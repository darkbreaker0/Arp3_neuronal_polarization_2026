# `ImageJ_macros/` — a beginner's guide

This directory holds **Fiji / ImageJ macros (`.ijm`)** that preprocess raw
imaging data into the per-cell / per-neurite CSVs that the R Markdown
analyses in `figures/` consume. Each macro corresponds to one figure panel
(or one preprocessing step that feeds multiple panels).

If you have never read a Fiji macro before, this README will walk you
through the 5 patterns that show up across all 58 files. Once you know
those, the per-file inline comments will make sense.

## What is a Fiji macro?

A `.ijm` file is a sequence of Fiji/ImageJ commands written in **IJ Macro
Language**. You run it in Fiji via:

  - Drag-and-drop the `.ijm` onto Fiji's main window, then click **Run**.
  - Or: Fiji menu → `Plugins → Macros → Run...` and pick the file.

A macro can:

  - Open images (`open(path)`, `getDirectory(...)`)
  - Apply image-processing commands (`run("...")` — same commands you'd
    pick from the menu)
  - Loop over many files in a folder (the **BatchProcessFolders** pattern,
    see below)
  - Read **ROIs** (Regions of Interest) from a `_RoiSet.zip` file and
    measure intensities inside them (the **ROI Manager** pattern)
  - Save the resulting measurements as a `.csv` file that an R Markdown
    analysis then reads.

Three Fiji concepts to know before reading the code:

  - **ROI** ("Region of Interest"): a hand-drawn or computed shape (line,
    polygon, ellipse, rectangle) on an image. ROIs live in the **ROI
    Manager** (Fiji menu → `Analyze → Tools → ROI Manager`).
  - **Results table**: Fiji's built-in spreadsheet-like window where
    measurements accumulate. Saving it writes a `.csv`.
  - **Stack** / **hyperstack**: a multi-frame image. Time-lapses are
    stacks. Multi-channel time-lapses are hyperstacks (z × c × t).

## The 5 patterns

### Pattern 1: Batch process every file in a folder (`BatchProcessFolders`)

Used by most batch macros. The template is:

```ijm
requires("1.33s");                                  // Fiji version gate
dir = getDirectory("Choose a Directory ");          // user picks the folder
setBatchMode(true);                                 // don't refresh display
                                                    // (faster + no flicker)
count = 0;
countFiles(dir);                                    // first pass: count
n = 0;
processFiles(dir);                                  // second pass: process

function countFiles(dir) {                          // recurse subfolders
   list = getFileList(dir);
   for (i = 0; i < list.length; i++) {
       if (endsWith(list[i], "/"))
           countFiles("" + dir + list[i]);          // ↳ subfolder
       else
           count++;                                 // ↳ a file
   }
}

function processFiles(dir) {
   list = getFileList(dir);
   for (i = 0; i < list.length; i++) {
       if (endsWith(list[i], "/"))
           processFiles("" + dir + list[i]);
       else {
           showProgress(n++, count);
           path = dir + list[i];
           processFile(path);                        // ↳ per-file action
       }
   }
   // After each folder is done: dump Results table to CSV in that folder.
   Table_path = dir + "measurements.csv";
   saveAs("Results", Table_path);
   run("Clear Results");
}

function processFile(path) {
   // This is the only function that varies per macro. Typical body:
   //   - open the file
   //   - open the matching _RoiSet.zip (see Pattern 2)
   //   - measure intensities → adds rows to Fiji's Results table
   //   - close the image
   if (endsWith(path, ".tif")) {
       open(path);
       // ... measure ...
       close();
   }
}
```

**Why the two-pass design?** First pass (`countFiles`) just counts files
so the progress bar (`showProgress`) can show a percentage. Second pass
(`processFiles`) does the real work.

**Output convention.** Most macros save `measurements.csv` in each folder
they descend into. The R Markdown analyses then walk the folder tree and
concatenate those CSVs.

### Pattern 2: Measure inside each ROI from a `_RoiSet.zip`

ImageJ stores a set of ROIs as a `.zip` (one `.roi` per ROI inside).
Convention in this codebase:

  - **Image**: `cell_05.tif`
  - **ROI set**: `cell_05.tif_RoiSet.zip` (or `cell_05.zip`, or
    `cell_05_RoiSet.zip` — varies by macro; check the body)

Typical body inside `processFile`:

```ijm
open(path);                                            // open the image
roiManager("reset");                                   // clear any leftover
                                                       // ROIs from the
                                                       // previous file
roiManager("Open", path + "_RoiSet.zip");              // load this image's
                                                       // matching ROIs
nROIs = roiManager("count");
for (y = 0; y < nROIs; y++) {
    roiManager("Select", y);                           // make ROI y active
    Stack.setChannel(1);                               // pick a channel
                                                       // (1 = first chan)
    roiManager("Measure");                             // adds one row per
                                                       // ROI to Results
}
roiManager("Deselect");
roiManager("reset");
close();                                               // close the image
```

What `roiManager("Measure")` records depends on the **Set Measurements**
configuration in Fiji (menu `Analyze → Set Measurements...`). Across this
codebase the canonical setup is **Area, Mean, IntDen, Stack position**.

### Pattern 3: Extract a 1-D intensity profile along a line

Used for line-profile / Z-profile / kymograph-track analyses.

```ijm
roiManager("Select", 0);                                  // pick the line ROI
profile = getProfile();                                   // x = pixel along line
                                                          // y = pixel intensity

// — or, for the more general "Plot Profile" command —
run("Plot Profile");                                      // makes a Plot window
Plot.getValues(x, y);                                     // pull the two arrays
                                                          // into x[] and y[]

// Write the profile to the Results table for export:
for (i = 0; i < x.length; i++) {
    setResult("Distance", i, x[i]);
    setResult("Intensity", i, y[i]);
}
updateResults();
```

Save the Results table to CSV via `saveAs("Results", ...)`.

### Pattern 4: Deinterleave channels

Some microscopes (e.g. **DeltaVision-Elite** in fast filter-wheel mode)
write a single-channel stack where alternating frames are different
emission channels. To split them:

```ijm
open(path);
run("Deinterleave", "how=2");          // splits into 2 stacks (one per chan)
                                       // window titles get " #1" and " #2"
                                       // suffixed automatically
selectImage(name + " #1");
run("Green");                          // apply LUT
selectImage(name + " #2");
run("Red");
run("Merge Channels...",                // recombine into one composite
    "c1=" + name + " #1 c2=" + name + " #2 create");
saveAs("Tiff", path + "_comp.tif");    // save as 2-channel composite
```

### Pattern 5: Generate a kymograph

A **kymograph** is a 1-D-vs-time image: pick a line ROI on the first
frame, then stack the intensity along that line for every timepoint into a
single 2-D image. Time goes down, distance along the line goes across.

```ijm
open(path);
roiManager("Open", roi_set_zip);
roiManager("Select", 0);               // the line ROI
run("KymographBuilder",                // produces the kymograph in a new
    "max-thickness=3 use=intensity");  // window
                                       // (some macros use Fiji's built-in
                                       //  Image → Stacks → Reslice instead)
saveAs("Tiff", path + "_kymo.tif");
```

## Per-file conventions in this repository

Every `.ijm` in this directory starts with a **15-line auto-injected
header** that records:

  - The filename and the manuscript panel it serves.
  - A one-line description of what the macro does.
  - The original source path on `G:\`.
  - Authorship attribution (Tien-Chen Lin — see `CONTRIBUTORS.md`).

The code body below the header is **bit-faithful** to the `G:\` original
plus any inline beginner comments added during the 2026-05-13 annotation
pass. Comments are prefixed with `//`. The original analysis logic and
every parameter value are preserved.

## Output naming conventions

| Output file                 | Meaning                                              |
|----------------------------|------------------------------------------------------|
| `measurements.csv`         | Per-ROI intensities for every cell in the folder.    |
| `*_kymo.tif`               | Kymograph image generated from a line ROI.           |
| `*_kymograph.tif`          | Same — older naming.                                 |
| `*_scaled.tif`             | Bilinear-upscaled (4×) version of `*_kymograph.tif`. |
| `*_comp.tif`               | 2-channel composite (after `Pattern 4` deinterleave). |
| `*_RoiSet.zip`             | A saved set of ROIs (used as input by other macros). |
| `*_soma.zip` / `*_wave.zip`| ROI subsets — soma boundary vs wave-event positions. |
| `*_NT.zip`                 | Neurite-tip ROI set (used for tip-intensity macros). |

## Three interactive macros (require user clicks)

Most macros run headlessly with `setBatchMode(true)`. Three macros require
user input (`getDirectory`, `getNumber`, `waitForUser`) and CANNOT be
batched without a real user at the keyboard. They have `_interactive` in
their filename:

  - `edfig02d/edfig02d_lifeact_kymo_batch_interactive.ijm`
  - `edfig02d/edfig02d_lifeact_kymo_gen.ijm`   *(also opens an ROI dialog)*
  - `edfig05/edfig05e_nd2_hyperstack_reorder_batch_interactive.ijm`

## Joint-authored kymograph-workflow macros

8 macros in this directory drive the Bradke-lab kymograph workflow —
they call the `Multi Kymograph` plugin (or `KymoResliceWide`) and the
`Proc.py` Jython post-processor. Both upstream tools were co-developed
by **Christoph Möhl** (Bradke lab, DZNE) and **Mansoureh Aghabeig**
(Image and Data Analysis Facility, DZNE); the batch wrappers that wire
them into per-panel pipelines were extended by **Tien-Chen Lin**. Joint
attribution is captured in each affected macro's header and in
`CONTRIBUTORS.md`:

  - `edfig02d/edfig02d_lifeact_kymo_batch_interactive.ijm` *(interactive)*
  - `edfig02d/edfig02d_lifeact_kymo_gen.ijm`
  - `edfig03/edfig03q_nested_actin_kymo_gen__240227_kymo_5b8b17be.ijm`
  - `edfig03/edfig03q_nested_actin_kymo_gen__241025_analyzed_5f793d08.ijm`
  - `fig03/fig03or_perfusion_kymo_gen.ijm`
  - `fig03/fig03or_perfusion_wave_kymo_gen.ijm`
  - `fig03/fig03or_perfusion_area_kymo_gen.ijm`
  - `fig04/fig04o_lyn_live_roi_measure.ijm`

`Proc.py` itself lives at `~/Nextcloud/Neurite activities/Proc.py` (per
the macros' hard-coded path) — it is NOT in this repo. If you want to
reproduce these panels from raw imaging you'll need to obtain `Proc.py`
and the `Multi Kymograph` plugin separately from the Bradke lab.

## Upstream tool used (not bundled in this repo)

Several R Markdown analyses also consume per-neurite **length time-series
CSVs** that were not produced by any macro in *this* directory. They were
produced by **`IJ_NeuriteGrowth`**, a separate Bradke-lab Fiji plugin
**created by Tien-Chen Lin** on top of the underlying **`Multi Kymograph`
/ `KymoResliceWide` + `Proc.py` workflow** authored by **Christoph Möhl**
and **Mansoureh Aghabeig** (see `CONTRIBUTORS.md` and
`REDISTRIBUTION_NOTES.md` for the attribution chain). You will need to
obtain `IJ_NeuriteGrowth` separately from the Bradke lab if you want to
reproduce the upstream length-extraction step.

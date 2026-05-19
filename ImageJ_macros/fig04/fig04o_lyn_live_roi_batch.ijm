// ============================================================================
// fig04o_lyn_live_roi_batch.ijm — Fig 4o
// ============================================================================
//
// What this macro does: M20 — batch ROI intensity from live-cell timelapse.
//
// Manuscript panel(s): Fig 4o
// Original source on G:\: G:/Figure 4_Arp3KO/Fig. 4o/WT_KO_Lyn_Live_Fig. 4o/Arp3KO/Batch roi measurement_2.ijm
//
// Authored by Tien-Chen Lin (Bradke lab, DZNE).
// See CONTRIBUTORS.md for full attribution.
//
// Header. The macro
// logic below this header is bit-faithful to the G:\ original; only
// comments (in-line beginner annotations and the header above) have been
// added during the 2026-05-13 annotation pass.
// ============================================================================
//
// PIPELINE ROLE (beginner)
// ------------------------
// Each Lyn-EGFP/Lyn-mCherry time-lapse on the Bradke lab's spinning-disc
// rig was cropped per-neurite into `kymograph.tif` files (one per neurite
// per cell) by an upstream macro. This batch macro walks every folder
// under a user-picked root, finds every `kymograph.tif`, scales it 4×
// with bilinear interpolation, and saves the scaled version as
// `*_scaled.tif`. The result is the input to the published Fig 4o CCF
// analysis in `figures/Fig04_Arp3KO/fig04o_lyn_live_neurite_xcorr_ko.Rmd`
// and `fig04o_lyn_live_neurite_xcorr_wt.Rmd`.
//
// The ROI-measurement block (lines 71-83) is commented out: this version
// only scales + saves; the measurement step is done by a sister macro
// (`fig04o_lyn_live_roi_measure.ijm`) downstream.
//
// USAGE
// -----
//   Drag this file onto Fiji → Run.
//   When prompted, pick the parent directory that contains one sub-folder
//   per condition (WT, KO, etc.). The macro recurses into all subfolders.
//
// See ImageJ_macros/README.md for explanations of:
//   - the "BatchProcessFolders" pattern (Pattern 1)
//   - the ROI Manager pattern (Pattern 2; mostly commented out here)
// ============================================================================

   requires("1.33s");                              // Fiji ≥ 1.33s required
                                                   // (for setBatchMode etc.)
   dir = getDirectory("Choose a Directory ");      // user picks the root
                                                   // folder; trailing slash
                                                   // included
   setBatchMode(true);                             // suppress display refresh
                                                   // → 10–100× faster on big
                                                   //   batches
   count = 0;                                      // global counter for the
                                                   // progress bar
   countFiles(dir);                                // pass 1: count files
   n = 0;                                          // global "processed so far"
   processFiles(dir);                              // pass 2: do the work

   // ------------------------------------------------------------------
   // Pass 1: recursively descend, increment `count` for every non-folder.
   // ------------------------------------------------------------------
   function countFiles(dir) {
      list = getFileList(dir);                     // entries in this folder
      for (i=0; i<list.length; i++) {
          if (endsWith(list[i], "/"))              // entry is a sub-folder
              countFiles(""+dir+list[i]);          // → recurse into it
          else
              count++;                             // entry is a file → count
      }
  }

//add process at subfolder level here.
   // ------------------------------------------------------------------
   // Pass 2: recursively descend; for every file, call processFile().
   // After each folder is fully processed, dump Fiji's Results table to
   // a per-folder `measurements.csv` and clear the table for the next
   // folder. (Note: this script's processFile() doesn't actually call
   // CSV save is kept for compatibility with sibling macros that do
   // measure.)
   // ------------------------------------------------------------------
   function processFiles(dir) {
      list = getFileList(dir);
      for (i=0; i<list.length; i++) {
          if (endsWith(list[i], "/"))
              processFiles(""+dir+list[i]);        // recurse into subfolder
          else {
             showProgress(n++, count);             // 0..1 progress fraction
             path = dir+list[i];
             processFile(path);                    // ← per-file action below
          }
      }
      Table_path = dir + "measurements.csv" ;      // one CSV per folder
               saveAs("Results", Table_path);      // write whatever rows
                                                   // are currently in Results
               run("Clear Results");               // empty the table before
                                                   // the next folder
  }

//add process at file level here.
  // ------------------------------------------------------------------
  // Per-file action. Trigger only on files named exactly `kymograph.tif`
  // (upstream-generated by the Bradke kymograph macro). Skip everything
  // else (.zip ROI sets, _scaled.tif outputs of previous runs, etc.).
  // ------------------------------------------------------------------
  function processFile(path) {
       if (endsWith(path, "kymograph.tif") ) {
           open(path);                             // load the kymograph
           run("Scale...",                         // bilinear 4× upscale
               "x=4 y=4 interpolation=Bilinear create");
                                                   //   "create" = new window
                                                   //   "x=4 y=4" = scale
                                                   //   "interpolation=Bilinear"
                                                   //     = smoother than NN
           imgName=getTitle();                     // get the new image's title
           name = replace(imgName, ".tif", "");    // strip extension
           saved_path = dir + "/" + name + "_scaled.tif";
		   saveAs("Tiff", saved_path);             // save as <name>_scaled.tif

             // ---------- the ROI-measure block is intentionally disabled
             // ---------- in this preprocessing macro. The sister
             // ---------- fig04o_lyn_live_roi_measure.ijm does the actual
             // ---------- intensity measurement step on the scaled tif.

                 }
		else {}                                    // not a kymograph → skip

      }

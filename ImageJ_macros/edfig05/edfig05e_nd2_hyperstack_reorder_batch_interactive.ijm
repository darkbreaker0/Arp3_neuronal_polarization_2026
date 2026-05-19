// ============================================================================
// edfig05e_nd2_hyperstack_reorder_batch_interactive.ijm — ED Fig 5e
// ============================================================================
//
// What this macro does: M28 — interactive ND2 hyperstack reorder + deinterleave.
//
// Manuscript panel(s): ED Fig 5e
// Original source on G:\: G:/Figure S5_PA-Rac1/Fig. S5e/250617_DIV1/reorder_stack_batch.ijm
//
// Authored by Tien-Chen Lin (Bradke lab, DZNE).
// See CONTRIBUTORS.md for full attribution.
//
// Header added 2026-05-08; commented-out dead alternatives and batch-template boilerplate were removed on 2026-05-13. The executable macro logic is unchanged from the original.
// ============================================================================
// ------------------------------------------------------------
//  Batch-process ND2 sets inside every subfolder of a parent dir
// ------------------------------------------------------------
macro "Batch ND2 ▸ Concatenate ▸ Deinterleave ▸ Save" {

    /* ---------- choose the PARENT directory ---------- */
    parentDir = getDirectory("Choose the parent folder (contains subfolders with ND2)");

    /* ---------- ask once for N (Z-slices per ND2) ---------- */
    N = getNumber("How many Z-slices does each ND2 file contain (N)?", 1);
    if (N < 1) exit("N must be ≥ 1");

    /* ---------- iterate over FIRST-LEVEL subfolders ---------- */
    subList = getFileList(parentDir);
    for (s = 0; s < subList.length; s++) {

        /* skip files – we only want items that end with "/" (= a folder) */
        if (!endsWith(subList[s], "/")) continue;

        subDir = parentDir + subList[s];         // e.g. …/20250617_093458_110/
        IJ.log("Processing " + subDir);

        /* ---- gather *.nd2 files in this subfolder ---- */
        fileList = getFileList(subDir);
        nd2s = newArray(0);
        for (f = 0; f < fileList.length; f++)
            if (endsWith(fileList[f], ".nd2"))
                nd2s = Array.concat(nd2s, fileList[f]);

        if (nd2s.length == 0) {
            IJ.log("  (no ND2 files – skipped)");
            continue;
        }
        Array.sort(nd2s);                         // ensures Seq0000, Seq0001, …

        /* ---- open each ND2, convert to hyperstack ---- */
        winNames = newArray(nd2s.length);
        for (i = 0; i < nd2s.length; i++) {
            path = subDir + nd2s[i];

            run("Bio-Formats Importer",
                "open=[" + path + "] autoscale color_mode=Composite concatenate_series " +
                "open_all_series rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
run("Re-order Hyperstack ...", "channels=[Channels (c)] slices=[Frames (t)] frames=[Slices (z)]");
        // total planes in raw stack
        sizeT = nSlices();

            frames = sizeT / N;
            if (sizeT % N != 0) {
                IJ.log("  ⚠ N does not divide stack size in " + nd2s[i]);
                close();   // close the mis-sized stack
                continue;
            }

            run("Stack to Hyperstack...",
                "order=xytzc channels=1 slices=" + N + " frames=" + frames + " display=Color");

            title = "Seq" + IJ.pad(i, 4);
            rename(title);
            winNames[i] = title;
        }

        if (winNames.length == 0) { IJ.log("  (nothing opened)"); continue; }

        /* ---- concatenate the hyperstacks ---- */
        concatArgs = "title=[Concatenated] open";
        for (i = 0; i < winNames.length; i++)
            concatArgs += " image" + (i + 1) + "=[" + winNames[i] + "]";
        run("Concatenate...", concatArgs);

        /* ---- de-interleave into N stacks ---- */
        selectWindow("Concatenated");
        run("Deinterleave", "how=" + N);          // → “Concatenated #1…#N”

        /* ---- build the prefix <subfolderName>_Cell_XX ---- */
        pathNorm = replace(subDir, "\\", "/");
        print(subDir);
        pathTrim  = substring(pathNorm, 0, lengthOf(subDir) - 1);  // drop trailing "/"
        parts     = split(pathTrim, "/");
        subName   = parts[parts.length - 1];                     // e.g. 20250617_093458_110
print(subName);
        for (c = 1; c <= N; c++) {
            title   = "Concatenated #" + c;
            selectWindow(title);
            outPath = subDir + subName + "_Cell_" + IJ.pad(c, 2) + ".tif";
            saveAs("Tiff", outPath);
            close();
        }

        call("java.lang.System.gc");     // optional: force garbage collection
    }

    showMessage("Done", "All subfolders processed.");
}

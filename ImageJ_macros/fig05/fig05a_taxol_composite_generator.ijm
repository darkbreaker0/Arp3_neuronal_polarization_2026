// ============================================================================
// fig05a_taxol_composite_generator.ijm — Fig 5a (orphan)
// ============================================================================
//
// What this macro does: M35 — RGB composite generation (orphan: display only).
//
// Manuscript panel(s): Fig 5a (orphan)
// Original source on G:\: G:/Figure 5_myosin/Fig. 5a/Taxol_noc_expts/Taxol_noc_series3_April2016/make_comp.ijm
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
// Display-only helper for Fig 5a: walks each sub-folder under a picked
// root, expects EXACTLY THREE single-channel .tif files per sub-folder
// (alphabetically: imglist[0] = c1, [1] = c2, [2] = c3 — e.g. DAPI,
// fascin-488, Tuj1-568), and merges them into a single 3-channel
// composite .tif saved as `Cell<i>_comp.tif` in the root. The pixel
// scale (0.2559524 µm/px) is hardcoded for the Bradke-lab Airyscan
// 63× objective.
//
// "Orphan" in the header means no downstream R Markdown analysis consumes
// the output — these composites are purely for figure-panel display in
// Adobe Illustrator.
//
// CAVEAT (beginner)
// -----------------
// The macro assumes alphabetical channel order is meaningful. If a
// sub-folder contains extra files (.zip ROI sets, metadata) or fewer
// than 3 .tifs, `imglist[0..2]` will pick the wrong files. Safe practice:
// run on a clean folder tree where each sub-folder has exactly its 3
// channel .tifs and nothing else.
//
// See ImageJ_macros/README.md (Pattern 4) for the channel-merge idiom.
// ============================================================================

dir =getDirectory ("Choose a Directory") ;  // user picks the ROOT folder

list = getFileList(dir);                    // top-level entries

for (i=0; i<list.length; i++) {
	if (endsWith(list[i], "/")){            // process only sub-folders
                                            // (top-level files ignored)
       imglist = getFileList(dir +list[i]); // entries inside this sub-folder

	         open (dir +list[i]+imglist[0]); // 1st channel (alphabetically)
	         open (dir +list[i]+imglist[1]); // 2nd channel
	         open (dir +list[i]+imglist[2]); // 3rd channel
                                            // Convention: these are
                                            // c1/c2/c3 in alphabetical
                                            // order of filename.

run("Merge Channels...",                    // assemble into one 3-channel
    "c1=" + imglist[0] +                    // composite. The Merge dialog
    " c2=" + imglist[1] +                   // names channels by source-
    " c3=" + imglist[2] +                   // window title, hence the
    " create");                             // string concatenations.
                                            // "create" = keep originals
run("Properties...",                        // imprint physical pixel size
    "channels=3 slices=1 frames=1 "         // so downstream display scales
    "pixel_width=0.2559524 "                // correctly. 0.2559524 µm/px
    "pixel_height=0.2559524 "               // is Airyscan 63× × 1.6 zoom.
    "voxel_depth=1");
 saveAs("tiff", dir + "Cell" + i +"_comp"); // saved as Cell<index>_comp.tif
                                            // (index = position in `list`,
                                            // includes non-folder entries
                                            // so values may have gaps)
     close();

}
else{}                                      // ignore non-folder entries
}
}
else{}                                      // (closing braces from the
}                                           // original; harmless extras)

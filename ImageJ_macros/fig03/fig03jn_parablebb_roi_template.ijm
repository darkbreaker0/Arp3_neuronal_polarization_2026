// ============================================================================
// 3_Batch roi measurement.ijm — (panel mapping pending)
// ============================================================================
//
// What this macro does: ROI template variant for paraBlebb GC; helper.
//
// Manuscript panel(s): (panel mapping pending)
// Original source on G:\: G:/Figure 3_Arp3/Fig. 3j-n_PARac1/Andor/paraBlebb/paraBlebb_GC/Batch roi measurement.ijm
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
// SINGLE-FOLDER variant of the ROI Manager batch loop. (Compare with the
// recursive BatchProcessFolders pattern used by `fig04o_lyn_live_roi_batch.ijm`
// — that one descends into subfolders; this one does not.) For every
// `.tif` in the picked folder this macro:
//   1. Opens the image.
//   2. Loads the matching ROI set: `<image>.tif_RoiSet.zip`.
//   3. Measures intensities for every ROI (default channel; if the
//      `Stack.setChannel(1)` line below is uncommented, channel 1 only).
//      Each ROI adds one row to Fiji's Results table.
//   4. Closes all image windows (`close("*")`) and resets the ROI Manager.
// After the loop, the Results table is saved as `measurements.csv` in the
// folder.
//
// See ImageJ_macros/README.md (Pattern 2) for the ROI Manager idiom.
// ============================================================================

dir=getDirectory ("Choose a Directory") ;   // user picks the folder

list = getFileList(dir);                    // entries in the folder

for (i=0; i<list.length; i++) {
     if (endsWith(list[i], ".tif")){        // process only .tif
             open(dir+list[i]);
             imgName=getTitle();
             roiManager("Open", dir+list[i]+"_RoiSet.zip"); //open Roi set of the opened video
                                            // expected filename:
                                            // <image>.tif_RoiSet.zip
             nROIs = roiManager("count");
                                            // would collapse z-stacks before
                                            // measuring; not used here
             for (y = 0; y < nROIs; y++){
               roiManager ("Select", y);    // pick ROI y
			   roiManager("Measure");       // adds one row to Results
				}

               roiManager("Deselect");
               roiManager("reset");         // clear ROIs for the next image
               close("*");                  // close ALL open image windows

                 }
		else {}                             // not a .tif → skip

			Table_path = dir + "measurements.csv" ;
                                            // NOTE: saveAs runs once per
                                            // .tif (inside the for loop) —
                                            // each save overwrites the
                                            // previous one, so only the
                                            // FINAL state of Results
                                            // (cumulative across all .tif)
                                            // is preserved on disk. This is
                                            // OK because Clear Results is
                                            // only called after the loop.
               saveAs("Results", Table_path);

     }
run("Clear Results");                       // clear table after all files
                                            // (so next run of the macro
                                            // starts clean)

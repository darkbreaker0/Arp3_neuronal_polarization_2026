// ============================================================================
// edfig07_paraBlebb_roi_template.ijm — (panel mapping pending)
// ============================================================================
//
// What this macro does: Summary/template variant of Batch roi measurement.
//
// Manuscript panel(s): (panel mapping pending)
// Original source on G:\: G:/Figure S7_PARac1_CK666/Fig. S7b/paraBlebb_GC_extFig. 7b/Batch roi measurement.ijm
//
// Authored by Tien-Chen Lin (Bradke lab, DZNE).
// See CONTRIBUTORS.md for full attribution.
//
// Header added 2026-05-08; commented-out dead alternatives and batch-template boilerplate were removed on 2026-05-13. The executable macro logic is unchanged from the original.
// ============================================================================

dir=getDirectory ("Choose a Directory") ;

list = getFileList(dir);

for (i=0; i<list.length; i++) {
     if (endsWith(list[i], ".tif")){
             open(dir+list[i]);
             imgName=getTitle();
             roiManager("Open", dir+list[i]+"_RoiSet.zip"); //open Roi set of the opened video
             nROIs = roiManager("count");
             for (y = 0; y < nROIs; y++){
               roiManager ("Select", y);
			   roiManager("Measure");
				}

               roiManager("Deselect");
               roiManager("reset");
               close("*");

                 }

			Table_path = dir + "measurements.csv" ;
               saveAs("Results", Table_path);

     }
run("Clear Results");

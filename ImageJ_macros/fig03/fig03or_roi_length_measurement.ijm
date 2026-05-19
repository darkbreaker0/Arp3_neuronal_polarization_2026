// ============================================================================
// fig03or_roi_length_measurement.ijm — Fig 3o-r (orphan)
// ============================================================================
//
// What this macro does: ROI bounding-box length/perimeter (orphan: no R consumer).
//
// Manuscript panel(s): Fig 3o-r (orphan)
// Original source on G:\: G:/Figure 3_Arp3/Fig. 3o-r_local_perfusion/ImageJ_Macro/Roi_length_measurement.ijm
//
// Authored by Tien-Chen Lin (Bradke lab, DZNE).
// See CONTRIBUTORS.md for full attribution.
//
// Header added 2026-05-08; commented-out dead alternatives and batch-template boilerplate were removed on 2026-05-13. The executable macro logic is unchanged from the original.
// ============================================================================
imgName=getTitle();
dir=getDirectory ("image") ;
roiManager("Deselect");
roiManager("Save", dir + imgName + "_length.zip");
roiManager("Deselect");
roiManager("reset");

imgName=getTitle();

roiManager("Open", dir + imgName+ "_length.zip"); //open Roi set of the opened video
nROIs = roiManager("count");

     for (y = 0; y < nROIs; y++){

        roiManager ("Select", y);
               Stack.setChannel(1);
			   roiManager("Measure");
				}

Table_path = dir + "length.csv" ;
saveAs("Results", Table_path);
roiManager("reset");
run("Clear Results");
close("*");

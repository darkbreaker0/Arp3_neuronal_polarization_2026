// ============================================================================
// 3_length_measurement.ijm.ijm — Fig 3o-r DMSO control
// ============================================================================
//
// What this macro does: Length measurement for DMSO control. Triple-extension corruption (.ijm.ijm) fixed.
//
// Manuscript panel(s): Fig 3o-r DMSO control
// Original source on G:\: G:/Figure 3_Arp3/Fig. 3o-r_local_perfusion/DMSO_control/length_measurement.ijm.ijm
//
// Authored by Tien-Chen Lin (Bradke lab, DZNE).
// See CONTRIBUTORS.md for full attribution.
//
// Header added 2026-05-08; commented-out dead alternatives and batch-template boilerplate were removed on 2026-05-13. The executable macro logic is unchanged from the original.
// ============================================================================

dir=getDirectory ("Choose a Directory") ;

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

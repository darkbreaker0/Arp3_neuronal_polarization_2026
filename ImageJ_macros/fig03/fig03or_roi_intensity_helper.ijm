// ============================================================================
// fig03or_roi_intensity_helper.ijm — (panel mapping pending)
// ============================================================================
//
// What this macro does: ROI intensity extraction (non-perfusion ROI; orphan helper).
//
// Manuscript panel(s): (panel mapping pending)
// Original source on G:\: G:/Figure 3_Arp3/Fig. 3o-r_local_perfusion/ImageJ_Macro/Roi_Intenity.ijm
//
// Authored by Tien-Chen Lin (Bradke lab, DZNE).
// See CONTRIBUTORS.md for full attribution.
//
// Header added 2026-05-08; commented-out dead alternatives and batch-template boilerplate were removed on 2026-05-13. The executable macro logic is unchanged from the original.
// ============================================================================

run("Subtract Background...", "rolling=10 sliding");

dir=getDirectory ("Choose a Directory") ;

imgName=getTitle();

roiManager("Open", dir + imgName+ "_RoiSet.zip"); //open Roi set of the opened video
nROIs = roiManager("count");

     for (y = 0; y < nROIs; y++){

        roiManager ("Select", y);
         Stack.setChannel(3); //select the channel to quantify
		run ("Plot Z-axis Profile");
		Plot.getValues (xpoints, ypoints);

			  for (z = 0; z < xpoints.length; z++) {
			    setResult (imgName + "_" + y, z, ypoints[z]);
			  		}

             close();
			 updateResults ();

}

Table_path = dir + "actin_int.csv" ;
saveAs("Results", Table_path);
roiManager("reset");
run("Clear Results");
close("*");

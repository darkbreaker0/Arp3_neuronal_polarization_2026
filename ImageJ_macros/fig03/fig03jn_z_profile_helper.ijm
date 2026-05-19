// ============================================================================
// fig03jn_z_profile_helper.ijm — Fig 3 + ED Fig 7
// ============================================================================
//
// What this macro does: M17 — Z-profile from hyperstack. Fixes triple-extension (.ijm.ijm -> .ijm).
//
// Manuscript panel(s): Fig 3 + ED Fig 7
// Original source on G:\: G:/Figure 3_Arp3/Fig. 3j-n_PARac1/LSM980/Analyzed/R_scripts/zProfi.ijm.ijm
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
             roiManager("Open", dir+imgName+"_Roiset.zip"); //open Roi set of the opened video
             nROIs = roiManager("count");

			   for (y = 0; y < nROIs; y++)
               {
               roiManager ("Select", y);
               Stack.setChannel(2);
			   run ("Plot Z-axis Profile");
			   Plot.getValues (xpoints, ypoints);

					  for (z = 0; z < xpoints.length; z++) {
					    setResult (imgName + "_roi_"+ y, z, ypoints[z]);
					  		}
				close();
             }

			  updateResults ();
              roiManager("Deselect");
              roiManager("reset");
              close("*");

                 }

     }

Table_path = dir + "zProfi_Myl.csv" ;
saveAs("Results", Table_path);
run("Clear Results");

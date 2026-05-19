// ============================================================================
// edfig02d_soma_z_intensity_221101.ijm — ED Fig 2d
// ============================================================================
//
// What this macro does: M5 — soma intensity Z-profile (221101).
//
// Manuscript panel(s): ED Fig 2d
// Original source on G:\: G:/Figure S2_actin/Fig. S2d/Lyn_Lifeact/221101/soma_intensity.ijm
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

             roiManager("Open", dir+imgName+"_soma.zip"); //open Roi set of the opened video
             nROIs = roiManager("count");

               roiManager ("Select", 0);
               Stack.setChannel(1); //select the channel to quantify
			   run ("Plot Z-axis Profile");
			  Plot.getValues (xpoints, ypoints);

			  for (z = 0; z < xpoints.length; z++) {
			    setResult (imgName, z, ypoints[z]);
			  		}

			  close();
			  updateResults ();
               roiManager("Deselect");
               roiManager("reset");
               close("*");

                 }

     }

Table_path = dir + "soma_actin.csv" ;
saveAs("Results", Table_path);
run("Clear Results");

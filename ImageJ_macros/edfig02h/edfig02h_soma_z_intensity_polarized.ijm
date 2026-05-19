// ============================================================================
// edfig02h_soma_z_intensity_polarized.ijm — ED Fig 2h
// ============================================================================
//
// What this macro does: M6 — soma intensity reference for polarized neurons.
//
// Manuscript panel(s): ED Fig 2h
// Original source on G:\: G:/Figure S2_actin/Fig. S2h/Polarized_neurons/IJ_scripts/soma_intensity.ijm
//
// Authored by Tien-Chen Lin (Bradke lab, DZNE).
// See CONTRIBUTORS.md for full attribution.
//
// Header added 2026-05-08; commented-out dead alternatives and batch-template boilerplate were removed on 2026-05-13. The executable macro logic is unchanged from the original.
// ============================================================================

dir=getDirectory ("Choose a Directory") ;

list = getFileList(dir);

for (i=0; i<list.length; i++) {
     if (endsWith(list[i], ".dv")){
             open(dir+list[i]);
             imgName=getTitle();
             roiManager("Open", dir+imgName+"_soma.zip"); //open Roi set of the opened video
             nROIs = roiManager("count");

               roiManager ("Select", 0);
               Stack.setChannel(3);
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

Table_path = dir + "soma_Kif5.csv" ;
saveAs("Results", Table_path);
run("Clear Results");

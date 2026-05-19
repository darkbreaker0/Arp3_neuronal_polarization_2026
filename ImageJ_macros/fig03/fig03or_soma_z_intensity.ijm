// ============================================================================
// fig03or_soma_z_intensity.ijm — Fig 3r
// ============================================================================
//
// What this macro does: M14 — soma intensity Z-profile, channel 3 select.
//
// Manuscript panel(s): Fig 3r
// Original source on G:\: G:/Figure 3_Arp3/Fig. 3o-r_local_perfusion/ImageJ_Macro/soma_intensity.ijm
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

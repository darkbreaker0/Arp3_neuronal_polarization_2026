// ============================================================================
// fig04m_immunostain_3channel_line_profile.ijm — Fig 4m + ED Fig 6
// ============================================================================
//
// What this macro does: M21 — 3-channel ICC line profile (Tuj/Phall/NMIIB). Fixes triple-extension.
//
// Manuscript panel(s): Fig 4m + ED Fig 6
// Original source on G:\: G:/Figure 4_Arp3KO/Fig. 4m/TujA488_PhallA594_NMIIBA647_Fig.4m/WT/Ch_profile.ijm.ijm
//
// Authored by Tien-Chen Lin (Bradke lab, DZNE).
// See CONTRIBUTORS.md for full attribution.
//
// Header added 2026-05-08; commented-out dead alternatives and batch-template boilerplate were removed on 2026-05-13. The executable macro logic is unchanged from the original.
// ============================================================================

dir=getDirectory ("Choose a Directory") ;

list = getFileList(dir);

for (i=0; i<list.length; i++) {
     if (endsWith(list[i], ".czi")){

             open(dir+list[i]);
             imgName=getTitle();
             kymoDir =  dir + "Profile_" + list[i] + "/";
             File.makeDirectory(kymoDir); // Create folders for kymographs

             roiManager("Open", dir+imgName+"_RoiSet.zip"); //open Roi set of the opened video
             nROIs = roiManager("count");

              for (y = 0; y < nROIs; y++)
               {

               	roi= "_Roi_" + y;
               roiManager ("Select", y);
               Stack.setChannel(1);

               run("Plot Profile");
			   Plot.getValues (xpoints, ypoints);
				  for (z = 0; z < xpoints.length; z++) {
				    setResult (imgName + roi + "_Ch1", z, ypoints[z]);
				  		}

			   close();
			   updateResults ();
               Stack.setChannel(2);

               run("Plot Profile");
			   Plot.getValues (xpoints, ypoints);
				  for (z = 0; z < xpoints.length; z++) {
				    setResult (imgName + roi + "_Ch2", z, ypoints[z]);
				  		}

			   close();
			   updateResults ();
               Stack.setChannel(3);

               run("Plot Profile");
			   Plot.getValues (xpoints, ypoints);
				  for (z = 0; z < xpoints.length; z++) {
				    setResult (imgName + roi +"_Ch3", z, ypoints[z]);
				  		}

			   close();
			   updateResults ();

             }

             roiManager("Deselect");
             roiManager("reset");

             Table_path = kymoDir + "profile.csv" ;
             saveAs("Results", Table_path);
             run("Clear Results");

             close("*");

                 }

     }

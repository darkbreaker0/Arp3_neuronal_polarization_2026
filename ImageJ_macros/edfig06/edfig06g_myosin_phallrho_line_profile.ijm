// ============================================================================
// edfig06g_myosin_phallrho_line_profile.ijm — ED Fig 6g
// ============================================================================
//
// What this macro does: M23 — Phall-NMIIB myosin ICC line profile.
//
// Manuscript panel(s): ED Fig 6g
// Original source on G:\: G:/Figure S6_myosin/Fig. S6g/201002_ICC_extFig. 6g/PhallRho_NMIIbA647/WT/Line_profiles.ijm
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
             roiManager("Open", dir+imgName+"_RoiSet.zip"); //open Roi set of the opened video
             nROIs = roiManager("count");

             for (y = 0; y < nROIs; y++)
               {
               selectWindow(imgName);
               roiManager ("Select", y);
               Stack.setChannel(3);
			   run("Plot Profile");
			   Plot.getValues (xpoints, ypoints);

				  for (z = 0; z < xpoints.length; z++) {
				    setResult (imgName + "_" + y, z, ypoints[z]);
				  		}

			  updateResults ();

               }

            Table_path = dir + imgName + "_Line_profiles2.csv" ;
			saveAs("Results", Table_path);
			run("Clear Results");
            roiManager("reset");
            close("*");

                 }

     }

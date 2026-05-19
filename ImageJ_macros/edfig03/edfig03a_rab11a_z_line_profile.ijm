// ============================================================================
// edfig03a_rab11a_z_line_profile.ijm — ED Fig 3a
// ============================================================================
//
// What this macro does: M31 — Z-stack line-profile for Rab11a colocalization.
//
// Manuscript panel(s): ED Fig 3a
// Original source on G:\: G:/Figure S3_Arp3/Fig. S3a_Rab11a/221025_Rab11aEGFP/decon/soma/Line_profiles.ijm
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
             roiManager("Open", dir+imgName+"_line_RoiSet.zip"); //open Roi set of the opened video
             nROIs = roiManager("count");

             for (y = 0; y < nROIs; y++)
               {
               selectWindow(imgName);
               roiManager ("Select", y);
               Stack.setChannel(1);
			   run("Plot Profile");
			   Plot.getValues (xpoints, ypoints);

				  for (z = 0; z < xpoints.length; z++) {
				    setResult (imgName + "_" + y, z, ypoints[z]);
				  		}

			  updateResults ();

               }

            Table_path = dir + imgName + "_Line_profiles_Actin.csv" ;
			saveAs("Results", Table_path);
			run("Clear Results");
            roiManager("reset");
            close("*");

                 }

     }

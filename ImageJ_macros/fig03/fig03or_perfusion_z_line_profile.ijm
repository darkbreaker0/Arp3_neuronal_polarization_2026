// ============================================================================
// fig03or_perfusion_z_line_profile.ijm — Fig 3r
// ============================================================================
//
// What this macro does: M13 — Z-stack line-profile extraction.
//
// Manuscript panel(s): Fig 3r
// Original source on G:\: G:/Figure 3_Arp3/Fig. 3o-r_local_perfusion/ImageJ_Macro/Line_profiles.ijm
//
// Authored by Tien-Chen Lin (Bradke lab, DZNE).
// See CONTRIBUTORS.md for full attribution.
//
// Header added 2026-05-08; commented-out dead alternatives and batch-template boilerplate were removed on 2026-05-13. The executable macro logic is unchanged from the original.
// ============================================================================

dir=getDirectory ("Choose a Directory") ;

list = getFileList(dir);

for (i=0; i<list.length; i++) {
     if (endsWith(list[i], "kymo.tif")){
             open(dir+list[i]);
             imgName=getTitle();
             roiManager("Open", dir+imgName+"_RoiSet.zip"); //open Roi set of the opened video
             nROIs = roiManager("count");

             for (y = 0; y < nROIs; y++)
               {
               selectWindow(imgName);
               roiManager ("Select", y);
			   run("Plot Profile");
			   Plot.getValues (xpoints, ypoints);

				  for (z = 0; z < xpoints.length; z++) {
				    setResult (imgName + "_" + y, z, ypoints[z]);
				  		}

			  updateResults ();

               }

            Table_path = dir + imgName + "_perfusion_area.csv" ;
			saveAs("Results", Table_path);
			run("Clear Results");
            roiManager("reset");
            close("*");

                 }

     }

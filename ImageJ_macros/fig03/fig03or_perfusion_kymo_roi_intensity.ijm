// ============================================================================
// fig03or_perfusion_kymo_roi_intensity.ijm — Fig 3r + ED Fig 4
// ============================================================================
//
// What this macro does: M11 — plot-profile from kymo ROI -> CSV.
//
// Manuscript panel(s): Fig 3r + ED Fig 4
// Original source on G:\: G:/Figure 3_Arp3/Fig. 3o-r_local_perfusion/ImageJ_Macro/Batch roi measurement_2_perfusion_area.ijm
//
// Authored by Tien-Chen Lin (Bradke lab, DZNE).
// See CONTRIBUTORS.md for full attribution.
//
// Header added 2026-05-08; commented-out dead alternatives and batch-template boilerplate were removed on 2026-05-13. The executable macro logic is unchanged from the original.
// ============================================================================

   requires("1.33s");
   dir = getDirectory("Choose a Directory ");
   setBatchMode(true);
   count = 0;
   countFiles(dir);
   n = 0;
   processFiles(dir);

   function countFiles(dir) {
      list = getFileList(dir);
      for (i=0; i<list.length; i++) {
          if (endsWith(list[i], "/"))
              countFiles(""+dir+list[i]);
          else
              count++;
      }
  }

//add process at subfolder level here.
   function processFiles(dir) {
      list = getFileList(dir);
      for (i=0; i<list.length; i++) {
          if (endsWith(list[i], "/"))
              processFiles(""+dir+list[i]);
          else {
             showProgress(n++, count);
             path = dir+list[i];
             processFile(path);
          }
      }

  }

//add process at file level here.
  function processFile(path) {
       if (endsWith(path, "_kymo.tif")) {
           open(path);

           imgName=getTitle();
             roiManager("Open", path +"_RoiSet.zip"); //open Roi set of the opened video
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

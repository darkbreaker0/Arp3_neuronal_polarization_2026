// ============================================================================
// edfig06g_myosin_icc_roi_batch.ijm — ED Fig 6g
// ============================================================================
//
// What this macro does: M24 — ROI batch from PhallRho/NMIIB ICC stack.
//
// Manuscript panel(s): ED Fig 6g
// Original source on G:\: G:/Figure S6_myosin/Fig. S6g/201002_ICC_extFig. 6g/PhallRho_NMIIbA647/WT/Batch roi measurement_2.ijm
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

  function processFile(path) {
       if (endsWith(path, ".tif")) {
           open(path);

           imgName=getTitle();
           roiManager("Open", path+"_RoiSet.zip"); //open Roi set of the opened video
           nROIs = roiManager("count");

             for (y = 0; y < nROIs; y++){
               roiManager ("Select", y);
               Stack.setChannel(1);
			  run("Multichannel Plot Profile");
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

run("Clear Results");

  }

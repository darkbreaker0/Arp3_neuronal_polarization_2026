// ============================================================================
// fig05ab_taxol_noc_roi_batch.ijm — Fig 5a/b
// ============================================================================
//
// What this macro does: M26 — batch ROI from Taxol/Nocodazole timelapse.
//
// Manuscript panel(s): Fig 5a/b
// Original source on G:\: G:/Figure 5_myosin/Fig. 5a/Taxol_noc_expts/Batch roi measurement_2.ijm
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
      Table_path = dir + "measurements.csv" ;
               saveAs("Results", Table_path);
               run("Clear Results");
  }

//add process at file level here.
  function processFile(path) {
       if (endsWith(path, ".tif")) {
           open(path);

           imgName=getTitle();
           run("Properties...", "channels=3 slices=1 frames=1 pixel_width=0.2559524 pixel_height=0.2559524 voxel_depth=1");
             roiManager("Open", path +"_RoiSet.zip"); //open Roi set of the opened video
             nROIs = roiManager("count");

             for (y = 0; y < nROIs; y++){
               roiManager ("Select", y);
               Stack.setChannel(3);
			   run("Measure");
				}

               roiManager("Deselect");
               roiManager("reset");

                 }

      }

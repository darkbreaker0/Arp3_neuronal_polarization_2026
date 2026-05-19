// ============================================================================
// edfig07d_parablebb_soma_roi_batch.ijm — ED Fig 7d
// ============================================================================
//
// What this macro does: ROI batch for paraBlebb soma 20uM (canonical kept).
//
// Manuscript panel(s): ED Fig 7d
// Original source on G:\: G:/Figure S7_PARac1_CK666/Fig. S7d/paBlebb_soma_20uM_ExtFig.7d/Batch roi measurement_2.ijm
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
             roiManager("Open", path +"_RoiSet.zip"); //open Roi set of the opened video
             nROIs = roiManager("count");

             for (y = 0; y < nROIs; y++){
               roiManager ("Select", y);
			   roiManager("Measure");
				}

               roiManager("Deselect");
               roiManager("reset");

                 }

      }

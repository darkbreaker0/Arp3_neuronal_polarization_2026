// ============================================================================
// edfig07b_parablebb_gc_roi_batch.ijm — ED Fig 7b
// ============================================================================
//
// What this macro does: ROI batch for paraBlebb GC (canonical kept; S3/Fig 3 dups dropped).
//
// Manuscript panel(s): ED Fig 7b
// Original source on G:\: G:/Figure S7_PARac1_CK666/Fig. S7b/paraBlebb_GC_extFig. 7b/Batch roi measurement_2.ijm
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

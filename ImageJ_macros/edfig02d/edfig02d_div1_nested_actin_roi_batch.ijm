// ============================================================================
// edfig02d_div1_nested_actin_roi_batch.ijm — ED Fig 2d (DIV1 221028)
// ============================================================================
//
// What this macro does: M4 — ROI intensity from nested actin-wave (DIV1 221028 batch).
//
// Manuscript panel(s): ED Fig 2d (DIV1 221028)
// Original source on G:\: G:/Figure S2_actin/Fig. S2d/Lyn_Lifeact/221028/221028_DIV1_2min/actin_wave/Batch roi measurement_2.ijm
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
           roiManager("Open", path+"_wave.zip"); //open Roi set of the opened video
           roiManager("Sort");
           nROIs = roiManager("count");

             for (y = 0; y < nROIs; y++){
               roiManager ("Select", y);
               Stack.setChannel(1);
			   roiManager("Measure");
				}

           roiManager("Deselect");
               roiManager("reset");
               Table_path = path + "_wave.csv" ;
               saveAs("Results", Table_path);

               close("*");

      }

run("Clear Results");

  }

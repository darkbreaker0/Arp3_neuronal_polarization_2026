// ============================================================================
// fig03or_perfusion_wave_roi_growth.ijm — Fig 3r
// ============================================================================
//
// What this macro does: M12 — wave growth kinetics from ROIs.
//
// Manuscript panel(s): Fig 3r
// Original source on G:\: G:/Figure 3_Arp3/Fig. 3o-r_local_perfusion/ImageJ_Macro/Batch roi measurement_2_wave.ijm
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
       if (endsWith(path, "WaveKymo_3.tif")) {
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

                Table_path = dir + imgName + ".csv" ;
			saveAs("Results", Table_path);
			run("Clear Results");
            roiManager("reset");
            close("*");

                 }

      }

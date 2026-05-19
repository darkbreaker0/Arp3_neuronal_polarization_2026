// ============================================================================
// edfig02d_div2_wave_roi_batch.ijm — ED Fig 2d (DIV2 201102)
// ============================================================================
//
// What this macro does: M4b — Wave growth metrics for DIV2 201102 batch.
//
// Manuscript panel(s): ED Fig 2d (DIV2 201102)
// Original source on G:\: G:/Figure S2_actin/Fig. S2d/Lyn_Lifeact/221101/201102_DIV2_1min/Batch roi measurement_2.ijm
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
           run("Subtract Background...", "rolling=20 sliding stack");
           save(path);
           close();
      }
  }

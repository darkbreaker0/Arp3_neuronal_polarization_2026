// ============================================================================
// edfig03a_roi_image_save.ijm — (panel mapping pending)
// ============================================================================
//
// What this macro does: ROI extraction + image save (helper).
//
// Manuscript panel(s): (panel mapping pending)
// Original source on G:\: G:/Figure S3_Arp3/Fig. S3a_Rab11a/ImageJMacros/Roi_img_save.ijm
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
             roiManager("Open", dir+list[i]+"_GC_RoiSet.zip"); //open Roi set of the opened video
             roiManager("Sort");
             nROIs = roiManager("count");

             for (y = 0; y < nROIs; y++){
	             roiManager ("Select", y);

				run("Duplicate...", "duplicate channels=1");
				run("Grays");
				run("Invert LUT");
				run("Bandpass Filter...", "filter_large=20 filter_small=3 suppress=None tolerance=5 process");
				run("Subtract Background...", "rolling=10 light stack");

				 Table_path = dir + "\\GC_img\\" + imgName + "_NT_" + y + ".tif";
				 saveAs("Tiff", Table_path);
	             close();
				}

               roiManager("Deselect");
               roiManager("reset");
               close("*");

                 }

     }

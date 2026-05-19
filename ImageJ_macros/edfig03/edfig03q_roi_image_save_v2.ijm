// ============================================================================
// edfig03q_roi_image_save_v2.ijm — (panel mapping pending)
// ============================================================================
//
// What this macro does: ROI region export + image save (S3q variant).
//
// Manuscript panel(s): (panel mapping pending)
// Original source on G:\: G:/Figure S3_Arp3/Fig. S3q/ActinRF_nested_Lifeact_extfig. 3q/240227/S2/Roi_img_save_2.ijm
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
             name=replace(imgName,".dv","");

             folder2 = dir + File.separator + name;
			File.makeDirectory(folder2);

             roi_name = imgName + "_RoiSet.zip";
             roiManager("Open", dir + roi_name); //open Roi set of the opened video
             nROIs = roiManager("count");

             for (y = 0; y < nROIs; y++){

	             roiManager ("Select", y);

			    // Go to the frame specified by the wave ROI in the original image
		        selectWindow(imgName);

		        // Apply soma ROI to the wave frame

				// Get the slice/frame associated with the wave ROI
		       waveFrame_1 = 1; //floor(waveFrame / 61)*61+1;
		       waveFrame_2 = 61; //waveFrame_1 + 60;

        		run("Duplicate...", "duplicate channels=2 " + "frames=" + waveFrame_1 + "-" + waveFrame_2);
        run("Properties...", "frame=[2 sec]");
				 Table_path = folder2  + File.separator + imgName + "_roi_" + y  +".tif";
				 saveAs("Tiff", Table_path);
	             close();

				}

               roiManager("Deselect");
               roiManager("reset");
               close("*");

                 }

     }

// ============================================================================
// edfig03a_roi_mask_generator.ijm — (panel mapping pending)
// ============================================================================
//
// What this macro does: ROI mask generation from threshold (helper).
//
// Manuscript panel(s): (panel mapping pending)
// Original source on G:\: G:/Figure S3_Arp3/Fig. S3a_Rab11a/ImageJMacros/masked.ijm
//
// Authored by Tien-Chen Lin (Bradke lab, DZNE).
// See CONTRIBUTORS.md for full attribution.
//
// Header added 2026-05-08; commented-out dead alternatives and batch-template boilerplate were removed on 2026-05-13. The executable macro logic is unchanged from the original.
// ============================================================================

dir=getDirectory ("Choose a Directory") ;
saveDir =  dir; //"C:\\Users\\user-adm\\Desktop\\temp\\";
list = getFileList(dir);

for (i=0; i<list.length; i++) {
     if (endsWith(list[i], ".tif")){
             open(dir+list[i]);
             input_image = getTitle();
				selectWindow(input_image);

				Stack.setChannel(1);
				run("Invert LUT");
				run("Enhance Contrast", "saturated=0.35");
				run("Cyan");

				Stack.setChannel(2);
				run("Invert LUT");
				run("Enhance Contrast", "saturated=0.35");
				run("Magenta");

				run("Z Project...", "projection=[Max Intensity]");
				close(input_image);
				name=replace(input_image,".tif","");
				max_name = "MAX_"+ name + ".tif";
				mask_name = "MAX_"+ name + "-1.tif";

                run("Duplicate...", "duplicate channels=1");
				setAutoThreshold("Huang dark no-reset");
				setOption("BlackBackground", true);
				run("Convert to Mask");
				run("Divide...", "value=255.000");
				imageCalculator("Multiply stack", max_name, mask_name);

				saveAs("Tiff", dir + name + "_masked.tif");

				close("*");
  }
}

// ============================================================================
// edfig03a_rab11a_coloc_filtered.ijm — ED Fig 3a
// ============================================================================
//
// What this macro does: M30 — colocalization with filtering.
//
// Manuscript panel(s): ED Fig 3a
// Original source on G:\: G:/Figure S3_Arp3/Fig. S3a_Rab11a/ImageJMacros/filtered_coloc.ijm
//
// Authored by Tien-Chen Lin (Bradke lab, DZNE).
// See CONTRIBUTORS.md for full attribution.
//
// Header added 2026-05-08; commented-out dead alternatives and batch-template boilerplate were removed on 2026-05-13. The executable macro logic is unchanged from the original.
// ============================================================================

dir=getDirectory ("Choose a Directory") ;
saveDir = dir; // "C:\\Users\\user-adm\\Desktop\\temp\\";
list = getFileList(dir);

for (i=0; i<list.length; i++) {
     if (endsWith(list[i], ".tif")){
             open(dir+list[i]);
             input_image = getTitle();
				selectWindow(input_image);

				name=replace(input_image,".tif","");

				Stack.setChannel(1);
				run("Grays");
				run("Invert LUT");

				Stack.setChannel(2);
				run("Grays");
				run("Invert LUT");

				run("Subtract Background...", "rolling=20 light sliding stack");

				run("Bandpass Filter...", "filter_large=40 filter_small=3 suppress=None tolerance=5 autoscale saturate process");
				saveAs("Tiff", saveDir + name + "_filtered.tif");
				new_name=getTitle();
				run("Split Channels");

				run("Colocalization ", "autothreshold threshold=0 threshold_0=0 channel=C1-" + new_name + " channel_0=C2-" + new_name);
				saveAs("Tiff", saveDir + name + "_colocalization.tif");

				selectWindow("Index of correlation");
				saveAs("Text", saveDir + name + "_idx.txt");
				close("Index of correlation");
				close("*");
  }
}

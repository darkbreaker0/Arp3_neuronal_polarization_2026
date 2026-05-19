// ============================================================================
// edfig03a_spot_tracker_utility.ijm — ED Fig 3a (orphan)
// ============================================================================
//
// What this macro does: Spot/trajectory tracker (orphan — no R pipeline consumer).
//
// Manuscript panel(s): ED Fig 3a (orphan)
// Original source on G:\: G:/Figure S3_Arp3/Fig. S3a_Rab11a/ImageJMacros/Tracker.ijm
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
				name=replace(input_image,".tif","");
				run("Split Channels");
				img_C2 = "C2-" +  input_image;
				selectWindow(img_C2);

				saveAs("Tiff", dir + name + "_C2.tif");
				run("Particle Tracker 2D/3D", "radius=4 cutoff=0.001 per/abs=0.5 link=1 displacement=10 dynamics=Brownian");

				close("*");
  }
}

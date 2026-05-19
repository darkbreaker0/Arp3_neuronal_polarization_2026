// ============================================================================
// 3_merged.ijm — (panel mapping pending)
// ============================================================================
//
// What this macro does: Channel merge helper for PA-Rac1 imaging.
//
// Manuscript panel(s): (panel mapping pending)
// Original source on G:\: G:/Figure 3_Arp3/Fig. 3j-n_PARac1/Andor/PARac1/201215_paRac1_mVenus/200730_TC_proto20201215_174813_20201216_182439/merged.ijm
//
// Authored by Tien-Chen Lin (Bradke lab, DZNE).
// See CONTRIBUTORS.md for full attribution.
//
// Header added 2026-05-08; commented-out dead alternatives and batch-template boilerplate were removed on 2026-05-13. The executable macro logic is unchanged from the original.
// ============================================================================

dir = getDirectory("Choose a Directory ");

folderlist = getFileList(dir);

for(i = 0; i < folderlist.length; i++) {
	subdir = dir + folderlist[i];

	subfolderlist = getFileList(subdir);

	for(j = 0; j < subfolderlist.length; j++) {

	    	open (subdir + subfolderlist[j]);

     		}
    selectImage(1);
    title1 = getTitle;
    print(title1);

    selectImage(2);
    title2 = getTitle;
    print(title2);

    selectImage(3);
    title3 = getTitle;
    print(title3);

    selectImage(4);
    title4 = getTitle;
    print(title4);

        selectImage(5);
    title5 = getTitle;

        selectImage(6);
    title6 = getTitle;

        selectImage(7);
    title7 = getTitle;

        selectImage(8);
    title8 = getTitle;

        selectImage(9);
    title9 = getTitle;

        selectImage(10);
    title10 = getTitle;

     run("Concatenate...", "  image1=" +  title1 + " image2=" +  title2 + " image3=" +  title3 + " image4=" +  title4 + " image5=" +  title5 + " image6=" +  title6 + " image7=" +  title7+ " image8=" +  title8+ " image9=" +  title9 + " image10=" +  title10);
     saveAs("tiff", subdir + "merged");

      close("*");

	}

//+ " image3=" +  title3 + " image4=" +  title4

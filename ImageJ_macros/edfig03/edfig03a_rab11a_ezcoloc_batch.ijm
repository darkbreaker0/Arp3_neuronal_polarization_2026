// ============================================================================
// edfig03a_rab11a_ezcoloc_batch.ijm — ED Fig 3a
// ============================================================================
//
// What this macro does: M29 — EZColocalization batch (PCC/SRCC/ICQ/MCC vs Costes).
//
// Manuscript panel(s): ED Fig 3a
// Original source on G:\: G:/Figure S3_Arp3/Fig. S3a_Rab11a/ImageJMacros/EZcoloc.ijm
//
// Authored by Tien-Chen Lin (Bradke lab, DZNE).
// See CONTRIBUTORS.md for full attribution.
//
// Header added 2026-05-08; commented-out dead alternatives and batch-template boilerplate were removed on 2026-05-13. The executable macro logic is unchanged from the original.
// ============================================================================
saveDir =  "C:\\Users\\user-adm\\Desktop\\temp\\";
dir=getDirectory ("Choose a Directory") ;
list = getFileList(dir);

for (i=0; i<list.length; i++) {
     if (endsWith(list[i], ".tif")){
             open(dir+list[i]);
             input_image = getTitle();
				selectWindow(input_image);
				run("Split Channels");

				img_C1 = "C1-" +  input_image;
				img_C2 = "C2-" +  input_image;

				run("EzColocalization ", "reporter_1_(ch.1)=" + img_C1 + " reporter_2_(ch.2)=" + img_C2 + " alignthold4=default tos metricthold1=costes' allft-c1-1=10 allft-c2-1=10 pcc metricthold2=costes' allft-c1-2=10 allft-c2-2=10 srcc metricthold3=costes' allft-c1-3=10 allft-c2-3=10 icq metricthold4=costes' allft-c1-4=10 allft-c2-4=10 mcc metricthold5=costes' allft-c1-5=10 allft-c2-5=10 summary");
				saveAs("Results", dir  + input_image + "_C1C2.csv");
				selectWindow(input_image+ "_C1C2.csv");
		        run("Close" );

				close("*");
  }
}

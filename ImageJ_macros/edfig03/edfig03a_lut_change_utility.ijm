// ============================================================================
// edfig03a_lut_change_utility.ijm — ED Fig 3a (display)
// ============================================================================
//
// What this macro does: LUT utility — orphan (no R consumer).
//
// Manuscript panel(s): ED Fig 3a (display)
// Original source on G:\: G:/Figure S3_Arp3/Fig. S3a_Rab11a/ImageJMacros/change_LUT.ijm
//
// Authored by Tien-Chen Lin (Bradke lab, DZNE).
// See CONTRIBUTORS.md for full attribution.
//
// Header added 2026-05-08; commented-out dead alternatives and batch-template boilerplate were removed on 2026-05-13. The executable macro logic is unchanged from the original.
// ============================================================================

dir=getDirectory ("Choose a Directory") ;

list = getFileList(dir);

for (i=0; i<list.length; i++) {
     if (endsWith(list[i], ".tif")){
             open(dir+list[i]);
             imgName=getTitle();
             Stack.setChannel(1);
             run("Yellow");
             run("Enhance Contrast", "saturated=0.35");
             Stack.setChannel(2);
				run("Cyan");
				run("Enhance Contrast", "saturated=0.35");
				Stack.setChannel(3);
				run("Magenta");
				run("Enhance Contrast", "saturated=0.35");
run("Save");
close();
                 }

     }

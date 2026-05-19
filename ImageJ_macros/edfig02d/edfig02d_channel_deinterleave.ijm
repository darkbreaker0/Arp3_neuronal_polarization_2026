// ============================================================================
// edfig02d_channel_deinterleave.ijm — (panel mapping pending)
// ============================================================================
//
// What this macro does: M7 — channel deinterleave stub (helper for M4/M2).
//
// Manuscript panel(s): (panel mapping pending)
// Original source on G:\: G:/Figure S2_actin/Fig. S2d/Lyn_Lifeact/221101/201102_DIV2_1min/deinterleave.ijm
//
// Authored by Tien-Chen Lin (Bradke lab, DZNE).
// See CONTRIBUTORS.md for full attribution.
//
// Header added 2026-05-08; commented-out dead alternatives and batch-template boilerplate were removed on 2026-05-13. The executable macro logic is unchanged from the original.
// ============================================================================

dir = getDirectory ("Choose a Directory") ;
list = getFileList(dir);

for (i=0; i<list.length; i++) {
	if (endsWith(list[i], ".tif")){

	open (dir +list[i]);
	name=getTitle();
	run("Deinterleave", "how=2");
    run("Merge Channels...", "c5=[" + name+" #1] c6=[" + name +" #2] create");
Stack.setChannel(1);
run("Cyan");
Stack.setChannel(2);
run("Magenta");
    saved_path = dir + "/" + name;
	saveAs("Tiff", saved_path);
     close("*");
	}

}

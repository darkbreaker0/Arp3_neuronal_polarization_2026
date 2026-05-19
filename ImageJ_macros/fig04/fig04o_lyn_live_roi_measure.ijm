// ============================================================================
// fig04o_lyn_live_roi_measure.ijm — Fig 4o
// ============================================================================
//
// What this macro does: M19 — Lyn-live time-lapse ROI measurement (4-copy hash group; canonical kept).
//
// Manuscript panel(s): Fig 4o
// Original source on G:\: G:/Figure 4_Arp3KO/Fig. 4o/WT_KO_Lyn_Live_Fig. 4o/Arp3KO/Macro.ijm
//
// Authored by Tien-Chen Lin (Bradke lab, DZNE) with Christoph Möhl
// (Bradke lab, DZNE) and Mansoureh Aghabeig (Image and Data Analysis
// Facility, DZNE) — joint contribution to the Bradke-lab kymograph
// workflow (`Multi Kymograph` / `KymoResliceWide` + `Proc.py`).
// See CONTRIBUTORS.md for full attribution.
//
// Header added 2026-05-08; commented-out dead alternatives and batch-template boilerplate were removed on 2026-05-13. The executable macro logic is unchanged from the original.
// ============================================================================

dir = getDirectory("Choose a Directory ");
macro_dir =  getDirectory("home");
macro_dir = macro_dir + "Nextcloud\\Neurite activities\\"

// specify macro location

folderlist = getFileList(dir);
w=100;
x=5;

for(i = 0; i < folderlist.length; i++) {
	subdir = dir + folderlist[i];
	subfolderlist = getFileList(subdir);

	for(j = 0; j < subfolderlist.length; j++) {
		 if (endsWith(subfolderlist[j], "kymograph.tif")){
	    	open (subdir + subfolderlist[j]);

                  run("Threshold...");
                  waitForUser("set the threshold and press Apply");

                  getThreshold(lower, upper);
		          resetThreshold();
			      Table_path = subdir +  "Lyn_" + j + ".csv" ;

			      arglst = Table_path + "," + upper + "," + x + "," + w ;
		          runMacro(macro_dir + "Proc.py",arglst);
		          saveAs("Results", Table_path);
		          close("*");

     		}
	}
}

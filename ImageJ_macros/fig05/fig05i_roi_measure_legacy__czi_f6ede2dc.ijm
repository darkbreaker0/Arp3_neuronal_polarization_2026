// ============================================================================
// fig05i_roi_measure_legacy__czi_f6ede2dc.ijm — (panel mapping pending)
// ============================================================================
//
// What this macro does: M27 — minimal ROI extraction (2015/2016 legacy).
//
// Manuscript panel(s): (panel mapping pending)
// Original source on G:\: G:/Figure 5_myosin/Fig. 5i/2016Feb_blebbKOvWT_expt4/KO/KO_20uM_48hr/2016-02-29/czi/Roi_measure.ijm
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
	open (dir +list[i]+ "_RoiSet.zip");
	roiManager("Sort");

	nROIs = roiManager("count");

      for (y = 0; y < nROIs; y++)
          {
              roiManager ("Select", y);
              Stack.setChannel(3);
              roiManager("Measure");
           }
             roiManager("Deselect");
             roiManager("reset");

     close("*");
	}

}

Table_path = dir + "Tau_length.csv" ;
saveAs("Results", Table_path);
run("Clear Results");

// ============================================================================
// fig05il_blebbistatin_roi_measure.ijm — Fig 5i + ED Fig 12a
// ============================================================================
//
// What this macro does: M25 — Blebbistatin live-cell ROI measurement (Fig 5i + ED Fig 12a hash-identical).
//
// Manuscript panel(s): Fig 5i + ED Fig 12a
// Original source on G:\: G:/Figure 5_myosin/Fig. 5i/2016Mar_blebb_WTvKO_series5/WT/WT_20uM_48hr/2016-04-21/SNT/Macro.ijm
//
// Authored by Tien-Chen Lin (Bradke lab, DZNE).
// See CONTRIBUTORS.md for full attribution.
//
// Header added 2026-05-08; commented-out dead alternatives and batch-template boilerplate were removed on 2026-05-13. The executable macro logic is unchanged from the original.
// ============================================================================
run("Simple Neurite Tracer...", "imagechoice=New-44.czi uichoice=[Default: XY, ZY and XZ views] channel=1");
roiManager("Deselect");
roiManager("Deselect");
run("ROI Exporter", "roichoice=[path segments] viewchoice=[XY (default)] useswccolors=false avgwidth=false discardexisting=true");
roiManager("Measure");
selectWindow("New-44.czi");
close();
run("Simple Neurite Tracer...", "imagechoice=New-43.czi tracesfile=/Users/lint/SNT/43.traces uichoice=[Memory saving: Only XY view] channel=1");
roiManager("Deselect");
roiManager("Deselect");
run("ROI Exporter", "roichoice=[path segments] viewchoice=[XY (default)] useswccolors=false avgwidth=false discardexisting=true");
roiManager("Measure");
selectWindow("New-43.czi");
close();
run("Simple Neurite Tracer...", "imagechoice=New-42.czi tracesfile=/Users/lint/SNT/42.traces uichoice=[Memory saving: Only XY view] channel=3");
roiManager("Deselect");
roiManager("Deselect");
run("ROI Exporter", "roichoice=[path segments] viewchoice=[XY (default)] useswccolors=false avgwidth=false discardexisting=true");
roiManager("Measure");
Stack.setActiveChannels("011");
Stack.setActiveChannels("001");
Stack.setActiveChannels("011");
Stack.setActiveChannels("001");
Stack.setActiveChannels("011");
Stack.setActiveChannels("111");
Stack.setActiveChannels("011");
Stack.setActiveChannels("111");
Stack.setActiveChannels("011");
selectWindow("New-42.czi");
close();
selectWindow("New-41.czi");

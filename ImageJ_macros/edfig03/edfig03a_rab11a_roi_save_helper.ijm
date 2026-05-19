// ============================================================================
// edfig03a_rab11a_roi_save_helper.ijm — (panel mapping pending)
// ============================================================================
//
// What this macro does: Minimal ROI manager save (helper).
//
// Manuscript panel(s): (panel mapping pending)
// Original source on G:\: G:/Figure S3_Arp3/Fig. S3a_Rab11a/221019_Rab11aEGFP/roi_save.ijm
//
// Authored by Tien-Chen Lin (Bradke lab, DZNE).
// See CONTRIBUTORS.md for full attribution.
//
// Header. The macro
// logic below this header is bit-faithful to the G:\ original; only
// comments (in-line beginner annotations and the header above) have been
// added during the 2026-05-13 annotation pass.
// ============================================================================
//
// PIPELINE ROLE (beginner)
// ------------------------
// An INTERACTIVE helper for the ED Fig 3a Rab11a-EGFP workflow. Run this
// after you have:
//   1. Opened an image in Fiji
//   2. Drawn N neurite-tip ROIs in the ROI Manager
//
// The macro then:
//   1. Saves the whole ROI set as `<image>.tif_NT.zip`.
//   2. For each ROI, duplicates the bounding box and saves it as a
//      separate `<image>.tif_NT_<index>.tif` file (one cropped sub-image
//      per neurite tip).
//   3. Resets the ROI Manager and closes all open windows.
//
// "_NT" = "neurite tip".
//
// USAGE
// -----
//   1. Open the image in Fiji.
//   2. Manually draw your ROIs and Add each to ROI Manager (key shortcut: t).
//   3. Run this macro. No prompts — it pulls everything from the active
//      image + ROI Manager state.
//
// See ImageJ_macros/README.md (Pattern 2) for ROI Manager basics.
// ============================================================================

imgName=getTitle();                       // name of the currently-active image
dir=getDirectory ("image") ;              // folder the image lives in
                                          //   ("image" = special argument
                                          //    that returns the dir of the
                                          //    currently-active image)
roiManager("Deselect");                   // make sure no ROI is selected
                                          // (otherwise Save would save just
                                          //  the selected one, not the set)
roiManager("Save", dir + imgName + "_NT.zip"); // save the full ROI set as
                                          // <image>.tif_NT.zip

roiManager("Sort");                       // sort ROIs by name (alphabetical)
                                          // so the output _NT_<index>.tif
                                          // ordering is stable
             nROIs = roiManager("count"); // how many ROIs in the manager?

             for (y = 0; y < nROIs; y++){ // for each ROI:
	             roiManager ("Select", y);//   make ROI y the active selection
				 run("Duplicate...", "duplicate");
                                          //   duplicate the bounding-box
                                          //   crop of that ROI into a new
                                          //   window (with full stack range)
				 Table_path = dir + imgName + "_NT_" + y + ".tif";
				 saveAs("Tiff", Table_path);
                                          //   save the crop as
                                          //   <image>.tif_NT_<i>.tif
	             close();                 //   close the duplicate window
				}

roiManager("reset");                      // clear the ROI Manager for the
                                          // next image
close("*");                               // close ALL open image windows
                                          // (clean slate)

// ============================================================================
// edfig08j_3d_blob_detector_comdet.ijm — ED Fig 8j (orphan)
// ============================================================================
//
// What this macro does: M37 — ComDet blob detection for 3D collagen patches (orphan).
//
// Manuscript panel(s): ED Fig 8j (orphan)
// Original source on G:\: G:/Figure S8_Arp3KO/Fig. S8j/3D_collagen_cultures/3D_KO_2014_Apr16/decon_MIP/Patch_num_ComDet.ijm
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
// For every `.tif` in the picked folder, runs the **ComDet** Fiji plugin
// (Cell-Counter / Detect-Particles) to auto-detect bright spots in the
// 3D MIP (Maximum Intensity Projection) of decon'd collagen cultures.
// The detections are saved as a per-image `<image>.tif_patch_RoiSet.zip`
// — these ROI sets are then ingested by a downstream R analysis (or in
// the published manuscript, by a hand-curation step).
//
// "orphan" in the header means no R Markdown analysis directly consumes
// this macro's output as-is — the ROI sets are used for visual
// counting / display only.
//
// REQUIREMENTS
// ------------
//   ComDet plugin must be installed in Fiji
//   (`Help → Update → Manage Update Sites → ComDet`).
//
// PARAMETERS (passed to ComDet's "Detect Particles" dialog)
// ---------------------------------------------------------
//   ch1i, ch1l   = channel-1 detection flags (intensity, size locks)
//   ch1a = 4     = particle approximate diameter, in pixels (= ~4 px blobs)
//   ch1s = 2     = "sensitivity" / SNR threshold (lower = more detections)
//   rois = Ovals = output ROI shape (Oval, not box)
//   add = [All detections] = push every detection to the ROI Manager
//   summary = Append = append per-image summary to a single Summary window
//
// See ImageJ_macros/README.md (Pattern 2) for the ROI Manager idiom.
// ============================================================================

dir=getDirectory ("Choose a Directory") ;     // user picks the folder

list = getFileList(dir);

for (i=0; i<list.length; i++) {
     if (endsWith(list[i], ".tif")){           // process only .tif (MIPs)
             open(dir+list[i]);
             run("Detect Particles",           // call ComDet
                 "ch1i ch1l ch1a=4 ch1s=2 rois=Ovals add=[All detections] summary=Append");
                                               // → fills the ROI Manager
                                               // with one Oval ROI per
                                               // detected particle, and
                                               // appends one row to the
                                               // Summary window
             imgName=getTitle();

				roiManager("Deselect");
				roiManager("Save", dir + imgName + "_patch_RoiSet.zip");
                                               // save the detections as a
                                               // ROI set named after the
                                               // image
				roiManager("Deselect");
				roiManager("reset");          // clear for next image
				close("*");                   // close all image windows

                 }
		else {}                                // skip non-.tif

     }

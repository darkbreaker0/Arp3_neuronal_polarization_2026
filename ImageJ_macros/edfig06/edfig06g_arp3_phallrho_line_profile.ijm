// ============================================================================
// edfig06g_arp3_phallrho_line_profile.ijm — ED Fig 6g
// ============================================================================
//
// What this macro does: M22 — Arp3-Phall ICC line profile (Airyscan).
//
// Manuscript panel(s): ED Fig 6g
// Original source on G:\: G:/Figure S6_myosin/Fig. S6g/201002_ICC_extFig. 6g/Arp3A488_PhallRho/WT/Airyscan/Line_profiles.ijm
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
// For ED Fig 6g (Arp3 + Phalloidin ICC, Airyscan high-res imaging):
//   For each .czi file in the picked folder:
//     1. Open the file.
//     2. Load the matching `<image>.czi_RoiSet.zip` (a set of line ROIs
//        that the user pre-drew through cellular structures of interest).
//     3. For each line ROI, run "Multichannel Plot Profile" on channel 2
//        (Phalloidin signal) and pull out the 1-D intensity profile.
//     4. Write the profile into the Results table as one column per ROI
//        named "<image>_<ROI-index>".
//     5. After all ROIs are processed, save Results to a per-image CSV:
//        `<image>.czi_Line_profiles2.csv`.
//
// The R analysis at `figures/EDFig06_myosin/edfig06g_arp3_factin_airyscan_line_profile_coloc.Rmd`
// consumes these per-image CSVs and pivots them to one column per line
// position.
//
// USAGE
// -----
//   Drag this file onto Fiji → Run. Pick the folder containing the .czi
//   files and their matching `*_RoiSet.zip` ROI files.
//
// See ImageJ_macros/README.md (Pattern 3) for the line-profile idiom.
// ============================================================================

dir=getDirectory ("Choose a Directory") ;     // pick the folder

list = getFileList(dir);

for (i=0; i<list.length; i++) {
     if (endsWith(list[i], ".czi")){           // process only Zeiss .czi
                                               // files; skip .zip, .csv,
                                               // already-generated outputs
             open(dir+list[i]);
             imgName=getTitle();
             roiManager("Open", dir+imgName+"_RoiSet.zip"); //open Roi set of the opened video
                                               // load this image's
                                               // matching line ROI set
             nROIs = roiManager("count");

             for (y = 0; y < nROIs; y++)
               {
               selectWindow(imgName);          // make sure the image is
                                               // the active window before
                                               // applying the ROI
               roiManager ("Select", y);       // pick ROI y (a line)
               Stack.setChannel(2);            // measure channel 2 only
                                               // (Phalloidin/rhodamine)
			   run("Multichannel Plot Profile"); // Fiji plugin that gives
                                               // a Plot window with one
                                               // curve per channel for the
                                               // current line ROI
			   Plot.getValues (xpoints, ypoints);
                                               // pull (distance, intensity)
                                               // into local arrays
                                               // xpoints[] = µm along line
                                               // ypoints[] = mean intensity

                                               // Each column gets a name
                                               // like "<image>_<ROI-index>"
                                               // → the R analysis can
                                               // identify ROI provenance
                                               // from the column name.
				  for (z = 0; z < xpoints.length; z++) {
				    setResult (imgName + "_" + y, z, ypoints[z]);
				  		}                       // setResult(col, row, val):
                                               // grows Results to include
                                               // a column named after this
                                               // ROI; one row per pixel
                                               // along the line.

                                               // Plot window open for
                                               // visual sanity check
			  updateResults ();                // refresh the Results
                                               // table after each ROI

               }

            Table_path = dir + imgName + "_Line_profiles2.csv" ;
			saveAs("Results", Table_path);    // save per-image CSV
			run("Clear Results");             // clear table for next image
            roiManager("reset");              // clear ROI Manager too
            close("*");                       // close all image windows

                 }

		else {}                               // not a .czi → skip
     }

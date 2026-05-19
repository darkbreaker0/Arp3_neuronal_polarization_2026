// ============================================================================
// fig03or_perfusion_area_kymo_gen.ijm — Fig 3r
// ============================================================================
//
// What this macro does: M15 — kymograph for perfusion area (typo "perfuion" fixed in rename).
//
// Manuscript panel(s): Fig 3r
// Original source on G:\: G:/Figure 3_Arp3/Fig. 3o-r_local_perfusion/DMSO_control/Kymo_for_perfuion_area.ijm
//
// Authored by Tien-Chen Lin (Bradke lab, DZNE) with Christoph Möhl
// (Bradke lab, DZNE) and Mansoureh Aghabeig (Image and Data Analysis
// Facility, DZNE) — joint contribution to the Bradke-lab kymograph
// workflow (`Multi Kymograph` / `KymoResliceWide` + `Proc.py`).
// See CONTRIBUTORS.md for full attribution.
//
// Header added 2026-05-08; commented-out dead alternatives and batch-template boilerplate were removed on 2026-05-13. The executable macro logic is unchanged from the original.
// ============================================================================
// ---- Process opened stack and save a thresholded kymograph ----
// 1. Duplicate channel 2
origTitle = getTitle();
run("Duplicate...", "title=" + origTitle + "_c2 duplicate channels=2");

// 2. Ask the user to draw a line ROI
waitForUser("Draw a straight line ROI on the duplicate image,\nthen click OK to continue.");

// 3. Build the kymograph with KymoResliceWide
run("KymoResliceWide", "intensity=Maximum ignore ignore_0");

// Rename the kymograph window so we know what to save
base = origTitle;
dot  = indexOf(base, ".");
if (dot > 0) base = substring(base, 0, dot);  // strip extension if present
kymoTitle = base + "_kymo";
rename(kymoTitle);

// 4. Open the Threshold dialog

// 5. Wait for the user to press “Apply” in the Threshold window

// 6. Save the thresholded kymograph next to the original file
dir = getDirectory("image");            // falls back to current working dir if unknown
if (dir == "") dir = getDirectory("current");

savePath = dir + File.separator + kymoTitle + ".tif";
saveAs("Tiff", savePath);
close("*");

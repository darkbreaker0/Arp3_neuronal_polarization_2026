// ============================================================================
// edfig03q_kymo_extract_stub.ijm — (panel mapping pending)
// ============================================================================
//
// What this macro does: M34 — minimal kymograph extractor stub.
//
// Manuscript panel(s): (panel mapping pending)
// Original source on G:\: G:/Figure S3_Arp3/Fig. S3b/ActinRF_nested_Lifeact/241023_DIV1_nested/kymo_extract.ijm
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
// A SHORT post-processing helper meant to be run interactively on a single
// kymograph image that is already open in Fiji (no folder picker, no
// batch loop). It re-colorizes the kymograph for visualization:
//   1. Apply Kymo Colorize (a Fiji plugin that converts the kymo to a
//      false-colored visualization).
//   2. Duplicate channel 2 in grayscale.
//   3. Apply a Top-Hat filter (background-subtracted bright structures).
//   4. Boost contrast and apply the "Fire" LUT for display.
// No CSV is produced. Output is purely a visual figure-ready kymograph.
//
// USAGE
// -----
//   Open the kymograph .tif in Fiji first, then run this macro.
//
// See ImageJ_macros/README.md (Pattern 5) for the kymograph concept.
// ============================================================================

run("Kymo Colorize");                     // colorize the kymo (plugin call)
run("Duplicate...", "duplicate channels=2"); // pull channel 2 into its own
                                          // window for separate processing
run("   Grays ");                         // apply the 8-bit Grays LUT to it
run("Top Hat...", "radius=10");           // morphological top-hat with
                                          // 10-pixel rolling kernel —
                                          // suppresses smooth background,
                                          // keeps small bright features
selectImage("Composite-1");               // switch focus back to the
                                          // Kymo-Colorize composite

run("Enhance Contrast", "saturated=0.35"); // contrast stretch, allowing
run("Enhance Contrast", "saturated=0.35"); // up to 0.35% of pixels to
run("Enhance Contrast", "saturated=0.35"); // saturate per call; called 3×
                                          // because each Enhance is mild
run("Fire");                              // apply the heat-map "Fire" LUT
                                          // (black→red→yellow→white)

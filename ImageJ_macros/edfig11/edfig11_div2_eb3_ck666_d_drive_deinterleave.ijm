/* =============================================================================
 *  ED Fig 11d, 11e, 11f - 2-channel deinterleave for EB3 + Lifeact
 *                         time-lapses under CK-666 perturbation
 *  Lin et al., Nature 2026 (Bradke lab, DZNE)
 * =============================================================================
 *
 *  PIPELINE ROLE
 *  -------------
 *  This Fiji/ImageJ macro is the IMAGE-PREPROCESSING step that converts
 *  single-channel interleaved time-lapses (where the microscope wrote
 *  alternating frames of two emission channels into one stack) into
 *  proper 2-channel composite TIFFs suitable for the EB3 length /
 *  intensity analysis at:
 *      edfig11df_eb3_div2_ck666_raw_d_drive.Rmd
 *      edfig11df_eb3_div2_decon_cropped_d_drive.Rmd
 *      edfig11df_eb3_div3_ck666_decon_d_drive.Rmd
 *      edfig11df_eb3_div4_ck666_raw_d_drive.Rmd
 *
 *  WHAT THIS MACRO DOES (beginner)
 *  -------------------------------
 *  1. Asks the user to pick a directory.
 *  2. For every .tif in that directory (non-recursive):
 *        - Opens the stack.
 *        - Runs Fiji's "Deinterleave" with how=2:
 *              splits the single-channel stack into two channel stacks
 *              (#1 = odd frames, #2 = even frames).
 *        - Merges them back as a 2-channel COMPOSITE:
 *              c5 = green channel = even frames (EB3-mNeonGreen)
 *              c6 = magenta channel = odd frames (Lifeact-mScarlet)
 *          (c5/c6 are Fiji's "Cyan/Magenta" defaults; see
 *           Image > Color > Channels Tool > "More" > LUT to remap.)
 *        - Saves as <name>_comp.tif in the same directory.
 *        - Closes everything before the next file.
 *
 *  WHY DEINTERLEAVE?
 *  -----------------
 *  On the GE Healthcare / Applied Precision DeltaVision-Elite, single-band 488/561 imaging with
 *  fast filter-wheel swaps writes a 1-channel stack with channels
 *  alternating frame-by-frame. Quantification scripts downstream assume
 *  proper 2-channel composites (1 timepoint = 1 frame per channel), so
 *  this macro re-shapes the data accordingly.
 *
 *  TERMINOLOGY
 *  -----------
 *    "interleaved"    Two channels written as alternating frames in a
 *                     single-channel time series; total frames = 2 x N_tp.
 *    "Deinterleave"   Built-in Fiji command (Image > Stacks > Tools).
 *    "Composite"      Fiji's multi-channel display mode where channels are
 *                     blended for visualisation.
 *    "EB3-mNG"        EB3-mNeonGreen, microtubule plus-end tracker.
 *    "CLIJ2"          GPU-accelerated ImageJ ops; the two top-of-file
 *                     CLIJ2 calls are commented out (not used at runtime).
 *
 *  REQUIREMENTS
 *  ------------
 *    - Fiji / ImageJ 1.53+ with the "Stacks > Tools > Deinterleave" command.
 *    - INTERACTIVE: prompts for the input directory.
 *
 *  REPO STATUS
 *  -----------
 *    Essentiality:    Image-preprocessing (pipeline step for ED Fig 11d-f).
 *    Pairs with:      All four edfig11df_eb3_*_d_drive.Rmd files in
 *                     figures/EDFig11_microtubules/.
 *    D:\ source:      D:\DVElite\CK666_LA_EB3\
 *                     240227_DIV2_EB3\240227_DIV2_EB3_CK666\Deinterleave.ijm
 *    Integrated:      2026-05-12
 *    Annotated:       2026-05-12 (header only; macro body unchanged).
 *
 * =============================================================================
 */

dir = getDirectory ("Choose a Directory") ;
list = getFileList(dir);

for (i=0; i<list.length; i++) {
	if (endsWith(list[i], ".tif")){

	open (dir +list[i]);
	name=getTitle();
	run("Deinterleave", "how=2");
	run("Merge Channels...", "c5=[" + name + " #2] c6=[" + name + " #1] create");
	selectImage("Composite");
    saved_path = dir + "/" + name + "_comp.tif";
	saveAs("Tiff", saved_path);
     close("*");
	}

}

/* =============================================================================
 *  ED Fig 3n, 3o - KIF5C-1-560 tip-intensity extraction (Arp3 KO neurons)
 *  Lin et al., Nature 2026 (Bradke lab, DZNE)
 * =============================================================================
 *
 *  PIPELINE ROLE
 *  -------------
 *  This Fiji/ImageJ macro extracts per-neurite tip-intensity time series of
 *  KIF5C1-560-mNeonGreen + Lifeact-mScarlet from live time-lapse stacks of
 *  Arp3 KO cortical neurons. It is the preprocessing step that feeds the
 *  Arp3 KO arm of the R Markdown analysis
 *      edfig03no_kif5c_arp3ko_velocity_ccf_d_drive.Rmd
 *  for panels ED Fig 3n (Z-score per phase) and ED Fig 3o (CCF with growth).
 *
 *  WHAT THIS MACRO DOES (beginner)
 *  -------------------------------
 *  1. Asks the user to pick a parent directory containing one sub-folder
 *     per imaging session.
 *  2. Walks each sub-folder. For every file whose name starts with
 *     "Tip_Kif5C_" and ends with ".tif" (these are per-neurite cropped
 *     timelapses produced upstream by Bradke-lab cropping macros):
 *        - Opens the image stack.
 *        - Hands the (Results-table path, integration-window w, sub-folder,
 *          paired Actin-CSV path) tuple to the external Jython script
 *              ~/Nextcloud/Neurite activities/Intensity.py
 *          which actually does the ROI-by-ROI intensity reading.
 *        - Saves the Results table as
 *              Kif5C_neurite_<NUM>.csv
 *          in the sub-folder.
 *        - Closes all open images and proceeds to the next file.
 *
 *  TERMINOLOGY
 *  -----------
 *    "KIF5C1-560"   Truncated kinesin-1 motor reporter, residues 1-560;
 *                   accumulates at the future axonal tip.
 *    "Tip_Kif5C_"   Filename prefix for per-neurite-tip cropped TIFFs.
 *    "w"            Integration window (in pixels along the line ROI) used
 *                   inside Intensity.py; set to 2,000,000 here as a very
 *                   permissive cap so all pixels along the neurite are
 *                   integrated.
 *
 *  REQUIREMENTS / EXTERNAL DEPENDENCIES
 *  ------------------------------------
 *    - Fiji / ImageJ 1.53+ with Jython (default scripting language).
 *    - Intensity.py at:
 *          $HOME/Nextcloud/Neurite activities/Intensity.py
 *      (the Bradke-lab common-helper folder; not redistributed with this
 *      repo; ask the lab if you need a copy.)
 *    - The macro is INTERACTIVE: it prompts for the parent directory.
 *
 *  REPO STATUS
 *  -----------
 *    Essentiality:    Essential (pipeline preprocessing for ED Fig 3n/3o).
 *    Pairs with:      edfig03no_kif5c_arp3ko_velocity_ccf_d_drive.Rmd
 *                     edfig03no_kif5c_wt_velocity_ccf_d_drive.Rmd (WT)
 *    D:\ source:      D:\DVElite\Kif5C_extfig. 3no\Arp3KO_Kif5C\Intensity.ijm
 *    Integrated:      2026-05-12
 *    Annotated:       2026-05-12 (header only; macro body unchanged).
 *
 * =============================================================================
 */

dir = getDirectory("Choose a Directory ");
macro_dir =  getDirectory("home");
macro_dir = macro_dir + "Nextcloud\\Neurite activities\\"

// specify macro location

folderlist = getFileList(dir);
w=2000000;

target="Tip_Kif5C_"

for(i = 0; i < folderlist.length; i++) {

	subdir = dir + folderlist[i];
	subfolderlist = getFileList(subdir);

	for(j = 0; j < subfolderlist.length; j++) {

		 if (startsWith(subfolderlist[j], target) && endsWith(subfolderlist[j], ".tif")){
	    	open (subdir + subfolderlist[j]);

	    	input_image = getTitle();
	    	num= replace(input_image, target , "");
	    	num= replace(num, ".tif", "");

	    	Table_path = subdir +  "Kif5C_neurite_" + num + ".csv" ;
	    	csv_file = subdir +  "Actin_" + num + ".csv" ;
	    	csv_file = replace(csv_file, "\\\\" , "\\\\\\\\");
	    	arglst = Table_path + "," + w + "," + subdir +  "," + csv_file ;

	    	runMacro(macro_dir + "Intensity.py", arglst);
			saveAs("Results", Table_path);
			close("*");
     		}
	}
}
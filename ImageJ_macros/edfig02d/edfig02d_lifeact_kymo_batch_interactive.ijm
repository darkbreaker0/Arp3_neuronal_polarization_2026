// ============================================================================
// edfig02d_lifeact_kymo_batch_interactive.ijm — ED Fig 2d
// ============================================================================
//
// What this macro does: M1 — interactive batch threshold + CSV via Proc.py. Feeds R xcorr.
//
// Manuscript panel(s): ED Fig 2d
// Original source on G:\: G:/Figure S2_actin/Fig. S2d/Lyn_Lifeact/Batch.ijm
//
// Authored by Tien-Chen Lin (Bradke lab, DZNE) with Christoph Möhl
// (Bradke lab, DZNE) and Mansoureh Aghabeig (Image and Data Analysis
// Facility, DZNE) — joint contribution to the Bradke-lab kymograph
// workflow (`Multi Kymograph` / `KymoResliceWide` + `Proc.py`).
// See CONTRIBUTORS.md for full attribution.
//
// Header added 2026-05-08; commented-out dead alternatives and batch-template boilerplate were removed on 2026-05-13. The executable macro logic is unchanged from the original.
// ============================================================================
#@ DatasetService ds
#@ File (label="Select a directory", style="directory") dir
#@ String(label="Threshold Method", required=true, choices={'Default white', 'Huang white', 'Intermodes white','IsoData white','Li white','MaxEntropy white', 'Mean white','MinError(I) white','Minimum white' ,'Moments white','Otsu white','Percentile white','RenyiEntropy white','Shanbhag white','Triangle white','Yen white' }) method_threshold
#@ int(label="x median filter", required=true) x
#@ int(label="window length", required=true) w
#@OUTPUT Dataset output

dir=getDirectory ("Choose a Directory") ;
macro_dir = getDirectory("home") + "Nextcloud\\Neurite activities\\";  // specify macro location
w=30
x=10
list = getFileList(dir);

for (i=0; i<list.length; i++) {
     if (endsWith(list[i], ".tif")){

             kymoDir =  dir + "Kymo_" + list[i] + "/";

             kymo_list = getFileList(kymoDir);
			 OutputDir = kymoDir;

             for (k=0; k < kymo_list.length; k++)
             {
                   open(kymoDir+kymo_list[k]);
                   run("Threshold...");
                   waitForUser("set the threshold and press Apply");

                  getThreshold(lower, upper);
		          resetThreshold();
			      Table_path = OutputDir +  "Tip_actin_" + k + ".csv" ;

			      arglst = Table_path + "," + upper + "," + x + "," + w ;
		          runMacro(macro_dir + "Proc.py",arglst);
		          saveAs("Results", Table_path);
		          close("*");
                 }

     }
}

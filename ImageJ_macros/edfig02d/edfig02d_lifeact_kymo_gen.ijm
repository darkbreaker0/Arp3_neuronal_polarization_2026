// ============================================================================
// edfig02d_lifeact_kymo_gen.ijm — ED Fig 2d
// ============================================================================
//
// What this macro does: M2 — single-file kymograph generator (upstream of M1).
//
// Manuscript panel(s): ED Fig 2d
// Original source on G:\: G:/Figure S2_actin/Fig. S2d/Lyn_Lifeact/Kymo_gen.ijm
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
w=50
x=10
list = getFileList(dir);

for (i=0; i<list.length; i++) {
     if (endsWith(list[i], ".tif")){

             kymoDir =  dir + "Kymo_" + list[i] + "/";

             open(dir+list[i]);
             input_image = getTitle();
             name=replace(input_image,".tif","");

             run("Duplicate...", "duplicate channels=1");
			selectWindow(name + "-1.tif");

             roiManager("Open", dir+list[i]+"_RoiSet.zip"); //open Roi set of the opened video
             nROIs = roiManager("count");

             for (y = 0; y < nROIs; y++)
               {
               roiManager ("Select", y);
               run("Multi Kymograph", "linewidth=3") ;  // run ("Kymograph Tool") ;
               run ("Median 3D...", "x = 10 y = 0 z = 0");
               run("16-bit");
               saved_kymo =  "Actin_kymo_" + y ;
               saveAs("tiff", kymoDir + saved_kymo);
               close();
             }
             roiManager("Deselect");
             roiManager("reset");
             close("*");

     }
}

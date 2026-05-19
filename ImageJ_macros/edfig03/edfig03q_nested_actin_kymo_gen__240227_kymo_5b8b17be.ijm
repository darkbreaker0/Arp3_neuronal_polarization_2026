// ============================================================================
// edfig03q_nested_actin_kymo_gen__240227_kymo_5b8b17be.ijm — ED Fig 3b/q
// ============================================================================
//
// What this macro does: M32 — kymograph generator for nested ActinRF (upstream of Batch roi measurement).
//
// Manuscript panel(s): ED Fig 3b/q
// Original source on G:\: G:/Figure S3_Arp3/Fig. S3q/ActinRF_nested_Lifeact_extfig. 3q/240227/GC/240227_kymo/Get_kymo#.ijm
//
// Authored by Tien-Chen Lin (Bradke lab, DZNE) with Christoph Möhl
// (Bradke lab, DZNE) and Mansoureh Aghabeig (Image and Data Analysis
// Facility, DZNE) — joint contribution to the Bradke-lab kymograph
// workflow (`Multi Kymograph` / `KymoResliceWide` + `Proc.py`).
// See CONTRIBUTORS.md for full attribution.
//
// Header added 2026-05-08; commented-out dead alternatives and batch-template boilerplate were removed on 2026-05-13. The executable macro logic is unchanged from the original.
// ============================================================================

dir=getDirectory ("Choose a Directory") ;

list = getFileList(dir);

for (i=0; i<list.length; i++) {

     if (endsWith(list[i], ".tif")){

             open(dir+list[i]);
             imgName=getTitle();
             name=replace(imgName,".tif","");
             run("Subtract Background...", "rolling=10 stack");

             roi_name = imgName + "_RoiSet.zip";
             roiManager("Open", dir + roi_name); //open Roi set of the opened video
             roiManager("Sort");
             nROIs = roiManager("count");

             for (y = 0; y < nROIs; y++){

	             roiManager ("Select", y);
	             run("Multi Kymograph", "linewidth=3");
				 Table_path = dir + "Kymo_" + imgName;
				 saveAs("Tiff", Table_path);
	             close();

				}

               roiManager("Deselect");
               roiManager("reset");
               close("*");

                 }

     }

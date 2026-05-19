// ============================================================================
// fig03or_perfusion_kymo_gen.ijm — Fig 3r
// ============================================================================
//
// What this macro does: M9 — kymograph generator + Colorize LUT for perfusion experiments.
//
// Manuscript panel(s): Fig 3r
// Original source on G:\: G:/Figure 3_Arp3/Fig. 3o-r_local_perfusion/ImageJ_Macro/Kymo.ijm
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

             kymoDir =  dir + "Kymo_" + list[i] + "/";
             File.makeDirectory(kymoDir); // Create folders for kymographs

             open(dir+list[i]);
             input_image = getTitle();
             name = input_image;
             roiManager("Open", dir +name+"_RoiSet.zip"); //open Roi set of the opened video
             nROIs = roiManager("count");

             for (y = 0; y < nROIs; y++)
               {
               roiManager ("Select", y);
               run("Multi Kymograph", "linewidth=1") ;  // run("KymoResliceWide ", "intensity=Maximum ignore");
               run("16-bit");
               run("Kymo Colorize");
               saved_kymo =  "kymogram " + y ;
               saveAs("tiff", kymoDir + saved_kymo);
                 close();
                 close("Kymograph");
             }
             roiManager("Deselect");
             roiManager("reset");
             close("*");

     }
}

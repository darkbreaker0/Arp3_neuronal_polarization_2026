// ============================================================================
// edfig03m_kif5c_soma_z_intensity.ijm — ED Fig 3m
// ============================================================================
//
// What this macro does: M33 — soma Z-profile for KIF5C-LifeAct.
//
// Manuscript panel(s): ED Fig 3m
// Original source on G:\: G:/Figure S3_Arp3/Fig. S3m/170811_KIF5CGFP-LifeActRFP_20170811_172029/soma/soma_intensity.ijm
//
// Authored by Tien-Chen Lin (Bradke lab, DZNE).
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
             roiManager("Open", dir + imgName +"_soma.zip"); //open Roi set of the opened video
             nROIs = roiManager("count");

               roiManager ("Select", 0);
               Stack.setChannel(2);
			   run ("Plot Z-axis Profile");
			  Plot.getValues (xpoints, ypoints);

			  for (z = 0; z < xpoints.length; z++) {
			    setResult (imgName, z, ypoints[z]);
			  		}

			  close();
			  updateResults ();
               roiManager("Deselect");
               roiManager("reset");
               close("*");

                 }

     }

Table_path = dir + "soma_Actin.csv" ;
saveAs("Results", Table_path);
run("Clear Results");

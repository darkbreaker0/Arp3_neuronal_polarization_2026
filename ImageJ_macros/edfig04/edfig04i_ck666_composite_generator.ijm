// ============================================================================
// edfig04i_ck666_composite_generator.ijm — ED Fig 4i (display)
// ============================================================================
//
// What this macro does: M36 — composite generator (orphan: no R consumer, display only).
//
// Manuscript panel(s): ED Fig 4i (display)
// Original source on G:\: G:/Figure S4_CK666/Fig. S4i/CK666_WO_Lifeact/240311_CK666_LA_DIV4_WO/CK666_2min/decon/Combined_image.ijm
//
// Authored by Tien-Chen Lin (Bradke lab, DZNE).
// See CONTRIBUTORS.md for full attribution.
//
// Header added 2026-05-08; commented-out dead alternatives and batch-template boilerplate were removed on 2026-05-13. The executable macro logic is unchanged from the original.
// ============================================================================
//-------------------------------------------------------------------------
// ImageJ Macro: concatenate three DIV4_LifeactmSC_?? files using "Concatenate..."
// and save as DIV4_LifeactmSC_combined_XX.tif
//-------------------------------------------------------------------------

dir = getDirectory("Choose a Directory");

// Close any open images before starting
run("Close All");

for (i = 1; i <= 34; i++) {
    // zero-pad to two digits ("01","02",...,"34")
    index = IJ.pad(i, 2);

    // Build each filename
    file1 = dir + "DIV4_LifeactmSC_03_11_" + index + "_R3D_D3D.dv";
    file2 = dir + "DIV4_LifeactmSC_01_" + index + "_R3D_D3D.dv";
    file3 = dir + "DIV4_LifeactmSC_02_" + index + "_R3D_D3D.dv";

    // Only proceed if all three files exist
    if (File.exists(file1) && File.exists(file2) && File.exists(file3)) {
        // Open each .dv and store its window title
        open(file1);
        title1 = getTitle();
        open(file2);
        title2 = getTitle();
        open(file3);
        title3 = getTitle();

        // Concatenate the three open images into one stack
        //   - "title=[Combined]" is the name of the new stack window
        //   - image1=[<title1>] image2=[<title2>] image3=[<title3>]
        run("Concatenate...",
            "title=[Combined] image1=[" + title1 + "] image2=[" + title2 + "] image3=[" + title3 + "]"
        );  // :contentReference[oaicite:0]{index=0}

        // Save "Combined" (3-slice stack) as a TIFF
        outName = dir + "DIV4_LifeactmSC_combined_" + index + ".tif";
        saveAs("Tiff", outName);

        // Close the concatenated stack plus the original three images
        close("*");

    }
    else {
        // If any of the three files is missing, log a warning
        print("Skipping index " + index + ": missing one or more source files.");
    }
}

print("Finished concatenating all available XX=01–34.");

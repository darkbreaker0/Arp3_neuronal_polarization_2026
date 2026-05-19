// ============================================================================
// fig02ci_soma_z_intensity.ijm — Fig 2b/i
// ============================================================================
//
// What this macro does: M3 — soma actin Z-profile (Fig 2c and 2i hash-identical).
//
// Manuscript panel(s): Fig 2b/i
// Original source on G:\: G:/Figure 2_actin wave/Fig. 2c/Actin_wave_Fig. 2di_ExtFig.2a/R_script/wave_soma_int.ijm
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
// For Fig 2b/i and (hash-identical) Fig 2c: measure how soma actin
// intensity changes around each actin-wave event. For each .tif file in
// the picked folder this macro:
//   1. Opens the image.
//   2. Loads TWO ROI sets named by file convention:
//        <image>.tif_soma.zip — a single ROI tracing the soma boundary.
//        <image>.tif_wave.zip — N ROIs, one per detected wave event;
//          each ROI is positioned at the wave's appearance frame.
//   3. For every wave event, measures the soma intensity at THREE frames:
//        - the wave's actual frame (t),
//        - the frame BEFORE it (t-1),  → baseline
//        - the frame AFTER it (t+2).   → response
//      Three rows per wave-event are appended to Fiji's Results table.
//   4. After all images are processed, the Results table is saved as
//      `measurements.csv` in the chosen folder.
//
// The "+2 for next-frame" instead of "+1" is because the source image is
// 2-channel: timepoint t spans 2 stack slices (chan1 at slice 2t-1,
// chan2 at slice 2t). The 81-line note in the code spells this out.
//
// USAGE
// -----
//   Drag this file onto Fiji → Run. Pick the folder that contains the
//   .tif images and their matching _soma.zip + _wave.zip ROI sets.
//
// See ImageJ_macros/README.md (Pattern 2) for ROI Manager basics. This
// macro is a more advanced variant: it loads TWO ROI sets and measures
// the SAME (soma) ROI at multiple slice positions chosen by the wave ROI.
// ============================================================================

// Define folder paths for images and ROIs
dir = getDirectory("Choose Directory with Image Files");
                                          // user picks the folder; trailing
                                          // slash is included automatically
imageList = getFileList(dir);             // names of everything in that
                                          // folder (images, .zip ROI sets,
                                          // and any other files)

// Loop through each image file in the folder
for (i = 0; i < imageList.length; i++) {

    // Only process .tif files (skip .zip, .csv, etc.)
    if (endsWith(imageList[i], ".tif")) {

    // Open the image
    imagePath = dir + imageList[i];
    open(imagePath);
                                          // sometimes applied to signed
                                          // 16-bit acquisitions
    imageName = getTitle();

	soma_name = replace(imageName, ".tif", ".tif_soma.zip");
                                          // build the matching ROI filename
                                          // by string-replacing extension

    // Open the soma.zip ROI file (one ROI: the soma boundary)
    somaRoiPath = dir + soma_name;
                                          // each image starts with the
                                          // manager already empty (see
                                          // reset at end of previous iter)
    roiManager("Open", somaRoiPath);      // soma ROI appended at index 0

    // Open the wave.zip ROI file (N ROIs: one per wave event,
    // each placed at the slice where the wave was first observed)

    wave_name = replace(imageName, ".tif", ".tif_wave.zip");
    waveRoiPath = dir + wave_name;
    roiManager("Open", waveRoiPath);      // wave ROIs appended at index 1..N

    // Get the number of ROIs in wave.zip
    numWaveRois = roiManager("count");    // total = 1 (soma) + N (waves)

    // Loop through each ROI in wave.zip
    for (j = 1; j < numWaveRois; j++) {   // start at 1 to skip the soma ROI
                                          // at index 0

        // Select the wave ROI (the ROIs in wave.zip are indexed starting at 1)
        roiManager("Select", j);

        // Get the slice/frame associated with the wave ROI
        waveFrame = getSliceNumber();     // the ROI's stack position;
                                          // serves as the "event time" t
		print(waveFrame);                 // debug echo to Fiji's log
        // Go to the frame specified by the wave ROI in the original image
        selectWindow(imageName);

        // Apply soma ROI to the wave frame (= measure soma at t)
        roiManager("Select", 0);          // soma ROI (index 0)
        setSlice(waveFrame);              // navigate to the wave's slice
        Stack.setChannel(1);              // measure on channel 1 only

        // Measure intensity of soma ROI in the wave frame
        run("Measure");                   // adds a row to Results: Area,
                                          // Mean, IntDen, etc. as defined
                                          // by Analyze → Set Measurements

        // Measure intensity of soma ROI in the previous frame (= t - 1, baseline)

        roiManager("Select", 0);          // soma ROI again
        setSlice(waveFrame - 1);          // one slice back
        Stack.setChannel(1);
        run("Measure");                   // baseline row

        // Measure intensity of soma ROI in the next frame (= t + 2)
        //
        // Why +2 instead of +1: the image is 2-channel, so each timepoint
        // takes 2 stack slices (c1 + c2 interleaved). +2 = the NEXT
        // timepoint's channel-1 slice. If a future single-channel variant
        // is used, change this to +1.
        roiManager("Select", 0);
        setSlice(waveFrame + 2); //If image has 2 channel, +2< one channel, +1
        Stack.setChannel(1);
        run("Measure");                   // response row
    }

    // Close the current image and reset the ROI Manager for the next file
     roiManager("Deselect");
             roiManager("reset");         // clear all ROIs for the next image
    close();                              // close the active image window
    }

}

    // After every image has been processed, dump Fiji's accumulated
    // Results table to a single CSV in the picked folder. The 3-rows-
    // per-wave-event layout means the consuming R Markdown analysis can
    // group rows by image-name + slice to get baseline/event/response
    // triplets per wave.
    Table_path = dir + "measurements.csv" ;
               saveAs("Results", Table_path);

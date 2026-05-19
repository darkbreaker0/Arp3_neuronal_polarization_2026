"""
============================================================================
fig03or_perfusion_channel_split_merge__fig_3o-r_local_perfusion_eeb3073b.py — Fig 3r perfusion
============================================================================

What this script does: Jython for ImageJ: 3-channel deinterleave/merge. One canonical kept per hash group. [Disambiguated from collision at ImageJ_macros/fig03/fig03or_perfusion_channel_split_merge.py]

Manuscript panel(s): Fig 3r perfusion
Original source on G:\: G:/Figure 3_Arp3/Fig. 3o-r_local_perfusion/process_ImageJJython.py

Header. The script
logic below this header is bit-faithful to the G:\ original; only the
docstring above has been added.
============================================================================
"""
#@ File(label="Select root folder containing TIFF files", style="directory") rootDir

import os
from ij import IJ, ImagePlus
from ij.io import FileSaver

def process_images_in_folder(rootDir):
    """
    Process .tiff files larger than 100 MB in the selected folder and all subfolders.
    Apply Deinterleave, Merge Channels, color adjustments, and save output in the original folder.
    """
    for root, dirs, files in os.walk(rootDir.getPath()):
        for file in files:
            # Check for TIFF files
            if file.lower().endswith(".tif") or file.lower().endswith(".tiff"):
                filePath = os.path.join(root, file)
                fileSize = os.path.getsize(filePath) / (1024 * 1024)  # Convert to MB

                if fileSize >200:  # Process files larger than 100MB
                    print("Processing file:", filePath, "Size:", fileSize, "MB")
                    
                    # imgName includes ".tif" extension
                    imgName = file  # Keep original file name with extension
                    
                    # Open the image
                    imp = IJ.openImage(filePath)
                    if imp is None:
                        print("Error: Unable to open file:", filePath)
                        continue
                    
                    # Step 1: Deinterleave
                    IJ.run(imp, "Deinterleave", "how=3")
                    
                    # Step 2: Merge Channels
                    IJ.run("Merge Channels...", 
                           "c4=[" + imgName + " #1] " + 
                           "c5=[" + imgName + " #2] " + 
                           "c6=[" + imgName + " #3] create")
                    
                    # Get the merged image
                    mergedImg = IJ.getImage()
                    
                    # Step 3: Process channels
                    # Channel 1 - Grey
                    IJ.runMacro("Stack.setChannel(1);")  # Set Channel 1
                    IJ.run("Grays")
                    IJ.run("Enhance Contrast", "saturated=0.35")
                    
                    # Channel 2 - Cyan
                    IJ.runMacro("Stack.setChannel(2);")  # Set Channel 2
                    IJ.run("Cyan")
                    IJ.run("Enhance Contrast", "saturated=0.35")
                    
                    # Channel 3 - Magenta
                    IJ.runMacro("Stack.setChannel(3);")  # Set Channel 3
                    IJ.run("Magenta")
                    IJ.run("Enhance Contrast", "saturated=0.35")
                    
                    IJ.run("Re-order Hyperstack ...", "channels=[Channels (c)] slices=[Frames (t)] frames=[Slices (z)]")
                    
                    # Step 4: Save processed file with a new name in the original folder
                    outputName = imgName.replace(".tif", "_processed.tif").replace(".tiff", "_processed.tif")
                    outputPath = os.path.join(root, outputName)
                    FileSaver(mergedImg).saveAsTiff(outputPath)
                    print("Saved processed file to:", outputPath)
                    
                    # Close the images
                    mergedImg.close()
                    imp.close()

# Run the function
process_images_in_folder(rootDir)
print("Processing completed successfully!")

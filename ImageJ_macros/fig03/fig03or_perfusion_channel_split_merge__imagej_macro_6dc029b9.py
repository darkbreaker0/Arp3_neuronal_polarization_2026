"""
============================================================================
fig03or_perfusion_channel_split_merge__imagej_macro_6dc029b9.py — Fig 3r perfusion
============================================================================

What this script does: Jython for ImageJ: 3-channel deinterleave/merge. One canonical kept per hash group. [Disambiguated from collision at ImageJ_macros/fig03/fig03or_perfusion_channel_split_merge.py]

Manuscript panel(s): Fig 3r perfusion
Original source on G:\: G:/Figure 3_Arp3/Fig. 3o-r_local_perfusion/ImageJ_Macro/convert_to_avi.ijm.py

Header. The script
logic below this header is bit-faithful to the G:\ original; only the
docstring above has been added.
============================================================================
"""
import os
from ij import IJ, WindowManager

def process_and_save_avi():
    """
    Retrieve the active image's file path and name, then save as .avi.
    """
    # Get the currently active image
    imp = IJ.getImage()
    if imp is None:
        print("Error: No image is currently open.")
        return

    # Get the image title and directory
    title = imp.getTitle()  # Image title with extension
    info = imp.getOriginalFileInfo()  # Retrieve file path information
    
    if info is None or info.directory is None:
        print("Error: Unable to retrieve file path information for the image.")
        return

    inputDir = info.directory  # Directory where the image file is located
    inputPath = os.path.join(inputDir, title)  # Full path of the input file

    # Create output file name by replacing extension with '_processed.avi'
    baseName = os.path.splitext(title)[0]  # Strip the extension
    outputName = baseName + ".avi"
    outputPath = os.path.join(inputDir, outputName)  # Full path for output file

    # Run the AVI save command
    print("Saving as AVI to:", outputPath)
    IJ.run(imp, "AVI... ", "compression=JPEG frame=10 save=[" + outputPath + "]")

    print("Saved successfully:", outputPath)
    imp.close()

# Run the function
process_and_save_avi()
print("Process completed successfully!")

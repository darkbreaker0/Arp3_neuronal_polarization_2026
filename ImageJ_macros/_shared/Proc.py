"""
Proc.py — kymograph-to-time-series Jython post-processor.

Part of the Bradke-lab neurite-growth / kymograph workflow. Called by the
8 kymograph-family .ijm macros in this directory tree:

  ImageJ_macros/edfig02d/edfig02d_lifeact_kymo_batch_interactive.ijm
  ImageJ_macros/edfig02d/edfig02d_lifeact_kymo_gen.ijm
  ImageJ_macros/edfig03/edfig03q_nested_actin_kymo_gen__240227_kymo_5b8b17be.ijm
  ImageJ_macros/edfig03/edfig03q_nested_actin_kymo_gen__241025_analyzed_5f793d08.ijm
  ImageJ_macros/fig03/fig03or_perfusion_kymo_gen.ijm
  ImageJ_macros/fig03/fig03or_perfusion_wave_kymo_gen.ijm
  ImageJ_macros/fig03/fig03or_perfusion_area_kymo_gen.ijm
  ImageJ_macros/fig04/fig04o_lyn_live_roi_measure.ijm

Each of those macros calls:

    runMacro(macro_dir + "Proc.py", arglst)

where `arglst` is a comma-separated string:

    "<Table_path>,<upper_threshold>,<x_median>,<window_length>"

The currently-active image must be a kymograph (time on Y axis, distance
on X axis) where bright pixels above `upper_threshold` mark the
fluorescent structure of interest (e.g. neurite tip in a Lifeact channel).

What this script does:

  1. For each row (= timepoint), scan left-to-right and record the
     RIGHTMOST column whose pixel value > upper_threshold. That column
     is interpreted as the "tip position" for that timepoint.
  2. Compute a `start_point = tip_position - window_length` per row
     (clamped to 0). This defines an integration window of width
     `window_length` ending at the tip.
  3. Sum pixel intensities along that window per row → "integrated
     intensity" of the tip's trailing neurite segment for that timepoint.
  4. Push three columns to Fiji's Results table:
        - Start point
        - Tip point
        - Integerated intensity      ← note: original typo preserved
     One row per Y position of the kymograph (= one row per timepoint).

The Results table is left open for the caller to `saveAs("Results", ...)`
into a per-cell CSV.

Authorship
----------
Authored by:

  - Christoph Möhl (Bradke lab, DZNE)
  - Mansoureh Aghabeig (Image and Data Analysis Facility, DZNE)

Tien-Chen Lin (Bradke lab, DZNE) integrated this script into the 8
kymograph-family `.ijm` macros listed above and also created the
upstream `IJ_NeuriteGrowth` Fiji plugin (not in this repo) that wraps
the same `Multi Kymograph` + `Proc.py` workflow into a user-facing
neurite-tracing tool.

This file in the repo is the `Project_Kymo` variant of Proc.py (uses
`pixl[0] > upper_value` for thresholded tip detection). An older sibling
variant at `~/Nextcloud/03_Notebooks_and_Code/Neurite activities/
NeuriteGrowthScript/Proc.py` uses `pixl[0] > 0` instead (ignores the
threshold argument) — that one is NOT what the kymograph macros in this
repo expect.

The original lives at:
    ~/Nextcloud/03_Notebooks_and_Code/Neurite activities/
    NeuriteGrowthScript/Project_Kymo/Proc.py

The macros hard-code:
    macro_dir = getDirectory("home") + "Nextcloud\\Neurite activities\\"

so when reproducing outside the original author's environment, either:
  - Copy this Proc.py to `~/Nextcloud/Neurite activities/Proc.py`, or
  - Edit `macro_dir` in each kymograph macro to point to
    `ImageJ_macros/_shared/` (this directory).

See `ImageJ_macros/README.md` for the joint authorship paragraph and
the full kymograph-family file list.

License: MIT (see top-level LICENSE).
"""
from ij import IJ
from ij.measure import ResultsTable
import os
import glob


# Getting main parameters
args = getArgument()
arglst= args.split( ",")

Table_path = arglst[0]
upper_value = int(arglst[1])
# x = int(arglst[2]) # x median filter
window_length = int(arglst[3]) # window length

imp = IJ.getImage()

# IJ.run(imp, "Auto Threshold", "method=%s" %method_threshold );


y = imp.getHeight()
x = imp.getWidth()


# Finding the tip point for each row
#(the tip is defined as the nonzero value with hieghest x value)
xlast = 0
tip_point_list =  [];
for row in range(y):
   xlast = 0
   for col in range(x):
      pixl = imp.getPixel(col, row)
      if pixl[0] > upper_value: # upper_value or 0?
         xlast = col
   tip_point_list.append(xlast)

# Calculating the start point
start_point_list = [];
for i in range(len(tip_point_list)):
   start_point = tip_point_list[i] - window_length
   if start_point < 0 :
      start_point = 0
   start_point_list.append(start_point)

# Calculating the integerated intensity
integrated_intensity_list = []
for row in range(y):
     integerated_intensity = 0
     for col in range(start_point_list[row],tip_point_list[row]+1):
         integerated_intensity = integerated_intensity + imp.getPixel(col, row)[0]
     integrated_intensity_list.append(integerated_intensity)

# list tip position for each row (time frame) in results table
table = ResultsTable.getResultsTable()
table.reset()
for i in range(len(tip_point_list)):
    table.incrementCounter()
    table.addValue('Start point', start_point_list[i])
    table.addValue('Tip point', tip_point_list[i])
    table.addValue('Integerated intensity', integrated_intensity_list[i])
    table.show('Results')

# IJ.saveAs("Results", Table_path);
imp.close()

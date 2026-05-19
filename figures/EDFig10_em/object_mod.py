"""
object_mod.py — Batch filament-orientation binning + Newton-disc coloring
==========================================================================

Like `color_model_batch.py`, but in addition to sorting filaments into
angular bins, this version generates a **harmonized Newton-disc color
palette** (one distinct color per angular bin) and a **white object** for
the barbed-end annotations, then writes the colors and a 3D line thickness
into the resulting `.mod` file via `point2model -color`.

Authored by **Florian Fassler**. Feeds ED Fig 10e (12-bin angular
distribution) and the colored radial filament panel in ED Fig 10. The
output `.mod` files open in IMOD's `3dmod` with each angular bin shown in a
distinct hue, making the radial orientation pattern of actin filaments
visually obvious.

Workflow per file (extends `color_model_batch.py`):
    foo.mod  →  IMOD `model2point`  →  foo_converted.txt
                                      ↓ (color_model.py logic)
                                  foo_processed.txt
                                      ↓
        IMOD `point2model -color ... -LineThicknessIn3D N`  →  foo_final.mod
                                                                 (colored)

Beginner notes:
    - "Newton disc" = a color wheel where N evenly spaced hues blend visually
      into white when spun. Here: N-1 saturated hues for the angular bins
      plus pure white (255,255,255) for the (N-th) barbed-end object.
    - HSV-to-RGB conversion uses the standard `colorsys` module from the
      Python standard library — no matplotlib needed.
    - This script imports the analysis functions from `color_model.py` so
      a fix in the binning logic propagates automatically.
"""

import os
import subprocess
import colorsys

# Reuse the canonical analysis functions.
from color_model import (
    file_to_model,
    orient_contours_according_to_barbed_ends,
    split_model_according_to_angle_between_contour_and_given_vector,
    model_to_file,
)


# -- User-editable inputs ---------------------------------------------------
input_folder = "WT/input/"           # folder containing .mod files (recursive)
output_folder = "WT/output_12/"      # folder to write processed .mod files
vector_x_y = [0, 1]                   # reference 2D vector for binning
bin_number = 12                       # number of angular bins
object_count = 13                     # bins + 1 (the +1 is the barbed-end
                                      # object, rendered in white)
line_thickness_3D = 4                 # 3D line thickness in IMOD's 3dmod


# -- Helpers ----------------------------------------------------------------

def find_files_with_extension(folder, extension):
    """Recursively return all files in `folder` whose name ends with
    `extension` (e.g. ".mod")."""
    files = []
    for root, _, filenames in os.walk(folder):
        for filename in filenames:
            if filename.endswith(extension):
                files.append(os.path.join(root, filename))
    return files


def run_imod_command(command, *args):
    """Run an IMOD command-line tool via subprocess and report failures."""
    try:
        subprocess.run([command, *args], check=True)
    except subprocess.CalledProcessError as e:
        print(f"Error running {command}: {e}")


def generate_newton_disc_colors(num_colors):
    """Generate `num_colors-1` evenly spaced hues plus pure white at the end.

    The first `num_colors-1` colors are bright (V=0.95) and saturated
    (S=0.85) HSV-derived RGB triples, evenly spaced around the hue circle.
    The last color is pure white (255, 255, 255) — used for the barbed-end
    annotation object so it's visually distinct from any filament-bin color.
    """
    hue_step = 360 / (num_colors - 1)   # exclude white from the hue rotation
    colors = []
    for i in range(num_colors - 1):
        hue = (hue_step * i) / 360.0    # colorsys wants hue in [0, 1]
        r, g, b = colorsys.hsv_to_rgb(hue, 0.85, 0.95)
        colors.append((int(r * 255), int(g * 255), int(b * 255)))
    colors.append((255, 255, 255))      # white for the (N-th) barbed-end object
    return colors


def process_mod_file(mod_file, output_folder, vector, bins,
                      object_count, line_thickness_3D):
    """Run the full pipeline on a single .mod file, including coloring.

    Steps (extends `color_model_batch.process_mod_file`):
        1. `.mod` → `_converted.txt` via IMOD `model2point`
        2. `_converted.txt` → `_processed.txt` via the binning logic
        3. Generate one color per object (bins + barbed-end-white)
        4. `_processed.txt` → `_final.mod` via IMOD `point2model` with
           `-color R,G,B` flags and `-LineThicknessIn3D N`
    """
    base_name = os.path.basename(mod_file).replace(".mod", "")
    temp_txt = os.path.join(output_folder, f"{base_name}_converted.txt")
    processed_txt = os.path.join(output_folder, f"{base_name}_processed.txt")
    output_mod = os.path.join(output_folder, f"{base_name}_final.mod")

    # 1. Convert .mod to .txt.
    print(f"Processing file: {mod_file}")
    run_imod_command("model2point", "-object", mod_file, temp_txt)

    # 2. Apply the binning analysis.
    model_as_imported = file_to_model(temp_txt)
    model_with_updated_contours = orient_contours_according_to_barbed_ends(
        model_as_imported)
    model_with_updated_objects = (
        split_model_according_to_angle_between_contour_and_given_vector(
            model_with_updated_contours, vector, bins))
    model_to_file(model_with_updated_objects, processed_txt)

    # 3. Build the per-object color list.
    colors = generate_newton_disc_colors(object_count)
    color_commands = []
    for color in colors:
        color_commands.extend(["-color", f"{color[0]},{color[1]},{color[2]}"])

    # 4. Convert back to .mod with colors + open contours + 3D line thickness.
    run_imod_command(
        "point2model",
        "-input", processed_txt,
        "-output", output_mod,
        "-open",
        "-LineThicknessIn3D", str(line_thickness_3D),
        *color_commands)


# -- Main entry point -------------------------------------------------------

if __name__ == "__main__":
    os.makedirs(output_folder, exist_ok=True)
    mod_files = find_files_with_extension(input_folder, ".mod")
    for mod_file in mod_files:
        process_mod_file(mod_file, output_folder, vector_x_y, bin_number,
                          object_count, line_thickness_3D)
    print(f"Batch processing completed. Output files are in {output_folder}.")

"""
color_model_batch.py — Batch wrapper around color_model.py for ED Fig 10e
=========================================================================

Walks a folder of IMOD `.mod` files and runs the filament-orientation
binning pipeline on each one. Calls IMOD's `model2point` to convert each
input `.mod` to text, runs the same binning logic as `color_model.py`, then
calls `point2model` to convert the result back to `.mod`.

Authored by **Florian Fassler**. Feeds ED Fig 10e (12-bin angular
distribution of actin filaments).

Beginner notes:
    - This script imports the analysis functions from `color_model.py`
      (which lives in the same folder), so the two files share the same
      filament-binning logic. If you fix a bug in `color_model.py`, this
      file picks it up automatically.
    - You need IMOD installed and `model2point` / `point2model` reachable
      on your PATH. The script calls them via `subprocess`.
    - Edit `input_folder`, `output_folder`, `vector_x_y`, and `bin_number`
      before running.

Workflow per file:
    foo.mod  →  IMOD `model2point`  →  foo_converted.txt
                                      ↓ (color_model.py logic)
                                  foo_processed.txt
                                      ↓
                       IMOD `point2model`  →  foo_final.mod

For an extended version that also assigns Newton-disc colors and 3D line
thickness for IMOD display, see `object_mod.py`.
"""

import os
import subprocess

# Reuse the canonical analysis functions instead of duplicating them.
from color_model import (
    file_to_model,
    orient_contours_according_to_barbed_ends,
    split_model_according_to_angle_between_contour_and_given_vector,
    model_to_file,
)


# -- User-editable inputs ---------------------------------------------------
input_folder = "WT/input/"          # folder containing .mod files (recursive)
output_folder = "WT/output_12/"     # folder to write processed .mod files
vector_x_y = [0, 1]                  # reference 2D vector for binning
bin_number = 12                      # number of angular bins


# -- Helpers ----------------------------------------------------------------

def find_files_with_extension(folder, extension):
    """Recursively return all files in `folder` whose name ends with
    `extension` (e.g. ".mod"). Used to enumerate inputs for batch
    processing."""
    files = []
    for root, _, filenames in os.walk(folder):
        for filename in filenames:
            if filename.endswith(extension):
                files.append(os.path.join(root, filename))
    return files


def run_imod_command(command, *args):
    """Run an IMOD command-line tool via subprocess and report failures.

    `command` should be on the PATH (e.g. "model2point", "point2model").
    Any non-zero exit is caught and printed; the script continues so a
    single bad file doesn't abort the whole batch.
    """
    try:
        subprocess.run([command, *args], check=True)
    except subprocess.CalledProcessError as e:
        print(f"Error running {command}: {e}")


def process_mod_file(mod_file, output_folder, vector, bins):
    """Run the full pipeline on a single .mod file.

    Steps:
        1. `.mod` → `_converted.txt` via IMOD `model2point`
        2. `_converted.txt` → `_processed.txt` via the binning logic
           imported from `color_model.py`
        3. `_processed.txt` → `_final.mod` via IMOD `point2model`
           (with `-open` so contours are not auto-closed)
    """
    base_name = os.path.basename(mod_file).replace(".mod", "")
    temp_txt = os.path.join(output_folder, f"{base_name}_converted.txt")
    processed_txt = os.path.join(output_folder, f"{base_name}_processed.txt")
    output_mod = os.path.join(output_folder, f"{base_name}_final.mod")

    # 1. Convert .mod to .txt.
    run_imod_command("model2point", "-object", mod_file, temp_txt)

    # 2. Apply the binning analysis (same logic as color_model.py).
    model_as_imported = file_to_model(temp_txt)
    model_with_updated_contours = orient_contours_according_to_barbed_ends(
        model_as_imported)
    model_with_updated_objects = (
        split_model_according_to_angle_between_contour_and_given_vector(
            model_with_updated_contours, vector, bins))
    model_to_file(model_with_updated_objects, processed_txt)

    # 3. Convert .txt back to .mod (open contours).
    run_imod_command("point2model", "-open", processed_txt, output_mod)


# -- Main entry point -------------------------------------------------------

if __name__ == "__main__":
    os.makedirs(output_folder, exist_ok=True)
    mod_files = find_files_with_extension(input_folder, ".mod")
    for mod_file in mod_files:
        process_mod_file(mod_file, output_folder, vector_x_y, bin_number)
    print(f"Batch processing completed. Output files are in {output_folder}.")

"""
color_model.py — Actin filament orientation binning for ED Fig 10e
==================================================================

Single-file version. Takes one IMOD model in `.txt` format (already converted
from `.mod` via the IMOD command `model2point`), sorts each filament into one
of N angular bins relative to a user-supplied reference vector, and writes
out a re-numbered `.txt` model that can be converted back to `.mod` via
`point2model`.

Authored by **Florian Fassler**. Feeds ED Fig 10e (the 12-bin angular
distribution of actin filaments). For the batch version that walks a folder,
see `color_model_batch.py`. For the version that also generates Newton-disc
colors and 3D line thickness for IMOD display, see `object_mod.py`.

Workflow context (IMOD pipeline):
    .mrc volume  →  IMOD filament tracking  →  .mod model
                                              ↓
                          IMOD `model2point` produces .txt (this script's input)
                                              ↓
                          color_model.py sorts filaments into angular bins
                                              ↓
                          IMOD `point2model` converts .txt back to .mod
                                              ↓
                          .mod displayed in 3dmod with colored objects per bin

Input file format (one row per point, 5 tab-separated values):
    object_id  contour_id  x  y  z

Conventions:
    - Object 1 holds the filament contours (each contour = one filament).
    - Object 2 holds annotated barbed-end points (one point per barbed end).
    - The script reverses contour direction when needed so each filament's
      end-point is closest to a barbed-end annotation. This guarantees the
      orientation vector points "barbed-to-pointed".

Beginner tip:
    A "contour" here is a sequence of (x, y, z) points along one filament.
    A "model" is the whole IMOD scene = list of objects = list of contours.
    Edit the `input_file_name`, `output_file_name`, `vector_x_y`, and
    `bin_number` constants below before running.
"""

import math


# -- User-editable inputs ---------------------------------------------------
input_file_name = 'WT/WT_TS_01.mrc.txt'   # original .mod converted to .txt
vector_x_y = [0, 1]                        # reference 2D vector for binning
                                           # (parallel to the leading edge,
                                           #  i.e. 90° CCW of protrusion).
bin_number = 12                            # number of angular bins (each
                                           # spans 360°/N degrees).
output_file_name = 'WT/WT_TS_01.mrc_ordered.txt'   # output .txt; convert
                                                   # back to .mod via
                                                   # `point2model`.


# -- I/O helpers ------------------------------------------------------------

def file_to_list(input_file):
    """Read the `.txt` model into a flat list of whitespace-separated tokens."""
    output_list = []
    for line in open(input_file):
        output_list.extend(line.split())
    return output_list


def element_list_to_named_point_list(input_list):
    """Group the flat token list back into 5-tuple rows.

    Each row of the IMOD `.txt` format is `obj_id contour_id x y z`.
    The flat list has 5 tokens per row in order; this function regroups them.
    """
    building_named_point = []
    building_named_point_list = []
    counter = 0
    for ele in input_list:
        if counter < 4:
            # First 4 columns of the row.
            building_named_point.append(float(ele))
            counter += 1
        else:
            # 5th column — finish the row and reset.
            building_named_point.append(float(ele))
            building_named_point_list.append(building_named_point)
            counter = 0
            building_named_point = []
    return building_named_point_list


def named_point_list_to_model(input_list):
    """Build a nested IMOD model: model = [object1, object2, ...],
    where object = [contour1, contour2, ...] and contour = [(x,y,z), ...].

    Walks the row list in order and starts a new contour whenever the
    contour_id changes, and a new object whenever the object_id changes.
    """
    building_contour = []
    building_object = []
    building_model = []
    current_line = input_list[0]
    current_contour_number = current_line[1]
    current_object_number = current_line[0]
    for ele in input_list:
        if ele[0] != current_object_number:
            # New object — close the current contour + object first.
            building_object.append(building_contour)
            building_model.append(building_object)
            current_contour_number = ele[1]
            current_object_number = ele[0]
            building_contour = [(ele[2], ele[3], ele[4])]
            building_object = []
        else:
            if ele[1] == current_contour_number:
                # Same contour — append point.
                building_contour.append((ele[2], ele[3], ele[4]))
            else:
                # New contour — close current, start fresh.
                building_object.append(building_contour)
                current_contour_number = ele[1]
                building_contour = [(ele[2], ele[3], ele[4])]
    # Flush the trailing contour and object after the loop.
    building_object.append(building_contour)
    building_model.append(building_object)
    return building_model


def file_to_model(file_name):
    """Convenience wrapper: read .txt and return the nested model."""
    return named_point_list_to_model(
        element_list_to_named_point_list(
            file_to_list(file_name)))


# -- Geometry helpers -------------------------------------------------------

def euclidean_distance_3d(point1, point2):
    """3D Euclidean distance between two (x, y, z) points."""
    return ((point1[0] - point2[0]) ** 2
            + (point1[1] - point2[1]) ** 2
            + (point1[2] - point2[2]) ** 2) ** 0.5


def closest_to_point_list_3d(point1, point2, point_list):
    """Return True iff `point1` is closer to *some* point in `point_list`
    than `point2` is. Used to decide which end of a filament contour is
    closest to an annotated barbed-end point."""
    def min_distance(point):
        return min(euclidean_distance_3d(point, p) for p in point_list)
    return min_distance(point1) < min_distance(point2)


def orient_contours_according_to_barbed_ends(model):
    """Flip filament contours so that the end-point of each contour is
    closest to one of the annotated barbed-end points.

    After this step, every filament has a consistent "tail-to-head"
    orientation: the contour starts at the pointed end and ends at the
    barbed end, regardless of how IMOD originally tracked it.
    """
    contour_object = model[0]
    barbed_end_object = model[1]
    # Each barbed-end "contour" is a single annotated point.
    barbed_end_list = [bcontour[0] for bcontour in barbed_end_object]
    updated_contour_object = []
    for contour in contour_object:
        # If the START point is closer to a barbed end than the END point,
        # flip the contour so the END points to the barbed end.
        if closest_to_point_list_3d(contour[0], contour[-1], barbed_end_list):
            contour.reverse()
        updated_contour_object.append(contour)
    return [updated_contour_object, barbed_end_object]


def determine_contour_angle_to_x_y_vector(contour, vector):
    """Signed angle (degrees, -180..+180) between the contour's overall
    direction (start-to-end XY vector) and the user-supplied reference
    vector. Uses atan2 to handle full 360° coverage."""
    contour_vector = (contour[-1][0] - contour[0][0],
                      contour[-1][1] - contour[0][1])
    return math.degrees(
        math.atan2(contour_vector[1], contour_vector[0])
        - math.atan2(vector[1], vector[0]))


# -- Binning ----------------------------------------------------------------

def split_object_according_to_angle_between_contour_and_given_vector(
        contour_object, vector, number_of_bins):
    """Sort filaments into `number_of_bins` equal-width angular bins.

    Each bin spans 360°/N degrees. Bin 0 is [0°, bin_width), bin 1 is
    [bin_width, 2*bin_width), etc., wrapping around to cover all 360°.
    """
    bin_width = 360 / number_of_bins
    sorted_contour_model = [[] for _ in range(number_of_bins)]
    for contour in contour_object:
        angle = determine_contour_angle_to_x_y_vector(contour, vector)
        # atan2 returns -180..+180; wrap to 0..360 so floor() lands in a bin.
        if angle < 0:
            angle = 360 + angle
        bin_index = math.floor(angle / bin_width)
        sorted_contour_model[bin_index].append(contour)
    return sorted_contour_model


def split_model_according_to_angle_between_contour_and_given_vector(
        model, vector, number_of_bins):
    """Apply binning to the contour object, keep barbed-end object as-is.

    Returns a new model where the first N entries are bin-objects (each
    containing the filaments whose orientation falls in that bin) and the
    last entry is the barbed-end annotation object (unchanged).
    """
    sorted_contour_model = (
        split_object_according_to_angle_between_contour_and_given_vector(
            model[0], vector, number_of_bins))
    sorted_contour_model.append(model[1])
    return sorted_contour_model


# -- Output -----------------------------------------------------------------

def model_to_file(model, output_name):
    """Write the binned model back to IMOD `.txt` format.

    Re-numbers objects from 1 (per IMOD convention) and re-numbers contours
    within each object starting from 1 as well.
    """
    output_string = ''
    object_number = 1
    contour_number = 1
    for current_object in model:
        if current_object:
            for contour in current_object:
                if contour:
                    for point in contour:
                        output_string += (
                            f'{object_number}\t{contour_number}'
                            f'\t{point[0]}\t{point[1]}\t{point[2]}\n')
                contour_number += 1
        object_number += 1
        contour_number = 1
    with open(output_name, "w") as txt_output:
        txt_output.write(output_string)


# -- Main pipeline ----------------------------------------------------------

# Step 1: parse the IMOD .txt model.
model_as_imported = file_to_model(input_file_name)

# Step 2: reorient each filament so its end-point is closest to an
# annotated barbed end (ensures consistent tail-to-head direction).
model_with_updated_contours = orient_contours_according_to_barbed_ends(
    model_as_imported)

# Step 3: sort filaments into angular bins relative to the reference vector.
model_with_updated_objects = (
    split_model_according_to_angle_between_contour_and_given_vector(
        model_with_updated_contours, vector_x_y, bin_number))

# Step 4: write the binned model to a new .txt for `point2model`.
model_to_file(model_with_updated_objects, output_file_name)

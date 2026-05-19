# `ImageJ_macros/edfig03/` — ED Fig 3 - ImageJ preprocessing macros

Fiji / ImageJ macros for **ED Fig 3 - ImageJ preprocessing macros**. Each macro preprocesses raw
imaging data into per-cell / per-neurite CSVs that the matching R Markdown
analysis in ``figures/`` consumes.

**16 macro file(s) in this folder.**

## Files

| File | Panel(s) | Role |
|------|----------|------|
| `edfig03_arp3ko_kif5c_d_drive_intensity.ijm` | ED Fig 3n; ED Fig 3o (Arp3 KO control) | ROI intensity CSV generation; upstream of ED Fig 3n; ED Fig 3o (Arp3 KO control). |
| `edfig03a_lut_change_utility.ijm` | ED Fig 3a (display) | LUT-swap display utility; no R consumer (orphan). |
| `edfig03a_rab11a_coloc_filtered.ijm` | ED Fig 3a | Filtered Rab11a colocalization preprocessing (Coloc2 / EZcoloc); upstream of ED Fig 3a. |
| `edfig03a_rab11a_ezcoloc_batch.ijm` | ED Fig 3a | EZColocalization batch (PCC / SRCC / ICQ / MCC / Costes coefficients); upstream of ED Fig 3a. |
| `edfig03a_rab11a_roi_save_helper.ijm` | (see header) | Minimal ROI Manager save helper for Rab11a colocalization workflow. |
| `edfig03a_rab11a_z_line_profile.ijm` | ED Fig 3a | Line-profile fluorescence extraction; upstream of ED Fig 3a. |
| `edfig03a_roi_image_save.ijm` | (see header) | ROI extraction + cropped-image save helper. |
| `edfig03a_roi_mask_generator.ijm` | (see header) | Image segmentation / mask generation. |
| `edfig03a_spot_tracker_utility.ijm` | ED Fig 3a (orphan) | Single-spot trajectory tracker utility (orphan; no R consumer). |
| `edfig03b_nested_actin_roi_batch.ijm` | ED Fig 3b | ROI intensity CSV generation; upstream of ED Fig 3b. |
| `edfig03m_kif5c_soma_z_intensity.ijm` | ED Fig 3m | Z-stack maximum-projection ROI intensity measurement; upstream of ED Fig 3m. |
| `edfig03q_kymo_extract_stub.ijm` | (see header) | Kymograph TIF generation from time-lapse stacks. |
| `edfig03q_nested_actin_kymo_gen__240227_kymo_5b8b17be.ijm` | ED Fig 3b/q | Kymograph TIF generation from time-lapse stacks; upstream of ED Fig 3b/q. |
| `edfig03q_nested_actin_kymo_gen__241025_analyzed_5f793d08.ijm` | ED Fig 3b/q | Kymograph TIF generation from time-lapse stacks; upstream of ED Fig 3b/q. |
| `edfig03q_nested_actin_roi_batch.ijm` | ED Fig 3q | ROI intensity CSV generation; upstream of ED Fig 3q. |
| `edfig03q_roi_image_save_v2.ijm` | (see header) | ROI region export + cropped-image save helper (S3q variant). |


# `ImageJ_macros/edfig02d/` — ED Fig 2d - ImageJ preprocessing macros

Fiji / ImageJ macros for **ED Fig 2d - ImageJ preprocessing macros**. Each macro preprocesses raw
imaging data into per-cell / per-neurite CSVs that the matching R Markdown
analysis in ``figures/`` consumes.

**6 macro file(s) in this folder.**

## Files

| File | Panel(s) | Role |
|------|----------|------|
| `edfig02d_channel_deinterleave.ijm` | (see header) | Channel split / deinterleave helper. |
| `edfig02d_div1_nested_actin_roi_batch.ijm` | ED Fig 2d (DIV1 221028) | ROI intensity CSV generation; upstream of ED Fig 2d (DIV1 221028). |
| `edfig02d_div2_wave_roi_batch.ijm` | ED Fig 2d (DIV2 201102) | Wave-growth ROI batch measurement (DIV-2 201102 batch); per-frame ROI mean-intensity CSV; upstream of ED Fig 2d. |
| `edfig02d_lifeact_kymo_batch_interactive.ijm` | ED Fig 2d | Kymograph TIF generation from time-lapse stacks; upstream of ED Fig 2d. |
| `edfig02d_lifeact_kymo_gen.ijm` | ED Fig 2d | Kymograph TIF generation from time-lapse stacks; upstream of ED Fig 2d. |
| `edfig02d_soma_z_intensity_221101.ijm` | ED Fig 2d | Z-stack maximum-projection ROI intensity measurement; upstream of ED Fig 2d. |


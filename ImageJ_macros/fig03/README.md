# `ImageJ_macros/fig03/` — Fig 3 - ImageJ preprocessing macros

Fiji / ImageJ macros for **Fig 3 - ImageJ preprocessing macros**. Each macro preprocesses raw
imaging data into per-cell / per-neurite CSVs that the matching R Markdown
analysis in ``figures/`` consumes.

**15 macro file(s) in this folder.**

## Files

| File | Panel(s) | Role |
|------|----------|------|
| `fig03jn_arp3ko_roi_template.ijm` | (see header) | ROI intensity CSV generation. |
| `fig03jn_parablebb_roi_template.ijm` | (see header) | ROI intensity CSV generation. |
| `fig03jn_parac1_channel_merge.ijm` | (see header) | Channel merge helper. |
| `fig03jn_parac1_roi_batch_measure.ijm` | Fig 3j-n + PARac1 cascade | ROI mean-intensity CSV (per-frame); upstream of Fig 3j-n + PARac1 cascade. |
| `fig03jn_z_profile_helper.ijm` | Fig 3 + ED Fig 7 | Z-stack maximum-projection ROI intensity measurement; upstream of Fig 3 + ED Fig 7. |
| `fig03or_dmso_length_measurement.ijm` | Fig 3o-r DMSO control | ROI intensity CSV generation; upstream of Fig 3o-r DMSO control. |
| `fig03or_perfusion_area_kymo_gen.ijm` | Fig 3r | Kymograph TIF generation from time-lapse stacks; upstream of Fig 3r. |
| `fig03or_perfusion_kymo_gen.ijm` | Fig 3r | Kymograph TIF generation from time-lapse stacks; upstream of Fig 3r. |
| `fig03or_perfusion_kymo_roi_intensity.ijm` | Fig 3r + ED Fig 4 | Kymograph TIF generation from time-lapse stacks; upstream of Fig 3r + ED Fig 4. |
| `fig03or_perfusion_wave_kymo_gen.ijm` | Fig 3r | Kymograph TIF generation from time-lapse stacks; upstream of Fig 3r. |
| `fig03or_perfusion_wave_roi_growth.ijm` | Fig 3r | ROI intensity CSV generation; upstream of Fig 3r. |
| `fig03or_perfusion_z_line_profile.ijm` | Fig 3r | Line-profile fluorescence extraction; upstream of Fig 3r. |
| `fig03or_roi_intensity_helper.ijm` | (see header) | ROI mean-intensity CSV (per-frame). |
| `fig03or_roi_length_measurement.ijm` | Fig 3o-r (orphan) | ROI mean-intensity CSV (per-frame); upstream of Fig 3o-r (orphan). |
| `fig03or_soma_z_intensity.ijm` | Fig 3r | Z-stack maximum-projection ROI intensity measurement; upstream of Fig 3r. |


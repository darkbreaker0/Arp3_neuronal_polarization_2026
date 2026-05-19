# `ImageJ_macros/fig05/` — Fig 5 - ImageJ preprocessing macros

Fiji / ImageJ macros for **Fig 5 - ImageJ preprocessing macros**. Each macro preprocesses raw
imaging data into per-cell / per-neurite CSVs that the matching R Markdown
analysis in ``figures/`` consumes.

**6 macro file(s) in this folder.**

## Files

| File | Panel(s) | Role |
|------|----------|------|
| `fig05a_taxol_composite_generator.ijm` | Fig 5a (orphan) | Taxol RGB composite-image generator (display only; orphan). |
| `fig05a_taxol_roi_template.ijm` | (see header) | ROI intensity CSV generation. |
| `fig05ab_taxol_noc_roi_batch.ijm` | Fig 5a/b | Taxol / Nocodazole ROI batch measurement; per-frame ROI mean-intensity CSV; upstream of Fig 5a/b. |
| `fig05i_roi_measure_legacy__analyzed_bcab55af.ijm` | (see header) | ROI mean-intensity CSV (per-frame). |
| `fig05i_roi_measure_legacy__czi_f6ede2dc.ijm` | (see header) | ROI mean-intensity CSV (per-frame). |
| `fig05il_blebbistatin_roi_measure.ijm` | Fig 5i + ED Fig 12a | ROI mean-intensity CSV (per-frame); upstream of Fig 5i + ED Fig 12a. |


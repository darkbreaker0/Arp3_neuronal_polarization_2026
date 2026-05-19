# `ImageJ_macros/fig04/` — Fig 4 - ImageJ preprocessing macros

Fiji / ImageJ macros for **Fig 4 - ImageJ preprocessing macros**. Each macro preprocesses raw
imaging data into per-cell / per-neurite CSVs that the matching R Markdown
analysis in ``figures/`` consumes.

**3 macro file(s) in this folder.**

## Files

| File | Panel(s) | Role |
|------|----------|------|
| `fig04m_immunostain_3channel_line_profile.ijm` | Fig 4m + ED Fig 6 | Line-profile fluorescence extraction; upstream of Fig 4m + ED Fig 6. |
| `fig04o_lyn_live_roi_batch.ijm` | Fig 4o | Lyn-live time-lapse ROI batch measurement; per-frame ROI mean-intensity CSV; upstream of Fig 4o. |
| `fig04o_lyn_live_roi_measure.ijm` | Fig 4o | ROI mean-intensity CSV (per-frame); upstream of Fig 4o. |


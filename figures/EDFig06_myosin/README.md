# `figures/EDFig06_myosin/` — ED Fig 6 (myosin)

R Markdown analyses for the published quantitative panels of **ED Fig 6 (myosin)**. Each `.Rmd` knits to one
manuscript panel (or panel group): reads the upstream CSV from
``ImageJ_macros/``, runs the stats / plotting, and writes the figure +
source-data files to ``outputs/`` (gitignored).

**7 analysis file(s) in this folder.**

## Files

| File | Panel(s) | Role |
|------|----------|------|
| `edfig06_arp3_mrlc_coloc_soma_stats.Rmd` | ED Fig 6 (soma) | Pearson/Costes colocalization; violin plot; feeds ED Fig 6 (soma). |
| `edfig06d_arp3_actin_mrlc_line_ccf_d_drive.Rmd` | ED Fig 6d | lag cross-correlation (alternative-cohort variant); CCF curve (mean +/- SD); feeds ED Fig 6d. |
| `edfig06d_soma_patch_line_profile_coloc.Rmd` | ED Fig 6d | Pearson/Costes colocalization; violin plot; feeds ED Fig 6d. |
| `edfig06e_mrlc_arp3_patch_lifetime_d_drive.Rmd` | ED Fig 6e | MRLC / Arp3 patch lifetime quantification (ComDet output), alternative-cohort variant; violin + boxplot; feeds ED Fig 6e. |
| `edfig06g_arp3_factin_airyscan_line_profile_coloc.Rmd` | ED Fig 6g | Pearson/Costes colocalization; violin plot; feeds ED Fig 6g. |
| `edfig06g_patch_profile_corr_canonical.Rmd` | ED Fig 6g | Soma-patch fluorescence line-profile correlation; violin plot; feeds ED Fig 6g. |
| `edfig06hl_arp3_mrlc_growth_xcorr_lsm.Rmd` | ED Fig 6h + ED Fig 6l | lag cross-correlation; CCF curve (mean +/- SD); feeds ED Fig 6h + ED Fig 6l. |


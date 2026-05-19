# `figures/Fig05_myosin/` — Fig 5 (myosin)

R Markdown analyses for the published quantitative panels of **Fig 5 (myosin)**. Each `.Rmd` knits to one
manuscript panel (or panel group): reads the upstream CSV from
``ImageJ_macros/``, runs the stats / plotting, and writes the figure +
source-data files to ``outputs/`` (gitignored).

**7 analysis file(s) in this folder.**

## Files

| File | Panel(s) | Role |
|------|----------|------|
| `fig05b_taxol_nocodazole_neurite_quantreg.R` | Fig 5b | quantile regression; violin plot; feeds Fig 5b. |
| `fig05bcd_morphology_taxol_noc_quant.Rmd` | Fig 5b + Fig 5c + Fig 5d | Morphology quantification of DMSO / Taxol / Nocodazole in WT + Arp3 KO; violin plot; feeds Fig 5b + Fig 5c + Fig 5d. |
| `fig05l_blebb_ko_neurite_xcorr.Rmd` | Fig 5l/m | lag cross-correlation; CCF curve (mean +/- SD); feeds Fig 5l/m. |
| `fig05l_blebb_wt_neurite_xcorr.Rmd` | Fig 5l/m | lag cross-correlation; CCF curve (mean +/- SD); feeds Fig 5l/m. |
| `fig05l_dmso_ko_neurite_xcorr.Rmd` | Fig 5l/m | lag cross-correlation; CCF curve (mean +/- SD); feeds Fig 5l/m. |
| `fig05l_dmso_wt_neurite_xcorr.Rmd` | Fig 5l/m | lag cross-correlation; CCF curve (mean +/- SD); feeds Fig 5l/m. |
| `fig05l_kymo_consolidate_master.Rmd` | Fig 5l | Per-neurite kymograph batch consolidator (length-vs-time per neurite class); stacked-area + line plot; upstream of all fig05l_*neurite_xcorr wrappers and feeds Fig 5l. |


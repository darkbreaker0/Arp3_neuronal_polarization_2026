# `figures/Fig01_coordination/` — Fig 1 (coordination)

R Markdown analyses for the published quantitative panels of **Fig 1 (coordination)**. Each `.Rmd` knits to one
manuscript panel (or panel group): reads the upstream CSV from
``ImageJ_macros/``, runs the stats / plotting, and writes the figure +
source-data files to ``outputs/`` (gitignored).

**2 analysis file(s) in this folder.**

## Files

| File | Panel(s) | Role |
|------|----------|------|
| `fig01ef_neurite_xcorr_culture_slice.Rmd` | Fig 1e/f/k/l + ED Fig 1 | Lag cross-correlation of neurite-tip velocity vs soma actin, culture + cortical-slice; CCF curve (mean +/- SD); feeds Fig 1e/f/k/l + ED Fig 1. |
| `fig01ikl_slice_wave_count_axonal_neurite_growth.Rmd` | Fig 1i + Fig 1k + Fig 1l | Multi-section wrapper: somatic actin wave count (Fig 1i, scatter + boxplot), axonal growth (Fig 1k) and total neurite growth (Fig 1l) for cortical-slice DIV-0 neurons. |


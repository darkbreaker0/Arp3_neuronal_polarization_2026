# `figures/EDFig01_coordination/` — ED Fig 1 (coordination)

R Markdown analyses for the published quantitative panels of **ED Fig 1 (coordination)**. Each `.Rmd` knits to one
manuscript panel (or panel group): reads the upstream CSV from
``ImageJ_macros/``, runs the stats / plotting, and writes the figure +
source-data files to ``outputs/`` (gitignored).

**2 analysis file(s) in this folder.**

## Files

| File | Panel(s) | Role |
|------|----------|------|
| `edfig01be_2d_culture_neurite_freq_and_xcorr_pooled.Rmd` | ED Fig 1b + Fig 1e | Pooled-replicate CCF of neurite-tip velocity vs soma actin (2D culture, 4 experiments); CCF curve (mean +/- SD); feeds ED Fig 1b + Fig 1e. |
| `edfig01c_fig01f_slice_neurite_freq_and_xcorr.Rmd` | ED Fig 1c + Fig 1f | Cortical-slice DIV-3 CCF of neurite-tip velocity vs soma actin (N=59); CCF curve (mean +/- SD); feeds ED Fig 1c + Fig 1f. |


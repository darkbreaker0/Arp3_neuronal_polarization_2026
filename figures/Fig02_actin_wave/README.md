# `figures/Fig02_actin_wave/` — Fig 2 (actin wave)

R Markdown analyses for the published quantitative panels of **Fig 2 (actin wave)**. Each `.Rmd` knits to one
manuscript panel (or panel group): reads the upstream CSV from
``ImageJ_macros/``, runs the stats / plotting, and writes the figure +
source-data files to ``outputs/`` (gitignored).

**8 analysis file(s) in this folder.**

## Files

| File | Panel(s) | Role |
|------|----------|------|
| `fig02c_neurite_actin_xcorr.Rmd` | Fig 2c | lag cross-correlation; CCF curve (mean +/- SD); feeds Fig 2c. |
| `fig02d_soma_actin_intensity_pre_wave.Rmd` | Fig 2d | Per-event somatic actin intensity at wave emergence vs baseline; violin + boxplot; feeds Fig 2d. |
| `fig02di_actin_wave_soma_ccf_d_drive.Rmd` | Fig 2d; Fig 2i; ED Fig 2a | lag cross-correlation (alternative-cohort variant); CCF curve (mean +/- SD); feeds Fig 2d; Fig 2i; ED Fig 2a. |
| `fig02e_neurite_actin_xcorr_culture.Rmd` | Fig 2e | lag cross-correlation; CCF curve (mean +/- SD); feeds Fig 2e. |
| `fig02hi_actin_wave_count_polarization.Rmd` | Fig 2h/i + ED Fig 2 | wave-event count/frequency; violin plot; feeds Fig 2h/i + ED Fig 2. |
| `fig02jk_neurite_actin_xcorr_polarized.Rmd` | Fig 2j/k | Polarized-neuron extension / retraction duration + velocity (with side-output CCF); violin + boxplot; feeds Fig 2j/k. |
| `fig02jkl_polarization_transition_d_drive.Rmd` | Fig 2j; Fig 2k; Fig 2l | Polarization-transition neurite dynamics (duration / velocity), alternative-cohort variant; violin + boxplot; feeds Fig 2j/k/l. |
| `fig02l_neurite_actin_xcorr_polarization_transition.Rmd` | Fig 2l | lag cross-correlation; CCF curve (mean +/- SD); feeds Fig 2l. |


# `figures/EDFig02_actin/` — ED Fig 2 (actin)

R Markdown analyses for the published quantitative panels of **ED Fig 2 (actin)**. Each `.Rmd` knits to one
manuscript panel (or panel group): reads the upstream CSV from
``ImageJ_macros/``, runs the stats / plotting, and writes the figure +
source-data files to ``outputs/`` (gitignored).

**6 analysis file(s) in this folder.**

## Files

| File | Panel(s) | Role |
|------|----------|------|
| `edfig02c_neurite_actin_xcorr_pooled_sd.Rmd` | ED Fig 2c | lag cross-correlation; CCF curve (mean +/- SD); feeds ED Fig 2c. |
| `edfig02ef_lyn_lifeact_neurite_xcorr.Rmd` | ED Fig 2e + ED Fig 2f | lag cross-correlation; CCF curve (mean +/- SD); feeds ED Fig 2e + ED Fig 2f. |
| `edfig02i_polarized_neurons_actin_wave_count.Rmd` | ED Fig 2i | wave-event count/frequency; violin plot; feeds ED Fig 2i. |
| `edfig02jk_polarized_neurons_duration_velocity.Rmd` | ED Fig 2j + ED Fig 2k | Extension / retraction duration + velocity comparison; violin + boxplot with jittered points; feeds ED Fig 2j + ED Fig 2k. |
| `edfig02jklm_polarized_neuron_dynamics_d_drive.Rmd` | ED Fig 2j; ED Fig 2k; ED Fig 2l; ED Fig 2m | Polarized-neuron actin dynamics (extension / retraction duration + velocity), alternative-cohort variant; violin + boxplot; feeds ED Fig 2j/k/l/m. |
| `edfig02lm_polarized_neurons_growth_actin_lyn_ccf.Rmd` | ED Fig 2l + ED Fig 2m | lag cross-correlation; CCF curve (mean +/- SD); feeds ED Fig 2l + ED Fig 2m. |


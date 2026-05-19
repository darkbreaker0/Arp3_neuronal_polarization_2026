# `figures/EDFig05_PARac1/` — ED Fig 5 (PARac1)

R Markdown analyses for the published quantitative panels of **ED Fig 5 (PARac1)**. Each `.Rmd` knits to one
manuscript panel (or panel group): reads the upstream CSV from
``ImageJ_macros/``, runs the stats / plotting, and writes the figure +
source-data files to ``outputs/`` (gitignored).

**3 analysis file(s) in this folder.**

## Files

| File | Panel(s) | Role |
|------|----------|------|
| `edfig05be_parac1_lamellipod_diff_intensity.Rmd` | ED Fig 5b, ED Fig 5e | PA-Rac1 lamellipodial differential intensity comparison; violin plot; feeds ED Fig 5b + ED Fig 5e. |
| `edfig05h_parac1_soma_lamellipod_intensity_timecourse.Rmd` | ED Fig 5h | Single-cell ROI intensity timecourse, soma vs lamellipodium during PA-Rac1 photoactivation; line plot of intensity vs time with activation-band shading; feeds ED Fig 5h. |
| `edfig05i_microperfusion_ck666_soma_length_dmso_control.Rmd` | ED Fig 5i (DMSO control side) | neurite length distribution analysis; violin plot; feeds ED Fig 5i (DMSO control side). |


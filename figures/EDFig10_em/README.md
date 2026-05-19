# `figures/EDFig10_em/` — ED Fig 10 (em)

R Markdown analyses for the published quantitative panels of **ED Fig 10 (em)**. Each `.Rmd` knits to one
manuscript panel (or panel group): reads the upstream CSV from
``ImageJ_macros/``, runs the stats / plotting, and writes the figure +
source-data files to ``outputs/`` (gitignored).

**4 analysis file(s) in this folder.**

## Files

| File | Panel(s) | Role |
|------|----------|------|
| `color_model_batch.py` | ED Fig 10 | Actin-filament orientation binning helper (third-party EM workflow); upstream of edfig10e_actin_filament_orientation_distribution.Rmd; feeds ED Fig 10. |
| `color_model.py` | ED Fig 10 | Actin-filament orientation binning helper (third-party EM workflow); upstream of edfig10e_actin_filament_orientation_distribution.Rmd; feeds ED Fig 10. |
| `edfig10e_actin_filament_orientation_distribution.Rmd` | ED Fig 10e | Actin-filament orientation distribution (histogram + density per cryo-tomogram); polar / rose density plot; feeds ED Fig 10e. |
| `object_mod.py` | ED Fig 10 | Filament-orientation binning + Newton-disc coloring helper (third-party EM workflow); upstream of edfig10e_actin_filament_orientation_distribution.Rmd. |


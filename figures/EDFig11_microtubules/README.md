# `figures/EDFig11_microtubules/` — ED Fig 11 (microtubules)

R Markdown analyses for the published quantitative panels of **ED Fig 11 (microtubules)**. Each `.Rmd` knits to one
manuscript panel (or panel group): reads the upstream CSV from
``ImageJ_macros/``, runs the stats / plotting, and writes the figure +
source-data files to ``outputs/`` (gitignored).

**7 analysis file(s) in this folder.**

## Files

| File | Panel(s) | Role |
|------|----------|------|
| `edfig11df_eb3_div2_ck666_raw_d_drive.Rmd` | ED Fig 11d; ED Fig 11e; ED Fig 11f | EB3 microtubule plus-end dynamics (velocity / intensity / lifetime), DIV-2 CK-666 raw-imaging cohort; violin + boxplot; feeds ED Fig 11d/e/f. |
| `edfig11df_eb3_div2_decon_cropped_d_drive.Rmd` | ED Fig 11d; ED Fig 11e; ED Fig 11f | EB3 microtubule plus-end dynamics (velocity / intensity / lifetime), DIV-2 deconvolved + cropped cohort; violin + boxplot; feeds ED Fig 11d/e/f. |
| `edfig11df_eb3_div3_ck666_decon_d_drive.Rmd` | ED Fig 11d; ED Fig 11e; ED Fig 11f | EB3 microtubule plus-end dynamics (velocity / intensity / lifetime), DIV-3 CK-666 deconvolved cohort; violin + boxplot; feeds ED Fig 11d/e/f. |
| `edfig11df_eb3_div4_ck666_raw_d_drive.Rmd` | ED Fig 11d; ED Fig 11e; ED Fig 11f | EB3 microtubule plus-end dynamics (velocity / intensity / lifetime), DIV-4 CK-666 raw-imaging cohort; violin + boxplot; feeds ED Fig 11d/e/f. |
| `edfig11f_eb3_tip_integrated_intensity.Rmd` | ED Fig 11f | EB3 integrated tip intensity per neurite; violin + boxplot; feeds ED Fig 11f. |
| `edfig11g_axon_retraction_loglinear.Rmd` | Fig 5f/g + ED Fig 11g | Axon-retraction frequency analysis across DIV stages and treatments; bar chart; feeds Fig 5f/g + ED Fig 11g. |
| `edfig11i_soma_eb3_intensity_timecourse.Rmd` | ED Fig 11i | Somatic EB3 intensity Pre / Act / Post photoactivation; violin + boxplot; feeds ED Fig 11i. |


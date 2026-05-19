# `figures/Fig03_Arp3/` — Fig 3 (Arp3)

R Markdown analyses for the published quantitative panels of **Fig 3 (Arp3)**. Each `.Rmd` knits to one
manuscript panel (or panel group): reads the upstream CSV from
``ImageJ_macros/``, runs the stats / plotting, and writes the figure +
source-data files to ``outputs/`` (gitignored).

**6 analysis file(s) in this folder.**

## Files

| File | Panel(s) | Role |
|------|----------|------|
| `fig03i_axon_retraction_by_div_t_test.Rmd` | Fig 3i + ED Fig 4 | t-test on axon-retraction proportions; violin plot; feeds Fig 3i + ED Fig 4. |
| `fig03n_parac1_arp3ko_pre_act_post_precursor.Rmd` | Fig 3n + ED Fig 5b | STAGE-1 precursor: event-aligned ROI intensity timecourse (Pre / Act / Post) for PA-Rac1 + Arp3 KO; feeds the fig03n consolidator (Fig 3n + ED Fig 5b). |
| `fig03n_parac1_c450m_pre_act_post_precursor.Rmd` | Fig 3n + ED Fig 5b | STAGE-1 precursor: event-aligned ROI intensity timecourse (Pre / Act / Post) for PA-Rac1 C450M control; feeds the fig03n consolidator (Fig 3n + ED Fig 5b). |
| `fig03n_parac1_gc_soma_length.Rmd` | Fig 3n | neurite length distribution analysis; violin plot; feeds Fig 3n. |
| `fig03n_parac1_t17n_pre_act_post_precursor.Rmd` | Fig 3n + ED Fig 5b | STAGE-1 precursor: event-aligned ROI intensity timecourse (Pre / Act / Post) for PA-Rac1 T17N control; feeds the fig03n consolidator (Fig 3n + ED Fig 5b). |
| `fig03r_microperfusion_actin_response.Rmd` | Fig 3r + ED Fig 4/5/7 | Microperfusion actin / GFP response timecourse (Pre / Act / Post intensity); line plot of intensity vs time with activation-band shading + violin / boxplot summary; feeds Fig 3r + ED Fig 4/5/7. |


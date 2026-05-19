# `figures/EDFig03_Arp3/` — ED Fig 3 (Arp3)

R Markdown analyses for the published quantitative panels of **ED Fig 3 (Arp3)**. Each `.Rmd` knits to one
manuscript panel (or panel group): reads the upstream CSV from
``ImageJ_macros/``, runs the stats / plotting, and writes the figure +
source-data files to ``outputs/`` (gitignored).

**11 analysis file(s) in this folder.**

## Files

| File | Panel(s) | Role |
|------|----------|------|
| `edfig03b_factin_rab11a_line_profile_coloc.Rmd` | ED Fig 3b | Pearson/Costes colocalization; violin plot; feeds ED Fig 3b. |
| `edfig03b_rab11_arp3_actin_coloc_consolidator.Rmd` | ED Fig 3b | Pearson/Costes colocalization; violin plot; feeds ED Fig 3b. |
| `edfig03b_rab11a_actin_line_ccf_d_drive.Rmd` | ED Fig 3b | lag cross-correlation (alternative-cohort variant); CCF curve (mean +/- SD); feeds ED Fig 3b. |
| `edfig03ef_arp3_patch_diffusion_lifetime.Rmd` | ED Fig 3e, ED Fig 3f | Per-patch trajectory moving velocity + lifetime from TrackMate MSD CSVs; violin + boxplot; feeds ED Fig 3e + ED Fig 3f. |
| `edfig03ef_arp3_patch_velocity_lifetime_d_drive.Rmd` | ED Fig 3e; ED Fig 3f | Arp3 patch velocity + lifetime (ComDet output), alternative-cohort variant; violin + boxplot; feeds ED Fig 3e/f. |
| `edfig03m_kif5c_neurite_corr.Rmd` | ED Fig 3m | Lag cross-correlation of KIF5C vs LifeAct; CCF curve with mean +/- SD ribbon; feeds ED Fig 3m. |
| `edfig03n_kif5c_parent_neurite_corr.Rmd` | ED Fig 3n | lag cross-correlation; violin plot; feeds ED Fig 3n. |
| `edfig03no_kif5c_arp3ko_velocity_ccf_d_drive.Rmd` | ED Fig 3n; ED Fig 3o (Arp3 KO control) | lag cross-correlation (alternative-cohort variant); CCF curve (mean +/- SD); feeds ED Fig 3n; ED Fig 3o (Arp3 KO control). |
| `edfig03no_kif5c_wt_velocity_ccf_d_drive.Rmd` | ED Fig 3n; ED Fig 3o | lag cross-correlation (alternative-cohort variant); CCF curve (mean +/- SD); feeds ED Fig 3n; ED Fig 3o. |
| `edfig03q_actin_radial_flow_kymo.Rmd` | ED Fig 3q | Kymograph-derived actin radial-flow velocity; violin + boxplot; feeds ED Fig 3q. |
| `edfig03q_actin_radial_flow_wilcoxon.Rmd` | ED Fig 3q | Actin radial-flow velocity comparison; violin + boxplot; feeds ED Fig 3q. |


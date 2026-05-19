# `figures/Fig04_Arp3KO/` — Fig 4 (Arp3KO)

R Markdown analyses for the published quantitative panels of **Fig 4 (Arp3KO)**. Each `.Rmd` knits to one
manuscript panel (or panel group): reads the upstream CSV from
``ImageJ_macros/``, runs the stats / plotting, and writes the figure +
source-data files to ``outputs/`` (gitignored).

**9 analysis file(s) in this folder.**

## Files

| File | Panel(s) | Role |
|------|----------|------|
| `fig04f_cortical_section_tau_density.Rmd` | Fig 4f | Tau-density spatial profile across cortical-section distance, WT vs Arp3 KO; line plot of mean Tau intensity with mean +/- SD ribbon; feeds Fig 4f. |
| `fig04fh_arp3_genotype_neurite_quantreg.R` | Fig 4f/h | quantile regression; violin plot; feeds Fig 4f/h. |
| `fig04m_actin_line_profile_ko.Rmd` | Fig 4m KO | Phalloidin / NMIIb fluorescence line-profile across neurite, Arp3 KO actin-focus variant; line plot with mean +/- SD ribbon; feeds Fig 4m (KO). |
| `fig04m_actin_line_profile_wt.Rmd` | Fig 4m WT | Phalloidin / NMIIb fluorescence line-profile across neurite, WT actin-focus variant; line plot with mean +/- SD ribbon; feeds Fig 4m (WT). |
| `fig04m_nmiib_actin_line_profile_ko.Rmd` | Fig 4m (KO side) | Phalloidin / NMIIb fluorescence line-profile across neurite, Arp3 KO NMIIb-focus variant; line plot with mean +/- SD ribbon; feeds Fig 4m (KO). |
| `fig04m_nmiib_actin_line_profile_wt.Rmd` | Fig 4m (WT side) | Phalloidin / NMIIb fluorescence line-profile across neurite, WT NMIIb-focus variant; line plot with mean +/- SD ribbon; feeds Fig 4m (WT). |
| `fig04o_lyn_live_neurite_xcorr_ko.Rmd` | Fig 4o KO + ED Fig 9e | lag cross-correlation; CCF curve (mean +/- SD); feeds Fig 4o KO + ED Fig 9e. |
| `fig04o_lyn_live_neurite_xcorr_wt.Rmd` | Fig 4o WT | lag cross-correlation; CCF curve (mean +/- SD); feeds Fig 4o WT. |
| `fig04p_brightfield_neurite_xcorr.Rmd` | Fig 4p | lag cross-correlation; CCF curve (mean +/- SD); feeds Fig 4p. |


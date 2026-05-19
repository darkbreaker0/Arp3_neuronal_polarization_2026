# Arp3 neuronal polarization — analysis code

Code accompanying *Lin et al., **"An intrinsic cytoskeletal oscillator
establishes neuronal polarity"***.

This GitHub repository is the **active-development mirror** of the code
component of a Zenodo deposit. For the full archive — Source Data
spreadsheets, raw representative micrographs, the `IJ_NeuriteGrowthScript`
Fiji plugin + demo dataset, mouse-line / probe / ethics / imaging-setup
metadata, and supporting docs — see the Zenodo deposit:

> **Zenodo DOI:** [10.5281/zenodo.20118606](https://doi.org/10.5281/zenodo.20118606)

## What's here

| Directory | Contents |
|---|---|
| [`figures/`](figures/) | R Markdown analyses for every published quantitative panel (Fig 1–5 + ED Fig 1–12). One subfolder per figure. |
| [`templates/`](templates/) | Canonical parameterized R Markdown templates that several figure-specific wrappers include via knitr child-document inclusion. |
| [`helpers/`](helpers/) | Small R utilities (file sorting, encoding helpers). |
| [`ImageJ_macros/`](ImageJ_macros/) | Fiji/ImageJ macros (`.ijm`) and Jython scripts (`.py`) that preprocess raw imaging data into the CSVs that R consumes. Includes `_shared/Proc.py` — the upstream kymograph post-processor. |

## Requirements

| Tool | Version |
|---|---|
| **R** | 4.0.2 |
| **R packages** | `tidyverse, data.table, forecast, vcd, MASS, ggpubr, rstatix, pheatmap, quantreg, circular, peakPick, pracma, quantmod, ggpmisc, magrittr, ggfortify, tsibble, broom, tidyquant, tsbox, RColorBrewer, viridis, hrbrthemes, ggmosaic, readxl, fs` |
| **Fiji / ImageJ** | ≥ 1.53 with the `EZColocalization`, `Multi Kymograph`, `KymoResliceWide`, and `ComDet` plugins |

## License and authorship

This code is released under the **MIT License** — see [`LICENSE`](LICENSE).

In summary (full breakdown in [`CONTRIBUTORS.md`](CONTRIBUTORS.md)):

- **R / R Markdown analyses** in `figures/`, `templates/`, `helpers/` — Tien-Chen Lin.
- **50 ImageJ macros** in `ImageJ_macros/` — Tien-Chen Lin.
- **8 kymograph-workflow macros** in `ImageJ_macros/` (`Multi Kymograph` / `KymoResliceWide` + `Proc.py` based) — joint contribution by Tien-Chen Lin, Christoph Möhl, and Mansoureh Aghabeig.
- **EM Python helpers** in `figures/EDFig10_em/` (`color_model.py`, `color_model_batch.py`, `object_mod.py`) — Florian Fassler (third-party, MIT-licensed).

The upstream `IJ_NeuriteGrowthScript` Fiji plugin (created by Tien-Chen
Lin on top of the underlying `Multi Kymograph` + `Proc.py` workflow by
Möhl + Aghabeig) is **not bundled in this mirror** but is published in
the Zenodo deposit and at
<https://github.com/darkbreaker0/IJ_NeuriteGrowthScript>.

The third-party EM MATLAB filament-tracking pipeline and TOM Toolbox
utilities are **not redistributed** via this mirror; obtain them from
the Bradke lab and the Baumeister group (MPI-Biochemistry) respectively.

## Citation

Please cite both the manuscript and the Zenodo deposit. A
machine-readable citation record is at [`CITATION.cff`](CITATION.cff).

## Related identifiers

- Manuscript DOI: *TBD on acceptance*
- Zenodo deposit (this repo is the code subfolder of that deposit): [10.5281/zenodo.20118606](https://doi.org/10.5281/zenodo.20118606)
- `IJ_NeuriteGrowthScript` Fiji plugin GitHub (separate repo): <https://github.com/darkbreaker0/IJ_NeuriteGrowthScript>

## Contact

| Role | Person | Email |
|---|---|---|
| Corresponding author | Frank Bradke (DZNE Bonn) | `frank.bradke@dzne.de` |
| First author / code contact | Tien-Chen Lin (DZNE Bonn) | `tien-chen.lin@dzne.de` |

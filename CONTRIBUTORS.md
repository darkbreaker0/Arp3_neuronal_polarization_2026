# Contributors

This file lists everyone whose code is included in the repository, organized
by what they wrote. Each contributor has consented to MIT-licensed
redistribution of their contribution.

## R / R Markdown analysis (`figures/`, `templates/`, `helpers/`)

- **Tien-Chen Lin** and the manuscript co-authors (Bradke lab, DZNE).

The exact authorship of individual `.Rmd` files cannot be reconstructed from
the script bodies alone (no per-file authorship comments exist). Lab members
who wrote analyses include those listed in the manuscript's author list. If a
specific attribution is needed for a single file, see the file's git history
once the repo is published.

## Fiji / ImageJ macros (`ImageJ_macros/`)

### Lin-only authored (50 macros)

The Fiji / ImageJ macros for ROI batch measurement, line/Z-profile
extraction, composite generation, and protein-intensity quantification
were written by:

- **Tien-Chen Lin** (Bradke lab, DZNE)

This covers the `*_roi_batch.ijm`, `*_roi_template.ijm`, `*_roi_measure.ijm`
(except `fig04o_lyn_live_roi_measure.ijm`, see below), `*_intensity*.ijm`,
`*_line_profile.ijm`, `*_composite_generator.ijm`, and `*_z_intensity*.ijm`
families used across all four pipeline cascades below.

### Joint Lin + Möhl + Aghabeig (8 kymograph-family macros)

The following macros wire together the Bradke-lab kymograph workflow —
`run("Multi Kymograph", ...)` / `run("KymoResliceWide", ...)` + the
`Proc.py` Jython post-processor at `~/Nextcloud/Neurite activities/`. The
kymograph plugin and `Proc.py` were co-developed by **Christoph Möhl**
(Bradke lab, DZNE) and **Mansoureh Aghabeig** (Image and Data Analysis
Facility, DZNE); the wrapper macros that drive them in batch were
extended/integrated by **Tien-Chen Lin** for the published panels:

- `ImageJ_macros/edfig02d/edfig02d_lifeact_kymo_batch_interactive.ijm`
- `ImageJ_macros/edfig02d/edfig02d_lifeact_kymo_gen.ijm`
- `ImageJ_macros/edfig03/edfig03q_nested_actin_kymo_gen__240227_kymo_5b8b17be.ijm`
- `ImageJ_macros/edfig03/edfig03q_nested_actin_kymo_gen__241025_analyzed_5f793d08.ijm`
- `ImageJ_macros/fig03/fig03or_perfusion_kymo_gen.ijm`
- `ImageJ_macros/fig03/fig03or_perfusion_wave_kymo_gen.ijm`
- `ImageJ_macros/fig03/fig03or_perfusion_area_kymo_gen.ijm`
- `ImageJ_macros/fig04/fig04o_lyn_live_roi_measure.ijm`

All macros are MIT-licensed.

### Upstream Fiji plugin used (not bundled in this repo): `IJ_NeuriteGrowth`

The neurite-length CSVs that several of the `figures/**/*.Rmd` analyses
consume were produced upstream by **`IJ_NeuriteGrowth`** — a separate
Bradke-lab Fiji plugin **created by Tien-Chen Lin** (Bradke lab, DZNE).

`IJ_NeuriteGrowth` builds on (i.e. wraps and extends) the underlying
**`Multi Kymograph` / `KymoResliceWide` + `Proc.py` workflow** that was
developed by **Christoph Möhl** (Bradke lab, DZNE) and **Mansoureh
Aghabeig** (Image and Data Analysis Facility, DZNE). When `IJ_NeuriteGrowth`
runs, the kymograph generation step is performed by the Möhl/Aghabeig
`Multi Kymograph` plugin and the kymograph-to-CSV conversion is performed
by their `Proc.py` Jython script.

So the credit chain is:

- **Lin** authored `IJ_NeuriteGrowth` (the user-facing plugin / orchestrator).
- **Möhl + Aghabeig** authored the upstream `Multi Kymograph` /
  `KymoResliceWide` plugin and the `Proc.py` post-processor that
  `IJ_NeuriteGrowth` invokes.

`IJ_NeuriteGrowth` is **not part of this repository** — it is a separate
tool that runs in Fiji to produce the per-neurite length time-series CSVs
that the downstream R Markdown analyses ingest. The attribution chain is
acknowledged here so users who want to reproduce the upstream image-
analysis step know who wrote which layer. See the Bradke-lab Fiji plugin
distribution for the tool itself.

### Pipeline cascades that the macros feed

The 58 `.ijm` macros and 6 `.py` Jython scripts in `ImageJ_macros/` are
organised into four preprocessing cascades, each ending in a CSV that an
R Markdown wrapper in `figures/` consumes. The arrows below use the
current repo filenames; the original `G:\` filenames are recorded inside
each macro's auto-injected header.

- **Fig 2 / ED Fig 2 (Lifeact actin):** `edfig02d_lifeact_kymo_gen.ijm` →
  `edfig02d_lifeact_kymo_batch_interactive.ijm` (with `_shared/Proc.py`)
  → R cross-correlation.
- **Fig 3o-r (microperfusion):** `fig03or_perfusion_kymo_gen.ijm` +
  `fig03or_perfusion_wave_kymo_gen.ijm` + `fig03or_perfusion_area_kymo_gen.ijm`
  → `fig03or_perfusion_kymo_roi_intensity.ijm` (with `_shared/Proc.py`)
  → R Wilcoxon / xcorr.
- **Fig 3j-n (PA-Rac1):** `fig03jn_parac1_roi_batch_measure.ijm` →
  R Wilcoxon.
- **ED Fig 5e (PA-Rac1 ND2):** `edfig05e_nd2_hyperstack_reorder_batch_interactive.ijm`
  → downstream ROI batch measurement → R intensity analysis.

Four macros are **interactive** and cannot be run headlessly (they call
`waitForUser` or `getNumber` and need per-image user input):

- `ImageJ_macros/edfig02d/edfig02d_lifeact_kymo_batch_interactive.ijm`
  (`waitForUser` — set threshold per kymograph)
- `ImageJ_macros/edfig05/edfig05e_nd2_hyperstack_reorder_batch_interactive.ijm`
  (`getNumber` — Z-slices per ND2 stack)
- `ImageJ_macros/fig04/fig04o_lyn_live_roi_measure.ijm` (`waitForUser`)
- `ImageJ_macros/fig03/fig03or_perfusion_area_kymo_gen.ijm` (`waitForUser`)

## EM filament analysis (`figures/EDFig10_em/`)

This directory contains code for the actin-filament-tracking analysis used in
ED Fig 10 (specifically ED Fig 10e — the 12-bin angular distribution of
actin filaments relative to a reference vector). After file-by-file review
on 2026-05-08 the publication scope is:

### Published, attributed to **Florian Fassler**:

- `color_model.py` — single-file actin filament orientation binning
- `color_model_batch.py` — batch wrapper around `color_model.py`
- `object_mod.py` — batch + Newton-disc color generation + 3D line thickness

These three files implement the angular-bin analysis that produces ED Fig 10e.
Each file has a module docstring, per-function comments, and dead code
removed. They are tracked in git as MIT-licensed, attributed to Florian
Fassler.


### R Markdown wrapper (published)

`edfig10e_actin_filament_orientation_distribution.Rmd` is the R Markdown
wrapper that documents how the actin-filament-tracking analysis was
structured. It remains in the repo as a documentation entry even though
the underlying MATLAB pipeline is not redistributed here.

## How to update this file

If you modify the repo and add new code:

1. Add yourself to the relevant section above.
2. Confirm in your commit message that you grant MIT-licensed redistribution
   of the new file.
3. If you remove someone's code, leave their entry intact with a note about
   when and why their contribution was removed.


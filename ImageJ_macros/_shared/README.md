# `ImageJ_macros/_shared/` — cross-cutting helper scripts

Files in this folder are **shared dependencies** used by multiple
macros in sibling subfolders.

## Files

| File | Used by | Role |
|------|---------|------|
| `Proc.py` | The 8 kymograph-family `.ijm` macros (see `../README.md`) | Jython post-processor for kymograph macros: converts thresholded kymograph TIF to per-timepoint Start/Tip/Integrated-intensity CSV; upstream of all kymo_gen .ijm wrappers. |

## How the macros find `Proc.py`

Each calling macro hard-codes the host path:

```ijm
macro_dir = getDirectory("home") + "Nextcloud\\Neurite activities\\";
runMacro(macro_dir + "Proc.py", arglst);
```

If you are reproducing these panels outside the original author's
environment, EITHER copy `Proc.py` to `~/Nextcloud/Neurite activities/`
on your machine, OR edit `macro_dir` in each kymograph macro to point at
this folder (`ImageJ_macros/_shared/`).

## Authorship

`Proc.py` was authored by **Christoph Möhl** and **Mansoureh Aghabeig**
as part of the Bradke-lab kymograph workflow. **Tien-Chen Lin**
integrated it into the 8 kymograph-family `.ijm` macros listed above and
also created the upstream `IJ_NeuriteGrowth` Fiji plugin (not in this
repo) that wraps the same `Multi Kymograph` + `Proc.py` workflow into a
user-facing neurite-tracing tool. See `../../CONTRIBUTORS.md` for the
full attribution chain.

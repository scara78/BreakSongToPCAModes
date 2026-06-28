# AI_RULES.md — GN‑v7 Fast Raw Mode Extractor

## Tech Stack

- **Language**: Python 3.x
- **UI Framework**: [Gradio](https://gradio.app/) — all UI is built with `gr.Blocks`, `gr.Row`, `gr.Column`, and Gradio components (Audio, Slider, Button, File, Markdown). Do NOT introduce React, Vue, or any JS frontend.
- **Audio I/O**: `soundfile` (`sf.read` / `sf.write`) for reading/writing WAV and other formats.
- **Signal Processing**: `scipy.signal` — use for resampling (`resample_poly`) and any filtering needs.
- **Numerical Computing**: `numpy` — all array math, normalization, and linear algebra helpers.
- **Dimensionality Reduction / SVD**: `sklearn.utils.extmath.randomized_svd` for fast truncated SVD. Do NOT add heavy ML frameworks (PyTorch, TensorFlow) unless explicitly requested.
- **Packaging / Output**: `zipfile` + `tempfile` — bundle output WAVs into a ZIP for download.
- **Entry Point**: `app.py` — single-file app; keep it that way unless complexity demands splitting.
- **Deployment**: Launched via `demo.launch()` (Gradio server). No additional web server needed.

## Library Rules

| Need | Use | Avoid |
|---|---|---|
| UI components | `gradio` (`gr.*`) | Any JS framework |
| Audio read/write | `soundfile` | `librosa`, `torchaudio` |
| Resampling / filtering | `scipy.signal` | Custom implementations |
| Matrix math | `numpy` | `torch`, `tensorflow` |
| SVD / PCA | `sklearn.utils.extmath.randomized_svd` | Full `np.linalg.svd` on large matrices |
| Temp files | `tempfile`, `os` | Hardcoded paths |

## Conventions

- Keep all logic in `app.py` unless a helper module is clearly warranted.
- Raise `gr.Error(...)` for user-facing errors; use `gr.Info(...)` for status messages.
- Always mono-mix stereo input (`np.mean(sig, axis=1)`) before processing.
- Resample to **16 kHz** at ingest for speed/consistency.
- Normalize audio to peak amplitude before any spectral decomposition.

# XLibre Xserver → V Language Translation

This repository contains a helper script, [`xlibre-v-converter.sh`](./xlibre-v-converter.sh), for **batch‑translating** the [XLibre Xserver](https://github.com/your-org/xlibre-xserver) C source tree into [V language](https://vlang.io/) source files.

It is designed for **safe, reproducible** translation runs:

- Preserves the original directory structure in the output folder  
- Avoids accidental `/home/...` nesting bugs  
- Creates `.err` logs for any file that fails to translate  
- Safe to re‑run without breaking existing output  

---

## 📦 Requirements

Before running the script, ensure you have:

- **V compiler** with `translate c` support  
  [Install instructions](https://github.com/vlang/v#installing-v)
- **Bash** (tested on GNU Bash 5.x)
- **GNU coreutils** (`realpath`, `mkdir`, `cp`, etc.)
- **findutils** (`find` with `-printf` support)
- **Sufficient disk space** for both the original C source and translated `.v` files

---

##  Usage

```
./xlibre-v-converter.sh /path/to/v /path/to/xlibre /path/to/output
```

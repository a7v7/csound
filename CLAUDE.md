# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a historical archive of Csound instruments and examples from the 1990s-2000s. The repository contains ~900+ orchestra (.orc) and score (.sco) files distributed across multiple collections from various composers and researchers. This is an archival project to preserve historical Csound materials that are difficult to find online.

**Important**: These are historical materials distributed on CD-ROMs. The repository owner did not create this content and is preserving it for educational purposes under MIT license.

## Repository Structure

The repository is organized into distinct collections, each in its own directory:

- **Gather Amsterdam Catalog** - ACCCI (Amsterdam Catalogue of Csound Computer Instruments) v1.1 by J.-P. Gather (1995), includes all of Jean-Claude Risset's 25 Bell Lab Catalogue instruments plus ~75 other instruments
- **Risset Catalog** - Jean-Claude Risset's classic Bell Lab instruments
- **Cook Collection** - Various synthesis techniques and effects by Steven Cook, including a detailed VCS3/Synthi A emulator
- **Comanjuncosas Collection** - Instruments by Josep M Comajuncosas, including TB-303 emulators and other classic synth emulations
- **Dodge_Jerse ComputerMusicBook** - Examples from the Dodge & Jerse "Computer Music" textbook
- **Harrington-DX7** - DX7 FM synthesis examples (dx701.orc/sco through dx732.orc/sco)
- **Internet Collections** - Organized by contributor (Arnott, Bezko, Brandt, CDP, Cascone, etc.)
- **Lyon Collection** - Reverb and effects examples
- **Mikelson Collection** - Various instruments including TB-303 emulator
- **Psychoacoustic** collections (Pavan_Noorden, Sumy_Rossing) - Psychoacoustic demonstrations
- **Smaragdis Collection** - Various synthesis examples
- **Varga-Collection** - Instruments by Istvan Varga
- **Varo_PinkstonDX Collection** - DX-style FM synthesis examples

## Csound File Structure

Csound instruments use two files:

- **Orchestra file (.orc or .ORC)** - Defines the synthesis engine, instruments, and signal processing
  - Header section: sample rate (sr), control rate (kr), samples per control period (ksmps), number of channels (nchnls)
  - Instrument definitions: `instr N` blocks containing synthesis code
  - Variables: i-rate (initialization), k-rate (control), a-rate (audio)

- **Score file (.sco or .SCO)** - Contains performance data
  - Function tables (f statements) - waveforms, envelopes, sequences
  - Note events (i statements) - instrument number, start time, duration, parameters
  - Tempo (t statement), comments, etc.

## Running Csound Files

To render a Csound instrument to audio:

```bash
csound orchestrafile.orc scorefile.sco
```

To specify output format and file:
```bash
csound -o output.wav orchestrafile.orc scorefile.sco
```

For realtime audio:
```bash
csound -odac orchestrafile.orc scorefile.sco
```

Common flags:
- `-o filename` - output file
- `-odac` - realtime audio output
- `-W` - WAV format output
- `-3` - 24-bit samples
- `-d` - suppress displays
- `--sample-rate=44100` - set sample rate

## File Naming Conventions

- Many files use DOS 8.3 naming (uppercase .ORC/.SCO extensions)
- Paired files share the same base name (e.g., `303a.orc` + `303a.sco`)
- Some collections use numerical prefixes (e.g., `01_01_1.orc`, `dx701.orc`)
- A few include auxiliary C files (.c) for custom opcodes or utilities

## Important Notes for Code Modification

1. **Historical preservation**: Files should generally remain unmodified to preserve historical accuracy. If updating for modern Csound, create separate versions.

2. **Csound version compatibility**: These instruments were written for Csound 3.x/4.x era. Modern Csound (6.x/7.x) may require updates:
   - Some opcodes have been deprecated or renamed
   - Global variables now use `gi`, `gk`, `ga` prefixes
   - Function table syntax may need adjustment
   - Sample rate and control rate handling differs

3. **Character encoding**: Some files contain special characters (degree symbols, accented characters) from 1990s encodings that may display incorrectly.

4. **Repository goal**: The owner plans to create a separate repository for modernized versions compatible with Csound 6.18+ and Csound 7.

## Key Collections Details

**Amsterdam Catalog (ACCCI)**: Systematically organized by synthesis technique with emphasis on documentation and transparency. Includes flowcharts and discussions (originally in .eps format).

**Cook VCS3 Emulator**: Detailed emulation of EMS VCS3/Synthi A modular synthesizer with patch matrix system. Includes three joystick emulation modes.

**Risset Bell Lab Catalog**: Classic foundational instruments demonstrating various synthesis techniques from the birth of computer music.

**Dodge & Jerse Examples**: Companion code to the seminal "Computer Music" textbook, numbered by figure/chapter.

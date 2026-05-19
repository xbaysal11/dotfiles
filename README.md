# Ultimate Dev Terminal Setup for Windows

> Zsh + Oh My Zsh inside Git Bash via Tabby Terminal — no WSL required.

---

## Prerequisites

| # | Tool | Purpose |
|---|------|---------|
| 1 | [Git for Windows](https://git-scm.com/download/win) | Git Bash baseline |
| 2 | [Fira Code](https://github.com/tonsky/FiraCode/releases) | Monospace font with ligatures |
| 3 | [Tabby Terminal](https://github.com/Eugeny/tabby/releases) | Modern terminal emulator |
| 4 | Zsh Binaries (MSYS2) | Injected into Git Bash |
| 5 | Oh My Zsh + Plugins | Shell framework & enhancements |
| 6 | [nvm-windows](https://github.com/coreybutler/nvm-windows/releases) | Node version manager for Windows |
| 7 | Node.js (via nvm) | JavaScript runtime |
| 8 | [Cursor](https://www.cursor.com) | AI-powered code editor |

---

## Installation

### 1. Git for Windows

1. Download and install from [git-scm.com](https://git-scm.com/download/win).
2. During setup, select **"Use Git from the Windows Command Prompt"**.
3. Leave all other options at their defaults.
4. Verify: `git --version`

---

### 2. Fira Code Font

1. Download the latest ZIP from [FiraCode Releases](https://github.com/tonsky/FiraCode/releases).
2. Extract → open `ttf/` → select all `.ttf` files → right-click → **Install for all users**.

---

### 3. Tabby Terminal

1. Install from [Tabby Releases](https://github.com/Eugeny/tabby/releases).
2. Open **Settings** (`Ctrl+,`).
3. Copy `config.yaml` to `C:\Users\<username>\AppData\Roaming\tabby\`.
4. Under **Profiles & connections**, verify **Git Bash** is detected.

---

### 4. Inject Zsh into Git Bash

1. Go to [MSYS2 Zsh Package](https://packages.msys2.org/package/zsh?repo=msys&variant=x86_64).
2. Download the `.pkg.tar.zst` matching your architecture.
3. Extract with **7-Zip** or **PeaZip**: `.zst` → `.tar` → folders.
4. Merge `usr/` and `etc/` into `C:\Program Files\Git` *(approve admin permissions if prompted)*.

---

### 5. Default Git Bash to Zsh

Add to the end of `~/.bashrc`:

```bash
if [ -t 1 ]; then
  exec zsh
fi
```

---

### 6. Install Oh My Zsh

If prompted on first launch, press `0` to create an empty profile.

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

---

### 7. Install Oh My Zsh Plugins

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone https://github.com/TamCore/autoupdate-oh-my-zsh-plugins \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/autoupdate
```

Enable in `~/.zshrc`:

```zsh
plugins=(git zsh-autosuggestions zsh-syntax-highlighting autoupdate)
```

---

### 8. Install nvm-windows

1. Download `nvm-setup.exe` from [nvm-windows Releases](https://github.com/coreybutler/nvm-windows/releases).
2. Run the installer and follow the prompts.
3. Restart your terminal.
4. Verify: `nvm version`

---

### 9. Install Node.js via nvm

```bash
nvm install --lts
nvm use --lts
```

Verify:

```bash
node -v
npm -v
```

---

### 10. Install Cursor

1. Download the installer from [cursor.com](https://www.cursor.com).
2. Run `CursorSetup.exe` and follow the prompts.
3. On first launch, sign in and complete the onboarding.

---

### 11. Install Recommended Extensions

```bash
cursor --install-extension dbaeumer.vscode-eslint
cursor --install-extension esbenp.prettier-vscode
cursor --install-extension dsznajder.es7-react-js-snippets
cursor --install-extension angular.ng-template
cursor --install-extension pkief.material-icon-theme
cursor --install-extension usernamehw.errorlens
cursor --install-extension ni3rav.andromeda-night
```


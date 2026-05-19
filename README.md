# Ultimate Dev Terminal Setup for Windows
A comprehensive guide to configuring a high-performance, modern development terminal environment using **Tabby**, **Fira Code**, **Zsh**, **Oh My Zsh**, and essential plugins on Windows.

---

## 📦 Prerequisites & Architecture
This setup injects **Zsh** directly into your **Git Bash** environment inside **Tabby Terminal**, giving you a Unix-like experience natively on Windows without requiring WSL resource overhead.

### 📋 Checklist
1. **Tabby Terminal** (Modern terminal emulator)
2. **Fira Code** (Monospace font with programming ligatures)
3. **Git for Windows** (Provides the Git Bash baseline)
4. **Zsh Binaries** (MSYS2 compilation injected into Git Bash)
5. **Oh My Zsh** + Performance Plugins

---

## 🛠️ Step-by-Step Installation

### Step 1: Install Fira Code Font
To display icons, glyphs, and beautiful code ligatures correctly, you need a compatible font.
1. Download the latest release ZIP from the official repository: [Fira Code Downloads](https://github.com/tonsky/FiraCode/releases).
2. Extract the ZIP archive.
3. Open the `ttf` folder, select all font files (`.ttf`), right-click, and select **Install for all users**.

### Step 2: Install & Configure Tabby Terminal
1. Download and install Tabby from the [Tabby Github Releases Page](https://github.com/Eugeny/tabby/releases).
2. Open Tabby and enter **Settings** (`Ctrl + ,`).
3. Paste config.yaml file to `C:\Users\username\AppData\Roaming\tabby`
4. Under **Profiles & connections**:
   * Verify that **Git Bash** is detected. We will configure this profile to default to Zsh shortly.

### Step 3: Inject Zsh into Git Bash
Because Git Bash on Windows doesn't ship with Zsh natively, we must add the compiled binaries manually.
1. Navigate to the [MSYS2 Zsh Package Repository](https://packages.msys2.org/package/zsh?repo=msys&variant=x86_64).
2. Download the compressed binary package matching your architecture (e.g., `zsh-5.9-2-x86_64.pkg.tar.zst`).
3. Extract the `.zst` file using an extractor like **7-Zip** or **PeaZip** to get the `.tar` file. Extract the `.tar` file to reveal the inner folders (specifically `usr` and `etc`).
4. Copy the contents of the extracted **`usr`** and **`etc`** folders and merge them directly into your native Git installation path, typically located at:
   `C:\Program Files\Git`
   *(Grant administrator folder permissions if prompted by Windows).*

### Step 4: Configure Git Bash to Default to Zsh
1. Open Git Bash (or launch the Git Bash profile inside Tabby).
2. Create or open your Bash profile config:
   ```bash
   nano ~/.bashrc
   ```
### Step 5: Install Oh My Zsh
Launch your terminal (which should now automatically load into a clean Zsh prompt). If prompted with a first-time setup wizard, press `0` to create an empty profile.

Run the official automated setup script:
```bash
sh -c "$(curl -fsSL [https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh](https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh))"
```
### Step 6: Install plugins

Run one by one: 
```bash
# Clone Autosuggestions
git clone [https://github.com/zsh-users/zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Clone Syntax Highlighting
git clone [https://github.com/zsh-users/zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Clone Background Auto-updater
git clone clone https://github.com/TamCore/autoupdate-oh-my-zsh-plugins ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/autoupdate
```

#!/usr/bin/env bash
# ===========================================================
#  DevOps/SRE Mac Setup Script
#  Author: Domenico Tanzarella
#  Description: Installs essential productivity + DevOps tools on macOS
# ===========================================================

# --- Check Homebrew ---
if ! command -v brew &>/dev/null; then
  echo "🍺 Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "✅ Homebrew already installed."
fi

echo "🔄 Updating Homebrew..."
brew update

# --- Core CLI tools ---
echo "⚙️ Installing CLI utilities..."
brew install \
  git \
  gh \
  wget \
  curl \
  htop \
  tmux \
  tree \
  jq \
  yq \
  watch \
  kubectl \
  k9s \
  helm \
  terraform \
  awscli \
  google-cloud-sdk \
  lazygit \
  lazydocker \
  btop \
  ghq \
  fzf \
  bat \
  neofetch

# --- Terminal & shells ---
echo "💻 Installing terminal tools..."
brew install --cask iterm2
brew install zsh zsh-autosuggestions zsh-syntax-highlighting

# --- Containers & Kubernetes ---
echo "🐳 Installing container tools..."
brew install --cask docker
brew install dive kubectx kubens

# --- Cloud simulators & dashboards ---
echo "☁️ Installing LocalStack & Lens..."
brew install --cask localstack
brew install --cask lens

# --- Editors & diff tools ---
echo "📝 Installing editors and comparison tools..."
brew install --cask sublime-text
brew install --cask visual-studio-code
brew install --cask meld
brew install --cask gitkraken

# --- Productivity & window management ---
echo "💼 Installing productivity apps..."
brew install --cask raycast
brew install --cask rectangle
brew install --cask obsidian
brew install --cask slack
brew install --cask postman
brew install --cask 1password
brew install --cask istat-menus
brew install --cask appcleaner
brew install --cask paste

# --- Diagramming & design ---
echo "🧩 Installing diagramming tools..."
brew install --cask drawio
brew install --cask miro
brew install --cask figma

# --- Security tools ---
echo "🔒 Installing security utilities..."
brew install gpg
brew install --cask little-snitch

# --- Cleanup ---
echo "🧹 Cleaning up..."
brew cleanup

echo "🎉 Setup complete!"
echo "👉 Suggested next steps:"
echo "  - Launch iTerm2 and set zsh as default shell: chsh -s $(which zsh)"
echo "  - Install Oh My Zsh: https://ohmyz.sh/"
echo "  - Sign into Docker Desktop and Slack"
echo "  - Configure Lens with your kubeconfig"
echo "  - Enjoy your new DevOps Mac setup 🚀"


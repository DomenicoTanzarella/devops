#!/usr/bin/env bash
# ===========================================================
#  DevOps/SRE Mac Setup Script
#  Author: Domenico Tanzarella
#  Description:
#     Installs essential CLI + GUI tools for DevOps/SRE work.
#     Includes Zsh + Oh My Zsh + Powerlevel10k + local dev envs.
# ===========================================================

set -e

# --- Homebrew setup ---
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
echo "⚙️ Installing core DevOps utilities..."
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
  kubectx \
  kubent \
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
  mtr \
  httpie \
  tldr \
  neofetch

# --- Terminal & shells ---
echo "💻 Installing terminal tools..."
brew install --cask iterm2
brew install zsh zsh-autosuggestions zsh-syntax-highlighting

# --- Containers & Kubernetes ---
echo "🐳 Installing container tools..."
brew install --cask docker
brew install dive kubectx kubens

# Install Docker Compose v2 (CLI plugin)
echo "🧱 Installing Docker Compose v2..."
brew install docker-compose

# Install Minikube for local Kubernetes
echo "🏗️ Installing Minikube..."
brew install minikube

# --- Local Cloud simulators & dashboards ---
echo "☁️ Installing LocalStack CLI & Lens..."
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
brew install --cask wireshark
brew install --cask wireshark-app


# --- Zsh / Oh My Zsh / Powerlevel10k ---
echo "💡 Setting up Zsh + Oh My Zsh + Powerlevel10k..."

chsh -s "$(which zsh)"

# Install Oh My Zsh if missing
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "🧩 Installing Oh My Zsh..."
  RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "✅ Oh My Zsh already installed."
fi

# Install Powerlevel10k
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
  echo "🎨 Installing Powerlevel10k theme..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

# Update ~/.zshrc for plugins + theme
if ! grep -q "ZSH_THEME=" ~/.zshrc; then
  echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> ~/.zshrc
else
  sed -i '' 's|^ZSH_THEME=.*|ZSH_THEME="powerlevel10k/powerlevel10k"|' ~/.zshrc
fi

if ! grep -q "plugins=(" ~/.zshrc; then
  echo "plugins=(git zsh-autosuggestions zsh-syntax-highlighting kubectl aws docker)" >> ~/.zshrc
fi

# Add DevOps aliases and plugin sourcing
cat <<'EOF' >> ~/.zshrc

# ---- DevOps Aliases ----
alias k="kubectl"
alias tf="terraform"
alias lg="lazygit"
alias ld="lazydocker"
alias cls="clear"
alias gs="git status"
alias gp="git pull"
alias dc="docker compose"
alias kctx="kubectx"
alias kns="kubens"
alias ls="ls -GFh"
alias ll="ls -lAh"
alias mk="minikube"
alias lsx="localstack"

# Load Zsh plugins
[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# FZF integration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Minikube helpers
alias mkstart="minikube start --driver=docker"
alias mkstop="minikube stop"
alias mkdash="minikube dashboard"
EOF

# --- Cleanup ---
echo "🧹 Cleaning up..."
brew cleanup


echo ""
echo "🎉 DevOps Mac setup complete!"
echo ""
echo "👉 Next steps:"
echo "  1. Restart your terminal or open iTerm2."
echo "  2. Powerlevel10k will guide you through prompt customization."
echo "  3. Verify installs:"
echo "     kubectl version --client"
echo "     terraform version"
echo "     docker version"
echo "     minikube version"
echo "     localstack --version"
echo "  4. Configure Lens with your kubeconfig"
echo "  5. Sign into Docker Desktop and Slack"
echo ""
echo "🚀 You now have a full-featured local DevOps workstation on macOS!"



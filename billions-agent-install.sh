#!/data/data/com.termux/files/usr/bin/bash

echo "========================================"
echo "🚀 Billions Agent Auto Install Starting"
echo "========================================"

pkg update -y && pkg upgrade -y

# Install dependencies
pkg install git -y

# Force stable Node version
pkg uninstall nodejs -y
pkg install nodejs-lts -y

# Fix npm
npm config set registry https://registry.npmjs.org/

# Clone repo safely
echo "📦 Setting up Billions repository..."
if [ -d "verified-agent-identity" ]; then
  echo "⚠️ Repo already exists, using existing folder..."
else
  git clone https://github.com/BillionsNetwork/verified-agent-identity.git
fi

cd verified-agent-identity || { echo "❌ Repo folder not found!"; exit 1; }

# Install packages
echo "📥 Installing packages..."
npm install --force

# Create identity
echo "⚡ Creating Identity..."
node scripts/createNewEthereumIdentity.js

# Generate verification link
echo "🔗 Generating Verification Link..."
node scripts/manualLinkHumanToAgent.js --challenge '{"name":"AkashAgent","description":"Auto setup by TechnicalAkash"}'

echo "========================================"
echo "✅ DONE! Copy the link above & open in browsers"
echo "========================================"

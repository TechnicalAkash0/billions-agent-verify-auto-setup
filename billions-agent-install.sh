#!/data/data/com.termux/files/usr/bin/bash

echo "========================================"
echo "🚀 Billions Agent Auto Install Starting"
echo "========================================"

# Update packages
pkg update -y && pkg upgrade -y

# Install dependencies
pkg install nodejs git -y

# Fix npm registry (slow issue fix)
npm config set registry https://registry.npmjs.org/

# Clone official repo
echo "📦 Cloning Billions repository..."
git clone https://github.com/BillionsNetwork/verified-agent-identity.git

# Enter folder safely
cd verified-agent-identity || { echo "❌ Repo folder not found!"; exit 1; }

# Install dependencies
echo "📥 Installing packages..."
npm install

# Create identity
echo "⚡ Creating Identity..."
node scripts/createNewEthereumIdentity.js

# Generate verification link
echo "🔗 Generating Verification Link..."
node scripts/manualLinkHumanToAgent.js --challenge '{"name":"AkashAgent","description":"Auto setup by TechnicalAkash"}'

echo "========================================"
echo "✅ DONE! Copy the link above & open in browser"
echo "========================================"

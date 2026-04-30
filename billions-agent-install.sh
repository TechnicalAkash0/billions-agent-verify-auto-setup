#!/data/data/com.termux/files/usr/bin/bash

echo "========================================"
echo "🚀 Billions Agent Auto Install Starting"
echo "========================================"

# Fix npm registry
npm config set registry https://registry.npmjs.org/

# Setup repo
echo "📦 Setting up Billions repository..."
if [ -d "verified-agent-identity" ]; then
  echo "⚠️ Repo already exists, using existing folder..."
else
  git clone https://github.com/BillionsNetwork/verified-agent-identity.git
fi

# Enter directory
cd verified-agent-identity || { echo "❌ Repo folder not found!"; exit 1; }

# Clean old install (important fix)
echo "🧹 Cleaning old files..."
rm -rf node_modules package-lock.json
npm cache clean --force

# Install dependencies (stable way)
echo "📥 Installing dependencies..."
npm install --legacy-peer-deps

# Fix missing packages manually
echo "🔧 Installing required modules..."
npm install @iden3/js-iden3-auth @0xpolygonid/js-sdk --legacy-peer-deps

# Create identity
echo "⚡ Creating Identity..."
node scripts/createNewEthereumIdentity.js

# Generate verification link
echo "🔗 Generating Verification Link..."
node scripts/manualLinkHumanToAgent.js --challenge '{"name":"AkashAgent","description":"Auto setup by TechnicalAkash"}'

echo "========================================"
echo "✅ DONE! Copy the link above & open in browser"
echo "========================================"

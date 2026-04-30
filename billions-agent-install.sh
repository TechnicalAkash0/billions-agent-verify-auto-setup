#!/data/data/com.termux/files/usr/bin/bash

echo "🚀 Billions Agent Install Starting..."

pkg update -y && pkg upgrade -y
pkg install nodejs git -y

npm config set registry https://registry.npmjs.org/

git clone https://github.com/BillionsNetwork/verified-agent-identity.git

cd verified-agent-identity

npm install

echo "⚡ Creating Identity..."
node scripts/createNewEthereumIdentity.js

echo "🔗 Generating Verification Link..."
node scripts/manualLinkHumanToAgent.js --challenge '{"name":"AkashAgent","description":"Auto setup"}'

echo "✅ Done! Open link in browser and verify."

#!/bin/bash

# Script to update Kubernetes deployment files to use local image tags
# This is useful for local development with Tilt

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KUBERNETES_DIR="$SCRIPT_DIR/../kubernetes"

echo "Updating Kubernetes deployment files to use local image tags..."

# Function to update image tags in a file
update_image_tags() {
    local file="$1"
    echo "Updating $file..."
    
    # Update marcstreeter/spigot:v* to marcstreeter/spigot:local
    sed -i.bak 's|marcstreeter/spigot:v[0-9]*|marcstreeter/spigot:local|g' "$file"
    
    # Update marcstreeter/proxy:v* to marcstreeter/proxy:local
    sed -i.bak 's|marcstreeter/proxy:v[0-9]*|marcstreeter/proxy:local|g' "$file"
    
    # Update marcstreeter/utils:v* to marcstreeter/utils:local
    sed -i.bak 's|marcstreeter/utils:v[0-9]*|marcstreeter/utils:local|g' "$file"
    
    # Remove backup files
    rm -f "$file.bak"
}

# Update all deployment files
for file in "$KUBERNETES_DIR"/deploy-*.yml; do
    if [ -f "$file" ]; then
        update_image_tags "$file"
    fi
done

echo "Done! All deployment files have been updated to use local image tags."
echo "You can now run 'just dev' to start the development environment with Tilt." 
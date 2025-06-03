#!/bin/bash
set -e
# This script deploys the NCERT theme for Open edX using Tutor.
# It clones the theme repository, copies the theme to the appropriate directory,
# sets the theme, rebuilds the Open edX images, and restarts the services.
# Usage: Run this script from the root of your Tutor installation.
# Ensure you have Tutor installed and configured before running this script.
# Ensure you have the necessary permissions to run this script.
THEME_REPO="https://github.com/dicdiksha/tutor-indigo"
THEME_NAME="ncert"
THEMES_DIR="$(tutor config printroot)/env/build/openedx/themes"

# Pull latest changes from the 'ncert' branch
git pull origin ncert

tutor local do settheme "$THEME_NAME"

# Verify if theme directory exists before copying
if [ ! -d "$THEME_NAME" ]; then
  echo "Error: Theme directory '$THEME_NAME' does not exist in $(pwd)."
  exit 1
fi

# Remove existing theme directory at destination
if [ -d "$THEMES_DIR/$THEME_NAME" ]; then
  echo "Removing existing theme at $THEMES_DIR/$THEME_NAME"
  rm -rf "$THEMES_DIR/$THEME_NAME"
fi

# Copy theme and verify
echo "Copying theme to $THEMES_DIR/$THEME_NAME"
cp -r "$THEME_NAME" "$THEMES_DIR/$THEME_NAME"

if [ -d "$THEMES_DIR/$THEME_NAME" ]; then
  echo "Theme copied successfully."
else
  echo "Error: Failed to copy theme to $THEMES_DIR/$THEME_NAME"
  exit 1
fi

tutor images build openedx
tutor local stop
tutor local start -d
sudo service nginx restart
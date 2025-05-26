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

cp -r "$THEME_NAME" "$THEMES_DIR/$THEME_NAME" || true

tutor local do settheme "$THEME_NAME"
tutor images build openedx
tutor local stop
tutor local start -d
sudo service nginx restart
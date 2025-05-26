# NCERT Theme Deployment Guide

## 1. Login to the Open edX Server

```sh
ssh -i id_rsa_prod_user ncertx_prod_user@10.245.0.2
```


## 2. Clone the Theme Repository

```sh
git clone https://github.com/dicdiksha/tutor-indigo
```
## 3. Copy the NCERT Theme

```sh
cd tutor-indigo
cp -r ncert "$(tutor config printroot)/env/build/openedx/themes/ncert"
```

## 4. Set the Theme in Tutor

```sh
tutor local do settheme ncert
```

## 5. Rebuild Open edX Images

```sh
tutor images build openedx
```

## 6. Restart Open edX and Nginx

```sh
tutor local stop
tutor local start -d
sudo service nginx restart
```

---

**Note:**  
- Replace `id_rsa_prod_user` with the path to your SSH private key if different.
- Ensure you have the necessary permissions to run these commands.

## Run as Shell Script Automation

1. Save the following script as `deploy_ncert_theme.sh` in your home directory or project root:

```sh
#!/bin/bash
set -e

THEME_REPO="https://github.com/dicdiksha/tutor-indigo"
THEME_NAME="ncert"
THEMES_DIR="$(tutor config printroot)/env/build/openedx/themes"

tutor local do settheme "$THEME_NAME"
tutor images build openedx
tutor local stop
tutor local start -d
sudo service nginx restart
```

2. Make the script executable and run it:

```sh
chmod +x deploy_ncert_theme.sh
bash deploy_ncert_theme.sh
```
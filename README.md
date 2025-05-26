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
tutor images build openedx --no-cache
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
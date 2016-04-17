

Run a mounted service that listens to port 1234 and gets node modules from a custom registry:
```
docker run -d -p 80:1234 -v ~/my/app:/usr/src/app -e npm_config_registry=https://npm.local/ solsson/node:5-run
```

Download a zipped distribution and npm install from default registry.
```
docker run -d -p 80:1234 -e download_zip_url=https://....zip -e download_zip_sha256=... solsson/node:5-run
```

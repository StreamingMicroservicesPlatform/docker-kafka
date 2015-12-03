
See https://github.com/GoogleCloudPlatform/kube-jenkins-imager

But beware of how https://github.com/GoogleCloudPlatform/nginx-ssl-proxy/blob/master/start.sh responds to ENV combinations.

We ended up using http://kubernetes.io/v1.1/docs/user-guide/connecting-applications.html#dns and
```
env:
-        - name: SERVICE_HOST_ENV_NAME
-          value: MY_BACKEND_HOST
-        - name: SERVICE_PORT_ENV_NAME
-          value: MY_BACKEND_PORT
+        - name: TARGET_SERVICE
+          value: my-backend:12345
- name: ENABLE_SSL
  value: 'true'
ports:
```

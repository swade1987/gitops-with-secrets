# How to create a generic secret

## 1. Create an env file.

An example can be found in [example/test.env](../example/test.env).

## 2. Generate the generic secret.

Then create a generic secret using the following command:

```
kubectl create secret generic test-secret --namespace=default --from-env-file=example/test.env --dry-run=client -o yaml > local-toseal/dev/default-test-secret.yaml
```

You can also create the new secret values by using the base64 command, but make sure you specify `-n` to avoid new line chars at the end of your secret.

```
echo -n 'secret' | base64
```

Important: The filename needs to be `<namespace>-<secret name>.yaml`.

The file should contain something similar to below:

```
apiVersion: v1
kind: Secret
metadata:
  name: <secret_name>
  namespace: <secret_namespace>
data:
  secretThing: WW91IGZvdW5kIG1lIDE=
```

## 3. Locate the file in the appropriate directory.

Place this file in `local-toseal/<env>` 

## 4. Seal the secret.

To seal secrets for an environment (e.g. bh) simply execute `make seal-dev`.

## 5. Locate sealed-secrets.

Your original secret will now be in `local-sealed/<env>` for reference.  

Your new sealed secret will now be in `sealed-secrets/<env>`.

## 6. Commit changes.

This part is self-explanatory.
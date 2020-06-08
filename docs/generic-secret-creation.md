# How to create a generic secret

## 1. Create an env file.

An example can be found in [example/test.env](../example/test.env).

## 2. Generate the generic secret.

Then create a generic secret using the following command:

```
kubectl create secret generic test-secret \
--namespace=default \
--from-env-file=example/test.env \
--dry-run=client -o yaml > local-toseal/dev/default-test-secret.yaml
```

The filename structure is extremely important see below:

```
kubectl create secret generic <secret name> \
--namespace=<namespace> \
--from-env-file=<env file> \
--dry-run -o yaml > <filename>.yaml
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

## 7. Located the sealed secret

To locate the `SealedSecret` resource, simply execute:

```
kubectl get sealedsecrets.bitnami.com

NAME          AGE
test-secret   29s
```

## 8. Locate the un-sealed secret

To locate the unsealed secret (`secret`) resource, simply execute:

```
kubectl get secrets

```
# Deploying Bayesian PgBouncer

First make sure you're logged in to the right cluster and on the right project:

```
$ oc project
```

Note this guide assumes that secrets have already been deployed.

To deploy the PgBouncer service, simply run:

```
./deploy.sh
```


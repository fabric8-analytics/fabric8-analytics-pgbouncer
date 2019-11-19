# Deploying Bayesian PgBouncer and PgWeb

First make sure you're logged in to the right cluster and on the right project:

```
$ oc project
```

Note this guide assumes that secrets have already been deployed.

To deploy PgBouncer and PgWeb services, simply run:

```
./deploy.sh
```


# helm-angular-app

OneCX angular application helm template

## Add to Angular apps

Add latest `0.x.x` version.
```yaml
  dependencies:
    - name: helm-angular-app
      alias: app
      version: ^0
      repository: oci://ghcr.io/onecx/charts
```

#### Default configuration

```
app:
  image:
    repository: "onecx/${project.name}"
    tag: latest
```
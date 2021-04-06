# qbitcli

## Description

**qbitcli** is a bundle full of useful scripts, covering the following technologies: **Azure, Docker, Kubernetes and Helm Charts**.

All resources in **qbitcli** are free, public and constantly updated with new code snippets.

## CLI

-   [az.ps1](https://github.com/qbituniverse/qbitcli/blob/master/cli/az.ps1)
-   [docker.ps1](https://github.com/qbituniverse/qbitcli/blob/master/cli/docker.ps1)
-   [kubectl.ps1](https://github.com/qbituniverse/qbitcli/blob/master/cli/kubectl.ps1)
-   [helm.ps1](https://github.com/qbituniverse/qbitcli/blob/master/cli/helm.ps1)

## Deployment

Open CMD, navigate to location where you need the *qbitcli* resources copied and run the command below. Image always has *latest* tag and it's the only tag.

```
docker create --name qbitcli qbituniverse/qbitcli
docker cp qbitcli:/qbitcli/. .qbitcli/
docker rm -fv qbitcli
docker rmi -f qbituniverse/qbitcli:latest
```

The end result will be a folder structure created as follows:

```
|- .qbitcli
   |- ...files...
```

## Usage

The *.qbitcli* folder contains set of powershell files that you can use to manage *Azure, Docker, Kubernetes and Helm Charts*.

### Core Flags
|Flag|Description|
|-|-|
|--help|Prints out help page describing relevant CLI flags|

### Examples
Simply select the powershell you want to run and pass *--help* operation to discover what operations are available for a particular cli.

```
docker.ps1 --help
```

Running the powershell without any flag, will simply print out snapshot of the environment for a particular cli.

```
kubectl.ps1
```

## Uninstall

Navigate to location where *qbitcli* resources are installed and delete the *.qbitcli* folder.

## Links

**qbitcli** is available on: [GitHub](https://github.com/qbituniverse/qbitcli) - [DockerHub](https://cloud.docker.com/u/qbituniverse/repository/docker/qbituniverse/qbitcli) - [Web](https://qbituniverse.com)

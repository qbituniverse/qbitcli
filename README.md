# qbitcli

## Description

**qbitcli** is full of useful scripts, covering the following technologies: Azure, Docker, Helm Charts, Kubernetes, MongoDb.

All resources in **qbitcli** are free, public and constantly updated with new code snippets.

## CLI

-   [az](https://github.com/qbituniverse/qbitcli/blob/master/cli/az.ps1)
-   [docker](https://github.com/qbituniverse/qbitcli/blob/master/cli/docker.ps1)
-   [helm](https://github.com/qbituniverse/qbitcli/blob/master/cli/helm.ps1)
-   [kubectl](https://github.com/qbituniverse/qbitcli/blob/master/cli/kubectl.md)

## Deployment

Open CMD, navigate to location where you need the *qbitcli* resources copied and run the command below. Image always has *latest* tag and it's the only tag.

```
docker create --name qbitcli qbituniverse/qbitcli
docker cp qbitcli:/qbitcli/. qbitcli/
docker rm -fv qbitcli
docker rmi -f qbituniverse/qbitcli:latest
```

The end result will be a folder structure created as follows:

```
|- qbitcli
   |- ...files...
```

## Usage

The *qbitcli* folder contains set of powershell files that you can use to manage Docker, Kubernetes, Helm Charts and Azure.

Simply select the powershell you want to run and pass *--help* operation to discover what operations are available for a particular powershell. For instance, for Docker do this:

```
docker.ps1 --help
```

Running the powershell without any flag, will simply print out snapshot of the environment for a particular powershell. For instance, to view Docker environment, do this:

```
docker.ps1
```

The above will print out Docker system output, Images, Containers, Volumes and any Dangling resources.

## Links

**qbitcli** is available on: [GitHub](https://github.com/qbituniverse/qbitcli) - [DockerHub](https://cloud.docker.com/u/qbituniverse/repository/docker/qbituniverse/qbitcli) - [Web](https://qbituniverse.com)

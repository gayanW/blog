---
layout: post
title:  "Running SonarQube in ECS"
date:   2021-02-24 23:30:00 +0530
categories: sonarqube ecs
---
This guide briefs the steps required to deploy SonarQube Server in Amazon ECS. An ECS task definition needs to be created which is then used to launch SoanrQube as a service within Amazon ECS. Ready-made docker images for different SonarQube editions and versions can be found in Docker Hub, which we’ll be using for the deployment.

Create an EFS file system to be used with SonarQube
When running SonarQube in ECS, persistent storage such as an EFS volume is required to prevent data loss. Otherwise, essential server data could be lost in case the container restarts or terminates. It also helps when updating the server to a new version or upgrading to a higher edition.

# Create ECS task definition

Make sure that the task execution IAM role has full access to the EFS created. 

Furthermore, this role should have the necessary permissions required to pull container images and to publish logs to Amazon CloudWatch.

## Set an appropriate task size

As mentioned in the docs, SonarQube server requires at least 2GB of RAM to run efficiently and 1GB of free RAM for the OS.

## Volumes

Under volumes add the EFS file system that is being created for SonarQube.

## Container definitions

Under container definitions, specify a SonarQube image as the image used to start your container. If this is image is being stored in ECR, make sure that the ECR Task execution IAM role has the permission to pull images from ECR.

### Port mappings

The default port that SonarQube runs is "9000". So under port mappings also set the container port to 9000.

### ENVIRONMENT

The default operating system limits on mmap counts are likely to be too low, which may result in out-of-memory exceptions. Therefore, SonarQube recommends that we set vm.max_map_count to a value greater than or equal to 524288. However, in ECS we can not control the ability to create memory maps.

So disallow memory-mapping altogether,  enter the following Docker CMD parameters, into the input field named ‘Command’.

```
-Dsonar.search.javaAdditionalOpts=-Dnode.store.allow_mmap=false
```

#### Environment variables
The following environment variables should be set. These are referenced by the SonarQube docker image and is required to be able to successfully run the application.

```
SONAR_JDBC_URL
SONAR_JDBC_PASSWORD
SONAR_JDBC_USERNAME
```

If the JDBC URL is updated, the server ID, which is stored in the database will be re-generated and you'll need a new license. So make sure to use an external database and to make backups.

### STORAGE AND LOGGING

Under ‘STORAGE AND LOGGING’, add the following mount points to your EFS volume.

```
/opt/sonarqube/data
/opt/sonarqube/extensions
/opt/sonarqube/logs
```

## RESOURCE LIMITS

The user running SonarQube should have permission to have at least 131072 open descriptors and should be able to open at least 8192 threads.

Set the recommended Ulimits under ‘RESOURCE LIMITS’

|-----------------+------------+-----------------|
| **Limit name** . | **Soft limit** . | **Hard limit**      |
|-----------------|:-----------|:---------------:|
| NOFILE          | 131072     |131072          |
| NPROC           | 8192       |8192            |
|-----------------+------------+-----------------|

# Creating the SonarQube Service

Now create a service from the task definition created. In the service configurations make sure to set FARGATE as the launch type. Set the ‘number of tasks’ to 1. Since, running multiple instances populating the same database is only supported by the Data Center Edition, and requires further configuration changes.

Make sure that the security group attached to the service instance has an inbound rule that allows TCP 9000. Also add an inbound rule of type NFS, for the instance to be able to access the EFS volume created. Once the task is up and running, the SonarQube server should be accessible via the private IP of the running task and port 9000.

Additionally, one could set up DNS routes, so to have convenient access to the server.

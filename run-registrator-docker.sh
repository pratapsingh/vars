#!/bin/bash
# Specify the cluster that the container instance should register into
cluster=$1

# Write the cluster configuration variable to the ecs.config file
# (add any other configuration variables here also)
#echo ECS_CLUSTER=$cluster >> /etc/ecs/ecs.config

# Install the AWS CLI and the jq JSON parser
yum install -y aws-cli jq

#upstart-job
#description "Amazon EC2 Container Service (start task on instance boot)"
#author "Amazon Web Services"
#start on started ecs

sleep 90

	# Grab the container instance ARN and AWS region from instance metadata
	instance_arn=$(curl -s http://localhost:51678/v1/metadata | jq -r '. | .ContainerInstanceArn' | awk -F/ '{print $NF}' )
	cluster=$(curl -s http://localhost:51678/v1/metadata | jq -r '. | .Cluster' | awk -F/ '{print $NF}' )
	region=$(curl -s http://localhost:51678/v1/metadata | jq -r '. | .ContainerInstanceArn' | awk -F: '{print $4}')

	# Specify the task definition to run at launch
	task_definition=$2

	# Run the AWS CLI start-task command to start your task on this container instance
	aws ecs start-task --cluster $cluster --task-definition $task_definition --container-instances $instance_arn --started-by $instance_arn --region $region

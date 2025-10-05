#!/bin/bash
######################################
# This script is used to list all EC2 instances across all regions in an AWS account.
# It retrieves the instance ID, instance type, state, count the number of instances in each region,
# and displays the information in a formatted table.
# It also provides a summary of the total number of instances across all regions.
######################################
# Function to check if AWS CLI is installed
check_aws_cli() {
    if ! command -v aws &> /dev/null; then
        echo "AWS CLI is not installed. Please install it and configure your credentials."
        exit 1
    fi
}
# Function to list EC2 instances across all regions
list_ec2_instances() {
    echo "Fetching list of EC2 instances across all regions..."
    echo
    printf "%-20s %-15s %-10s %-10s\n" "Instance ID" "Instance Type" "State" "Region"
    printf "%-20s %-15s %-10s %-10s\n" "-----------" "-------------" "-----" "------"
    
    total_instances=0
    regions=$(aws ec2 describe-regions --query "Regions[].RegionName" --output text)
    
    for region in $regions; do
        instances=$(aws ec2 describe-instances --region "$region" --query "Reservations[].Instances[].[InstanceId, InstanceType, State.Name]" --output text)
        
        if [ -n "$instances" ]; then
            instance_count=$(echo "$instances" | wc -l)
            total_instances=$((total_instances + instance_count))
            
            while read -r line; do
                instance_id=$(echo "$line" | awk '{print $1}')
                instance_type=$(echo "$line" | awk '{print $2}')
                state=$(echo "$line" | awk '{print $3}')
                printf "%-20s %-15s %-10s %-10s\n" "$instance_id" "$instance_type" "$state" "$region"
            done <<< "$instances"
        fi
    done
    
    echo
    echo "Total number of EC2 instances across all regions: $total_instances"
}
# Main script execution
check_aws_cli
list_ec2_instances


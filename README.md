# 🖥️ AWS EC2 Multi-Region Instance Lister

A simple yet powerful **Bash script** that lists **all EC2 instances across every AWS region** in your AWS account — including their **Instance ID, Instance Type, State, and Region** — and provides a **total instance count summary**.  

Perfect for AWS administrators, DevOps engineers, and cloud auditors who want a fast overview of their EC2 infrastructure without manually switching regions in the AWS Console.

---

## 🚀 Features

✅ Lists **EC2 instances across all regions**  
✅ Displays a **clean, formatted table output**  
✅ Shows **Instance ID**, **Type**, **State**, and **Region**  
✅ Counts the **total number of instances** across all regions  
✅ Automatically checks if **AWS CLI** is installed  
✅ Works seamlessly with any configured AWS profile  

---

## 🧰 Requirements

Before using the script, make sure you have:

- **AWS CLI v2+** installed  
  👉 [Installation Guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

- **Configured AWS credentials**  
  ```bash
  aws configure


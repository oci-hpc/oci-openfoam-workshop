Command Line Interface (CLI)

1. Install prerequisites for managing infrastrucutre on OCI with Terraform using the following [link](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/terraformgetstarted.htm).
    
2. Open a browser and navigate to the .zip file in this [project](https://github.com/oci-hpc/oci-openfoam-workshop/blob/oci-hpc/Resources/Intel%20Workshop.zip).
    
3. Click the download button to download the .zip file to your local machine.
    <br>INSERT PIC OF DOWNLOAD BUTTON ON GITHUB REPO</br>
    
4. Navigate to the directory where the .zip file was downloaded and unarchived using the following command:
    <br>cd "Intel Workshop"</br>

5. Assign your configuration values to the TF_VAR_variables in env.sh using the following command:
    <br>vi env.sh</br>
    <br>INSERT PIC OF VARS</br>

6. Export the TF_VAR_variables to your command line interface environment using the following command:
    <br>source env.sh</br>

7. Initialize the Terraform project using the following command:
    <br>terraform init</br>

8. Provision the infrastructure by deploying the project using the following command:
    <br>terraform apply</br>
    <br>INSERT PIC OF 'YES' PROMPT</br>

9. Wait for your deployment to provision. You can monitor the logs that appear in the Terminal window
    <br>INSERT PIC OF LOGS IN TERMINAL</br>

10. [Visualize on OCI](https://github.com/oci-hpc/oci-openfoam-workshop/blob/oci-hpc/README.md)

# Command Line Interface (CLI)
###### <p align="right">Total Time: 1-2 hours</p>
1. Install prerequisites for managing infrastructure on OCI with Terraform.\
<sub><sup><sub>:clock3:</sub></sup></sub>
	&nbsp;
	<sub>~10 minutes</sub>
	<p></p>
	1.1. Install prerequisites for managing infrastructure on OCI with Terraform:
	<p></p>
	<pre>
	open https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/terraformgetstarted.htm
	</pre>
	<p></p>
2. Launch a job via CLI that provisions the infrastructure on OCI by deploying the <b>openfoam-workshop</b> project.\
	2.1. Navigate to the source code online:
	<p></p>
	<pre>
	open https://github.com/oci-hpc/oci-openfoam-workshop/blob/oci-hpc/Resources/Intel%20Workshop.zip
	</pre>
	<p></p>
	2.1. Navigate to the source code online
	<p></p>
	<pre>
	open https://github.com/oci-hpc/oci-openfoam-workshop/blob/oci-hpc/Resources/Intel%20Workshop.zip
	</pre>
	<p></p>
	2.2. Click <b>Download</b> to download the .zip file containing the source code to your local machine
	<p></p>
	2.3. If the folder containing the source code was extracted from the downloaded .zip file, you may delete the .zip file and move the folder to a preferred location on your local machine. The following example references ~/Downloads as the default download location:
	<pre>
	ls | grep "~/Downloads/Intel Workshop"
	# if <b>Intel Workshop</b> shows up in the output, you may proceed with <b>rm "~/DownloadsIntel Workshop.zip"</b>
	mv ~/Downloads/"Intel Workshop" <b>DESIRED_PATH</b>
	cd <b>DESIRED_PATH</b>/"Intel Workshop"
	</pre>
	<p></p>
	2.4. Assign your configuration values to the TF_VAR_variables in env.sh:
	<pre>
	vi env.sh
	</pre>
	<p></p>
	2.5. Export the variables with the prefix <b>TF_VAR_</b> to your CLI environment:
	<pre>
	source env.sh
	</pre>
	<p></p>
	2.6. Initialize the Terraform project:
	<pre>
	terraform init
	</pre>
	<p></p>
	2.7. Provision the infrastructure by deploying the project:
	<pre>
	terraform apply # answer yes
	</pre>
	<p></p>
3. [Visualize on OCI](https://github.com/oci-hpc/oci-openfoam-workshop/blob/oci-hpc/README.md)
4. Launch a job via CLI that deprovisions the infrastructure.\
	4.1. Navigate to the source code online:
	<p></p>
	<pre>
	terraform destroy # answer yes
	</pre>
	<p></p>

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

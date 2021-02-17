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
	<details>
		<summary>Download the project</summary>
	<div style="text-align:center"><img src="https://github.com/oci-hpc/oci-openfoam-workshop/blob/oci-hpc/pictures/pre-cli-deployment/01-download-from-github.png" width=70%/>
	</div>
	</details>
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
	<details>
		<summary>Edit env.sh</summary>
	<div style="text-align:center"><img src="https://github.com/oci-hpc/oci-openfoam-workshop/blob/oci-hpc/pictures/pre-cli-deployment/02-eit-env.png" width=70%/>
	</div>
	</details>
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
	<details>
		<summary>Deploy the project</summary>
	<div style="text-align:center"><img src="https://github.com/oci-hpc/oci-openfoam-workshop/blob/oci-hpc/pictures/pre-cli-deployment/03-terraform-yes-apply.png" width=40%/>
	</div>
	</details>
	<details>
		<summary>Deployment in progress</summary>
	<div style="text-align:center"><img src="https://github.com/oci-hpc/oci-openfoam-workshop/blob/oci-hpc/pictures/pre-cli-deployment/04-cli-deployment-in-progress.png" width=80%/>
	</div>
	</details>
	<p></p>
3. [Visualize on OCI](https://github.com/oci-hpc/oci-openfoam-workshop/blob/oci-hpc/README.md)
4. Launch a job via CLI that deprovisions the infrastructure.\
	4.1. Navigate to the source code online:
	<p></p>
	<pre>
	terraform destroy # answer yes
	</pre>
	<p></p>
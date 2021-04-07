# Resource Manager
###### <p align="right">Total Time: 30 minutes (excluding Visualization)</p>

### Summary
In this section, you will deploy the motorbike model stack using Resource Manager, stack manager that is accessible as a GUI on the OCI portal.

In this lab, you will upload the stack project file to Resource Manager on OCI, and configure the variables in the GUI according to your deployment parameters. Then you will deploy the stack via Resource Manager, visualize the motorbike model in 3D virtual space, and finally deprovision the stack via Resource Manager.



### Step 1. Launch a job via Resource Manager to deploy the IntelWorkshop stack
<p></p>
<sub><sup><sub>:clock3:</sub></sup></sub>
&nbsp;
<sub>5 minutes</sub>
<p></p>

1. Download the stack project:

<a href="https://github.com/oci-hpc/oci-openfoam-workshop/blob/oci-hpc/Resources/IntelWorkshop.zip">IntelWorkshop.zip</a>

2. Open a web browser and navigate to the <b>Create Stack</b> wizard in Resource Manager, in your preferred Compartment and Region:

<pre>
cloud.oracle.com &gt sign into your OCI Tenancy &gt click Hamburger Menu &gt hover over <b>Resource Manager</b> &gt click <b>Stacks</b> &gt choose your Compartment from the dropdown menu under <b>List Scope</b> &gt click <b>Create Stack</b>
</pre>

<details>
	<summary>Navigate to the <b>Create Stack</b> wizard</summary>

<div style="text-align:center"><img src="https://github.com/oci-hpc/oci-openfoam-workshop/blob/oci-hpc/pictures/pre-resourcemanager-deployment/02-resourcemanager-stacks.png"/>
</div>

<p></p>

<div style="text-align:center"><img src="https://github.com/oci-hpc/oci-openfoam-workshop/blob/oci-hpc/pictures/pre-resourcemanager-deployment/03-resourcemanager-stack-listings.png"/>
</div>

<p></p>

<div style="text-align:center"><img src="https://github.com/oci-hpc/oci-openfoam-workshop/blob/oci-hpc/pictures/pre-resourcemanager-deployment/04-resourcemanager-stack-wizard-before-upload.png"/>
</div>

</details>

</pre>

3. In the <b>Stack Information</b> section of the <b>Create Stack</b> wizard, click <b>Browse</b> under <b>Stack Configuration</b> and choose the <b>openfoam-workshop</b> folder (or .zip file), then click <b>Next</b>.
<details>
	<summary>Stack wizard - <b>Stack Information</b> section</summary>

<div style="text-align:center"><img src="https://github.com/oci-hpc/oci-openfoam-workshop/blob/oci-hpc/pictures/pre-resourcemanager-deployment/05-resourcemanager-stack-wizard-after-upload-folder.png"/>
</div>

<p>or</p>

<div style="text-align:center"><img src="https://github.com/oci-hpc/oci-openfoam-workshop/blob/oci-hpc/pictures/pre-resourcemanager-deployment/06-resourcemanager-stack-wizard-after-upload-zipfile.png"/>
</div>

</details>

4. In the <b>Configure Variables</b> section, do the following for the appropriate field:
<p></p>

- Select a Compartment where you have permissions to manage the resources that are mentioned in the [Prerequisites](../README.md#workshop-prerequisites) section.
<p></p>

- Paste the contents of your SSH public key file.
<p></p>
The default location of your SSH public key file on your machine is <b>~/.ssh/id_rsa.pub</b>. You can copy these contents to your clipboard from your Mac OS local machine by executing:
<p></p>
<pre>
pbcopy &lt ~/.ssh/id_rsa.pub
# pbcopy &lt <b>PUBLIC_KEY_PATH</b>
# then paste with CMD+V
</pre>

<p>or</p>
<pre>
cat ~/.ssh/id_rsa.pub
# cat <b>PUBLIC_KEY_PATH</b>
# capture the output manually with CMD+C, then paste with CMD+V
</pre>
	<p>You can generate a new key pair on Mac OS if necessary by executing:</p>
<pre>
ssh-keygen
</pre>
	on your Mac OS or Linux machine and specifying (1.) the path on your local machine where the key pair will be saved, and (2.) no passphrase for the key pair.
<details>
	<summary>Copy contents of new SSH public key to clipboard</summary>

<div style="text-align:center"><img src="https://github.com/oci-hpc/oci-openfoam-workshop/blob/oci-hpc/pictures/pre-resourcemanager-deployment/07-ssh-key-create-and-copy.png"/>
</div>

</details>

- Select a shape for your Compute Instance.
<p></p>
The name of the shape indicates the number of cores that are available to that shape, e.g. the VM.Standard2.<b>8</b> shape has <b>8</b> cores available.
<p></p>
- Select the number representing the Availability Domain (AD) in which the infrastructure will be provisioned.
<p></p>

Note that the availability of cores the shape that you use will vary between Availability Domains. The way to check resource availability is described in the [Prerequisites](../README.md#workshop-prerequisites) section.
When you are finished configuring your variables, click <b>Next</b>.

<details>
	<summary>Stack wizard - <b>Configure Variables</b> section</summary>

<div style="text-align:center"><img src="https://github.com/oci-hpc/oci-openfoam-workshop/blob/oci-hpc/pictures/pre-resourcemanager-deployment/08-resourcemanager-stack-wizard-variables.png"/>
</div>

</details>

5. In the <b>Review</b> section, click <b>Create</b>.

<details>
	<summary>Stack wizard - <b>Review</b> section</summary>
<div style="text-align:center"><img src="https://github.com/oci-hpc/oci-openfoam-workshop/blob/oci-hpc/pictures/pre-resourcemanager-deployment/09-resourcemanager-stack-wizard-review.png"/>
</div>
</details>

6. On the <b>Stack Details</b> page, Under <b>Terraform Actions</b> dropdown menu, click <b>Apply</b> > <b>Apply</b> to provision the infrastructure.

<details>
	<summary>Provision the infrastructure</summary>
<div style="text-align:center"><img src="https://github.com/oci-hpc/oci-openfoam-workshop/blob/oci-hpc/pictures/pre-resourcemanager-deployment/10-resourcemanager-stack-apply-1.png"/>
</div>

<p></p>

<div style="text-align:center"><img src="https://github.com/oci-hpc/oci-openfoam-workshop/blob/oci-hpc/pictures/pre-resourcemanager-deployment/11-resourcemanager-stack-apply-2.png"/></div>
</details>

<details>
	<summary>Resource Manager - <b>Apply</b> job in progress</summary>
<div style="text-align:center"><img src="https://github.com/oci-hpc/oci-openfoam-workshop/blob/oci-hpc/pictures/pre-resourcemanager-deployment/12-resourcemanager-job-in-progress-apply.png"/>
</div>
</details>



### Step 2. Wait for the infrastructure to finish provisioning.
<p></p>
<sub><sup><sub>:clock3:</sub></sup></sub>
&nbsp;
<sub>20 minutes</sub>
<p></p>

From the left side of the page, you can monitor the logs of the Resource Manager job while the job is running, or check the variables, and after the Resource Manager job completes, you can obtain the output values.

<details>
	<summary>Resource Manager - Logs</summary>
<div style="text-align:center"><img src="https://github.com/oci-hpc/oci-openfoam-workshop/blob/oci-hpc/pictures/post-resourcemanager-deployment/01-resourcemanager-logs.png"/>
</div>
</details>

<details>
	<summary>Resource Manager - Variables</summary>
<div style="text-align:center"><img src="https://github.com/oci-hpc/oci-openfoam-workshop/blob/oci-hpc/pictures/post-resourcemanager-deployment/02-resourcemanager-variables.png"/>
</div>
</details>

<details>
	<summary>Resource Manager - <b>Apply</b> job complete</summary>
<div style="text-align:center"><img src="https://github.com/oci-hpc/oci-openfoam-workshop/blob/oci-hpc/pictures/post-resourcemanager-deployment/00-resourcemanager-job-complete-apply.png"/>
</div>
</details>

<details>
	<summary>Resource Manager - Outputs</summary>
<div style="text-align:center"><img src="https://github.com/oci-hpc/oci-openfoam-workshop/blob/oci-hpc/pictures/post-resourcemanager-deployment/03-resourcemanager-outputs.png"/>
</div>
</details>



### Step 3: [Visualize the Motorbike Model on OCI](https://github.com/oci-hpc/oci-openfoam-workshop/blob/oci-hpc/README.md)
<p></p>
<sub><sup><sub>:clock3:</sub></sup></sub>
&nbsp;
<sub>15 minutes</sub>
<p></p>



### Step 4. Launch a job via Resource Manager that deprovisions the IntelWorkshop stack
<p></p>
<sub><sup><sub>:clock3:</sub></sup></sub>
&nbsp;
<sub>5 minutes</sub>
<p></p>

1. From your web browser, navigate to the Stack listings page in Resource Manager, in the same Compartment and Region where your Stack was deployed:

<p></p>

<pre>
cloud.oracle.com &gt sign into your OCI Tenancy &gt click Hamburger Menu &gt hover over <b>Resource Manager</b> &gt click <b>Stacks</b> &gt choose your Compartment from the dropdown menu under <b>List Scope</b>
</pre>

<details>
	<summary>Navigate to the Stack listings page</summary>
<div style="text-align:center"><img src="https://github.com/oci-hpc/oci-openfoam-workshop/blob/oci-hpc/pictures/post-resourcemanager-deployment/14-resourcemanager-stack-listings.png"/>
</div>
</details>

2. On the <b>Stack Details</b> page, Under <b>Terraform Actions</b> dropdown menu, click <b>Destroy</b> > <b>Destroy</b> to deprovision the infrastructure.

<details>
	<summary>Deprovision the infrastructure</summary>
<div style="text-align:center"><img src="https://github.com/oci-hpc/oci-openfoam-workshop/blob/oci-hpc/pictures/post-resourcemanager-deployment/15-resourcemanager-destroy-1.png"/>
</div>

<p></p>

<div style="text-align:center"><img src="https://github.com/oci-hpc/oci-openfoam-workshop/blob/oci-hpc/pictures/post-resourcemanager-deployment/16-resourcemanager-destroy-2.png"/></div>
</details>

<details>
	<summary>Resource Manager - <b>Destroy</b> job in progress</summary>

<div style="text-align:center"><img src="https://github.com/oci-hpc/oci-openfoam-workshop/blob/oci-hpc/pictures/post-resourcemanager-deployment/17-resourcemanager-job-in-progress-destroy.png"/>
</div>
</details>

<details>
	<summary>Resource Manager - <b>Destroy</b> job complete</summary>

<div style="text-align:center"><img src="https://github.com/oci-hpc/oci-openfoam-workshop/blob/oci-hpc/pictures/post-resourcemanager-deployment/18-resourcemanager-job-complete-destroy.png"/>
</div>

Congratulations! You have successfully deployed the motorbike model stack using Resource Manager!

Another way to deploy this stack is via ocihpc, an HPC stack deployment tool for the CLI. You can do this by following [these steps](https://github.com/oci-hpc/oci-openfoam-workshop/blob/oci-hpc/Documentation/Command%20Line.md).
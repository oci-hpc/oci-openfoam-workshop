# oci-openfoam-workshop

### Motorbike Simulation on Oracle Cloud Infrastructure (OCI)
<div style="text-align:center">
	<img src="./pictures/post-resourcemanager-deployment/13-paraview-motorbike.png"
	/>
</div>

### Workshop Prerequisites
- Access to an OCI Tenancy (account)
- [VNC Viewer](https://www.realvnc.com/en/connect/download/viewer/) installed on your local machine as a client application for VNCServer.
- An SSH key pair on your local machine.
- Permissions to manage the following resources in some Compartment: Virtual Cloud Network, Subnet, Route Table, Security List, Internet Gateway, Compute Instance, Block Volume. (See [Identity and Access Management Policies](https://docs.oracle.com/en-us/iaas/data-safe/doc/iam-policies.html))
- Sufficient availability to provision 1 x each of the aformentioned resources. You can check resource availability:
<pre>
Hamburger Menu &gt Governance &gt Limits, Quotas and Usage
</pre>
<details>
	<summary>Check resource availability</summary>
<div style="text-align:center"><img src="./pictures/pre-resourcemanager-deployment/limits/01-governance-limits.png"/>
</div>
<p></p>
<div style="text-align:center"><img src="./pictures/pre-resourcemanager-deployment/limits/02-check-availability-1.png"/>
</div>
<p></p>
<div style="text-align:center"><img src="./pictures/pre-resourcemanager-deployment/limits/03-check-availability-2.png"/>
</div>
</details>

### Workshop Steps
###### <p align="right">Total Time: 1-2 hours</p>
1. Launch a job via Resource Manager that provisions the infrastructure on OCI by deploying the <b>openfoam-workshop</b> project.\
	<sub><sup><sub>:clock3:</sub></sup></sub>
	&nbsp;
	<sub>~10 minutes</sub>
	<p></p>
	1.1. Clone this project:
	<p></p>
	<pre>
	git clone https://github.com/scacela/oci-openfoam-workshop
	</pre>
	<p></p>
	1.2. Remove <b>oci-openfoam-workshop/pictures</b> and <b>oci-openfoam-workshop/.git</b> to eliminate excess data from the project, so that the project does not exceed the 11 MB size limit for uploading to Resource Manager: 
	<p></p>
	<pre>
	cd oci-openfoam-workshop
	rm -r pictures
	rm -rf .git
	</pre>
	1.3. Open a web browser and navigate to the <b>Create Stack</b> wizard in Resource Manager, in your preferred Compartment and Region:
	<p></p>
	<pre>
	cloud.oracle.com &gt sign into your OCI Tenancy &gt click Hamburger Menu &gt hover over <b>Resource Manager</b> &gt click <b>Stacks</b> &gt choose your Compartment from the dropdown menu under <b>List Scope</b> &gt click <b>Create Stack</b>
	</pre>
	<details>
		<summary>Navigate to the <b>Create Stack</b> wizard</summary>
	<div style="text-align:center"><img src="./pictures/pre-resourcemanager-deployment/02-resourcemanager-stacks.png"/>
	</div>
	<p></p>
	<div style="text-align:center"><img src="./pictures/pre-resourcemanager-deployment/03-resourcemanager-stack-listings.png"/>
	</div>
	<p></p>
	<div style="text-align:center"><img src="./pictures/pre-resourcemanager-deployment/04-resourcemanager-stack-wizard-before-upload.png"/>
	</div>
	</details>
	</pre>
	1.4. In the <b>Stack Information</b> section of the <b>Create Stack</b> wizard, click <b>Browse</b> under <b>Stack Configuration</b> and choose the <b>openfoam-workshop</b> folder (or .zip file), then click <b>Next</b>.
	<details>
		<summary>Stack wizard - <b>Stack Information</b> section</summary>
	<div style="text-align:center"><img src="./pictures/pre-resourcemanager-deployment/05-resourcemanager-stack-wizard-after-upload-folder.png"/>
	</div>
	<p>or</p>
	<div style="text-align:center"><img src="./pictures/pre-resourcemanager-deployment/06-resourcemanager-stack-wizard-after-upload-zipfile.png"/>
	</div>
	</details>
	1.5. In the <b>Configure Variables</b> section, do the following for the appropriate field:
	<p></p>
	- Select a Compartment where you have permissions to manage the resources that are mentioned in the <a href="#workshop-prerequisites">Prerequisites</a> section.
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
	<div style="text-align:center"><img src="./pictures/pre-resourcemanager-deployment/07-ssh-key-create-and-copy.png"/>
	</div>
	</details>
	- Select a shape for your Compute Instance.
	<p></p>
	The name of the shape indicates the number of cores that are available to that shape, e.g. the VM.Standard2.<b>8</b> shape has <b>8</b> cores available.
	<p></p>
	- Select the number representing the Availability Domain (AD) in which the infrastructure will be provisioned.
	<p></p>
	Note that the availability of cores the shape that you use will vary between Availability Domains. The way to check resource availability is described in the <a href="#workshop-prerequisites">Prerequisites</a> section.
	When you are finished configuring your variables, click <b>Next</b>.
	<details>
		<summary>Stack wizard - <b>Configure Variables</b> section</summary>
	<div style="text-align:center"><img src="./pictures/pre-resourcemanager-deployment/08-resourcemanager-stack-wizard-variables.png"/>
	</div>
	</details>
	1.6. In the <b>Review</b> section, click <b>Create</b>.
	<details>
		<summary>Stack wizard - <b>Review</b> section</summary>
	<div style="text-align:center"><img src="./pictures/pre-resourcemanager-deployment/09-resourcemanager-stack-wizard-review.png"/>
	</div>
	</details>
	1.7. On the <b>Stack Details</b> page, Under <b>Terraform Actions</b> dropdown menu, click <b>Apply</b> > <b>Apply</b> to provision the infrastructure.
	<details>
		<summary>Provision the infrastructure</summary>
	<div style="text-align:center"><img src="./pictures/pre-resourcemanager-deployment/10-resourcemanager-stack-apply-1.png"/>
	</div>
	<p></p>
	<div style="text-align:center"><img src="./pictures/pre-resourcemanager-deployment/11-resourcemanager-stack-apply-2.png"/></div>
	</details>
	<details>
		<summary>Resource Manager - <b>Apply</b> job in progress</summary>
	<div style="text-align:center"><img src="./pictures/pre-resourcemanager-deployment/12-resourcemanager-job-in-progress-apply.png"/>
	</div>
	</details>
2. Wait for the infrastructure to finish provisioning.
	From the left side of the page, you can monitor the logs of the Resource Manager job while the job is running, or check the variables, and after the Resource Manager job completes, you can obtain the output values.<!-- \
	<sub><sup><sub>:clock3:</sub></sup></sub>
	&nbsp;
	<sub>~45 minutes with BM.Standard2.52 shape</sub>\ -->\
	<sub><sup><sub>:clock3:</sub></sup></sub>
	&nbsp;
	<sub>~60 minutes with VM.Standard2.16 shape</sub>\
	<sub><sup><sub>:clock3:</sub></sup></sub>
	&nbsp;
	<sub>~75 minutes with VM.Standard2.8 shape</sub>
	<p></p>
	<details>
		<summary>Resource Manager - Logs</summary>
	<div style="text-align:center"><img src="./pictures/post-resourcemanager-deployment/01-resourcemanager-logs.png"/>
	</div>
	</details>
	<details>
		<summary>Resource Manager - Variables</summary>
	<div style="text-align:center"><img src="./pictures/post-resourcemanager-deployment/02-resourcemanager-variables.png"/>
	</div>
	</details>
	<details>
		<summary>Resource Manager - <b>Apply</b> job complete</summary>
	<div style="text-align:center"><img src="./pictures/post-resourcemanager-deployment/00-resourcemanager-job-complete-apply.png"/>
	</div>
	</details>
	<details>
		<summary>Resource Manager - Outputs</summary>
	<div style="text-align:center"><img src="./pictures/post-resourcemanager-deployment/03-resourcemanager-outputs.png"/>
	</div>
	</details>
3.	Connect to your remote host via VNC.\
	<sub><sup><sub>:clock3:</sub></sup></sub>
	&nbsp;
	<sub>~5 minutes</sub>
	<p></p>
	3.1. Establish a port mapping from port 5901 on your local machine to port 5901 on the remote host. You can find the public IP address of your remote host from the Outputs section on the left side of the screen after the Resource Manager job has completed.
	<p></p>
	<pre>
	# if the private SSH key is in default location, ~/.ssh/id_rsa
	ssh -L 5901:localhost:5901 opc@<b>REMOTE_HOST_IP_ADDRESS</b>
	&nbsp;
	# if the private SSH key is in a different location, execute:
	ssh -i <b>SSH_PRIVATE_KEY_PATH</b> -L 5901:localhost:5901 opc@<b>REMOTE_HOST_IP_ADDRESS</b>
	</pre>
	<p></p>
	3.2. Execute the following command on your remote machine to launch a VNCServer instance on port 5901 on the remote host:
	<p></p>
	<pre>
	vncserver
	</pre>
	<details>
		<summary>Port mapping from localhost to remote host</summary>
	<div style="text-align:center"><img src="./pictures/post-resourcemanager-deployment/04-vnc-connection-port-mapping.png"/>
	</div>
	</details>
	3.2. On your local machine, open VNC Viewer.
	3.3. Enter <b>localhost:5901</b> into the search bar and press return.
	<details>
		<summary>VNC Viewer</summary>
	<div style="text-align:center"><img src="./pictures/post-resourcemanager-deployment/05-vnc-connection-vnc-viewer.png"/>
	</div>
	</details>
	3.4. Enter the password <b>HPC_oci1</b> when prompted.
	<details>
		<summary>Enter VNC password</summary>
	<div style="text-align:center"><img src="./pictures/post-resourcemanager-deployment/06-vnc-connection-enter-password.png"/>
	</div>
	</details>
	3.5. Click through the default options (<b>Next</b>, <b>Skip</b>) to get to the end with the VNC setup wizard:
	<p></p>
	<pre>
	language options &gt keyboard layout options &gt location services options &gt connect online accounts options
	</pre>
	<details>
		<summary>GUI desktop options - choose language</summary>
	<div style="text-align:center"><img src="./pictures/post-resourcemanager-deployment/07-vnc-connection-choose-language.png"/>
	</div>
	</details>
4.	Visualize the simulation using ParaView.\
	<sub><sup><sub>:clock3:</sub></sup></sub>
	&nbsp;
	<sub>~5 minutes</sub>
	<p></p>
	4.1. Open Terminal from your VNC Viewer window:
	<p></p>
	<pre>
	click <b>Applications</b> &gt hover over <b>System Utilities</b> &gt click <b>Terminal</b>
	</pre>
	<details>
		<summary>Navigate to Terminal on the remote host</summary>
	<div style="text-align:center"><img src="./pictures/post-resourcemanager-deployment/08-vnc-connection-nav-to-terminal.png"/>
	</div>
	</details>
	4.2. Open Paraview by executing the following command from the Terminal instance in your VNC Viewer window:
	<p></p>
	<pre>
	paraview
	</pre>
	<details>
		<summary>Run ParaView on the remote host</summary>
	<div style="text-align:center"><img src="./pictures/post-resourcemanager-deployment/09-vnc-connection-run-paraview.png"/>
	</div>
	</details>
	4.3. In ParaView, open the motorbike.foam file:
	<p></p>
	<pre>
	File > Open > choose <b>/mnt/volb/work/motorbike.foam</b>
	</pre>
	<details>
		<summary>Open motorbike.foam in ParaView</summary>
	<div style="text-align:center"><img src="./pictures/post-resourcemanager-deployment/10-paraview-open-motorbike-file.png"/>
	</div>
	</details>
	4.4. Under the <b>Properties</b> pane on the left side of Paraview, select <b>Mesh Regions</b> to select everything, and then deselect the options that do not start with the string <b>motorBike_</b>. You can adjust the windows to make this section of the GUI easier to access e.g. by closing <b>PipeLine Browser</b> section by clicking <b>X</b>.
	<details>
		<summary>Before selection of <b>motorBike_</b> options</summary>
		<div style="text-align:center"><img src="./pictures/post-resourcemanager-deployment/11-paraview-before-select.png"/>
		</div>
	</details>
	<details>
		<summary>After selection of <b>motorBike_</b> options</summary>
	<div style="text-align:center"><img src="./pictures/post-resourcemanager-deployment/12-paraview-after-select.png"/>
	</div>
	</details>
	4.5. Click the green <b>Apply</b> button to render the motorbike image. If a window with a list of errors appears, titled <b>Output Messages</b>, you may close it.
	<p></p>
	4.6. The motorbike model should appear in the large window titled <b>RenderView1</b>. Use your mouse and its left-click button to manipulate it in virtual 3D space!
	<details>
		<summary>Motorbike model</summary>
	<div style="text-align:center"><img src="./pictures/post-resourcemanager-deployment/13-paraview-motorbike.png"/>
	</div>
	</details>
5.	Launch a job via Resource Manager that deprovisions the
	infrastructure.\
	<sub><sup><sub>:clock3:</sub></sup></sub>
	&nbsp;
	<sub>~5 minutes</sub>
	<p></p>
	5.1. From your web browser, navigate to the Stack listings page in Resource Manager, in the same Compartment and Region where your Stack was deployed:
	<p></p>
	<pre>
	cloud.oracle.com &gt sign into your OCI Tenancy &gt click Hamburger Menu &gt hover over <b>Resource Manager</b> &gt click <b>Stacks</b> &gt choose your Compartment from the dropdown menu under <b>List Scope</b>
	</pre>
	<details>
		<summary>Navigate to the Stack listings page</summary>
	<div style="text-align:center"><img src="./pictures/post-resourcemanager-deployment/14-resourcemanager-stack-listings.png"/>
	</div>
	</details>
	5.2. On the <b>Stack Details</b> page, Under <b>Terraform Actions</b> dropdown menu, click <b>Destroy</b> > <b>Destroy</b> to deprovision the infrastructure.
	<details>
		<summary>Deprovision the infrastructure</summary>
	<div style="text-align:center"><img src="./pictures/post-resourcemanager-deployment/15-resourcemanager-destroy-1.png"/>
	</div>
	<p></p>
	<div style="text-align:center"><img src="./pictures/post-resourcemanager-deployment/16-resourcemanager-destroy-2.png"/></div>
	</details>
	<details>
		<summary>Resource Manager - <b>Destroy</b> job in progress</summary>
	<div style="text-align:center"><img src="./pictures/post-resourcemanager-deployment/17-resourcemanager-job-in-progress-destroy.png"/>
	</div>
	</details>
	<details>
		<summary>Resource Manager - <b>Destroy</b> job complete</summary>
	<div style="text-align:center"><img src="./pictures/post-resourcemanager-deployment/18-resourcemanager-job-complete-destroy.png"/>
	</div>
	</details>

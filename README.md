# oci-openfoam-workshop

### Motorbike Simulation on Oracle Cloud Infrastructure (OCI)
![](./pictures/motorbike.png)

### Workshop Prerequisites
- [VNC Viewer](https://www.realvnc.com/en/connect/download/viewer/) on your local machine as a client application for VNCServer.

### Workshop Steps
###### <p align="right">Total Time: 1-1.5 hours</p>
1. Launch a job via Resource Manager that provisions the infrastructure on OCI by deploying the **openfoam-workshop** project.\
	<sub><sup><sub>:clock3:</sub></sup></sub>
	&nbsp;
	<sub>~10 minutes</sub>\
	\
	1.1. Clone this project:
	<pre>
	git clone https://github.com/scacela/oci-openfoam-workshop
	</pre>
	1.2. Open a web browser and navigate to the **Create Stack** wizard in Resource Manager, in your Compartment:
	<pre>
	cloud.oracle.com &gt sign into your OCI Tenancy (account) &gt click Hamburger Menu &gt hover over <b>Resource Manager</b> &gt click <b>Stacks</b> &gt choose your Compartment from the dropdown menu under **List Scope** &gt click <b>Create Stack</b>
	</pre>
	1.3. In the **Stack Information** section of the **Create Stack** wizard, click **Browse** under **Stack Configuration** and choose the **openfoam-workshop** folder (or .zip file), then click **Next**.\
	1.4. In the **Configure Variables** section, choose:
	- Your Compartment ID.
	- Paste the contents of your SSH Public Key file. The default location of your SSH Public key file on your machine is **~/.ssh/id_rsa.pub**. You can copy these contents to your clipboard from your Mac OS local machine by executing:
		<pre>
		pbcopy < ~/.ssh/id_rsa.pub
		# then paste with CMD+V
		</pre>
		or
		<pre>
		cat ~/.ssh/id_rsa.pub
		# capture the output manually with CMD+C, then paste with CMD+V
		</pre>
	You can generate a new key pair on Mac OS if necessary by executing:
		<pre>
		ssh-keygen
		</pre>
	on your Mac OS or Linux machine and choosing the default options.
	- The shape of your Compute instance
	- The Availability Domain (AD) number. Note that the availability of the shape that you use will vary between Availability Domains. You can check the shape limits by navigating from:
		<pre>
		Hamburger Menu > Identity > Governance > Limits, Quotas and Usage.
		</pre>
	1.5. In the **Review** section, click **Create**.\
	1.6. On the **Stack Details** page, Under **Terraform Actions** dropdown menu, click **Apply** > **Apply**.
2. Wait for the infrastructure to finish provisioning. You can monitor the logs on the left side of the page, where output information will appear when the Resource Manager job finishes.\
	<sub><sup><sub>:clock3:</sub></sup></sub>
	&nbsp;
	<sub>~45 minutes with BM.Standard2.52 shape</sub>\
	<sub><sup><sub>:clock3:</sub></sup></sub>
	&nbsp;
	<sub>~75 minutes with VM.Standard2.8 shape</sub>

3.	Connect to your remote host via VNC.\
	<sub><sup><sub>:clock3:</sub></sup></sub>
	&nbsp;
	<sub>~5 minutes</sub>\
	\
	3.1. Execute the following command from your local machine to map port 5901 on localhost to port 5901 on the remote host:
	<pre>
	ssh -L 5901:localhost:5901 opc@<b>REMOTE_HOST_IP_ADDRESS</b>
	</pre>
	3.2. Execute the following command on your remote machine to launch a VNCServer instance on port 5901 on the remote host:
	<pre>
	vncserver
	</pre>
	3.2. On your local machine, open the client application for VNC, VNC Viewer.\
	3.3. Enter **localhost:5901** into the searchbar and press return.\
	3.4. Enter the password **HPC_oci1** when prompted.\
	3.5. Click through the default options (**Next**, **Skip**) to get to the end with the VNC setup wizard:
	<pre>
	language options > keyboard layout options > location services options > connect online accounts options
	</pre>
4.	Visualize the Motorbike simulation using ParaView.\
	<sub><sup><sub>:clock3:</sub></sup></sub>
	&nbsp;
	<sub>~5 minutes</sub>\
	\
	4.1. Open Terminal from your VNC Viewer window:
	<pre>
	click Applications &gt hover over System Utilities &gt click Terminal
	</pre>
	4.2. Open Paraview by executing the following command from the Terminal instance in your VNC Viewer window:
	<pre>
	/mnt/volb/ParaView/bin/paraview
	</pre>
	4.3. In ParaView, open the motorbike.foam file:
	<pre>
	click File > Open > choose /mnt/volb/work/motorbike.foam
	</pre>
	4.4. Under the **Properties** pane on the left side of Paraview, select **Mesh Regions** to select everything, and then deselect the options that do not start with the string **motorBike_**. You can adjust the windows to make this section of the GUI easier to access e.g. by closing **PipeLine Browser** section by clicking **X**.\
	4.5. Click the green **Apply** button to render the motorbike image. If a window with a list of errors appears, titled **Output Messages**, you may close it.\
	4.6. Use your mouse and its left-click button to manipulate the virtual motorbike that appears.

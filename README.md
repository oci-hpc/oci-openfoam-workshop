# oci-openfoam-workshop

## Motorbike Simulation on Oracle Cloud Infrastructure (OCI)

1. Deploy the **openfoam-workshop** project on OCI via Resource Manager (~45 minutes):\
	1.1. Clone this project:
	<pre>
	git clone https://github.com/scacela/oci-openfoam-workshop
	</pre>
	1.2. Open a web browser and navigate to the **Create Stack** wizard in Resource Manager:
	<pre>
	cloud.oracle.com &gt sign into your OCI account &gt click Hamburger Menu &gt hover over <b>Resource Manager</b> &gt click <b>Stacks</b> &gt click <b>Create Stack</b>
	</pre>
	1.3. In the **Stack Information** section of the **Create Stack** wizard, click **Browse** under **Stack Configuration** and choose the **openfoam-workshop** folder (or .zip file), then click **Next**.\
	1.4. In the **Configure Variables** section, choose:
	- Your Compartment ID.
	- Paste the contents of your SSH Public Key file. Its default location on your machine is **~/.ssh/id_rsa.pub**. You can generate a new key pair if necessary by executing:
		<pre>
		ssh-keygen
		</pre>
	on your Mac or Linux machine and choosing the default options.
	- The shape of your Compute instance
	- The Availability Domain (AD) number. Note that the availability of the shape that you use will vary between Availability Domains. You can check the shape limits by navigating from:
		<pre>
		Hamburger Menu > Identity > Governance > Limits, Quotas and Usage.
		</pre>
	1.5. In the **Review** section, click **Create**.\
	1.6. On the **Stack Details** page, Under **Terraform Actions** dropdown menu, click **Apply** &gt **Apply**.\
	1.7. Wait ~37 minutes for your project to deploy. You can monitor the logs on the left side of the page, where output information will appear when the project finishes deploying.\
2.	Connect to your remote host via VNC:\
	2.1. Execute the following command from your local machine to map port 5901 on localhost to port 5901 on the remote host:
	<pre>
	ssh -L 5901:localhost:5901 opc@REMOTE_HOST_IP_ADDRESS
	</pre>
	2.2. Open the client application for VNC, VNC Viewer.\
	2.3. Enter **localhost:5901** into the searchbar and press return.\
	2.4. Enter the password **HPC_oci1** when prompted.\
	2.5. Click through the default options (**Next**, **Skip**) to get to the end with the VNC setup wizard:
	<pre>
	language options > keyboard layout options > location services options > connect online accounts options
	</pre>
3.	Run the Motorbike simulation in ParaView:\
	3.1. Open Terminal from your VNC window:
	<pre>
	click Applications &gt hover over System Utilities &gt click Terminal
	</pre>
	3.2. Open Paraview by executing the following command:
	<pre>
	/mnt/volb/ParaView/bin/paraview
	</pre>
	3.3. Open the motorbike.foam file in ParaView:
	<pre>
	click File > Open > choose /mnt/volb/work/motorbike.foam
	</pre>
	3.4. Under the **Properties** pane on the left side of Paraview, select **Mesh Regions** to select everything, and then deselect the options that do not start with the string **motorBike_**. You can adjust the windows to make this section of the GUI easier to access e.g. by closing **PipeLine Browser** section by clicking **X**.\
	3.5. Click the green **Apply** button to render the motorbike image. If a window with a list of errors appears, titled **Output Messages**, you may close it.\
	3.6. Use your mouse and its left-click button to manipulate the virtual motorbike that appears.

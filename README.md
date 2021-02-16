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

### Visualize on OCI

1.	Connect to your remote host via VNC.\
	<sub><sup><sub>:clock3:</sub></sup></sub>
	&nbsp;
	<sub>~5 minutes</sub>
	<p></p>
	1.1. Establish a port mapping from port 5901 on your local machine to port 5901 on the remote host. You can find the public IP address of your remote host from the Outputs section on the left side of the screen after the Resource Manager job has completed.
	<p></p>
	<pre>
	# if the private SSH key is in default location, ~/.ssh/id_rsa
	ssh -L 5901:localhost:5901 opc@<b>REMOTE_HOST_IP_ADDRESS</b>
	&nbsp;
	# if the private SSH key is in a different location, execute:
	ssh -i <b>SSH_PRIVATE_KEY_PATH</b> -L 5901:localhost:5901 opc@<b>REMOTE_HOST_IP_ADDRESS</b>
	</pre>
	<p></p>
	1.2. Execute the following command on your remote machine to launch a VNCServer instance on port 5901 on the remote host:
	<p></p>
	<pre>
	vncserver
	</pre>
	<details>
		<summary>Port mapping from localhost to remote host</summary>
	<div style="text-align:center"><img src="./pictures/post-resourcemanager-deployment/04-vnc-connection-port-mapping.png"/>
	</div>
	</details>
	1.3. On your local machine, open VNC Viewer.
	1.4. Enter <b>localhost:5901</b> into the search bar and press return.
	<details>
		<summary>VNC Viewer</summary>
	<div style="text-align:center"><img src="./pictures/post-resourcemanager-deployment/05-vnc-connection-vnc-viewer.png"/>
	</div>
	</details>
	1.5. Enter the password <b>HPC_oci1</b> when prompted.
	<details>
		<summary>Enter VNC password</summary>
	<div style="text-align:center"><img src="./pictures/post-resourcemanager-deployment/06-vnc-connection-enter-password.png"/>
	</div>
	</details>
	1.6. Click through the default options (<b>Next</b>, <b>Skip</b>) to get to the end with the VNC setup wizard:
	<p></p>
	<pre>
	language options &gt keyboard layout options &gt location services options &gt connect online accounts options
	</pre>
	<details>
		<summary>GUI desktop options - choose language</summary>
	<div style="text-align:center"><img src="./pictures/post-resourcemanager-deployment/07-vnc-connection-choose-language.png"/>
	</div>
	</details>
2.	Visualize the simulation using ParaView.\
	<sub><sup><sub>:clock3:</sub></sup></sub>
	&nbsp;
	<sub>~5 minutes</sub>
	<p></p>
	2.1. Open Terminal from your VNC Viewer window:
	<p></p>
	<pre>
	click <b>Applications</b> &gt hover over <b>System Utilities</b> &gt click <b>Terminal</b>
	</pre>
	<details>
		<summary>Navigate to Terminal on the remote host</summary>
	<div style="text-align:center"><img src="./pictures/post-resourcemanager-deployment/08-vnc-connection-nav-to-terminal.png"/>
	</div>
	</details>
	2.2. Open Paraview by executing the following command from the Terminal instance in your VNC Viewer window:
	<p></p>
	<pre>
	paraview
	</pre>
	<details>
		<summary>Run ParaView on the remote host</summary>
	<div style="text-align:center"><img src="./pictures/post-resourcemanager-deployment/09-vnc-connection-run-paraview.png"/>
	</div>
	</details>
	2.3. In ParaView, open the motorbike.foam file:
	<p></p>
	<pre>
	File > Open > choose <b>/mnt/volb/work/motorbike.foam</b>
	</pre>
	<details>
		<summary>Open motorbike.foam in ParaView</summary>
	<div style="text-align:center"><img src="./pictures/post-resourcemanager-deployment/10-paraview-open-motorbike-file.png"/>
	</div>
	</details>
	2.4. Under the <b>Properties</b> pane on the left side of Paraview, select <b>Mesh Regions</b> to select everything, and then deselect the options that do not start with the string <b>motorBike_</b>. You can adjust the windows to make this section of the GUI easier to access e.g. by closing <b>PipeLine Browser</b> section by clicking <b>X</b>.
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
	2.5. Click the green <b>Apply</b> button to render the motorbike image. If a window with a list of errors appears, titled <b>Output Messages</b>, you may close it.
	<p></p>
	2.6. The motorbike model should appear in the large window titled <b>RenderView1</b>. Use your mouse and its left-click button to manipulate it in virtual 3D space!
	<details>
		<summary>Motorbike model</summary>
	<div style="text-align:center"><img src="./pictures/post-resourcemanager-deployment/13-paraview-motorbike.png"/>
	</div>
	</details>


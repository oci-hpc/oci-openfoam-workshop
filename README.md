# oci-openfoam-workshop

## Motorbike Simulation on Oracle Cloud Infrastructure (OCI)

1. Deploy the "openfoam-workshop" project on OCI via Resource Manager (~45 minutes):\
	1.1. Navigate to the Create Stack wizard in Resource Manager:\
```
cloud.oracle.com > sign into your OCI account > click Hamburger Menu > hover over "Resource Manager" > click "Stacks" > click "Create Stack"
```
	1.2. In the "Stack Information" section of the "Create Stack" wizard, click "Browse" under "Stack Configuration" and choose the "openfoam-workshop" folder, then click "Next"\
	c.	In the "Configure Variables" section, choose your Compartment ID, paste the contents of your SSH Public Key file (its default location on your machine is ~/.ssh/id_rsa.pub. You can generate a new key pair if necessary by executing "ssh-keygen" on your Mac or Linux machine and choosing the default options). Then choose the shape of your Compute instance, and the Availability Domain (AD) number. Note that the availability of the shape that you use will vary between Availability Domains. You can check the shape limits by navigating from Hamburger Menu > Identity > Governance > Limits, Quotas and Usage.\
	d.	In the "Review" section, click "Create".\
	e.	On the "Stack Details" page, Under "Terraform Actions" dropdown menu, click "Apply" > "Apply".\
	f.	Wait ~37 minutes for your project to deploy. You can monitor the logs on the left side of the page, where output information will appear when the project finishes deploying.
2.	Connect to your remote host via VNC:\
	a.	Execute the following command from your local machine to map port 5901 on localhost to port 5901 on the remote host:
	<pre>
	ssh -L 5901:localhost:5901 opc@REMOTE_HOST_IP_ADDRESS
	</pre>
	c.	Open the client application for VNC, VNC Viewer\
	d.	Enter "localhost:5901" into the searchbar and press return\
	e.	Enter the password "HPC_oci1" when prompted\
	f.	Click through the default options to get to the end with the VNC setup wizard (choose "Next" for language, keyboard layout, location services, and "Skip" for connect online accounts)
3.	Run the Motorbike simulation in ParaView:\
	a.	Open Terminal from your VNC window by clicking Applications > hover over System Utilities > click Terminal\
	b.	Open Paraview by executing the following command:
	<pre>
	/mnt/volb/ParaView/bin/paraview
	</pre>
	c.	Open the motorbike.foam file in ParaView by clicking File > Open > choose motorbike.foam\
	d.	Under the "Properties" pane on the left side of Paraview, select "Mesh Regions" to select everything, and then deselect the options that do not start with the string "motorBike_". You can adjust the windows to make this section of the GUI easier to access e.g. by closing "PipeLine Browser" section by clicking "X".\
	e.	Click the green "Apply" button to render the motorbike image. If a window with a list of errors appears, titled "Output Messages", you may close it.\
	f.	Use your mouse and its left-click button to manipulate the virtual motorbike that appears.

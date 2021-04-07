CLI Documentation

In this lab, you will deploy an HPC cluster network using the OCI Command Line Interface (CLI). The bastion node of this cluster comes with OpenFoam, a computational fluid dynamic software, pre-installed. In the first section you will install the latest version of ocihpc, which is a tool for simplifying deployments of HPC applications in OCI. You will then generate the necessary ssh keys, API signing keys, and configuration file to enable the HPC CLI. Afterwards, you will download the IntelWorkshop stack and set up the configuration file specific for this stack. Lastly, using a single command on the HPC CLI, you will deploy an HPC cluster network.



Step 1: Install ocihpc


Linux

1. Download the latest release with the following command and extract it:

	$ curl -LO https://github.com/oracle-quickstart/oci-ocihpc/releases/download/v1.0.2/ocihpc_v1.0.2_linux_x86_64.tar.gz

2. Run the following command to unzip the downloaded file using tar:

	$ tar -xf ocihpc_v1.0.2_linux_x86_64.tar.gz

3. Make the ocihpc binary executable by running:

	$ chmod +x ./ocihpc

4. Move the ocihpc binary to your PATH:

	$ sudo mv ./ocihpc /usr/local/bin/ocihpc 

5. Test that it works. It should returm something like "ocihpc 1.0.2 darwin/amd64".

	$ ocihpc version


Mac OS

1. Download the latest release with the following command and extract it:

	$ curl -LO https://github.com/oracle-quickstart/oci-ocihpc/releases/download/v1.0.2/ocihpc_v1.0.2_darwin_x86_64.tar.gz

2. Run the following command to unzip the downloaded file using tar:

	$ tar -xf ocihpc_v1.0.2_darwin_x86_64.tar.gz

3. Make the ocihpc binary executable by running:

	$ chmod +x ./ocihpc

4. Move the ocihpc binary to your PATH:

	$ sudo mv ./ocihpc /usr/local/bin/ocihpc 

5. Test that it works. It should return something like "ocihpc 1.0.2 darwin/amd64".

	$ ocihpc version


Windows

1. Download the latest release from this link and extract it.

2. Add the ocihpc binary to your PATH using the following documentation.

3. Test that it works using the following command:

	$ ocihpc.exe version



Step 2: Create an SSH Key Pair


Please refer to this link if you are using windows.

1. Open Terminal and navigate to your home directory

	$ cd $home

2. Create a .ssh directory to store your credentials

	$ mkdir .ssh

3. Enter the following command to generate the ssh keypair:

	$ ssh-keygen

4. Press Enter when prompted with the file in which to save the key. Press Enter again to save the key with no passphrase. Within the .ssh directory, you have created a public/private ssh keypair. The public key is saved as id_rsa.pub, while the private key is saved as id_rsa.



Step 3: Generating an API Signing Key


1. Your API requests will be signed with your private key, and Oracle will use the public key to verify the authenticity of the request. Please refer to this link and scroll down to "Generating an API Signing Key (Windows)" section if you are using Windows.

2. Navigate back to the home directory, and create a .oci directory to store your credentials 

	$ cd $home

	$ mkdir .oci

3. Generate the private key using the following command.

	$ openssl genrsa -out ~/.oci/oci_api_key.pem 2048
4. Ensure that only you can read the private key file by running the following command:

	$ chmod go-rwx ~/.oci/oci_api_key.pem
5. Generate the public key using the following command:

	$ openssl rsa -pubout -in ~/.oci/oci_api_key.pem -out ~/.oci/oci_api_key_public.pem

6. Ensure that you have created both the public and private key by running ‘ls’ in your .oci directory. You should see two files, one being oci_api_key.pem and the other being oci_api_key_public.pem



Step 4: Add your Public API Signing Key to Oracle Cloud Infrastructure (OCI)


1. Now that you’ve generated both a private and public key, you must add it to the OCI Console under the user setting. 

2. Navigate to your .oci folder containing "oci_api_key_public.pem" and copy the key. You can do so by running the following command. It is important to note that you should include the -----BEGIN PUBLIC KEY----- and -----END PUBLIC KEY----- from the file. 

	$ cat oci_api_key_public.pem

3. Log into the OCI Console using the credentials provided. 

4. Click on the Avatar icon in the top right corner of the screen (pictured below). 

5. Select your user name. "Harrison" would be the username in this case.
 
6. Scroll down and click on "API Keys"
 
7. Now click on "Add Public Key" under API Keys section 

8. Paste the public key that you copied from your terminal, and click Add at the bottom  



Step 5: Configure the CLI with your OCI credentials


This step describes the required configuration for the Command Line Interface (CLI) tool and includes optional configurations that enable you to extend CLI functionality. 

1. Navigate back to the OCI console and go to where you created your API public key. Refer to step four to see how to navigate there.

2. Once you get there, you will see that a fingerprint has been generated for you (as shown in the image below)

3. In the image above, click the three dots on the right hand side and select "View Configuration File"

4. Copy the configuration file preview using the "Copy" button in the bottom right corner
 
5. Before using the CLI, you have to create the config file in your .oci folder that contains the required credentials for working with your Oracle Cloud Infrastructure account. You can do so by running the following commands in your terminal window.

	$ cd .oci

	$touch config

6. Now, paste the configuration file you copied from the OCI console into your local config file. You can edit the file using the following command:

	$ nano config

7. Once open, paste the appropriate content into the file. An example config file would look like this. Fill in the keyfile variable as /Users/<your_user_name>/.oci/oci_api_key.pem
 	 

8. Now you want to go ahead and exit out of the file. It is essential that you save the content before exiting. You can exit by pressing ‘ctrl+x’ on your keyboard. Then, press ‘y’ when prompted to save, and finally hit "Enter" to confirm the file directory. The default location will suffice.




Step 6: Import the Stack


1. Firstly, it’s important to note that you can get the list of available stacks by running the following command:

	$ ocihpc list

2. Now, create a folder that you will use as the deployment source. You should always use a different folder for each stack. Do not initialize more than one stack in the same folder. Otherwise, the tool will overwrite the previous one. 

	$ mkdir ocihpc-test

3. Now, change into the directory you created above by running the following command:

	$ cd ocihpc-test

4. Run the following command to download the stack (or you can open a browser, enter the URL and move the download to the current directory):

	$ wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/JwWMOqsi4ZBQihcMddyqyDzFrUFaQt0NK3mraOuezJc0pZMHsF_sboGPwid_-jqq/n/hpc_limited_availability/b/large_files/o/IntelWorkshop.zip



Step 7: Deploy the Stack


1. Before deploying, you need to create a file called config.json.

	$ nano config.json

2. Change the values config.json. The variables depend on the stack that you are deploying. You can paste the following JSON example into your config.json and adjust it according to your desired deployment parameters.
<pre>
    {
        "tenancy_ocid": "YOUR_TENANCY_OCID",
        "region": "us-phoenix-1",
        "compartment_ocid": "YOUR_COMPARTMENT_OCID",
        "ssh_public_key":"YOUR_SSH_PUBLIC_KEY",
        "compute_shape":"VM.Standard2.1",
        "ad_number":"1"
    }
</pre>

3. To modify your config.json file, navigate to your newly created directory, ocihpc-test, and open the config.json file using your preferred text editor. Note that this is not the same config file that we configured in Step 5. 

4. After you change the values in the config.json file, you can deploy the stack using the following command:
	<pre>
	ocihpc deploy –-stack IntelWorkshop –-compartment-id <your_compartment_ocid>
	</pre>
5. You can locate your Compartment OCID by following these steps:
	a. Log into your OCI tenancy using the credentials provided to you
	b. Click the hamburger menu in the top right-hand corner, and scroll down to IdentityCompartments
 	c. Copy your Compartment OCID by clicking the "Copy" button shown below
 
6. The ocihpc deploy command shown above will generate a deployment name that consists of <stack_name>-<current_directory>-<random_number>. The output to this command will look something like this:

	$ ocihpc deploy –-stack IntelWorkshop –-compartment-id <your_compartment_ocid>
  	Deploying IntelWorkshop-ocihpc-test-7355 [0min 0sec]
 	Deploying IntelWorkshop-ocihpc-test-7355 [0min 17sec]
 	Deploying IntelWorkshop-ocihpc-test-7355 [0min 35sec]



Step 8: Connect to the Stack


1. Once the deployment has completed, you will see the bastion/head node IP that you can connect to

	$ Successfully deployed IntelWorkshop-ocihpc-test-7355

	$ You can connect to your head node using the command: ssh opc@123.221.10.8 -i <location of the private ssh key you created in the .ssh directory>



Step 9: [Visualize on OCI](https://github.com/oci-hpc/oci-openfoam-workshop/blob/oci-hpc/README.md)


Step 10: Delete the Stack


1. When you are done with your deployment, you can delete the stack by changing to the stack directory and running the following command:

	$ ocihpc delete –-stack IntelWorkshop

2. The output will look something like this:

	Deleting IntelWorkshop-ocihpc-test-7355 [0min 0sec]
	Deleting IntelWorkshop-ocihpc-test-7355 [0min 17sec]
	Deleting IntelWorkshop-ocihpc-test-7355 [0min 35sec]
	…
	Successfully deleted IntelWorkshop-ocihpc-test-7355


All done! You have successfully deployed your first High Performance Compute (HPC) Instance using the OCI Command Line Interface (CLI) tool. 

These are detailed information about managing HPC instances. For a complete command reference, check out additional OCI documentation here.

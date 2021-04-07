# Command Line
###### <p align="right">Total Time: 40 minutes (excluding Visualization)</p>

### Summary
In this section, you will deploy the motorbike model stack using ocihpc, an HPC stack deployment tool for CLI. Ocihpc simplifies deployments of applications in OCI.

In this lab, you will download ocihpc, then generate the necessary credentials for interacting with the OCI API (i.e. API signing keys, OCI API configuration file), then download the stack project file using ocihpc, then configure the ocihpc
In the first part of this lab, you will download the latest version of ocihpc. Then you will then generate the necessary ssh keys, API signing keys, and configuration file to enable proper API access to OCI. Afterward, you will download the IntelWorkshop stack using ocihpc, and set up the ocihpc stack configuration file according to your deployment parameters. Then you will deploy the stack via ocihpc, visualize the motorbike model in 3D virtual space, and finally deprovision the stack via ocihpc.



### Step 1. Install ocihpc
<p></p>
<sub><sup><sub>:clock3:</sub></sup></sub>
&nbsp;
<sub>~2 minutes</sub>
<p></p>
<details>
<summary>Linux</summary>

1. Download the latest release with the following command and extract it:

<pre>
curl -LO https://github.com/oracle-quickstart/oci-ocihpc/releases/download/v1.0.2/ocihpc_v1.0.2_linux_x86_64.tar.gz
</pre>

2. Run the following command to unzip the downloaded file using tar:

<pre>
tar -xf ocihpc_v1.0.2_linux_x86_64.tar.gz
</pre>

3. Make the ocihpc binary executable by running:

<pre>
chmod +x ./ocihpc
</pre>
4. Move the ocihpc binary to your PATH:

<pre>
sudo mv ./ocihpc /usr/local/bin/ocihpc 
</pre>

5. Test that it works. It should returm something like "ocihpc 1.0.2 darwin/amd64".

<pre>
ocihpc version
</pre>

</details>

<details>
<summary>Mac OS</summary>

1. Download the latest release with the following command and extract it:

<pre>
curl -LO https://github.com/oracle-quickstart/oci-ocihpc/releases/download/v1.0.2/ocihpc_v1.0.2_darwin_x86_64.tar.gz
</pre>

2. Run the following command to unzip the downloaded file using tar:

<pre>
tar -xf ocihpc_v1.0.2_darwin_x86_64.tar.gz
</pre>

3. Make the ocihpc binary executable by running:

<pre>
chmod +x ./ocihpc
</pre>

4. Move the ocihpc binary to your PATH:

<pre>
sudo mv ./ocihpc /usr/local/bin/ocihpc 
</pre>

5. Test that it works. It should return something like "ocihpc 1.0.2 darwin/amd64".

<pre>
ocihpc version
</pre>

</details>

<details>
<summary>Windows</summary>

1. Download the latest release from [this link](https://github.com/oracle-quickstart/oci-ocihpc/releases/download/v1.0.2/ocihpc_v1.0.2_windows_x86_64.zip) and extract it.

2. Add the ocihpc binary to your PATH using the following documentation.

3. Test that it works using the following command:
<pre>
ocihpc.exe version
</pre>

</details>

### Step 2: Create an SSH key pair
<p></p>
<sub><sup><sub>:clock3:</sub></sup></sub>
&nbsp;
<sub>~2 minutes</sub>
<p></p>

<details>
<summary>Unix-based OS</summary>

Please refer to the following steps if you are using a Unix-based OS.

1. Open Terminal and navigate to your home directory

</pre>
cd
</pre>

2. Create a directory called .ssh to store your SSH credentials.

<pre>
mkdir -p .ssh
</pre>

3. Enter the following command to generate the SSH key pair:

<pre>
ssh-keygen
</pre>

4. Press Enter when prompted with the file in which to save the key. Press Enter again to save the key with no passphrase. Within the .ssh directory, you have created one public and one private SSH key pair. The public key is saved as id_rsa.pub, while the private key is saved as id_rsa.

</details>

<details>
<summary>Windows</summary>

Please refer to [this link](https://docs.joyent.com/public-cloud/getting-started/ssh-keys/generating-an-ssh-key-manually/manually-generating-your-ssh-key-in-windows) if you are using Windows.

</details>


### Step 3: Generate an OCI API signing key pair
<p></p>
<sub><sup><sub>:clock3:</sub></sup></sub>
&nbsp;
<sub>~2 minutes</sub>
<p></p>

Your API requests will be signed with your private API signing key, and Oracle will use the public API signing key to verify the authenticity of the request. 

<details>
<summary>Unix-based OS</summary>

Please refer to the following steps if you are using a Unix-based OS.

1. Navigate to the home directory

<pre>
cd
</pre>

2. Create a directory called .oci directory to store your OCI API credentials.

<pre>
mkdir .oci
</pre>

3. Generate the private API signing key using the following command.

<pre>
openssl genrsa -out ~/.oci/oci_api_key.pem 2048
</pre>

4. Ensure that only your current user can read the private API signing key file by executing:

<pre>
chmod go-rwx ~/.oci/oci_api_key.pem
</pre>

5. Generate the public API signing key using the following command:

<pre>
openssl rsa -pubout -in ~/.oci/oci_api_key.pem -out ~/.oci/oci_api_key_public.pem
</pre>

6. Ensure that you have created both the public and private API signing keys by running 'ls' in your .oci directory. You should see two files, one named "oci_api_key.pem" and the other named "oci_api_key_public.pem".

</details>

<details>
<summary>Windows</summary>

Please refer to [this link](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/apisigningkey.htm#Required_Keys_and_OCIDs) and scroll down to "Generating an API Signing Key (Windows)" section if you are using Windows.

</details>



### Step 4: Register your Public API signing key to your OCI User
<p></p>
<sub><sup><sub>:clock3:</sub></sup></sub>
&nbsp;
<sub>~5 minutes</sub>
<p></p>

1. Now that you’ve generated a API signing key pair, you must add your public API signing key to the OCI portal under your User page. 

2. [Navigate to the OCI portal](https://www.cloud.oracle.com) and sign in with your OCI credentials.

3. Click on the Avatar icon in the top right corner of the screen to access your Profile menu. 

4. On the Profile menu, click the line that reads as your User's name. This will take you to the User page.
 
5. On the User page, scroll down and click "API Keys" at the bottom left of the screen.
 
6. Click "Add Public Key", and then choose "Paste Public Key".

7. On your local machine, open the CLI and copy the public API signing key that you created. It is important to note that you include the -----BEGIN PUBLIC KEY----- and -----END PUBLIC KEY----- from the file.

<pre>
cat ~/.oci/oci_api_key_public.pem
</pre>

8. Paste the public API signing key into the text field, and then click Add at the bottom.



### Step 5: Create your OCI API configuration file
<p></p>
<sub><sup><sub>:clock3:</sub></sup></sub>
&nbsp;
<sub>~5 minutes</sub>
<p></p>

This step describes the required configuration for ocihpc, and includes optional configurations that enable you to extend CLI functionality. 

1. Navigate back to the OCI console and go to the User page, where you created your public API signing key. Refer to Step 4 to see how to navigate there.

2. On the User page, you will see that a listing has appeared for a Fingerprint that was generated when you registered your public API signing key.

3. On the right-hand side of the Fingerprint listing, click the three dots and click "View Configuration File".

4. Copy the configuration file preview using the "Copy" button in the bottom right-hand corner of the "Configuration File Preview" window that pops up.
 
5. Before using the ocihpc, you have to create the configuration file in your .oci folder that contains the required credentials for accessing OCI APIs through your OCI account. You can do this by executing:

<pre>
touch ~/.oci/config
</pre>

6. Paste the configuration file you copied from the OCI console into the OCI API configuration file on your local machine. You can edit the file using the following command:

<pre>
nano config
</pre>
	
7. Paste the content that you copied from the "Configuration File Preview" pop-up window into the file. Your OCI API configuration file should look like the code snippet below.

<pre>
[DEFAULT]
user=YOUR_USER_OCID
fingerprint=YOUR_FINGERPRINT
tenancy=YOUR_TENANCY_OCID
region=YOUR_REGION_IDENTIFIER
key_file=~/.oci/oci_api_key.pem
</pre>
 	 

8. Save and close out of the OCI API configuration file.



### Step 6: Initialize the IntelWorkshop stack using ocihpc
<p></p>
<sub><sup><sub>:clock3:</sub></sup></sub>
&nbsp;
<sub>~2 minutes</sub>
<p></p>

1. Firstly, it’s important to note that you can get the list of available stacks by running the following command:

<pre>
ocihpc list
</pre>

2. Create a folder that you will use as the deployment source. You should always use a different folder for each stack. Do not initialize more than one stack in the same folder. Otherwise, the tool will overwrite the previous stack. 

<pre>
mkdir ocihpc-test
</pre>

3. Change into the directory you created above:

<pre>
cd ocihpc-test
</pre>

4. Run the following command to download the stack:

<pre>
ocihpc init --stack IntelWorkshop
</pre>



### Step 7: Deploy the Stack
<p></p>
<sub><sup><sub>:clock3:</sub></sup></sub>
&nbsp;
<sub>~20 minutes</sub>
<p></p>


1. Notice that an ocihpc stack configuration file named "config.json" was generated when you initialized the IntelWorkshop stack. This is a JSON file. Open the file for editing, e.g. with "nano config.json", and populate the values with your own stack deployment parameters. The contents will appear similar to the following code snippet.

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

Populate <b>config.json</b> according to your 
<p></p>
- Get the OCID of the Compartment where you have permissions to manage the resources that are mentioned in the Prerequisites section on the [main Readme](https://github.com/oci-hpc/oci-openfoam-workshop/blob/oci-hpc/README.md). You can locate your Compartment OCID by following these steps:

	a. Log into your OCI tenancy using the credentials provided to you

	b. Click the hamburger menu in the top right-hand corner, and scroll down to Identity > Compartments

	c. Copy your Compartment OCID by clicking the "Copy" button
<p></p>
- Paste the contents of your SSH public key file:
<pre>
cat ~/.ssh/id_rsa.pub
</pre>
- Select a shape for your Compute Instance.
<p></p>
The name of the shape indicates the number of cores that are available to that shape, e.g. the VM.Standard2.<b>8</b> shape has <b>8</b> cores available.
<p></p>
- Select the number representing the Availability Domain (AD) in which the infrastructure will be provisioned.
<p></p>
Note that the availability of cores the shape that you use will vary between Availability Domains. The way to check resource availability is described in the Prerequisites section on the [main Readme](https://github.com/oci-hpc/oci-openfoam-workshop/blob/oci-hpc/README.md).
When you are finished configuring your variables, click <b>Next</b>.


2. To modify your config.json file, navigate to your newly created directory, ocihpc-test, and open the config.json file using your preferred text editor. Note that this is not the same config file that we configured in Step 5. 

3. After you change the values in the config.json file, you can deploy the stack using the following command:

<pre>
ocihpc deploy –-stack IntelWorkshop –-compartment-id YOUR_COMPARTMENT_OCID
</pre>
 
4. The ocihpc deploy command shown above will generate a deployment name that consists of STACK_NAME-CURRENT_DIRECTORY-RANDOM_NUMBER. The output to this command will look something like this:

<pre>
ocihpc deploy --stack IntelWorkshop --compartment-id YOUR_COMPARTMENT_OCID
Deploying IntelWorkshop-ocihpc-test-7355 [0min 0sec]
Deploying IntelWorkshop-ocihpc-test-7355 [0min 17sec]
Deploying IntelWorkshop-ocihpc-test-7355 [0min 35sec]
</pre>



### Step 8: Find compute node public IP address
<p></p>
<sub><sup><sub>:clock3:</sub></sup></sub>
&nbsp;
<sub>~1 minute</sub>
<p></p>

1. Once the deployment has completed, the public IP address of the compute node will be printed as a CLI console log. You will use this public IP address to connect to the compute node in the in the steps for Visualizing the Motorbike Model on OCI.

<pre>
Successfully deployed IntelWorkshop-ocihpc-test-7355

You can connect to your head node using the command: ssh opc@123.221.10.8 -i &ltlocation of the private ssh key you created in the .ssh directory&gt
</pre>



### Step 9: [Visualize the Motorbike Model on OCI](https://github.com/oci-hpc/oci-openfoam-workshop/blob/oci-hpc/README.md)
<p></p>
<sub><sup><sub>:clock3:</sub></sup></sub>
&nbsp;
<sub>~20 minutes</sub>
<p></p>


### Step 10: Delete the Stack
<p></p>
<sub><sup><sub>:clock3:</sub></sup></sub>
&nbsp;
<sub>~5 minutes</sub>
<p></p>


1. When you are done with your deployment, you can delete the stack by changing to the stack directory and executing the following command:

<pre>
ocihpc delete --stack IntelWorkshop
</pre>

2. The output will look something like this:

<pre>
Deleting IntelWorkshop-ocihpc-test-7355 [0min 0sec]
Deleting IntelWorkshop-ocihpc-test-7355 [0min 17sec]
Deleting IntelWorkshop-ocihpc-test-7355 [0min 35sec]
…
Successfully deleted IntelWorkshop-ocihpc-test-7355
</pre>

Congratulations! You have successfully deployed the motorbike model stack using ocihpc!

Another way to deploy this stack is via Resource Manager. You can do this by following [these steps](https://github.com/oci-hpc/oci-openfoam-workshop/blob/oci-hpc/Documentation/Resource%20Manager.md).
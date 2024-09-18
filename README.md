# RunJobsIntoHyperion
This is a guide to upload and execute jobs in Hyperion.



The first step is to connect to Hyperion using the shell and the following command:  
ssh username@hyperion.sw.ehu.es  
The first time you log in, you will need to insert a password. Keep it in mind as you will need it later.

Once you have logged into Hyperion, navigate to the /scratch/username folder, which is the folder where jobs are going to be executed.  
You need to upload your executables here so the server can execute them.

To upload your program and download the results, it is a good idea to use FileZilla. Download it if you don't have it yet.  
Once you have downloaded FileZilla, go to "Files" ("Archivos" in Spanish) and then to "Site Manager" ("Gestor de Sitios" in Spanish).  
There, you will start a new connection to Hyperion. To connect to the server, use the username and password you normally use to connect via the shell.  
Once connected, you can upload files and folders from your local computer to Hyperion using the main FileZilla interface.  
To do so, write the path of your project on your computer in "Local Site" ("Sitio Local") and the path of your project inside Hyperion in "Remote Site" ("Sitio Remoto").  
When you write those paths, the contents of those folders will appear. You just need to right-click on the content you want to upload or download, and it will be copied to the corresponding path.

To execute files inside Hyperion, you must first connect to the server using the shell.  
Then, two important things are needed: an environment and a Slurm file.





ENVIRONMENT:  
To execute your program, you will need some libraries installed. The server doesn't have them installed by default, and you cannot install them in your account.  
What you have to do is reserve part of the memory of your account with some libraries installed and execute your programs there.  
The so-called environment can be created with a .yml file. To understand how to create it, I have prepared an example called environmentExample.yml.  
This file is composed of the following elements: 
- name: The name of the environment to be created.
- channels: We use Conda to download the libraries, so we specify where to find those libraries within Conda.
- dependencies: The libraries we want to install.
- pip: Not all libraries are available in Conda, so we install them using pip. In pip, there’s an additional URL preceded by `--extra-index-url` because some libraries need this URL to be found.

Once we have written the .yml file, we are ready to create the environment. Earlier, I mentioned that there are no libraries on the server, but that’s not entirely true, there are some basic libraries, and we will need to use some of them.  
We need a Python version that has Conda inside it, so type the following command in the shell:  
`module load Python/Python-3.10.9-Anaconda3-2023.03-1`  
Now that we have Python, execute the .yml file:  
`conda env create -f environmentExample.yml`  
The environment has been created, but it may have been created in `/home/username`, so you need to copy this environment into `/scratch/username`.  
To do this, go to the destination folder and execute the following command:  
`conda create --prefix=environmentExample --clone /home/username/.conda/envs/environmentExample`  
Now you will have the environment in your desired folder. note that the path could be different from "/home/username/".



SLURM:  
The next step is to execute our program using the environment you created. To do this, we will use a Slurm file.  
In this file, we will specify several things, like the environment to use and the program to execute, as well as the execution details (e.g., how many GPUs, how much time, etc.).  
In the `slurm_example.sh` file, you can see the following things:  
First, there are several rows starting with `#SBATCH`. These rows specify how Hyperion will be used. You can find an explanation for each row in `slurm_example.sh`.  
Once it has been set how Hyperion should execute the job, we need to load our libraries. We have previously created an environment with all the necessary libraries, but we also need Python, Conda, CUDA, and other libraries to use it.  
Because of that, we will load Python (with Conda inside it) and the other necessary libraries. After loading them, we will define our environment (e.g., `/scratch/username/environmentExample/bin`) using the path to its binary folder.  
Once we have done that, we can execute our program using the following command:  
`$ENV_PYTHON/python my_program.py`  


A TIP:
When using a cluster, it’s a good idea to use arguments in your execution calls. Sometimes, small changes are needed for different executions. Instead of changing the code, it is preferred to modify the Slurm file.




GOOD LUCK






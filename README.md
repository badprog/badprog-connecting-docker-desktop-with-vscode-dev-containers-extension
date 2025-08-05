# connecting-docker-desktop-with-vscode-dev-containers-extension

Docker Desktop and VSCode are interesing software, using them together offers many advantages.  
One of the most useful part is the Dev Containers extension from VSCode.  
It allows to dockerize an environment with the **devcontainer.json** file.  
No need to use the command line to manage containers, images, volumes and networks.  
Furthermore your code is on your computer when your environment is inside a container.  
So you can add classic or exotic configurations for your environment without breaking your current OS configuration.  
To be clear, you don't have to install new libraries on your computer, everything is inside a container.  

## What we need

Everything can be installed on Linux, Windows and Mac.

* Docker Desktop: https://www.docker.com/products/docker-desktop/
* VSCode: https://code.visualstudio.com/
* Dev Containers extension: https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers

This extension can be, of course, directly downloaded from your VSCode instance.

## How it works

After installing the 3 software, it's time to understand how to use them.

### Docker Desktop
Docker Desktop is the first software to launch in our environment because the VSCode extension needs it.  
From the menu (on the left) you can see the containers, images, volumes and build already created.


### VScode and the Dev containers extension

Create a new project from VSCode.
Let's say we want a Python project named project-python.
From your new project, create a folder **.devcontainer** and inside this folder a file named **devcontainer.json**.
So you have something like this:

```
project-python
├── .devcontainer
│   └── devcontainer.json
└── main.py
```

In the devcontainer.json file write the following code:

``` json
{
  "name": "Python Dev Container",
  "image": "mcr.microsoft.com/devcontainers/python:3",
  "customizations": {
    "vscode": {
      "extensions": ["ms-python.python"]
    }
  },
  "postCreateCommand": "python --version && pip install --upgrade pip"
}
```

In this last snippet we have different fields.  

#### The name
The name field is the name of the dev container for your VSCode instance, it's the name you are going to see when the container is running.  

#### The image
The image field is the image that is going to be used from the Docker hub repository.  
In our example, you can find this image there: https://hub.docker.com/r/microsoft/devcontainers-python  
By letting the end of the image name without any numbers means we want the latest version of Python 3. 
If we wanted a specific version of Python, for example 3.11, we would have to do change the name with: 

``` json
  "image": "mcr.microsoft.com/devcontainers/python:3.11",
```

#### The customization
The customization allows to add specific customization, in our case we add the vscode extension "ms-python.python".
This extension is the official one to program in Python with VSCode.

#### The postCreateCommand
The postCreateCommand field launches commands of our choice.
In our exemple we decided to execute the two following commands at the end of the image build:

* python --version
* pip install --upgrade pip


We are now reading to build the container from the image specified.  
From VSCode, press CTRL + SHIFT + P in order to show all Commands available.  
Select (or write) **Dev Containers: Reopen in Container**. 
A pop up appears at the bottom right of VSCode with this text: **Connecting to Dev container (Show logs)**.  
Click in or der to see the logs from the terminal.  
You can then see the output of the 2 commands:
Finally in the Configuring... terminal you can see the output:

```
[14878 ms] Start: Run in container: /bin/sh -c python --version && pip install --upgrade pip
Python 3.13.5
Defaulting to user installation because normal site-packages is not writeable
Requirement already satisfied: pip in /usr/local/lib/python3.13/site-packages (25.1.1)
Collecting pip
  Downloading pip-25.2-py3-none-any.whl.metadata (4.7 kB)
Downloading pip-25.2-py3-none-any.whl (1.8 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 1.8/1.8 MB 4.3 MB/s eta 0:00:00
Installing collected packages: pip
Successfully installed pip-25.2

[notice] A new release of pip is available: 25.1.1 -> 25.2
[notice] To update, run: pip install --upgrade pip
Done. Press any key to close the terminal.
```

If you want to retrieve your project without the Dev container, then click at the bottom left of VSCode (in blue background) **Dev Container: Python Dev Container** then **Close Remote Connection**.  

Furthermore, each time you modify the devcontainer.json file, you have to rebuild your container with CTRL + SHIFT + P and select **Dev Container: Rebuild Container** (or sometimes a popup appears to asking you if you want to do so).




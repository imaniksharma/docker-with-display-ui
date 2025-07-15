# Docker with Display Drivers

#### "Firefox" has been tested along with other web-ui apps.

#### The docker container that will be created from this docker image will have
* Ubuntu 24.04 with all dependencies
* X11 display drivers
* Python with all dependecies resolved
* Firefox
* Jupyter Lab

</br>

## Steps:
### 1. Download the Base.DockerFile (Attached in this branch or click the link)</br>
DockerFile link: https://github.com/imaniksharma/docker-with-display-ui/blob/main/Base.Dockerfile</br>
</br>
</br>


### 2. Open terminal where the file is downloaded</br>
<code>$ sudo docker build -f Base.Dockerfile -t manik_base:24.04 . </code> </br>

#### (NOTE: There is a full stop also after "manik_base:24.04" , MUST copy the whole cmd properly otherwise it will throw error)</br>
<code>$ sudo docker images </code></br>

You will see the repository with the name "manik_base" and tag "24.04"</br>
</br>
</br>


### 3. Opening all display connections</br>
<code>$ xhost + </code></br>

You will see "access control disabled, clients can connect from any host"</br>
</br>
</br>


### 4. Create a Container from the image</br>
#### ----- ONLY DO ONE OF THE FOLLOWING -----</br>
#### OPTION 1: (Without GPUs)</br>
<code>$ sudo docker run -it --network host -e DISPLAY=$DISPLAY --name Base manik_base:24.04 </code></br>
#### OPTION 2: (With GPUs)</br>
If you also want GPUs access also inside this container run the below cmd</br>

To remove the existing "Base" named container if the "Option 1" cmd is run by mistake</br>
<code>$ sudo docker rm Base </code></br>

To make GPU based container</br>
<code>$ sudo docker run -it --gpus all --network host -e DISPLAY=$DISPLAY --name Base manik_base:24.04 </code></br>
</br>
</br>



### 5. Close the terminal and Run Firefox</br>
<code>$ sudo docker start Base </code></br>
<code>$ sudo docker attach Base </code></br>

You will be inside the container (it's terminal) now (type the below cmd inside container)</br>
<code> firefox </code></br>

To launch jupyter lab</br>
<code> jupyter lab --ip=0.0.0.0 --port=8020 --no-browser --allow-root </code></br>

Either click on the link provided or type in the URL of system browser **127.0.0.1:8020** or if want to access in another system browser (incase taken ssh from a dgx etc.) _systemip_:8020 in URL</br>
</br>
</br>



### 6. Update repos (MUST)</br>
This is done INSIDE THE CONTAINER terminal</br>

<code> apt update </code></br>
<code> apt upgrade </code></br>
</br>
## DONE

</br>

## Optional: For all advance display applications (may never be required)</br>
### 1. Installing Fuse
Go into the container terminal using Step-5 cmds</br>
<code> apt install -y fuse </code>

### 2. Installing pynvml</br>
Go into the container terminal using Step-5 cmds</br>
<code> pip install --break-system-packages pynvml </code></br>


### 3. Copying X11 temp files (no need though this is for very old applications)</br>
Close all terminals and open a fresh System Terminal NOT CONTAINER terminal</br>
<code>$ sudo docker cp /tmp/.X11-unix Base:/tmp/.X11-unix </code>
</br>
</br>
# DONE



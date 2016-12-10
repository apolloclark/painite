# Painite

This build uses the pre-packaged Gauntlt ruby gem, and the natively installed
ruby 2.3.3 within Kali Linux.

Painite is a combination of Kali Linux + Gauntlt, in a Docker Container, for
use in a Jenkins pipeline, for Continuous Integration and Continuous Deployment
pipeline security scanning.

Painite is a very rare borate mineral. It was first found in Myanmar by British
mineralogist and gem dealer Arthur C.D. Pain in the 1950s. When it was confirmed
as a new mineral species, the mineral was named after him.


```shell
# build the docker container from source
docker build --no-cache=true -t apolloclark/painite .

# run the container
docker run -dit apolloclark/painite

# run the container, with ALL ports exposed
docker run -it --publish-all=true apolloclark/painite
    OR
docker run -it -P apolloclark/painite

# start up a secondary bash command instance
docker exec -it <container_id> bash
```
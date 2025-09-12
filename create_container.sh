# Run ONCE to create container

#!/bin/bash
docker build -t scorched-earth .

# Run the container in the background (detached mode)
docker run -d --name scorched-earth --net=host -e DISPLAY=$DISPLAY scorched-earth tail -f /dev/null
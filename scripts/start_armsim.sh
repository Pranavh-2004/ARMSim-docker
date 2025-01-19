#!/bin/bash

# Start XQuartz
open -a XQuartz

# Wait for XQuartz to initialize
sleep 3

# Allow connections from localhost
xhost +127.0.0.1

# Run the Docker container
docker run -it --rm \
  -e DISPLAY=host.docker.internal:0 \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /Users/pranavhemanth/Code/Projects/armsim-docker/ARMSim_files:/opt/armsim/files \
  pranavhemanth/armsim:latest \
  bash
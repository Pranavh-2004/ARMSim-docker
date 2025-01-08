# ARMSim Docker Setup for macOS

This repository provides a Dockerized environment to run ARMSim on macOS. With this setup, you can run ARMSim without the need for native installation, directly from a Docker container.

## Prerequisites

Before setting up ARMSim on your macOS using Docker, ensure you have the following installed:

- **Docker Desktop for Mac**: [Download Docker](https://www.docker.com/products/docker-desktop)
- Basic knowledge of how to use Docker commands.
- **XQuartz** (for GUI support): [Download XQuartz](https://www.xquartz.org/) (Required for running GUI applications like ARMSim in Docker on macOS)

### Additional macOS Configuration for Docker GUI Support

1. **Install XQuartz**:

   - After installation, open XQuartz and configure it to allow connections from network clients:
     1. Open **XQuartz** preferences.
     2. Under the **Security** tab, ensure "Allow connections from network clients" is checked.

2. **Set the DISPLAY environment variable**:
   - In your terminal, set the `DISPLAY` variable to use the X11 server. This allows Docker containers to display GUI applications on macOS.

```bash
export DISPLAY=host.docker.internal:0
```

You can add this to your .bash_profile or .zshrc file to set it permanently.

## Steps to Download and Run ARMSim using Docker

### Option 1: Pull the Docker Image from Docker Hub (Recommended)

If you want to skip building the Docker image yourself, you can directly pull the pre-built ARMSim Docker image from Docker Hub.

1. Pull the Docker Image:
   Run the following command to download the latest ARMSim Docker image:

```bash
docker pull pranavhemanth/armsim:latest
```

### Option 2: Build the Docker Image from Source (Optional)

If you want to build the Docker image yourself (for customization or learning purposes), follow these steps:
(Use the resources subdirectory to find the required dockerfile to be built)

1. Clone the Repository:
   Clone this repository to your local machine:

```bash
git clone https://github.com/yourusername/armsim-docker.git
cd armsim-docker
```

2. Build the Docker Image (optional, only if you need to build from source):
   If the Docker image has not been built yet, you can build it using the following command:

```bash
docker build -t armsim:latest .
```

3. **Run the ARMSim Docker Container:**
   To run ARMSim in Docker, execute the following command:

```bash
docker run -it --rm \
  -e DISPLAY=host.docker.internal:0 \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /path/to/your/ARMSim_files:/opt/armsim \
  armsim:latest
```

- Replace /path/to/your/ARMSim_files with the path to your ARMSim files (this directory should contain your .s assembly files).
- This command will open an interactive terminal with the ARMSim GUI available.
- The ARMSim_files directory must also contain the armsim executable and config file. Extract the necessary files from the armsim.zip in the resources subdirectory.

4. **Running ARMSim:**
   After the container is launched, the ARMSim GUI should appear. If there are issues with the display, ensure that XQuartz is running and properly configured.

5. **Running Assembly Programs:**
   To run an ARM assembly program, place your .s assembly files inside the ARMSim_files directory (either locally or in the mounted directory) and follow these steps:

   - Assemble the file:

   ```bash
   arm-none-eabi-as -o program.o program.s
   ```

   - Link the object file:

   ```bash
   arm-none-eabi-ld -o program.elf program.o
   ```

   - Run the program in ARMSim:

   ```bash
   mono ARMSim.exe program.elf
   ```

## Contributing

If you want to contribute to the project, feel free to open a pull request or submit issues.

### Steps to Contribute:

1. Fork the repository.
2. Create a feature branch.
3. Make changes and commit them.
4. Open a pull request with a clear description of what was changed.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

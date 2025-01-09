FROM ubuntu:20.04

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    mono-complete \
    wget \
    unzip \
    libgtk2.0-0 \
    libgdk-pixbuf2.0-0 \
    libatk1.0-0 \
    libpango1.0-0 \
    libgdk-pixbuf2.0-common \
    gcc-arm-none-eabi \    
    gdb-multiarch \
    binutils-arm-none-eabi \
    && apt-get clean

# Set working directory
WORKDIR /opt

# Download and unzip ARMSim
RUN wget https://kyledewey.github.io/comp122-fall17/resources/installing_armsim/armsim_linux.zip -O armsim.zip \
    && unzip armsim.zip -d armsim \
    && rm armsim.zip

# Set the working directory to ARMSim
WORKDIR /opt/armsim

# Default command to run ARMSim
CMD ["mono", "/opt/armsim/armsim/ARMSim.exe"]
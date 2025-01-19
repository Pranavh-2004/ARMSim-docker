### Mono Update Patch for ARMSim Docker Project

The ARMSim Docker project is now updated and running correctly after addressing compatibility issues caused by updates to Mono. Here's a detailed guide to help you understand the architecture and resolve common errors.

---

### **Architecture Overview**

#### Why Use Docker?

Docker allows us to run only the necessary parts of an OS (bash and Mono) instead of a full virtual machine (VM) with the entire OS. This approach keeps ARMSim lightweight compared to using a VM.

#### Role of Mono

ARMSim runs on Linux using the Mono runtime environment. Since macOS and Linux share the same kernel, Docker creates a lightweight Linux environment (Ubuntu runtime) on macOS to run ARMSim using Mono.

- `/opt/armsim/armsim#`: Contains the ARMSim executable file.
- `/opt/armsim/files#`: Contains the required files for Mono to run ARMSim. This subdirectory should be mounted in the container for your code.

#### What is Mounting?

When running an application in a VM or Docker container, files can get trapped within the isolated OS. Mounting resolves this issue by sharing a directory between the container (Ubuntu) and the host OS (macOS). This allows you to code in your usual workspace (e.g., VS Code) and use those files in the container seamlessly.

---

### **Common Errors and Solutions**

#### **Unhandled Exception: X-Server Display Issue**

```plaintext
Unhandled Exception: System.TypeInitializationException: The type initializer for 'System.Windows.Forms.XplatUI' threw an exception. ---> System.ArgumentNullException: Could not open display (X-Server required. Check your DISPLAY environment variable) Parameter name: Display
```

**Solution:**
This error occurs because the Xhost is not configured for the project. Use the following command to set it up (modify it for your file structure if needed):

```bash
/opt/X11/bin/xhost +127.0.0.1
```

#### **Error: Unable to Find Image 'armsim:latest' Locally**

```plaintext
Unable to find image 'armsim:latest' locally
docker: Error response from daemon: pull access denied for armsim, repository does not exist or may require 'docker login': denied: requested access to the resource is denied.
See 'docker run --help'.

```

**Solution:**
This error usually occurs when the Docker image isn’t built correctly. Confirm if the image exists:

```bash
docker images
```

- Check if armsim:latest is listed. If not, the image wasn’t built or the build process failed.

- To rebuild the image:

  1. Navigate to the directory containing the Dockerfile (armsim-docker).
  2. Rebuild the image:

  ```bash
  docker build -t armsim:latest .
  ```

- Retry running the container after rebuilding the image.

#### **File Path Issues**

File path errors are specific to your system and may require manual debugging. Generally, you shouldn’t encounter these issues. However, if they persist, seek assistance from ChatGPT or reach out to me for support.

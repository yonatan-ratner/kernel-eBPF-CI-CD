# kernel-eBPF-CI-CD
CI/CD project for integrating and deploying kernel/eBPF modules.

# CI/CD overview for kernel modules
1. Developer pushes code (kernel module changes or infra updates).
2. CI matrix triggers per (ARCH, KERNEL_VERSION, CONFIG).
3. CI checks if kernel+VM image already built and cached:
   a. If not — build the kernel from source (bzImage, modules).
   b. Build a VM disk image with preinstalled toolchain + utilities.
4. Boot the VM (QEMU or baremetal provisioned system).
5. Transfer the kmod source into the VM.
6. Inside the VM:
   a. Build the kernel module using the exact matching headers/sources.
   b. Run tests using scripts or orchestration layer (e.g., Helm later).
7. Results returned to CI host:
   a. Upload `.ko` as artifact if tests pass.
   b. Store logs, metrics, crash dumps as needed.
8. Destroy the VM (ephemeral test/build environment).

# pre-requisites
- Docker - Multi Platform Builds:
    - [Docker](https://docs.docker.com/engine/install/debian/#install-using-the-repository)
    - [Linux post-installation steps for Docker Engine](https://docs.docker.com/engine/install/linux-postinstall/)
        using sudo is problematic - make sure the user is part of the docker group.
    - [Docker - Multi Platform via QEMU](https://docs.docker.com/build/building/multi-platform/#install-qemu-manually)

- GHCR (GitHub Container Registery)
    ```
    export GITHUB_USER=*your-username*
    export GHCR_PAT=*your-PAT*

    echo "$GHCR_PAT" | docker login ghcr.io -u "$GITHUB_USER" --password-stdin
    ```  

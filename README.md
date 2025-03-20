# kernel-eBPF-CI-CD
CI/CD project for integrating and deploying kernel/eBPF modules.

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

# kernel-eBPF-CI-CD

This CI/CD pipeline builds Linux kernels and rootfs images inside a dedicated Docker-based QEMU builder environment, launches ephemeral VMs with exact target kernel/arch combinations, compiles and tests kernel modules inside those VMs, and uploads verified .ko artifacts with full ABI isolation.

## *Kernel module* CI/CD Overview
1. Code push triggers CI workflow (kernel module or pipeline changes).</br></br>
2. CI matrix expands for all target (ARCH, KERNEL_VERSION).</br></br>
3. CI runner uses `qemu-builder` Docker image to:</br>
        a. Build the target kernel from source.</br>
        b. Build rootfs/initramfs or full QEMU disk image.</br>
        c. Prepare QEMU launch scripts or configs.</br></br>
4. CI runner launches the QEMU VM (or physical VM provisioner).</br></br>
5. CI injects kmod source into VM (via scp or volume mount).</br></br>
6. Inside the VM:</br>
    a. Build the kmod (using kernel source or in-tree headers).</br>
    b. Run functional/integration tests (via script or Helm later).</br></br>
7. Test results and built `.ko` modules are extracted from the VM.</br></br>
8. CI uploads artifacts, logs, and optionally destroys the VM.</br></br>

## Features:
This CI/CD pipeline is designed to support a robust and architecture-agnostic system for building and testing Linux kernel modules in isolated environments. The following features are planned as part of the implementation roadmap:

- [ ] **Matrix-driven Build Pipeline**  
  CI jobs run automatically for each defined `(architecture, kernel version)` combination.

- [ ] **Kernel Build from Source**  
  Kernels are built from upstream source trees, ensuring ABI consistency and full control over kernel configuration.

- [ ] **QEMU-Based VM Test Environment**  
  All kernel modules are compiled and tested inside VMs booted with the target kernel, providing full isolation and accuracy.

- [ ] **Architecture Agnostic Design**  
  Supports multi-architecture CI (e.g., `amd64`, `arm64`, `riscv64`) with fully isolated and reproducible build/test environments.

- [ ] **Reproducible Artifacts**  
  Kernel module artifacts (`.ko` files) are generated per target kernel/arch, ensuring ABI compatibility and traceability.

- [ ] **QEMU Builder Docker Image**  
  A reusable Docker image encapsulating the toolchain and QEMU infrastructure to build kernels and launch test VMs in CI.

- [ ] **Dynamic RootFS Generation**  
  Root filesystems with pre-installed toolchains are generated dynamically or reused from cache to speed up CI runs.

- [ ] **Kernel Module Test Framework**  
  Tests are run inside the VM using a modular and extensible test harness (shell scripts, Helm workflows, etc.).

- [ ] **Artifact Caching**  
  Built kernel trees, rootfs images, and QEMU disk images are cached per `(architecture, kernel version)` for faster builds.

- [ ] **Self-hosted Runner / Bare Metal Support**  
  The CI/CD flow supports execution on pre-provisioned physical machines or bare-metal runners, not only QEMU VMs.

- [ ] **Acceptance Gate Logic**  
  A configurable system to distinguish critical and non-critical test failures, allowing conditional artifact promotion.

- [ ] **Helm-based Orchestration Layer**  
  Helm charts will be used to manage and orchestrate test scenarios and module lifecycle inside VMs or clusters.

## pre-requisites

This project builds and tests Linux kernel modules inside isolated virtual machines (VMs) that match the target architecture and kernel version. The following tools and configurations are required to set up and run the CI/CD pipeline or develop locally.

### Docker
Docker is used to build the QEMU builder image, which contains all necessary tools for building kernels, root filesystems, and managing QEMU virtual machines.
- [Install Docker](https://docs.docker.com/engine/install/debian/#install-using-the-repository)
- [Linux post-installation steps for Docker Engine](https://docs.docker.com/engine/install/linux-postinstall/)
  - It is **required** to add your user to the `docker` group to avoid using `sudo docker`.

### GitHub user & GHCR (GitHub Container Registery)
Used to store and retrieve the QEMU builder Docker image and other infrastructure artifacts. </br>
    ```
    export GITHUB_USER=*your-username*
    export GHCR_PAT=*your-PAT*

    echo "$GHCR_PAT" | docker login ghcr.io -u "$GITHUB_USER" --password-stdin
    ``` 

### QEMU (placeholder - to be updated)
QEMU will be used to boot virtual machines for building and testing kernel modules.
- Installation and usage instructions will be added when relevant.

### Kernel Build Tooling (placeholder - to be updated)
The system will use standard Linux kernel build tools such as `make`, `gcc`, `binutils`, etc.
- These will be included in the QEMU builder image.
- Additional setup information will be added as the implementation progresses.

### Root Filesystem Build Tooling (placeholder - to be updated)
Tools for generating initramfs or full root filesystem images (e.g., `debootstrap`, `busybox`, `mkinitcpio`, etc.) will be included in the QEMU builder image.
- Specific tools and configurations will be documented once finalized.

### Test Harness / Acceptance Framework (placeholder - to be updated)
Testing inside VMs will be driven by custom scripts, and later extended with Helm-based orchestration.
- This section will be expanded when test frameworks are implemented.

### Helm (placeholder - to be updated)
Helm will be used in future phases for test orchestration and environment lifecycle management.

### Kubernetes (placeholder - to be updated)
The system may integrate with Kubernetes in future iterations for managing VM lifecycles and scaling test infrastructure.

### Monitoring and Observability (placeholder - to be updated)
Prometheus, Grafana, and other observability tools may be integrated later to monitor test execution and system health.

### CI Cache/Storage (placeholder - to be updated)
Optional caching systems for compiled kernels, rootfs images, and test artifacts may be introduced in later phases.


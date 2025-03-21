# kernel-eBPF-CI-CD

This CI/CD pipeline builds Linux kernels and rootfs images inside a dedicated Docker-based QEMU builder environment, launches ephemeral VMs with exact target kernel/arch combinations, compiles and tests kernel modules inside those VMs, and uploads verified .ko artifacts with full ABI isolation.

## CI/CD Overview
1. Code push triggers CI workflow (kmod or kernel changes).
2. CI matrix expands for all target (ARCH, KERNEL_VERSION).
3. CI runner uses `qemu-builder` Docker image to:
    a. Build the target kernel from source.
    b. Build rootfs/initramfs or full QEMU disk image.
    c. Prepare QEMU launch scripts or configs.
4. CI runner launches the QEMU VM (or physical VM provisioner).
5. CI injects kmod source into VM (via scp or volume mount).
6. Inside the VM:
    a. Build the kmod (using kernel source or in-tree headers).
    b. Run functional/integration tests (via script or Helm later).
7. Test results and built `.ko` modules are extracted from the VM.
8. CI uploads artifacts, logs, and optionally destroys the VM.

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

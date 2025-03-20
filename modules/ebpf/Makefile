ARTIFACT_DIR ?= ../../artifacts/ebpf

.PHONY: all clean

all:
	chmod +x ./build_all.sh
	ARTIFACT_DIR=$(ARTIFACT_DIR) ./build_all.sh

clean:
	chmod +x ./clean_all.sh
	ARTIFACT_DIR=$(ARTIFACT_DIR) ./clean_all.sh


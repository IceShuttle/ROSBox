ROS_DISTRO ?=humble
IMAGE ?=ros-$(ROS_DISTRO)
FLAGS ?=
RUNTIME ?=podman
NVIDIA ?= 0
ifeq ($(NVIDIA),0)
NVIDIA_FLAGS :=
else
NVIDIA_FLAGS := --nvidia
endif
FLAGS ?= $(FLAGS) $(NVIDIA)

build:
	$(RUNTIME) build -t $(IMAGE) . && touch build
create: build
	distrobox create $(FLAGS) -n $(IMAGE) -i localhost/$(IMAGE)
enter: create
	distrobox enter $(IMAGE)
refresh:
	rm build
	distrobox rm -f $(IMAGE)
	make enter

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
NVIM_VER != nvim --version | head -n1 | cut -d " " -f 2

build-$(ROS_DISTRO):
	echo $(NVIM_VER)
	$(RUNTIME) build -t $(IMAGE) \
		--build-arg NVIM_VER=$(NVIM_VER) \
		--build-arg ROS_DISTRO=$(ROS_DISTRO) \
		. && touch $(ROS_DISTRO)-build
create: build-$(ROS_DISTRO)
	distrobox create $(FLAGS) -n $(IMAGE) -i localhost/$(IMAGE)
enter: create
	distrobox enter $(IMAGE)
refresh:
	rm $(ROS_DISTRO)-build
	distrobox rm -f $(IMAGE)
	make enter

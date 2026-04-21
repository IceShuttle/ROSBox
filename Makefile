ROS_DISTRO ?=humble
IMAGE ?=ros-$(ROS_DISTRO)

build:
	podman build -t $(IMAGE) . && touch build
create: build
	distrobox create -n $(IMAGE) -i localhost/$(IMAGE)
enter: create
	distrobox enter $(IMAGE)
refresh:
	rm build
	distrobox rm -f $(IMAGE)
	make enter

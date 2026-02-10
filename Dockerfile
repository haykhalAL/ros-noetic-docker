FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV ROS_DISTRO=noetic
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Base system
RUN apt update && apt install -y \
    locales \
    curl \
    gnupg2 \
    lsb-release \
    ca-certificates \
    python3-pip \
    && locale-gen en_US en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

# ROS GPG key (modern way)
RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc \
    | gpg --dearmor -o /etc/apt/keyrings/ros.gpg

# ROS repository
RUN echo "deb [signed-by=/etc/apt/keyrings/ros.gpg] \
    http://packages.ros.org/ros/ubuntu focal main" \
    > /etc/apt/sources.list.d/ros1.list

# Install ROS + Gazebo
RUN apt update && apt install -y \
    ros-noetic-desktop-full \
    ros-noetic-gazebo-ros-pkgs \
    ros-noetic-gazebo-ros-control \
    ros-noetic-turtlebot3 \
    ros-noetic-turtlebot3-simulations \
    python3-rosdep \
    python3-catkin-tools \
    && rm -rf /var/lib/apt/lists/*

# rosdep
RUN rosdep init || true
RUN rosdep update

# Auto-source ROS
RUN echo "source /opt/ros/noetic/setup.bash" >> /etc/bash.bashrc

# Workspace
WORKDIR /root/catkin_ws
RUN mkdir -p src

CMD ["bash"]

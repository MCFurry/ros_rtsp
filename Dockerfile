FROM ros:melodic-ros-base


RUN apt update -qq && \
    apt install -y  python-catkin-tools\
                    libgstreamer-plugins-base1.0-dev \
                    libgstreamer-plugins-good1.0-dev \
                    libgstreamer-plugins-bad1.0-dev \
                    libgstrtspserver-1.0-dev \
                    libx264-dev \
                    libgstreamer1.0-0 \
                    gstreamer1.0-plugins-base \
                    gstreamer1.0-plugins-good \
                    gstreamer1.0-plugins-bad \
                    gstreamer1.0-plugins-ugly

RUN git clone https://github.com/MCFurry/ros_rtsp.git src/ros_rtsp

# Install dependencies used by packages
RUN rosdep update && rosdep install -y -i --from-paths src

# Compile ROS package
RUN bash -c 'source /opt/ros/melodic/setup.bash && catkin build'

# RUN command
CMD bash -c 'source /devel/setup.bash && roslaunch ros_rtsp rtsp_streams.launch'

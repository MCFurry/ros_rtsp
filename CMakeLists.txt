cmake_minimum_required(VERSION 3.0.2)
project(ros_rtsp)

## Compile as C++11, supported in ROS Kinetic and newer
add_compile_options(-std=c++11)

## Find catkin macros and libraries
## if COMPONENTS list like find_package(catkin REQUIRED COMPONENTS xyz)
## is used, also find other catkin packages
find_package(OpenCV REQUIRED)
find_package(PkgConfig REQUIRED)
pkg_check_modules(GST REQUIRED
  gstreamer-1.0
  gstreamer-app-1.0
  gstreamer-rtsp-server-1.0
)


find_package(catkin REQUIRED COMPONENTS
  roscpp
  sensor_msgs
  nodelet
)

catkin_package(
 CATKIN_DEPENDS roscpp sensor_msgs
)

###########
## Build ##
###########

include_directories(
  include
  ${catkin_INCLUDE_DIRS}
  ${GST_INCLUDE_DIRS}
)

## Declare a C++ library
# add_library(${PROJECT_NAME}
#   src/${PROJECT_NAME}/ros_rtsp.cpp
# )
add_library(image_to_rtsp_nodelet src/image2rtsp.cpp src/video.cpp)

## Specify libraries to link a library or executable target against
target_link_libraries(image_to_rtsp_nodelet
  ${catkin_LIBRARIES}
  ${GST_LIBRARIES}
)

#############
## Install ##
#############

install(
  TARGETS
    image_to_rtsp_nodelet
  ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

# Install files
install(
  FILES
    ${PROJECT_NAME}_plugin.xml
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
)

# Install directories
install(
  DIRECTORY
    launch
    config
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
)

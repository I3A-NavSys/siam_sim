# ROS API


## ROS packages

U-TRAFMAN is structured in a single workspace including two ROS packages:
- **utrafman_main**: This package contains the core components of the simulator, including launch files, world files, UAV SDF models, UAV control software, etc.
- **utrafman_god**: This package contains a Gazebo plugin that is integrated into each world file, facilitating the dynamic spawning and removal of UAVs within the environment throughout the simulation.


## ROS Topics
In the simulation, each UAV generates the following topics:
- **/drone/_%droneid_/uplan**: This topic is used to send a flight plan to a specific UAV.
- **/drone/_%droneid_/telemetry**: This topic is employed to receive telemetry data from a UAV.
- **/drone/_%droneid_/kill**: This topic enables the termination of a UAV.


### Custom topic messages
Data sent through topics and services is defined with generic or custom ROS messages. 
Some of the custom ROS messages used in U-TRAFMAN include(_package_/_message_):
- **utrafman_main/[Operator.msg](https://github.com/I3A-NavSys/utrafman_sim/tree/main/src/gazebo-ros/src/utrafman/msg/Operator.msg)**: This message encapsulates the information related to the operator.
- **utrafman_main/[Telemetry.msg](https://github.com/I3A-NavSys/utrafman_sim/tree/main/src/gazebo-ros/src/utrafman/msg/Telemetry.msg)**: This message contains telemetry data for UAVs, including parameters such as position, velocity, acceleration, and more.
- **utrafman_main/[UAV.msg](https://github.com/I3A-NavSys/utrafman_sim/tree/main/src/gazebo-ros/src/utrafman/msg/UAV.msg)**: This message stores information about the UAVs.
- **utrafman_main/[Uplan.msg](https://github.com/I3A-NavSys/utrafman_sim/tree/main/src/gazebo-ros/src/utrafman/msg/Uplan.msg)**: This message encompasses the flight plan of a UAV.
- **utrafman_main/[Waypoint.msg](https://github.com/I3A-NavSys/utrafman_sim/tree/main/src/gazebo-ros/src/utrafman/msg/Waypoint.msg)**: This message conveys the position of a 4D waypoint, which includes coordinates in four dimensions.


## ROS Services
<!-- > Rehacer: describir todos los servicios y sus mensajes asociados -->



### Custom service messages

- **utrafman_main/[insert_model.srv](https://github.com/I3A-NavSys/utrafman_sim/tree/main/src/gazebo-ros/src/utrafman/srv/insert_model.srv)**: a service message used to insert a UAV in the simulation.
- **utrafman_main/[mon_get_locs.srv](https://github.com/I3A-NavSys/utrafman_sim/tree/main/src/gazebo-ros/src/utrafman/srv/mon_get_locs.srv)**: a service message used to get telemetry of UAVs from the Monitoring service.
- **utrafman_main/[reg_get_fps.srv](https://github.com/I3A-NavSys/utrafman_sim/tree/main/src/gazebo-ros/src/utrafman/srv/reg_get_fps.srv)**: a service message used to get (a / a list of) flight plans of UAVs from the Register service.
- **utrafman_main/[reg_get_operators.srv](https://github.com/I3A-NavSys/utrafman_sim/tree/main/src/gazebo-ros/src/utrafman/srv/reg_get_operators.srv)**: a service message used to get (a / a list of) operators from the Register service.
- **utrafman_main/[reg_get_uavs.srv](https://github.com/I3A-NavSys/utrafman_sim/tree/main/src/gazebo-ros/src/utrafman/srv/reg_get_uavs.srv)**: a service message used to get (a / a list of) UAVs from the Register service.
- **utrafman_main/[reg_new_flightplan.srv](https://github.com/I3A-NavSys/utrafman_sim/tree/main/src/gazebo-ros/src/utrafman/srv/reg_new_flightplan.srv)**: a service message used to register a flight plan into the Register service.
- **utrafman_main/[reg_new_operator.srv](https://github.com/I3A-NavSys/utrafman_sim/tree/main/src/gazebo-ros/src/utrafman/srv/reg_new_operator.srv)**: a service message used to register a operator into the Register service.
- **utrafman_main/[reg_new_uav.srv](https://github.com/I3A-NavSys/utrafman_sim/tree/main/src/gazebo-ros/src/utrafman/srv/reg_new_uav.srv)**: a service message used to register a UAV intos the Register service.
- **utrafman_main/[teletransport.srv](https://github.com/I3A-NavSys/utrafman_sim/tree/main/src/gazebo-ros/src/utrafman/srv/teletransport.srv)**: a service message used to teletransport a UAV to a different position in the world.



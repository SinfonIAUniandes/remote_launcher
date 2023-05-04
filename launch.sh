
#!/bin/bash

. config.cfg

export ROS_MASTER_URI=http://$PEPPER_IP:11311
export ROS_IP=$(hostname -I | awk '{print $1}')


echo "The IP of Pepper is: $ROS_IP $PEPPER_IP $ROS_MASTER_URI"

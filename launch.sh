
#!/bin/bash

. ./config.cfg

export ROS_MASTER_URI=http://$PEPPER_IP:11311
export ROS_IP=$(hostname -I | awk '{print $1}')


export LAUNCH_TOOLKIT="
source <(echo \"$REMOTE_CONFIG\") &&
./gentoo/startprefix &&
cd &&
. startRos.sh &&
. start_robot_toolkit_wlan.sh
"

# Encode the config.cfg content in base64
REMOTE_CONFIG=$(base64 < config.cfg)

echo "The IP of Pepper is: $PEPPER_IP - $ROS_MASTER_URI"
echo "The IP of this computer is: $ROS_IP"

echo "Connecting to Pepper..."
# sshpass -p "$PEPPER_PASSWORD" ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null $PEPPER_USER@$PEPPER_IP "REMOTE_CONFIG=$REMOTE_CONFIG; $LAUNCH_TOOLKIT"


export LAUNCH_REMOTE="
. \"${HOME}/${REMOTE_CONTROLLER_WS_PATH}/devel/setup.bash\";
rosrun remote_controller remote_controller ;
read -p 'Press enter to close the terminal...'
"

gnome-terminal -- bash -c "$LAUNCH_REMOTE"

echo "Done!"

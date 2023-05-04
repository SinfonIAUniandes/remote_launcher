
#!/bin/bash

export PEPPER_IP=192.168.0.111
export PEPPER_USER=nao
export PEPPER_PASSWORD=nao
export REMOTE_CONTROLLER_WS_PATH="sinfonia_ws"

export ROS_MASTER_URI=http://$PEPPER_IP:11311
export ROS_IP=$(hostname -I | awk '{print $1}')


export LAUNCH_TOOLKIT="
export PEPPER_IP=192.168.0.111
echo prueba &&
./gentoo/startprefix /bin/bash -c 'cd && echo hola &&
. startRos.sh &&
. start_robot_toolkit_wlan.sh &'
"



# Encode the config.cfg content in base64

echo "The IP of Pepper is: $PEPPER_IP - $ROS_MASTER_URI"
echo "The IP of this computer is: $ROS_IP"

echo "Connecting to Pepper..."
sshpass -p "$PEPPER_PASSWORD" ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null $PEPPER_USER@$PEPPER_IP "$LAUNCH_TOOLKIT"


export LAUNCH_REMOTE="
. \"${HOME}/${REMOTE_CONTROLLER_WS_PATH}/devel/setup.bash\";
rosrun remote_controller remote_controller ;
read -p 'Press enter to close the terminal...'
"

gnome-terminal -- bash -c "$LAUNCH_REMOTE"

echo "Done!"

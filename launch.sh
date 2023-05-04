
#!/bin/bash

. ./config.cfg

export PEPPER_IP=192.168.0.111
export PEPPER_USER=nao
export PEPPER_PASSWORD=nao
export REMOTE_CONTROLLER_WS_PATH="sinfonia_ws"

export ROS_MASTER_URI=http://$PEPPER_IP:11311
export ROS_IP=$(hostname -I | awk '{print $1}')


export LAUNCH_TOOLKIT="
echo prueba
./gentoo/startprefix
echo hola
. startRos.sh
. start_robot_toolkit_wlan.sh &
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


"if [[ ! -x $SHELL ]] ; then
        echo "Failed to find the Prefix shell, this is probably" > /dev/stderr
        echo "because you didn't emerge the shell ${SHELL##*/}" > /dev/stderr
        exit -1
fi

# give a small notice
echo "Entering Gentoo Prefix ${EPREFIX}"
# start the login shell, clean the entire environment but what's needed
RETAIN="HOME=$HOME TERM=$TERM USER=$USER SHELL=$SHELL"
# PROFILEREAD is necessary on SUSE not to wipe the env on shell start
[[ -n ${PROFILEREAD} ]] && RETAIN+=" PROFILEREAD=$PROFILEREAD"
# ssh-agent is handy to keep, of if set, inherit it
[[ -n ${SSH_AUTH_SOCK} ]] && RETAIN+=" SSH_AUTH_SOCK=$SSH_AUTH_SOCK"
# if we're on some X terminal, makes sense to inherit that too
[[ -n ${DISPLAY} ]] && RETAIN+=" DISPLAY=$DISPLAY"
# do it!
env -i $RETAIN $SHELL -l"
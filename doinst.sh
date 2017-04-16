config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

config etc/pulse/client.conf.new
config etc/pulse/daemon.conf.new
config etc/pulse/default.pa.new
config etc/pulse/system.pa.new

# Make sure the pulse user is in the audio group:
chroot . /usr/sbin/usermod -a -G audio pulse 1> /dev/null 2> /dev/null

# Make sure the root user is in the audio group:
chroot . /usr/sbin/usermod -a -G audio root 1> /dev/null 2> /dev/null

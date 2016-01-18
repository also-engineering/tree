# tree

if ! $updated_recently; then
  sudo apt-get update
  updated_recently=TRUE
fi

# JDK
which_javac=`which javac`
if [ ! -z "$which_javac" ]; then
  echo "JDK already installed"
else
  sudo apt-get install default-jdk -y
fi

# Android SDK
which_javac=`which android`
if [ ! -z "$which_android" ]
  echo "Android SDK already installed"
else
  curl http://dl.google.com/android/android-sdk_r24.3.4-linux.tgz > android-sdk.tgz
  tar xvf android-sdk.tgz
  sudo mv android-sdk-linux /usr/local/bin
  sudo touch /etc/profile.d/android-sdk-path
  echo "export PATH=$PATH:/usr/local/bin/android-sdk-linux/tools:/usr/local/bin/android-sdk-linux/platform-tools" > /etc/profile.d/android-sdk-path

  # Install Android SDK's tools
  /usr/local/bin/android-sdk-linux/tools/android list sdk --all
  echo "################ Android SDK Install ########################"
  echo "Please select which following packages you wish to install."
  echo "You want the numbers for the following"
  echo "  * Android SDK Tools"
  echo "  * Android SDK Platform Tools"
  echo "  * Android SDK Build Tools"
  echo "  * Android SDK Platform (whatever version you need)"
  echo "For example: 1,2,6,26"
  echo "Install the proper versions please. Example: 1,2,6,26"
  echo -n "Package numbers separated by comma, no spaces:"
  read packages
  /usr/local/bin/android-sdk-linux/tools/android update sdk -u -a -t $packages

fi


# node
which_npm=`which npm`
if [ ! -z "$which_npm" ]; then
  echo "npm already installed"
else
  sudo apt-get install nodejs nodejs-legacy npm -y
fi

sudo git submodule init && git submodule update
cd client
sudo npm install
sudo chown -R www-data:www-data /var/www
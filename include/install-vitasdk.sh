#!/bin/bash

get_download_link () {
  wget -qO- https://github.com/vitasdk/vita-headers/raw/master/.travis.d/last_built_toolchain.py | python3 - $@
}

install_vitasdk () {
  INSTALLDIR=$1

  case "$(uname -s)" in
     Darwin*)
      mkdir -p $INSTALLDIR
      wget -O- "https://github.com/RealYoti/vdpm-20200619/releases/download/master-osx-v1130/vitasdk-x86_64-apple-darwin-2020-06-18_14-24-47.tar.bz2" | tar xj -C $INSTALLDIR --strip-components=1
     ;;

     Linux*)
      if [ -n "${TRAVIS}" ]; then
          sudo apt-get install libc6-i386 lib32stdc++6 lib32gcc1 patch
      fi
      command -v curl || { echo "curl missing (install using: apt install curl)" ; exit 1; }
      if [ ! -d "$INSTALLDIR" ]; then
        sudo mkdir -p $INSTALLDIR
        sudo chown $USER:$(id -gn $USER) $INSTALLDIR
      fi
      wget -O- "https://github.com/RealYoti/vdpm-20200619/releases/download/master-linux-v1133/vitasdk-x86_64-linux-gnu-2020-06-19_15-01-34.tar.bz2" | tar xj -C $INSTALLDIR --strip-components=1
     ;;

     MSYS*|MINGW64*)
      UNIX=false
      mkdir -p $INSTALLDIR
      wget -O- "https://github.com/RealYoti/vdpm-20200619/releases/download/master-win-v1133/vitasdk-x86_64-w64-mingw32-2020-06-19_15-01-27.tar.bz2" | tar xj -C $INSTALLDIR --strip-components=1
     ;;

     CYGWIN*|MINGW32*)
      echo "Please use msys2. Exiting..."
      exit 1
     ;;

     *)
       echo "Unknown OS"
       exit 1
      ;;
  esac

}

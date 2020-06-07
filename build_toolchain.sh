#!/bin/bash

# exit on error
set -e

if [ $# -eq 0 ]; then
#    TARGETS=( arm-none-eabi arm-none-elf mips-none-elf mipsel-none-elf mips64-none-elf mips64el-none-elf sparc-none-elf avr-none-elf)
    TARGETS=arm-none-eabi
else
    TARGETS=$1
fi

printf "binutils targets are: ";
for i in "${TARGETS[@]}" 
do
    printf "$i "
done
printf "\n"

# switches for clang tools
WANT_LLD=true
WANT_LLDB=false
WANT_COMPILER_RT=true
WANT_CPP_RT=true

# output directories
BUILDDIR=build
SOURCEDIR=src
BINDIR=binary

# working dir
WORKING_DIR=toolchain

# remove old 
rm -rf $WORKING_DIR/$BUILDDIR
rm -rf $WORKING_DIR/$BINDIR

# make new one
mkdir -p $WORKING_DIR/$BUILDDIR
mkdir -p $WORKING_DIR/$BINDIR

# curl
CURL="curl -s"

# tool versions
GMAKE_VERSION=3.82
BINUTILS_VERSION=2.34
CMAKE_VERSION=3.17.2
LLVM_VERSION=10.0.0

CLANG_VERSION=$LLVM_VERSION
LLD_VERSION=$LLVM_VERSION
LLDB_VERSION=$LLVM_VERSION
COMPILER_RT_VERSION=$LLVM_VERSION
CPP_RT_VERSION=$LLVM_VERSION

# tool names
GMAKE=make-$GMAKE_VERSION
BINUTILS=binutils-$BINUTILS_VERSION
CMAKE=cmake-$CMAKE_VERSION
LLVM=llvm-$LLVM_VERSION
CLANG=cfe-$CLANG_VERSION
LLD=lld-$LLD_VERSION
LLDB=lldb-$LLDB_VERSION
COMPILER_RT=compiler-rt-$COMPILER_RT_VERSION
CPP_RT=libcxx-$CPP_RT_VERSION

# tool tarballs
GMAKE_TARBALL=$GMAKE.tar.gz
BINUTILS_TARBALL=$BINUTILS.tar.gz
CMAKE_TARBALL=$CMAKE.tar.gz
LLVM_TARBALL=$LLVM.src.tar.xz
CLANG_TARBALL=$CLANG.src.tar.xz
LLD_TARBALL=$LLD.src.tar.xz
LLDB_TARBALL=$LLDB.src.tar.xz
COMPILER_RT_TARBALL=$COMPILER_RT.src.tar.xz
CPP_RT_TARBALL=$CPP_RT.src.tar.xz

# download sites
GNU_FTP=ftp.gnu.org/gnu
LLVM_FTP=http://releases.llvm.org
CMAKE_FTP=https://cmake.org/files/v3.17

TOPDIR=$(pwd)/$WORKING_DIR
printf "Topdir is $TOPDIR\n";

LOGDIR=$TOPDIR/logs;
printf "Logdir is $LOGDIR\n";

# tool binaries
CMAKE_BINARY=$TOPDIR/$BINDIR/usr/local/bin/cmake
GMAKE_BINARY=$TOPDIR/$BINDIR/bin/make
LLVM_BINARY=$TOPDIR/$BINDIR/bin/llc
CLANG_BINARY=$TOPDIR/$BINDIR/bin/clang

LLD_BINARY=$TOPDIR/$BINDIR/bin/lld
LLDB_BINARY=$TOPDIR/$BINDIR/bin/lldb

# output some useful information
printf "cmake is $CMAKE_BINARY\n";
printf "gmake is $GMAKE_BINARY\n";
printf "llvm is $LLVM_BINARY\n";
printf "clang is $CLANG_BINARY\n";
printf "lld is $LLD_BINARY\n";

cd $TOPDIR
rm -rf $LOGDIR
mkdir -p $LOGDIR
mkdir -p $SOURCEDIR
 
# **** GMAKE *****
if [ ! -f $SOURCEDIR/$GMAKE_TARBALL ]; then
        cd $SOURCEDIR
        printf "downloading $GNU_FTP/make/$GMAKE_TARBALL\n";
        $CURL $GNU_FTP/make/$GMAKE_TARBALL > $GMAKE_TARBALL
        tar zxvf $GMAKE_TARBALL >> $LOGDIR/$GMAKE.log 2>&1
        cd $TOPDIR
else
        printf "Found $GMAKE source\n";
fi

# **** BINUTILS *****
if [ ! -f $SOURCEDIR/$BINUTILS_TARBALL ]; then
        cd $SOURCEDIR 
        printf "downloading $GNU_FTP/binutils/$BINUTILS_TARBALL\n";
        $CURL $GNU_FTP/binutils/$BINUTILS_TARBALL > $BINUTILS_TARBALL
        tar xvf $BINUTILS_TARBALL >> $LOGDIR/$BINUTILS.log 2>&1
        cd $TOPDIR
else
        printf "Found binutils-$BINUTILS_VERSION source\n";
fi

# **** CMAKE *****
if [ ! -f $SOURCEDIR/$CMAKE_TARBALL ]; then
        cd $SOURCEDIR
        printf "downloading $CMAKE_FTP/$CMAKE_TARBALL\n";
        $CURL $CMAKE_FTP/$CMAKE_TARBALL > $CMAKE_TARBALL
        tar xvf $CMAKE_TARBALL >> $LOGDIR/$CMAKE.log 2>&1
        cd $TOPDIR
else
        printf "Found $CMAKE source\n";
fi

# **** LLVM  *****
if [ ! -f $SOURCEDIR/$LLVM_TARBALL ]; then
        cd $SOURCEDIR
        printf "downloading $LLVM_FTP/$LLVM_VERSION/$LLVM_TARBALL\n";
        $CURL $LLVM_FTP/$LLVM_VERSION/$LLVM_TARBALL > $LLVM_TARBALL
        tar xvf $LLVM_TARBALL >> $LOGDIR/$LLVM.log 2>&1
        cd $TOPDIR
else
        printf "Found $LLVM source\n";
fi

# **** CLANG  *****
if [ ! -f $SOURCEDIR/$LLVM.src/tools/$CLANG_TARBALL ]; then
        mkdir -p $SOURCEDIR/$LLVM.src/tools
        cd $SOURCEDIR/$LLVM.src/tools
        printf "downloading $LLVM_FTP/$CLANG_VERSION/$CLANG_TARBALL\n";
        $CURL $LLVM_FTP/$CLANG_VERSION/$CLANG_TARBALL > $CLANG_TARBALL
        tar xvf $CLANG_TARBALL >> $LOGDIR/$CLANG.log 2>&1
        cd $TOPDIR
else
        printf "Found $CLANG source\n";
fi

# **** COMPILER-RT *****
if [ $WANT_COMPILER_RT = "true" ]; then
    if [ ! -f $SOURCEDIR/$LLVM.src/projects/$CPP_RT_TARBALL ]; then
            mkdir -p $SOURCEDIR/$LLVM.src/projects
            cd $SOURCEDIR/$LLVM.src/projects
            printf "downloading $LLVM_FTP/$LLD_VERSION/$CPP_RT_TARBALL\n";
            $CURL $LLVM_FTP/$LLD_VERSION/$CPP_RT_TARBALL > $CPP_RT_TARBALL
            tar xvf $CPP_RT_TARBALL >> $LOGDIR/$CPP_RT.log 2>&1
            cd $TOPDIR
    else
            printf "Found $CPP_RT source\n";
    fi
else
    rm -f $SOURCEDIR/$LLVM.src/$LLD_TARBALL;
    rm -rf $SOURCEDIR/$LLVM.src/tools/$LLD.src;
fi

# **** LIBC++ *****
if [ $WANT_CPP_RT = "true" ]; then
    if [ ! -f $SOURCEDIR/$LLVM.src/projects/$COMPILER_RT_TARBALL ]; then
            mkdir -p $SOURCEDIR/$LLVM.src/projects
            cd $SOURCEDIR/$LLVM.src/projects
            printf "downloading $LLVM_FTP/$LLD_VERSION/$COMPILER_RT_TARBALL\n";
            $CURL $LLVM_FTP/$LLD_VERSION/$COMPILER_RT_TARBALL > $COMPILER_RT_TARBALL
            tar xvf $COMPILER_RT_TARBALL >> $LOGDIR/$COMPILER_RT.log 2>&1
            cd $TOPDIR
    else
            printf "Found $COMPILER_RT source\n";
    fi
else
    rm -f $SOURCEDIR/$LLVM.src/$LLD_TARBALL;
    rm -rf $SOURCEDIR/$LLVM.src/tools/$LLD.src;
fi

# **** LLD *****
if [ $WANT_LLD = "true" ]; then
    if [ ! -f $SOURCEDIR/$LLVM.src/tools/$LLD_TARBALL ]; then
            mkdir -p $SOURCEDIR/$LLVM.src/tools
            cd $SOURCEDIR/$LLVM.src/tools
            printf "downloading $LLVM_FTP/$LLD_VERSION/$LLD_TARBALL\n";
            $CURL $LLVM_FTP/$LLD_VERSION/$LLD_TARBALL > $LLD_TARBALL
            tar xvf $LLD_TARBALL >> $LOGDIR/$LLD.log 2>&1
            cd $TOPDIR
    else
            printf "Found $LLD source\n";
    fi
else
    rm -f $SOURCEDIR/$LLVM.src/$LLD_TARBALL;
    rm -rf $SOURCEDIR/$LLVM.src/tools/$LLD.src;
fi

# **** LLDB *****
if [ $WANT_LLDB = "true" ]; then
    if [ ! -f $SOURCEDIR/$LLVM.src/tools/$LLDB_TARBALL ]; then
            mkdir -p $SOURCEDIR/$LLVM.src/tools
            cd $SOURCEDIR/$LLVM.src/tools
            printf "downloading $LLVM_FTP/$LLDB_VERSION/$LLDB_TARBALL\n";
            $CURL $LLVM_FTP/$LLDB_VERSION/$LLDB_TARBALL > $LLDB_TARBALL
            tar xvf $LLDB_TARBALL >> $LOGDIR/$LLDB.log 2>&1
            cd $TOPDIR
    else
            printf "Found $LLDB source\n";
    fi
else
    rm -f $SOURCEDIR/$LLVM.src/$LLDB_TARBALL;
    rm -rf $SOURCEDIR/$LLVM.src/tools/$LLDB.src;
fi

# **** Make Dirs *****
rm -rf $BUILDDIR
mkdir -p $BUILDDIR/$GMAKE
mkdir -p $BUILDDIR/$BINUTILS
mkdir -p $BUILDDIR/$CMAKE
mkdir -p $BUILDDIR/$CLANG

# **** GMAKE *****
if [ ! -f $GMAKE_BINARY ]; then
        printf "Configuring $GMAKE\n";
        cd $BUILDDIR/$GMAKE
        $TOPDIR/$SOURCEDIR/$GMAKE/configure --prefix=$TOPDIR/$BINDIR >> $LOGDIR/$GMAKE.log 2>&1
        printf "Building $GMAKE\n";
        make >> $LOGDIR/$GMAKE.log 2>&1
        printf "Installing $GMAKE\n";
        make install >> $LOGDIR/$GMAKE.log 2>&1
        cd $TOPDIR
else
        printf "Found $GMAKE binary\n"        
fi

# **** BINUTILS *****
for TARGET in "${TARGETS[@]}" 
do
    PREFIX=$TOPDIR/$BINDIR/$TARGET
    # printf "Prefix is $PREFIX\n";
    AS_BINARY=$PREFIX/bin/$TARGET-as
    if [ ! -f $AS_BINARY ]; then
            printf "Configuring $BINUTILS ($TARGET)\n";
            mkdir -p $BUILDDIR/$BINUTILS/$TARGET
            cd $BUILDDIR/$BINUTILS/$TARGET
            $TOPDIR/$SOURCEDIR/$BINUTILS/configure --target=$TARGET --prefix=$PREFIX --disable-nls >> $LOGDIR/$BINUTILS.log 2>&1
            printf "Building $BINUTILS ($TARGET)\n";
            $GMAKE_BINARY >> $LOGDIR/$BINUTILS.log 2>&1
            printf "Installing $BINUTILS ($TARGET)\n";
            $GMAKE_BINARY install >> $LOGDIR/$BINUTILS.log 2>&1
            cd $TOPDIR
    else
            printf "Found as binary ($TARGET)\n"       
    fi
done

# **** CMAKE *****
if [ ! -f $CMAKE_BINARY ]; then
        printf "Configuring $CMAKE\n";
        cd $BUILDDIR/$CMAKE
        $TOPDIR/$SOURCEDIR/$CMAKE/configure >> $LOGDIR/$CMAKE.log 2>&1
        printf "Building $CMAKE\n";
        $GMAKE_BINARY >> $LOGDIR/$CMAKE.log 2>&1
        printf "Installing $CMAKE\n";
        $GMAKE_BINARY DESTDIR=$TOPDIR/$BINDIR install >> $LOGDIR/$CMAKE.log 2>&1
        cd $TOPDIR;
else
        printf "Found $CMAKE binary\n";       
fi

# **** LLVM / CLANG / LLD / LLDB *****
if [ ! -f $CLANG_BINARY ]; then
        cd $BUILDDIR/$CLANG;
        printf "Building $CLANG Makefile\n";
        $CMAKE_BINARY -DCMAKE_INSTALL_PREFIX=$TOPDIR/$BINDIR -DCMAKE_BUILD_TYPE=Release $TOPDIR/$SOURCEDIR/$LLVM.src >> $LOGDIR/$CLANG.log 2>&1
        printf "Building $CLANG\n"; 
        $GMAKE_BINARY >> $LOGDIR/$CLANG.log 2>&1
        printf "Installing $CLANG\n";
        $GMAKE_BINARY install >> $LOGDIR/$CLANG.log 2>&1
        cd $TOPDIR;
else
        printf "Found $CLANG binary\n";       
fi

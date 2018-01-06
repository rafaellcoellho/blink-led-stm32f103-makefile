# Blink Led STM32f103

A template to start projects with the STM32F1xx family on linux using makefile, having static analysis and unit tests. The initial example will be the flashing of a led.

## Prerequisites


First you need to clone this repository on your machine.

```
$ git clone https://github.com/rafaellcoellho/blink-led-stm32f103.git
```

To analyze the code according to the linux kernel code style, the perl checkpatch script is used. In the scripts folder use dowload.sh to download directly from /torvalds/linux/scripts. Thanks to riboseinc who write the [script](https://github.com/riboseinc/checkpatch).

```
$ cd scripts/
$ ./download.sh
```

The static analysis of the code is done through cppcheck. If you use ubuntu 14+ or some distro based on it, you can install using:

```
$ sudo apt-get install cppcheck
```

It is open source and the repository is here in [github](https://github.com/danmar/cppcheck). If you prefer, just compile from the source:

```
$ git clone git://github.com/danmar/cppcheck.git
$ cd cppcheck/
$ git checkout 1.70
$ make CFGDIR=/etc/cppcheck/ HAVE_RULES=yes
$ sudo CFGDIR=/etc/cppcheck/ make install
```

To check if it really worked:

```
$ cppcheck --version
Cppcheck 1.70
```
The tests are done with [CppUTest](https://github.com/cpputest/cpputest). You need to run the setup-cpputest.sh script in the scripts folder. It will download the test framework inside the project tree.

```
$ cd scripts/
$ ./setup-cpputest.sh
```
Let's use the gcc toolchain for ARM. You must install the compiler, assembler, linker, and some utilities.

```
$ apt-get install gcc-arm-none-eabi binutils-arm-none-eabi libnewlib-arm-none-eabi
```

## Usage

To run static analysis (And check encoding patterns):

```
$ make analysis
```

To run the tests

```
make tests
```

To compile:

```
$ make runnable
```

To delete the unnecessary files:

```
$ make clean
```

## Authors

* **Rafael Coelho** - [rafaellcoellho](https://github.com/rafaellcoellho)

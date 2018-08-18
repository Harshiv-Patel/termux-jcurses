# Generated automatically from Makefile.in by configure.
CURSES=-lncurses -lc
JAVAHOME=/data/data/com.termux/files/usr/lib/jvm/openjdk-9
#JAVAC=$(JAVAHOME)/bin/javac
JAVAC=javac
JAR=jar
JAVAH=javah
JAVA=java
JAVADOC=javadoc
GCC=gcc
GCCFLAGS=-Wall -shared -I$(JAVAHOME)/include -I$(JAVAHOME)/include/ 
OLIB=./lib/libjcurses.so
CLASSPATH=./classes

#default: jar native
java: ;
	$(JAVAC) \
		-classpath $(CLASSPATH) \
		-encoding iso-8859-1 \
		-source 1.6 \
		-target 1.6 \
		-d  ./classes \
		`find ./src/jcurses -name *.java`

docs: ;
	$(JAVADOC) \
		-classpath $(CLASSPATH) \
		-encoding iso-8859-1 \
		-sourcepath ./src \
		-d ./doc jcurses.event jcurses.system jcurses.util jcurses.widgets

#native: java include

include: java;
	$(JAVAH) \
		-classpath $(CLASSPATH) \
		-d ./src/native/include jcurses.system.Toolkit

clean: ;
	rm \
		-rf ./classes/jcurses \
		./lib/libjcurses.so \
		./lib/jcurses.jar \
		./src/native/include/*.h

native: 
	$(GCC) $(GCCFLAGS) \
		-fpic \
		-o lib/libjcurses.so \
		$(CURSES) src/native/Toolkit.c

jar: java;
	cd classes/ && $(JAR) -cvf ../lib/jcurses.jar *

test: ;
	$(JAVA) \
		-classpath ./lib/jcurses.jar \
		-Djcurses.protocol.filename=jcurses.log jcurses.tests.Test

install:
	termux-elf-cleaner ./lib/*.so
	install ./lib/libjcurses.so $(PREFIX)/lib/libjcurses.so

uninstall: clean;
	rm $(PREFIX)/lib/libjcurses.so
all: clean java include jar native install


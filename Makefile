# Lib(X)SVF  -  A library for implementing SVF and XSVF JTAG players
#
# Copyright (C) 2009  RIEGL Research ForschungsGmbH
# Copyright (C) 2009  Clifford Wolf <clifford@clifford.at>
# 
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
# 
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

#AR = ppc_6xx-ar
#RANLIB = ppc_6xx-ranlib
#CC = ppc_6xx-gcc
#CFLAGS += -DXSVFTOOL_RLMS_VLINE

AR = ar
RANLIB = ranlib
CC = gcc

CFLAGS += -Wall -Os -ggdb -MD
#CFLAGS += -Wextra -Wno-unused-parameter -Werror

help:
	@echo ""
	@echo "Usage:"
	@echo ""
	@echo "  $(MAKE) libxsvf.a"
	@echo "                .... build only the library"
	@echo ""
	@echo "  $(MAKE) xsvftool-gpio"
	@echo "                .... build the library and xsvftool-gpio"
	@echo ""
	@echo "  $(MAKE) all"
	@echo "                .... build the library and all examples"
	@echo ""
	@echo "  $(MAKE) install"
	@echo "                .... install everything in /usr/local/"
	@echo ""

all: libxsvf.a xsvftool-gpio

install: all
	install -Dt /usr/local/bin/ xsvftool-gpio
	install -Dt /usr/local/include/ -m 644 libxsvf.h
	install -Dt /usr/local/lib/ -m 644 libxsvf.a

libxsvf.a: tap.o statename.o memname.o svf.o xsvf.o scan.o play.o
	rm -f libxsvf.a
	$(AR) qc $@ $^
	$(RANLIB) $@

xsvftool-gpio: libxsvf.a xsvftool-gpio.o

clean:
	rm -f xsvftool-gpio
	rm -f libxsvf.a *.o *.d

-include *.d

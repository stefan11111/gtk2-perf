PREFIX=/usr/local

XCFLAGS = ${CFLAGS} $(shell pkg-config --cflags gtk+-2.0) -std=c99
XLDFLAGS = ${LDFLAGS} $(shell pkg-config --libs gtk+-2.0)

all:
	glib-genmarshal --prefix=_gtk_marshal marshalers.list --header > marshalers.h
	glib-genmarshal --prefix=_gtk_marshal marshalers.list --body > marshalers.c
	${CC} ${XCFLAGS} appwindow.c -c -o appwindow.o
	${CC} ${XCFLAGS} gtkwidgetprofiler.c -c -o gtkwidgetprofiler.o
	${CC} ${XCFLAGS} textview.c -c -o textview.o
	${CC} ${XCFLAGS} typebuiltins.c -c -o typebuiltins.o
	${CC} ${XCFLAGS} marshalers.c -c -o marshalers.o
	${CC} ${XCFLAGS} main.c -c -o main.o
	${CC} ${XCFLAGS} appwindow.o gtkwidgetprofiler.o textview.o typebuiltins.o marshalers.o main.o -o perf ${XLDFLAGS}
install:
	mkdir -p ${DESTDIR}${PREFIX}/bin
	cp -r perf ${DESTDIR}${PREFIX}/bin/gtk2-perf

clean:
	rm -f *.o marshalers.{c,h} perf

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/gtk2-perf

.PHONY: all clean install uninstall

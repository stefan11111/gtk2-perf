PREFIX=/usr/local

all:
	glib-genmarshal --prefix=_gtk_marshal marshalers.list --header > marshalers.h
	glib-genmarshal --prefix=_gtk_marshal marshalers.list --body > marshalers.c
	${CC} ${CFLAGS} $(shell pkg-config --cflags gtk+-2.0) appwindow.c -c -o appwindow.o
	${CC} ${CFLAGS} $(shell pkg-config --cflags gtk+-2.0) gtkwidgetprofiler.c -c -o gtkwidgetprofiler.o
	${CC} ${CFLAGS} $(shell pkg-config --cflags gtk+-2.0) textview.c -c -o textview.o
	${CC} ${CFLAGS} $(shell pkg-config --cflags gtk+-2.0) typebuiltins.c -c -o typebuiltins.o
	${CC} ${CFLAGS} $(shell pkg-config --cflags gtk+-2.0) marshalers.c -c -o marshalers.o
	${CC} ${CFLAGS} $(shell pkg-config --cflags gtk+-2.0) main.c -c -o main.o
	${CC} ${CFLAGS} $(shell pkg-config --cflags gtk+-2.0) $(shell pkg-config --libs gtk+-2.0) appwindow.o gtkwidgetprofiler.o textview.o typebuiltins.o marshalers.o main.o -o perf ${LDFLAGS}
install:
	mkdir -p ${DESTDIR}${PREFIX}/bin
	cp -r perf ${DESTDIR}${PREFIX}/bin/gtk2-perf

clean:
	rm -f *.o marshalers.{c,h} perf

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/gtk2-perf

.PHONY: all clean install uninstall

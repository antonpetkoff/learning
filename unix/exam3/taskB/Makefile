ifndef CC
	CC=gcc
endif
CFLAGS=-std=c99 -Werror -Wall -Wpedantic -Wextra
SRCS=main.c generator.c
OBJS=$(subst .c,.o,$(SRCS))
RM=rm -f

all: main generator

main: main.o
	$(CC) $(CFLAGS) -o main main.c -lm

generator: generator.o
	$(CC) $(CFLAGS) -o generator generator.c

clean:
	$(RM) $(OBJS) main generator


CC = gcc
CFLAGS = -g -Wall -O2 -std=c99
LDFLAGS = -lm

SOURCES = eulers_ten.c
OBJECTS = $(SOURCES:.c=.o)
TARGET = eulers_ten

$(TARGET) : $(OBJECTS)
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

.PHONY: clean

clean:
	@rm -f $(TARGET) $(OBJECTS) core

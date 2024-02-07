OBJECTS=storytllr.o 
CFLAGS=-g -Wall
LIBS=-lm -lSDL2 -lGL -lGLU -lGLEW -I.
RM=rm
CC=g++
PROGRAM_NAME=StoryTllr_lin

all: $(PROGRAM_NAME)
	
clean:
	$(RM) *.o

$(OBJECTS): ../player-win/storytllr.cpp
	$(CC) -o $(OBJECTS) ../player-win/storytllr.cpp $(LIBS)

$(PROGRAM_NAME):$(OBJECTS)
	cp $(OBJECTS) ../bin/$(PROGRAM_NAME)
	@echo " "
	@echo "Done!"
	@echo " "
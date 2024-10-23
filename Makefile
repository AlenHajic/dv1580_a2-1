# Compiler and Linking Variables
CC = gcc
CFLAGS = -Wall -fPIC -pthread
LDFLAGS = -lm
LIB_NAME = libmemory_manager.so

# Source and Object Files
SRC = memory_manager.c
OBJ = $(SRC:.c=.o)

# Default target: builds both memory manager and linked list
all: mmanager list

# Rule to create the dynamic library (memory manager)
mmanager: $(LIB_NAME) test_memory_manager

$(LIB_NAME): $(OBJ)
	$(CC) -shared -o $@ $(OBJ) $(LDFLAGS)

# Rule to compile source files into object files
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Rule to build the linked list application and link it with libmemory_manager.so
list: test_linked_list

test_linked_list: test_linked_list.o linked_list.o $(LIB_NAME)
	$(CC) $(CFLAGS) -o test_linked_list linked_list.o test_linked_list.o -L. -lmemory_manager $(LDFLAGS)
	cp test_linked_list test_linked_listCG

# Rule to compile test_linked_list.c into an object file
test_linked_list.o: test_linked_list.c
	$(CC) $(CFLAGS) -c test_linked_list.c -o test_linked_list.o

# Rule to compile linked_list.c into an object file
linked_list.o: linked_list.c
	$(CC) $(CFLAGS) -c linked_list.c -o linked_list.o

# Rule to build the test_memory_manager application
test_memory_manager: test_memory_manager.o memory_manager.o $(LIB_NAME)
	$(CC) $(CFLAGS) -o test_memory_manager memory_manager.o test_memory_manager.o -L. -lmemory_manager $(LDFLAGS)
	cp test_memory_manager test_memory_managerCG

# Rule to compile test_memory_manager.c into an object file
test_memory_manager.o: test_memory_manager.c
	$(CC) $(CFLAGS) -c test_memory_manager.c -o test_memory_manager.o

# Run all tests
run_tests: run_test_mmanager run_test_list

# Run test cases for the memory manager
run_test_mmanager:
	./test_memory_manager

# Run test cases for the linked list
run_test_list:
	./test_linked_list

# Clean target to clean up build files
clean:
	rm -f $(OBJ) $(LIB_NAME) test_memory_manager test_linked_list test_memory_manager.o test_linked_list.o linked_list.o test_linked_listCG test_memory_managerCG


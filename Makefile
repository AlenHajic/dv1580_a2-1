# Compiler and Linking Variables
CC = gcc
CFLAGS = -Wall -fPIC
LDFLAGS = -pthread
LIB_NAME = libmemory_manager.so

# Source and Object Files
SRC = memory_manager.c
OBJ = $(SRC:.c=.o)

# Default target: builds both memory manager and linked list
all: mmanager list

# Rule to create the dynamic library (memory manager)
mmanager: $(LIB_NAME)

$(LIB_NAME): $(OBJ)
	$(CC) -shared -o $@ $(OBJ) $(LDFLAGS)

# Rule to compile source files into object files
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Rule to build the linked list application and link it with libmemory_manager.so
list: linked_list.o $(LIB_NAME)
	$(CC) $(CFLAGS) -o test_linked_list linked_list.c test_linked_list.c -L. -lmemory_manager $(LDFLAGS)
	cp test_linked_list test_linked_listCG

# Test target to run the memory manager test program
test_mmanager: $(LIB_NAME)
	$(CC) $(CFLAGS) -o test_memory_manager test_memory_manager.c -L. -lmemory_manager $(LDFLAGS)

# Test target to run the linked list test program
test_list: $(LIB_NAME) linked_list.o
	$(CC) $(CFLAGS) -o test_linked_list linked_list.c test_linked_list.c -L. -lmemory_manager $(LDFLAGS)
	cp test_linked_list test_linked_listCG

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
	rm -f $(OBJ) $(LIB_NAME) test_memory_manager test_linked_list test_linked_listCG linked_list.o

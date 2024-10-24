# Compiler and Linking Variables
CC = gcc
CFLAGS = -Wall -fPIC -pthread -lm
LIB_NAME = libmemory_manager.so
LDFLAGS = -lm

# Source and Object Files
SRC = memory_manager.c
OBJ = $(SRC:.c=.o)

# Default target: builds both memory manager and linked list
all: mmanager list test_mmanager test_list

# Rule to create the dynamic library
$(LIB_NAME): $(OBJ)
	$(CC) $(CFLAGS) -shared -o $@ $(OBJ) $(LDFLAGS)

# Rule to compile source files into object files
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Build the memory manager
mmanager: $(LIB_NAME)

# Build the linked list
list: linked_list.o

# Test target to run the memory manager test program
#$(LIB_NAME)
test_mmanager: $(LIB_NAME)
	$(CC) $(CFLAGS) -o test_memory_manager test_memory_manager.c -L. -lmemory_manager $(LDFLAGS)

# Test target to run the linked list test program
#$(LIB_NAME) linked_list.o
#linked_list.c
test_list: $(LIB_NAME) linked_list.o
	$(CC) $(CFLAGS) -o test_linked_list linked_list.c test_linked_list.c -L. -lmemory_manager $(LDFLAGS)


# test_memory_manager: test_memory_manager.o memory_manager.o $(LIB_NAME)
# 	$(CC) $(CFLAGS) -o test_memory_manager memory_manager.o test_memory_manager.o -L. -lmemory_manager $(LDFLAGS)
# 	cp test_memory_manager test_memory_managerCG

# # Rule to compile test_memory_manager.c into an object file
# test_memory_manager.o: test_memory_manager.c
# 	$(CC) $(CFLAGS) -c test_memory_manager.c -o test_memory_manager.o

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
	rm -f $(OBJ) $(LIB_NAME) test_memory_manager test_linked_list linked_list.o

# Compiler and Linking Variables
CC = gcc
CFLAGS = -Wall -fPIC
LDFLAGS = -pthread -lm
LIB_NAME = libmemory_manager.dll

# Source and Object Files
SRC = memory_manager.c
OBJ = $(SRC:.c=.o)

# Default target: builds both memory manager and linked list
all: mmanager list

# Rule to create the dynamic library (memory manager)
mmanager: $(LIB_NAME)

$(LIB_NAME): $(OBJ)
	$(CC) -shared -o $@ $(OBJ) -Wl,--out-implib,libmemory_manager.a $(LDFLAGS)

# Rule to compile source files into object files
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Rule to build the linked list application and link it with libmemory_manager.dll
list: linked_list.o $(LIB_NAME)
	$(CC) $(CFLAGS) -o test_linked_list linked_list.c test_linked_list.c -L. -lmemory_manager $(LDFLAGS)
	copy test_linked_list.exe test_linked_listCG.exe

# Rule to create the test_memory_manager binary
test_mmanager: mmanager memory_manager.o
	$(CC) $(CFLAGS) -o test_memory_manager memory_manager.o test_memory_manager.c -L. -lmemory_manager $(LDFLAGS)
	copy test_memory_manager.exe test_memory_manager_listCG.exe

# Run all tests
run_tests: run_test_mmanager run_test_list

# Run test cases for the memory manager
run_test_mmanager:
	./test_memory_manager.exe

# Run test cases for the linked list
run_test_list:
	./test_linked_list.exe

# Clean target to clean up build files
clean:
	rm -f $(OBJ) $(LIB_NAME) libmemory_manager.a test_memory_manager.exe test_linked_list.exe test_linked_listCG.exe linked_list.o

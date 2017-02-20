#include <stdio.h>
#include <inttypes.h>
#include <err.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdlib.h>
#include <math.h>

int source_fd, aux_fd;
uint32_t * buffer;
ssize_t read_size;
uint64_t file_size;
size_t buffer_size,    // buffer size is the same as the available RAM
       window_size,
       buffers_count,
       windows_count;

int comparator(const void * l, const void * r) {
    return (*(uint32_t *) l) - (*(uint32_t *) r);
}

void print_integers(uint32_t * array, int size) {
    for (int i = 0; i < size; ++i) {
        printf("%d ", array[i]);
    }
    printf("\n\n");
}

void close_fds() {
    close(source_fd);
    close(aux_fd);
}

struct stream {
private:
    uint32_t * window_base;
    uint32_t * window_offset;  // must be in bounds of the window
    size_t items_count; // count of uint32_t items ready for reading
    int fd;
    off_t file_base;    // in bytes
    off_t file_offset;
    //bool is_empty; // TODO:
public:
    stream(uint32_t * window_start, int target_fd, off_t file_start) {
        window_offset = window_base = window_start; // empty memory window
        fd = target_fd;
        file_offset = file_base = file_start;
        items_count = 0;
    }

    bool get_next(uint32_t * item) {
        if (items_count == 0 && ((file_offset - file_base) < buffer_size)) {
            // read the next window-sized chunk from the stream's dedicated input buffer
            off_t prev_offset = file_offset, next_offset = file_base + prev_offset;
            
            // TODO: use ternary operator
            if (file_offset + window_size < buffer_size) {
                next_offset += window_size;
            } else {    // read the last chunk
                next_offset += (buffer_size - file_offset);
            }
            
            window_offset = window_base;    // reset memory window pointer
            items_count = (next_offset - prev_offset) / sizeof(uint32_t);

            file_offset = lseek(fd, next_offset, SEEK_SET);
            
            if ((next_offset - prev_offset) != read(fd, window_base, window_size)) {
                err(1, "Failed reading a window from an input buffer!");
                close_fds(); // TODO: what about allocated memory?
            }
        }
        
        if (items_count) {
            // TODO: isn't window_offset redundant with items_count?
            *item = *(window_offset++);
            --items_count;
            return true;
        }

        //is_empty = true;
        return false;
    }
};

int main(int argc, char ** argv) {
    if (argc != 3) {
        err(1, "You must pass 2 arguments: a file for sorting and available RAM in bytes!");
    }

    if ((source_fd = open(argv[1], O_RDONLY)) == -1) {
        err(1, "Couldn't open file for reading!");
    }

    file_size = lseek(source_fd, 0, SEEK_END);
    lseek(source_fd, 0, SEEK_SET);
    if (file_size % sizeof(uint32_t)) {
        warn("Unaligned data is given!");
    }
    printf("File size: %" PRIu64 " bytes\n", file_size);
    buffer_size = atoi(argv[2]);
    printf("Available RAM (memory buffer size): %zu bytes\n", buffer_size);
    buffers_count = ceil(file_size / (double) buffer_size);
    windows_count = buffers_count + 1; 
    window_size = buffer_size / windows_count;
    window_size -= window_size % sizeof(uint32_t);
    printf("Auxiliary buffers (of size %zu) count: %zu\n", buffer_size, buffers_count);
    printf("Window size: %zu bytes (aligned to 4 bytes (uint32_t))\n", window_size);
    printf("Windows count: %zu\n", windows_count);

    buffer = (uint32_t *) malloc(buffer_size);

    if ((aux_fd = open("aux", O_WRONLY | O_CREAT | O_TRUNC, 0644)) == -1) {
        close(source_fd);
        err(1, "Couldn't open auxiliary file for writing!");
    }

    // sort separately buffers_count chunks from the source_fd
    while ((read_size = read(source_fd, buffer, buffer_size)) > 0) {
        qsort(buffer, read_size / sizeof(uint32_t), sizeof(uint32_t), comparator);
        //print_integers(buffer, read_size / sizeof(uint32_t));

        if (read_size != write(aux_fd, buffer, read_size)) {
            close_fds();
            err(1, "Less data was written than it was read!");
        }
    }

    free(buffer);
    close_fds();
}


#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>
#include <err.h>
#include <stdio.h>
#include <string.h>
#define __STDC_FORMAT_MACROS
#include <inttypes.h>

int main(int argc, char** argv) {
    int fd;
    ssize_t read_size;
    uint8_t buffer[1<<12];
    const int SIZE = 1<<8;
    uint64_t bytes[SIZE];
    memset(bytes, 0, SIZE * sizeof(uint64_t));
    
    if (argc != 2) {
        err(1, "Exactly one argument must be passed!");
    }

    if ((fd = open(argv[1], O_RDONLY)) == -1) {
        err(1, "Could not open file for reading");
    }

    while ((read_size = read(fd, &buffer, sizeof(buffer))) > 0) {
        for (int i = 0; i < read_size; ++i) {
            bytes[(uint8_t) buffer[i]]++;
        }
    }
    close(fd);

    printf("%s", "BYTE\tCOUNT\n");
    for (int i = 0; i < SIZE; ++i) {
        printf("%d\t%" PRIu64 "\n", i, bytes[i]);
    }
}


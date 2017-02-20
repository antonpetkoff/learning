#include <stdio.h>
#include <inttypes.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <err.h>
#include <stdlib.h>
#include <unistd.h>

const int INTEGER_COUNT = (1<<13) / sizeof(uint32_t);

int main() {
    int fd;
    uint32_t integer = 0;

    if ((fd = open("data", O_WRONLY | O_CREAT | O_TRUNC, 0644)) == -1) {
        err(1, "Couldn't open file 'data' for writing");
    }

    for (int i = 0; i < INTEGER_COUNT; ++i) {
        integer = rand() % 1000;
        if (sizeof(uint32_t) != write(fd, &integer, sizeof(uint32_t))) {
            err(1, "Couldn't write integer to file!");
        }
    }
}

#include <stdio.h>
#include <inttypes.h>
#include <err.h>
#include <string.h>

#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdlib.h>

/**
 *  За реализацията на решението е използван алгоритъмът Counting Sort.
 *  След стандартните проверки за правилен вход проверяваме колко байта има в подадения
 *  файл, заделяме достатъчно памет и сортираме. Накрая записваме сортираната редица.
 *
 *  Изпробвах програмата върху няколко файла и видях, че работи.
 *  Може би се престарах за тази задача.
 */

const int BUCKETS_COUNT = 1<<8; // there are 256 distinct 1 byte values

void counting_sort(uint8_t * source, uint8_t * sorted, int size) {
    uint8_t buckets[BUCKETS_COUNT];
    
    // use memset() instead of '= {0}', so that the array size can be stored in a constant
    memset(buckets, 0, BUCKETS_COUNT * sizeof(uint8_t));

    for (int i = 0; i < size; ++i) {
        ++buckets[source[i]];
    }

    for (int i = 1; i < 255; ++i) {
        buckets[i] += buckets[i - 1];
    }

    for (int i = size - 1; i >= 0; --i) {
        sorted[buckets[source[i]] - 1] = source[i];
        --buckets[source[i]];
    }
}

int main(int argc, char ** argv) {
    int fd, file_size;
    ssize_t bytes_read, bytes_written;
    uint8_t * buffer, * sorted;

    if (argc != 2) {
        err(1, "A path to a binary file must be passed as a single argument!");
    }

    if ((fd = open(argv[1], O_RDWR, S_IWUSR)) == -1) {
        err(1, "Cannot open file for read/write!");
    }

    file_size = lseek(fd, 0, SEEK_END);
    buffer = (uint8_t *) malloc(sizeof(uint8_t) * file_size);
    sorted = (uint8_t *) malloc(sizeof(uint8_t) * file_size);
    lseek(fd, 0, SEEK_SET);

    bytes_read = read(fd, buffer, file_size);
    if (bytes_read != file_size) {
        err(1, "Error while reading file!");
    }
    
    counting_sort(buffer, sorted, file_size);
    lseek(fd, 0, SEEK_SET);

    bytes_written = write(fd, sorted, file_size);
    if (bytes_written != file_size) {
        err(1, "Error while writing file!");
    }

    free(sorted);
    free(buffer);
    close(fd);
}


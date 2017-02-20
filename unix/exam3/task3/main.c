#include <stdio.h>
#include <inttypes.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <err.h>
#include <inttypes.h>

/**
 *  За съжаление ще ми отнеме твърде много време да създам тестови данни и да проверя
 *  коректността на решението си.
 *
 *  Решение:
 *  Присъства стандартната проверка за коректен брой подадени аргументи, както и проверките
 *  дали файловете са отворени успешно. Всички отворени файлови дескриптори се затварят
 *  при настъпване на изход на програмата. Има доста проверки за грешки, които са сложени
 *  с цел да се провери по-лесно коректността на програмата.
 *
 *  Прочитат се наредени двойки от f1 в масива tuples[2], който държи числа със съответните
 *  размери, поставени в условието на задачата - uint32_t. Правят се проверки дали са
 *  прочетени и записани точно толкова байтове, колкото са нужни за да работи коректно
 *  програмата. Например когато четем наредена двойка искаме да прочетем
 *  2 * sizeof(uint32_t) байта, което е равно на sizeof(tuple).
 *  Използва се lseek() за да се движим в f2, от който трябва да прочитаме числа от
 *  различни позиции, определени от наредената двойка <x_i, y_i>, която сме прочели от f1
 *  и съхранили в tuple за i-тата итерация на while цикъла.
 *  Чрез whence аргумента SEEK_SET на lseek() позиционираме абсолютно указателя за четене
 *  на f2 на позиция x_i. Понеже трябва да вземем y_i на брой uint32_t числа от f2 от
 *  позиция x_i нататък, завъртаме for цикъл по j в интервала [0, y_i), за да копираме
 *  в f3 точно y_i на брой числа последователно от f2.
 */

int fd1, fd2, fd3;

void close_fds() {
    close(fd1);
    close(fd2);
    close(fd3);
}

int main(int argc, char ** argv) {
    ssize_t f1_rs, f2_rs, f3_ws;    // rs = read size, ws = write size
    uint32_t tuple[2], number;

    if (argc != 4) {
        err(1, "Exectly 3 arguments must be passed!");
    }

    if ((fd1 = open(argv[1], O_RDONLY)) == -1) {
        err(1, "Failed opening first file for reading!");
    }

    if ((fd2 = open(argv[2], O_RDONLY)) == -1) {
        close(fd1);
        err(1, "Failed opening second file for reading!");
    }

    if ((fd3 = open(argv[3], O_WRONLY, S_IWUSR)) == -1) {
        close(fd1);
        close(fd2);
        err(1, "Failed opening third file for writing!");
    }

    // прочитаме наредената двойка <x_i, y_i> в tuple масива от uint32_t
    while ((f1_rs = read(fd1, tuple, sizeof(tuple))) > 0) {
        if (f1_rs != sizeof(tuple)) {
            close_fds();
            err(1, "Error while reading tuples from file 1!");
        }

        printf("%d, %d\n", (unsigned int) tuple[0], (unsigned int) tuple[1]);

        // местим f2 до позиция x_i
        lseek(fd2, tuple[0] * sizeof(uint32_t), SEEK_SET);

        // прочитаме y_i на брой uint32_t числа от f2 и ги записваме в f3
        for (uint32_t j = 0; j < tuple[1]; ++j) {
            
            // за всяко j от [0, y_i) прочитаме число от f2 на позиция (x_i + j)
            lseek(fd2, j * sizeof(uint32_t), SEEK_CUR);
            
            if ((f2_rs = read(fd2, &number, sizeof(uint32_t))) != sizeof(uint32_t)) {
                close_fds();
                err(1, "Failed reading correctly a number from file 2!");
            }

            // записваме прочетеното число в f3
            if ((f3_ws = write(fd3, &number, sizeof(uint32_t))) != sizeof(uint32_t)) {
                close_fds();
                err(1, "Failed writing correctly a number into file 3!");
            }
        }
    }

    close_fds();
}


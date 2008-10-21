/*
 * opcontrol/opcontrol.cpp
 */

#include "op_config.h"

#include <stdlib.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <assert.h>
#include <dirent.h>
#include <sys/stat.h>

static int usage(const char* name);
static int echo(const char* str, const char* file);
static int read_num(const char* file);

static int start_profiler(int argc, char const * argv[]);
static int stop_profiler();
static int reset_profiler();
static int status_profiler();

int main(int argc, char const * argv[])
{
    if (argc < 2)
        return usage(argv[0]);

    const char* tool = argv[1];

    int ret = 0;
    if (!strcmp("start", tool))        ret = start_profiler(argc-2, argv+2);
    else if (!strcmp("stop", tool))    ret = stop_profiler();
    else if (!strcmp("reset", tool))   ret = reset_profiler();
    else if (!strcmp("status", tool))  ret = status_profiler();

    return ret ? usage(argv[0]) : 0;
}

int usage(const char* name)
{
    printf("usage: %s [start [-e event][-p type][-c depth][-i names]"
            " | stop | reset | status]\n", name);
    return 0;
}


int start_profiler(int argc, char const * argv[])
{
    char const* backtrace_depth = "0";
    if (argc&1)
        return -1; 

    while (argc>0) {
        if (!strcmp("-c", argv[0]))
            backtrace_depth = argv[1];
        else if (!strcmp("-p", argv[0]))
            ; // type
        else if (!strcmp("-e", argv[0]))
            ; // event
        else if (!strcmp("-i", argv[0]))
            ; // images
        argc-=2;
        argv+=2;        
    }

    int err;

    err = echo(backtrace_depth, OP_DRIVER_BASE"/backtrace_depth");
    if (err) {
        printf("couldn't set backtrace depth. backtraces disabled.\n");
    }

    err = echo("1", OP_DRIVER_BASE"/enable");
    if (err) {
        printf("couldn't start profiling, is the oprofile driver installed?\n");
        return -1;
    }

    // XXX: start daemon with all good options ...

    mkdir(OP_BASE_DIR, 644);
    return 0;
}

int stop_profiler()
{
    int dump, stop;
    dump = echo("1", OP_DRIVER_BASE"/dump");
        // XXX: should wait for complete_dump
    usleep(250000);
    stop = echo("0", OP_DRIVER_BASE"/enable");
    if (dump || stop) {
        printf("couldn't stop profiling, is the oprofile driver installed?\n");
        return -1;
    }
    int num = read_num(OP_DRIVER_BASE"/stats/cpu0/sample_received");
    printf("profiler stopped with %u samples received\n", num);
    return 0;
}

int rm_dir_content(const char* path)
{
    DIR* d = opendir(path);
    if (d) {
        struct dirent* de;
        while ((de = readdir(d))) {
            if(de->d_name[0] == '.') continue;
            struct stat s;
            char* tmp = (char*)malloc(strlen(path)+strlen(de->d_name)+2);
            if (tmp) {
                sprintf(tmp, "%s/%s", path, de->d_name);
                if (lstat(tmp, &s) == 0) {
                    int mode = s.st_mode & S_IFMT;
                    if (mode == S_IFDIR) {
                        rm_dir_content(tmp);
                        rmdir(tmp);
                    } else if (mode == S_IFLNK) {
                    } else if (mode == S_IFSOCK) {
                    } else if (mode == S_IFREG) {
                        unlink(tmp);
                    }
                }
                free(tmp);
            }
        }
        closedir(d);
    }
    return 0;
}

int reset_profiler()
{
    echo("1", OP_DRIVER_BASE"/dump");
    usleep(250000);
    // should erase all samples
    rm_dir_content(OP_BASE_DIR);
    return 0;
}


int status_profiler()
{
    int num = read_num(OP_DRIVER_BASE"/enable");
    if (num >= 0) {
        printf("profiler %s\n", num ? "started" : "not started");
        num = read_num(OP_DRIVER_BASE"/stats/cpu0/sample_received");
        printf("  %9u samples received\n", num);
        num = read_num(OP_DRIVER_BASE"/stats/cpu0/backtrace_aborted");
        printf("  %9u backtrace aborted\n", num);
        num = read_num(OP_DRIVER_BASE"/stats/cpu0/sample_lost_overflow");
        printf("  %9u samples lost overflow\n", num);
        num = read_num(OP_DRIVER_BASE"/backtrace_depth");
        printf("  %9u backtrace_depth\n", num);
        return 0;
    }
    printf("couldn't get profiling status, is the oprofile driver installed?\n");
    return -1;

}

int echo(const char* str, const char* file)
{
    int fd = open(file, O_WRONLY);
    if (fd<0)
        return fd;
    write(fd, str, strlen(str));
    close(fd);
    return 0;
}

int read_num(const char* file)
{
    char buffer[256];
    int fd = open(file, O_RDONLY);
    if (fd<0) return -1;
    int rd = read(fd, buffer, sizeof(buffer)-1);
    buffer[rd] = 0;
    return atoi(buffer);
}


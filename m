Received: from mail-yw0-f179.google.com ([209.85.161.179]:52676 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbdKOIib (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 15 Nov 2017 03:38:31 -0500
Received: by mail-yw0-f179.google.com with SMTP id j198so1997593ywg.9
        for <fstests@vger.kernel.org>; Wed, 15 Nov 2017 00:38:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1510731882-9145-1-git-send-email-xzhou@redhat.com>
References: <1510731882-9145-1-git-send-email-xzhou@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 15 Nov 2017 10:38:29 +0200
Message-ID: <CAOQ4uxgyUt_=Bq6FsOTwW8PwFQmN8TVhJQfXxfhFVN_0HxNWWw@mail.gmail.com>
Subject: Re: [PATCH] generic: add stress test for fanotify and inotify
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Xiong Zhou <xzhou@redhat.com>
Cc: fstests <fstests@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

On Wed, Nov 15, 2017 at 9:44 AM, Xiong Zhou <xzhou@redhat.com> wrote:
> Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> ---
>
>   This test takes a bit longer time, so I was hesitating adding
> it to the "auto" group. Any suggestions are welcome.

I am not sure that 5m is too long for auto, but IIUC you say this test
panics the kernel, so it may justify the 'dangerous' group, but perhaps
I did not understand the side effects of the test on the system.

>
>   On some older kernels, this test keeps eating several MBs per
> second. OOM/panic will happen after all free memory consumed. This
> kind of panic is narrowed down to triggered by the "flush_stress"
> loop, which I believe has been fixed.
>
>   Panic on 4.14.0+ kernel. No OOM heppened, just hang and panic.
> Tested on 2 hosts: 72c32G, 32c46G.
>
>   This patch depends on my previous OFD lock patch.
>
>  .gitignore            |   1 +
>  src/Makefile          |   2 +-
>  src/fsnotify_stress.c | 339 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/468     | 168 +++++++++++++++++++++++++
>  tests/generic/468.out |   2 +
>  tests/generic/group   |   1 +
>  6 files changed, 512 insertions(+), 1 deletion(-)
>  create mode 100644 src/fsnotify_stress.c
>  create mode 100755 tests/generic/468
>  create mode 100644 tests/generic/468.out
>
> diff --git a/.gitignore b/.gitignore
> index 77acb42..5a10a04 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -72,6 +72,7 @@
>  /src/fill
>  /src/fill2
>  /src/fs_perms
> +/src/fsnotify_stress
>  /src/fssum
>  /src/fstest
>  /src/fsync-err
> diff --git a/src/Makefile b/src/Makefile
> index f37af74..7650e30 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -14,7 +14,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
>         t_mmap_writev t_truncate_cmtime dirhash_collide t_rename_overwrite \
>         holetest t_truncate_self t_mmap_dio af_unix t_mmap_stale_pmd \
>         t_mmap_cow_race t_mmap_fallocate fsync-err t_mmap_write_ro \
> -       t_ofd_locks
> +       t_ofd_locks fsnotify_stress
>
>  LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>         preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> diff --git a/src/fsnotify_stress.c b/src/fsnotify_stress.c
> new file mode 100644
> index 0000000..f113918
> --- /dev/null
> +++ b/src/fsnotify_stress.c
> @@ -0,0 +1,339 @@
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE     /* Needed to get O_LARGEFILE definition */
> +#endif
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <limits.h>
> +#include <poll.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/fanotify.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <dirent.h>
> +#include <sys/inotify.h>
> +
> +static void handle_events(int fd)
> +{
> +       const struct fanotify_event_metadata *metadata;
> +       struct fanotify_event_metadata buf[200];
> +       ssize_t len;
> +       struct fanotify_response response;
> +
> +       /* Loop while events can be read from fanotify file descriptor */
> +       for(;;) {
> +               /* Read some events */
> +               len = read(fd, (void *) &buf, sizeof(buf));
> +               if (len == -1 && errno != EAGAIN) {
> +                       perror("read");
> +                       exit(EXIT_FAILURE);
> +               }
> +               /* Check if end of available data reached */
> +               if (len <= 0)
> +                       break;
> +               /* Point to the first event in the buffer */
> +               metadata = buf;
> +               /* Loop over all events in the buffer */
> +               while (FAN_EVENT_OK(metadata, len)) {
> +                       /* Check that run-time and compile-time structures match */
> +                       if (metadata->vers != FANOTIFY_METADATA_VERSION) {
> +                               fprintf(stderr,
> +                                   "Mismatch of fanotify metadata version.\n");
> +                               exit(EXIT_FAILURE);
> +                       }
> +                       if (metadata->fd >= 0) {
> +                               /* Handle open permission event */
> +                               if (metadata->mask & FAN_OPEN_PERM) {
> +                                       /* Allow file to be opened */
> +                                       response.fd = metadata->fd;
> +                                       response.response = FAN_ALLOW;
> +                                       write(fd, &response,
> +                                           sizeof(struct fanotify_response));
> +                               }
> +                               /* Handle access permission event */
> +                               if (metadata->mask & FAN_ACCESS_PERM) {
> +                                       /* Allow file to be accessed */
> +                                       response.fd = metadata->fd;
> +                                       response.response = FAN_ALLOW;
> +                                       write(fd, &response,
> +                                           sizeof(struct fanotify_response));
> +                               }
> +                               /* Close the file descriptor of the event */
> +                               close(metadata->fd);
> +                       }
> +                       /* Advance to next event */
> +                       metadata = FAN_EVENT_NEXT(metadata, len);
> +               }
> +       }
> +}
> +
> +static int fanotify_watch(char *arg)
> +{
> +       int fd, poll_num;
> +       nfds_t nfds;
> +       struct pollfd fds[2];
> +
> +       /* Create the file descriptor for accessing the fanotify API */
> +       fd = fanotify_init(FAN_CLOEXEC | FAN_CLASS_CONTENT | FAN_NONBLOCK,
> +                                          O_RDONLY | O_LARGEFILE);
> +       if (fd == -1) {
> +               perror("fanotify_init");
> +               exit(EXIT_FAILURE);
> +       }
> +       /*
> +        * Mark the mount for:
> +        * - permission events before opening files
> +        * - notification events after closing a write-enabled
> +            file descriptor
> +        */
> +       if (fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_MOUNT,
> +                       FAN_ACCESS | FAN_MODIFY | FAN_OPEN_PERM |
> +                       FAN_CLOSE | FAN_OPEN | FAN_ACCESS_PERM |
> +                       FAN_ONDIR | FAN_EVENT_ON_CHILD,
> +                       -1, arg) == -1) {
> +               perror("fanotify_mark");
> +               exit(EXIT_FAILURE);
> +       }
> +       /* Prepare for polling */
> +       nfds = 1;
> +       /* Fanotify input */
> +       fds[0].fd = fd;
> +       fds[0].events = POLLIN;
> +       /* This is the loop to wait for incoming events */
> +       while (1) {
> +               poll_num = poll(fds, nfds, -1);
> +               if (poll_num == -1) {
> +                       if (errno == EINTR)     /* Interrupted by a signal */
> +                               continue;           /* Restart poll() */
> +                       perror("poll");         /* Unexpected error */
> +                       exit(EXIT_FAILURE);
> +               }
> +               if (poll_num > 0) {
> +                       if (fds[0].revents & POLLIN) {
> +                               /* Fanotify events are available */
> +                               handle_events(fd);
> +                       }
> +               }
> +       }
> +       exit(EXIT_SUCCESS);
> +}
> +
> +static int fanotify_flush_stress(char *arg)
> +{
> +       int fd;
> +
> +       /* Create the file descriptor for accessing the fanotify API */
> +       fd = fanotify_init(FAN_CLOEXEC | FAN_CLASS_CONTENT | FAN_NONBLOCK,
> +                                          O_RDONLY | O_LARGEFILE);
> +       if (fd == -1) {
> +               perror("fanotify_init");
> +               exit(EXIT_FAILURE);
> +       }
> +
> +       /* Loop marking all kinds of events and flush */
> +       while (1) {
> +               if (fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_MOUNT,
> +                         FAN_ACCESS | FAN_MODIFY | FAN_OPEN_PERM | FAN_CLOSE |
> +                         FAN_OPEN | FAN_ACCESS_PERM | FAN_ONDIR |
> +                         FAN_EVENT_ON_CHILD, -1, arg) == -1)
> +                       perror("fanotify_mark add");
> +
> +               if (fanotify_mark(fd, FAN_MARK_FLUSH | FAN_MARK_MOUNT,
> +                                               0, -1, arg) == -1)
> +                       perror("fanotify_mark flush mount");
> +
> +               if (fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_MOUNT,
> +                         FAN_ACCESS | FAN_MODIFY | FAN_OPEN_PERM | FAN_CLOSE |
> +                         FAN_OPEN | FAN_ACCESS_PERM | FAN_ONDIR |
> +                         FAN_EVENT_ON_CHILD, -1, arg) == -1)
> +                       perror("fanotify_mark add");
> +
> +               if (fanotify_mark(fd, FAN_MARK_FLUSH, 0, -1, arg) == -1)
> +                       perror("fanotify_mark flush");
> +       }
> +       close(fd);
> +       exit(EXIT_SUCCESS);
> +}
> +
> +static int fanotify_init_stress(char *arg)
> +{
> +       int fd;
> +
> +       while (1) {
> +               /* Create the file descriptor for accessing the fanotify API */
> +               fd = fanotify_init(FAN_CLOEXEC | FAN_CLASS_CONTENT |
> +                               FAN_NONBLOCK, O_RDONLY | O_LARGEFILE);
> +               if (fd == -1)
> +                       perror("fanotify_init");
> +               if (fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_MOUNT,
> +                               FAN_ACCESS | FAN_MODIFY | FAN_OPEN_PERM |
> +                               FAN_CLOSE | FAN_OPEN | FAN_ACCESS_PERM |
> +                               FAN_ONDIR | FAN_EVENT_ON_CHILD, -1,
> +                               arg) == -1)
> +                       perror("fanotify_mark");
> +               close(fd);
> +       }
> +       exit(EXIT_SUCCESS);
> +}
> +
> +static void add_mark(int fd, uint64_t mask, char *path)
> +{
> +       if (fanotify_mark(fd, FAN_MARK_ADD, mask, -1, path) == -1)
> +               perror("fanotify_mark add");
> +}
> +
> +static void remove_mark(int fd, uint64_t mask, char *path)
> +{
> +       if (fanotify_mark(fd, FAN_MARK_REMOVE, mask, -1, path) == -1)
> +               perror("fanotify_mark remove");
> +}
> +
> +static int fanotify_mark_stress(char *arg)
> +{
> +       int fd;
> +
> +       /* Create the file descriptor for accessing the fanotify API */
> +       fd = fanotify_init(FAN_CLOEXEC | FAN_CLASS_CONTENT | FAN_NONBLOCK,
> +                                          O_RDONLY | O_LARGEFILE);
> +       if (fd == -1) {
> +               perror("fanotify_init");
> +               exit(EXIT_FAILURE);
> +       }
> +       /* Loop marking all kinds of events */
> +       while (1) {
> +               add_mark(fd, FAN_ACCESS, arg);
> +               remove_mark(fd, FAN_ACCESS, arg);
> +               add_mark(fd, FAN_MODIFY, arg);
> +               remove_mark(fd, FAN_MODIFY, arg);
> +               add_mark(fd, FAN_OPEN_PERM, arg);
> +               remove_mark(fd, FAN_OPEN_PERM, arg);
> +               add_mark(fd, FAN_CLOSE, arg);
> +               remove_mark(fd, FAN_CLOSE, arg);
> +               add_mark(fd, FAN_OPEN, arg);
> +               remove_mark(fd, FAN_OPEN, arg);
> +               add_mark(fd, FAN_ACCESS_PERM, arg);
> +               remove_mark(fd, FAN_ACCESS_PERM, arg);
> +               add_mark(fd, FAN_ONDIR, arg);
> +               remove_mark(fd, FAN_ONDIR, arg);
> +               add_mark(fd, FAN_EVENT_ON_CHILD, arg);
> +               remove_mark(fd, FAN_EVENT_ON_CHILD, arg);
> +       }
> +
> +       close(fd);
> +       exit(EXIT_SUCCESS);
> +}
> +
> +static int inotify_watch(char *arg)
> +{
> +       int notify_fd;
> +       int wd, ret;
> +       char *buf;
> +
> +       buf = malloc(sizeof(struct inotify_event) + NAME_MAX + 1);
> +       if (buf == NULL) {
> +               perror("malloc");
> +               return -1;
> +       }
> +
> +       notify_fd = inotify_init1(IN_CLOEXEC);
> +       if (notify_fd == -1) {
> +               perror("inotify_init1");
> +               return -1;
> +       }
> +
> +       wd = inotify_add_watch(notify_fd, arg,
> +               IN_ACCESS | IN_ATTRIB | IN_CLOSE_WRITE | IN_CLOSE_NOWRITE |
> +               IN_CREATE | IN_DELETE | IN_DELETE_SELF | IN_MODIFY |
> +               IN_MOVE_SELF | IN_MOVED_FROM | IN_MOVED_TO | IN_OPEN);
> +       if (wd < 0) {
> +               perror("inotify_add_watch");
> +               return -1;
> +       }
> +
> +       while ((ret = read(notify_fd, buf, NAME_MAX)) != -1) {
> +                       ;
> +       }
> +
> +       ret = inotify_rm_watch(notify_fd, wd);
> +       if (ret < 0)
> +               perror("inotify_rm_watch");
> +
> +       close(notify_fd);
> +       free(buf);
> +       return 0;
> +}
> +
> +static int inotify_add_rm_watch_stress(char *arg)
> +{
> +       int notify_fd;
> +       int wd, ret;
> +
> +       notify_fd = inotify_init1(IN_CLOEXEC);
> +       if (notify_fd == -1) {
> +               perror("inotify_init1");
> +               return -1;
> +       }
> +
> +       while (1) {
> +               wd = inotify_add_watch(notify_fd, arg,
> +                       IN_ACCESS | IN_ATTRIB | IN_CLOSE_WRITE |
> +                       IN_CLOSE_NOWRITE | IN_CREATE | IN_DELETE |
> +                       IN_DELETE_SELF | IN_MODIFY | IN_MOVE_SELF |
> +                       IN_MOVED_FROM | IN_MOVED_TO | IN_OPEN);
> +               if (wd < 0)
> +                       perror("inotify_add_watch");
> +               ret = inotify_rm_watch(notify_fd, wd);
> +               if (ret < 0)
> +                       perror("inotify_rm_watch");
> +       }
> +       close(notify_fd);
> +       return 0;
> +}
> +
> +static int inotify_init_stress(void)
> +{
> +       int notify_fd;
> +
> +       while (1) {
> +               notify_fd = inotify_init1(IN_CLOEXEC);
> +               if (notify_fd == -1)
> +                       perror("inotify_init1");
> +               close(notify_fd);
> +       }
> +       return 0;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +       pid_t pid;
> +
> +       if (argc != 2) {
> +               fprintf(stderr, "Usage: %s testdir\n", argv[0]);
> +               exit(EXIT_FAILURE);
> +       }
> +
> +       if ((pid = fork()) == 0)
> +               fanotify_watch(argv[1]);
> +
> +       if ((pid = fork()) == 0)
> +               fanotify_flush_stress(argv[1]);
> +
> +       if ((pid = fork()) == 0)
> +               fanotify_init_stress(argv[1]);
> +
> +       if ((pid = fork()) == 0)
> +               fanotify_mark_stress(argv[1]);
> +
> +       if ((pid = fork()) == 0)
> +               inotify_watch(argv[1]);
> +
> +       if ((pid = fork()) == 0)
> +               inotify_add_rm_watch_stress(argv[1]);
> +
> +       if ((pid = fork()) == 0)
> +               inotify_init_stress();
> +
> +       return 0;
> +}
> diff --git a/tests/generic/468 b/tests/generic/468
> new file mode 100755
> index 0000000..4519f49
> --- /dev/null
> +++ b/tests/generic/468
> @@ -0,0 +1,168 @@
> +#! /bin/bash
> +# FS QA Test 468
> +#
> +# Stress test for fanotify and inotify.
> +#
> +# Exercise fanotify and inotify interfaces in loop while
> +# other stress tests going on in the watched test directory.
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2017 Red Hat Inc.  All Rights Reserved.
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write the Free Software Foundation,
> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +#-----------------------------------------------------------------------
> +#
> +
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1       # failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +       cd /
> +       rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +stopfile=$tmp.stop
> +TIMEOUT=5m
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch
> +
> +function add_files ()
> +{
> +       local i=$((RANDOM))
> +
> +       touch $SCRATCH_MNT/f-$i
> +       ln -s $SCRATCH_MNT/f-$i $SCRATCH_MNT/f-$i-sym
> +       ln $SCRATCH_MNT/f-$i $SCRATCH_MNT/f-$i-hdl
> +       mkdir $SCRATCH_MNT/d-$i
> +       mknod $SCRATCH_MNT/c-$i c 1 2
> +       mknod $SCRATCH_MNT/b-$i b 1 2
> +}
> +
> +function mv_files ()
> +{
> +       local i
> +       for i in $SCRATCH_MNT/* ; do
> +               mv -f f-$i f-$i-rename
> +       done
> +}
> +
> +function read_files ()
> +{
> +       find $SCRATCH_MNT/
> +       cat $SCRATCH_MNT/f-*
> +       ls -R $SCRATCH_MNT/d-*
> +}
> +
> +function write_files ()
> +{
> +       local i
> +       for i in $SCRATCH_MNT/* ; do
> +               echo 1 > $i
> +               echo 2 >> $i
> +       done
> +}
> +
> +function rm_files ()
> +{
> +       local i
> +       for i in $SCRATCH_MNT/* ; do
> +               rm -rf $i
> +       done
> +}
> +
> +free_mem()
> +{
> +       echo 3 > /proc/sys/vm/drop_caches
> +       free -m | grep Mem | awk '{print $4}'
> +}
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount
> +
> +fm1=`free_mem`
> +
> +NR_CPUS=$(grep -c processor /proc/cpuinfo)
> +[ $NR_CPUS -lt 4 ] && NR_CPUS=4
> +opts="-d $SCRATCH_MNT/ -p $NR_CPUS -n 50 -v -l 0 -c $FSSTRESS_AVOID"
> +$FSSTRESS_PROG $opts >> $seqres.full 2>&1 &
> +
> +rm -f $stopfile
> +for j in 1 2 ; do
> +
> +for i in `seq 1 $(($NR_CPUS/7 + 1))` ; do
> +       $here/src/fsnotify_stress $SCRATCH_MNT &
> +done
> +
> +# run read/write files operations
> +while [ ! -e $stopfile ]; do
> +       add_files > /dev/null 2>&1
> +done &
> +while [ ! -e $stopfile ]; do
> +       mv_files > /dev/null 2>&1
> +done &
> +while [ ! -e $stopfile ]; do
> +       read_files > /dev/null 2>&1
> +done &
> +while [ ! -e $stopfile ]; do
> +       write_files > /dev/null 2>&1
> +done &
> +while [ ! -e $stopfile ]; do
> +       rm_files > /dev/null 2>&1
> +done &
> +
> +done
> +
> +# stressing for $TIMEOUT
> +sleep $TIMEOUT
> +touch $stopfile
> +
> +fm2=`free_mem`
> +
> +# cleanup stress processes
> +while killall fsnotify_stress > /dev/null 2>&1 ; do
> +       sleep 1
> +done
> +while killall fsstress > /dev/null 2>&1 ; do
> +       sleep 1
> +done
> +
> +# wait _files functions done
> +wait
> +
> +echo $fm1 $fm2 >> $seqres.full
> +if [ $fm1 -gt $fm2 ] && [ $((fm1-fm2)) -gt 1024 ] ; then
> +       echo mem leaked
> +fi

Is that the most accurate way to test mem leak caused by fsnotify?
Wouldn't it be better to measure leak of fsnotify_mark/inotify_inode_mark
slabs?

> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/generic/468.out b/tests/generic/468.out
> new file mode 100644
> index 0000000..a3bdc04
> --- /dev/null
> +++ b/tests/generic/468.out
> @@ -0,0 +1,2 @@
> +QA output created by 468
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index 9bea64c..a52ce41 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -470,3 +470,4 @@
>  465 auto rw quick aio
>  466 auto quick rw
>  467 auto quick
> +468 auto stress

Please also add to new 'fsnotify' group.

Amir.

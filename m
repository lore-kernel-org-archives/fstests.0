Received: from mx1.redhat.com ([209.132.183.28]:34484 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751363AbdJXIQf (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 24 Oct 2017 04:16:35 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 406BE2627
        for <fstests@vger.kernel.org>; Tue, 24 Oct 2017 08:16:35 +0000 (UTC)
Date: Tue, 24 Oct 2017 16:16:32 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v3] generic: add OFD lock tests
Message-ID: <20171024081632.GC3235@eguan.usersys.redhat.com>
References: <20171016102849.GA10593@eguan.usersys.redhat.com>
 <1508401836-5114-1-git-send-email-xzhou@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1508401836-5114-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Xiong Zhou <xzhou@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Oct 19, 2017 at 04:30:36PM +0800, Xiong Zhou wrote:
> The basic idea is placing a type of lock in one process,
> eg WRLCK, on a testfile in SCRATCH_MNT, then do fcntl
> getlk with a type of lock, eg RDLCK, in another process.
> In the end, we check the returned flock.l_type by getlk
> to see if the lock mechanism works fine.
> 
> We can also test these situations:
> that the two locks are conflicting or not;
> that open testfile RDONLY or RDWR.
> 
> Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> ---
> 
> v3:
>   Use golden output to match test result;
>   Use semaphore to sync getlk/setlk;
>   Add option parse to the test programme;
>   Add a testrun code path for the helper;
>   Add more comments;
>   Skip the not stable /proc/locks check.

v3 looks better, thanks! More comments inline.

> 
>  .gitignore            |   1 +
>  common/rc             |  11 +++
>  src/Makefile          |   3 +-
>  src/t_ofd_locks.c     | 262 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/466     | 119 +++++++++++++++++++++++
>  tests/generic/466.out |  13 +++
>  tests/generic/group   |   1 +
>  7 files changed, 409 insertions(+), 1 deletion(-)
>  create mode 100644 src/t_ofd_locks.c
>  create mode 100755 tests/generic/466
>  create mode 100644 tests/generic/466.out
> 
> diff --git a/.gitignore b/.gitignore
> index 2014c08..77acb42 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -126,6 +126,7 @@
>  /src/t_mmap_write_ro
>  /src/t_mmap_writev
>  /src/t_mtab
> +/src/t_ofd_locks
>  /src/t_readdir_1
>  /src/t_readdir_2
>  /src/t_rename_overwrite
> diff --git a/common/rc b/common/rc
> index e2a8229..983a214 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3192,6 +3192,17 @@ _require_test_fcntl_advisory_locks()
>  		_notrun "Require fcntl advisory locks support"
>  }
>  
> +_require_ofd_locks()
> +{
> +	# Give a test run by setlk/getlk rdlck on testfile.
> +	# If the running kernel does not support OFD locks,
> +	# EINVAL will be returned.
> +	touch $TEST_DIR/ofd_testfile || \
> +		_notrun "Something wrong with $TEST_DIR"
> +	src/t_ofd_locks -t $TEST_DIR/ofd_testfile > /dev/null 2>&1
> +	[ $? -eq 22 ] && _notrun "Require OFD locks support"

Perhaps we can move _require_test_program "t_ofd_locks" here too.

> +}
> +
>  _require_test_lsattr()
>  {
>  	testio=$(lsattr -d $TEST_DIR 2>&1)
> diff --git a/src/Makefile b/src/Makefile
> index 3eb25b1..f37af74 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -13,7 +13,8 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
>  	multi_open_unlink dmiperf unwritten_sync genhashnames t_holes \
>  	t_mmap_writev t_truncate_cmtime dirhash_collide t_rename_overwrite \
>  	holetest t_truncate_self t_mmap_dio af_unix t_mmap_stale_pmd \
> -	t_mmap_cow_race t_mmap_fallocate fsync-err t_mmap_write_ro
> +	t_mmap_cow_race t_mmap_fallocate fsync-err t_mmap_write_ro \
> +	t_ofd_locks
>  
>  LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>  	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> diff --git a/src/t_ofd_locks.c b/src/t_ofd_locks.c
> new file mode 100644
> index 0000000..f87c9c5
> --- /dev/null
> +++ b/src/t_ofd_locks.c
> @@ -0,0 +1,262 @@
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <errno.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <stdlib.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <sys/ipc.h>
> +#include <sys/sem.h>
> +
> +/*
> + * In distributions that do not have these macros ready in
> + * glibc-headers, compilation fails. Adding them here to avoid
> + * build errors, relevant tests would fail at the helper which
> + * requires OFD locks support and notrun if the kernel does not
> + * support OFD locks. If the kernel does support OFD locks,
> + * we are good to go.
> + *
> + */
> +#ifndef F_OFD_GETLK
> +#define F_OFD_GETLK    36
> +#endif
> +
> +#ifndef F_OFD_SETLK
> +#define F_OFD_SETLK    37
> +#endif
> +
> +#ifndef F_OFD_SETLKW
> +#define F_OFD_SETLKW   38
> +#endif
> +
> +/* This is required by semctl to set semaphore value */
> +union semun {
> +	int              val;    /* Value for SETVAL */
> +	struct semid_ds *buf;    /* Buffer for IPC_STAT, IPC_SET */
> +	unsigned short  *array;  /* Array for GETALL, SETALL */
> +	struct seminfo  *__buf;  /* Buffer for IPC_INFO
> +				    (Linux-specific) */
> +};
> +
> +int fd;
> +
> +void err_exit(char *op, int errn)
> +{
> +	fprintf(stderr, "%s: %s\n", op, strerror(errn));
> +	if (fd > 0)
> +		close(fd);
> +	exit(errn);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	/* Five flags that used to specify operation details.
> +	 * They can be specified via command line options.

For multi-line comments, please use this format

	/*
	 * Five flags that ..
	 * Then can be ...
	 */

> +	 *
> +	 * option: -s/-g
> +	 * lock_cmd : 1 <--> setlk
> +	 *	      0 <--> getlk
> +	 *
> +	 * option: -r/-w
> +	 * lock_rw : 1 <--> set/get wrlck
> +	 *	     0 <--> set/get rdlck
> +	 *
> +	 * option: -o num
> +	 * lock_start : l_start to getlk
> +	 *
> +	 * option: -R/-W
> +	 * open_rw : 1 <--> open file RDWR
> +	 *	     0 <--> open file RDONLY
> +	 *
> +	 * This option is for _require_ofd_locks helper, just do
> +	 * fcntl setlk then return errno.
> +	 * option: -t
> +	 * testrun : 1 <--> this is a testrun, return after setlk
> +	 *	     0 <--> this is not a testrun, run as usual
> +	 */

I think this usage information should be in a usage() function, which
gets called when error happens in option parsing.

> +
> +	/* By default, we setlk WRLCK on [0,9], opening file RDWR.
> +	 */
> +
> +	int lock_cmd = 1;
> +	int lock_rw = 1;
> +	int lock_start = 0;
> +	int open_rw = 1;
> +	int testrun = 0;
> +
> +	/* We use semaphore to synchronize between getlk and setlk.
> +	 *
> +	 * Although we run getlk routine after running setlk routine
> +	 * in background, getlk still can be executed before setlk
> +	 * sometimes, which is invalid for our tests.
> +	 *
> +	 * In setlk routine, we wait getlk done, then exit, making sure
> +	 * the lock is still there when doing getlk.
> +	 *
> +	 * In getlk routine, we wait till setlk done firstly, making
> +	 * sure the lock is valid at that time, then we do getlk,
> +	 * after that, we tell setlk we are done, then exit.
> +	 */
> +	key_t semkey;
> +	unsigned short vals[2];
> +	union semun arg;
> +	int semid;
> +	struct sembuf sop;
> +
> +	struct flock flk = {
> +		.l_whence = SEEK_SET,
> +		.l_start = 0,
> +		.l_len = 10,     /* lock range [0,9] */
> +		.l_type = F_RDLCK,
> +		.l_pid = 0,
> +	};
> +
> +	int opt;
> +
> +	while((opt = getopt(argc, argv, "sgrwo:RWt")) != -1) {
> +		switch(opt) {
> +		case 's':
> +			lock_cmd = 1;
> +			break;
> +		case 'g':
> +			lock_cmd = 0;
> +			break;
> +		case 'r':
> +			lock_rw = 0;
> +			break;
> +		case 'w':
> +			lock_rw = 1;
> +			break;
> +		case 'o':
> +			lock_start = atoi(optarg);
> +			break;
> +		case 'R':
> +			open_rw = 0;
> +			break;
> +		case 'W':
> +			open_rw = 1;
> +			break;
> +		case 't':
> +			testrun = 1;
> +			break;
> +		default:
> +			printf("Usage: %s [-sgrwo:RW] filename\n", argv[0]);
> +			return -1;
> +		}
> +	}
> +
> +	if (lock_rw == 1)
> +		flk.l_type = F_WRLCK;
> +	else
> +		flk.l_type = F_RDLCK;
> +
> +	if (open_rw == 0)
> +		fd = open(argv[optind], O_RDONLY);
> +	else
> +		fd = open(argv[optind], O_RDWR);
> +	if (fd == -1)
> +		err_exit("open", errno);
> +
> +	/* In a testun, we do a fcntl getlk call and exit
> +	 * immediately no matter it succeeds or not.
> +	 */
> +	if (testrun == 1) {
> +		if (fcntl(fd, F_OFD_GETLK, &flk) < 0)
> +			err_exit("test_ofd_getlk", errno);
> +		if (fd > 0)
> +			close(fd);

fd is always greater than 0 here, just close(fd) should be fine. Or use
err_exit() unconditionally? e.g.

		fcntl(fd, ...);
		err_exit("test_ofd_getlk", errno);

> +		exit(0);
> +	}
> +
> +	/* Init the semaphore, with key related to the same file.
> +	 * If the sem set has not been created, we initialnize it.
> +	 * If it exists, we semget again to get the exist one.
> +	 * To make sure getlk routine and setlk routine are looking
> +	 * at the same semaphore set in one single round of test.
> +	 */
> +	if((semkey = ftok("ofd_key", 255)) == -1)
> +		err_exit("ftok", errno);

This uses a file called "ofd_key" in current working dir, usually $here
in fstests, I don't think that's good idea, how about using the test
file too? i.e. argv[optind].

> +	semid = semget(semkey, 2, IPC_CREAT|IPC_EXCL);
> +	if (semid < 0) {
> +		/* The sem exists or errer happens. */
> +		if (errno != EEXIST)
> +			err_exit("semget0", errno);
> +
> +		semid = semget(semkey, 2, 0);
> +		if (semid < 0)
> +			err_exit("semget1", errno);
> +	} else {
> +		/* Init both new sem to 1. */
> +		vals[0] = 1;
> +		vals[1] = 1;
> +		arg.array = vals;
> +		if (semctl(semid, 2, SETALL, arg) == -1)
> +			err_exit("init sem", errno);
> +	}
> +
> +	/* setlk */
> +	if (lock_cmd == 1) {
> +		if (fcntl(fd, F_OFD_SETLKW, &flk) < 0)
> +			err_exit("ofd_setlkw", errno);
> +
> +		/* set sem0 to 0 after setlk done */
> +		arg.val = 0;
> +		if (semctl(semid, 0, SETVAL, arg) == -1)
> +			err_exit("set sem0 0", errno);
> +
> +		/* wating sem 1 to be zero */
> +		sop.sem_num = 1;
> +		sop.sem_op = 0;
> +		sop.sem_flg = 0;
> +		if (semop(semid, &sop, 1) == -1)
> +			err_exit("wait sem1 0", errno);
> +
> +		/* remove sem set after one round of test */
> +		if (semctl(semid, 2, IPC_RMID, arg) == -1)
> +			err_exit("rmid", errno);
> +	}
> +
> +	/* getlck */
> +	if (lock_cmd == 0) {
> +		flk.l_start = lock_start;
> +
> +		/* wating sem 0 to be zero */
> +		sop.sem_num = 0;
> +		sop.sem_op = 0;
> +		sop.sem_flg = 0;
> +		if (semop(semid, &sop, 1) == -1)
> +			err_exit("wait sem0 0", errno);
> +
> +		if (fcntl(fd, F_OFD_GETLK, &flk) < 0)
> +			err_exit("ofd_getlk", errno);
> +
> +		/* set sem1 to 0 after getlk done */
> +		arg.val = 0;
> +		if (semctl(semid, 1, SETVAL, arg) == -1)
> +			err_exit("set sem1 0", errno);
> +
> +		switch (flk.l_type) {
> +		case F_UNLCK:
> +			printf("lock could be placed\n");
> +			break;
> +		case F_RDLCK:
> +			printf("get rdlck\n");
> +			break;
> +		case F_WRLCK:
> +			printf("get wrlck\n");
> +			break;
> +		default:
> +			printf("error\n");

Could be more verbose on error, e.g. "unknown lock type"?

> +			close(fd);
> +			return 0;
> +		}
> +	}
> +
> +	close(fd);
> +	return 0;
> +}
> diff --git a/tests/generic/466 b/tests/generic/466
> new file mode 100755
> index 0000000..8903af4
> --- /dev/null
> +++ b/tests/generic/466
> @@ -0,0 +1,119 @@
> +#! /bin/bash
> +# FS QA Test 466
> +#
> +# Test OFD locks, F_OFD_SETLK/F_OFD_GETLK
> +#
> +# The basic idea is placing a type of lock in one process,
> +# eg WRLCK, on a testfile in SCRATCH_MNT, then do fcntl
> +# getlk with a type of lock, eg RDLCK, in another process.
> +# In the end, we check the returned flock.l_type by getlk
> +# to see if the lock mechanism works fine.
> +#
> +# We can also test these situations:
> +# that the two locks are conflicting or not;
> +# that open testfile RDONLY or RDWR.
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
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	rm -f ofd_key

Better not to pollute $here as mentioned above.

> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch
> +_require_test_program "t_ofd_locks"
> +_require_ofd_locks
> +
> +# real QA test starts here
> +_scratch_mkfs >> $seqres.full 2>&1
> +
> +# prepare a 4k test file
> +$XFS_IO_PROG -f -c "pwrite -S 0xFF 0 4096" \
> +	$SCRATCH_MNT/testfile >> $seqres.full 2>&1
> +
> +do_test()
> +{
> +	local soptions="$1"
> +	local goptions="$2"
> +	rm -f fifo

Unused fifo, this line can be removed.

> +	echo $* >> $seqres.full 2>&1
> +	# -s : do setlk
> +	src/t_ofd_locks -s $soptions $SCRATCH_MNT/testfile &

$here/src/t_ofd_locks, not a big issue though.

> +	# -g : do getlk
> +	src/t_ofd_locks -g $goptions $SCRATCH_MNT/testfile
> +	wait
> +}
> +
> +# For the semaphore to sync getlk and getlk
> +touch ofd_key

Can be removed too if take use of $SCRATCH_MNT/testfile

> +
> +# Always setlk at range [0,9], getlk at range [0,9] or [20,29].
> +# To open file RDONLY or RDWR should not break the locks.
> +
> +# -w : operate on F_WRLCK
> +# -r : operate on F_RDLCK
> +# -R : open file RDONLY
> +# -W : open file RDWR
> +# -o : file offset where the lock starts
> +
> +# setlk wrlck [0,9], getlk wrlck [0,9], expect wrlck
> +do_test "-w" "-w"
> +# setlk wrlck [0,9], getlk wrlck [20,29], expect unlck
> +do_test "-w" "-w -o 20"
> +# setlk wrlck [0,9], getlk rdlck [0,9], expect wrlck
> +do_test "-w" "-r"
> +# setlk wrlck [0,9], getlk rdlck [20,29], expect unlck
> +do_test "-w" "-r -o 20"
> +# setlk rdlck [0,9], getlk wrlck [0,9], expect rdlck
> +do_test "-r -R" "-w -R"
> +do_test "-r" "-w"
> +# setlk rdlck [0,9], getlk wrlck [20,29], expect unlck
> +do_test "-r -R" "-w -o 20 -R"
> +do_test "-r" "-w -o 20"
> +# setlk rdlck [0,9], getlk rdlck [0,9], expect unlck
> +do_test "-r -R" "-r -R"
> +do_test "-r" "-r"
> +# setlk rdlck [0,9], getlk rdlck [0,9], expect unlck
                                    ^^^^^ [20,29]

Thanks,
Eryu

> +do_test "-r -R" "-r -o 20 -R"
> +do_test "-r" "-r -o 20"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/466.out b/tests/generic/466.out
> new file mode 100644
> index 0000000..89c77fe
> --- /dev/null
> +++ b/tests/generic/466.out
> @@ -0,0 +1,13 @@
> +QA output created by 466
> +get wrlck
> +lock could be placed
> +get wrlck
> +lock could be placed
> +get rdlck
> +get rdlck
> +lock could be placed
> +lock could be placed
> +lock could be placed
> +lock could be placed
> +lock could be placed
> +lock could be placed
> diff --git a/tests/generic/group b/tests/generic/group
> index fbe0a7f..b716440 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -468,3 +468,4 @@
>  463 auto quick clone dangerous
>  464 auto rw
>  465 auto rw quick aio
> +466 auto quick
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

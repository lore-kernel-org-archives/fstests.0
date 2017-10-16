Received: from mx1.redhat.com ([209.132.183.28]:55520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751410AbdJPK2v (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 16 Oct 2017 06:28:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7F5E34E909
        for <fstests@vger.kernel.org>; Mon, 16 Oct 2017 10:28:51 +0000 (UTC)
Date: Mon, 16 Oct 2017 18:28:49 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2] generic: add OFD lock tests
Message-ID: <20171016102849.GA10593@eguan.usersys.redhat.com>
References: <1507711346-16056-1-git-send-email-xzhou@redhat.com>
 <1507886030-21518-1-git-send-email-xzhou@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1507886030-21518-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Xiong Zhou <xzhou@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Oct 13, 2017 at 05:13:50PM +0800, Xiong Zhou wrote:
> The basic idea is placing a type of lock, eg WRLCK, on
> a testfile in SCRATCH_MNT, then do fcntl getlk with a
> type of lock, eg RDLCK, checking the returned flock
> struct to see if it works fine.
> 
> We can also test these situations:
> that the two locks are conflicting or not;
> that open testfile RDONLY or RDWR.
> 
> Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> ---
> 
> v2:
>   add helper checking if OFD lock is available.
>   mv simple getlk WRLCK test to the helper.
>   add macro definitions in c programme to avoid build errors.
> 
>  .gitignore            |   1 +
>  common/rc             |   8 +++
>  src/Makefile          |   3 +-
>  src/t_ofd_locks.c     | 150 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/463     | 128 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/463.out |   2 +
>  tests/generic/group   |   1 +
>  7 files changed, 292 insertions(+), 1 deletion(-)
>  create mode 100644 src/t_ofd_locks.c
>  create mode 100755 tests/generic/463
>  create mode 100644 tests/generic/463.out
> 
> diff --git a/.gitignore b/.gitignore
> index ae7ef87..2824c3d 100644
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
> index 53bbb11..79f97a4 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3310,6 +3310,14 @@ _require_test_fcntl_advisory_locks()
>  		_notrun "Require fcntl advisory locks support"
>  }
>  
> +_require_scratch_fcntl_ofd_locks()
> +{
> +	# getlk with wrlck only, expect unlck
> +	touch $SCRATCH_MNT/testfile
> +	src/t_ofd_locks $SCRATCH_MNT/testfile 0 1 0 1
> +	[ $? -ne 1 ] && _notrun "Require fcntl OFD locks support"
> +}
> +

I think we can work on a file resides in TEST_DIR and rename it to
_require_ofd_locks(), as TEST_DIR is always mounted pre-test and OFD is
not controlled by any mkfs or mount options.

There're multiple places that could return 1 in t_ofd_locks.c, e.g.
wrong argument count and F_GETLK returned F_UNLCK.

How about checking if t_ofd_locks returned EINVAL? If so then the
running kernel doesn't know F_OFD_* lock commands.

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
> index 0000000..2aab48b
> --- /dev/null
> +++ b/src/t_ofd_locks.c
> @@ -0,0 +1,150 @@
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
> +void err_exit(int fd, char *op)
> +{
> +	fprintf(stderr, "%s: %s\n", op, strerror(errno));
> +	if (fd > 0)
> +		close(fd);
> +	exit(errno);

errno can be changed by close(2) above, you need to save a local copy of
errno.

> +}
> +
> +void set_lock(int fd, struct flock *flkp)
> +{
> +	if (fcntl(fd, F_OFD_SETLKW, flkp) < 0)
> +		err_exit(fd, "ofd_setlkw");
> +}
> +
> +void get_lock(int fd, struct flock *flkp)
> +{
> +	if (fcntl(fd, F_OFD_GETLK, flkp) < 0)
> +		err_exit(fd, "ofd_getlk");
> +}
> +
> +void wait_exit(int fd)
> +{
> +	sleep(1);
> +	close(fd);
> +	exit(0);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int fd;
> +	int lock_cmd;
> +	int lock_rw;
> +	int lock_start = 0;
> +	int open_rw = 1;
> +
> +	struct flock flk = {
> +		.l_whence = SEEK_SET,
> +		.l_start = 0,
> +		.l_len = 10,     /* lock range [0,9] */
> +		.l_type = F_RDLCK,
> +	};
> +
> +	/* lock_cmd : 1 <--> setlk
> +	 *            0 <--> getlk
> +	 *
> +	 *  lock_rw : 1 <--> set/get wrlck
> +	 *            0 <--> set/get rdlck
> +	 *
> +	 * lock_start : l_start to getlk
> +	 *
> +	 *  open_rw : 1 <--> open file RDWR
> +	 *            0 <--> open file RDONLY
> +	 */

This takes me a few seconds to realize that these comments are
describing command line options.. Coule you please make it more obvious?

> +
> +	if (argc < 5) {
> +		printf("Usage: %s filename lock_cmd lock_rw lock_start open_rw\n", argv[0]);
> +		return 1;
> +	}
> +
> +	lock_cmd = atoi(argv[2]);
> +	lock_rw = atoi(argv[3]);
> +	lock_start = atoi(argv[4]);
> +	open_rw = atoi(argv[5]);

And it seems that when lock_cmd is 1 (we're setting a lock), the
lock_start is not used. And it's hard to remember which argument
presents which variable, I'd prefer a getopt(3) parse of arguments, e.g.

	-f	testfile
	-s	set lock
	-g	get lock
	-r	read lock
	-w	write lock
	-R	readonly open
	-o	offset

So getting a write lock on testfile with rw open could be:

./src/t_ofd_locks -g -w -f /path/to/testfile

I think this is a bit easier to read.

> +
> +	if (open_rw == 0)
> +		fd = open(argv[1], O_RDONLY);
> +	else
> +		fd = open(argv[1], O_RDWR);
> +
> +	if (fd < 0)
> +		err_exit(fd, "open");
> +
> +	/* set rdlck */
> +	if (lock_cmd == 1 && lock_rw == 0) {
> +

Extra empty line.

> +		flk.l_type = F_RDLCK;
> +		set_lock(fd, &flk);
> +		wait_exit(fd);
> +	}
> +
> +	/* set wrlck */
> +	if (lock_cmd == 1 && lock_rw == 1) {
> +

Extra empty line.

> +		flk.l_type = F_WRLCK;
> +		set_lock(fd, &flk);
> +		wait_exit(fd);
> +	}
> +
> +	/* getlck */
> +	if (lock_cmd == 0) {
> +

Same here.

> +		if (lock_rw == 1)
> +			flk.l_type = F_WRLCK;
> +		else
> +			flk.l_type = F_RDLCK;
> +
> +		flk.l_start = lock_start;
> +
> +		get_lock(fd, &flk);
> +		close(fd);
> +
> +		switch (flk.l_type) {
> +		case F_UNLCK:
> +			return 1; // lock can be placed
> +		case F_RDLCK:
> +			return 2; // got rdlck
> +		case F_WRLCK:
> +			return 3; // got wrlck
> +		default:
> +			return 0;

As mentioned above, there're multiple places that could return 1. And I
don't think you need to check the expected return value in test script.
How about just printing the result here and let the results match golden
output?

> +		}
> +	}
> +
> +	close(fd);
> +	return 0;
> +}
> diff --git a/tests/generic/463 b/tests/generic/463
> new file mode 100755
> index 0000000..ad4f0dc
> --- /dev/null
> +++ b/tests/generic/463
> @@ -0,0 +1,128 @@
> +#! /bin/bash
> +# FS QA Test 463
> +#
> +# test OFD locks, F_OFD_SETLK/F_OFD_GETLK

Need more descriptions in the test.

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
> +_require_scratch_fcntl_ofd_locks
> +
> +# real QA test starts here
> +_scratch_mkfs >> $seqres.full 2>&1
> +
> +# prepare a 4k test file
> +$XFS_IO_PROG -f -c "pwrite -S 0xFF 0 4096" \
> +	$SCRATCH_MNT/testfile >> $seqres.full 2>&1
> +
> +function do_test()
> +{
> +	# set_rw : 1 <--> set wrlck
> +	#          0 <--> set rdlck
> +	local set_rw=$1
> +
> +	# get_rw : 1 <--> get wrlck
> +	#          0 <--> get rdlck
> +	local get_rw=$2
> +
> +	#  start : l_start to getlk
> +	local start=$3
> +
> +	#     rw : 1 <--> open file RDWR
> +	#          0 <--> open file RDONLY
> +	local rw=$4
> +
> +	#     rs : expected getlk return value
> +	#          1 <--> lock can be placed
> +	#          2 <--> get conflict rdlck
> +	#          3 <--> get conflict wrlck
> +	local rs=$5
> +
> +	# setlk and wait
> +	src/t_ofd_locks $SCRATCH_MNT/testfile 1 $set_rw $start $rw &

In most cases the 1s sleep in t_ofd_locks is enough, but it's still
possible process exits before we check /proc/locks. Also, this makes
every do_test call spends at least 1s, which makes test run time longer
unnecessarily.

Better to make t_ofd_locks wait forever until it's told to exit, e.g.
check the existence of a given file and only exit when the file is
created (or removed).

> +	# check the lock, we've set lock range as [0,9]
> +	if ! grep -qE "OFD.*0 *9" /proc/locks ; then

Hmm, I think this check is racy. Sometimes I got "setlok failed" error
here, and I think that's because this check is scheduled before
t_ofd_locks gets the lock. We should make sure the test binary gets the
lock first.

And check that process ID match the process placed the lock too?

> +		echo setlk failed $*

Dump /proc/locks to $seqres.full too.

> +		wait
> +		return
> +	fi
> +	# getlk
> +	src/t_ofd_locks $SCRATCH_MNT/testfile 0 $get_rw $start $rw
> +	ret=$?
> +	echo $ret >> $seqres.full

Dump all the t_ofd_locks command lines to $seqres.full too for a better
understandable debug log.

> +	# checking return value
> +	[ $ret -ne $rs ] && echo $ret fail $*

As mentioned above, there's no need to check return values, just dump
the F_GETLK results to stdout.

Thanks,
Eryu

> +
> +	wait
> +}
> +
> +# Always setlk at range [0,9], getlk at range [0,9] or [20,29]
> +# To open file RDONLY or RDWR should not break the locks.
> +
> +# setlk wrlck [0,9], getlk wrlck [0,9], expect wrlck
> +do_test 1 1 0 1 3
> +# setlk wrlck [0,9], getlk wrlck [20,29], expect unlck
> +do_test 1 1 20 1 1
> +# setlk wrlck [0,9], getlk rdlck [0,9], expect wrlck
> +do_test 1 0 0 1 3
> +# setlk wrlck [0,9], getlk rdlck [20,29], expect unlck
> +do_test 1 0 20 1 1
> +# setlk rdlck [0,9], getlk wrlck [0,9], expect rdlck
> +do_test 0 1 0 0 2
> +do_test 0 1 0 1 2
> +# setlk rdlck [0,9], getlk wrlck [20,29], expect unlck
> +do_test 0 1 20 0 1
> +do_test 0 1 20 1 1
> +# setlk rdlck [0,9], getlk rdlck [0,9], expect unlck
> +do_test 0 0 0 0 1
> +do_test 0 0 0 1 1
> +# setlk rdlck [0,9], getlk rdlck [0,9], expect unlck
> +do_test 0 0 20 0 1
> +do_test 0 0 20 1 1
> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/generic/463.out b/tests/generic/463.out
> new file mode 100644
> index 0000000..dd61371
> --- /dev/null
> +++ b/tests/generic/463.out
> @@ -0,0 +1,2 @@
> +QA output created by 463
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index f2a6cda..9031e84 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -465,3 +465,4 @@
>  460 auto quick rw
>  461 auto shutdown stress
>  462 auto quick dax
> +463 auto quick
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

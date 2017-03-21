Received: from mx1.redhat.com ([209.132.183.28]:47364 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757722AbdCUPwW (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 21 Mar 2017 11:52:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0B72DC05AA57
        for <fstests@vger.kernel.org>; Tue, 21 Mar 2017 15:52:22 +0000 (UTC)
Date: Tue, 21 Mar 2017 23:52:19 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic: test pagecache invalidation after direct write
Message-ID: <20170321155219.GY14226@eguan.usersys.redhat.com>
References: <20170313065005.24401-1-eguan@redhat.com>
 <20170321151151.GA59313@bfoster.bfoster>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170321151151.GA59313@bfoster.bfoster>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: Quoted-printable
MIME-Version: 1.0
To: Brian Foster <bfoster@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Mar 21, 2017 at 11:11:52AM -0400, Brian Foster wrote:
> On Mon, Mar 13, 2017 at 02:50:05PM +0800, Eryu Guan wrote:
> > Test if direct write invalidates pagecache correctly, so that subsequent
> > buffer read reads the correct data from disk.
> >=20
> > This test is inspired LTP tests dio29, and serves as a regression test
> > for the bug found by it, see kernel commit c771c14baa33 ("iomap:
> > invalidate page caches should be after iomap_dio_complete() in direct
> > write").
> >=20
> > The test can be easily expanded to other write/read combinations, e.g.
> > buffer write + direct read and direct write + direct read, so they are
> > also being tested.
> >=20
> > Signed-off-by: Eryu Guan <eguan@redhat.com>
> > ---
>=20
> Hi Eryu,
>=20
> This mostly looks Ok to me. I notice the test takes just over 2m on a
> test vm and seems to reproduce less than 50% of the time (only in a
> handful of tries). Then again, it only requires 10s or so on a more high
> end system, so that's pretty good. Either way, have you played around
> with the tunables to either speed up the test and/or improve the
> reproducibility?

Yes, the original reproducer for the bug is quick and almost always
reproduces for me on my test vm.

runtest $((10 * LOAD_FACTOR)) -b $sectorsize -n 3 -i 1

I tuned the second test config, which adds more stress. I think current
config works best for me. It takes me around 3 minutes to finish and
doesn't lose too much stress.

runtest $((5 * LOAD_FACTOR))  -b $sectorsize -n 8 -i 4

>=20
> Mostly nits and minor comments to follow...
>=20
> >  .gitignore                 |   1 +
> >  src/Makefile               |   3 +-
> >  src/dio-invalidate-cache.c | 335 +++++++++++++++++++++++++++++++++++++=
++++++++
> >  tests/generic/418          | 122 +++++++++++++++++
> >  tests/generic/418.out      |   2 +
> >  tests/generic/group        |   1 +
> >  6 files changed, 463 insertions(+), 1 deletion(-)
> >  create mode 100644 src/dio-invalidate-cache.c
> >  create mode 100755 tests/generic/418
> >  create mode 100644 tests/generic/418.out
> >=20
> > diff --git a/.gitignore b/.gitignore
> > index 48a40a0..1ed2a92 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -45,6 +45,7 @@
> >  /src/dbtest
> >  /src/devzero
> >  /src/dio-interleaved
> > +/src/dio-invalidate-cache
> >  /src/dirperf
> >  /src/dirstress
> >  /src/dmiperf
> > diff --git a/src/Makefile b/src/Makefile
> > index eb5a56c..a7f27f0 100644
> > --- a/src/Makefile
> > +++ b/src/Makefile
> > @@ -21,7 +21,8 @@ LINUX_TARGETS =3D xfsctl bstat t_mtab getdevicesize p=
reallo_rw_pattern_reader \
> >  	stale_handle pwrite_mmap_blocked t_dir_offset2 seek_sanity_test \
> >  	seek_copy_test t_readdir_1 t_readdir_2 fsync-tester nsexec cloner \
> >  	renameat2 t_getcwd e4compact test-nextquota punch-alternating \
> > -	attr-list-by-handle-cursor-test listxattr dio-interleaved t_dir_type
> > +	attr-list-by-handle-cursor-test listxattr dio-interleaved t_dir_type \
> > +	dio-invalidate-cache
> >=20=20
> >  SUBDIRS =3D
> >=20=20
> > diff --git a/src/dio-invalidate-cache.c b/src/dio-invalidate-cache.c
> > new file mode 100644
> > index 0000000..4fd72ab
> > --- /dev/null
> > +++ b/src/dio-invalidate-cache.c
> > @@ -0,0 +1,335 @@
> > +/*
> > + * Copyright (c) 2017 Red Hat Inc. All Rights Reserved.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it would be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, write the Free Software Foundation,
> > + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> > + */
> > +
> > +/*
> > + * Fork N children, each child writes to and reads from its own region=
 of the
> > + * same test file, and check if what it reads is what it writes. The t=
est
> > + * region is determined by N * blksz. Write and read operation can be =
either
> > + * direct or buffered.
> > + */
> > +
> > +#ifndef _GNU_SOURCE
> > +#define _GNU_SOURCE
> > +#endif
> > +#include <sys/file.h>
> > +#include <sys/types.h>
> > +#include <sys/wait.h>
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <signal.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <unistd.h>
> > +
> > +#define DEF_BLKSZ 4096
> > +
> > +int verbose =3D 0;
> > +
> > +static void usage(const char *prog)
> > +{
> > +	fprintf(stderr, "Usage: %s [-Fhptrwv] [-b blksz] [-n nr_child] [-i it=
erations] [-o offset] <-f filename>\n", prog);
> > +	fprintf(stderr, "\t-F\tPreallocate all blocks by writing them before =
test\n");
> > +	fprintf(stderr, "\t-p\tPreallocate all blocks using fallocate(2) befo=
re test\n");
> > +	fprintf(stderr, "\t-t\tTruncate test file to largest size before test=
\n");
> > +	fprintf(stderr, "\t-r\tDo direct read\n");
> > +	fprintf(stderr, "\t-w\tDo direct write\n");
> > +	fprintf(stderr, "\t-v\tBe verbose\n");
> > +	fprintf(stderr, "\t-h\tshow this help message\n");
> > +	exit(EXIT_FAILURE);
> > +}
> > +
> > +static int cmpbuf(char *b1, char *b2, int bsize)
> > +{
> > +	int i;
> > +
> > +	for (i =3D 0; i < bsize; i++) {
> > +		if (strncmp(&b1[i], &b2[i], 1)) {
>=20
> If you're going to iterate the buffer a byte at a time, shouldn't
> something like 'if (b1[1] !=3D b2[i]) ...' be sufficient here?

You're right, I must have copied this pattern from ltp test and
didn't think more about it.

>=20
> > +			fprintf(stderr, "cmpbuf: offset %d: Expected: 0x%x,"
> > +				" got 0x%x\n", i, b1[i], b2[i]);
> > +			return 1;
> > +		}
> > +	}
> > +	return 0;
> > +}
> > +
> > +static void kill_children(pid_t *pids, int nr_child)
> > +{
> > +	int i;
> > +	pid_t pid;
> > +
> > +	for (i =3D 0; i < nr_child; i++) {
> > +		pid =3D *(pids + i);
>=20
> 			pids[i] ?

Sure.

>=20
> > +		if (pid =3D=3D 0)
> > +			continue;
> > +		kill(pid, SIGTERM);
> > +	}
> > +	return;
> > +}
> > +
> > +static int wait_children(pid_t *pids, int nr_child)
> > +{
> > +	int i, status, ret =3D 0;
> > +	pid_t pid;
> > +
> > +	for (i =3D 0; i < nr_child; i++) {
> > +		pid =3D *(pids + i);
> > +		if (pid =3D=3D 0)
> > +			continue;
> > +		waitpid(pid, &status, 0);
> > +		ret +=3D WEXITSTATUS(status);
> > +	}
> > +	return ret;
> > +}
> > +
> > +static void dumpbuf(char *buf, int size, int blksz)
> > +{
> > +	int i;
> > +
> > +	printf("dumping buffer content\n");
> > +	for (i =3D 0; i < size; i++) {
> > +		if (((i % blksz) =3D=3D 0) || ((i % 64) =3D=3D 0))
> > +			putchar('\n');
> > +		fprintf(stderr, "%x", buf[i]);
>=20
> Hmm.. is it intentional to write the buf data to stderr and the newlines
> to stdout? What does this look like if stderr is redirected?

No.. they both should go to stdout.

>=20
> > +	}
> > +	putchar('\n');
> > +}
> > +
> > +static int run_test(const char *filename, int n_child, int blksz, off_=
t offset,
> > +		    int nr_iter, int flag_rd, int flag_wr)
> > +{
> > +	char *buf_rd;
> > +	char *buf_wr;
> > +	off_t seekoff;
> > +	int fd_rd, fd_wr;
> > +	int i, ret;
> > +	long page_size;
> > +
> > +	seekoff =3D offset + blksz * n_child;
> > +
> > +	page_size =3D sysconf(_SC_PAGESIZE);
> > +	ret =3D posix_memalign((void **)&buf_rd, (size_t)page_size,
> > +		blksz > page_size ? blksz : (size_t)page_size);
> > +	if (ret) {
> > +		fprintf(stderr, "posix_memalign(buf_rd, %d, %d) failed: %d\n",
> > +			blksz, blksz, ret);
> > +		exit(EXIT_FAILURE);
> > +	}
> > +	memset(buf_rd, 0, blksz);
> > +	ret =3D posix_memalign((void **)&buf_wr, (size_t)page_size,
> > +		blksz > page_size ? blksz : (size_t)page_size);
> > +	if (ret) {
> > +		fprintf(stderr, "posix_memalign(buf_wr, %d, %d) failed: %d\n",
> > +			blksz, blksz, ret);
> > +		exit(EXIT_FAILURE);
> > +	}
> > +	memset(buf_wr, 0, blksz);
> > +
> > +	fd_rd =3D open(filename, flag_rd);
> > +	if (fd_rd < 0) {
> > +		perror("open readonly for read");
> > +		exit(EXIT_FAILURE);
> > +	}
> > +
> > +	fd_wr =3D open(filename, flag_wr);
> > +	if (fd_wr < 0) {
> > +		perror("open writeonly for direct write");
> > +		exit(EXIT_FAILURE);
> > +	}
> > +
> > +#define log(format, ...) 			\
> > +	if (verbose) {				\
> > +		printf("[%d:%d] ", n_child, i);	\
> > +		printf(format, __VA_ARGS__);	\
> > +	}
> > +
> > +
> > +	/* seek, write, read and verify */
> > +	ret =3D 0;
> > +	for (i =3D 0; i < nr_iter; i++) {
> > +		memset(buf_wr, n_child + i + 1, blksz);
>=20
> Why use n_child? It doesn't help us differentiate from other threads if
> the values are incremented. Might be more simple to just use i + 1.

Sure, will fix it.

>=20
> > +		if (lseek(fd_wr, seekoff, SEEK_SET) < 0) {
> > +			perror("lseek for write");
> > +			exit(EXIT_FAILURE);
> > +		}
> > +		log("write(fd_wr, %p, %d)\n", buf_wr, blksz);
> > +		if (write(fd_wr, buf_wr, blksz) < 0) {
> > +			perror("direct write");
> > +			exit(EXIT_FAILURE);
> > +		}
>=20
> pwrite()/pread() could eliminate the need for the lseek() calls. Also,
> we probably want to check for short writes as well.

OK.

>=20
> > +
> > +		/* make sure buffer write hit disk before direct read */
> > +		if (!(flag_wr & O_DIRECT)) {
> > +			if (fsync(fd_wr) < 0) {
> > +				perror("fsync(fd_wr)");
> > +				exit(EXIT_FAILURE);
> > +			}
> > +		}
> > +
> > +		if (lseek(fd_rd, seekoff, SEEK_SET) < 0) {
> > +			perror("lseek for read");
> > +			exit(EXIT_FAILURE);
> > +		}
> > +		log("read(fd_rd, %p, %d)\n", buf_rd, blksz);
> > +		if (read(fd_rd, buf_rd, blksz) !=3D blksz) {
> > +			perror("buffer read");
> > +			exit(EXIT_FAILURE);
> > +		}
> > +		if (cmpbuf(buf_wr, buf_rd, blksz) !=3D 0) {
> > +			fprintf(stderr, "[%d:%d] FAIL - comparsion failed, "
>=20
> Typo:							comparison

Will fix.

>=20
> > +				"offset %d\n", n_child, i, (int)seekoff);
> > +			ret +=3D 1;
>=20
> ret doesn't appear to be used after this.

Originally there was no exit call in this error case, but I forgot to
remove the "ret +=3D 1" when adding exit. Will fix it.

>=20
> > +			if (verbose)
> > +				dumpbuf(buf_rd, blksz, blksz);
> > +			exit(EXIT_FAILURE);
> > +		}
> > +	}
> > +	exit(ret);
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +	int nr_iter =3D 1;
> > +	int nr_child =3D 1;
> > +	int blksz =3D DEF_BLKSZ;
> > +	int fd, i, ret =3D 0;
> > +	int flag_rd =3D O_RDONLY;
> > +	int flag_wr =3D O_WRONLY;
> > +	int do_trunc =3D 0;
> > +	int pre_fill =3D 0;
> > +	int pre_alloc =3D 0;
> > +	pid_t pid;
> > +	pid_t *pids;
> > +	off_t offset =3D 0;
> > +	char *filename =3D NULL;
> > +
> > +	while ((i =3D getopt(argc, argv, "b:i:n:f:Fpo:tvrw")) !=3D -1) {
> > +		switch (i) {
> > +		case 'b':
> > +			if ((blksz =3D atoi(optarg)) <=3D 0) {
> > +				fprintf(stderr, "blksz must be > 0\n");
> > +				exit(EXIT_FAILURE);
> > +			}
> > +			if (blksz % 512 !=3D 0) {
> > +				fprintf(stderr, "blksz must be multiple of 512\n");
> > +				exit(EXIT_FAILURE);
> > +			}
> > +			break;
> > +		case 'i':
> > +			if ((nr_iter =3D atoi(optarg)) <=3D 0) {
> > +				fprintf(stderr, "iterations must be > 0\n");
> > +				exit(EXIT_FAILURE);
> > +			}
> > +			break;
> > +		case 'n':
> > +			if ((nr_child =3D atoi(optarg)) <=3D 0) {
> > +				fprintf(stderr, "no of children must be > 0\n");
> > +				exit(EXIT_FAILURE);
> > +			}
> > +			break;
> > +		case 'f':
> > +			filename =3D optarg;
> > +			break;
> > +		case 'F':
> > +			pre_fill =3D 1;
> > +			break;
> > +		case 'p':
> > +			pre_alloc =3D 1;
> > +			break;
> > +		case 'r':
> > +			flag_rd |=3D O_DIRECT;
> > +			break;
> > +		case 'w':
> > +			flag_wr |=3D O_DIRECT;
> > +			break;
> > +		case 't':
> > +			do_trunc =3D 1;
> > +			break;
> > +		case 'o':
> > +			if ((offset =3D atol(optarg)) < 0) {
> > +				fprintf(stderr, "offset must be >=3D 0\n");
> > +				exit(EXIT_FAILURE);
> > +			}
> > +			break;
> > +		case 'v':
> > +			verbose =3D 1;
> > +			break;
> > +		case 'h':	/* fall through */
> > +		default:
> > +			usage(argv[0]);
> > +		}
> > +	}
> > +
> > +	if (filename =3D=3D NULL)
> > +		usage(argv[0]);
> > +	if (pre_fill && pre_alloc) {
> > +		fprintf(stderr, "Error: -F and -p are both specified\n");
> > +		exit(EXIT_FAILURE);
> > +	}
> > +
> > +	pids =3D malloc(nr_child * sizeof(pid_t));
> > +	if (!pids) {
> > +		fprintf(stderr, "failed to malloc memory for pids\n");
> > +		exit(EXIT_FAILURE);
> > +	}
> > +	memset(pids, 0, nr_child * sizeof(pid_t));
> > +
> > +	/* create & truncate testfile first */
> > +	fd =3D open(filename, O_CREAT | O_TRUNC | O_RDWR, 0600);
> > +	if (fd < 0) {
> > +		perror("create & truncate testfile");
> > +		free(pids);
> > +		exit(EXIT_FAILURE);
> > +	}
> > +	if (do_trunc && (ftruncate(fd, blksz * nr_child) < 0)) {
> > +		perror("ftruncate failed");
> > +		free(pids);
> > +		exit(EXIT_FAILURE);
> > +	}
> > +	if (pre_fill) {
> > +		char *buf;
> > +		buf =3D malloc(blksz * nr_child);
> > +		memset(buf, 's', blksz * nr_child);
> > +		write(fd, buf, blksz * nr_child);
> > +		free(buf);
> > +	}
> > +	if (pre_alloc) {
> > +		fallocate(fd, 0, 0, blksz * nr_child);
> > +	}
> > +	close(fd);
> > +	sync();
>=20
> Is sync() really necessary here? I'd expect fsync(fd) to be sufficient.

Sure, will fix.

>=20
> > +
> > +	/* fork workers */
> > +	for (i =3D 0; i < nr_child; i++) {
> > +		pid =3D fork();
> > +		if (pid < 0) {
> > +			perror("fork");
> > +			kill_children(pids, nr_child);
> > +			free(pids);
> > +			exit(EXIT_FAILURE);
> > +		} else if (pid =3D=3D 0) {
>=20
> 			/* never returns */

OK.

>=20
> > +			run_test(filename, i, blksz, offset, nr_iter,
> > +				 flag_rd, flag_wr);
> > +		} else {
> > +			*(pids + i) =3D pid;
>=20
> How about:		pids[i] =3D pid;

Will fix.

>=20
> > +		}
> > +	}
> > +
> > +	ret =3D wait_children(pids, nr_child);
> > +	free(pids);
> > +	exit(ret);
> > +}
> > diff --git a/tests/generic/418 b/tests/generic/418
> > new file mode 100755
> > index 0000000..2d56cf0
> > --- /dev/null
> > +++ b/tests/generic/418
> > @@ -0,0 +1,122 @@
> > +#! /bin/bash
> > +# FS QA Test 418
> > +#
> > +# Test pagecache invalidation in buffer/direct write/read combination.
> > +#
> > +# Fork N children, each child writes to and reads from its own region =
of the
> > +# same test file, and check if what it reads is what it writes. The te=
st region
> > +# is determined by N * blksz. Write and read operation can be either d=
irect or
> > +# buffered.
> > +#
> > +# Regression test for commit c771c14baa33 ("iomap: invalidate page cac=
hes
> > +# should be after iomap_dio_complete() in direct write")
> > +#
> > +#---------------------------------------------------------------------=
--
> > +# Copyright (c) 2017 Red Hat Inc.  All Rights Reserved.
> > +#
> > +# This program is free software; you can redistribute it and/or
> > +# modify it under the terms of the GNU General Public License as
> > +# published by the Free Software Foundation.
> > +#
> > +# This program is distributed in the hope that it would be useful,
> > +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> > +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > +# GNU General Public License for more details.
> > +#
> > +# You should have received a copy of the GNU General Public License
> > +# along with this program; if not, write the Free Software Foundation,
> > +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> > +#---------------------------------------------------------------------=
--
> > +#
> > +
> > +seq=3D`basename $0`
> > +seqres=3D$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=3D`pwd`
> > +tmp=3D/tmp/$$
> > +status=3D1	# failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +_cleanup()
> > +{
> > +	cd /
> > +	rm -f $tmp.*
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +
> > +# remove previous $seqres.full before test
> > +rm -f $seqres.full
> > +
> > +# real QA test starts here
> > +_supported_fs generic
> > +_supported_os Linux
> > +_require_test
> > +_require_odirect
> > +_require_block_device $TEST_DEV
> > +_require_test_program "dio-invalidate-cache"
> > +_require_test_program "feature"
> > +
> > +diotest=3D$here/src/dio-invalidate-cache
> > +testfile=3D$TEST_DIR/$seq-diotest
> > +sectorsize=3D`blockdev --getss $TEST_DEV`
> > +pagesize=3D`src/feature -s`
> > +
> > +# test case array, test different write/read combinations
> > +# -r: use direct read
> > +# -w: use direct write
> > +# -t: truncate file to final size before test, i.e. write to hole
> > +# -p: fallocate whole file before test, i.e. write to allocated but un=
written extents
> > +# -F: fulfill whole file before test, i.e. write to alloated & written=
 extents
>=20
> Typo:						       allocated

Will fix.

Thanks a lot for the review! I'll probably send v2 tomorrow.

Thanks,
Eryu

>=20
> Brian
>=20
> > +t_cases=3D(
> > +	"-w"
> > +	"-wt"
> > +	"-wp"
> > +	"-wF"
> > +	"-r"
> > +	"-rt"
> > +	"-rp"
> > +	"-rF"
> > +	"-rw"
> > +	"-rwt"
> > +	"-rwp"
> > +	"-rwF"
> > +)
> > +
> > +runtest()
> > +{
> > +	local i=3D0
> > +	local tc=3D""
> > +	local loop=3D$1
> > +	shift
> > +
> > +	for tc in ${t_cases[*]}; do
> > +		echo "diotest $tc $*" >> $seqres.full
> > +		i=3D0
> > +		while [ $i -lt $loop ]; do
> > +			$diotest $tc $* -f $testfile
> > +			if [ $? -ne 0 ]; then
> > +				echo "diotest $tc $* failed at loop $i" | \
> > +					tee -a $seqres.full
> > +				break
> > +			fi
> > +			let i=3Di+1
> > +		done
> > +	done
> > +}
> > +
> > +while [ $sectorsize -le $((pagesize * 2)) ]; do
> > +	# reproducer for the original bug
> > +	runtest $((10 * LOAD_FACTOR)) -b $sectorsize -n 3 -i 1
> > +	# try more processes and iterations
> > +	runtest $((5 * LOAD_FACTOR))  -b $sectorsize -n 8 -i 4
> > +	sectorsize=3D$((sectorsize * 2))
> > +done
> > +echo "Silence is golden"
> > +
> > +# success, all done
> > +status=3D0
> > +exit
> > diff --git a/tests/generic/418.out b/tests/generic/418.out
> > new file mode 100644
> > index 0000000..954de31
> > --- /dev/null
> > +++ b/tests/generic/418.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 418
> > +Silence is golden
> > diff --git a/tests/generic/group b/tests/generic/group
> > index f0096bb..0a272b7 100644
> > --- a/tests/generic/group
> > +++ b/tests/generic/group
> > @@ -420,3 +420,4 @@
> >  415 auto clone
> >  416 auto enospc
> >  417 auto quick shutdown log
> > +418 auto rw
> > --=20
> > 2.9.3
> >=20
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=3Dht=
tp-3A__vger.kernel.org_majordomo-2Dinfo.html&d=3DDwIBAg&c=3DRoP1YumCXCgaWHv=
lZYR8PQcxBKCX5YTpkKY057SbK10&r=3D-yMrTV4jriXR7ieyzzjV-QgHBD0UDw8ixoR77aMeAH=
E&m=3D9kR41WV_x3eKPz68VfO3UzuOXC5G73l6h-geghyIqB0&s=3Dft8gm2NuVZBLFlmRG8fTw=
bhzoF9UHj4nSynJOz8DSxA&e=3D=20
--
To unsubscribe from this list: send the line "unsubscribe fstests" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3=
A__vger.kernel.org_majordomo-2Dinfo.html&d=3DDwIBAg&c=3DRoP1YumCXCgaWHvlZYR=
8PQcxBKCX5YTpkKY057SbK10&r=3D-yMrTV4jriXR7ieyzzjV-QgHBD0UDw8ixoR77aMeAHE&m=
=3D9kR41WV_x3eKPz68VfO3UzuOXC5G73l6h-geghyIqB0&s=3Dft8gm2NuVZBLFlmRG8fTwbhz=
oF9UHj4nSynJOz8DSxA&e=3D=20

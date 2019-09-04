Received: from mga18.intel.com ([134.134.136.126]:30653 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731829AbfIDQwI (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 4 Sep 2019 12:52:08 -0400
From: "Weiny, Ira" <ira.weiny@intel.com>
Subject: RE: [PATCH v2] generic: Add a test for basic F_SETLEASE
 functionality
Date: Wed, 4 Sep 2019 16:52:05 +0000
Message-ID: <2807E5FD2F6FDA4886F6618EAC48510E898E7BD9@CRSMSX101.amr.corp.intel.com>
References: <20190827123537.18794-1-jlayton@kernel.org>
 <20190904124849.15816-1-jlayton@kernel.org>
In-Reply-To: <20190904124849.15816-1-jlayton@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>, "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Cc: "bfields@fieldses.org" <bfields@fieldses.org>, "amir73il@gmail.com" <amir73il@gmail.com>
List-ID: <fstests@vger.kernel.org>

> Subject: [PATCH v2] generic: Add a test for basic F_SETLEASE functionality
> 
> Add a new test that verifies that F_SETLEASE works as expected. The parent
> opens a file and sets a lease on it and then forks. The child then does a
> (possibly) conflicting open. We then verify that we get signals as expected.

Jeff, does this mean you would rather go with this test vs the one I submitted?

https://www.spinics.net/lists/fstests/msg12449.html

Ira

> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  .gitignore            |   1 +
>  src/Makefile          |   2 +-
>  src/t_setlease.c      | 165
> ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/566     |  51 +++++++++++++
>  tests/generic/566.out |   2 +
>  tests/generic/group   |   1 +
>  6 files changed, 221 insertions(+), 1 deletion(-)  create mode 100644
> src/t_setlease.c  create mode 100755 tests/generic/566  create mode 100644
> tests/generic/566.out
> 
> v2: address Eryu's comments
> 
> diff --git a/.gitignore b/.gitignore
> index c8c815f91dd5..cc4c4c26ab98 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -141,6 +141,7 @@
>  /src/t_readdir_1
>  /src/t_readdir_2
>  /src/t_rename_overwrite
> +/src/t_setlease
>  /src/t_stripealign
>  /src/t_truncate_cmtime
>  /src/t_truncate_self
> diff --git a/src/Makefile b/src/Makefile index c4fcf370431f..11190afa3603
> 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -28,7 +28,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize
> preallo_rw_pattern_reader \
>  	attr-list-by-handle-cursor-test listxattr dio-interleaved t_dir_type \
>  	dio-invalidate-cache stat_test t_encrypted_d_revalidate \
>  	attr_replace_test swapon mkswap t_attr_corruption
> t_open_tmpfiles \
> -	fscrypt-crypt-util bulkstat_null_ocount
> +	fscrypt-crypt-util bulkstat_null_ocount t_setlease
> 
>  SUBDIRS = log-writes perf
> 
> diff --git a/src/t_setlease.c b/src/t_setlease.c new file mode 100644 index
> 000000000000..030ffaf454df
> --- /dev/null
> +++ b/src/t_setlease.c
> @@ -0,0 +1,165 @@
> +/*
> + * t_setlease.c: test basic F_SETLEASE functionality
> + *
> + * Open file, set lease on it. Then fork off children that open the
> +file with
> + * different openflags. Ensure we get signals as expected.
> + *
> + * Copyright (c) 2019: Jeff Layton <jlayton@redhat.com>  */ #include
> +<sys/types.h> #include <sys/stat.h> #include <errno.h> #include
> +<fcntl.h> #include <stdlib.h> #include <stdio.h> #include <unistd.h>
> +#include <stdbool.h> #include <signal.h> #include <sys/wait.h>
> +
> +#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> +
> +static volatile bool signalled;
> +
> +struct leasetest {
> +	int	openflags;
> +	int	leasetype;
> +	int	conf_openflags;
> +	bool	expect_signal;
> +};
> +
> +static struct leasetest testcase[] = {
> +	{ O_RDONLY, F_RDLCK, O_RDONLY, false },
> +	{ O_RDONLY, F_RDLCK, O_WRONLY, true },
> +	{ O_WRONLY, F_WRLCK, O_RDONLY, true },
> +	{ O_WRONLY, F_WRLCK, O_WRONLY, true }, };
> +
> +static void usage()
> +{
> +	printf("Usage: t_setlease <filename>\n"); }
> +
> +static void lease_break(int signum)
> +{
> +	if (signum == SIGIO)
> +		signalled = true;
> +}
> +
> +/* Open/create a file, set up signal handler and set lease on file. */
> +static int setlease(const char *fname, int openflags, int leasetype) {
> +	int fd, ret;
> +
> +	fd = open(fname, openflags | O_CREAT, 0644);
> +	if (fd < 0) {
> +		perror("open");
> +		return -errno;
> +	}
> +
> +	ret = fcntl(fd, F_SETLEASE, leasetype);
> +	if (ret) {
> +		perror("setlease");
> +		return -errno;
> +	}
> +	return fd;
> +}
> +
> +static int open_conflict(const char *fname, int openflags) {
> +	int fd;
> +
> +	fd = open(fname, openflags);
> +	if (fd < 0) {
> +		perror("open");
> +		return -errno;
> +	}
> +	close(fd);
> +	return 0;
> +}
> +
> +static int simple_lease_break(const char *fname, struct leasetest
> +*test) {
> +	int fd, ret, status;
> +	pid_t pid, exited;
> +
> +	signalled = false;
> +	fd = setlease(fname, test->openflags, test->leasetype);
> +	if (fd < 0)
> +		return fd;
> +
> +	pid = fork();
> +	if (pid < 0) {
> +		return -errno;
> +	} else if (pid == 0) {
> +		/* child */
> +		close(fd);
> +		ret = open_conflict(fname, test->conf_openflags);
> +		exit(ret ? 1 : 0);
> +	}
> +
> +	/* parent */
> +	while (!signalled) {
> +		/* Break out if child exited */
> +		exited = waitpid(pid, &status, WNOHANG);
> +		if (exited)
> +			break;
> +		usleep(1000);
> +	}
> +
> +	ret = fcntl(fd, F_SETLEASE, F_UNLCK);
> +	if (ret) {
> +		perror("F_UNLCK");
> +		return ret;
> +	}
> +
> +	close(fd);
> +
> +	/* If it didn't already exit, then wait now */
> +	if (!exited)
> +		waitpid(pid, &status, 0);
> +
> +	if (!WIFEXITED(status)) {
> +		ret = 1;
> +	} else {
> +		ret = WEXITSTATUS(status);
> +		if (test->expect_signal != signalled)
> +			ret = 1;
> +	}
> +
> +	return ret;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int ret, i;
> +	char *fname;
> +	struct sigaction sa = { .sa_handler = lease_break };
> +
> +	if (argc < 2) {
> +		usage();
> +		return 1;
> +	}
> +
> +	fname = argv[1];
> +
> +	ret = sigaction(SIGIO, &sa, NULL);
> +	if (ret) {
> +		perror("sigaction");
> +		return -1;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(testcase); ++i) {
> +		struct leasetest *t = &testcase[i];
> +
> +		ret = simple_lease_break(fname, t);
> +		if (ret) {
> +			fprintf(stderr,
> +				"Test failure: openflags=%d leasetype=%d
> conf_openflags=%d expect_signal=%d\n",
> +				t->openflags, t->leasetype, t-
> >conf_openflags,
> +				t->expect_signal);
> +			exit(1);
> +		}
> +	}
> +	return 0;
> +}
> diff --git a/tests/generic/566 b/tests/generic/566 new file mode 100755
> index 000000000000..f08cea833681
> --- /dev/null
> +++ b/tests/generic/566
> @@ -0,0 +1,51 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2019 Jeff Layton.  All Rights Reserved.
> +#
> +# FS QA Test 566
> +#
> +# Test basic F_SETLEASE functionality. Call the t_setlease program
> +which # opens a file and sets a lease on it, and then forks a child to
> +open the # same file with various openflags and verify that we get signals as
> expected.
> +#
> +# Note that kernels that lack 387e3746d01c (locks: eliminate false
> +positive # conflicts for write lease) will fail this test as tasks that
> +have the file # open for write are unable to get a F_WRLCK lease.
> +#
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
> +# get standard environment, filters and checks . ./common/rc .
> +./common/filter
> +
> +# remove previous $seqres.full before test rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_supported_os Linux
> +_require_test
> +_require_test_program t_setlease
> +
> +testfile=$TEST_DIR/t_setlease-testfile
> +$here/src/t_setlease $testfile
> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/generic/566.out b/tests/generic/566.out new file mode
> 100644 index 000000000000..31df95af2378
> --- /dev/null
> +++ b/tests/generic/566.out
> @@ -0,0 +1,2 @@
> +QA output created by 566
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group index
> 2e4a6f79276b..57f85f619f3b 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -568,3 +568,4 @@
>  563 auto quick
>  564 auto quick copy_range
>  565 auto quick copy_range
> +566 auto quick locks
> --
> 2.21.0

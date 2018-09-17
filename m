Received: from mail-pf1-f194.google.com ([209.85.210.194]:35454 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbeIQLBo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 17 Sep 2018 07:01:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id p12-v6so7006665pfh.2
        for <fstests@vger.kernel.org>; Sun, 16 Sep 2018 22:35:57 -0700 (PDT)
Date: Mon, 17 Sep 2018 13:35:49 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] generic: Test whether xattrs work on unlinked files
Message-ID: <20180917053549.GB17817@desktop>
References: <20180916215011.31029-1-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180916215011.31029-1-richard@nod.at>
Sender: fstests-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: fstests@vger.kernel.org, koen.vandeputte@ncentric.com
List-ID: <fstests@vger.kernel.org>

On Sun, Sep 16, 2018 at 11:50:11PM +0200, Richard Weinberger wrote:
> On UBIFS we had an embarrassing bug where xattr operations
> worked only for files with nlink > 0.
> Make sure this will never happen again.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
> Hi!
> 
> I'm not sure whether this is worth a new test, maybe we can add it
> to an existing test? What about generic/020?

Like Amir mentioned, we usually don't add new tests to existing cases. A
new test is totally fine and recommended.

> Since xfs_io does not support xattrs, we need a new C test helper.

Looks like you only need to create an open-but-unlinked file? Maybe you
could take a look at src/multi_open_unlinked.c and its usage and see if
it meets your need.

> 
> Thanks,
> //richard
> ---
>  src/Makefile             |  2 +-
>  src/attr_unlinked_test.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++

If a new C helper is still needed, please don't forget add an entry for
it in .gitignore.

>  tests/generic/505        | 46 +++++++++++++++++++++++++++++++++++++++++
>  tests/generic/505.out    |  2 ++
>  tests/generic/group      |  1 +
>  5 files changed, 103 insertions(+), 1 deletion(-)
>  create mode 100644 src/attr_unlinked_test.c
>  create mode 100755 tests/generic/505
>  create mode 100644 tests/generic/505.out
> 
> diff --git a/src/Makefile b/src/Makefile
> index 41826585..433fa517 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -27,7 +27,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>  	renameat2 t_getcwd e4compact test-nextquota punch-alternating \
>  	attr-list-by-handle-cursor-test listxattr dio-interleaved t_dir_type \
>  	dio-invalidate-cache stat_test t_encrypted_d_revalidate \
> -	attr_replace_test swapon mkswap
> +	attr_replace_test swapon mkswap attr_unlinked_test
>  
>  SUBDIRS = log-writes perf
>  
> diff --git a/src/attr_unlinked_test.c b/src/attr_unlinked_test.c
> new file mode 100644
> index 00000000..f3ce6d84
> --- /dev/null
> +++ b/src/attr_unlinked_test.c
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Test whether xattr operations work on unlinked files.
> + * based on attr_replace_test.c
> + */
> +#include <stdio.h>
> +#include <string.h>
> +#include <fcntl.h>
> +#include <errno.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <sys/types.h>
> +#include <sys/xattr.h>
> +#include <sys/stat.h>
> +
> +#define die() do { perror(""); \
> +fprintf(stderr, "error at line %d\n", __LINE__); \
> +exit(1); } while (0)
> +
> +#define fail(...) do { \
> +fprintf(stderr, __VA_ARGS__); exit (1); \
> +} while (0)
> +
> +int main(int argc, char *argv[])
> +{
> +	int ret;
> +	int fd;
> +	char *name = "user.world";
> +	char value[] = "hello";
> +
> +	if (argc != 2)
> +		fail("Usage: %s <file>\n", argv[0]);
> +
> +	fd = open(argv[1], O_RDWR | O_DIRECTORY | O_TMPFILE, S_IRUSR | S_IWUSR);
> +	if (fd < 0)
> +		die();
> +
> +	ret = fsetxattr(fd, name, value, sizeof(value), XATTR_CREATE);
> +	if (ret < 0)
> +		die();
> +
> +	ret = fsetxattr(fd, name, value, sizeof(value), XATTR_REPLACE);
> +	if (ret < 0)
> +		die();
> +
> +	ret = fsetxattr(fd, name, NULL, 0, 0);
> +	if (ret < 0)
> +		die();
> +
> +	close(fd);
> +
> +	return 0;
> +}
> diff --git a/tests/generic/505 b/tests/generic/505
> new file mode 100755
> index 00000000..6e8bb512
> --- /dev/null
> +++ b/tests/generic/505
> @@ -0,0 +1,46 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. 505
> +#
> +# Ensure that xattr operations work also on unlinked files.
> +# UBIFS wrongly assumed that xattr operations are only valid for nlink > 0.
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15

Please use "./new generic" to generate new test template (and don't
remove the pre-defined variables if you did :-)), it also has "here" and
"tmp" defined. (Even if your test doesn't take use of the variables, but
the common helper functions do).

> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $testfile
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/attr
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +_supported_fs generic
> +_supported_os Linux
> +_require_test_program "attr_unlinked_test"
> +_require_attrs
> +_require_scratch

Seems like test could be done directly on TEST_DEV/TEST_DIR.

Thanks,
Eryu

> +
> +rm -f $seqres.full
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount >>$seqres.full 2>&1
> +
> +./src/attr_unlinked_test $SCRATCH_MNT/
> +
> +echo "Silence is golden"
> +
> +status=0
> +exit
> diff --git a/tests/generic/505.out b/tests/generic/505.out
> new file mode 100644
> index 00000000..80e3bd1d
> --- /dev/null
> +++ b/tests/generic/505.out
> @@ -0,0 +1,2 @@
> +QA output created by 505
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index 55155de8..75770f7a 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -507,3 +507,4 @@
>  502 auto quick log
>  503 auto quick dax punch collapse zero
>  504 auto quick locks
> +505 auto quick attr
> -- 
> 2.11.0
> 

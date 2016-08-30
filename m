Received: from mx1.redhat.com ([209.132.183.28]:60746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750793AbcH3EfT (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 30 Aug 2016 00:35:19 -0400
Date: Tue, 30 Aug 2016 12:35:16 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v3] Add a test for listxattr syscall with different
 buffer sizes.
Message-ID: <20160830043516.GK27776@eguan.usersys.redhat.com>
References: <20160826051819.GQ22388@dastard>
 <1472211074-26464-1-git-send-email-asavkov@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1472211074-26464-1-git-send-email-asavkov@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Artem Savkov <asavkov@redhat.com>
Cc: fstests@vger.kernel.org, Dave Chinner <david@fromorbit.com>, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

On Fri, Aug 26, 2016 at 01:31:14PM +0200, Artem Savkov wrote:
> Add generic/375 test that calls listxattr syscall with different buffer size
> arguments checking if it fails properly.
> 
> Signed-off-by: Artem Savkov <asavkov@redhat.com>
> ---
>  .gitignore            |  1 +
>  src/Makefile          |  2 +-
>  src/listxattr.c       | 73 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/375     | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/375.out | 11 +++++++
>  tests/generic/group   |  1 +
>  6 files changed, 174 insertions(+), 1 deletion(-)
>  create mode 100644 src/listxattr.c
>  create mode 100755 tests/generic/375
>  create mode 100644 tests/generic/375.out
> 
> diff --git a/.gitignore b/.gitignore
> index d84f385..915d2d8 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -66,6 +66,7 @@
>  /src/holes
>  /src/holetest
>  /src/itrash
> +/src/listxattr
>  /src/locktest
>  /src/loggen
>  /src/looptest
> diff --git a/src/Makefile b/src/Makefile
> index 57b0df1..dd51216 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -21,7 +21,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>  	stale_handle pwrite_mmap_blocked t_dir_offset2 seek_sanity_test \
>  	seek_copy_test t_readdir_1 t_readdir_2 fsync-tester nsexec cloner \
>  	renameat2 t_getcwd e4compact test-nextquota punch-alternating \
> -	attr-list-by-handle-cursor-test
> +	attr-list-by-handle-cursor-test listxattr
>  
>  SUBDIRS =
>  
> diff --git a/src/listxattr.c b/src/listxattr.c
> new file mode 100644
> index 0000000..da9d163
> --- /dev/null
> +++ b/src/listxattr.c
> @@ -0,0 +1,73 @@
> +/*
> + * Copyright (c) 2016 Artem Savkov <asavkov@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation, either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/types.h>
> +#include <sys/xattr.h>
> +
> +int main(int argc, char **argv)
> +{
> +        int ret;
> +        size_t bufsize = 0;
> +        char *buf = NULL;
> +
> +        if (argc < 2) {
> +                fprintf(stderr, "usage: %s <testfile> [bufsize]\n", argv[0]);
> +                return 1;
> +        };
> +
> +        if (argc > 2) {
> +                bufsize = strtoul(argv[2], NULL, 10);
> +                if (bufsize == -1) {
> +                        perror("buffsize");
> +                        return 1;
> +                }
> +        }
> +
> +        if (bufsize == 0) {
> +                bufsize = listxattr(argv[1], NULL, 0);
> +                if (bufsize == -1) {
> +                        perror("listxattr");
> +                        return 1;
> +                }
> +        }
> +
> +        buf = malloc(bufsize);
> +        if (buf == NULL) {
> +                perror("buf alloc");
> +                return 1;
> +        }
> +
> +        ret = listxattr(argv[1], buf, bufsize);
> +        if (ret < 0) {
> +                perror("listxattr");
> +        } else {
> +                char *l;
> +                for (l = buf; l != (buf + bufsize) && *l != '\0';
> +                                l = strchr(l, '\0') + 1) {
> +                        printf("xattr: %s\n", l);
> +                }
> +        }
> +
> +        free(buf);
> +
> +        return 0;
> +}
> diff --git a/tests/generic/375 b/tests/generic/375
> new file mode 100755
> index 0000000..8651c7d
> --- /dev/null
> +++ b/tests/generic/375
> @@ -0,0 +1,87 @@
> +#! /bin/bash
> +# FSQA Test No. 375
> +#
> +# Test listxattr syscall behaviour with different buffer sizes.
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2016 Artem Savkov <asavkov@redhat.com>
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation, either version 2 of
> +# the License, or (at your option) any later version.
> +#
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, see <http://www.gnu.org/licenses/>.
> +#-----------------------------------------------------------------------
> +#
> +
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
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
> +. ./common/attr
> +
> +# real QA test starts here
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch
> +_require_attrs
> +_require_test_program "listxattr"
> +
> +listxattr="$here/src/listxattr"
> +
> +rm -f $seqres.full
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount
> +
> +# Create a testfile with three xattrs such that the sum of namelengths of the
> +# first two is bigger than the namelength of the third. This is needed for
> +# the 5th testcase that tests one of the cornercases.
> +testfile=${SCRATCH_MNT}/testfile
> +touch $testfile
> +$SETFATTR_PROG -n user.foo -v bar $testfile
> +$SETFATTR_PROG -n user.ping -v pong $testfile
> +$SETFATTR_PROG -n user.hello -v there $testfile
> +
> +# 1. Call listxattr without buffer length argument. This should succeed.
> +$listxattr $testfile

This fails for me on btrfs as:
[root@dhcp-66-86-11 xfstests]# diff -u tests/generic/375.out /root/workspace/xfstests/results//btrfs/generic/375.out.bad
--- tests/generic/375.out       2016-08-30 12:23:06.827000000 +0800
+++ /root/workspace/xfstests/results//btrfs/generic/375.out.bad 2016-08-30 12:28:48.392000000 +0800
@@ -1,11 +1,11 @@
 QA output created by 375
-xattr: user.foo
 xattr: user.ping
 xattr: user.hello
+xattr: user.foo
 listxattr: No such file or directory
 listxattr: Numerical result out of range
 listxattr: Numerical result out of range
 listxattr: Numerical result out of range
-xattr: user.foo
 xattr: user.ping
 xattr: user.hello
+xattr: user.foo

Seems btrfs returns xattrs in a different order, perhaps you need to
sort the results in the test?

> +
> +# 2. Calling listxattr on nonexistant file should fail with -ENOENT.
> +$listxattr ""
> +
> +# 3. Calling listxattr with buffersize not suffecient for even one xattr
> +# should fail with -ERANGE.
> +$listxattr $testfile 1
> +
> +# 4. Calling listxattr with buffersize suffecient for one xattr, but not
> +# sufficient for the whole list should still fail with -ERANGE.
> +$listxattr $testfile 9
> +
> +# 5. Calling listxattr with buffersize suffecient for the last xattr, but not
> +# sufficient for the sum of first two. Should fail with -ERANGE.
> +$listxattr $testfile 11
> +
> +# 6. Calling listxattr with buffersize bigger than needed should succeed.
> +$listxattr $testfile 500
> +
> +status=0
> +exit
> diff --git a/tests/generic/375.out b/tests/generic/375.out
> new file mode 100644
> index 0000000..0d45622
> --- /dev/null
> +++ b/tests/generic/375.out
> @@ -0,0 +1,11 @@
> +QA output created by 375
> +xattr: user.foo
> +xattr: user.ping
> +xattr: user.hello
> +listxattr: No such file or directory
> +listxattr: Numerical result out of range
> +listxattr: Numerical result out of range
> +listxattr: Numerical result out of range
> +xattr: user.foo
> +xattr: user.ping
> +xattr: user.hello
> diff --git a/tests/generic/group b/tests/generic/group
> index ef38c35..3068510 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -377,3 +377,4 @@
>  372 auto quick clone
>  373 auto quick clone
>  374 auto quick clone dedupe
> +375 auto quick metadata

Add 'attr' group too?

Thanks,
Eryu

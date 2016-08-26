Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:56042 "EHLO
        ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750771AbcHZFY2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 26 Aug 2016 01:24:28 -0400
Date: Fri, 26 Aug 2016 15:18:19 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2] Add a test for listxattr syscall with different
 buffer sizes.
Message-ID: <20160826051819.GQ22388@dastard>
References: <20160825055713.GN22388@dastard>
 <1472122893-22158-1-git-send-email-asavkov@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1472122893-22158-1-git-send-email-asavkov@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Artem Savkov <asavkov@redhat.com>
Cc: fstests@vger.kernel.org, Eryu Guan <eguan@redhat.com>, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Aug 25, 2016 at 01:01:33PM +0200, Artem Savkov wrote:
> Add generic/375 test that calls listxattr syscall with different buffer size
> arguments checking if it fails properly.
> 
> Signed-off-by: Artem Savkov <asavkov@redhat.com>
> ---
>  .gitignore            |  1 +
>  src/Makefile          |  2 +-
>  src/listxattr.c       | 55 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/375     | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/375.out | 10 +++++++++
>  tests/generic/group   |  1 +
>  6 files changed, 130 insertions(+), 1 deletion(-)
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
> index 0000000..7fdccb5
> --- /dev/null
> +++ b/src/listxattr.c
> @@ -0,0 +1,55 @@

License, copyright.

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
> +  int ret;
> +  size_t bufsize = 0;
> +  char *buf = NULL;
> +
> +  if (argc < 2) {
> +    fprintf(stderr, "usage: %s <testfile> [bufsize]\n", argv[0]);
> +    return 1;
> +  };

Please use 8 space tabs for all new code in xfstests.

> +
> +  if (argc == 3) {
> +    bufsize = strtoul(argv[2], NULL, 10);
> +    if (bufsize == -1) {
> +      perror("buffsize");
> +      return 1;
> +    }
> +  }
> +
> +  if (bufsize == 0) {
> +    bufsize = listxattr(argv[1], buf, 0);
> +    if (bufsize == -1) {
> +      fprintf(stderr, "listxattr failed with %d\n", -errno);

	perror("listxattr:");

> +      return 1;
> +    }
> +  }
> +
> +  buf = malloc(bufsize + 1);
> +  if (buf == NULL) {
> +    perror("buf alloc");
> +    return 1;
> +  }
> +
> +  ret = listxattr(argv[1], buf, bufsize);
> +  if (ret < 0) {
> +    fprintf(stderr, "listxattr failed with %d\n", -errno);

	perror("listxattr:");

> +  } else {
> +    char *l;
> +    for (l = buf; l != (buf + bufsize) && *l != '\0'; l = strchr(l, '\0') + 1) {
> +      printf("xattr: %s\n", l);
> +    }
> +  }
> +
> +  free(buf);
> +
> +  return 0;
> +}
> diff --git a/tests/generic/375 b/tests/generic/375
> new file mode 100755
> index 0000000..ad7b168
> --- /dev/null
> +++ b/tests/generic/375
> @@ -0,0 +1,62 @@
> +#! /bin/bash
> +# FSQA Test No. 375
> +#
> +# Test listxattr syscall behaviour with different buffer sizes.
> +#

Why did you remove the license and copyright statement from the
template? Please add them back in when you resend.

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

_require_test_program "listxattr"

listxattr="$here/src/listxattr"

> +
> +rm -f $seqres.full
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount
> +
> +# Create a testfile with multiple xattrs.
> +TESTFILE=${SCRATCH_MNT}/testfile
> +touch $TESTFILE

testfile, not TESTFILE.

i.e. local variables use lower case, harness provided/global
variables use upper case.

> +$SETFATTR_PROG -n user.foo -v bar $TESTFILE
> +$SETFATTR_PROG -n user.ping -v pong $TESTFILE
> +$SETFATTR_PROG -n user.xxxx -v yyyy $TESTFILE

Why only 3 attributes? A small comment explaining the reason for the
initial conditions helps a lot here.

> +
> +# Call listxattr without buffer length argument. This should succeed.
> +$here/src/listxattr $TESTFILE

$listxattr $testfile

> +
> +# Calling listxattr on nonexistant file should fail with -ENOENT.
> +$here/src/listxattr ""
> +
> +# Calling listxattr with buffersize not suffecient for even one xattr should
> +# fail with -ERANGE.
> +$here/src/listxattr $TESTFILE 1
> +
> +# Calling listxattr with buffersize sufficient for one xattr, but not
> +# sufficient for the whole list should still fail with -ERANGE.
> +$here/src/listxattr $TESTFILE 9
> +
> +# Calling listxattr with buffersize not suffecient for even one xattr should
> +# fail with -ERANGE.
> +$here/src/listxattr $TESTFILE 500

Comment above this case is wrong.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

Received: from mx1.redhat.com ([209.132.183.28]:40590 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752153AbdCTGix (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 20 Mar 2017 02:38:53 -0400
Date: Mon, 20 Mar 2017 14:38:49 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/418: Add test for fallocate()
 PUNCH_HOLE|KEEP_SIZE
Message-ID: <20170320063849.GI14226@eguan.usersys.redhat.com>
References: <8044718e71d02568f3fe84fc57478e9ca99b4f1a.1489799266.git.calvinowens@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8044718e71d02568f3fe84fc57478e9ca99b4f1a.1489799266.git.calvinowens@fb.com>
Sender: fstests-owner@vger.kernel.org
To: Calvin Owens <calvinowens@fb.com>
Cc: fstests@vger.kernel.org, kernel-team@fb.com
List-ID: <fstests@vger.kernel.org>

On Fri, Mar 17, 2017 at 06:26:01PM -0700, Calvin Owens wrote:
> Verify that punching holes at ends of files does not alter st_size if we
> pass FALLOC_FL_KEEP_SIZE to fallocate().
> 
> Signed-off-by: Calvin Owens <calvinowens@fb.com>
> ---
>  tests/generic/418     | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/418.out |  3 +++
>  tests/generic/group   |  1 +
>  3 files changed, 73 insertions(+)
>  create mode 100755 tests/generic/418
>  create mode 100644 tests/generic/418.out
> 
> diff --git a/tests/generic/418 b/tests/generic/418
> new file mode 100755
> index 0000000..658c4c3
> --- /dev/null
> +++ b/tests/generic/418
> @@ -0,0 +1,69 @@
> +#! /bin/bash
> +# FS QA Test 418
> +#
> +# Verify fallocate(mode=FALLOC_FL_KEEP_SIZE|FALLOC_FL_PUNCH_HOLE) does
> +# not alter the file size.
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2017 Calvin Owens.  All Rights Reserved.
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
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_supported_os Linux
> +_require_test
> +
> +testfile="${TEST_DIR}/testfile"
> +
> +echo "Testing fallocate(mode=FALLOC_FL_KEEP_SIZE|FALLOC_FL_PUNCH_HOLE)"
> +dd if=/dev/urandom of=$testfile bs=2048 count=1 >/dev/null 2>/dev/null

Any reason to use /dev/urandom? I think a plain xfs_io pwrite would be
sufficient?

$XFS_IO_PROG -fc "pwrite -b 2048 0 2048" $testfile

> +
> +# FIXME: A bug in xfs_io prevents multiple flags in mode from being set at once,
> +# use the standard command to test this until that is fixed.
> +
> +#$XFS_IO_PROG -c "falloc -k -p 2048 2048" $testfile
> +fallocate -n -p -l 2048 -o 2048 $testfile

Seems fpunch command from xfs_io already sets KEEP_SIZE flag, a strace
run of "xfs_io -c 'fpunch 0 4m' file" shows flag is 03:

fallocate(3, 03, 0, 4194304)            = 0

And the flag definitions:
#define FALLOC_FL_KEEP_SIZE     0x01 /* default is extend size */                                                                                                                              
#define FALLOC_FL_PUNCH_HOLE    0x02 /* de-allocates range */

I also tested fpunch command and it could reproduce the failure on XFS too.

> +
> +$XFS_IO_PROG -c "stat" $testfile 2>/dev/null | grep -F 'stat.size'
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/418.out b/tests/generic/418.out
> new file mode 100644
> index 0000000..9927731
> --- /dev/null
> +++ b/tests/generic/418.out
> @@ -0,0 +1,3 @@
> +QA output created by 418
> +Testing fallocate(mode=FALLOC_FL_KEEP_SIZE|FALLOC_FL_PUNCH_HOLE)
> +stat.size = 2048
> diff --git a/tests/generic/group b/tests/generic/group
> index f0096bb..a2368ae 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -420,3 +420,4 @@
>  415 auto clone
>  416 auto enospc
>  417 auto quick shutdown log
> +418 auto quick

We can add it to 'punch' group too.

Thanks,
Eryu

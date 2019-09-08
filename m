Received: from mail-pf1-f195.google.com ([209.85.210.195]:43285 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728770AbfIHMj7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 8 Sep 2019 08:39:59 -0400
Date: Sun, 8 Sep 2019 20:39:39 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] xfs: test the deadlock between the AGI and AGF with
 RENAME_WHITEOUT
Message-ID: <20190908123939.GG2622@desktop>
References: <59006cf8-f825-d33f-c860-111189689e2e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59006cf8-f825-d33f-c860-111189689e2e@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: kaixuxia <xiakaixu1987@gmail.com>
Cc: fstests@vger.kernel.org, linux-xfs@vger.kernel.org, "Darrick J. Wong" <darrick.wong@oracle.com>, newtongao@tencent.com, jasperwang@tencent.com
List-ID: <fstests@vger.kernel.org>

On Wed, Sep 04, 2019 at 06:01:27PM +0800, kaixuxia wrote:
> There is ABBA deadlock bug between the AGI and AGF when performing
> rename() with RENAME_WHITEOUT flag, and add this testcase to make
> sure the rename() call works well.
> 
> Signed-off-by: kaixuxia <kaixuxia@tencent.com>
> ---
>  tests/xfs/512     | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/512.out |   2 ++
>  tests/xfs/group   |   1 +
>  3 files changed, 103 insertions(+)
>  create mode 100755 tests/xfs/512
>  create mode 100644 tests/xfs/512.out
> 
> diff --git a/tests/xfs/512 b/tests/xfs/512
> new file mode 100755
> index 0000000..0e95fb7
> --- /dev/null
> +++ b/tests/xfs/512
> @@ -0,0 +1,100 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2019 Tencent.  All Rights Reserved.
> +#
> +# FS QA Test 512
> +#
> +# Test the ABBA deadlock case between the AGI and AGF When performing
> +# rename operation with RENAME_WHITEOUT flag.
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
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +_supported_fs xfs
> +_supported_os Linux
> +_require_scratch

Only _require_scratch_nocheck is suffiecient.

> +
> +# Single AG will cause default xfs_repair to fail. This test need a
> +# single AG fs, so ignore the check.
> +_require_scratch_nocheck

Also need to 

. ./common/rename
...

_requires_renameat2

Also, this test requires RENAME_WHITEOUT, I'd suggest enhance
src/renameat2.c to support check for if a given rename flag is supported
by kernel, and refactor the checks in generic/02[45] and generic/078
into _requires_renameat2 to use the new functionality. e.g.

# without option, behavior stays unchanged, check for renameat2 syscall
# support
_requires_renameat2

# check if renameat2 upports RENAME_WHITEOUT flag
_requires_renameat2 whiteout

# check if renameat2 upports RENAME_EXCHANGE flag
_requires_renameat2 exchange

> +
> +prepare_file()
> +{
> +	# create many small files for the rename with RENAME_WHITEOUT
> +	i=0
> +	while [ $i -le $files ]; do
> +		file=$SCRATCH_MNT/f$i
> +		$XFS_IO_PROG -f -d -c 'pwrite -b 4k 0 4k' $file >/dev/null 2>&1
> +		let i=$i+1

Creating 250000 4k files take a long time. Does file content really
matters? I guess racing RENAME_WHITEOUT with file creation is enough, is
it possible to just create many empty files? e.g.

		echo > $file

this saves a lot time.

> +	done
> +}
> +
> +rename_whiteout()
> +{
> +	# create the rename targetdir
> +	renamedir=$SCRATCH_MNT/renamedir
> +	mkdir $renamedir
> +
> +	# just get a random long name...
> +	longnamepre=FFFsafdsagafsadfagasdjfalskdgakdlsglkasdg

Better to explain why long file name is required.

> +
> +	# now try to do rename with RENAME_WHITEOUT flag
> +	i=0
> +	while [ $i -le $files ]; do
> +		src/renameat2 -w $SCRATCH_MNT/f$i $renamedir/$longnamepre$i >/dev/null 2>&1
> +		let i=$i+1
> +	done
> +}
> +
> +create_file()
> +{
> +	# create the targetdir
> +	createdir=$SCRATCH_MNT/createdir
> +	mkdir $createdir
> +
> +	# try to create file at the same time to hit the deadlock
> +	i=0
> +	while [ $i -le $files ]; do
> +		file=$createdir/f$i
> +		$XFS_IO_PROG -f -d -c 'pwrite -b 4k 0 4k' $file >/dev/null 2>&1
> +		let i=$i+1
> +	done

Same here, does creating empty files work?

> +}
> +
> +_scratch_mkfs_xfs -bsize=512 -dagcount=1 >> $seqres.full 2>&1 ||

This doesn't work because crc is on by default, as crc requires minimum
1k block size. Is 512 block size really needed?

> +	_fail "mkfs failed"
> +_scratch_mount
> +
> +files=250000

If we could reduce file number to create, test could run faster as well.
Running test with less than 250000 files couldn't reproduce the
deadlock?

Thanks,
Eryu

> +
> +prepare_file
> +rename_whiteout &
> +create_file &
> +
> +wait
> +echo Silence is golden
> +
> +# Failure comes in the form of a deadlock.
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/xfs/512.out b/tests/xfs/512.out
> new file mode 100644
> index 0000000..0aabdef
> --- /dev/null
> +++ b/tests/xfs/512.out
> @@ -0,0 +1,2 @@
> +QA output created by 512
> +Silence is golden
> diff --git a/tests/xfs/group b/tests/xfs/group
> index a7ad300..ed250d6 100644
> --- a/tests/xfs/group
> +++ b/tests/xfs/group
> @@ -509,3 +509,4 @@
>  509 auto ioctl
>  510 auto ioctl quick
>  511 auto quick quota
> +512 auto rename
> -- 
> 1.8.3.1
> 
> -- 
> kaixuxia

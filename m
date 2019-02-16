Received: from mail-pg1-f196.google.com ([209.85.215.196]:42321 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbfBPKFG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 16 Feb 2019 05:05:06 -0500
Received: by mail-pg1-f196.google.com with SMTP id b2so285407pgl.9
        for <fstests@vger.kernel.org>; Sat, 16 Feb 2019 02:05:05 -0800 (PST)
Date: Sat, 16 Feb 2019 18:04:54 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] xfs: new EOF fragmentation tests
Message-ID: <20190216100454.GY2713@desktop>
References: <20190211013647.22580-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211013647.22580-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Feb 11, 2019 at 12:36:47PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> These tests create substantial file fragmentation as a result of
> application actions that defeat post-EOF preallocation
> optimisations. They are intended to replicate known vectors for
> these problems, and provide a check that the fragmentation levels
> have been controlled. The mitigations we make may not completely
> remove fragmentation (e.g. they may demonstrate speculative delalloc
> related extent size growth) so the checks don't assume we'll end up
> with perfect layouts and hence check for an exceptable level of
> fragmentation rather than none.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  tests/xfs/500     | 79 +++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/500.out |  9 +++++
>  tests/xfs/501     | 81 ++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/501.out |  9 +++++
>  tests/xfs/502     | 81 ++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/502.out |  9 +++++
>  tests/xfs/503     | 89 +++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/503.out | 33 ++++++++++++++++++
>  tests/xfs/group   |  4 +++
>  9 files changed, 394 insertions(+)
>  create mode 100755 tests/xfs/500
>  create mode 100644 tests/xfs/500.out
>  create mode 100755 tests/xfs/501
>  create mode 100644 tests/xfs/501.out
>  create mode 100755 tests/xfs/502
>  create mode 100644 tests/xfs/502.out
>  create mode 100755 tests/xfs/503
>  create mode 100644 tests/xfs/503.out
> 
> diff --git a/tests/xfs/500 b/tests/xfs/500
> new file mode 100755
> index 00000000..d0802e86
> --- /dev/null
> +++ b/tests/xfs/500
> @@ -0,0 +1,79 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2019 Red Hat, Inc.  All Rights Reserved.
> +#
> +# FS QA Test xfs/500
> +#
> +# Post-EOF preallocation defeat test

The test description of the four tests are all the same, I know there're
detailed descriptions later in each test, but it's better to write high
level descriptions here.

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
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs generic

_supported_fs xfs

The four tests all have the same issue.

> +_supported_os Linux
> +_require_scratch
> +
> +_scratch_mkfs 2>&1 >> $seqres.full
> +_scratch_mount
> +
> +# Write multiple files in parallel using synchronous buffered writes. Aim is to
> +# interleave allocations to fragment the files. Synchronous writes defeat the
> +# open/write/close heuristics in xfs_release() that prevent EOF block removal,
> +# so this should fragment badly. Typical problematic behaviour shows per-file
> +# extent counts of >900 (almost worse case) whilst fixed behaviour typically
> +# shows extent counts in the low 20s.
> +#
> +# Failure is determined by golden output mismatch from _within_tolerance().
> +
> +workfile=$SCRATCH_MNT/file
> +nfiles=8
> +wsize=4096
> +wcnt=1000
> +
> +write_sync_file()
> +{
> +	idx=$1
> +
> +	for ((cnt=0; cnt<$wcnt; cnt++)); do
> +		$XFS_IO_PROG -f -s -c "pwrite $((cnt * wsize)) $wsize" $workfile.$idx
> +	done
> +}
> +
> +rm -f $workfile*
> +for ((n=0; n<$nfiles; n++)); do
> +	write_sync_file $n > /dev/null 2>&1 &
> +done
> +wait
> +sync
> +
> +for ((n=0; n<$nfiles; n++)); do
> +	count=$(_count_extents $workfile.$n)
> +	# Acceptible extent count range is 1-40
> +	_within_tolerance "file.$n extent count" $count 21 19 -v
> +done
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/xfs/500.out b/tests/xfs/500.out
> new file mode 100644
> index 00000000..1ffc1790
> --- /dev/null
> +++ b/tests/xfs/500.out
> @@ -0,0 +1,9 @@
> +QA output created by 500
> +file.0 extent count is in range
> +file.1 extent count is in range
> +file.2 extent count is in range
> +file.3 extent count is in range
> +file.4 extent count is in range
> +file.5 extent count is in range
> +file.6 extent count is in range
> +file.7 extent count is in range
> diff --git a/tests/xfs/501 b/tests/xfs/501
> new file mode 100755
> index 00000000..493e4d77
> --- /dev/null
> +++ b/tests/xfs/501
> @@ -0,0 +1,81 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2019 Red Hat, Inc.  All Rights Reserved.
> +#
> +# FS QA Test xfs/501
> +#
> +# Post-EOF preallocation defeat test
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
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch
> +
> +_scratch_mkfs 2>&1 >> $seqres.full
> +_scratch_mount
> +
> +# Write multiple files in parallel using buffered writes with extent size hints.
> +# Aim is to interleave allocations to fragment the files. Writes w/ extent size
> +# hints set defeat the open/write/close heuristics in xfs_release() that prevent
> +# EOF block removal, so this should fragment badly. Typical problematic
> +# behaviour shows per-file extent counts of 1000 (worst case!) whilst
> +# fixed behaviour should show very few extents (almost best case).
> +#
> +# Failure is determined by golden output mismatch from _within_tolerance().
> +
> +workfile=$SCRATCH_MNT/file
> +nfiles=8
> +wsize=4096
> +wcnt=1000
> +extent_size=16m
> +
> +write_extsz_file()
> +{
> +	idx=$1
> +
> +	$XFS_IO_PROG -f -c "extsize $extent_size" $workfile.$idx
> +	for ((cnt=0; cnt<$wcnt; cnt++)); do
> +		$XFS_IO_PROG -f -c "pwrite $((cnt * wsize)) $wsize" $workfile.$idx
> +	done
> +}
> +
> +rm -f $workfile*
> +for ((n=0; n<$nfiles; n++)); do
> +	write_extsz_file $n > /dev/null 2>&1 &
> +done
> +wait
> +sync
> +
> +for ((n=0; n<$nfiles; n++)); do
> +	count=$(_count_extents $workfile.$n)
> +	# Acceptible extent count range is 1-10
> +	_within_tolerance "file.$n extent count" $count 2 1 8 -v
> +done
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/xfs/501.out b/tests/xfs/501.out
> new file mode 100644
> index 00000000..ead0b496
> --- /dev/null
> +++ b/tests/xfs/501.out
> @@ -0,0 +1,9 @@
> +QA output created by 501
> +file.0 extent count is in range
> +file.1 extent count is in range
> +file.2 extent count is in range
> +file.3 extent count is in range
> +file.4 extent count is in range
> +file.5 extent count is in range
> +file.6 extent count is in range
> +file.7 extent count is in range
> diff --git a/tests/xfs/502 b/tests/xfs/502
> new file mode 100755
> index 00000000..9f314a3d
> --- /dev/null
> +++ b/tests/xfs/502
> @@ -0,0 +1,81 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2019 Red Hat, Inc.  All Rights Reserved.
> +#
> +# FS QA Test xfs/502
> +#
> +# Post-EOF preallocation defeat test
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
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch
> +
> +_scratch_mkfs 2>&1 >> $seqres.full
> +_scratch_mount
> +
> +# Write multiple files in parallel using O_DIRECT writes w/ extent size hints.
> +# Aim is to interleave allocations to fragment the files. O_DIRECT writes defeat
> +# the open/write/close heuristics in xfs_release() that prevent EOF block
> +# removal, so this should fragment badly. Typical problematic behaviour shows
> +# per-file extent counts of ~1000 (worst case) whilst fixed behaviour typically
> +# shows extent counts in the low single digits (almost best case)
> +#
> +# Failure is determined by golden output mismatch from _within_tolerance().
> +
> +workfile=$SCRATCH_MNT/file
> +nfiles=8
> +wsize=4096
> +wcnt=1000
> +extent_size=16m
> +
> +write_direct_file()
> +{
> +	idx=$1
> +
> +	$XFS_IO_PROG -f -c "extsize $extent_size" $workfile.$idx
> +	for ((cnt=0; cnt<$wcnt; cnt++)); do
> +		$XFS_IO_PROG -f -d -c "pwrite $((cnt * wsize)) $wsize" $workfile.$idx
> +	done
> +}
> +
> +rm -f $workfile*
> +for ((n=0; n<$nfiles; n++)); do
> +	write_direct_file $n > /dev/null 2>&1 &
> +done
> +wait
> +sync
> +
> +for ((n=0; n<$nfiles; n++)); do
> +	count=$(_count_extents $workfile.$n)
> +	# Acceptible extent count range is 1-10
> +	_within_tolerance "file.$n extent count" $count 2 1 8 -v
> +done
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/xfs/502.out b/tests/xfs/502.out
> new file mode 100644
> index 00000000..766a6efe
> --- /dev/null
> +++ b/tests/xfs/502.out
> @@ -0,0 +1,9 @@
> +QA output created by 502
> +file.0 extent count is in range
> +file.1 extent count is in range
> +file.2 extent count is in range
> +file.3 extent count is in range
> +file.4 extent count is in range
> +file.5 extent count is in range
> +file.6 extent count is in range
> +file.7 extent count is in range
> diff --git a/tests/xfs/503 b/tests/xfs/503
> new file mode 100755
> index 00000000..ad303551
> --- /dev/null
> +++ b/tests/xfs/503
> @@ -0,0 +1,89 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2019 Red Hat, Inc.  All Rights Reserved.
> +#
> +# FS QA Test xfs/503
> +#
> +# Post-EOF preallocation defeat test
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
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch
> +
> +_scratch_mkfs 2>&1 >> $seqres.full
> +_scratch_mount
> +
> +# Write multiple files in parallel using synchronous buffered writes. Aim is to

This should be "using open/read/close loops" not "synchronous buffered
writes"?

Thanks,
Eryu

> +# interleave allocations to fragment the files. Assuming we've fixed the
> +# sycnhronous write defeat, we can still trigger the same issue with a
> +# open/read/close on O_RDONLY files. We should not be triggering EOF
> +# preallocation removal on files we don't have permission to write, so until
> +# this is fixed it should fragment badly.  Typical problematic behaviour shows
> +# per-file extent counts of 50-350 whilst fixed behaviour typically demonstrates
> +# post-eof speculative delalloc growth in extent size (~6 extents for 50MB
> +# file).
> +#
> +# Failure is determined by golden output mismatch from _within_tolerance().
> +
> +workfile=$SCRATCH_MNT/file
> +nfiles=32
> +wsize=4096
> +wcnt=1000
> +
> +write_file()
> +{
> +	idx=$1
> +
> +	$XFS_IO_PROG -f -s -c "pwrite -b 64k 0 50m" $workfile.$idx
> +}
> +
> +read_file()
> +{
> +	idx=$1
> +
> +	for ((cnt=0; cnt<$wcnt; cnt++)); do
> +		$XFS_IO_PROG -f -r -c "pread 0 28" $workfile.$idx
> +	done
> +}
> +
> +rm -f $workdir/file*
> +for ((n=0; n<$((nfiles)); n++)); do
> +	write_file $n > /dev/null 2>&1 &
> +	read_file $n > /dev/null 2>&1 &
> +done
> +wait
> +
> +for ((n=0; n<$nfiles; n++)); do
> +	count=$(_count_extents $workfile.$n)
> +	# Acceptible extent count range is 1-40
> +	_within_tolerance "file.$n extent count" $count 6 5 10 -v
> +done
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/xfs/503.out b/tests/xfs/503.out
> new file mode 100644
> index 00000000..0089a698
> --- /dev/null
> +++ b/tests/xfs/503.out
> @@ -0,0 +1,33 @@
> +QA output created by 503
> +file.0 extent count is in range
> +file.1 extent count is in range
> +file.2 extent count is in range
> +file.3 extent count is in range
> +file.4 extent count is in range
> +file.5 extent count is in range
> +file.6 extent count is in range
> +file.7 extent count is in range
> +file.8 extent count is in range
> +file.9 extent count is in range
> +file.10 extent count is in range
> +file.11 extent count is in range
> +file.12 extent count is in range
> +file.13 extent count is in range
> +file.14 extent count is in range
> +file.15 extent count is in range
> +file.16 extent count is in range
> +file.17 extent count is in range
> +file.18 extent count is in range
> +file.19 extent count is in range
> +file.20 extent count is in range
> +file.21 extent count is in range
> +file.22 extent count is in range
> +file.23 extent count is in range
> +file.24 extent count is in range
> +file.25 extent count is in range
> +file.26 extent count is in range
> +file.27 extent count is in range
> +file.28 extent count is in range
> +file.29 extent count is in range
> +file.30 extent count is in range
> +file.31 extent count is in range
> diff --git a/tests/xfs/group b/tests/xfs/group
> index 7b7d69f1..d0d33d73 100644
> --- a/tests/xfs/group
> +++ b/tests/xfs/group
> @@ -497,3 +497,7 @@
>  497 dangerous_fuzzers dangerous_scrub dangerous_online_repair
>  498 dangerous_fuzzers dangerous_norepair
>  499 auto quick
> +500 auto prealloc rw
> +501 auto prealloc rw
> +502 auto prealloc rw
> +503 auto prealloc rw
> -- 
> 2.20.1
> 

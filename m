Received: from mail-pf1-f196.google.com ([209.85.210.196]:44720 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfBPNzD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 16 Feb 2019 08:55:03 -0500
Received: by mail-pf1-f196.google.com with SMTP id u6so6215268pfh.11
        for <fstests@vger.kernel.org>; Sat, 16 Feb 2019 05:55:02 -0800 (PST)
Date: Sat, 16 Feb 2019 21:54:55 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] fstests/generic: cgroup aware writeback accounting test
Message-ID: <20190216135455.GA2713@desktop>
References: <20190212152203.37434-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212152203.37434-1-bfoster@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Brian Foster <bfoster@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Feb 12, 2019 at 10:22:03AM -0500, Brian Foster wrote:
> A test to perform reads/writes under various cgroups and verify that
> I/Os are accounted properly according to cgroup aware writeback.
> This is a generic test, but not all commonly used local filesystems
> support cgroup aware writeback at the moment (i.e., XFS). Therefore,
> this test currently requires ext4 or btrfs for the time being.
> 
> The common/cgroup2 file is copied from a separate cgroup related
> patch from Shaohua Li that never made it upstream.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> Signed-off-by: Shaohua Li <shli@fb.com>
> ---
> 
> This is a test I had lying around from previous cgawb on XFS discussions
> that I never got back to finishing off. This currently passes on
> ext4/btrfs, fails on upstream XFS and survives XFS with the old cgawb
> enablement patch applied.
> 
> Shaohua's patch referenced in the commit log is available here[1].
> 
> Brian
> 
> [1] https://marc.info/?l=fstests&m=152175327503759&w=2
> 
>  common/cgroup2        |  15 +++++
>  tests/generic/999     | 141 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/999.out |  14 +++++
>  tests/generic/group   |   1 +
>  4 files changed, 171 insertions(+)
>  create mode 100644 common/cgroup2
>  create mode 100755 tests/generic/999
>  create mode 100644 tests/generic/999.out
> 
> diff --git a/common/cgroup2 b/common/cgroup2
> new file mode 100644
> index 00000000..f89825e2
> --- /dev/null
> +++ b/common/cgroup2
> @@ -0,0 +1,15 @@
> +# cgroup2 specific common functions
> +
> +export CGROUP2_PATH="${CGROUP2_PATH:-/sys/fs/cgroup}"
> +
> +_require_cgroup2()
> +{
> +	if [ ! -f "${CGROUP2_PATH}/cgroup.subtree_control" ]; then
> +		_notrun "Test requires cgroup2 enabled"
> +	fi
> +	if [[ ! $(cat ${CGROUP2_PATH}/cgroup.controllers) =~ $1 ]]; then
> +		_notrun "Cgroup2 doesn't support $1 controller $1"
> +	fi
> +}
> +
> +/bin/true
> diff --git a/tests/generic/999 b/tests/generic/999
> new file mode 100755
> index 00000000..1664da60
> --- /dev/null
> +++ b/tests/generic/999
> @@ -0,0 +1,141 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2019 Red Hat, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 999
> +#
> +# This test verifies that cgroup aware writeback properly accounts I/Os in
> +# various scenarios. We perform reads/writes from different combinations of
> +# cgroups and verify that pages are accounted against the group that brought
> +# them into cache.
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
> +
> +	echo $$ > $cgdir/cgroup.procs
> +	rmdir $cgdir/$seq-cg* > /dev/null 2>&1
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/cgroup2
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs ext4 btrfs

Then this should be a 'shared' test, I renamed it to shared/011.

> +_supported_os Linux
> +_require_scratch
> +_require_cgroup2 io
> +
> +smajor=$((0x`stat -L -c %t $SCRATCH_DEV`))
> +sminor=$((0x`stat -L -c %T $SCRATCH_DEV`))
> +cgdir=$CGROUP2_PATH
> +
> +iosize=$((1024 * 1024 * 8))
> +
> +# Check cgroup read/write charges against expected values. Allow for some
> +# tolerance as different filesystems seem to account slightly differently.
> +check_cg()
> +{
> +	cgroot=$1
> +	cgname=$(basename $cgroot)
> +	expectedread=$2
> +	expectedwrite=$3
> +	rbytes=0
> +	wbytes=0
> +
> +	iobytes=`cat $cgroot/io.stat | grep $smajor:$sminor`
> +	if [ $? == 0 ]; then
> +		rbytes=`echo $iobytes | awk '{ print $2 }' | \
> +			awk -F = '{ print $2 }'`
> +		wbytes=`echo $iobytes | awk '{ print $3 }' | \
> +			awk -F = '{ print $2 }'`
> +	fi
> +
> +	_within_tolerance "read" $rbytes $expectedread 5% -v
> +	_within_tolerance "write" $wbytes $expectedwrite 5% -v
> +}
> +
> +# Move current process to another cgroup.
> +switch_cg()
> +{
> +	mkdir -p $1
> +	echo $$ > $1/cgroup.procs
> +}
> +
> +# Reset cgroup state for a new test.
> +reset()
> +{
> +	echo $$ > $cgdir/cgroup.procs
> +	rmdir $cgdir/$seq-cg* > /dev/null 2>&1
> +	$XFS_IO_PROG -fc "pwrite 0 $iosize" $SCRATCH_MNT/file \
> +		>> $seqres.full 2>&1
> +	_scratch_cycle_mount || _fail "mount failed"

_scratch_cycle_mount will call _fail too, no need to _fail explicitly
here. Otherwise looks good to me.

Thanks,
Eryu

> +	stat $SCRATCH_MNT/file > /dev/null
> +}
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount
> +
> +echo "+io" > $cgdir/cgroup.subtree_control || _fail "subtree control"
> +
> +# Read and write from a single group.
> +echo "read/write"
> +reset
> +switch_cg $cgdir/$seq-cg
> +$XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite 0 $iosize" -c fsync \
> +	$SCRATCH_MNT/file >> $seqres.full 2>&1
> +switch_cg $cgdir
> +$XFS_IO_PROG -c fsync $SCRATCH_MNT/file
> +check_cg $cgdir/$seq-cg $iosize $iosize
> +
> +# Write from one cgroup then read and write from a second. Writes are charged to
> +# the first group and nothing to the second.
> +echo "write -> read/write"
> +reset
> +switch_cg $cgdir/$seq-cg
> +$XFS_IO_PROG -c "pwrite 0 $iosize" $SCRATCH_MNT/file >> $seqres.full 2>&1
> +switch_cg $cgdir/$seq-cg-2
> +$XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite 0 $iosize" $SCRATCH_MNT/file \
> +	>> $seqres.full 2>&1
> +switch_cg $cgdir
> +$XFS_IO_PROG -c fsync $SCRATCH_MNT/file
> +check_cg $cgdir/$seq-cg 0 $iosize
> +check_cg $cgdir/$seq-cg-2 0 0
> +
> +# Read from one cgroup, read & write from a second. Both reads and writes are
> +# charged to the first group and nothing to the second.
> +echo "read -> read/write"
> +reset
> +switch_cg $cgdir/$seq-cg
> +$XFS_IO_PROG -c "pread 0 $iosize" $SCRATCH_MNT/file >> $seqres.full 2>&1
> +switch_cg $cgdir/$seq-cg-2
> +$XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite 0 $iosize" $SCRATCH_MNT/file \
> +	>> $seqres.full 2>&1
> +switch_cg $cgdir
> +$XFS_IO_PROG -c fsync $SCRATCH_MNT/file
> +check_cg $cgdir/$seq-cg $iosize $iosize
> +check_cg $cgdir/$seq-cg-2 0 0
> +
> +echo "-io" > $cgdir/cgroup.subtree_control || _fail "subtree control"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/999.out b/tests/generic/999.out
> new file mode 100644
> index 00000000..d93b7089
> --- /dev/null
> +++ b/tests/generic/999.out
> @@ -0,0 +1,14 @@
> +QA output created by 999
> +read/write
> +read is in range
> +write is in range
> +write -> read/write
> +read is in range
> +write is in range
> +read is in range
> +write is in range
> +read -> read/write
> +read is in range
> +write is in range
> +read is in range
> +write is in range
> diff --git a/tests/generic/group b/tests/generic/group
> index cfd003d3..9d7d7613 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -528,3 +528,4 @@
>  523 auto quick attr
>  524 auto quick
>  525 auto quick rw
> +999 auto quick
> -- 
> 2.17.2
> 

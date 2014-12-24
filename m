Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:12832 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750740AbaLXBxj (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 23 Dec 2014 20:53:39 -0500
Date: Wed, 24 Dec 2014 12:53:35 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfs: add test for truncate/collapse range race
Message-ID: <20141224015335.GL4521@dastard>
References: <1419060301-26830-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1419060301-26830-1-git-send-email-gux.fnst@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xing Gu <gux.fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org, guaneryu@gmail.com, lczerner@redhat.com
List-ID: <fstests@vger.kernel.org>

On Sat, Dec 20, 2014 at 03:25:01PM +0800, Xing Gu wrote:
> This case tests truncate/collapse range race. If
> the race occurs, it will trigger BUG_ON.
> 
> Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
> ---

What changed from the previous version?

...
> +rm -f $seqres.full
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount
> +
> +old_bug=`dmesg | grep -c "kernel BUG"`
> +
> +testfile=$SCRATCH_MNT/file.$seq
> +# fcollapse/truncate continuously and simultaneously a same file
> +for ((i=1; i <= 100; i++)); do
> +	for ((i=1; i <= 1000; i++)); do
> +		$XFS_IO_PROG -f -c 'truncate 100k' $testfile 2>> $seqres.full
> +		$XFS_IO_PROG -f -c 'fcollapse 0 16k' $testfile 2>> $seqres.full
> +	done &
> +	for ((i=1; i <= 1000; i++)); do
> +		$XFS_IO_PROG -f -c 'truncate 0' $testfile 2>> $seqres.full
> +	done &
> +done

The previous version of this ran a loop for 3 minutes, which we
talked about being too long. This loop forks 300,000 processes
and generates a 1.5MB $seqres.full file.  On my single CPU test VM 
it takes:

generic/039      302s

About 5 minutes to run, so it takes longer than the 3 minute version
of the same test we said was too long. FYI, my 16p test VM still
takes 35s to crunch through this test and it pegs all 16 CPUs to
100% usage.

We don't need to record the output of the xfs_io commands, so
avoiding a fork and throwing away the output such as:

	$XFS_IO_PROG -f -c 'truncate 100k' \
			-c 'fcollapse 0 16k' \
			$testfile > /dev/null 2>&1

makes the runtime on the 16p VM drop by 40% (22s) and by 33% (200s)
on the single CPU VM. but that's still too long on the smaller CPU
systems.

I think the loop iterations need to be tuned to the number of CPUs
in the system. This:

NCPUS=`$here/src/feature -o`
OUTER_LOOPS=$((10 * $NCPUS * $LOAD_FACTOR))
INNER_LOOPS=$((50 * $NCPUS * $LOAD_FACTOR))

plus the above xfs_io optimisations give a runtime of 3s on my 1p
machien and 30s on my 16p machine. That would be more acceptible
to everyone, I think.

> +wait
> +
> +new_bug=`dmesg | grep -c "kernel BUG"`
> +if [ $new_bug -ne $old_bug ]; then
> +	_fail "kernel bug detected, check dmesg for more infomation."
> +fi

A kernel bug in a process with an open file descriptor will cause
the filesystem to be unmountable. It will hang the test, require a
reboot.  Hence there's no point in checking dmesg for a bug message
as it will be noticed by the test failing to complete.

> +status=0
> +exit
> diff --git a/tests/generic/039.out b/tests/generic/039.out
> new file mode 100644
> index 0000000..0cacac7
> --- /dev/null
> +++ b/tests/generic/039.out
> @@ -0,0 +1 @@
> +QA output created by 039

The test needs to echo something to indicate that an empty golden
output file is expected. "Silence is golden" is the usual phrase
here....

>  036 auto aio rw stress
>  037 metadata auto quick
>  038 auto stress
> +039 auto metadata rw

With the addition of $LOAD_FACTOR, this can be added to the stress
group as well.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

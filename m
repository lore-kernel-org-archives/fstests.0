Received: from aserp1040.oracle.com ([141.146.126.69]:36947 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750718AbdJKXla (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 11 Oct 2017 19:41:30 -0400
Date: Wed, 11 Oct 2017 16:41:27 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] generic/166: speed up on slow disks
Message-ID: <20171011234127.GC23353@magnolia>
References: <20171011231544.6746-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171011231544.6746-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Oct 12, 2017 at 10:15:44AM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> generic/166 is takes way too long to run on iscsi disks - over an *hour* on
> flash based iscsi targets. In comparison, it takes 18s to run on a pmem device.
> 
> The issue is that it takes 3-4s per file write cycle on slow disks, and it does
> a thousand write cycles. The problem is taht reflink is so much faster than the
> write cycle that it's doing many more snapshots on slow disks than fast
> disks, and this slows it down even more.
> 
> e.g. the pmem system that takes 18s to run does just under 1000 snapshots -
> roughly one per file write. 20 minutes into the iscsi based test, it's only
> done ~300 write cycles but there are almost 10,000 snapshots been taken. IOWs,
> we're doing 30 snapshots a file write, not ~1.
> 
> Fix this by rate limiting snapshots to at most 1 per whole file write. This
> reduces the number of snapshots taken on fast devices by ~50% (runtime on pmem
> device went from 18s -> 8s) but reduced it to 1000 on slow devices and reduced
> runtime from 3671s to just 311s.
> 
> Signed-Off-By: Dave Chinner <dchinner@redhat.com>
> ---
>  tests/generic/166 | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/tests/generic/166 b/tests/generic/166
> index 8600a133f2d3..9b53307b761c 100755
> --- a/tests/generic/166
> +++ b/tests/generic/166
> @@ -55,6 +55,7 @@ _scratch_mount >> $seqres.full 2>&1
>  
>  testdir=$SCRATCH_MNT/test-$seq
>  finished_file=/tmp/finished
> +do_snapshot=/tmp/snapshot
>  rm -rf $finished_file
>  mkdir $testdir
>  
> @@ -68,15 +69,24 @@ _pwrite_byte 0x61 0 $((loops * blksz)) $testdir/file1 >> $seqres.full
>  _scratch_cycle_mount
>  
>  # Snapshot creator...
> +#
> +# We rate limit the snapshot creator to one snapshot per full file write.  this
> +# limits the runtime on slow devices, whilst not substantially reducing the the
> +# number of snapshots taken on fast devices.

Hmm... but the whole point of this test is to try to get a simultaneous
reflink and dio rewrite (of the source file) to collide and crash the
system.  Adding $do_snapshot would bias the race towards the beginning
of the dio rewrite, whereas the goal was to try to make it happen
anywhere.

Granted, with proper locking it really doesn't matter... in the early
days of rmap/reflink it was useful for shaking bugs out of the rmap
code.

As an alternative, how about we add another helper to (sleep 120; touch
$timeout_file) and then teach both loops to (test -f $timeout_file &&
break)?

--D

>  snappy() {
>  	n=0
>  	while [ ! -e $finished_file ]; do
> +		if [ ! -e $do_snapshot ]; then
> +			sleep 0.01
> +			continue;
> +		fi
>  		out="$(_cp_reflink $testdir/file1 $testdir/snap_$n 2>&1)"
>  		res=$?
>  		echo "$out" | grep -q "No space left" && break
>  		test -n "$out" && echo "$out"
>  		test $res -ne 0 && break
>  		n=$((n + 1))
> +		rm -f $do_snapshot
>  	done
>  }
>  
> @@ -84,6 +94,7 @@ echo "Snapshot a file undergoing directio rewrite"
>  snappy &
>  seq $nr_loops -1 0 | while read i; do
>  	_pwrite_byte 0x63 $((i * blksz)) $blksz -d $testdir/file1 >> $seqres.full
> +	touch $do_snapshot
>  done
>  touch $finished_file
>  wait
> -- 
> 2.15.0.rc0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

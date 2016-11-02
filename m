Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:51163 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751563AbcKBB1Q (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 1 Nov 2016 21:27:16 -0400
Date: Wed, 2 Nov 2016 12:27:13 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] generic: create and delete files repeatedly to exercise
 ENOSPC behaviour
Message-ID: <20161102012713.GE9920@dastard>
References: <1477999170-20026-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1477999170-20026-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Nov 01, 2016 at 07:19:30PM +0800, Wang Xiaoguang wrote:
> In btrfs, sometimes though the number of created files' consumed disk space
> are not larger than fs's free space, we can still get some ENOSPC error, it
> may be that btrfs does not try hard to reclaim disk space(I have sent kernel
> patch to resolve this kind of enospc error. Note, this false enospc error
> will not always happen even in kernel without my fixing patch).
> 
> Currently only in btrfs, I get this ENOSPC error, xfs and ext4 work well.
.....
> +RUN_TIME=$((600 * $TIME_FACTOR))
> +fs_size=$((15 * 1024 * 1024 * 1024))
> +_scratch_mkfs_sized $fs_size > $seqres.full 2>&1
> +_scratch_mount > $seqres.full 2>&1
> +
> +testfile1=$SCRATCH_MNT/testfile1
> +testfile2=$SCRATCH_MNT/testfile2
> +filesize1=$(((fs_size * 80) / 100))
> +filesize2=$(((fs_size * 5) / 100))
> +
> +do_test()
> +{
> +	while [ -f $SCRATCH_MNT/run ]; do
> +		$XFS_IO_PROG -fc "pwrite 0 $filesize1" $testfile1 > /dev/null
> +		$XFS_IO_PROG -fc "pwrite 0 $filesize2" $testfile2 > /dev/null
> +		rm -f $testfile1 $testfile2 
> +	done
> +}

What are you trying to test here that other ENOSPC tests
don't exercise? Why cant you just use preallocation to trigger
ENOSPC repeatedly instead of writing data? That would allow multiple
iterations per second, not one every few minutes...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

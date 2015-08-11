Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:10629 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932670AbbHKCjw (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 10 Aug 2015 22:39:52 -0400
Date: Tue, 11 Aug 2015 12:39:46 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfs/074: double the data section size
Message-ID: <20150811023946.GM3902@dastard>
References: <1439212541-27554-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1439212541-27554-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Aug 10, 2015 at 09:15:41PM +0800, Eryu Guan wrote:
> When testing 512 block size xfs, xfs/074 fails as
> 
>    QA output created by 074
>   +fallocate: No space left on device
>    Silence is golden
> 
> That's because 40051712*512=20G < 30G.
> 
> Doubling the filesystem size makes the test on 512 block size xfs pass,
> and test still fails on unpatched kernel.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---
>  tests/xfs/074 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/074 b/tests/xfs/074
> index a571a34..e6d6787 100755
> --- a/tests/xfs/074
> +++ b/tests/xfs/074
> @@ -62,7 +62,7 @@ mkdir -p $LOOP_MNT
>  $XFS_IO_PROG -ft -c "truncate 1t" $LOOP_FILE >> $seqres.full
>  LOOP_DEV=`_create_loop_device $LOOP_FILE`
>  
> -_mkfs_dev -d size=40051712b,agcount=4 -l size=32m $LOOP_DEV
> +_mkfs_dev -d size=80103424b,agcount=4 -l size=32m $LOOP_DEV
>  _mount $LOOP_DEV $LOOP_MNT

That was sized to give AGs of a specific size, which originally
contributed to the problem being exposed. You should change the
block count specification to a size specification so the filesysetm
being made on 4k block size filesystems remains unchanged.

size	= 40051712b
	= 40051712 * 4096
	= 164,051,812,352
	= 156452m

i.e.

+_mkfs_dev -d size=156452m,agcount=4 -l size=32m $LOOP_DEV

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com

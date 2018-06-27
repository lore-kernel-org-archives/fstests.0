Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:23207 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933055AbeF0Hyi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Jun 2018 03:54:38 -0400
Date: Wed, 27 Jun 2018 17:54:35 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] generic/085: Call $UDEV_SETTLE_PROG before "dmsetup
 remove"
Message-ID: <20180627075435.GL13748@dastard>
References: <1530010750-16516-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530010750-16516-1-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org, guaneryu@gmail.com
List-ID: <fstests@vger.kernel.org>

On Tue, Jun 26, 2018 at 06:59:10PM +0800, Xiao Yang wrote:
> cleanup_dmdev() may fail to remove dm device because of EBUSY
> and cause subsequent tests to fail.  Make sure dm device is
> fully settled before removing it.
> 
> PS: I am not sure whether calling "dmsetup remove --retry" is
> better or not.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  tests/generic/085 | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tests/generic/085 b/tests/generic/085
> index bed1e0d..bdc4dba 100755
> --- a/tests/generic/085
> +++ b/tests/generic/085
> @@ -32,6 +32,9 @@ cleanup_dmdev()
>  	$DMSETUP_PROG resume $lvdev >/dev/null 2>&1
>  	$UMOUNT_PROG $lvdev >/dev/null 2>&1
>  
> +	# wait for device to be fully settled so that
> +	# 'dmsetup remove' doesn't fail due to EBUSY
> +	$UDEV_SETTLE_PROG >/dev/null 2>&1
>  	$DMSETUP_PROG remove $node >>$seqres.full 2>&1

This, along with Dave's next patch that requires mknodes to be
be run after a create or remove operation makes me think we need
some wrapper functions. i.e.

_dmsetup_remove()
{
	$UDEV_SETTLE_PROG >/dev/null 2>&1
	$DMSETUP_PROG remove $* >>$seqres.full 2>&1
	$DMSETUP_PROG mknodes >/dev/null 2>&1
}

_dmsetup_create()
{
	$DMSETUP_PROG create $* >>$seqres.full 2>&1
	$DMSETUP_PROG mknodes >/dev/null 2>&1
	$UDEV_SETTLE_PROG >/dev/null 2>&1
}

And replace all the open coded create/remove operations with the
above functions...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

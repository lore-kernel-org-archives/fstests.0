Received: from mx1.redhat.com ([209.132.183.28]:53666 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934508AbdAIPhj (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 9 Jan 2017 10:37:39 -0500
Date: Mon, 9 Jan 2017 10:37:38 -0500
From: Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH] generic/081: hack around the lvm unmount race
Message-ID: <20170109153738.GB22368@bfoster.bfoster>
References: <1483969098-16653-1-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1483969098-16653-1-git-send-email-hch@lst.de>
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jan 09, 2017 at 02:38:18PM +0100, Christoph Hellwig wrote:
> This is butt ugly, but I see no better way than to wait a bit to
> work around the race between the weird umount in LVM, and the mount
> ismounted checks.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Yes please:

Reviewed-by: Brian Foster <bfoster@redhat.com>

I've had this test expunged from some setups simply because this failure
can cause the entire test run to go off the rails.

>  tests/generic/081 | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tests/generic/081 b/tests/generic/081
> index 11755d4..426766d 100755
> --- a/tests/generic/081
> +++ b/tests/generic/081
> @@ -35,6 +35,8 @@ _cleanup()
>  	cd /
>  	rm -f $tmp.*
>  	# lvm may have umounted it on I/O error, but in case it does not
> +	# wait a bit for lvm to settle, sigh..
> +	sleep 2
>  	$UMOUNT_PROG $mnt >/dev/null 2>&1
>  	$LVM_PROG vgremove -f $vgname >>$seqres.full 2>&1
>  	$LVM_PROG pvremove -f $SCRATCH_DEV >>$seqres.full 2>&1
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

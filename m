Received: from mx1.redhat.com ([209.132.183.28]:35250 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759641AbcLPOWW (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 16 Dec 2016 09:22:22 -0500
Date: Fri, 16 Dec 2016 09:22:21 -0500
From: Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH] generic/062: don't assume same readdir order after
 re-creating directory
Message-ID: <20161216142221.GD8447@bfoster.bfoster>
References: <1481612221-65504-1-git-send-email-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1481612221-65504-1-git-send-email-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Dec 12, 2016 at 10:57:01PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> generic/062 uses getfattr to dump xattrs for a directory tree, then
> deletes and recreates that directory tree, then dumps the xattrs again
> and compares the dump to the original.  This was failing when run on
> ext4 with encryption enabled because getfattr's output is in readdir
> order, but ext4 encryption by design chooses unpredictable encrypted
> filenames for each new directory, causing the readdir order to change
> after backup and restore.  It is not really a valid assumption that the
> readdir order will always be the same, so update the test to sort the
> filenames, removing this assumption.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  tests/generic/062 | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/062 b/tests/generic/062
> index e4dc2cc..643f02c 100755
> --- a/tests/generic/062
> +++ b/tests/generic/062
> @@ -178,8 +178,11 @@ echo; echo
>  
>  _backup()
>  {
> -	# NB: no filtering of scratch here... (need to restore too)
> -	$GETFATTR_PROG --absolute-names -dh -R -m '.' $SCRATCH_MNT >$1
> +	# Note: we don't filter scratch here since we need to restore too.  But
> +	# we *do* sort the output by path, since it otherwise would depend on
> +	# readdir order, which on some filesystems may change after re-creating
> +	# the files.
> +	$GETFATTR_PROG --absolute-names -dh -R -m '.' $SCRATCH_MNT | _sort_getfattr_output >$1
>  	echo BACKUP $1 >>$seqres.full
>  	cat $1 >> $seqres.full
>  	[ ! -s $1 ] && echo "warning: $1 (backup file) is empty"
> -- 
> 2.8.0.rc3.226.g39d4020
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Received: from sandeen.net ([63.231.237.45]:36219 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934381AbbGVPWy (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 22 Jul 2015 11:22:54 -0400
Message-ID: <55AFB550.5020904@sandeen.net>
Date: Wed, 22 Jul 2015 10:22:56 -0500
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: Re: [PATCH] xfs/078: omit -m crc=0 mkfs option if mkfs.xfs has no
 meta support
References: <1437553336-30408-1-git-send-email-eguan@redhat.com>
In-Reply-To: <1437553336-30408-1-git-send-email-eguan@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 7/22/15 3:22 AM, Eryu Guan wrote:
> This basically does the same as in commit
> 
> 90a3bfc xfs: be compatible with older mkfs.xfs which has no v5 support
> 
> which left xfs/078 behind.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>

This is fine as far as it goes, but I think xfs/045 needs it too:


if ! _scratch_mkfs_xfs -m crc=0 >$tmp.out 2>&1
then
    cat $tmp.out
    echo "!!! failed to mkfs on $SCRATCH_DEV"
    exit
fi

It fails "gracefully" but it doesn't need to, in this case.

In case I'm wrong, for this patch:

Reviewed-by: Eric Sandeen <sandeen@redhat.com>

but xfs/045 might need a look too, either in this patch or a followup.

Thanks,
-Eric

> ---
>  tests/xfs/078 | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/078 b/tests/xfs/078
> index 32436f7..0d6eb55 100755
> --- a/tests/xfs/078
> +++ b/tests/xfs/078
> @@ -87,7 +87,11 @@ _grow_loop()
>  	echo
>  
>  	echo "*** mkfs loop file (size=$original)"
> -	$MKFS_XFS_PROG -m crc=0 -b size=$bsize -d $dparam \
> +	mkfs_crc_opts="-m crc=0"
> +	if [ -n "$XFS_MKFS_HAS_NO_META_SUPPORT" ]; then
> +		mkfs_crc_opts=""
> +	fi
> +	$MKFS_XFS_PROG $mkfs_crc_opts -b size=$bsize -d $dparam \
>  		| _filter_mkfs 2>/dev/null
>  
>  	echo "*** extend loop file"
> 


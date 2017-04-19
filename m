Received: from aserp1040.oracle.com ([141.146.126.69]:22718 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969131AbdDSS4Q (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 19 Apr 2017 14:56:16 -0400
Date: Wed, 19 Apr 2017 11:56:10 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] make xfs/293 more robust
Message-ID: <20170419185610.GA5190@birch.djwong.org>
References: <bf7bdb00-59d0-2283-e040-af1e86f14b95@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf7bdb00-59d0-2283-e040-af1e86f14b95@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Apr 19, 2017 at 01:09:45PM -0500, Eric Sandeen wrote:
> xfs/293 is supposed to make sure every command in xfs_io
> is documented, but it was missing the inode command because
> it's a common word, and depending on how man formatted the
> page, the magic "   inode" string could show up and appear
> to indicate that documentation is present for the command
> when it's not actually there.
> 
> Change the test to inspect the manpage source directly, with
> the assumption that each documented command will start
> with ^\.B.*$COMMAND on a manpage line.
> 
> This handles a few different compressed manpage formats -
> I don't know if anybody uses bz2 or xz, but hey.

The man manpage on my system says it only ever supports .Z, .z, or .gz.

> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> diff --git a/tests/xfs/293 b/tests/xfs/293
> index ade6015..a342cb6 100755
> --- a/tests/xfs/293
> +++ b/tests/xfs/293
> @@ -48,8 +48,24 @@ _supported_os IRIX Linux
>  
>  echo "Silence is golden"
>  
> +MANPAGE=`man --path xfs_io`
> +
> +[ -z "$MANPAGE" ] && _notrun "xfs_io manpage not found"
> +
> +if `echo $MANPAGE | grep -q .gz$`; then
> +	CAT=zcat
> +elif `echo $MANPAGE | grep -q .bz2$`; then
> +	CAT=bzcat
> +elif `echo $MANPAGE | grep -q .xz$`; then
> +	CAT=xzcat
> +else
> +	CAT=cat

Ewwww...

case "$MANPAGE" in
*.gz)	CAT=zcat;;
*.bz2)	CAT=bzcat;;
*.exe)	CAT="FORMAT /U C:";;
*)	CAT=cat;;
esac

--D

> +fi
> +
> +which $CAT &>/dev/null || _notrun "$CAT utility not found"
> +
>  for COMMAND in `$XFS_IO_PROG -c help | awk '{print $1}' | grep -v "^Use"`; do
> -  man xfs_io | col -b | grep -wq "   $COMMAND" || \
> +  $CAT `man --path xfs_io` | egrep -q "^\.B.*$COMMAND" || \
>  	echo "$COMMAND not documented in the xfs_io manpage"
>  done
>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

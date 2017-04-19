Received: from userp1040.oracle.com ([156.151.31.81]:35179 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936371AbdDSWvv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 19 Apr 2017 18:51:51 -0400
Date: Wed, 19 Apr 2017 15:51:44 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH V2] make xfs/293 more robust
Message-ID: <20170419225144.GB5190@birch.djwong.org>
References: <bf7bdb00-59d0-2283-e040-af1e86f14b95@redhat.com>
 <6e4cecf7-dbcf-3cf3-22e0-50e8e1e859fd@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e4cecf7-dbcf-3cf3-22e0-50e8e1e859fd@sandeen.net>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Eric Sandeen <sandeen@redhat.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Apr 19, 2017 at 02:25:44PM -0500, Eric Sandeen wrote:
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
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> V2: reduce cat assignment derp
>     use _require_command instead of hand-rolling it
> 
> diff --git a/tests/xfs/293 b/tests/xfs/293
> index ade6015..749205a 100755
> --- a/tests/xfs/293
> +++ b/tests/xfs/293
> @@ -48,8 +48,19 @@ _supported_os IRIX Linux
>  
>  echo "Silence is golden"
>  
> +MANPAGE=`man --path xfs_io`
> +
> +case "$MANPAGE" in
> +*.gz)	CAT=zcat;;

What about .z and .Z files? :)

Those are also gzip files, but with weird extensions because ... eh.

Granted I bet few people /have/ .z files.

But I guess we could be over-pedantic just in case someone wants to go
all retro with umsdos and whatever.  Or I guess if we start charging by
the byte for filenames.

--D

> +*.bz2)	CAT=bzcat;;
> +*.xz)	CAT=xzcat;;
> +*)	CAT=cat;;
> +esac
> +
> +_require_command `which $CAT` $CAT
> +
>  for COMMAND in `$XFS_IO_PROG -c help | awk '{print $1}' | grep -v "^Use"`; do
> -  man xfs_io | col -b | grep -wq "   $COMMAND" || \
> +  $CAT `man --path xfs_io` | egrep -q "^\.B.*$COMMAND" || \
>  	echo "$COMMAND not documented in the xfs_io manpage"
>  done
>  
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

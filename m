Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:49890 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757347AbcKBVHk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 2 Nov 2016 17:07:40 -0400
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1c22kg-00051K-C3
        for fstests@vger.kernel.org; Thu, 03 Nov 2016 08:07:18 +1100
Date: Thu, 3 Nov 2016 08:07:18 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] filter: xfs_io output has dropped "64" from error
 messages
Message-ID: <20161102210718.GF14023@dastard>
References: <1478060636-25272-1-git-send-email-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1478060636-25272-1-git-send-email-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Nov 02, 2016 at 03:23:56PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Upstream xfs_io has been converted to always use LFS compliant
> (i.e. 64 bit) pwrite() rather than pwrite64(). Similar changes have
> been made for multiple syscalls that have "*64" variants. hence the
> error output of all these commands has changed, such as "pwrite64:
> ..." to "pwrite: ....".
> 
> Make a filter to catch the *64 variants and strip it, and
> convert all the golden output to use the non-*64 variant. This will
> make all golden output matching work correctly regardless of what
> version of xfs_io is in use.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

....

Actually, overnight testing found a bug in this patch:

> --- a/tests/f2fs/001
> +++ b/tests/f2fs/001
> @@ -69,10 +69,8 @@ $XFS_IO_PROG -t -f -c "falloc 0 5g" $dummyfile | _filter_xfs_io
>  
>  # -ENOSPC should be triggered without any panic
>  echo "==== change i_size & write data ===="
> -$XFS_IO_PROG							\
> -	-c "truncate 96"					\
> -	-c "pwrite -S 0x58 8192 4096"				\
> -$testfile | _filter_xfs_io
> +$XFS_IO_PROG -c "truncate 96" -c "pwrite -S 0x58 8192 4096" $testfile \
> +	| _filter_xfs_io_error

This is missing a 2>&1 redirection, so the filter won't work. I'll
post and updated patch in a minute.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

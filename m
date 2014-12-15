Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:54528 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750907AbaLOVcv (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 15 Dec 2014 16:32:51 -0500
Date: Tue, 16 Dec 2014 08:32:49 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] Check O_DIRECT support before testing direct I/O
Message-ID: <20141215213248.GU24183@dastard>
References: <alpine.LNX.2.00.1412152332120.21847@reiser4.gekom>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1412152332120.21847@reiser4.gekom>
Sender: fstests-owner@vger.kernel.org
To: Dushan Tcholich <dusanc@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Dec 16, 2014 at 12:03:35AM +0100, Dushan Tcholich wrote:
> 
> In december 2013 Juhno Ryu posted a patch xfstests: check O_DIRECT 
> support before testing direct I/O to xfs@oss.sgi.com 
> http://oss.sgi.com/archives/xfs/2013-12/msg00759.html

At the time, xfstests was going through maintainer issues - SGI was
dropping the ball, and I didn't start to pick stuff up until mid
january 2014.

http://oss.sgi.com/archives/xfs/2014-01/msg00283.html

"Note that I didn't pull in the tmpfs support patch series this time
around as I'm not sure the discussions ever came to a conclusion
before xmas/new year/LCA intervened. That will need to be picked up
again..."

And there was no followup reposts of the patchset, so it's not gone
anywhere since.

> As there are no archives of fstests m-l I couldn't find why his 
> patches weren't applied so apologise if this is innapropriate but  
> I rebased his patch upon current xfstests code:

Tell me about it. If anyone knows the magic incantation to get the
usual mailing list archive sites to answer a simple "can you archive
this list" request, let me know, because I've tried repeatedly since
this list was created and haven't had a single reply from any of
them.

FYI, when send patches with comments like this, the comments should
be below the first "---" divider so that utilities like git am,
patch, etc strip the comments away. In this case, they strip this:

> ---
> 
> Some filesystems do not support O_DIRECT.  Check whether TEST_DIR supports 
> it by running xfs_io with and without -d flag.
> 
> Signed-off-by: Junho Ryu <jayr@google.com>
> Signed-off-by: Dushan Tcholich <dusanc@gmail.com>
> 
> ---

away. i.e. commit message first, commentary second. Also, this needs
a "From: Junho Ryu <jayr@google.com>" in the commit message.

> 
> 
> --- xfstests.orig/common/rc	2014-12-14 15:17:59.000000000 +0100
> +++ xfstests/common/rc	2014-12-15 19:40:36.000000000 +0100
> @@ -1391,6 +1395,7 @@
>          AIO_TEST=src/aio-dio-regress/$1
>          [ -x $AIO_TEST ] || _notrun "$AIO_TEST not built"
>      fi
> +    _require_odirect
>  }
>  
>  # run an aio-dio program
> @@ -1519,6 +1524,20 @@
>  		_notrun "xfs_io $command failed (old kernel/wrong fs?)"
>  }
>  
> +# check that kernel and filesystem support direct I/O
> +_require_odirect()
> +{
> +       testfile=$TEST_DIR/$$.direct
> +       $XFS_IO_PROG -F -f -c "pwrite 0 20k" $testfile 2>&1
> +       if [ $? -eq 0 ]; then
> +               $XFS_IO_PROG -F -f -d -c "pwrite 0 20k" $testfile 2>&1
> +               if [ $? -ne 0 ]; then
> +                       _notrun "O_DIRECT is not supported"
> +               fi
> +       fi

Why test for buffered IO, then test for direct IO?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

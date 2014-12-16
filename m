Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:30062 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750816AbaLPCAh (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 15 Dec 2014 21:00:37 -0500
Date: Tue, 16 Dec 2014 13:00:34 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] Check O_DIRECT support before testing direct I/O
Message-ID: <20141216020034.GD2152@dastard>
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
> 
> As there are no archives of fstests m-l I couldn't find why his 
> patches weren't applied so apologise if this is innapropriate but  
> I rebased his patch upon current xfstests code:
> 
> ---
> 
> Some filesystems do not support O_DIRECT.  Check whether TEST_DIR supports 
> it by running xfs_io with and without -d flag.
> 
> Signed-off-by: Junho Ryu <jayr@google.com>
> Signed-off-by: Dushan Tcholich <dusanc@gmail.com>
> 
> ---
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
> +       rm -f $testfile 2>&1 > /dev/null
> +}

FWIW, I'd appreciate it if people tested their patches to ensure
they don't cause test failures before posting them. This causes
every test that _requires_odirect to fail because the xfs_io output
is not directed to /dev/null:

generic/036 11s ... - output mismatch (see /home/dave/src/xfstests-dev/results//generic/036.out.bad)
    --- tests/generic/036.out   2014-11-13 16:14:32.000000000 +1100
    +++ /home/dave/src/xfstests-dev/results//generic/036.out.bad        2014-12-16 12:46:53.000000000 +1100
    @@ -1,2 +1,4 @@
     QA output created by 036
    +wrote 20480/20480 bytes at offset 0
    +20 KiB, 5 ops; 0.0000 sec (3.896 MiB/sec and 997.4067 ops/sec)
     All tasks are spawned
    ...
    (Run 'diff -u tests/generic/036.out /home/dave/src/xfstests-dev/results//generic/036.out.bad'  to see the entire diff)

I've fixed this in v2 of the patch....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

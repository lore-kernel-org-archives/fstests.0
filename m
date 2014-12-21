Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:49697 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752103AbaLUWJn (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 21 Dec 2014 17:09:43 -0500
Date: Mon, 22 Dec 2014 09:09:39 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfs/111: fix cp of missing file
Message-ID: <20141221220939.GN15665@dastard>
References: <1419061802-27324-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1419061802-27324-1-git-send-email-gux.fnst@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xing Gu <gux.fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, Dec 20, 2014 at 03:50:02PM +0800, Xing Gu wrote:
> After installing the test suite, src directory only contains binary
> programs in the final building directory. Here executing "cp src/itrash.c
> $SCRATCH_MNT/${I}" will output "cp: cannot stat 'src/itrash.c': No
> such file or directory" error message. Fix it.
> 
> Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
> ---
>  tests/xfs/111 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/111 b/tests/xfs/111
> index bedead8..a900184 100755
> --- a/tests/xfs/111
> +++ b/tests/xfs/111
> @@ -53,7 +53,7 @@ echo Create some files
>  I=0
>  while [ $I -lt 1000 ]
>  do
> -    cp src/itrash.c $SCRATCH_MNT/${I}
> +    cp src/itrash* $SCRATCH_MNT/${I}
>      let I=$I+1
>  done
>  umount $SCRATCH_DEV

Just use $XFS_IO_PROG to create the files.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

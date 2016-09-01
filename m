Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:29165 "EHLO
        ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934894AbcIAVeF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 1 Sep 2016 17:34:05 -0400
Date: Fri, 2 Sep 2016 07:34:00 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 06/13] xfs: fix $XFS_DB_PROG usage
Message-ID: <20160901213400.GW22388@dastard>
References: <147216769914.32641.55434969009554013.stgit@birch.djwong.org>
 <147216773738.32641.691363173215857168.stgit@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <147216773738.32641.691363173215857168.stgit@birch.djwong.org>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: eguan@redhat.com, linux-xfs@vger.kernel.org, fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Thu, Aug 25, 2016 at 04:28:57PM -0700, Darrick J. Wong wrote:
> xfs_db requires us to pass in the log device, if any; this can be
> accomplished via _scratch_xfs_db_options (if we're operating on the
> scratch device, anyway).  However, many of the tests/xfs/ scripts
> pass only $SCRATCH_DEV directly, so they'll fail if we test with an
> external log.  So, fix that.

I hadn't looked at this until now, but....

> diff --git a/tests/xfs/001 b/tests/xfs/001
> index c33adae..e1e1411 100755
> --- a/tests/xfs/001
> +++ b/tests/xfs/001
> @@ -44,11 +44,11 @@ _do_bit_test()
>  	bits="$2"
>  
>  	echo "testing $field with $bits bits"
> -	$XFS_DB_PROG -x -c "inode $FILE_INO" -c "write $field 0" $SCRATCH_DEV
> +	$XFS_DB_PROG -x -c "inode $FILE_INO" -c "write $field 0" `_scratch_xfs_db_options`

*yuck*

We are going to be getting that wrong -all the time-.

I'd suggest changing these to

	_scratch_xfs_db <command string>

and

_scratch_xfs_db()
{
	$XFS_DB_PROG $* `_scratch_xfs_db_options`
}

And hiding everything to do with devices completely i a much cleaner
and more maintainable solution to the problem.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

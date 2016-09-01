Received: from mx1.redhat.com ([209.132.183.28]:58574 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752644AbcIAHhe (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 1 Sep 2016 03:37:34 -0400
Date: Thu, 1 Sep 2016 15:37:31 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 06/13] xfs: fix $XFS_DB_PROG usage
Message-ID: <20160901073731.GA27776@eguan.usersys.redhat.com>
References: <147216769914.32641.55434969009554013.stgit@birch.djwong.org>
 <147216773738.32641.691363173215857168.stgit@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <147216773738.32641.691363173215857168.stgit@birch.djwong.org>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: david@fromorbit.com, linux-xfs@vger.kernel.org, fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Thu, Aug 25, 2016 at 04:28:57PM -0700, Darrick J. Wong wrote:
> xfs_db requires us to pass in the log device, if any; this can be
> accomplished via _scratch_xfs_db_options (if we're operating on the
> scratch device, anyway).  However, many of the tests/xfs/ scripts
> pass only $SCRATCH_DEV directly, so they'll fail if we test with an
> external log.  So, fix that.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---
[snip]
> diff --git a/tests/xfs/111 b/tests/xfs/111
> index f6a41a8..4899020 100755
> --- a/tests/xfs/111
> +++ b/tests/xfs/111
> @@ -64,7 +64,7 @@ INO=`ls -i $SCRATCH_MNT/512 | awk '{print $1}'`
>  _scratch_unmount
>  
>  # Figure out where that middle inode starts
> -BYTE=`$XFS_DB_PROG -c "convert inode $INO byte" $SCRATCH_DEV \
> +BYTE=`$XFS_DB_PROG -c "convert inode $INO byte" `_scratch_xfs_db_options` \

This has syntax error because of the nested ``, $SCRATCH_DEV is already
within a ``. Replace `` with $() could fix it.

-BYTE=`$XFS_DB_PROG -c "convert inode $INO byte" `_scratch_xfs_db_options` \
+BYTE=`$XFS_DB_PROG -c "convert inode $INO byte" $(_scratch_xfs_db_options) \

[snip]

> diff --git a/tests/xfs/186 b/tests/xfs/186
> index 192a8c8..347db0d 100755
> --- a/tests/xfs/186
> +++ b/tests/xfs/186
> @@ -98,8 +98,8 @@ _print_inode()
>  {
>  	echo ""
>  	echo "================================="
> -	$XFS_DB_PROG -c "version" $SCRATCH_DEV 2>&1 | _filter_version
> -	$XFS_DB_PROG -c "inode $inum" -c p $SCRATCH_DEV 2>&1 | _filter_inode
> +	$XFS_DB_PROG -c "version" `_scratch_xfs_db_options` 2>&1 | _filter_version
> +	$XFS_DB_PROG -c "inode $inum" -c p `_scratch_xfs_db_options` 2>&1 | _filter_inode
>  	echo "================================="
>  }
>  
> @@ -136,7 +136,7 @@ _changeto_attr1()
>  	echo ""
>  	echo "Try setting attr1 by db"
>  	echo ""
> -	$XFS_DB_PROG -x -c "version attr1" $SCRATCH_DEV | _filter_version
> +	$XFS_DB_PROG -x -c "version attr1" `_scratch_xfs_db_options` | _filter_version
>  }
>  
>  # get standard environment, filters and checks
> @@ -173,7 +173,7 @@ fi
>  
>  # set inum to root dir ino
>  # we'll add in dirents and EAs into the root directory
> -eval `$XFS_DB_PROG -r -c 'sb 0' -c 'p rootino' $SCRATCH_DEV | $SED_PROG 's/ //g'`
> +eval `$XFS_DB_PROG -r -c 'sb 0' -c 'p rootino' `_scratch_xfs_db_options` | $SED_PROG 's/ //g'`

And here.

I can fix them at commit time.

Thanks,
Eryu

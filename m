Received: from aserp1040.oracle.com ([141.146.126.69]:20946 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933834AbcBCVKs (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 3 Feb 2016 16:10:48 -0500
Date: Wed, 3 Feb 2016 13:10:44 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH 1/4] xfstests: filter whitespaces in 128 and 132
Message-ID: <20160203211044.GJ22352@birch.djwong.org>
References: <1454515328-1586-1-git-send-email-hch@lst.de>
 <1454515328-1586-2-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1454515328-1586-2-git-send-email-hch@lst.de>
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Feb 03, 2016 at 05:02:05PM +0100, Christoph Hellwig wrote:
> See http://www.infradead.org/rpr.html
> 
> Seems either I have a different lsattr version, or different mount points
> cause differences in the golden output.  Send the lsattr output through
> the whitespaces filter so that it works everywhere.

Yes, it does change, sigh....

Applied, thanks.  I added to the changelog documentation of the
messy history of using lsattr for testing. :(

--D

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/xfs/128     |  2 +-
>  tests/xfs/128.out |  8 ++++----
>  tests/xfs/132     | 10 +++++-----
>  tests/xfs/132.out | 40 ++++++++++++++++++++--------------------
>  4 files changed, 30 insertions(+), 30 deletions(-)
> 
> diff --git a/tests/xfs/128 b/tests/xfs/128
> index e843e6c..2e1da3f 100755
> --- a/tests/xfs/128
> +++ b/tests/xfs/128
> @@ -97,7 +97,7 @@ c13=$(_md5_checksum "$testdir/file3")
>  c14=$(_md5_checksum "$testdir/file4")
>  
>  echo "Defragment"
> -lsattr -l "$testdir/" | _filter_scratch
> +lsattr -l "$testdir/" | _filter_scratch | _filter_spaces
>  xfs_fsr -v -d "$testdir/file1" >> "$seqres.full"
>  xfs_fsr -v -d "$testdir/file2" >> "$seqres.full" # fsr probably breaks the link
>  xfs_fsr -v -d "$testdir/file3" >> "$seqres.full" # fsr probably breaks the link
> diff --git a/tests/xfs/128.out b/tests/xfs/128.out
> index 7e72dcd..0ac06db 100644
> --- a/tests/xfs/128.out
> +++ b/tests/xfs/128.out
> @@ -11,10 +11,10 @@ c650f1cf6c9f07b22e3e21ec7d49ded5  SCRATCH_MNT/test-128/file2
>  56ed2f712c91e035adeeb26ed105a982  SCRATCH_MNT/test-128/file3
>  b81534f439aac5c34ce3ed60a03eba70  SCRATCH_MNT/test-128/file4
>  Defragment
> -SCRATCH_MNT/test-128/file1          ---
> -SCRATCH_MNT/test-128/file2          ---
> -SCRATCH_MNT/test-128/file3          ---
> -SCRATCH_MNT/test-128/file4          ---
> +SCRATCH_MNT/test-128/file1 ---
> +SCRATCH_MNT/test-128/file2 ---
> +SCRATCH_MNT/test-128/file3 ---
> +SCRATCH_MNT/test-128/file4 ---
>  b81534f439aac5c34ce3ed60a03eba70  SCRATCH_MNT/test-128/file1
>  c650f1cf6c9f07b22e3e21ec7d49ded5  SCRATCH_MNT/test-128/file2
>  56ed2f712c91e035adeeb26ed105a982  SCRATCH_MNT/test-128/file3
> diff --git a/tests/xfs/132 b/tests/xfs/132
> index 79a6d57..9c57c3b 100755
> --- a/tests/xfs/132
> +++ b/tests/xfs/132
> @@ -87,32 +87,32 @@ for i in `seq 2 $nr`; do
>  done
>  _test_remount
>  free_blocks1=$(stat -f "$testdir" -c '%f')
> -lsattr -l $testdir/ | _filter_test_dir
> +lsattr -l $testdir/ | _filter_test_dir | _filter_spaces
>  
>  echo "funshare part of a file"
>  "$XFS_IO_PROG" -f -c "falloc 0 $((sz / 2))" "$testdir/file2"
>  _test_remount
> -lsattr -l $testdir/ | _filter_test_dir
> +lsattr -l $testdir/ | _filter_test_dir | _filter_spaces
>  
>  echo "funshare some of the copies"
>  "$XFS_IO_PROG" -f -c "falloc 0 $sz" "$testdir/file2"
>  "$XFS_IO_PROG" -f -c "falloc 0 $sz" "$testdir/file3"
>  _test_remount
>  free_blocks2=$(stat -f "$testdir" -c '%f')
> -lsattr -l $testdir/ | _filter_test_dir
> +lsattr -l $testdir/ | _filter_test_dir | _filter_spaces
>  
>  echo "funshare the rest of the files"
>  "$XFS_IO_PROG" -f -c "falloc 0 $sz" "$testdir/file4"
>  "$XFS_IO_PROG" -f -c "falloc 0 $sz" "$testdir/file1"
>  _test_remount
>  free_blocks3=$(stat -f "$testdir" -c '%f')
> -lsattr -l $testdir/ | _filter_test_dir
> +lsattr -l $testdir/ | _filter_test_dir | _filter_spaces
>  
>  echo "Rewrite the original file"
>  _pwrite_byte 0x65 0 $sz "$testdir/file1" >> "$seqres.full"
>  _test_remount
>  free_blocks4=$(stat -f "$testdir" -c '%f')
> -lsattr -l $testdir/ | _filter_test_dir
> +lsattr -l $testdir/ | _filter_test_dir | _filter_spaces
>  #echo $free_blocks0 $free_blocks1 $free_blocks2 $free_blocks3 $free_blocks4
>  
>  _within_tolerance "free blocks after reflinking" $free_blocks1 $((free_blocks0 - blks)) $margin -v
> diff --git a/tests/xfs/132.out b/tests/xfs/132.out
> index fd2b7bd..f32db7d 100644
> --- a/tests/xfs/132.out
> +++ b/tests/xfs/132.out
> @@ -1,30 +1,30 @@
>  QA output created by 132
>  Create the original file blocks
>  Create the reflink copies
> -TEST_DIR/test-132/file1          ---
> -TEST_DIR/test-132/file2          ---
> -TEST_DIR/test-132/file3          ---
> -TEST_DIR/test-132/file4          ---
> +TEST_DIR/test-132/file1 ---
> +TEST_DIR/test-132/file2 ---
> +TEST_DIR/test-132/file3 ---
> +TEST_DIR/test-132/file4 ---
>  funshare part of a file
> -TEST_DIR/test-132/file1          ---
> -TEST_DIR/test-132/file2          ---
> -TEST_DIR/test-132/file3          ---
> -TEST_DIR/test-132/file4          ---
> +TEST_DIR/test-132/file1 ---
> +TEST_DIR/test-132/file2 ---
> +TEST_DIR/test-132/file3 ---
> +TEST_DIR/test-132/file4 ---
>  funshare some of the copies
> -TEST_DIR/test-132/file1          ---
> -TEST_DIR/test-132/file2          No_COW
> -TEST_DIR/test-132/file3          No_COW
> -TEST_DIR/test-132/file4          ---
> +TEST_DIR/test-132/file1 ---
> +TEST_DIR/test-132/file2 No_COW
> +TEST_DIR/test-132/file3 No_COW
> +TEST_DIR/test-132/file4 ---
>  funshare the rest of the files
> -TEST_DIR/test-132/file1          No_COW
> -TEST_DIR/test-132/file2          No_COW
> -TEST_DIR/test-132/file3          No_COW
> -TEST_DIR/test-132/file4          No_COW
> +TEST_DIR/test-132/file1 No_COW
> +TEST_DIR/test-132/file2 No_COW
> +TEST_DIR/test-132/file3 No_COW
> +TEST_DIR/test-132/file4 No_COW
>  Rewrite the original file
> -TEST_DIR/test-132/file1          No_COW
> -TEST_DIR/test-132/file2          No_COW
> -TEST_DIR/test-132/file3          No_COW
> -TEST_DIR/test-132/file4          No_COW
> +TEST_DIR/test-132/file1 No_COW
> +TEST_DIR/test-132/file2 No_COW
> +TEST_DIR/test-132/file3 No_COW
> +TEST_DIR/test-132/file4 No_COW
>  free blocks after reflinking is in range
>  free blocks after nocow'ing some copies is in range
>  free blocks after nocow'ing all copies is in range
> -- 
> 2.1.4
> 

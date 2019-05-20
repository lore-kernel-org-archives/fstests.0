Received: from userp2130.oracle.com ([156.151.31.86]:60678 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbfETOdG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 20 May 2019 10:33:06 -0400
Date: Mon, 20 May 2019 07:32:46 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] tests/generic/54{0..3}: redirect FILEFRAG error output
 to .full too
Message-ID: <20190520143246.GI5352@magnolia>
References: <20190520062818.12421-1-xzhou@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520062818.12421-1-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Murphy Zhou <xzhou@redhat.com>
Cc: fstests@vger.kernel.org, linux-nfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, May 20, 2019 at 02:28:18PM +0800, Murphy Zhou wrote:
> NFSv4.2 supports reflink but does not support FIBMAP. These 4 tests
> about file content can pass on NFSv4.2, but FILEFRAG complaint :
> +/mnt/testarea/scratch/test-542/file2: FIBMAP unsupported
> is breaking golden output.
> 
> Signed-off-by: Murphy Zhou <xzhou@redhat.com>

Looks ok to me,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  tests/generic/540 | 8 ++++----
>  tests/generic/541 | 8 ++++----
>  tests/generic/542 | 8 ++++----
>  tests/generic/543 | 8 ++++----
>  4 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/tests/generic/540 b/tests/generic/540
> index 65a71f22..dc4d9485 100755
> --- a/tests/generic/540
> +++ b/tests/generic/540
> @@ -72,16 +72,16 @@ _weave_reflink_rainbow_delalloc $blksz $nr $testdir/file3 >> $seqres.full
>  
>  # now reflink into the rainbow
>  echo "before reflink" >> $seqres.full
> -$FILEFRAG_PROG -v $testdir/file2 >> $seqres.full
> -$FILEFRAG_PROG -v $testdir/file3 >> $seqres.full
> +$FILEFRAG_PROG -v $testdir/file2 >> $seqres.full 2>&1
> +$FILEFRAG_PROG -v $testdir/file3 >> $seqres.full 2>&1
>  $XFS_IO_PROG -f -c "reflink $testdir/file2 $roff $roff $rsz" $testdir/file3 >> $seqres.full
>  _pwrite_byte 0x64 $roff $rsz $testdir/file3.chk >> $seqres.full
>  _scratch_cycle_mount
>  
>  echo "Compare files"
>  echo "after reflink" >> $seqres.full
> -$FILEFRAG_PROG -v $testdir/file2 >> $seqres.full
> -$FILEFRAG_PROG -v $testdir/file3 >> $seqres.full
> +$FILEFRAG_PROG -v $testdir/file2 >> $seqres.full 2>&1
> +$FILEFRAG_PROG -v $testdir/file3 >> $seqres.full 2>&1
>  md5sum $testdir/file1 | _filter_scratch
>  md5sum $testdir/file2 | _filter_scratch
>  md5sum $testdir/file3 | _filter_scratch
> diff --git a/tests/generic/541 b/tests/generic/541
> index e7e19be4..fcb5d567 100755
> --- a/tests/generic/541
> +++ b/tests/generic/541
> @@ -74,8 +74,8 @@ _weave_reflink_rainbow_delalloc $blksz $nr $testdir/file3 >> $seqres.full
>  
>  # now reflink the rainbow
>  echo "before reflink" >> $seqres.full
> -$FILEFRAG_PROG -v $testdir/file2 >> $seqres.full
> -$FILEFRAG_PROG -v $testdir/file3 >> $seqres.full
> +$FILEFRAG_PROG -v $testdir/file2 >> $seqres.full 2>&1
> +$FILEFRAG_PROG -v $testdir/file3 >> $seqres.full 2>&1
>  $XFS_IO_PROG -f -c "reflink $testdir/file3 $roff $roff $rsz" $testdir/file2 >> $seqres.full
>  cp $testdir/file3.chk $testdir/file2.chk
>  _pwrite_byte 0x64 0 $roff $testdir/file2.chk >> $seqres.full
> @@ -84,8 +84,8 @@ _scratch_cycle_mount
>  
>  echo "Compare files"
>  echo "after reflink" >> $seqres.full
> -$FILEFRAG_PROG -v $testdir/file2 >> $seqres.full
> -$FILEFRAG_PROG -v $testdir/file3 >> $seqres.full
> +$FILEFRAG_PROG -v $testdir/file2 >> $seqres.full 2>&1
> +$FILEFRAG_PROG -v $testdir/file3 >> $seqres.full 2>&1
>  md5sum $testdir/file1 | _filter_scratch
>  md5sum $testdir/file2 | _filter_scratch
>  md5sum $testdir/file2.chk | _filter_scratch
> diff --git a/tests/generic/542 b/tests/generic/542
> index c416ab69..62b32cb5 100755
> --- a/tests/generic/542
> +++ b/tests/generic/542
> @@ -73,16 +73,16 @@ _weave_reflink_rainbow_delalloc $blksz $nr $testdir/file3 >> $seqres.full
>  
>  # now reflink into the rainbow
>  echo "before reflink" >> $seqres.full
> -$FILEFRAG_PROG -v $testdir/file2 >> $seqres.full
> -$FILEFRAG_PROG -v $testdir/file3 >> $seqres.full
> +$FILEFRAG_PROG -v $testdir/file2 >> $seqres.full 2>&1
> +$FILEFRAG_PROG -v $testdir/file3 >> $seqres.full 2>&1
>  $XFS_IO_PROG -f -c "reflink $testdir/file2 $soff $doff $rsz" $testdir/file3 >> $seqres.full
>  _pwrite_byte 0x64 $doff $rsz $testdir/file3.chk >> $seqres.full
>  _scratch_cycle_mount
>  
>  echo "Compare files"
>  echo "after reflink" >> $seqres.full
> -$FILEFRAG_PROG -v $testdir/file2 >> $seqres.full
> -$FILEFRAG_PROG -v $testdir/file3 >> $seqres.full
> +$FILEFRAG_PROG -v $testdir/file2 >> $seqres.full 2>&1
> +$FILEFRAG_PROG -v $testdir/file3 >> $seqres.full 2>&1
>  md5sum $testdir/file1 | _filter_scratch
>  md5sum $testdir/file2 | _filter_scratch
>  md5sum $testdir/file3 | _filter_scratch
> diff --git a/tests/generic/543 b/tests/generic/543
> index 50a51f89..cc7ee532 100755
> --- a/tests/generic/543
> +++ b/tests/generic/543
> @@ -75,8 +75,8 @@ _weave_reflink_rainbow_delalloc $blksz $nr $testdir/file3 >> $seqres.full
>  
>  # now reflink the rainbow
>  echo "before reflink" >> $seqres.full
> -$FILEFRAG_PROG -v $testdir/file2 >> $seqres.full
> -$FILEFRAG_PROG -v $testdir/file3 >> $seqres.full
> +$FILEFRAG_PROG -v $testdir/file2 >> $seqres.full 2>&1
> +$FILEFRAG_PROG -v $testdir/file3 >> $seqres.full 2>&1
>  $XFS_IO_PROG -f -c "reflink $testdir/file3 $soff $doff $rsz" $testdir/file2 >> $seqres.full
>  $XFS_IO_PROG -c "truncate $doff" $testdir/file2.chk
>  dd if=$testdir/file3.chk skip=$((soff / blksz)) count=$((rsz / blksz)) bs=$blksz >> $testdir/file2.chk 2> /dev/null
> @@ -84,8 +84,8 @@ _scratch_cycle_mount
>  
>  echo "Compare files"
>  echo "after reflink" >> $seqres.full
> -$FILEFRAG_PROG -v $testdir/file2 >> $seqres.full
> -$FILEFRAG_PROG -v $testdir/file3 >> $seqres.full
> +$FILEFRAG_PROG -v $testdir/file2 >> $seqres.full 2>&1
> +$FILEFRAG_PROG -v $testdir/file3 >> $seqres.full 2>&1
>  md5sum $testdir/file1 | _filter_scratch
>  md5sum $testdir/file2 | _filter_scratch
>  md5sum $testdir/file2.chk | _filter_scratch
> -- 
> 2.21.0
> 

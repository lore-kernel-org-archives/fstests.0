Received: from mx1.redhat.com ([209.132.183.28]:38178 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751130AbcI3JOj (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 30 Sep 2016 05:14:39 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 58480C057FA9
        for <fstests@vger.kernel.org>; Fri, 30 Sep 2016 09:14:39 +0000 (UTC)
Date: Fri, 30 Sep 2016 17:14:37 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v3] fstests: test xfs_copy V5 XFS without -d option
Message-ID: <20160930091437.GA27776@eguan.usersys.redhat.com>
References: <1475213020-17942-1-git-send-email-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1475213020-17942-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Sep 30, 2016 at 01:23:40PM +0800, Zorro Lang wrote:
> Before xfsprogs commit a872b62 (xfs_copy: band-aids for CRC
> filesystems), xfs_copy requires the "-d" option to copy a V5 XFS,
> because it can't rewrite the UUID of V5 XFS properly.
> 
> Now xfs_copy already full support to copy a V5 XFS. But for above
> old problem, xfstests use below patch to make sure xfs_copy always
> use "-d" option to copy a V5 XFS:
> 
>   8346e53 common: append -d option to XFS_COPY_PROG when testing v5 xfs
> 
> That cause xfstests miss the coverage of copying a V5 XFS without
> "-d". For test this feature I did below things:
> 
>   1. Change init_rc(), add "-d" to $XFS_COPY_PROG if xfs_copy can't
>      copy a V5 XFS properly.
>   2. xfs/073 test V4 xfs forcibly by specify "-m crc=0" in case. I
>      think it's useless now, so remove it.
>   3. remove the xfs_copy "-d" option from xfs/032

After thinking about it more, I think we lose "-d" coverage by doing so
in xfs/032. Perhaps we can do two rounds of xfs_copy test, one with "-d"
and one without it.

> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
> 
> Hi,
> 
> V2:
> 1. remove require_xfs_copy() function
> 2. change the code logic of init_rc function about how to add "-d" to
>    $XFS_COPY_PROG
> 3. remove xfs_copy "-d" option of xfs/032
> 
> V3 add comments to explain the change in init_rc()
> 
> Thanks,
> Zorro
> 
>  common/rc     | 15 ++++++++++++---
>  tests/xfs/032 |  2 +-
>  tests/xfs/073 |  8 ++------
>  3 files changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 13afc6a..b0183b2 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3790,9 +3790,18 @@ init_rc()
>  	xfs_io -c stat $TEST_DIR 2>&1 | grep -q "is not on an XFS filesystem" && \
>  	export XFS_IO_PROG="$XFS_IO_PROG -F"
>  
> -	# xfs_copy doesn't work on v5 xfs yet without -d option
> -	if [ "$FSTYP" == "xfs" ] && [[ $MKFS_OPTIONS =~ crc=1 ]]; then
> -		export XFS_COPY_PROG="$XFS_COPY_PROG -d"
> +	# xfs_copy on v5 filesystems do not require the "-d" option if xfs_db
> +	# can change the UUID on v5 filesystems
> +	if [ "$FSTYP" == "xfs" ]; then
> +		touch $tmp.img
> +		$MKFS_XFS_PROG $MKFS_OPTIONS -d file,name=$tmp.img,size=512m \

I don't think we need $MKFS_OPTIONS here.

> +							>/dev/null 2>/dev/null

Ah, ">/dev/null 2>/dev/null" not ">/dev/null 2>&1", that works too but
not commonly used in this way :)

Thanks,
Eryu

> +		# xfs_db will return 0 even if it can't generate a new uuid, so
> +		# check the output to make sure if it can change UUID of V5 xfs
> +		$XFS_DB_PROG -x -c "uuid generate" $tmp.img \
> +			| grep -q "invalid UUID\|supported on V5 fs" \
> +			&& export XFS_COPY_PROG="$XFS_COPY_PROG -d"
> +		rm -f $tmp.img
>  	fi
>  }
>  
> diff --git a/tests/xfs/032 b/tests/xfs/032
> index 6216379..0e41db8 100755
> --- a/tests/xfs/032
> +++ b/tests/xfs/032
> @@ -65,7 +65,7 @@ while [ $SECTORSIZE -le $PAGESIZE ]; do
>  		$FSSTRESS_PROG -n 100 -d $SCRATCH_MNT >> $seqres.full 2>&1
>  		_scratch_unmount
>  
> -		$XFS_COPY_PROG -d $SCRATCH_DEV $IMGFILE >> $seqres.full 2>&1 || \
> +		$XFS_COPY_PROG $SCRATCH_DEV $IMGFILE >> $seqres.full 2>&1 || \
>  			_fail "Copy failed for Sector size $SECTORSIZE Block size $BLOCKSIZE"
>  		# Must use "-n" to get exit code; without it xfs_repair always returns 0
>  		$XFS_REPAIR_PROG -n -f $IMGFILE >> $seqres.full 2>&1 || \
> diff --git a/tests/xfs/073 b/tests/xfs/073
> index 9e29223..7228dd9 100755
> --- a/tests/xfs/073
> +++ b/tests/xfs/073
> @@ -138,7 +138,7 @@ _require_loop
>  
>  rm -f $seqres.full
>  
> -_scratch_mkfs_xfs -m crc=0 -dsize=41m,agcount=2 >>$seqres.full 2>&1
> +_scratch_mkfs_xfs -dsize=41m,agcount=2 >>$seqres.full 2>&1
>  _scratch_mount 2>/dev/null || _fail "initial scratch mount failed"
>  
>  echo
> @@ -158,11 +158,7 @@ _verify_copy $imgs.image $SCRATCH_DEV $SCRATCH_MNT
>  
>  echo 
>  echo === copying scratch device to single target, large ro device
> -mkfs_crc_opts="-m crc=0"
> -if [ -n "$XFS_MKFS_HAS_NO_META_SUPPORT" ]; then
> -	mkfs_crc_opts=""
> -fi
> -${MKFS_XFS_PROG} $mkfs_crc_opts -dfile,name=$imgs.source,size=100g \
> +${MKFS_XFS_PROG} -dfile,name=$imgs.source,size=100g \
>  	| _filter_mkfs 2>/dev/null
>  rmdir $imgs.source_dir 2>/dev/null
>  mkdir $imgs.source_dir
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

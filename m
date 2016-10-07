Received: from mx1.redhat.com ([209.132.183.28]:43084 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755475AbcJGMYk (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 7 Oct 2016 08:24:40 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 312DEC05A291
        for <fstests@vger.kernel.org>; Fri,  7 Oct 2016 12:24:40 +0000 (UTC)
Date: Fri, 7 Oct 2016 20:24:38 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfs/078: use loopback device to instead of file image
Message-ID: <20161007122438.GJ27776@eguan.usersys.redhat.com>
References: <1475423238-15881-1-git-send-email-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1475423238-15881-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Oct 02, 2016 at 11:47:18PM +0800, Zorro Lang wrote:
> If test on 4k sector size device, xfs/078 will fail when it try to
> make a filesystem image with block size less than 4096. But if we
> attach the file image to a loop device, it can accept 512 block
> size. So this patch attach a loop device before do mkfs.xfs.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
>  tests/xfs/078     | 51 +++++++++++++++++++++++++++++----------------------
>  tests/xfs/078.out | 16 ++++++++--------
>  2 files changed, 37 insertions(+), 30 deletions(-)
> 
> diff --git a/tests/xfs/078 b/tests/xfs/078
> index 0d6eb55..374d30c 100755
> --- a/tests/xfs/078
> +++ b/tests/xfs/078
> @@ -34,11 +34,14 @@ trap "_cleanup; rm -f $tmp.*; exit \$status" 0 1 2 3 15
>  
>  _cleanup()
>  {
> -    cd /
> -    rm -f $tmp.*
> -    umount $LOOP_MNT 2>/dev/null
> -    [ -n "$LOOP_DEV" ] && losetup -d $LOOP_DEV
> -    rmdir $LOOP_MNT
> +	cd /
> +	rm -f $tmp.*
> +	umount $LOOP_MNT 2>/dev/null
> +	if [ -n "$LOOP_DEV" ]; then
> +		_destroy_loop_device $LOOP_DEV
> +		rm -f $LOOP_IMG
> +	fi
> +	rmdir $LOOP_MNT
>  }
>  
>  # get standard environment, filters and checks
> @@ -52,6 +55,8 @@ _supported_os Linux
>  _require_test
>  # Must have loop device
>  _require_loop
> +_require_xfs_io_command "truncate"
> +_require_xfs_io_command "pwrite"

I don't think this is needed, truncate and pwrite are the basic
commands and should be always available.

>  
>  LOOP_IMG=$TEST_DIR/$seq.fs
>  LOOP_MNT=$TEST_DIR/$seq.mnt
> @@ -77,9 +82,12 @@ _grow_loop()
>  	check=$4
>  	agsize=$5
>  
> -	dparam="file,name=$LOOP_IMG,size=$original"
> +	$XFS_IO_PROG -f -c "truncate $original" $LOOP_IMG
> +	LOOP_DEV=`_create_loop_device $LOOP_IMG`
> +
> +	dparam=""
>  	if [ -n "$agsize" ]; then
> -		dparam="$dparam,agsize=$agsize"
> +		dparam="-d agsize=$agsize"
>  	fi
>  
>  	echo
> @@ -87,20 +95,21 @@ _grow_loop()
>  	echo
>  
>  	echo "*** mkfs loop file (size=$original)"
> -	mkfs_crc_opts="-m crc=0"
> -	if [ -n "$XFS_MKFS_HAS_NO_META_SUPPORT" ]; then
> -		mkfs_crc_opts=""
> +	mkfs_crc_opts=""
> +	if [ $bsize -lt 1024 -a -z "$XFS_MKFS_HAS_NO_META_SUPPORT" ]; then
> +		mkfs_crc_opts="-m crc=0"
>  	fi

This hunk enables growfs tests on v5 XFS, and should be in a separate
patch.

> -	$MKFS_XFS_PROG $mkfs_crc_opts -b size=$bsize -d $dparam \
> +	$MKFS_XFS_PROG $mkfs_crc_opts -b size=$bsize $dparam $LOOP_DEV \
>  		| _filter_mkfs 2>/dev/null
>  
>  	echo "*** extend loop file"
> +	_destroy_loop_device $LOOP_DEV
>  	$XFS_IO_PROG -c "pwrite $new_size $bsize" $LOOP_IMG | _filter_io
> +	LOOP_DEV=`_create_loop_device $LOOP_IMG`
>  	echo "*** mount loop filesystem"
> -	mount -t xfs -o loop $LOOP_IMG $LOOP_MNT
> +	mount -t xfs $LOOP_DEV $LOOP_MNT
>  
>  	echo "*** grow loop filesystem"
> -	#xfs_growfs $LOOP_MNT 2>&1 | grep -e "^data" #| _filter_growfs 2>/dev/null
>  	$XFS_GROWFS_PROG $LOOP_MNT 2>&1 |  _filter_growfs 2>&1
>  
>  	echo "*** unmount"
> @@ -110,23 +119,21 @@ _grow_loop()
>  	if [ "$check" -gt "0" ]
>  	then
>  		echo "*** check"
> -		LOOP_DEV=`losetup -f`
> -		losetup $LOOP_DEV $LOOP_IMG
> -		 _check_xfs_filesystem $LOOP_DEV none none
> -		losetup -d $LOOP_DEV
> -		LOOP_DEV=
> +		_check_xfs_filesystem $LOOP_DEV none none
>  	fi
>  
> +	_destroy_loop_device $LOOP_DEV
> +	LOOP_DEV=
>  	rm -f $LOOP_IMG
>  }
>  
>  # Wes' problem sizes...
> -_grow_loop 168024b 1376452608 4096 1
> +_grow_loop $((168024*4096)) 1376452608 4096 1
>  
>  # Some other blocksize cases...
> -_grow_loop 168024b 1376452608 2048 1
> -_grow_loop 168024b 1376452608 512 1 16m
> -_grow_loop 168024b 688230400 1024 1
> +_grow_loop $((168024*2048)) 1376452608 2048 1
> +_grow_loop $((168024*512)) 1376452608 512 1 16m
> +_grow_loop $((168024*1024)) 688230400 1024 1

Why changing the initial fs size in the tests?

Thanks,
Eryu

>  
>  # Other corner cases suggested by dgc
>  # also the following doesn't check if the filesystem is consistent.
> diff --git a/tests/xfs/078.out b/tests/xfs/078.out
> index 4d294aa..cc3c47d 100644
> --- a/tests/xfs/078.out
> +++ b/tests/xfs/078.out
> @@ -1,9 +1,9 @@
>  QA output created by 078
>  *** create loop mount point
>  
> -=== GROWFS (from 168024b to 1376452608, 4096 blocksize)
> +=== GROWFS (from 688226304 to 1376452608, 4096 blocksize)
>  
> -*** mkfs loop file (size=168024b)
> +*** mkfs loop file (size=688226304)
>  meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks
>  data     = bsize=XXX blocks=XXX, imaxpct=PCT
>           = sunit=XXX swidth=XXX, unwritten=X
> @@ -19,9 +19,9 @@ data blocks changed from 168024 to 336048
>  *** unmount
>  *** check
>  
> -=== GROWFS (from 168024b to 1376452608, 2048 blocksize)
> +=== GROWFS (from 344113152 to 1376452608, 2048 blocksize)
>  
> -*** mkfs loop file (size=168024b)
> +*** mkfs loop file (size=344113152)
>  meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks
>  data     = bsize=XXX blocks=XXX, imaxpct=PCT
>           = sunit=XXX swidth=XXX, unwritten=X
> @@ -37,9 +37,9 @@ data blocks changed from 168024 to 672096
>  *** unmount
>  *** check
>  
> -=== GROWFS (from 168024b to 1376452608, 512 blocksize)
> +=== GROWFS (from 86028288 to 1376452608, 512 blocksize)
>  
> -*** mkfs loop file (size=168024b)
> +*** mkfs loop file (size=86028288)
>  meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks
>  data     = bsize=XXX blocks=XXX, imaxpct=PCT
>           = sunit=XXX swidth=XXX, unwritten=X
> @@ -55,9 +55,9 @@ data blocks changed from 163840 to 2688384
>  *** unmount
>  *** check
>  
> -=== GROWFS (from 168024b to 688230400, 1024 blocksize)
> +=== GROWFS (from 172056576 to 688230400, 1024 blocksize)
>  
> -*** mkfs loop file (size=168024b)
> +*** mkfs loop file (size=172056576)
>  meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks
>  data     = bsize=XXX blocks=XXX, imaxpct=PCT
>           = sunit=XXX swidth=XXX, unwritten=X
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

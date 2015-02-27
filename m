Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32817 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751693AbbB0S5E (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 27 Feb 2015 13:57:04 -0500
Date: Fri, 27 Feb 2015 13:56:59 -0500
From: Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH 3/4] xfs/049: umount -d fails when kernel wins teardown
 race
Message-ID: <20150227185659.GB17531@laptop.bfoster>
References: <1424818479-10083-1-git-send-email-david@fromorbit.com>
 <1424818479-10083-4-git-send-email-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1424818479-10083-4-git-send-email-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Feb 25, 2015 at 09:54:38AM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> When /etc/mtab is linked to /proc/mounts and we are using mount time
> created loop devices (i.e. mount -o loop), the unmount can fail
> with this amazingly informative error message:
> 
> umount: /mnt/scratch/test2: filesystem was unmounted, but mount(8) failed: Invalid argument
> 
> What it actually means in this case is that the kernel tore down the
> loop device when the last reference went away, and it did it so fast
> that mount was not able to find it in /etc/mtab after the unmount
> syscall. Hence it could not find the loop device it was supposed to
> tear down and has a hissy fit.
> 
> This is simple to fix: mount does not need to tear down the loop
> device as the kernel does it automatically. Remove the "-d" from
> the umount command, and the test passes again.
> 
> There's quite a few other tests that also use umount -d - fix them
> as well.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  tests/xfs/049 | 8 ++++----
>  tests/xfs/073 | 6 +++---
>  tests/xfs/078 | 4 ++--
>  tests/xfs/216 | 2 +-
>  tests/xfs/217 | 2 +-
>  tests/xfs/250 | 4 ++--
>  6 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/tests/xfs/049 b/tests/xfs/049
> index 04c2c75..8d4e074 100755
> --- a/tests/xfs/049
> +++ b/tests/xfs/049
> @@ -29,8 +29,8 @@ echo "QA output created by $seq"
>  _cleanup()
>  {
>      cd /
> -    umount -d $SCRATCH_MNT/test2 > /dev/null 2>&1
> -    umount -d $SCRATCH_MNT/test > /dev/null 2>&1
> +    umount $SCRATCH_MNT/test2 > /dev/null 2>&1
> +    umount $SCRATCH_MNT/test > /dev/null 2>&1
>      rm -f $tmp.*
>  
>      if [ -w $seqres.full ]
> @@ -123,11 +123,11 @@ rm -rf $SCRATCH_MNT/test/* >> $seqres.full 2>&1 \
>      || _fail "!!! clean failed"
>  
>  _log "umount ext2 on xfs"
> -umount -d $SCRATCH_MNT/test2 >> $seqres.full 2>&1 \
> +umount $SCRATCH_MNT/test2 >> $seqres.full 2>&1 \
>      || _fail "!!! umount ext2 failed"
>  
>  _log "umount xfs"
> -umount -d $SCRATCH_MNT/test >> $seqres.full 2>&1 \
> +umount $SCRATCH_MNT/test >> $seqres.full 2>&1 \
>      || _fail "!!! umount xfs failed"
>  
>  echo "--- mounts at end (before cleanup)" >> $seqres.full
> diff --git a/tests/xfs/073 b/tests/xfs/073
> index f955771..38ed2cb 100755
> --- a/tests/xfs/073
> +++ b/tests/xfs/073
> @@ -41,9 +41,9 @@ _cleanup()
>  {
>  	cd /
>  	umount $SCRATCH_MNT 2>/dev/null
> -	umount -d $imgs.loop 2>/dev/null
> +	umount $imgs.loop 2>/dev/null
>  	[ -d $imgs.loop ] && rmdir $imgs.loop
> -	umount -d $imgs.source_dir 2>/dev/null
> +	umount $imgs.source_dir 2>/dev/null
>  	[ -d $imgs.source_dir ] && rm -rf $imgs.source_dir
>  	rm -f $imgs.* $tmp.* /var/tmp/xfs_copy.log.*
>  }
> @@ -119,7 +119,7 @@ _verify_copy()
>  
>  	echo unmounting and removing new image
>  	umount $source_dir
> -	umount -d $target_dir > /dev/null 2>&1
> +	umount $target_dir > /dev/null 2>&1
>  	rm -f $target
>  }
>  
> diff --git a/tests/xfs/078 b/tests/xfs/078
> index f859efc..d8cb919 100755
> --- a/tests/xfs/078
> +++ b/tests/xfs/078
> @@ -36,7 +36,7 @@ _cleanup()
>  {
>      cd /
>      rm -f $tmp.*
> -    umount -d $LOOP_MNT 2>/dev/null
> +    umount $LOOP_MNT 2>/dev/null
>      rmdir $LOOP_MNT
>  }
>  
> @@ -97,7 +97,7 @@ _grow_loop()
>  	$XFS_GROWFS_PROG $LOOP_MNT 2>&1 |  _filter_growfs 2>&1
>  
>  	echo "*** unmount"
> -	umount -d $LOOP_MNT > /dev/null 2>&1
> +	umount $LOOP_MNT > /dev/null 2>&1
>  
>  	# Large grows takes forever to check..
>  	if [ "$check" -gt "0" ]
> diff --git a/tests/xfs/216 b/tests/xfs/216
> index 8513479..76f79ca 100755
> --- a/tests/xfs/216
> +++ b/tests/xfs/216
> @@ -60,7 +60,7 @@ _do_mkfs()
>  			-d name=$LOOP_DEV,size=${i}g |grep log
>  		mount -o loop -t xfs $LOOP_DEV $LOOP_MNT
>  		echo "test write" > $LOOP_MNT/test
> -		umount -d $LOOP_MNT > /dev/null 2>&1
> +		umount $LOOP_MNT > /dev/null 2>&1
>  	done
>  }
>  # make large holey file
> diff --git a/tests/xfs/217 b/tests/xfs/217
> index ab55a30..8aacdf9 100755
> --- a/tests/xfs/217
> +++ b/tests/xfs/217
> @@ -62,7 +62,7 @@ _do_mkfs()
>  			-d name=$LOOP_DEV,size=${i}g |grep log
>  		mount -o loop -t xfs $LOOP_DEV $LOOP_MNT
>  		echo "test write" > $LOOP_MNT/test
> -		umount -d $LOOP_MNT > /dev/null 2>&1
> +		umount $LOOP_MNT > /dev/null 2>&1
>  
>  		# punch out the previous blocks so that we keep the amount of
>  		# disk space the test requires down to a minimum.
> diff --git a/tests/xfs/250 b/tests/xfs/250
> index c1622a4..0cdc382 100755
> --- a/tests/xfs/250
> +++ b/tests/xfs/250
> @@ -33,7 +33,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  _cleanup()
>  {
>  	cd /
> -	umount -d $LOOP_MNT 2>/dev/null
> +	umount $LOOP_MNT 2>/dev/null
>  	rm -f $LOOP_DEV
>  	rmdir $LOOP_MNT
>  }
> @@ -84,7 +84,7 @@ _test_loop()
>  	xfs_io -f -c "resvsp 0 $fsize" $LOOP_MNT/foo | _filter_io
>  
>  	echo "*** unmount loop filesystem"
> -	umount -d $LOOP_MNT > /dev/null 2>&1
> +	umount $LOOP_MNT > /dev/null 2>&1
>  
>  	echo "*** check loop filesystem"
>  	 _check_xfs_filesystem $LOOP_DEV none none
> -- 
> 2.0.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

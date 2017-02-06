Received: from mx1.redhat.com ([209.132.183.28]:59038 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750873AbdBFEUr (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 5 Feb 2017 23:20:47 -0500
Date: Mon, 6 Feb 2017 12:20:45 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] fstests: btrfs: Use compressible data
Message-ID: <20170206042045.GJ1859@eguan.usersys.redhat.com>
References: <20170201135028.1727-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170201135028.1727-1-anand.jain@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Feb 01, 2017 at 09:50:28PM +0800, Anand Jain wrote:
> /dev/urandom is incompressible and, /dev/zero is highly compressible,
> so both are less effective in testing the compress code logic in btrfs.
> 
> This patch introduces a text data generator
>  cat /dev/urandom | od

I noticed that the similar patterns appear many times:

cat /dev/urandom | od | dd <dd params> | _filter_dd

I'm wondering if this could be done in a new helper?

Thanks,
Eryu

> to populate the files where /dev/urandom is currently being used in the
> btrfs test cases.
> 
> And updates the _populate_fs() with a new option -c, so to instruct
> to use the compressible data to populate the file(s).
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  common/rc       |  9 ++++++---
>  tests/btrfs/002 |  6 +++---
>  tests/btrfs/003 |  4 ++--
>  tests/btrfs/008 |  4 ++--
>  tests/btrfs/011 | 11 ++++-------
>  tests/btrfs/016 |  2 +-
>  tests/btrfs/022 |  6 ++++--
>  tests/btrfs/027 |  6 +++---
>  8 files changed, 25 insertions(+), 23 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 862bc048de46..022dc202aaf5 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2424,7 +2424,9 @@ _nfiles()
>                  if [ $size -gt 0 ]; then
>                      if [ "$2" == "false" ]; then
>                          dd if=/dev/zero of=$file bs=1024 count=$size 2>&1 | _filter_dd
> -                    else
> +                    elif [ "$2" == "comp" ]; then
> +                        cat /dev/urandom | od | dd iflag=fullblock of=$file bs=1024 count=$size 2>&1 | _filter_dd
> +		    else
>                          dd if=/dev/urandom of=$file bs=1024 count=$size 2>&1 | _filter_dd
>                      fi
>                  fi
> @@ -2468,10 +2470,10 @@ _populate_fs()
>      depth=2         # depth of tree from root to leaves
>      verbose=false
>      root=root       # path of initial root of directory tree
> -    randomdata=false # -x data type urandom or zero
> +    randomdata=false # -x data type urandom, zero or compressible
>  
>      OPTIND=1
> -    while getopts "d:f:n:r:s:v:x" c
> +    while getopts "d:f:n:r:s:v:x:c" c
>      do
>          case $c in
>          d)      depth=$OPTARG;;
> @@ -2481,6 +2483,7 @@ _populate_fs()
>          v)      verbose=true;;
>          r)      root=$OPTARG;;
>          x)      randomdata=true;;
> +        c)      randomdata=comp;;
>          esac
>      done
>  
> diff --git a/tests/btrfs/002 b/tests/btrfs/002
> index fce5d955dfa3..6a44c832e1b5 100755
> --- a/tests/btrfs/002
> +++ b/tests/btrfs/002
> @@ -92,7 +92,7 @@ _read_modify_write()
>  	do
>  		FSIZE=`stat -t $i | cut -d" " -f2`
>  		dd if=$i of=/dev/null obs=$FSIZE count=1 status=noxfer 2>/dev/null &
> -		dd if=/dev/urandom of=$i obs=$FSIZE count=1 status=noxfer 2>/dev/null &
> +		cat /dev/urandom | od | dd iflag=fullblock of=$i obs=$FSIZE count=1 status=noxfer 2>/dev/null &
>  	done
>  	wait $!
>  }
> @@ -114,7 +114,7 @@ _fill_blk()
>  		NBLK=`stat -c "%b" $i`
>  		FALLOC=$(($BLKS * $NBLK))
>  		WS=$(($FALLOC - $FSIZE))
> -		dd if=/dev/urandom of=$i oseek=$FSIZE obs=$WS count=1 status=noxfer 2>/dev/null &
> +		cat /dev/urandom | od | dd of=$i oseek=$FSIZE obs=$WS count=1 status=noxfer 2>/dev/null &
>  	done
>  	wait $!
>  }
> @@ -149,7 +149,7 @@ _append_file()
>  firstvol="$SCRATCH_MNT/sv1"
>  $BTRFS_UTIL_PROG subvolume create $firstvol > /dev/null || _fail "btrfs subvolume create $firstvol failed"
>  dirp=`mktemp -duq $firstvol/dir.XXXXXX`
> -_populate_fs -n 1 -f 20 -d 10 -r $dirp -s 10 -x
> +_populate_fs -n 1 -f 20 -d 10 -r $dirp -s 10 -c
>  SNAPNAME=0
>  _create_snap $firstvol
>  _save_checksum $firstvol $tmp.sv1.sum
> diff --git a/tests/btrfs/003 b/tests/btrfs/003
> index 51cff4644186..3ec3a2d9f998 100755
> --- a/tests/btrfs/003
> +++ b/tests/btrfs/003
> @@ -62,7 +62,7 @@ _test_raid0()
>  	_scratch_pool_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
>  	_scratch_mount
>  	dirp=`mktemp -duq $SCRATCH_MNT/dir.XXXXXX`
> -	_populate_fs -n 1 -f 20 -d 10 -r $dirp -s 10
> +	_populate_fs -n 1 -f 20 -d 10 -r $dirp -s 10 -c
>  	_scratch_unmount
>  }
>  
> @@ -72,7 +72,7 @@ _test_raid1()
>  	_scratch_pool_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
>  	_scratch_mount
>  	dirp=`mktemp -duq $SCRATCH_MNT/dir.XXXXXX`
> -	_populate_fs -n 1 -f 20 -d 10 -r $dirp -s 10
> +	_populate_fs -n 1 -f 20 -d 10 -r $dirp -s 10 -c
>  	_scratch_unmount
>  }
>  
> diff --git a/tests/btrfs/008 b/tests/btrfs/008
> index 019af0415d18..2c9fe11890cf 100755
> --- a/tests/btrfs/008
> +++ b/tests/btrfs/008
> @@ -69,8 +69,8 @@ work_dir="$TEST_DIR/$tmp_dir/send"
>  mkdir $work_dir/testdir
>  mkdir $work_dir/testdir/1/
>  mkdir $work_dir/testdir/2/
> -dd if=/dev/urandom  of=$work_dir/testdir/aa count=16 > /dev/null 2>&1
> -dd if=/dev/urandom  of=$work_dir/testdir/bb count=16 > /dev/null 2>&1
> +cat /dev/urandom | od | dd iflag=fullblock of=$work_dir/testdir/aa count=16 > /dev/null 2>&1
> +cat /dev/urandom | od | dd iflag=fullblock of=$work_dir/testdir/bb count=16 > /dev/null 2>&1
>  
>  mkdir $work_dir/snapshots
>  $BTRFS_UTIL_PROG subvolume snapshot -r $work_dir $work_dir/snapshots/backup2 \
> diff --git a/tests/btrfs/011 b/tests/btrfs/011
> index 918742717528..202fb41485e2 100755
> --- a/tests/btrfs/011
> +++ b/tests/btrfs/011
> @@ -123,15 +123,12 @@ workout()
>  	# 20K extents in the data chunk and fill up metadata with inline
>  	# extents.
>  	for i in `seq 1 500`; do
> -		dd if=/dev/urandom of=$SCRATCH_MNT/l$i bs=16385 count=1
> -		dd if=/dev/urandom of=$SCRATCH_MNT/s$i bs=3800 count=1
> +		cat /dev/urandom | od | dd iflag=fullblock of=$SCRATCH_MNT/l$i bs=16385 count=1
> +		cat /dev/urandom | od | dd iflag=fullblock of=$SCRATCH_MNT/s$i bs=3800 count=1
>  	done > /dev/null 2>&1
>  
> -	# /dev/urandom is slow but has the benefit that the generated
> -	# contents does not shrink during compression.
>  	# Generate a template once and quickly copy it multiple times.
> -	# Obviously with online deduplication this will not work anymore.
> -	dd if=/dev/urandom of=$SCRATCH_MNT/t0 bs=1M count=1 > /dev/null 2>&1
> +	cat /dev/urandom | od | dd iflag=fullblock of=$SCRATCH_MNT/t0 bs=1M count=1 > /dev/null 2>&1
>  
>  	if [ "${quick}Q" = "thoroughQ" ]; then
>  		# The intention of this "thorough" test is to increase
> @@ -220,7 +217,7 @@ btrfs_replace_test()
>  	# generate some (slow) background traffic in parallel to the
>  	# replace operation. It is not a problem if cat fails early
>  	# with ENOSPC.
> -	cat /dev/urandom > $SCRATCH_MNT/noise 2>> $seqres.full &
> +	cat /dev/urandom | od > $SCRATCH_MNT/noise 2>> $seqres.full &
>  	noise_pid=$!
>  
>  	if [ "${with_cancel}Q" = "cancelQ" ]; then
> diff --git a/tests/btrfs/016 b/tests/btrfs/016
> index c8fc70892394..03f030410358 100755
> --- a/tests/btrfs/016
> +++ b/tests/btrfs/016
> @@ -66,7 +66,7 @@ mkdir $TEST_DIR/$tmp_dir
>  $BTRFS_UTIL_PROG subvolume create $TEST_DIR/$tmp_dir/send \
>  	> $seqres.full 2>&1 || _fail "failed subvolume create"
>  
> -dd if=/dev/urandom of=$TEST_DIR/$tmp_dir/send/foo bs=1M count=10 >> $seqres.full \
> +cat /dev/urandom | od | dd iflag=fullblock of=$TEST_DIR/$tmp_dir/send/foo bs=1M count=10 >> $seqres.full \
>  	2>&1 || _fail "dd failed"
>  $BTRFS_UTIL_PROG subvolume snapshot -r $TEST_DIR/$tmp_dir/send \
>  	$TEST_DIR/$tmp_dir/snap >> $seqres.full 2>&1 || _fail "failed snap"
> diff --git a/tests/btrfs/022 b/tests/btrfs/022
> index 9abad6c99099..713e42146853 100755
> --- a/tests/btrfs/022
> +++ b/tests/btrfs/022
> @@ -103,7 +103,8 @@ _limit_test_exceed()
>  	_run_btrfs_util_prog quota enable $SCRATCH_MNT
>  	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT a)
>  	_run_btrfs_util_prog qgroup limit 5M 0/$subvolid $SCRATCH_MNT
> -	dd if=/dev/urandom of=$SCRATCH_MNT/a/file bs=10M count=1 >> \
> +	cat /dev/urandom | od | \
> +		dd iflag=fullblock of=$SCRATCH_MNT/a/file bs=10M count=1 >> \
>  		$seqres.full 2>&1
>  	[ $? -ne 0 ] || _fail "quota should have limited us"
>  }
> @@ -115,7 +116,8 @@ _limit_test_noexceed()
>  	_run_btrfs_util_prog quota enable $SCRATCH_MNT
>  	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT a)
>  	_run_btrfs_util_prog qgroup limit 5M 0/$subvolid $SCRATCH_MNT
> -	dd if=/dev/urandom of=$SCRATCH_MNT/a/file bs=4M count=1 >> \
> +	cat /dev/urandom | od | \
> +		dd iflag=fullblock of=$SCRATCH_MNT/a/file bs=4M count=1 >> \
>  		$seqres.full 2>&1
>  	[ $? -eq 0 ] || _fail "should have been allowed to write"
>  }
> diff --git a/tests/btrfs/027 b/tests/btrfs/027
> index 8cc2e8cb8264..a3d152db8b9b 100755
> --- a/tests/btrfs/027
> +++ b/tests/btrfs/027
> @@ -81,11 +81,11 @@ run_test()
>  	local missing_dev_id=`$BTRFS_UTIL_PROG fi show $SCRATCH_MNT | grep $missing_dev | awk '{print $2}'`
>  
>  	# get some data on the filesystem so there's something to replace
> -	dd if=/dev/urandom of="$SCRATCH_MNT"/file1 bs=1M count=1 \
> +	cat /dev/urandom | od | dd iflag=fullblock of="$SCRATCH_MNT"/file1 bs=1M count=1 \
>  		>>$seqres.full 2>&1
> -	dd if=/dev/urandom of="$SCRATCH_MNT"/file2 bs=1M count=2 \
> +	cat /dev/urandom | od | dd iflag=fullblock of="$SCRATCH_MNT"/file2 bs=1M count=2 \
>  		>>$seqres.full 2>&1
> -	dd if=/dev/urandom of="$SCRATCH_MNT"/file3 bs=1M count=4 \
> +	cat /dev/urandom | od | dd iflag=fullblock of="$SCRATCH_MNT"/file3 bs=1M count=4 \
>  		>>$seqres.full 2>&1
>  
>  	# nuke a device and remount in degraded mode
> -- 
> 2.10.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

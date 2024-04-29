Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C82A80039
	for <fstests@vger.kernel.org>; Mon, 29 Apr 2024 16:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406717; cv=none; b=rwXykhy9gpTf32IO6Vk1WDJf9eWvAeLw9AXlH/Rcd4gnxhG8sWiP1LoZN2bEQ4sWscqoSxwJc1rD0ijehynxV8kcyw/9FD/0ae+ZV+daMW/JBl0ekjOQ+lNajIP6FibN+zT7Dmfy4k+tuHycDIDCLQ7NxzQsQMMZCbhaMaGlA+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406717; c=relaxed/simple;
	bh=15Ju20FMZZk5gT8Vr/M9t90C2VhzvKkPX/WI9mbqCe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltv4GEd2E0hrJouDUmyF8Lp+dt+ptw+fKDlXgwTC0AspmeA796j6TGHG4aBvWsTQC7b3dufI13NP5MaoA+t6shKdf4/y3EWgmluq5aQ0jCiww7HJ1LlqEhMoSVBwGsSDstb0qcfnZPNLJsPqO1C+J+BcXZC0c1NmZDbrCNJh+V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0ohFjS6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0ohFjS6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28027C113CD;
	Mon, 29 Apr 2024 16:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714406717;
	bh=15Ju20FMZZk5gT8Vr/M9t90C2VhzvKkPX/WI9mbqCe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d0ohFjS6ek43JYCL4J9uTGCfE4V8X9Ogt+0qWcw/oY/Tjz8+b7ji1IoydzRmaLeRU
	 SVbTdYQbQxVjV6d/6rP4zj5rAZv2P+dUHziEs/82ZGGJvyPTRygIqHaQOcqcLRzTbe
	 YYxcIwCwISsvdDaGZ6EecXkUDErskDtJIIlpsiSErCJLYWct5y4ysrNJBu/Kx8QhfK
	 QZ2eu24ogvw52K1Ce/ZeM8yw+US9QrOsRUa6chZ7MZw17WGgQooxLegNfUXGH5T0j/
	 tnoKxueJRld8RIn/iCMMtx/sgt02gkHsTOngl9QYiM6la08zUcIt6vFpwrJzWm77nH
	 DQkC609FSOv4w==
Date: Mon, 29 Apr 2024 09:05:16 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH v3] tests: _fail on _scratch_mkfs_sized failure
Message-ID: <20240429160516.GD360908@frogsfrogsfrogs>
References: <20240429153751.23515-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429153751.23515-1-ddiss@suse.de>

On Tue, Apr 30, 2024 at 01:37:52AM +1000, David Disseldorp wrote:
> If _scratch_mkfs_sized() fails, e.g. due to an FS not supporting the
> provided size, tests may subsequently mount and run atop a previously
> created (e.g. non-size-bound) filesystem.
> This can lead to difficult to debug failures, or for some -ENOSPC
> exercising tests, near infinite runtimes. Avoid this by renaming the
> current function to _try_scratch_mkfs_sized() and _fail in the parent
> _scratch_mkfs_sized() wrapper.
> 
> Suggested-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
> Changes since v2:
> - drop existing test-specific _scratch_mkfs_sized() error handlers
> Changes since v1:
> - call _fail in a wrapper function, instead of adding failure handlers
>   to individual test _scratch_mkfs_sized() callers.
> 
>  common/rc         | 9 +++++++--
>  tests/btrfs/004   | 3 +--
>  tests/btrfs/007   | 3 +--
>  tests/ext4/021    | 2 +-
>  tests/ext4/059    | 2 +-
>  tests/generic/015 | 3 +--
>  tests/generic/077 | 2 +-
>  tests/generic/083 | 3 +--
>  tests/generic/171 | 2 +-
>  tests/generic/172 | 2 +-
>  tests/generic/173 | 2 +-
>  tests/generic/174 | 2 +-
>  tests/generic/735 | 2 +-
>  tests/xfs/015     | 2 +-
>  tests/xfs/057     | 3 +--
>  15 files changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 56f1afb6..c3def066 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -968,8 +968,8 @@ _small_fs_size_mb()
>  }
>  
>  # Create fs of certain size on scratch device
> -# _scratch_mkfs_sized <size in bytes> [optional blocksize]
> -_scratch_mkfs_sized()
> +# _try_scratch_mkfs_sized <size in bytes> [optional blocksize]
> +_try_scratch_mkfs_sized()
>  {
>  	local fssize=$1
>  	local blocksize=$2
> @@ -1111,6 +1111,11 @@ _scratch_mkfs_sized()
>  	esac
>  }
>  
> +_scratch_mkfs_sized()
> +{
> +	_try_scratch_mkfs_sized $* || _fail "_scratch_mkfs_sized (size=${1}) failed"

I wonder if you ought to dump all the arguments, but the maintainer did
say to print the *size*. :)

Either way this looks decent to me so
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> +}
> +
>  # Emulate an N-data-disk stripe w/ various stripe units
>  # _scratch_mkfs_geom <sunit bytes> <swidth multiplier> [optional blocksize]
>  _scratch_mkfs_geom()
> diff --git a/tests/btrfs/004 b/tests/btrfs/004
> index 00a516c3..684f5fdf 100755
> --- a/tests/btrfs/004
> +++ b/tests/btrfs/004
> @@ -157,8 +157,7 @@ workout()
>  	_scratch_unmount >/dev/null 2>&1
>  	echo "*** mkfs -dsize=$fsz"    >>$seqres.full
>  	echo ""                                     >>$seqres.full
> -	_scratch_mkfs_sized $fsz >>$seqres.full 2>&1 \
> -		|| _fail "size=$fsz mkfs failed"
> +	_scratch_mkfs_sized $fsz >>$seqres.full 2>&1
>  	_scratch_mount
>  	# -w ensures that the only ops are ones which cause write I/O
>  	run_check $FSSTRESS_PROG -d $SCRATCH_MNT -w -p $procs -n 2000 \
> diff --git a/tests/btrfs/007 b/tests/btrfs/007
> index 333524e2..a3a5b185 100755
> --- a/tests/btrfs/007
> +++ b/tests/btrfs/007
> @@ -43,8 +43,7 @@ workout()
>  	_scratch_unmount >/dev/null 2>&1
>  	echo "*** mkfs -dsize=$fsz"    >>$seqres.full
>  	echo ""                                     >>$seqres.full
> -	_scratch_mkfs_sized $fsz >>$seqres.full 2>&1 \
> -		|| _fail "size=$fsz mkfs failed"
> +	_scratch_mkfs_sized $fsz >>$seqres.full 2>&1
>  	_scratch_mount "-o noatime"
>  
>  	run_check $FSSTRESS_PROG -d $SCRATCH_MNT -n $ops $FSSTRESS_AVOID -x \
> diff --git a/tests/ext4/021 b/tests/ext4/021
> index a9277abf..62768c60 100755
> --- a/tests/ext4/021
> +++ b/tests/ext4/021
> @@ -24,7 +24,7 @@ _scratch_unmount
>  
>  # With 4k block size, this amounts to 10M FS instance.
>  fssize=$((2560 * $blocksize))
> -_scratch_mkfs_sized $fssize >> $seqres.full 2>&1 || _fail "mkfs failed"
> +_scratch_mkfs_sized $fssize >> $seqres.full 2>&1
>  _require_metadata_journaling $SCRATCH_DEV
>  
>  offset=0
> diff --git a/tests/ext4/059 b/tests/ext4/059
> index 4230bde9..f4864ffc 100755
> --- a/tests/ext4/059
> +++ b/tests/ext4/059
> @@ -23,7 +23,7 @@ _require_scratch_size_nocheck $((1024 * 1024))
>  # Initalize a 512M ext4 fs with resize_inode feature disabled
>  dev_size=$((512 * 1024 * 1024))
>  MKFS_OPTIONS="-O ^resize_inode $MKFS_OPTIONS" _scratch_mkfs_sized $dev_size \
> -	>>$seqres.full 2>&1 || _fail "mkfs failed"
> +	>>$seqres.full 2>&1
>  
>  # Force some reserved GDT blocks to trigger the bug
>  $DEBUGFS_PROG -w -R "set_super_value s_reserved_gdt_blocks 100" $SCRATCH_DEV \
> diff --git a/tests/generic/015 b/tests/generic/015
> index 10423a29..716a7b1f 100755
> --- a/tests/generic/015
> +++ b/tests/generic/015
> @@ -31,8 +31,7 @@ _require_no_large_scratch_dev
>  
>  # btrfs needs at least 256MB (with upward round off) to create a non-mixed mode
>  # fs. Ref: btrfs-progs: btrfs_min_dev_size()
> -_scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1 \
> -    || _fail "mkfs failed"
> +_scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1
>  _scratch_mount
>  out=$SCRATCH_MNT/fillup.$$
>  
> diff --git a/tests/generic/077 b/tests/generic/077
> index 94d89fae..2624e88f 100755
> --- a/tests/generic/077
> +++ b/tests/generic/077
> @@ -50,7 +50,7 @@ _scratch_unmount >/dev/null 2>&1
>  echo "*** MKFS ***"                         >>$seqres.full
>  echo ""                                     >>$seqres.full
>  fs_size=$((256 * 1024 * 1024))
> -_scratch_mkfs_sized $fs_size >> $seqres.full 2>&1 || _fail "mkfs failed"
> +_scratch_mkfs_sized $fs_size >> $seqres.full 2>&1
>  _scratch_mount
>  mkdir $SCRATCH_MNT/subdir
>  
> diff --git a/tests/generic/083 b/tests/generic/083
> index 2a5af3cc..4cd1c399 100755
> --- a/tests/generic/083
> +++ b/tests/generic/083
> @@ -50,8 +50,7 @@ workout()
>  		_scratch_mkfs_xfs -dsize=$fsz,agcount=$ags  >>$seqres.full 2>&1 \
>  			|| _fail "size=$fsz,agcount=$ags mkfs failed"
>  	else
> -		_scratch_mkfs_sized $fsz >>$seqres.full 2>&1 \
> -			|| _fail "size=$fsz mkfs failed"
> +		_scratch_mkfs_sized $fsz >>$seqres.full 2>&1
>  	fi
>  	_scratch_mount
>  
> diff --git a/tests/generic/171 b/tests/generic/171
> index f823a454..fb2a6f14 100755
> --- a/tests/generic/171
> +++ b/tests/generic/171
> @@ -42,7 +42,7 @@ sz_bytes=$((nr_blks * 8 * blksz))
>  if [ $sz_bytes -lt $((32 * 1048576)) ]; then
>  	sz_bytes=$((32 * 1048576))
>  fi
> -_scratch_mkfs_sized $sz_bytes >> $seqres.full 2>&1 || _fail "mkfs failed"
> +_scratch_mkfs_sized $sz_bytes >> $seqres.full 2>&1
>  _scratch_mount >> $seqres.full 2>&1
>  rm -rf $testdir
>  mkdir $testdir
> diff --git a/tests/generic/172 b/tests/generic/172
> index 383824b9..ab5122fa 100755
> --- a/tests/generic/172
> +++ b/tests/generic/172
> @@ -40,7 +40,7 @@ umount $SCRATCH_MNT
>  
>  file_size=$((768 * 1024 * 1024))
>  fs_size=$((1024 * 1024 * 1024))
> -_scratch_mkfs_sized $fs_size >> $seqres.full 2>&1 || _fail "mkfs failed"
> +_scratch_mkfs_sized $fs_size >> $seqres.full 2>&1
>  _scratch_mount >> $seqres.full 2>&1
>  rm -rf $testdir
>  mkdir $testdir
> diff --git a/tests/generic/173 b/tests/generic/173
> index e1493278..0eb313e2 100755
> --- a/tests/generic/173
> +++ b/tests/generic/173
> @@ -42,7 +42,7 @@ sz_bytes=$((nr_blks * 8 * blksz))
>  if [ $sz_bytes -lt $((32 * 1048576)) ]; then
>  	sz_bytes=$((32 * 1048576))
>  fi
> -_scratch_mkfs_sized $sz_bytes >> $seqres.full 2>&1 || _fail "mkfs failed"
> +_scratch_mkfs_sized $sz_bytes >> $seqres.full 2>&1
>  _scratch_mount >> $seqres.full 2>&1
>  rm -rf $testdir
>  mkdir $testdir
> diff --git a/tests/generic/174 b/tests/generic/174
> index c7a177b8..1505453e 100755
> --- a/tests/generic/174
> +++ b/tests/generic/174
> @@ -43,7 +43,7 @@ sz_bytes=$((nr_blks * 8 * blksz))
>  if [ $sz_bytes -lt $((32 * 1048576)) ]; then
>  	sz_bytes=$((32 * 1048576))
>  fi
> -_scratch_mkfs_sized $sz_bytes >> $seqres.full 2>&1 || _fail "mkfs failed"
> +_scratch_mkfs_sized $sz_bytes >> $seqres.full 2>&1
>  _scratch_mount >> $seqres.full 2>&1
>  rm -rf $testdir
>  mkdir $testdir
> diff --git a/tests/generic/735 b/tests/generic/735
> index 0ba111a6..89107a61 100755
> --- a/tests/generic/735
> +++ b/tests/generic/735
> @@ -25,7 +25,7 @@ _require_xfs_io_command "falloc"
>  _require_xfs_io_command "finsert"
>  
>  dev_size=$((80 * 1024 * 1024))
> -_scratch_mkfs_sized $dev_size >>$seqres.full 2>&1 || _fail "mkfs failed"
> +_scratch_mkfs_sized $dev_size >>$seqres.full 2>&1
>  
>  _scratch_mount
>  _require_congruent_file_oplen $SCRATCH_MNT 1048576	# finsert at 1M
> diff --git a/tests/xfs/015 b/tests/xfs/015
> index a7f4d243..3896ce1c 100755
> --- a/tests/xfs/015
> +++ b/tests/xfs/015
> @@ -43,7 +43,7 @@ _scratch_mount
>  _require_fs_space $SCRATCH_MNT 196608
>  _scratch_unmount
>  
> -_scratch_mkfs_sized $((96 * 1024 * 1024)) > $tmp.mkfs.raw || _fail "mkfs failed"
> +_scratch_mkfs_sized $((96 * 1024 * 1024)) > $tmp.mkfs.raw
>  cat $tmp.mkfs.raw | _filter_mkfs >$seqres.full 2>$tmp.mkfs
>  # get original data blocks number and agcount
>  . $tmp.mkfs
> diff --git a/tests/xfs/057 b/tests/xfs/057
> index 6af14c80..0cf16701 100755
> --- a/tests/xfs/057
> +++ b/tests/xfs/057
> @@ -51,8 +51,7 @@ echo "Silence is golden."
>  sdev=$(_short_dev $SCRATCH_DEV)
>  
>  # use a small log fs
> -_scratch_mkfs_sized $((1024 * 1024 * 500)) >> $seqres.full 2>&1 ||
> -		_fail "mkfs failed"
> +_scratch_mkfs_sized $((1024 * 1024 * 500)) >> $seqres.full 2>&1
>  _scratch_mount
>  
>  # populate the fs with some data and cycle the mount to reset the log head/tail
> -- 
> 2.35.3
> 
> 

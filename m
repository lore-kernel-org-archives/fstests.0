Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB6C275AEB
	for <fstests@vger.kernel.org>; Wed,  1 Apr 2026 14:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775053983; cv=none; b=dfjRc5+w0otxrhfpqm9vQEW9++LVogSG/S9jwZcOej+KjdeB1cDCOpLIzU6Fy4M8dBmbRWGNzoz1xL6Ynp1j4eOIztK1AetkIU3S4Nv46FWWiyw8EyaUbuRFjBSFdJDSutkZifkUrHNDTt4ygxuVEKa2wKKA1UP6AUWKyp66YuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775053983; c=relaxed/simple;
	bh=uIyjk1kZyA6rFtZGwtj+F7LhZN6TRJHkfOWMqB7UwC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MuyxI0jbo+TId6hDUZJCm18j5HbWWOTWB/vg1Bue786dxJ+iTdtmPU+aOQ/jyYQTO3VDhdNh3JWiAnJublnzN90KV6FmOt0lggi3iPSPXb4dh0RqpFxnTqvqzHnX8eEokyOfyXjKkzZT9JtRhU24bSn9h5NV+110z/R35Gownfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D41rSe2m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D41rSe2m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C5DC4CEF7;
	Wed,  1 Apr 2026 14:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775053983;
	bh=uIyjk1kZyA6rFtZGwtj+F7LhZN6TRJHkfOWMqB7UwC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D41rSe2mJerGBfGhM/nEMLRPtzP8hZyMJ+g9KeCobnhprZxxNj4fveHksF8EZGDki
	 yjLlbOwaXST+KUYZGf4dQr5rUdSmx3oijUfkE6xl31TtVxOOGi3CtzvVDXqwZWeU4Q
	 EhAfIcIpxmsTAPOmS26MdpNhYS8L2Q0HrqnTDy1LusS2kzjRb9k9JDB1FtrNsZvrCH
	 DBnDFm4hs/M0DtmUI12yymfaaPQ7mP26CohEPlNPWTgvNFEXknzsly3zD4jfLO0tvf
	 SBp3PDgtT3m11DFuIHqlCPJgMzDv+mJdTLe3HKd05oBfV5CoP953j/kHL4jasOLiu2
	 OjlvrX3zxMxgQ==
Date: Wed, 1 Apr 2026 07:33:02 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCH 1/4] ext4/061,062: Minor fixes and refactoring
Message-ID: <20260401143302.GJ6212@frogsfrogsfrogs>
References: <726e43008315a1bed018c1b43aae2458aebc03bc.1775039135.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <726e43008315a1bed018c1b43aae2458aebc03bc.1775039135.git.ojaswin@linux.ibm.com>

On Wed, Apr 01, 2026 at 04:10:47PM +0530, Ojaswin Mujoo wrote:
> Fix 2 issues in the tests:
> 
> 1. Use fs atomic write limits instead of bdev's
> 
> The tests use block device's limits instead of limits advertised
> by filesystem. This can cause failures because block device might
> advertise a higher maximum than the FS.  Fix the tests to use
> filesystem's limits instead.
> 
> 2. Fix the test loop range
> 
> Fix the test loop start and end so that our calculations for
> blocksize, clustersize and iosize are correct.
> 
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Looks fine to me,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/ext4/061 | 28 ++++++++++++++++++++--------
>  tests/ext4/062 | 26 +++++++++++++++++++-------
>  2 files changed, 39 insertions(+), 15 deletions(-)
> 
> diff --git a/tests/ext4/061 b/tests/ext4/061
> index 1d61c8b0..69ddeaca 100755
> --- a/tests/ext4/061
> +++ b/tests/ext4/061
> @@ -31,10 +31,19 @@ _require_aiodio
>  FIO_LOAD=$(($(nproc) * 2 * LOAD_FACTOR))
>  SIZE=$((100*1024*1024))
>  
> -# Calculate fsblocksize as per bdev atomic write units.
> -bdev_awu_min=$(_get_atomic_write_unit_min $SCRATCH_DEV)
> -bdev_awu_max=$(_get_atomic_write_unit_max $SCRATCH_DEV)
> -bs=$(_max 4096 "$bdev_awu_min")
> +_scratch_mkfs > /dev/null 2>&1 || \
> +	_notrun "mkfs failed"
> +_try_scratch_mount || \
> +	_notrun "mount failed"
> +
> +touch $SCRATCH_MNT/f
> +
> +fs_awu_min=$(_get_atomic_write_unit_min $SCRATCH_MNT/f)
> +fs_awu_max=$(_get_atomic_write_unit_max $SCRATCH_MNT/f)
> +bs=$(_max 4096 "$fs_awu_min")
> +ps=$(_get_page_size)
> +
> +_scratch_unmount
>  
>  function create_fio_configs()
>  {
> @@ -97,10 +106,11 @@ run_test_one() {
>  	local cs=$2
>  	local iosize=$3
>  
> +	echo "== Testing: bs=$bs cs=$cs iosize=$iosize ==" >> $seqres.full
> +
>  	MKFS_OPTIONS="-O bigalloc -b $bs -C $cs"
>  	_scratch_mkfs_ext4  >> $seqres.full 2>&1 || return
>  	if _try_scratch_mount >> $seqres.full 2>&1; then
> -		echo "== Testing: bs=$bs cs=$cs iosize=$iosize ==" >> $seqres.full
>  
>  		touch $SCRATCH_MNT/f1
>  		create_fio_configs $iosize
> @@ -127,7 +137,7 @@ run_test() {
>  	# cluster sizes above 16 x blocksize are experimental so avoid them
>  	# Also, cap cluster size at 128kb to keep it reasonable for large
>  	# blocks size
> -	max_cs=$(_min $((16 * bs)) "$bdev_awu_max" $((128 * 1024)))
> +	max_cs=$(_min $((16 * bs)) "$fs_awu_max" $((128 * 1024)))
>  
>  	# Fuzz for combinations of blocksize, clustersize and
>  	# iosize that cover most of the cases
> @@ -145,8 +155,10 @@ fio_out=$tmp.fio.out
>  create_fio_configs $bs
>  _require_fio $fio_aw_config
>  
> -for ((bs=$bs; bs <= $(_get_page_size); bs = $bs << 1)); do
> -	run_test $bs
> +echo "Awu min: $fs_awu_min Awu max: $fs_awu_max" >> $seqres.full
> +
> +for ((bs=$fs_awu_min; bs <= $(_min ps fs_awu_max); bs = $bs << 1)); do
> +	run_test $bs $cs $iosize
>  done
>  
>  # success, all done
> diff --git a/tests/ext4/062 b/tests/ext4/062
> index 05cce696..56bf080c 100755
> --- a/tests/ext4/062
> +++ b/tests/ext4/062
> @@ -33,10 +33,19 @@ _require_aiodio
>  FSSIZE=$((360*1024*1024))
>  FIO_LOAD=$(($(nproc) * LOAD_FACTOR))
>  
> -# Calculate bs as per bdev atomic write units.
> -bdev_awu_min=$(_get_atomic_write_unit_min $SCRATCH_DEV)
> -bdev_awu_max=$(_get_atomic_write_unit_max $SCRATCH_DEV)
> -bs=$(_max 4096 "$bdev_awu_min")
> +_scratch_mkfs > /dev/null 2>&1 || \
> +	_notrun "mkfs failed"
> +_try_scratch_mount || \
> +	_notrun "mount failed"
> +
> +touch $SCRATCH_MNT/f
> +
> +fs_awu_min=$(_get_atomic_write_unit_min $SCRATCH_MNT/f)
> +fs_awu_max=$(_get_atomic_write_unit_max $SCRATCH_MNT/f)
> +bs=$(_max 4096 "$fs_awu_min")
> +ps=$(_get_page_size)
> +
> +_scratch_unmount
>  
>  function create_fio_configs()
>  {
> @@ -146,10 +155,11 @@ run_test_one() {
>  	local cs=$2
>  	local iosize=$3
>  
> +	echo "Testing: bs=$bs cs=$cs iosize=$iosize" >> $seqres.full
> +
>  	MKFS_OPTIONS="-O bigalloc -b $bs -C $cs"
>  	_scratch_mkfs_sized "$FSSIZE" >> $seqres.full 2>&1 || return
>  	if _try_scratch_mount >> $seqres.full 2>&1; then
> -		echo "Testing: bs=$bs cs=$cs iosize=$iosize" >> $seqres.full
>  
>  		touch $SCRATCH_MNT/f1
>  		create_fio_configs $iosize
> @@ -175,7 +185,7 @@ run_test() {
>  	# cluster sizes above 16 x blocksize are experimental so avoid them
>  	# Also, cap cluster size at 128kb to keep it reasonable for large
>  	# blocks size
> -	max_cs=$(_min $((16 * bs)) "$bdev_awu_max" $((128 * 1024)))
> +	max_cs=$(_min $((16 * bs)) "$fs_awu_max" $((128 * 1024)))
>  
>  	# Fuzz for combinations of blocksize, clustersize and
>  	# iosize that cover most of the cases
> @@ -193,7 +203,9 @@ fio_out=$tmp.fio.out
>  create_fio_configs $bs
>  _require_fio $fio_aw_config
>  
> -for ((bs=$bs; bs <= $(_get_page_size); bs = $bs << 1)); do
> +echo "Awu min: $fs_awu_min Awu max: $fs_awu_max" >> $seqres.full
> +
> +for ((bs=$fs_awu_min; bs <= $(_min ps fs_awu_max); bs = $bs << 1)); do
>  	run_test $bs $cs $iosize
>  done
>  
> -- 
> 2.53.0
> 
> 

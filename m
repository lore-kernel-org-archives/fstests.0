Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A7B3DDDCE
	for <fstests@vger.kernel.org>; Fri, 10 Apr 2026 16:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775839947; cv=none; b=MvkP9KKlZwv7c6nUV23tGp3bpL+cjHNOjpF2+D2i+Iz7ZXxBF93b5t5U3Cwe3F+xNrF8XxnbHwD34oS36FTvR6f1Asqwk2UefDuUgYD36lF8SQdlo55Azq7Y1l5Jv1FQr+9ERPeeRoEgv78qx8oVUO+FPnI8paUIamdTarXdUyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775839947; c=relaxed/simple;
	bh=dB187/atjEmgTC1i2bDvMg1XEHmKnsg96b4BKe3oqZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ff6K28jTGNnrvCzwZASOphMtL4i3WFkD0XsbO08AjoCQgLhOCFHe9b3NHQXDXg9xh2oA27z8U+TMlEupuxPvGuUYCMEZQcORKGb4B3cx+RHhVRB6OyrSR/08V14cVPaj/y8OxhVRNhU7FxSbpsZBQC+fBfWy5tsUgdJsMn8zOmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QL52Rnvh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QL52Rnvh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED55C19424;
	Fri, 10 Apr 2026 16:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775839946;
	bh=dB187/atjEmgTC1i2bDvMg1XEHmKnsg96b4BKe3oqZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QL52Rnvh6vNqHuaPCk2OhNC0C1MW5NXevxpPKihiPYvwUk5HBdavSuQUF46x9FFK+
	 wwnlwgSzD2aeNQcHebkp3Ta772064h3L/vd9lLmNvjFKMJCqayn4UoO+7QM/upLQHI
	 ouClGR1VVmTr3IjgHR2NtNCNAKb4SeMvk8NkrWRQn42Y9XE6i8nGeLSqQJyy36bwSO
	 PLZeoys5YExEHChfaLt+7jjATvBFTvQDidFnpaSEpViIhLkxHxjNOVUqwfApfXYnZT
	 d4sCKHneJhqV3gzfH+Bw6c+VrNSwfml0OPd7C0Q6+zT9cDAv0OeeTHXT/jX+kMiN7l
	 Fjkq7OeeUhCcQ==
Date: Fri, 10 Apr 2026 09:52:26 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	fdmanana@suse.com, ritesh.list@gmail.com, naohiro.aota@wdc.com,
	wqu@suse.com
Subject: Re: [PATCH 6/6] treewide: Use _sysfs_queue_path helper in all queue
 access locations
Message-ID: <20260410165226.GT6212@frogsfrogsfrogs>
References: <cover.1775802601.git.ojaswin@linux.ibm.com>
 <01fdf4d33a80159edbc53fbc57d856f794480c94.1775802601.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01fdf4d33a80159edbc53fbc57d856f794480c94.1775802601.git.ojaswin@linux.ibm.com>

On Fri, Apr 10, 2026 at 12:06:06PM +0530, Ojaswin Mujoo wrote:
> The sysfs queue dir for partitions is present in their parent device's
> sysfs dir. This requires extra checks when trying to reading queue data
> from sysfs. Currently, fstests open codes this handling or straight up
> ignores it in some places.
> 
> Avoid this by converting all remaining direct sysfs queue accesses to
> use the _sysfs_queue_path helper function. This ensures proper handling
> of partitions across the entire codebase and provides a consistent
> interface for accessing queue attributes.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Looks reasonable to me,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  common/encrypt  |  7 ++-----
>  common/rc       | 12 ++++++++----
>  common/report   | 20 +++++++++++---------
>  common/zoned    |  5 +++--
>  tests/btrfs/076 | 11 +++++++----
>  tests/btrfs/237 |  5 +++--
>  tests/btrfs/273 |  4 +++-
>  tests/btrfs/283 |  4 +++-
>  8 files changed, 40 insertions(+), 28 deletions(-)
> 
> diff --git a/common/encrypt b/common/encrypt
> index f2687631..c9e0853d 100644
> --- a/common/encrypt
> +++ b/common/encrypt
> @@ -173,11 +173,8 @@ _require_hw_wrapped_key_support()
>  	local dev=$1
>  
>  	echo "Checking for HW-wrapped key support on $dev" >> $seqres.full
> -	local sysfs_dir=$(_sysfs_dev $dev)
> -	if [ ! -e $sysfs_dir/queue ]; then
> -		sysfs_dir=$sysfs_dir/..
> -	fi
> -	if [ ! -e $sysfs_dir/queue/crypto/hw_wrapped_keys ]; then
> +	local queue_path=$(_sysfs_queue_path $dev)
> +	if [ $? -ne 0 ] || [ ! -e $queue_path/crypto/hw_wrapped_keys ]; then
>  		_notrun "$dev doesn't support hardware-wrapped inline encryption keys"
>  	fi
>  
> diff --git a/common/rc b/common/rc
> index d7db5db1..9632b211 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2502,7 +2502,11 @@ __scratch_dev_has_dax()
>  {
>  	local sysfs="/sys/block/$(_short_dev $SCRATCH_DEV)"
>  	test -e "${sysfs}/dax" && return 0
> -	test "$(cat "${sysfs}/queue/dax" 2>/dev/null)" = "1" && return 0
> +
> +	local queue_path=$(_sysfs_queue_path $SCRATCH_DEV)
> +	if [ $? -eq 0 ]; then
> +		test "$(cat "${queue_path}/dax" 2>/dev/null)" = "1" && return 0
> +	fi
>  
>  	return 1
>  }
> @@ -2562,10 +2566,10 @@ _zone_type()
>  		echo "Usage: _zone_type <device>"
>  		_exit 1
>  	fi
> -	local sdev=`_short_dev $target`
>  
> -	if [ -e /sys/block/${sdev}/queue/zoned ]; then
> -		cat /sys/block/${sdev}/queue/zoned
> +	local queue_path=$(_sysfs_queue_path $target)
> +	if [ $? -eq 0 ] && [ -e "$queue_path/zoned" ]; then
> +		cat "$queue_path/zoned"
>  	else
>  		echo none
>  	fi
> diff --git a/common/report b/common/report
> index 7128bbeb..0d9ad78c 100644
> --- a/common/report
> +++ b/common/report
> @@ -37,16 +37,18 @@ __generate_blockdev_report_vars() {
>  
>  	test -z "$bdev" && return
>  	test -b "$bdev" || return
> -	local sysfs_bdev="$(_sysfs_dev "$bdev")"
> -
>  	REPORT_VARS["${bdev_var}_SIZE_KB"]="$(( "$(blockdev --getsz "$bdev")" / 2 ))"
> -	REPORT_VARS["${bdev_var}_ROTATIONAL"]="$(cat "$sysfs_bdev/queue/rotational" 2>/dev/null)"
> -	REPORT_VARS["${bdev_var}_DAX"]="$(cat "$sysfs_bdev/queue/dax" 2>/dev/null)"
> -	REPORT_VARS["${bdev_var}_DISCARD"]="$(sed -e 's/[1-9][0-9]*/1/g' "$sysfs_bdev/queue/discard_max_bytes" 2>/dev/null)"
> -	REPORT_VARS["${bdev_var}_WRITE_ZEROES"]="$(sed -e 's/[1-9][0-9]*/1/g' "$sysfs_bdev/queue/write_zeroes_max_bytes" 2>/dev/null)"
> -	REPORT_VARS["${bdev_var}_PHYS_BLOCK_BYTES"]="$(cat "$sysfs_bdev/queue/physical_block_size" 2>/dev/null)"
> -	REPORT_VARS["${bdev_var}_LBA_BYTES"]="$(cat "$sysfs_bdev/queue/logical_block_size" 2>/dev/null)"
> -	REPORT_VARS["${bdev_var}_ZONES"]="$(cat "$sysfs_bdev/queue/nr_zones" 2>/dev/null)"
> +
> +	local queue_path="$(_sysfs_queue_path "$bdev")"
> +	if [ $? -eq 0 ]; then
> +		REPORT_VARS["${bdev_var}_ROTATIONAL"]="$(cat "$queue_path/rotational" 2>/dev/null)"
> +		REPORT_VARS["${bdev_var}_DAX"]="$(cat "$queue_path/dax" 2>/dev/null)"
> +		REPORT_VARS["${bdev_var}_DISCARD"]="$(sed -e 's/[1-9][0-9]*/1/g' "$queue_path/discard_max_bytes" 2>/dev/null)"
> +		REPORT_VARS["${bdev_var}_WRITE_ZEROES"]="$(sed -e 's/[1-9][0-9]*/1/g' "$queue_path/write_zeroes_max_bytes" 2>/dev/null)"
> +		REPORT_VARS["${bdev_var}_PHYS_BLOCK_BYTES"]="$(cat "$queue_path/physical_block_size" 2>/dev/null)"
> +		REPORT_VARS["${bdev_var}_LBA_BYTES"]="$(cat "$queue_path/logical_block_size" 2>/dev/null)"
> +		REPORT_VARS["${bdev_var}_ZONES"]="$(cat "$queue_path/nr_zones" 2>/dev/null)"
> +	fi
>  }
>  
>  __import_report_vars() {
> diff --git a/common/zoned b/common/zoned
> index 88b81de5..89d0a061 100644
> --- a/common/zoned
> +++ b/common/zoned
> @@ -17,8 +17,9 @@ _filter_blkzone_report()
>  
>  _require_limited_active_zones() {
>      local dev=$1
> -    local sysfs=$(_sysfs_dev ${dev})
> -    local attr="${sysfs}/queue/max_active_zones"
> +    local queue_path=$(_sysfs_queue_path ${dev})
> +    [ $? -ne 0 ] && _notrun "cannot find queue path: $queue_path"
> +    local attr="${queue_path}/max_active_zones"
>  
>      [ -e "${attr}" ] || _notrun "cannot find queue/max_active_zones. Maybe non-zoned device?"
>      if [ $(cat "${attr}") == 0 ]; then
> diff --git a/tests/btrfs/076 b/tests/btrfs/076
> index c148406f..0a1e660d 100755
> --- a/tests/btrfs/076
> +++ b/tests/btrfs/076
> @@ -28,10 +28,13 @@ _fixed_by_kernel_commit 4bcbb3325513 \
>  # An extent size can be up to BTRFS_MAX_UNCOMPRESSED
>  max_extent_size=$(( 128 * 1024 ))
>  if _scratch_btrfs_is_zoned; then
> -	zone_append_max=$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/queue/zone_append_max_bytes")
> -	if [[ $zone_append_max -gt 0 && $zone_append_max -lt $max_extent_size ]]; then
> -		# Round down to PAGE_SIZE
> -		max_extent_size=$(( $zone_append_max / 4096 * 4096 ))
> +	queue_path=$(_sysfs_queue_path $SCRATCH_DEV)
> +	if [ $? -eq 0 ]; then
> +		zone_append_max=$(cat "$queue_path/zone_append_max_bytes")
> +		if [[ $zone_append_max -gt 0 && $zone_append_max -lt $max_extent_size ]]; then
> +			# Round down to PAGE_SIZE
> +			max_extent_size=$(( $zone_append_max / 4096 * 4096 ))
> +		fi
>  	fi
>  fi
>  file_size=$(( 10 * 1024 * 1024 ))
> diff --git a/tests/btrfs/237 b/tests/btrfs/237
> index 675f4c42..07a56336 100755
> --- a/tests/btrfs/237
> +++ b/tests/btrfs/237
> @@ -44,8 +44,9 @@ get_data_bg_physical()
>  $BLKZONE_PROG report $SCRATCH_DEV | grep -q -e "nw" && \
>  	_notrun "test is unreliable on devices with conventional zones"
>  
> -sdev="$(_short_dev $SCRATCH_DEV)"
> -zone_size=$(($(cat /sys/block/${sdev}/queue/chunk_sectors) << 9))
> +queue_path=$(_sysfs_queue_path $SCRATCH_DEV) || \
> +    _notrun "Failed to get queue path: $queue_path"
> +zone_size=$(($(cat "$queue_path/chunk_sectors") << 9))
>  fssize=$((zone_size * 16))
>  devsize=$(($(_get_device_size $SCRATCH_DEV) * 1024))
>  # Create a minimal FS to kick the reclaim process
> diff --git a/tests/btrfs/273 b/tests/btrfs/273
> index 06ae5d53..60c3967b 100755
> --- a/tests/btrfs/273
> +++ b/tests/btrfs/273
> @@ -38,7 +38,9 @@ _require_btrfs_command inspect-internal dump-tree
>  # enabled.
>  _require_no_compress
>  
> -max_active=$(cat $(_sysfs_dev ${SCRATCH_DEV})/queue/max_active_zones)
> +queue_path=$(_sysfs_queue_path ${SCRATCH_DEV}) || \
> +    _notrun "Failed to get queue path: $queue_path"
> +max_active=$(cat "$queue_path/max_active_zones")
>  
>  # Fill the zones leaving the last 1MB
>  fill_active_zones() {
> diff --git a/tests/btrfs/283 b/tests/btrfs/283
> index f7a8290a..9f89fafb 100755
> --- a/tests/btrfs/283
> +++ b/tests/btrfs/283
> @@ -26,7 +26,9 @@ _wants_kernel_commit c7499a64dcf6 \
>  
>  extent_size=$(( 128 * 1024 ))
>  if _scratch_btrfs_is_zoned; then
> -	zone_append_max=$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/queue/zone_append_max_bytes")
> +	queue_path=$(_sysfs_queue_path $SCRATCH_DEV) ||
> +	    _notrun "Couldn't find queue path for zoned device"
> +	zone_append_max=$(cat "$queue_path/zone_append_max_bytes")
>  	if [[ $zone_append_max -gt 0 && $zone_append_max -lt $extent_size ]]; then
>  		_notrun "zone append max $zone_append_max is smaller than wanted extent size $extent_size"
>  	fi
> -- 
> 2.53.0
> 
> 

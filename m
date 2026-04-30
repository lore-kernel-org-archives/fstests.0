Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE6D242D97
	for <fstests@vger.kernel.org>; Thu, 30 Apr 2026 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566719; cv=none; b=bMkVoWhXosuv05FkMMUTVJV/JXYAgR7TyqPS+Fr1ICw1nPTUPgZp74Ihkiod8dilzqTsfhwJ3dfCPtiHr0jhDXl1oLYN4o62eRqy97LOQCET6XRjLnaOQ2mOb20KKy/sYUnlaQ6aSw8USHj5EnRrtngRYHT0qybgw3Ap+1ps1Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566719; c=relaxed/simple;
	bh=lAwYSgk8V6QV7+wZkcKP0pxB5/J4RE1Imamwk02hnwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBW2qBfioCdpXEHaasrep+u0ejAgL8PeOhOTkyoRmLND6OUYrAdDWz02hVC/g8agt0ed8y8/4vthDW9oYjWA4OSYa/KfjSWqxiF7PyD+VS9W4c9gN5D+eRNXI3MulRbwRO9fUPJv/bFI3ovQ5t5gm5PM8CXzDHhTD9eQpAv6XWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4v0nDF7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4v0nDF7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C71FC2BCB3;
	Thu, 30 Apr 2026 16:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777566719;
	bh=lAwYSgk8V6QV7+wZkcKP0pxB5/J4RE1Imamwk02hnwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C4v0nDF7828sZs/XrtDitCMbcS350jyqaZUxRTQW7e8HRd8tqnjK/hyAc3HPKg/XV
	 GUWwm69zB+fL2FIceZQ6eYToIEsk37VvEnlDZTSegI8P9HVjneMYAFqXjB59GWmVve
	 79PSL17GGKaNuqLx1YlA759AMzju+Jqons3/JpTyYAvNwEXphztBywTud9quGZR3LO
	 JKpjuaiP/i2btc5l9m2iWYCc99VxZc5zSPx9RBrMnZ46MeFOnEmPvdrYGnHGhw9Zmw
	 2Ya8jscZ3z8NJZW1NjK9wU451INn9XCfoVIeriHmfBN/FKdPstuLqRGfFDI1gezM+T
	 phSxEE+Glcr6w==
Date: Thu, 30 Apr 2026 09:31:58 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Lukas Herbolt <lukas@herbolt.com>
Cc: zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 3/4] generic/{102,172,347}: Adapt test for XFS on systems
 with 128+CPUs + SSDs
Message-ID: <20260430163158.GR7739@frogsfrogsfrogs>
References: <20260430131317.693845-2-lukas@herbolt.com>
 <20260430131317.693845-8-lukas@herbolt.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430131317.693845-8-lukas@herbolt.com>

On Thu, Apr 30, 2026 at 03:13:20PM +0200, Lukas Herbolt wrote:
> XFS will now scale by default its log size according the amount of CPUs. This
> can significantly increase the log area and using hardcoded size of file size
> will make the test file. Using the the X percent of the free space to create
> the file will let the test proceed.
> 
> For generic/102 we also have to change the 102.out as we cannot know the
> amount written data and it has to be filterred out.
> 
> For generic/172 we just use the new function to calculate file big enough
> to consume most of the available space.
> 
> The generic/347 will use -l concurency=0 in case it is being run on the
> XFS filesystem and mkfs.xfs already supports this option.
> 
> Signed-off-by: Lukas Herbolt <lukas@herbolt.com>
> ---
>  tests/generic/102     |  5 +++--
>  tests/generic/102.out | 20 ++++++++++----------
>  tests/generic/172     |  8 ++++----
>  tests/generic/347     |  9 ++++++++-
>  4 files changed, 25 insertions(+), 17 deletions(-)
> 
> diff --git a/tests/generic/102 b/tests/generic/102
> index daa5061bd3fe..60e651fefb5b 100755
> --- a/tests/generic/102
> +++ b/tests/generic/102
> @@ -23,12 +23,13 @@ _require_scratch
>  dev_size=$((1024 * 1024 * 1024))     # 1GB filesystem
>  _scratch_mkfs_sized $dev_size >>$seqres.full 2>&1
>  _scratch_mount
> +file_size=`_mb_pct_of_available_space $SCRATCH_DEV 95`
>  
>  for ((i = 0; i < 10; i++)); do
>  	echo "loop $i" >>$seqres.full
>  
> -	$XFS_IO_PROG -f -c "pwrite -b 1m 0 800m" "$SCRATCH_MNT"/file | \
> -_filter_xfs_io | _filter_scratch
> +	$XFS_IO_PROG -f -c "pwrite -b 1m 0 ${file_size}m" "$SCRATCH_MNT"/file | \
> +_filter_xfs_io_numbers | _filter_scratch

Ah, ok, so we're using 95% of the available space, not just a static
800M?  That's a pretty big difference...

>  	rm -f "$SCRATCH_MNT"/file
>  done
> diff --git a/tests/generic/102.out b/tests/generic/102.out
> index b58aa5ccc68b..647bb23abec1 100644
> --- a/tests/generic/102.out
> +++ b/tests/generic/102.out
> @@ -1,21 +1,21 @@
>  QA output created by 102
> -wrote 838860800/838860800 bytes at offset 0
> +wrote XXXX/XXXX bytes at offset XXXX
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -wrote 838860800/838860800 bytes at offset 0
> +wrote XXXX/XXXX bytes at offset XXXX
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -wrote 838860800/838860800 bytes at offset 0
> +wrote XXXX/XXXX bytes at offset XXXX
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -wrote 838860800/838860800 bytes at offset 0
> +wrote XXXX/XXXX bytes at offset XXXX
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -wrote 838860800/838860800 bytes at offset 0
> +wrote XXXX/XXXX bytes at offset XXXX
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -wrote 838860800/838860800 bytes at offset 0
> +wrote XXXX/XXXX bytes at offset XXXX
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -wrote 838860800/838860800 bytes at offset 0
> +wrote XXXX/XXXX bytes at offset XXXX
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -wrote 838860800/838860800 bytes at offset 0
> +wrote XXXX/XXXX bytes at offset XXXX
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -wrote 838860800/838860800 bytes at offset 0
> +wrote XXXX/XXXX bytes at offset XXXX
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -wrote 838860800/838860800 bytes at offset 0
> +wrote XXXX/XXXX bytes at offset XXXX
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> diff --git a/tests/generic/172 b/tests/generic/172
> index b67e817b667b..06f9370f065d 100755
> --- a/tests/generic/172
> +++ b/tests/generic/172
> @@ -37,15 +37,15 @@ echo "Reformat with appropriate size"
>  blksz="$(_get_block_size $testdir)"
>  _scratch_unmount
>  
> -file_size=$((768 * 1024 * 1024))
>  fs_size=$((1024 * 1024 * 1024))
>  _scratch_mkfs_sized $fs_size >> $seqres.full 2>&1
>  _scratch_mount >> $seqres.full 2>&1
>  rm -rf $testdir
>  mkdir $testdir
> +file_size=`_mb_pct_of_available_space $SCRATCH_DEV 70`

...particularly since you replace 768/1024 with 70% here.

>  echo "Create a big file and reflink it"
> -_pwrite_byte 0x61 0 $file_size $testdir/bigfile >> $seqres.full 2>&1
> +_pwrite_byte 0x61 0 ${file_size}m $testdir/bigfile >> $seqres.full 2>&1
>  _cp_reflink $testdir/bigfile $testdir/clonefile
>  _scratch_sync
>  
> @@ -54,7 +54,7 @@ _fill_fs $fs_size  $testdir/space $blksz 0 >> $seqres.full 2>&1
>  _scratch_sync
>  
>  echo "CoW the big file"
> -out="$(_pwrite_byte 0x62 0 $file_size $testdir/bigfile 2>&1 | \
> +out="$(_pwrite_byte 0x62 0 ${file_size}m $testdir/bigfile 2>&1 | \
>  	_filter_xfs_io_error)"
>  echo ${out} | grep -q "No space left on device" || echo "CoW should have failed with ENOSPC"
>  echo ${out} >> $seqres.full 2>&1
> @@ -63,7 +63,7 @@ echo ${out}
>  echo "Remount and try CoW again"
>  _scratch_cycle_mount
>  
> -out="$(_pwrite_byte 0x62 0 $file_size $testdir/bigfile 2>&1 | \
> +out="$(_pwrite_byte 0x62 0 ${file_size}m $testdir/bigfile 2>&1 | \
>  	_filter_xfs_io_error)"
>  echo ${out} | grep -q "No space left on device" || echo "CoW should have failed with ENOSPC"
>  echo ${out} >> $seqres.full 2>&1
> diff --git a/tests/generic/347 b/tests/generic/347
> index 5c0e3f949585..cf3cfc94c8c4 100755
> --- a/tests/generic/347
> +++ b/tests/generic/347
> @@ -14,6 +14,13 @@ BACKING_SIZE=$((500 * 1024 * 1024 / 512))	# 500M
>  VIRTUAL_SIZE=$((10 * $BACKING_SIZE))		# 5000M
>  GROW_SIZE=$((100 * 1024 * 1024 / 512))		# 100M
>  
> +dmthin_mkfs_opts=""
> +if [ $FSTYP == "xfs" ]; then
> +	if _scratch_mkfs_xfs_supported -l concurrency=0  >> $seqres.full 2>&1; then

_scratch_mkfs_supports_concurrency ?

> +		dmthin_mkfs_opts="-l concurrency=0"
> +	fi
> +fi
> +
>  # Override the default cleanup function.
>  _cleanup()
>  {
> @@ -25,7 +32,7 @@ _setup_thin()
>  {
>  	_dmthin_init $BACKING_SIZE $VIRTUAL_SIZE
>  	_dmthin_set_queue
> -	_dmthin_mkfs
> +	_dmthin_mkfs $dmthin_mkfs_opts
>  	_dmthin_mount
>  }
>  
> -- 
> 2.53.0
> 
> 

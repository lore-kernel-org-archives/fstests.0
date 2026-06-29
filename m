Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C6D3E00A3
	for <fstests@vger.kernel.org>; Mon, 29 Jun 2026 15:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782748523; cv=none; b=DRedK+4gIaj7E5g5yMQ7XIDSO2MFkTUA24ltMYa0GnKoinXCjHlQuED4xGAMflHncmCCQiweO9r4x0do92rYi8MLaHMi24i6ZZjU/3NmaxjrZN1byngllLel8DMj5IYeLm9OgcLHZL/w/ps9+na2q4nGARoDYNFQf6YNUXU83O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782748523; c=relaxed/simple;
	bh=fjA7uaI0S107OK5mwsdCJ5nBv/nmbuih2XAfv2Lo4Xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dyb7YNp32JghOEkRpPLoBfP/wCumMOhUyocTctAdA20M5Kzdd6LNpBEF9WAAVnWyK39vE8Ybr4/uVNlEpqBlZbmVAD5Me8m8uIA/8ww+08xh2cUfFNTibj/i/YAZPvbInxdlHGDoEsa7aj/67h7KYoYoFA32Nz7etsu7lSn7WKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qicr41Ol; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qicr41Ol"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C1D1F000E9;
	Mon, 29 Jun 2026 15:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782748522;
	bh=dZWPmadlMuMuN5TYG3U41b2/GEW9wzGFpKaeKRrJPBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Qicr41Ol1oE8YCSnWulm1sZW1EofBcnSQEqVy6RrSjKJMf+/px3d7tVrzn+YEudWW
	 SKfPVQSSfq032M1luFiGWc9jXwKVCr11l4HoTdwDuC/yMBZ9pZ68ynZBrWHbw1ILqy
	 O0s1VoPnwrjXsU5ZZHbeyzxaKClCtNdfhoYhDw6ITP9pwWO137AA4MS4/SfnK96W8v
	 XvdnkKTsdgAJWy5wtL4/qMDMAo1OzWCg4f73+PyHoka8SvAYQb/BaD5i4Uu9lvRrae
	 qtgZKxco/tCdsQR4uDeptTCFgFTGN4m29zP0ZClsvpILWxWqTThwLqk2gyjNMRcf+7
	 lLzyKZtW3nFsw==
Date: Mon, 29 Jun 2026 23:55:15 +0800
From: Zorro Lang <zlang@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: fstests@vger.kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] common/f2fs: introduce _require_f2fs_io_command
Message-ID: <akKP89EaCIyfIOES@zlang-mailbox>
Mail-Followup-To: Chao Yu <chao@kernel.org>, fstests@vger.kernel.org, 
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
References: <20260622020516.2372277-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622020516.2372277-1-chao@kernel.org>

On Mon, Jun 22, 2026 at 02:05:16AM +0000, Chao Yu wrote:
> Update existing f2fs testcases to utilize the new
> _require_f2fs_io_command() helper for verifying required f2fs_io
> subcommands instead of basic executable checks or open coding.
> 
> Suggested-by: Zorro Lang <zlang@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2: add Suggested-by tag of Zorro
>  common/f2fs    | 16 ++++++++++++++++
>  tests/f2fs/003 |  1 +
>  tests/f2fs/004 |  1 +
>  tests/f2fs/007 |  1 +
>  tests/f2fs/009 |  1 +
>  tests/f2fs/010 |  2 +-
>  tests/f2fs/011 |  2 +-
>  tests/f2fs/012 |  2 +-
>  tests/f2fs/013 |  2 +-
>  tests/f2fs/025 |  2 +-
>  10 files changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/common/f2fs b/common/f2fs
> index 82d3102ea..025d29a76 100644
> --- a/common/f2fs
> +++ b/common/f2fs
> @@ -96,3 +96,19 @@ _require_inject_f2fs_command()
>  	$F2FS_INJECT_PROG "--$metaarea" "$val" "-h" | grep "$member:" > /dev/null || \
>  		_notrun "--$metaarea --mb $member support is missing"
>  }
> +
> +# Check that f2fs_io supports specific subcommand(s)
> +_require_f2fs_io_command()
> +{
> +	_require_command "$F2FS_IO_PROG" f2fs_io
> +
> +	if [ -z "$1" ]; then
> +		echo "Usage: _require_f2fs_io_command command..." 1>&2
> +		_exit 1
> +	fi
> +
> +	for command in "$@"; do
> +		$F2FS_IO_PROG help | awk '{print $1}' | grep -qw "$command" || \
> +			_notrun "f2fs_io $command support is missing"

Thanks for this update. If we don't need to check whether the command supports
someone option, then the current logic is sufficient.

Reviewed-by: Zorro Lang <zlang@kernel.org>

> +	done
> +}
> diff --git a/tests/f2fs/003 b/tests/f2fs/003
> index fbb08a3e9..94885904c 100755
> --- a/tests/f2fs/003
> +++ b/tests/f2fs/003
> @@ -30,6 +30,7 @@ _fixed_by_kernel_commit b40a2b003709 \
>  
>  _require_scratch
>  _require_xfs_io_command "fpunch"
> +_require_f2fs_io_command "write" "gc"
>  
>  _scratch_mkfs >> $seqres.full
>  _scratch_mount >> $seqres.full
> diff --git a/tests/f2fs/004 b/tests/f2fs/004
> index ac824c437..0592e23c4 100755
> --- a/tests/f2fs/004
> +++ b/tests/f2fs/004
> @@ -30,6 +30,7 @@ _fixed_by_kernel_commit b2c160f4f3cf \
>  
>  _require_scratch
>  _require_odirect
> +_require_f2fs_io_command "write"
>  _scratch_mkfs >> $seqres.full
>  _scratch_mount >> $seqres.full
>  
> diff --git a/tests/f2fs/007 b/tests/f2fs/007
> index 37388433e..e45b6cea9 100755
> --- a/tests/f2fs/007
> +++ b/tests/f2fs/007
> @@ -15,6 +15,7 @@ _fixed_by_kernel_commit 26413ce18e85 \
>          "f2fs: compress: fix inconsistent update of i_blocks in release_compress_blocks and reserve_compress_blocks"
>  
>  _require_scratch
> +_require_f2fs_io_command "compress" "get_cblocks" "release_cblocks" "reserve_cblocks" "decompress"
>  testfile_prefix=$SCRATCH_MNT/testfile
>  fio_config=$tmp.fio
>  
> diff --git a/tests/f2fs/009 b/tests/f2fs/009
> index 39a4bad3d..afb3bc98f 100755
> --- a/tests/f2fs/009
> +++ b/tests/f2fs/009
> @@ -15,6 +15,7 @@ _require_scratch
>  _require_scratch_shutdown
>  _require_inject_f2fs_command node i_links
>  _require_command "$(type -P socket)" socket
> +_require_f2fs_io_command "write"
>  
>  _fixed_by_git_commit f2fs-tools 958cd6e \
>  	"fsck.f2fs: support to repair corrupted i_links"
> diff --git a/tests/f2fs/010 b/tests/f2fs/010
> index 50e378177..b8899dedc 100755
> --- a/tests/f2fs/010
> +++ b/tests/f2fs/010
> @@ -30,7 +30,7 @@ _fixed_by_kernel_commit 03511e936916 \
>  	"f2fs: fix inconsistent dirty state of atomic file"
>  
>  _require_scratch
> -_require_command "$F2FS_IO_PROG" f2fs_io
> +_require_f2fs_io_command "write"
>  
>  _scratch_mkfs >> $seqres.full
>  _scratch_mount >> $seqres.full
> diff --git a/tests/f2fs/011 b/tests/f2fs/011
> index 07c94d8c9..aa939c9e7 100755
> --- a/tests/f2fs/011
> +++ b/tests/f2fs/011
> @@ -27,7 +27,7 @@ _fixed_by_kernel_commit f7f8932ca6bb \
>  	"f2fs: fix to avoid running out of free segments"
>  
>  _require_scratch
> -_require_command "$F2FS_IO_PROG" f2fs_io
> +_require_f2fs_io_command "pinfile"
>  
>  _scratch_mkfs_sized $((1*1024*1024*1024)) >> $seqres.full
>  _scratch_mount -o checkpoint=disable:10%
> diff --git a/tests/f2fs/012 b/tests/f2fs/012
> index 53d54bf6b..15b0e5055 100755
> --- a/tests/f2fs/012
> +++ b/tests/f2fs/012
> @@ -19,7 +19,7 @@ _fixed_by_kernel_commit 91b587ba79e1 \
>  
>  export LC_ALL=C.UTF-8
>  _require_scratch_nocheck
> -_require_command "$F2FS_IO_PROG" f2fs_io
> +_require_f2fs_io_command "setflags"
>  _require_inject_f2fs_command dent d_hash
>  
>  #check whether f2fs supports "lookup_mode=x" mount option
> diff --git a/tests/f2fs/013 b/tests/f2fs/013
> index 80ed2702b..086a5b4bb 100755
> --- a/tests/f2fs/013
> +++ b/tests/f2fs/013
> @@ -19,7 +19,7 @@
>  . ./common/preamble
>  _begin_fstest auto quick
>  _require_kernel_config CONFIG_F2FS_FAULT_INJECTION
> -_require_command "$F2FS_IO_PROG" f2fs_io
> +_require_f2fs_io_command "write" "fsync"
>  
>  _cleanup()
>  {
> diff --git a/tests/f2fs/025 b/tests/f2fs/025
> index 807f18f23..6fc18d989 100755
> --- a/tests/f2fs/025
> +++ b/tests/f2fs/025
> @@ -20,7 +20,7 @@ _require_scratch
>  _require_scratch_shutdown
>  _require_xfs_io_command "pwrite"
>  _require_xfs_io_command "truncate"
> -_require_command "$F2FS_IO_PROG" f2fs_io
> +_require_f2fs_io_command gc_urgent
>  _require_fs_sysfs_attr $TEST_DEV gc_urgent
>  _require_check_dmesg
>  
> -- 
> 2.49.0
> 

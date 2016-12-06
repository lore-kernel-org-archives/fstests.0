Received: from aserp1040.oracle.com ([141.146.126.69]:48346 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752657AbcLFIZd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 6 Dec 2016 03:25:33 -0500
Date: Tue, 6 Dec 2016 00:23:26 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] generic/35[67]: disable swapfile tests on Btrfs
Message-ID: <20161206082326.GC25841@birch.djwong.org>
References: <f0b9fc441b46d15ddcdb126d3aabb27784c3e758.1480985305.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0b9fc441b46d15ddcdb126d3aabb27784c3e758.1480985305.git.osandov@fb.com>
Sender: fstests-owner@vger.kernel.org
To: Omar Sandoval <osandov@osandov.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, kernel-team@fb.com
List-ID: <fstests@vger.kernel.org>

On Mon, Dec 05, 2016 at 05:01:28PM -0800, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Btrfs doesn't support swapfiles (yet?), so generic/356 fails
> erroneously, and generic/357 only passes by accident. Let's add a
> _require_scratch_swapfile helper and add it to these tests.

Hehe, good catch. :)
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
> I have some code enabling swapfiles for Btrfs [1], but there's some ABBA
> deadlock issues with i_rwsem and mmap_sem on swap-over-NFS that I
> haven't had time to sort out. In the meantime, let's just skip these
> tests.
> 
> 1: https://github.com/osandov/linux/tree/btrfs-swap
> 
>  common/rc         | 22 ++++++++++++++++++++++
>  tests/generic/356 |  1 +
>  tests/generic/357 |  1 +
>  3 files changed, 24 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 2719b23..d863e56 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1790,6 +1790,28 @@ _require_odirect()
>  	rm -f $testfile 2>&1 > /dev/null
>  }
>  
> +# Check that the filesystem supports swapfiles
> +_require_scratch_swapfile()
> +{
> +	_require_scratch
> +
> +	_scratch_mkfs >/dev/null
> +	_scratch_mount
> +
> +	# Minimum size for mkswap is 10 pages
> +	local size=$(($(get_page_size) * 10))
> +
> +	_pwrite_byte 0x61 0 "$size" "$SCRATCH_MNT/swap" >/dev/null 2>&1
> +	mkswap "$SCRATCH_MNT/swap" >/dev/null 2>&1
> +	if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
> +		_scratch_unmount
> +		_notrun "swapfiles are not supported"
> +	fi
> +
> +	swapoff "$SCRATCH_MNT/swap" >/dev/null 2>&1
> +	_scratch_unmount
> +}
> +
>  # Check that a fs has enough free space (in 1024b blocks)
>  #
>  _require_fs_space()
> diff --git a/tests/generic/356 b/tests/generic/356
> index 6bb90c0..51eeb65 100755
> --- a/tests/generic/356
> +++ b/tests/generic/356
> @@ -44,6 +44,7 @@ _cleanup()
>  
>  # real QA test starts here
>  _supported_os Linux
> +_require_scratch_swapfile
>  _require_scratch_reflink
>  _require_cp_reflink
>  
> diff --git a/tests/generic/357 b/tests/generic/357
> index 439b314..0dd0c10 100755
> --- a/tests/generic/357
> +++ b/tests/generic/357
> @@ -44,6 +44,7 @@ _cleanup()
>  
>  # real QA test starts here
>  _supported_os Linux
> +_require_scratch_swapfile
>  _require_scratch_reflink
>  _require_cp_reflink
>  
> -- 
> 2.10.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

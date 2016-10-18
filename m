Received: from aserp1040.oracle.com ([141.146.126.69]:44035 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753416AbcJRD6n (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 17 Oct 2016 23:58:43 -0400
Date: Mon, 17 Oct 2016 20:58:38 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] xfs: fix __populate_check_xfs_dir
Message-ID: <20161018035838.GB20730@birch.djwong.org>
References: <1476759584-4150-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1476759584-4150-1-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Oct 18, 2016 at 10:59:44AM +0800, Xiao Yang wrote:
> We need to remove unused ${SCRATCH_DEV} when calling __populate_check_xfs_dir
> because __populate_check_xfs_dir function has been rewritten by Darrick.

What a jerk, that guy. ;)

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

(There'll be a lot more going on soon with common/populate once I get
going on the "fuzz every field" tests again.)

> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  tests/xfs/099 | 2 +-
>  tests/xfs/100 | 2 +-
>  tests/xfs/101 | 2 +-
>  tests/xfs/102 | 2 +-
>  tests/xfs/105 | 2 +-
>  tests/xfs/112 | 2 +-
>  tests/xfs/113 | 2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/xfs/099 b/tests/xfs/099
> index ebc02dd..85193ab 100755
> --- a/tests/xfs/099
> +++ b/tests/xfs/099
> @@ -75,7 +75,7 @@ echo "+ check fs"
>  _scratch_xfs_repair -n >> $seqres.full 2>&1 || _fail "xfs_repair should not fail"
>  
>  echo "+ check dir"
> -__populate_check_xfs_dir "${SCRATCH_DEV}" "${inode}" block
> +__populate_check_xfs_dir "${inode}" block
>  
>  echo "+ corrupt dir"
>  _scratch_xfs_db -x -c "inode ${inode}" -c 'dblock 0' -c "stack" -c "blocktrash -x 32 -y $((blksz * 8)) -z ${FUZZ_ARGS}" >> $seqres.full
> diff --git a/tests/xfs/100 b/tests/xfs/100
> index 2412c81..3bfafce 100755
> --- a/tests/xfs/100
> +++ b/tests/xfs/100
> @@ -75,7 +75,7 @@ echo "+ check fs"
>  _scratch_xfs_repair -n >> $seqres.full 2>&1 || _fail "xfs_repair should not fail"
>  
>  echo "+ check dir"
> -__populate_check_xfs_dir "${SCRATCH_DEV}" "${inode}" leaf
> +__populate_check_xfs_dir "${inode}" leaf
>  
>  echo "+ corrupt dir"
>  loff=0
> diff --git a/tests/xfs/101 b/tests/xfs/101
> index 679940f..d3abd19 100755
> --- a/tests/xfs/101
> +++ b/tests/xfs/101
> @@ -75,7 +75,7 @@ echo "+ check fs"
>  _scratch_xfs_repair -n >> $seqres.full 2>&1 || _fail "xfs_repair should not fail"
>  
>  echo "+ check dir"
> -__populate_check_xfs_dir "${SCRATCH_DEV}" "${inode}" leaf
> +__populate_check_xfs_dir "${inode}" leaf
>  
>  echo "+ corrupt dir"
>  _scratch_xfs_db -x -c "inode ${inode}" -c "dblock ${leaf_lblk}" -c "stack" -c "blocktrash -x 32 -y $((blksz * 8)) -z ${FUZZ_ARGS}" >> $seqres.full
> diff --git a/tests/xfs/102 b/tests/xfs/102
> index 8018a9e..cf0d7a6 100755
> --- a/tests/xfs/102
> +++ b/tests/xfs/102
> @@ -75,7 +75,7 @@ echo "+ check fs"
>  _scratch_xfs_repair -n >> $seqres.full 2>&1 || _fail "xfs_repair should not fail"
>  
>  echo "+ check dir"
> -__populate_check_xfs_dir "${SCRATCH_DEV}" "${inode}" node
> +__populate_check_xfs_dir "${inode}" node
>  
>  echo "+ corrupt dir"
>  loff=0
> diff --git a/tests/xfs/105 b/tests/xfs/105
> index 27ee4b3..07ccf00 100755
> --- a/tests/xfs/105
> +++ b/tests/xfs/105
> @@ -75,7 +75,7 @@ echo "+ check fs"
>  _scratch_xfs_repair -n >> $seqres.full 2>&1 || _fail "xfs_repair should not fail"
>  
>  echo "+ check dir"
> -__populate_check_xfs_dir "${SCRATCH_DEV}" "${inode}" node
> +__populate_check_xfs_dir "${inode}" node
>  
>  echo "+ corrupt dir"
>  loff="${leaf_lblk}"
> diff --git a/tests/xfs/112 b/tests/xfs/112
> index c237f03..84f1f1d 100755
> --- a/tests/xfs/112
> +++ b/tests/xfs/112
> @@ -75,7 +75,7 @@ echo "+ check fs"
>  _scratch_xfs_repair -n >> $seqres.full 2>&1 || _fail "xfs_repair should not fail"
>  
>  echo "+ check dir"
> -__populate_check_xfs_dir "${SCRATCH_DEV}" "${inode}" node
> +__populate_check_xfs_dir "${inode}" node
>  
>  echo "+ corrupt dir"
>  loff="${node_lblk}"
> diff --git a/tests/xfs/113 b/tests/xfs/113
> index 6d6e6fd..ec328bc 100755
> --- a/tests/xfs/113
> +++ b/tests/xfs/113
> @@ -75,7 +75,7 @@ echo "+ check fs"
>  _scratch_xfs_repair -n >> $seqres.full 2>&1 || _fail "xfs_repair should not fail"
>  
>  echo "+ check dir"
> -__populate_check_xfs_dir "${SCRATCH_DEV}" "${inode}" btree
> +__populate_check_xfs_dir "${inode}" btree
>  
>  echo "+ corrupt dir"
>  loff=0
> -- 
> 1.8.3.1
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

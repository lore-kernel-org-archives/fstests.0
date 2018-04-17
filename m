Received: from userp2120.oracle.com ([156.151.31.85]:54124 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751157AbeDQR70 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 17 Apr 2018 13:59:26 -0400
Date: Tue, 17 Apr 2018 10:59:17 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v3] common/xfs: Add require_xfs_db_write_array function
Message-ID: <20180417175917.GD5201@magnolia>
References: <20180417040641.GA5210@magnolia>
 <1523945500-10819-1-git-send-email-xuyang.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523945500-10819-1-git-send-email-xuyang.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: yang xu <xuyang.jy@cn.fujitsu.com>
Cc: guaneryu@gmail.com, david@fromorbit.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Apr 17, 2018 at 02:11:40PM +0800, yang xu wrote:
> xfsprogs commit 4222d00("db: write via array indexing doesn't
> work") fixes a bug that xfs_db write can't support array indexing.
> This function will check whether the bug is fixed on the current
> xfsprogs.
> 
> xfs/444 applies the function, and skips if this bug exists.
> 
> Signed-off-by: yang xu <xuyang.jy@cn.fujitsu.com>
> ---
>  common/xfs    | 17 +++++++++++++++++
>  tests/xfs/444 |  1 +
>  2 files changed, 18 insertions(+)
> 
> diff --git a/common/xfs b/common/xfs
> index 3169f87..0b59994 100644
> --- a/common/xfs
> +++ b/common/xfs
> @@ -701,3 +701,20 @@ _scratch_xfs_set_sb_field()
>  {
>  	_scratch_xfs_set_metadata_field "$1" "$2" "sb 0"
>  }
> +
> +#Before xfsprogs commit 4222d000ed("db: write via array indexing doesn't work"),
> +##xfs_db command to write a specific AGFL index doesn't work.
> +_require_xfs_db_write_array()
> +{
> +	local supported=0
> +
> +	_require_test
> +	touch $TEST_DIR/$seq.img
> +	$MKFS_XFS_PROG -d file,name=$TEST_DIR/$seq.img,size=512m >/dev/null 2>&1
> +	$XFS_DB_PROG -x -c "agfl 0" -c "write bno[32] 78" $TEST_DIR/$seq.img \
> +		>/dev/null 2>&1
> +	$XFS_DB_PROG -x -c "agfl 0" -c "print bno[32]" $TEST_DIR/$seq.img \
> +		| grep -q "bno\[32\] = 78" && supported=1
> +	rm -f $TEST_DIR/$seq.img
> +	[ $supported -eq 0 ] && _notrun "xfs_db write can't support array"
> +}
> diff --git a/tests/xfs/444 b/tests/xfs/444
> index 141be52..9700422 100755
> --- a/tests/xfs/444
> +++ b/tests/xfs/444
> @@ -54,6 +54,7 @@ _supported_os Linux
>  _require_check_dmesg
>  _require_scratch
>  _require_test_program "punch-alternating"
> +_require_xfs_db_write_array

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

>  
>  # This is only a v5 filesystem problem
>  _require_scratch_xfs_crc
> -- 
> 1.8.3.1
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

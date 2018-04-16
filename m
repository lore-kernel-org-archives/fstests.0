Received: from aserp2130.oracle.com ([141.146.126.79]:36694 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752481AbeDPRXD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 16 Apr 2018 13:23:03 -0400
Date: Mon, 16 Apr 2018 10:22:50 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v2] common/xfs: Add require_xfs_db_write_array function
Message-ID: <20180416172249.GA5201@magnolia>
References: <20180416060005.GJ2932@desktop>
 <1523869655-20309-1-git-send-email-xuyang.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523869655-20309-1-git-send-email-xuyang.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: yang xu <xuyang.jy@cn.fujitsu.com>
Cc: guaneryu@gmail.com, david@fromorbit.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Apr 16, 2018 at 05:07:35PM +0800, yang xu wrote:
> xfsprogs commit 4222d000ed("db: write via array indexing doesn't
> work") fixes a bug that xfs_db write can't support array indexing.
> This function will check whether the bug is fixed on the current
> xfsprogs.
> 
> xfs/444 applies the function, and skips if this bug exists.
> 
> Signed-off-by: yang xu <xuyang.jy@cn.fujitsu.com>
> ---
>  common/xfs    | 18 ++++++++++++++++++
>  tests/xfs/444 |  1 +
>  2 files changed, 19 insertions(+)
> 
> diff --git a/common/xfs b/common/xfs
> index 3169f87..c4611a1 100644
> --- a/common/xfs
> +++ b/common/xfs
> @@ -701,3 +701,21 @@ _scratch_xfs_set_sb_field()
>  {
>  	_scratch_xfs_set_metadata_field "$1" "$2" "sb 0"
>  }
> +
> +#Before xfsprogs commit 4222d000ed("db: write via array indexing doesn't work"),
> +#xfs_db command to write a specific AGFL index doesn't work.
> +_require_xfs_db_write_array()
> +{
> +	_scratch_xfs_set_metadata_field "bno[32]" "78" "agfl 0" >/dev/null 2>&1

This is going to fail randomly unless the caller previously called
_require_scratch to make sure that there's some kind of xfs fs image
sitting on the scratch device (and that there even is a scratch device).
Please document that requirement.  Alternately, consider formatting a xfs
image file in $TEST_DIR and poking that with xfs_db so you don't have to
deal with formatting and cleaning up the scratch device.

> +
> +	# Before xfsprogs commit 0ebbf1d58898 ("db: limit AGFL bno
> +	# arrayi printing), When asking for a single agfl entry,
> +	# the result outputs the entire remainder of the array
> +	# starting at the given index.
> +	# It is difficult to extract single entry values.
> +	# So filter useless information.
> +	bno_value=$(_scratch_xfs_get_metadata_field "bno[32]" \
> +		"agfl 0" |sed -e 's/ .*$//g' | sed -e 's/^.*://g')
> +
> +	[ "${bno_value}" != "78" ] && _notrun "xfs_db write can't support array"

It seems like a bad idea to leave a potentially corrupt scratch fs lying
around after this helper exits.

--D

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

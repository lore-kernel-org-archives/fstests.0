Received: from userp2130.oracle.com ([156.151.31.86]:34680 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932218AbeARSTh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 18 Jan 2018 13:19:37 -0500
Date: Thu, 18 Jan 2018 10:19:27 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v5 1/3] common/xfs: Check if write supports [-c|-d]
 option in xfs_db
Message-ID: <20180118181927.GH5606@magnolia>
References: <20180118084645.GT3102@eguan.usersys.redhat.com>
 <1516272595-3678-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516272595-3678-1-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: xiao yang <yangx.jy@cn.fujitsu.com>
Cc: eguan@redhat.com, david@fromorbit.com, bfoster@redhat.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jan 18, 2018 at 06:49:53PM +0800, xiao yang wrote:
> Make sure _scratch_xfs_set_metadata_field() can be used on an
> old xfsprogs-dev(e.g. v3.1.1).
> 
> The "-d" option was introduced since xfsprogs-dev v4.7.0 by commit
> 86769b3 ("xfs_db: allow recalculating CRCs on invalid metadata").
> 
> The special argument "--" is only used to end option-scanning
> in getopt().  getopt() was introduced since xfsprogs-dev v3.2.3 by
> commit c9f5e3d ("xfs_db: Allow writes of corrupted data")'.
> 
> Signed-off-by: xiao yang <yangx.jy@cn.fujitsu.com>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

> ---
>  common/xfs | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/common/xfs b/common/xfs
> index 45b84a0..ab58364 100644
> --- a/common/xfs
> +++ b/common/xfs
> @@ -658,8 +658,11 @@ _scratch_xfs_set_metadata_field()
>  	for arg in "$@"; do
>  		cmds+=("-c" "${arg}")
>  	done
> -	_scratch_xfs_db -x "${cmds[@]}" -c "write -d ${key} -- ${value}"
> -	echo
> +
> +	local wr_cmd="write"
> +	_scratch_xfs_db -x -c "help write" | egrep -q "(-c|-d)" && value="-- ${value}"
> +	_scratch_xfs_db -x -c "help write" | egrep -q "(-d)" && wr_cmd="${wr_cmd} -d"
> +	_scratch_xfs_db -x "${cmds[@]}" -c "${wr_cmd} ${key} ${value}"
>  }
>  
>  _scratch_xfs_get_sb_field()
> -- 
> 1.8.3.1
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

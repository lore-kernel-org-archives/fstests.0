Received: from mx1.redhat.com ([209.132.183.28]:40776 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754087AbeALHou (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 12 Jan 2018 02:44:50 -0500
Date: Fri, 12 Jan 2018 15:44:48 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2 1/2] common/xfs: Check if write supports [-c|-d]
 option in xfs_db
Message-ID: <20180112074448.GO5123@eguan.usersys.redhat.com>
References: <20180111180734.GD1168@magnolia>
 <1515737783-2061-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1515737783-2061-1-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: xiao yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org, darrick.wong@oracle.com
List-ID: <fstests@vger.kernel.org>

On Fri, Jan 12, 2018 at 02:16:22PM +0800, xiao yang wrote:
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
> ---
>  common/xfs | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/common/xfs b/common/xfs
> index 45b84a0..59d6dd3 100644
> --- a/common/xfs
> +++ b/common/xfs
> @@ -658,8 +658,11 @@ _scratch_xfs_set_metadata_field()
>  	for arg in "$@"; do
>  		cmds+=("-c" "${arg}")
>  	done
> -	_scratch_xfs_db -x "${cmds[@]}" -c "write -d ${key} -- ${value}"
> -	echo

I'm not sure if any golden image depends on this extra newline..

> +
> +	local wr_cmd="write"
> +	_scratch_xfs_db -x -c "help write" | egrep -q "(-c|-d)" && value="-- $value"
> +	_scratch_xfs_db -x -c "help write" | egrep -q "(-d)" && wr_cmd="${wr_cmd} -d"
> +	_scratch_xfs_db -x "${cmds[@]}" -c "${wr_cmd} ${key} ${value}"

This looks OK, but I'd like Darrick to help review too.

Thanks,
Eryu

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

Received: from mx1.redhat.com ([209.132.183.28]:46254 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751499AbcHQDgm (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 16 Aug 2016 23:36:42 -0400
Date: Wed, 17 Aug 2016 11:36:40 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfs/191: skip tests on older xfsprogs
Message-ID: <20160817033640.GP27776@eguan.usersys.redhat.com>
References: <1471403935-24222-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1471403935-24222-1-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org, jtulak@redhat.com
List-ID: <fstests@vger.kernel.org>

On Wed, Aug 17, 2016 at 11:18:55AM +0800, Xiao Yang wrote:
> If we don't have /tmp/foo file on xfsprogs 3.2.2, _require_xfs_mkfs_validation
> will fail because mkfs.xfs can't create this file.  We need to skip tests
> before xfsprogs 4.7.0, so fix it.  the feature has been introduced since
> xfsprogs 4.2.0:
> commit 20cec860e16b267ea0c71a2f648fa2b26aad2e65
> Author: Eric Sandeen <sandeen@sandeen.net>
> Date: Fri Jul 31 09:04:11 2015 +1000
> 
>   mkfs.xfs: always use underlying fs sector size when mkfs'ing a file
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  common/rc | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index b19b698..db99794 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3889,6 +3889,9 @@ _get_fs_sysfs_attr()
>  # number of failed cases.
>  _mkfs_validation_check()
>  {
> +	if [ ! -f /tmp/foo ]; then
> +		touch /tmp/foo
> +	fi

I think the file can be touched unconditionally.

Thanks,
Eryu

>  	local cmd="$MKFS_XFS_PROG -f -N -d file,name=/tmp/foo,size=$((1024 * 1024 * 1024))"
>  	$cmd -s size=2s >/dev/null 2>&1
>  	local sum=$?
> -- 
> 1.8.3.1
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

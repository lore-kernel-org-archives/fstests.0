Received: from mx1.redhat.com ([209.132.183.28]:37702 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751547AbcHZEuJ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 26 Aug 2016 00:50:09 -0400
Date: Fri, 26 Aug 2016 12:42:25 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2] xfs/098: fix xfs_repair on newer xfsprogs
Message-ID: <20160826044225.GY27776@eguan.usersys.redhat.com>
References: <20160825154052.GD20705@birch.djwong.org>
 <1472182612-10218-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1472182612-10218-1-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: darrick.wong@oracle.com, fstests@vger.kernel.org, zlang@redhat.com
List-ID: <fstests@vger.kernel.org>

On Fri, Aug 26, 2016 at 11:36:52AM +0800, Xiao Yang wrote:
> Make sure xfs_repair can't clear the log by default when it is corrupted.
> xfs_repair always and only clear the log when the -L parameter is specified.
> This has updated by:
> Commit f2053bc ("xfs_repair: don't clear the log by default")

Can you please put more details in commit log? e.g. what's the problem
you want to fix, what's the symptom, etc. I had a hard time
understanding the problems without running the test.

> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  common/rc     | 4 ++--
>  tests/xfs/098 | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 3fb0600..c693a31 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1143,9 +1143,9 @@ _repair_scratch_fs()
>      xfs)
>          _scratch_xfs_repair "$@" 2>&1
>  	res=$?
> -	if [ "$res" -eq 2 ]; then
> +	if [ "$res" -ne 0 ]; then
>  		echo "xfs_repair returns $res; replay log?"
> -		_scratch_mount
> +		_scratch_mount 2>&1
>  		res=$?
>  		if [ "$res" -gt 0 ]; then
>  			echo "mount returns $res; zap log?"
> diff --git a/tests/xfs/098 b/tests/xfs/098
> index d91d617..eb33bb1 100755
> --- a/tests/xfs/098
> +++ b/tests/xfs/098
> @@ -93,7 +93,7 @@ echo "+ mount image"
>  _scratch_mount 2>/dev/null && _fail "mount should not succeed"
>  
>  echo "+ repair fs"
> -_scratch_xfs_repair >> $seqres.full 2>&1
> +_repair_scratch_fs >> $seqres.full

The above two redirection updates seem not necessary to me, mount
failure message got redirected to $seqres.full in both cases. Any reason
doing so?

Thanks,
Eryu

>  
>  echo "+ mount image (2)"
>  _scratch_mount
> -- 
> 1.8.3.1
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

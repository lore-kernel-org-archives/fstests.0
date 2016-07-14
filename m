Received: from mx1.redhat.com ([209.132.183.28]:39133 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983AbcGNOVz (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 14 Jul 2016 10:21:55 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 46683C049D5A
	for <fstests@vger.kernel.org>; Thu, 14 Jul 2016 14:21:55 +0000 (UTC)
Date: Thu, 14 Jul 2016 22:21:52 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 4/6] xfstests: add _require_xfs_mkfs_validation to
 common/rc
Message-ID: <20160714142152.GG2432@eguan.usersys.redhat.com>
References: <1468500214-6237-1-git-send-email-jtulak@redhat.com>
 <1468500214-6237-5-git-send-email-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1468500214-6237-5-git-send-email-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Jan Tulak <jtulak@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jul 14, 2016 at 02:43:32PM +0200, Jan Tulak wrote:
> Add a simple way to skip a test if it is (or is not) run on mkfs correctly
> validating inputs.
> 
> Signed-off-by: Jan Tulak <jtulak@redhat.com>
> ---
>  common/rc | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 0c68e4f..72f9901 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3843,6 +3843,35 @@ _get_fs_sysfs_attr()
>  	cat /sys/fs/${FSTYP}/${dname}/${attr}
>  }
>  
> +# Skip if we are running an older binary without the stricter input checks.
> +# Make multiple checks to be sure that there is no regression on the one
> +# selected feature check, which would skew the result.
> +_require_xfs_mkfs_validation()
> +{
> +	_require_scratch

I don't think you need $SCRATCH_DEV and _require_scratch in this helper,
a test file just does the work, e.g. creating an empty file somewhere
and using the "-d name=<filename>,size=<size>" option of mkfs.xfs to do
the test.

> +	$MKFS_XFS_PROG -f -N -s size=2s $SCRATCH_DEV >/dev/null 2>&1
> +	sum=$?
> +	$MKFS_XFS_PROG -f -N -l version=2,su=$((256 * 1024 + 4096)) $SCRATCH_DEV >/dev/null 2>&1
> +	sum=`expr $sum + $?`
> +
> +	if [ "$sum" -eq 0 ]; then
> +		_notrun "Requires newer mkfs with stricter input checks."

"newer mkfs" is not specific, it's not clear which version of xfsprogs
one should use to run this test. It'd be good to see specific version
info in this message if possible. (Sorry I didn't make my point clear in
previous reviews.)

Thanks,
Eryu

> +	fi
> +}
> +
> +# The oposite of _require_xfs_mkfs_validation.
> +_require_xfs_mkfs_without_validation()
> +{
> +	_require_scratch
> +	$MKFS_XFS_PROG -f -N -s size=2s $SCRATCH_DEV >/dev/null 2>&1
> +	sum=$?
> +	$MKFS_XFS_PROG -f -N -l version=2,su=$((256 * 1024 + 4096)) $SCRATCH_DEV >/dev/null 2>&1
> +	sum=`expr $sum + $?`
> +
> +	if [ "$sum" -eq 2 ]; then
> +		_notrun "Requires older mkfs without stricter input checks."
> +	fi
> +}
>  init_rc
>  
>  ################################################################################
> -- 
> 2.5.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

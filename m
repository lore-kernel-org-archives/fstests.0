Received: from mx1.redhat.com ([209.132.183.28]:60640 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751139AbcGMKi0 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 13 Jul 2016 06:38:26 -0400
Date: Wed, 13 Jul 2016 18:38:05 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v3] xfstests: update xfs/096 for new behaviour
Message-ID: <20160713103805.GS2432@eguan.usersys.redhat.com>
References: <1464858659-610-1-git-send-email-jtulak@redhat.com>
 <1467389674-5341-1-git-send-email-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1467389674-5341-1-git-send-email-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Jan Tulak <jtulak@redhat.com>
Cc: fstests@vger.kernel.org, david@fromorbit.com
List-ID: <fstests@vger.kernel.org>

On Fri, Jul 01, 2016 at 06:14:34PM +0200, Jan Tulak wrote:
> Because we recently changed how mkfs behaves when it gets incorrect/invalid
> values, add a feature check to run this test only on older binaries, which
> accepts invalid sunit values.
> 
> Signed-off-by: Jan Tulak <jtulak@redhat.com>
> ---
> UPDATE:
> Change it to _notrun on newer binaries. Commit message updated respectivvely.
> ---
>  tests/xfs/096 | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/xfs/096 b/tests/xfs/096
> index f949e83..803b49d 100755
> --- a/tests/xfs/096
> +++ b/tests/xfs/096
> @@ -39,6 +39,20 @@ _cleanup()
>      rm -f $tmp.*
>  }
>  
> +# maximum log record size
> +max_lr_size=`expr 256 \* 1024`
> +big_su=`expr $max_lr_size + 4096`
> +
> +requires_mkfs_accept_invalid_log_sunit()
> +{
> +	accepts=`mkfs.xfs -N -l version=2,su=$big_su 2>&1 | \
> +		grep -ci "No device name"`
> +	if [ "$accepts" -eq 0 ];then
> +		_notrun "Runs only on older xfsprogs accepting invalid log sunit"
> +	fi

You're counting the number of "No device name" string, which doesn't
seem reliable to me. I'd prefer to rely on whether mkfs.xfs really
accepts invalid log sunit, so how about:

require_mkfs_accept_invalid_log_sunit()
{
	local fsimg=$tmp.img
	touch $fsimg

	$MKFS_XFS_PROG -N -l version=2,su=$big_su -d name=$fsimg,size=1g >/dev/null 2>&1
	if [ $? -ne 0 ]; then
		_notrun "This test requires v4.5 or older xfsprogs"
	fi
}

(These mkfs argument checks went to v4.7-rc1, and v4.5 is the latest
"older" xfsprogs, right?)

Thanks,
Eryu

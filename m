Received: from ipmail03.adl6.internode.on.net ([150.101.137.143]:43685 "EHLO
        ipmail03.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726995AbfBRD4F (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 17 Feb 2019 22:56:05 -0500
Date: Mon, 18 Feb 2019 14:56:01 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2] generic/299: limit max file size
Message-ID: <20190218035601.GD9805@dastard>
References: <20190218015741.7996-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218015741.7996-1-yuyufen@huawei.com>
Sender: fstests-owner@vger.kernel.org
To: Yufen Yu <yuyufen@huawei.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Feb 18, 2019 at 09:57:41AM +0800, Yufen Yu wrote:
> For some filesystem, such as vfat, the max support file size
> is 4G. We limit the max size and let the test go on running.
> 
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> ---
>  common/rc         | 9 +++++++++
>  tests/generic/299 | 5 +++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index e5da6484..94148029 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3785,6 +3785,15 @@ _require_scratch_feature()
>  	esac
>  }
>  
> +# get mount point filesystem max file size
> +_get_file_max_size()
> +{
> +	local mnt_point=$1
> +
> +	bits=`getconf FILESIZEBITS ${mnt_point}`
> +	echo "$((2**bits-1))"
> +}

Did you test this?

$ echo "$((2**64-1))"
-1
$

>  # The maximum filesystem label length, /not/ including terminating NULL
>  _label_get_max()
>  {
> diff --git a/tests/generic/299 b/tests/generic/299
> index c4d74fc8..175aa6f2 100755
> --- a/tests/generic/299
> +++ b/tests/generic/299
> @@ -33,6 +33,11 @@ NUM_JOBS=$((4*LOAD_FACTOR))
>  BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
>  FILE_SIZE=$((BLK_DEV_SIZE * 512))
>  
> +# filesystem limit max file size
> +max_file_size=$(_get_file_max_size $SCRATCH_MNT)
> +FILE_SIZE=$([ $max_file_size -le $FILE_SIZE ] && \
> +		echo "$max_file_size" || echo "$FILE_SIZE")
> +

It's much easier to read if you use if/then:

max_file_size=$(_get_file_max_size $SCRATCH_MNT)
if [ $max_file_size -lt $FILE_SIZE ]; then
	FILE_SIZE=$max_file_size
fi

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

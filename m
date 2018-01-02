Received: from mx1.redhat.com ([209.132.183.28]:49744 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750726AbeABUFF (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 2 Jan 2018 15:05:05 -0500
Date: Tue, 2 Jan 2018 15:05:01 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH xfstest v2 2/4] overlay: add fsck.overlay whiteout test
Message-ID: <20180102200501.GD15274@redhat.com>
References: <20171228114933.47759-1-yi.zhang@huawei.com>
 <20171228114933.47759-3-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171228114933.47759-3-yi.zhang@huawei.com>
Sender: fstests-owner@vger.kernel.org
To: "zhangyi (F)" <yi.zhang@huawei.com>
Cc: linux-unionfs@vger.kernel.org, fstests@vger.kernel.org, miklos@szeredi.hu, amir73il@gmail.com, eguan@redhat.com, miaoxie@huawei.com, yangerkun@huawei.com
List-ID: <fstests@vger.kernel.org>

On Thu, Dec 28, 2017 at 07:49:31PM +0800, zhangyi (F) wrote:

[..]
> +# Create test directories
> +lowerdir=$OVL_BASE_SCRATCH_MNT/lower
> +lowerdir2=$OVL_BASE_SCRATCH_MNT/lower2
> +upperdir=$OVL_BASE_SCRATCH_MNT/upper
> +workdir=$OVL_BASE_SCRATCH_MNT/workdir
> +
> +mkdir -p $lowerdir $lowerdir2 $upperdir $workdir $workdir

Minor nit. Why $workdir has been specified twice. I saw it in another test
as well.

Vivek


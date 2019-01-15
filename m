Received: from ipmail01.adl6.internode.on.net ([150.101.137.136]:65443 "EHLO
        ipmail01.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726769AbfAODrr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 14 Jan 2019 22:47:47 -0500
Date: Tue, 15 Jan 2019 14:47:43 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] common/scsi_debug: make sure scsi_debug been removed
 correctly
Message-ID: <20190115034743.GS27534@dastard>
References: <20190109054845.93810-1-yangerkun@huawei.com>
 <20190109210243.GG27534@dastard>
 <a91e3234-9a4a-27b4-2382-683f773e892c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a91e3234-9a4a-27b4-2382-683f773e892c@huawei.com>
Sender: fstests-owner@vger.kernel.org
To: yangerkun <yangerkun@huawei.com>
Cc: guaneryu@gmail.com, houtao1@huawei.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, Jan 12, 2019 at 10:20:26AM +0800, yangerkun wrote:
> 
> 
> Dave Chinner wrote on 2019/1/10 5:02:
> >On Wed, Jan 09, 2019 at 01:48:45PM +0800, yangerkun wrote:
> >>Case generic/108 sometimes will fail while testing ext2, and the reson
> >>is that rmmod scsi_debug in _put_scsi_debug_dev may randomly fail. Now
> >>add the loop to do rmmod to make sure scsi_debug can be removed
> >>correctly.
> >
> >Why does 'rmmod scsi_debug' randomly fail?
> >
> >What bug does ext2 have that prevents the scsi debug module from
> >being released and hence removed?
> 
> It's not a bug with ext2, ever been existing in ext4 too. This patch
> is a reference to 'https://gitlab.com/cryptsetup/cryptsetup.git'
> commit d7b9ed05f0931b416c33c8eb2ff1e6efa39270ff, and the reason why
> need this is that the behavior of udev cannot be speculated, so
> scsi_debug may rmmod failed since udev scan open the device and take
> the reference of module scsi_debug.

IOWs, you copied a hack from cryptsetup tests because you didn't
know about $UDEV_SETTLE_PROG and didn't think to ask if anyone knew
a solution to this problem?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

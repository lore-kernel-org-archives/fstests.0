Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:60726 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727753AbfAIVDb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Jan 2019 16:03:31 -0500
Date: Thu, 10 Jan 2019 08:02:43 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] common/scsi_debug: make sure scsi_debug been removed
 correctly
Message-ID: <20190109210243.GG27534@dastard>
References: <20190109054845.93810-1-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109054845.93810-1-yangerkun@huawei.com>
Sender: fstests-owner@vger.kernel.org
To: yangerkun <yangerkun@huawei.com>
Cc: guaneryu@gmail.com, houtao1@huawei.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jan 09, 2019 at 01:48:45PM +0800, yangerkun wrote:
> Case generic/108 sometimes will fail while testing ext2, and the reson
> is that rmmod scsi_debug in _put_scsi_debug_dev may randomly fail. Now
> add the loop to do rmmod to make sure scsi_debug can be removed
> correctly.

Why does 'rmmod scsi_debug' randomly fail?

What bug does ext2 have that prevents the scsi debug module from
being released and hence removed?

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com

Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:31199 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726304AbfBQW31 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 17 Feb 2019 17:29:27 -0500
Date: Mon, 18 Feb 2019 09:29:24 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] generic/299: limit max file size
Message-ID: <20190217222924.GC9805@dastard>
References: <20190216120717.114983-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190216120717.114983-1-yuyufen@huawei.com>
Sender: fstests-owner@vger.kernel.org
To: Yufen Yu <yuyufen@huawei.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, Feb 16, 2019 at 08:07:17PM +0800, Yufen Yu wrote:
> For some filesystem, such as vfat, the max support file size
> is 4G. We limit the max size and let the test go on running.

Can't this be probed?

ext3/xfs/ext4/btrfs/etc:

$ getconf FILESIZEBITS /
64
$

vfat:

$ getconf FILESIZEBITS /mnt/scratch
32
$

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

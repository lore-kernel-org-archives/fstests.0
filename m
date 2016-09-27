Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:13458 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756465AbcI0XzH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 27 Sep 2016 19:55:07 -0400
Date: Wed, 28 Sep 2016 09:55:03 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfs/032: avoid making a 512b block size V5 xfs
Message-ID: <20160927235503.GC9806@dastard>
References: <1474989815-8202-1-git-send-email-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1474989815-8202-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Sep 27, 2016 at 11:23:35PM +0800, Zorro Lang wrote:
> If test on a 512b sector size device, xfs/032 will try to do:
> 
>   mkfs.xfs -s size=512 -b size=512 ...
> 
> The 512b block size is not acceptable for V5 XFS. So I change the
> minimum block size to 1024 if (crc = 1 && sector size < 1024).

Why so complex?

The output of the test is empty, so if mkfs.xfs fails with the given
configuration then just skip the loop iteration and run the next
size.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

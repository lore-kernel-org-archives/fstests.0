Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:26585 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935184AbcKMXP2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 13 Nov 2016 18:15:28 -0500
Date: Mon, 14 Nov 2016 10:15:20 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] generic/38[3-6]: require project quota to be enabled on
 SCRATCH_DEV
Message-ID: <20161113231520.GM28922@dastard>
References: <1478976065-2060-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1478976065-2060-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Nov 13, 2016 at 02:41:05AM +0800, Eryu Guan wrote:
> generic/38[3-6] are made generic from xfs tests to test project
> quota on other filesystems, e.g. ext4. But we should make sure
> project quota is enabled in between of _scratch_enable_pquota and
> _qmount. Otherwise mount will fail if there's no project quota
> support on SCRATCH_DEV, e.g. ext2 and ext3.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>

looks fine.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com

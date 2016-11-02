Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:20281 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751563AbcKBBPr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 1 Nov 2016 21:15:47 -0400
Date: Wed, 2 Nov 2016 12:15:14 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v4] generic: make 17[1-4] work well when btrfs
 compression is enabled
Message-ID: <20161102011514.GD9920@dastard>
References: <20161101084503.6578-1-wangxg.fnst@cn.fujitsu.com>
 <5818571E.8020806@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5818571E.8020806@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, eguan@redhat.com, darrick.wong@oracle.com
List-ID: <fstests@vger.kernel.org>

On Tue, Nov 01, 2016 at 04:49:34PM +0800, Wang Xiaoguang wrote:
> hi Darrick,
> 
> Common/populate needs xfs_io supports falloc and fpunch,
> so I didn't put _fill_fs() in common/populate.

Tests will include common/rc first, and so pick up the functionality
_fill_fs requires before it's included from common/populate. So
there is no reason to put it in common/rc.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

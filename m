Received: from aserp1050.oracle.com ([141.146.126.70]:46639 "EHLO
        aserp1050.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754375AbcHXXGG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 24 Aug 2016 19:06:06 -0400
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
        by aserp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id u7ON5Ubl021438
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <fstests@vger.kernel.org>; Wed, 24 Aug 2016 23:05:31 GMT
Date: Wed, 24 Aug 2016 16:03:13 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: question about xfs/122
Message-ID: <20160824230313.GD8265@birch.djwong.org>
References: <57BD53DC.30605@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57BD53DC.30605@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

[cc list]

On Wed, Aug 24, 2016 at 03:59:24PM +0800, Xiao Yang wrote:
> Hi Darrick
> 
> When i run xfstests test case xfs/122 on RHEL7.3Alpha with xfsprog-dev(4.7.0),
> I always get following error:
> ------------------------------------------------------------------
> -sizeof(xfs_dsb_t) = 272
> +sizeof(xfs_dsb_t) = 264
> ------------------------------------------------------------------
> 
> I find that the size of xfs_dsb structure is still 264 on xfsprog-dev(4.7.0).
> I'm wondering if the releated patch hasn't been pushed into xfsprog-dev?

The XFS superblock will be expanding to 272 bytes to record the
realtime rmap btree inode.

--D

> 
> Please advise. Thanks very much.
> 
> Regards,
> Xiao Yang
> 
> 
> 

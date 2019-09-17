Received: from aserp2120.oracle.com ([141.146.126.78]:40964 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbfIQQjm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 17 Sep 2019 12:39:42 -0400
Date: Tue, 17 Sep 2019 09:39:33 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: question of xfs/148 and xfs/149
Message-ID: <20190917163933.GC736475@magnolia>
References: <4BF2FD5A942B1C4B828DDAF5635768C1041AB0E2@G08CNEXMBPEKD02.g08.fujitsu.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BF2FD5A942B1C4B828DDAF5635768C1041AB0E2@G08CNEXMBPEKD02.g08.fujitsu.local>
Sender: fstests-owner@vger.kernel.org
To: "Xu, Yang" <xuyang2018.jy@cn.fujitsu.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>, xfs <linux-xfs@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

[add linux-xfs to cc]

On Tue, Sep 17, 2019 at 09:00:57AM +0000, Xu, Yang wrote:
> HI All
> 
> When I investigated xfs/030 failure on upstream kernel after mering
> xfstests commit d0e484ac699f ("check: wipe scratch devices between
> tests"), I found two similar cases(xfs/148,xfs/149).
> 
> xfs/148 is a clone of test 030 using xfs_prepair64 instead of xfs_repair.
> xfs/149 is a clone of test 031 using xfs_prepair instead of xfs_repair
> 
> But I don't find these two commands and know nothing about them.  If
> these commands have been obsoleted long time ago, I think we can
> remove the two cases. Or may I miss something?

<shrug> I think your analysis is correct, but let's see what the xfs
list thinks.

--D

> 
> Thanks
> Yang Xu
> 
> 

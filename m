Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:49362 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726981AbfHPLaV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 16 Aug 2019 07:30:21 -0400
Date: Fri, 16 Aug 2019 19:30:18 +0800
From: Eryu Guan <eguan@linux.alibaba.com>
Subject: Re: [PATCH] fstests: btrfs: Check snapshot creation and deletion
 with dm-logwrites
Message-ID: <20190816113018.GJ52397@e18g06458.et15sqa>
References: <20190814105544.18318-1-wqu@suse.com>
 <CAL3q7H5v6jrFcKupRBZ9EnaQDKM2UooK3iwOgJ01wTvqMtizcw@mail.gmail.com>
 <21a7b532-c16d-c014-e714-e280d0a1850a@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21a7b532-c16d-c014-e714-e280d0a1850a@gmx.com>
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>, fstests <fstests@vger.kernel.org>, linux-btrfs <linux-btrfs@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri, Aug 16, 2019 at 05:47:33PM +0800, Qu Wenruo wrote:
[...]
> >> +$KILLALL_PROG -q $FSSTRESS_PROG &> /dev/null
> > 
> > You're very inconsistent within the same test :) Using both ">
> > /dev/null 2>&1" and "&> /dev/null".
> 
> My bad, I mean 2>&1 > /dev/null.
> What I mean is output stderr while skip stdout in previous calls.

Then just do "2>/dev/null", the test harness will capture both stdout
and stderr. "2>&1 > /dev/null" is less used and usually indicates a
mis-usage :)

Thanks,
Eryu

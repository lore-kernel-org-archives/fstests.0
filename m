Received: from mx1.redhat.com ([209.132.183.28]:40104 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752545AbdI0Jqr (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 27 Sep 2017 05:46:47 -0400
Date: Wed, 27 Sep 2017 17:46:44 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2] fstests: btrfs/150 regression test for reading
 compressed data
Message-ID: <20170927094644.GO8034@eguan.usersys.redhat.com>
References: <20170920235243.11822-1-bo.li.liu@oracle.com>
 <20170922232127.12032-1-bo.li.liu@oracle.com>
 <20170926090236.GI8034@eguan.usersys.redhat.com>
 <20170926233752.GB27095@lim.localdomain>
 <20170927001851.GA22418@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170927001851.GA22418@localhost.localdomain>
Sender: fstests-owner@vger.kernel.org
To: Liu Bo <bo.li.liu@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Sep 26, 2017 at 05:18:51PM -0700, Liu Bo wrote:
> On Tue, Sep 26, 2017 at 04:37:52PM -0700, Liu Bo wrote:
> > On Tue, Sep 26, 2017 at 05:02:36PM +0800, Eryu Guan wrote:
> > > On Fri, Sep 22, 2017 at 05:21:27PM -0600, Liu Bo wrote:
> > > > We had a bug in btrfs compression code which could end up with a
> > > > kernel panic.
> > > > 
> > > > This is adding a regression test for the bug and I've also sent a
> > > > kernel patch to fix the bug.
> > > > 
> > > > The patch is "Btrfs: fix kernel oops while reading compressed data".
> > > > 
> > > > Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
> > > 
> > > Hmm, I can't reproduce the panic with 4.13 kernel, which doesn't have
> > > the fix applied. Can you please help confirm if it panics on your test
> > > environment?
> > >
> > 
> > Yes, it is reproducible on my box, hrm...I'll be running it more times
> > to double check.
> > 
> 
> It worked for me...both v4.13 and v4.14.0-rc2 have the following
> messages[1].
> 
> This requires two config:
> CONFIG_FAULT_INJECTION=y
> CONFIG_FAULT_INJECTION_DEBUG_FS=y
> 
> Could you please check again?

I re-compiled 4.14-rc2 kernel on my test vm with FAIL_MAKE_REQUEST
enabled (which requires FAULT_INJECTION), and I can reproduce the crash
now. It was so weired that previously I did have FAIL_MAKE_REQUEST
enabled and test ran normally without hitting the bug, but now I can hit
the bug quite reliably. Not sure what was happning in my previous test..

Thanks for confirming!

Eryu

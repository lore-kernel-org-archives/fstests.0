Received: from mx1.redhat.com ([209.132.183.28]:39648 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751524AbeA1Kqu (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 28 Jan 2018 05:46:50 -0500
Date: Sun, 28 Jan 2018 18:46:47 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2 4/8] metaperf: Include linux/param.h explicitly for HZ
 macro
Message-ID: <20180128104647.GO18267@eguan.usersys.redhat.com>
References: <1516636639-9107-1-git-send-email-rostislav@tuxera.com>
 <1516636639-9107-5-git-send-email-rostislav@tuxera.com>
 <20180122202406.GD16776@infradead.org>
 <20180124035859.GA30514@eguan.usersys.redhat.com>
 <20180125000215.qlbpu5i37luul6cl@destitution>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180125000215.qlbpu5i37luul6cl@destitution>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@infradead.org>, Rostislav Skudnov <rostislav@tuxera.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jan 25, 2018 at 11:02:15AM +1100, Dave Chinner wrote:
> On Wed, Jan 24, 2018 at 11:58:59AM +0800, Eryu Guan wrote:
> > On Mon, Jan 22, 2018 at 12:24:06PM -0800, Christoph Hellwig wrote:
> > > On Mon, Jan 22, 2018 at 03:57:15PM +0000, Rostislav Skudnov wrote:
> > > > Glibc includes linux/param.h when we include sys/param.h, whereas musl
> > > > libc does not do that. HZ is a Linux-specific macro, therefore include
> > > > the header file that defines it explicitly.
> > > > 
> > > > Signed-off-by: Rostislav Skudnov <rostislav@tuxera.com>
> > > 
> > > Using HZ in userspace doesn't make any sense at all.  The kernel HZ
> > > (as in the granulairy for jiffies) can vary between architectures
> > > and even configurations.  I guess it wants a hard coded 100 here, but
> > > someone will have to do a detailed analysis.
> > 
> > No one is using metaperf now, all the old benchmark infrastructure was
> > removed by commit b020416d51ff ("xfstests: remove bench infrastructure")
> > 
> > I think we can remove src/metaperf.c too.
> 
> I use metaperf (and dirperf) quite regularly when testing my
> patches, so I'd really like them to remin available on all my test
> machines that have fstests installed....

Thanks for the heads-up! Let's keep dmiperf.c and metaperf.c then.

I tend to take this patch as is for now to fix the build problem with
musl libc first. I think the "using HZ in userspace problem" is another
issue which can be fixed by a separate patch (if necessary and someone
has interest).

Thanks,
Eryu

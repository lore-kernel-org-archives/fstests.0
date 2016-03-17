Received: from mx1.redhat.com ([209.132.183.28]:44684 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752334AbcCQD2E (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 16 Mar 2016 23:28:04 -0400
Date: Thu, 17 Mar 2016 11:28:02 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfs/073: filter out finobt warning from mkfs.xfs
Message-ID: <20160317032801.GU11419@eguan.usersys.redhat.com>
References: <1458129204-31882-1-git-send-email-eguan@redhat.com>
 <20160316120416.GA18030@infradead.org>
 <20160316145418.GT11419@eguan.usersys.redhat.com>
 <20160316200043.GG11812@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160316200043.GG11812@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@infradead.org>, fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 17, 2016 at 07:00:43AM +1100, Dave Chinner wrote:
> On Wed, Mar 16, 2016 at 10:54:18PM +0800, Eryu Guan wrote:
> > On Wed, Mar 16, 2016 at 05:04:16AM -0700, Christoph Hellwig wrote:
> > > On Wed, Mar 16, 2016 at 07:53:24PM +0800, Eryu Guan wrote:
> > > > When testing xfs/073 with MKFS_OPTIONS="-m crc=1,finobt=1" set, it fails
> > > > due to extra warning about disabling finobt feature:
> > > > 
> > > >  +warning: finobt not supported without CRC support, disabled.
> > > > 
> > > > Because xfs/073 disables crc unconditionally and finobt can not be
> > > > enabled either.
> > > 
> > > How about explicitly disabling finobt as well?
> > 
> > I think that's a cleaner way to fix it. Just that some extra work is
> > needed to let the test pass with old mkfs.xfs without metadata suport.
> 
> This is a downhill slope. e.g. if I add "-i sparse=1" to the mkfs
> line, it will warning differently and a new filter is needed. I
> would suggest just ignoring the mkfs output altogether (maybe just
> dumping it all to $seqres.full) as it's not necessary to determine
> whether the test ran correctly or not.

Yes, other tests that call _scratch_mkfs_xfs with explicit "-m crc=0"
all redirect output to null or $seqres.full, so I only see the warning
in xfs/073. I'd like to do the same for it.

I think the update to _scratch_mkfs_xfs_opts() in v2 patch is still
worth doing, it belongs to a seperate patch though.

Thanks,
Eryu

Received: from mx1.redhat.com ([209.132.183.28]:32904 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752315AbdGFDLH (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 5 Jul 2017 23:11:07 -0400
Date: Thu, 6 Jul 2017 11:10:55 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/247: unmount test device, not scratch device
Message-ID: <20170706031055.GX23360@eguan.usersys.redhat.com>
References: <20170705203754.92140-1-ebiggers3@gmail.com>
 <20170706025059.GW23360@eguan.usersys.redhat.com>
 <20170706025428.GA595@zzz.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170706025428.GA595@zzz.localdomain>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Brian Foster <bfoster@redhat.com>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Jul 05, 2017 at 07:54:28PM -0700, Eric Biggers wrote:
> On Thu, Jul 06, 2017 at 10:50:59AM +0800, Eryu Guan wrote:
> > On Wed, Jul 05, 2017 at 01:37:54PM -0700, Eric Biggers wrote:
> > > From: Eric Biggers <ebiggers@google.com>
> > > 
> > > Commit d55123c080cb ("generic/247: filter out expected XFS warnings for
> > > mixed mmap/direct I/O") made generic/247 start explicitly unmounting the
> > > scratch device.  However, the test doesn't actually use the scratch
> > > device, so it will fail if SCRATCH_DEV is undefined.  Fix it by
> > > unmounting the test device instead.
> > > 
> > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > 
> > Thanks for the fix! I found this in my review and I remembered I removed
> > the _scratch_unmount and updated the comments accordingly at commit
> > time, but clearly I didn't.
> > 
> 
> It was removed from generic/095 (maybe by accident?) but not generic/247.
> Perhaps it needs to be added back to generic/095?

You're right, I updated the wrong test.. Yeah, it should be added back
to generic/095. Would you mind sending a v2 patch to do these edits all
together? i.e. add _scratch_unmount (and comments) back to generic/095
and remove them from generic/247?

Thanks,
Eryu

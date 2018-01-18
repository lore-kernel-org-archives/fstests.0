Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:5403 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932166AbeARX1B (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 18 Jan 2018 18:27:01 -0500
Date: Fri, 19 Jan 2018 10:26:44 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: ext4 quota tests fail with CONFIG_QFMT_V2=n
Message-ID: <20180118232644.GJ16421@dastard>
References: <20180118010936.GA10649@vader>
 <20180118012831.GF6948@thunk.org>
 <20180118021610.GA10877@vader>
 <20180118040819.GI6948@thunk.org>
 <20180118081713.GB10877@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180118081713.GB10877@vader>
Sender: fstests-owner@vger.kernel.org
To: Omar Sandoval <osandov@osandov.com>
Cc: Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org, Jan Kara <jack@suse.cz>, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Jan 18, 2018 at 12:17:13AM -0800, Omar Sandoval wrote:
> On Wed, Jan 17, 2018 at 11:08:19PM -0500, Theodore Ts'o wrote:
> > On Wed, Jan 17, 2018 at 06:16:10PM -0800, Omar Sandoval wrote:
> > > > I'd like to ask a different question, which is there a reason to
> > > > support CONFIG_QFMT_V1 && !CONFIG_QFMT_V2?  Maybe we should just
> > > > always enable CONFIG_QFMT_V2, and simplify the test matrix?
> > > 
> > > FWIW,
> > > 
> > > # CONFIG_QFMT_V1 is not set
> > > # CONFIG_QFMT_V2 is not set
> > > 
> > > on this kernel.
> > 
> > Huh.... I don't think that's a valid kernel configuration at all.  Or
> > rather, it's allowed by Kconfig, but it shouldn't be, since without
> > any quota formats enabled, the quota code is completely useless, and
> > you might as well not compile it in, as near as I can tell.
> > 
> > Was this configuration one that you were deliberately using; and if
> > so, what for?   Or was it one that was created accidentally?
> 
> It's not intentional. I'm assuming what happened here is we disabled any
> modules we weren't using, but CONFIG_QUOTA happened to stay on. Is it
> also the case for XFS that quotas are useless without qfmt-v2?

XFS quotas are completely independent of the generic CONFIG_QUOTA
stuff. From fs/xfs/Kconfig:

config XFS_QUOTA
        bool "XFS Quota support"
        depends on XFS_FS
        select QUOTACTL
        help
.....

So it's fully controlled by CONFIG_XFS_QUOTA...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

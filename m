Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:10330 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751220AbdL1VWJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 28 Dec 2017 16:22:09 -0500
Date: Fri, 29 Dec 2017 08:21:54 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: xfstests: generic/342 run failed in f2fs
Message-ID: <20171228212154.GR5858@dastard>
References: <2d524305-ecb5-8600-a92a-d79b717b8d13@intel.com>
 <e367054d-046d-d6e5-943c-7fbe10493029@sandeen.net>
 <d20cb58e-6646-a7de-bff1-8b7783a30664@intel.com>
 <d5ff659d-c659-ca47-3999-2f4b16629e42@sandeen.net>
 <20171225163102.GB14399@thunk.org>
 <20171227191130.GB13490@jaegeuk-macbookpro.roam.corp.google.com>
 <20171228090903.GQ5858@dastard>
 <a4091bfd-a054-b157-00c8-806357da7183@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4091bfd-a054-b157-00c8-806357da7183@sandeen.net>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Theodore Ts'o <tytso@mit.edu>, Chen Rong <rongx.a.chen@intel.com>, fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, philip.li@intel.com
List-ID: <fstests@vger.kernel.org>

On Thu, Dec 28, 2017 at 08:59:18AM -0800, Eric Sandeen wrote:
> On 12/28/17 1:09 AM, Dave Chinner wrote:
> ...
> 
> > There's a whole lot more detail in the kernel commit 2be63d5ce929
> > ("Btrfs: fix file loss on log replay after renaming a file and
> > fsync") but my point is that we considered this a btrfs filesystem
> > bug and so changing the test defeats it's purpose as a regression
> > test for the btrfs bug.
> > 
> > So IMO the test should not be changed. And I think we should be
> > consistent and consider this f2fs failure as a f2fs bug that needs
> > fixing to bring it's behaviour in line with xfs, ext4, and btrfs.
> > 
> > Remember this when quoting POSIX about fsync behaviour: Posix is a
> > terrible standard when it comes to data integrity. We go way, way
> > beyond what POSIX specifies as a valid fsync implementation (i.e.
> > posix allows "do nothing and return success" as a conformant
> > implementation). Ext4, XFS and btrfs all have strictly ordered
> > metadata crash recovery semantics and all of the crash recovery
> > tests expect this behaviour from the filesytem being tested. The
> > underlying intention is that by encoding it into these tests, all
> > widely used and future linux filesystems meet or exceed this crash
> > integrity requirement.
> > 
> > IOWs, changing the test is the wrong thing to do on many levels....
> > 
> > Cheers,
> > 
> > Dave.
> > 
> 
> Thanks for digging into the btrfs commit which changed the behavior
> tested by this testcase, I had meant to do that. 
> 
> Yeah, that's all fair, for sure.  But this shouldn't be implicit in the
> testcase; it should explicitly document that it is testing a de-facto
> new standard adhered to by several filesystems, what that standard is,
> etc, and not leave it to the reader.  ;)  

Well, the point of the test case is to catch recovery behaviour
that is not properly ordered in this complex corner case. It's not
an obvious thing for developers to test, as we can see by both btrfs
and now f2fs failing this test.

What that failure actually means and implies is completely separate
to the test itself. i.e. the test is just a canary that tells us a
filesystem is not strictly ordered in it's crash recovery behaviour.
If we don't have tests somewhere that exercise the behaviour we want
filesystems to have, we'll never know if a filesystem does or
doesn't behave as we want them to.

The fact we'd like all filesystems to have strictly ordered crash
recovery semantics has nothing to do with the test. It's based on
the fact that XFS and ext3/4 have had this behaviour since forever,
and apps written on these filesystems are quite likely to skip
the directory fsync() because it's not necessary. That's seen by
btrfs users reporting lost files where other filesystems are fine.

We want all linux filesystems to behave the same way in these
circumstances, but we can't enforce it because....

> If a filesystem explicitly chooses not to adhere to that standard they
> /could/ opt out of the test.

... that is a option the filesystem developers can take.

> It's makes a lot of sense for linux filesystems to behave in consistent
> ways, but if we're going to start enforcing that through xfstests we
> need to be very clear about it, IMHO.

xfstests is not the way we enforce it - it's just tells us something
is inconsistent. What the fs developers do from there (fix it or
skip the test) is up to them.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

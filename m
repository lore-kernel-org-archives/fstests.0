Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:45555 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752475AbbBXMtx (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 24 Feb 2015 07:49:53 -0500
Date: Tue, 24 Feb 2015 23:49:38 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] ext4: add regression tests for ^extents punch hole
Message-ID: <20150224124938.GB4251@dastard>
References: <4c557308eb4e62752dc8b513495cb6d46ca5775d.1424730653.git.osandov@osandov.com>
 <20150223224620.GL12722@dastard>
 <alpine.LFD.2.00.1502241106110.28736@localhost.localdomain>
 <20150224113108.GA4251@dastard>
 <alpine.LFD.2.00.1502241249300.28736@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.LFD.2.00.1502241249300.28736@localhost.localdomain>
Sender: fstests-owner@vger.kernel.org
To: =?utf-8?B?THVrw6HFoQ==?= Czerner <lczerner@redhat.com>
Cc: Omar Sandoval <osandov@osandov.com>, fstests@vger.kernel.org, linux-ext4@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Feb 24, 2015 at 12:52:00PM +0100, Lukáš Czerner wrote:
> On Tue, 24 Feb 2015, Dave Chinner wrote:
> > > it's not that long ago when we discussed very similar case, where
> > > directly in the test itself the author would specify mkfs options. I
> > > had the same comment as you have here and you argued that the test
> > > was made specifically to test that mkfs option. I agree.
> > 
> > The case I remember and was basing this off was commit 448efe1
> > ("generic/017: Do not create file systems with different block
> > sizes") where you made the argument that we shouldn't be setting
> > mkfs parameters inside the test and instead those specific cases
> > would be tested by using test-wide mkfs parameters....
> > 
> > I don't recall any other discussion, so maybe you should remind me
> > of it....
> 
> Here it is
> 
> http://www.spinics.net/lists/fstests/msg00073.html
> 
> specifically your paragraph:
> 
> "No, I'm not advocating that at all. If the test has a specific
> reason for overriding the user configuration, then it should.
> Some configurations are rarely tested, and so having some tests that
> exercise them even when other options are being tested is not a bad
> thing. We catch problem with new changes much faster that way."

Ah, right, I said that was during the discussion about the commit I
quoted above. You convinced me that we shouldn't cater for special
cases like this and instead iterate mkfs/mount configurations.
On that basis I committed your patch to remove the special cases
from generic/017.

> I do not really want to hold your words against you but the thing is
> that I changed my mind since then and I do agree with that, because
> it really is useful for testing specific cases where we already had
> problems before. And this test is one of those cases.

<sigh>

/me shakes his head, wonders how other maintainers stay sane

I think the test should still be generic and block size independent,
but if you want to force ext4 to turn off the extents flag, then
use something like this:

[ "$FSTYP" = "ext4" ] && MKFS_OPTIONS="-O ^extents $MKFS_OPTIONS"

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:19341 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751498AbbBXLbY (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 24 Feb 2015 06:31:24 -0500
Date: Tue, 24 Feb 2015 22:31:08 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] ext4: add regression tests for ^extents punch hole
Message-ID: <20150224113108.GA4251@dastard>
References: <4c557308eb4e62752dc8b513495cb6d46ca5775d.1424730653.git.osandov@osandov.com>
 <20150223224620.GL12722@dastard>
 <alpine.LFD.2.00.1502241106110.28736@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.LFD.2.00.1502241106110.28736@localhost.localdomain>
Sender: fstests-owner@vger.kernel.org
To: =?utf-8?B?THVrw6HFoQ==?= Czerner <lczerner@redhat.com>
Cc: Omar Sandoval <osandov@osandov.com>, fstests@vger.kernel.org, linux-ext4@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Feb 24, 2015 at 11:11:04AM +0100, Lukáš Czerner wrote:
> On Tue, 24 Feb 2015, Dave Chinner wrote:
> 
> > Date: Tue, 24 Feb 2015 09:46:20 +1100
> > From: Dave Chinner <david@fromorbit.com>
> > To: Omar Sandoval <osandov@osandov.com>
> > Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org
> > Subject: Re: [PATCH] ext4: add regression tests for ^extents punch hole
> > 
> > On Mon, Feb 23, 2015 at 02:39:36PM -0800, Omar Sandoval wrote:
> > > Linux commit 6f30b7e37a82 (ext4: fix indirect punch hole corruption)
> > > fixes several bugs in the FALLOC_FL_PUNCH_HOLE implementation for an
> > > ext4 filesystem with indirect blocks.
> > > 
> > > Signed-off-by: Omar Sandoval <osandov@osandov.com>
> > > ---
> > >  tests/ext4/005     | 115 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  tests/ext4/005.out |  29 ++++++++++++++
> > >  tests/ext4/group   |   1 +
> > >  3 files changed, 145 insertions(+)
> > >  create mode 100755 tests/ext4/005
> > >  create mode 100644 tests/ext4/005.out
> > 
> > What's ext4 specific about this test apart from the mkfs parameter?
> > Shouldn't it be generic and so test all the filesystems behave the
> > same?  i.e. when someone then runs
> > 
> > # MKFS_OPTIONS="-b size=1k -O ^extents" ./check -g auto
> > 
> > That will exercise this specific regression fix, not to mention give
> > much, much better test coverage of that configuration than just
> > making a single test use that config...
> > 
> > Cheers,
> > 
> > Dave.
> 
> Hi Dave,
> 
> it's not that long ago when we discussed very similar case, where
> directly in the test itself the author would specify mkfs options. I
> had the same comment as you have here and you argued that the test
> was made specifically to test that mkfs option. I agree.

The case I remember and was basing this off was commit 448efe1
("generic/017: Do not create file systems with different block
sizes") where you made the argument that we shouldn't be setting
mkfs parameters inside the test and instead those specific cases
would be tested by using test-wide mkfs parameters....

I don't recall any other discussion, so maybe you should remind me
of it....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:58192 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753785AbcKJEG1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Nov 2016 23:06:27 -0500
Date: Thu, 10 Nov 2016 15:06:21 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] fstests: btrfs: Check false ENOSPC bug caused by
 incorrect metadata reserve
Message-ID: <20161110040621.GX28177@dastard>
References: <20161108091515.20867-1-quwenruo@cn.fujitsu.com>
 <20161108105826.GN27776@eguan.usersys.redhat.com>
 <d9a9d224-2f21-5b77-a3e9-de271cd4e755@cn.fujitsu.com>
 <20161109094341.GY27776@eguan.usersys.redhat.com>
 <6ae5fc6d-afbb-c284-190e-a0d2625cff25@cn.fujitsu.com>
 <20161110021944.GW28177@dastard>
 <c2e2eb35-e87a-90f7-9746-946a0995549a@cn.fujitsu.com>
 <20161110032434.GB27776@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161110032434.GB27776@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Qu Wenruo <quwenruo@cn.fujitsu.com>, linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Nov 10, 2016 at 11:24:34AM +0800, Eryu Guan wrote:
> On Thu, Nov 10, 2016 at 10:42:36AM +0800, Qu Wenruo wrote:
> > 
> > 
> > At 11/10/2016 10:19 AM, Dave Chinner wrote:
> > > On Thu, Nov 10, 2016 at 08:34:20AM +0800, Qu Wenruo wrote:
> > > > At 11/09/2016 05:43 PM, Eryu Guan wrote:
> > > > > On Wed, Nov 09, 2016 at 08:24:38AM +0800, Qu Wenruo wrote:
> > > > > > At 11/08/2016 06:58 PM, Eryu Guan wrote:
> > > > > > > On Tue, Nov 08, 2016 at 05:15:15PM +0800, Qu Wenruo wrote:
> > > > > We should use helpers and not open-code when helpers are available. So
> > > > > we should really use _scratch_mkfs_sized here.
> > > > > 
> > > > > And "-n 64k" is only to make bug easier to reproduce, but I don't think
> > > > > it's necessary. In my testings, 50%-75% runs hit the ENOSPC failure on
> > > > > my x86_64 test vm, even I removed the "-n 64k" mkfs option from the
> > > > > test.
> > > > > 
> > > > > So I'd say remove "-n 64k" and test whatever mkfs options user
> > > > > specified.
> > > > 
> > > > I really don't like the idea to allow user to override any mount
> > > > option to reduce the possibility.
> > > 
> > > That's not the point. Overriding mount options reduces test coverage
> > > because it limits the test to only the exact configuration that
> > > reproduced the bug that was seen. If a user is testing a specific
> > > configuration, then we really want to run the test on that config.
> > > 
> > > > And further more, this testcase is not a generic test, but a
> > > > regression/pinpoint test to expose one specific bug.
> > > 
> > > If you want to make sure that the bug doesn't return, then you need
> > > to run the /entire test suite/ with the configuration that exposes
> > > the problem. You wouldn't be suggesting this specific set of mount
> > > options if users weren't using that configuration. Hence you really
> > > need to run the entire test suite with that configuration to make
> > > sure you haven't broken those user's systems....
> > > 
> > > And, yes, I test lots of different XFS configurations in their
> > > entirity every day on every change I make or review, so I'm not
> > > suggesting that you should do anything I don't already do.
> > 
> > OK, most of your points makes sense.
> > I'll update the case.
> > 
> > And I want to make it clear, doesn it mean, newly submitted test case
> > shouldn't specify any mkfs/mount option?
> 
> My understanding is that if test needs a extremely rare configuration to
> hit a bug, then it should specify mkfs/mount options, e.g. xfs/297 tests
> a bug in XFS only in very specific configuration:
> 
> _scratch_mkfs_xfs -d agcount=16,su=256k,sw=12 -l su=256k,size=5120b >/dev/null 2>&1

Yes, but there's a key reason we can do this for /XFS/. I point this
out every time this comes up:

	We can do this with /XFS/ because the *implementation of
	_scratch_mkfs_xfs()* has a fallback strategy on failure.

That is, _scratch_mkfs_xfs will first try to make the filesystems
with $MKFS_OPTIONS + $TEST_SUPPLIED_OPTIONS. If that fails, it then
runs mkfs with just $TEST_SUPPLIED_OPTIONS.

IOWs, XFS always tries to use the global options, and only removes
them when there is a problem combining them with
$TEST_SUPPLIED_OPTIONS.

This is how custom test options should be applied for all
filesystems, not just XFS. It gets rid of the need for any test to
care about MKFS_OPTIONS.

What we are also missing is that we need to apply this process to
scratch mount options as we don't do it for any filesystem.
That will get rid of the need for tests to care about what is in
MOUNT_OPTIONS, too...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

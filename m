Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:45250 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751365AbaFXGpa (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 24 Jun 2014 02:45:30 -0400
Date: Tue, 24 Jun 2014 16:45:26 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/2] generic/017: Do not create file systems with
 different block sizes
Message-ID: <20140624064525.GH9508@dastard>
References: <1403535255-14601-1-git-send-email-lczerner@redhat.com>
 <1403535255-14601-2-git-send-email-lczerner@redhat.com>
 <20140624043835.GF9508@dastard>
 <alpine.LFD.2.00.1406240643160.2556@localhost.localdomain>
 <20140624054854.GG9508@dastard>
 <alpine.LFD.2.00.1406240802370.2556@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.LFD.2.00.1406240802370.2556@localhost.localdomain>
Sender: xfstests-owner@vger.kernel.org
To: =?utf-8?B?THVrw6HFoQ==?= Czerner <lczerner@redhat.com>
Cc: fstests@vger.kernel.org, fdmanana@gmail.com
List-ID: <fstests@vger.kernel.org>

On Tue, Jun 24, 2014 at 08:17:17AM +0200, Lukáš Czerner wrote:
> On Tue, 24 Jun 2014, Dave Chinner wrote:
> > > That's
> > > why I removed it. What was done in this test was entirely
> > > unnecessary and was not done in any other similar test before.
> > 
> > Not true.  There are tests that override user specified configs all
> > over the place. There's at least 50 calls to _scratch_mkfs_xfs with
> > specific options across all the XFS tests, some of which
> > specifically override block size so they can test sub-page block
> > size behaviour.
> 
> I said similar test, like other fallocate variants. Looking at the
> tests there are three xfs tests that set block size and all of them
> seems to have a reason to do so. None of them iterate through all
> possible variants of block size.

True, but we do iterate over other options, like all the different
quota configurations.

My point is that tests should be able to iterate if they need to
exercise boundary conditions. It doesn't matter if it is block size
or quota or btree leaf size or allocation cluster size. The point is
that we can iterate them in a single test *all the time* rather on
the rare occasion that someone runs with the specific test that
exercises the corner case in question.

> > Indeed, there's a bunch of specific options passed into
> > _scratch_mkfs in the btrfs tests, too, so this sort of constrained
> > test configuration behaviour is not limited to just XFS.
> > 
> > IOWs, what needs to happen here is that btrfs needs to grow an
> > equivalent _scratch_mkfs_btrfs that drops conflicting options and
> > filters unsupported options so that tests don't need to care about
> > what a filesystem supports or doesn't support....
> > 
> > > Yes, we can test all block size in every test from now on, but
> > > what's the point?  We have a config file and the user can set
> > > whatever block size he wants to test. I do not dispute that there
> > > is a time when we really want to set a specific mkfs options in
> > > the test, but this is not the case at all.
> > 
> > Most people don't test multiple different block sizes, so unless
> > there is excessive runtime saying "but you can specify it manually"
> > is not a valid reason for preventing a single test from iterating
> > over multiple mkfs and/or mount configurations.
> 
> That applies to most of the tests and most of the mkfs/mount
> options. And what you're asking for is that people will start to
> write tests which iterate through their favourite options within the
> test itself for no real reason.

No, I'm not advocating that at all. If the test has a specific
reason for overriding the user configuration, then it should.
Some configurations are rarely tested, and so having some tests that
exercise them even when other options are being tested is not a bad
thing. We catch problem with new changes much faster that way.

IOWs, if there is a need to exercise configuration corner cases,
then it can be done within a single test. If it's not testing such
corner cases, then iteration is not necessary. And for this test,
it's exercising sub-page block size behaviour, and so iteration over
different block sizes is just fine....

> The result will be that those of us
> who actually run xfstests for different configuration will get much
> longer runtime.

Not if we review tests appropriately. ;)

Are you having problems with the runtime of this test?

> I think that xfstests should have a policy not to allow this to
> happen, but you obviously think otherwise...

... because the long standing policy has been "tests can force
whatever configuration they need to exercise the functionality in
question". You're advocating that we don't allow tests to do this,
i.e so the only time sub-page block size functionality is tested is
when the entire test suite is run with that specific configuration.

The idea of a regression test suite is to exercise as much
functionality as it can as quickly as it can. To adopt apolicy that
excludes entire classes of code paths unless the user specifically
configures the test suite to exercise those paths is Just Plain
Wrong...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

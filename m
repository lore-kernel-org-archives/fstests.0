Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:27233 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751407AbaFXJIV (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 24 Jun 2014 05:08:21 -0400
Date: Tue, 24 Jun 2014 11:08:08 +0200 (CEST)
From: =?ISO-8859-15?Q?Luk=E1=A8_Czerner?= <lczerner@redhat.com>
Subject: Re: [PATCH 2/2] generic/017: Do not create file systems with different
 block sizes
In-Reply-To: <20140624064525.GH9508@dastard>
Message-ID: <alpine.LFD.2.00.1406241027530.2210@localhost.localdomain>
References: <1403535255-14601-1-git-send-email-lczerner@redhat.com> <1403535255-14601-2-git-send-email-lczerner@redhat.com> <20140624043835.GF9508@dastard> <alpine.LFD.2.00.1406240643160.2556@localhost.localdomain> <20140624054854.GG9508@dastard>
 <alpine.LFD.2.00.1406240802370.2556@localhost.localdomain> <20140624064525.GH9508@dastard>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1754211362-1403600891=:2210"
Sender: xfstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, fdmanana@gmail.com
List-ID: <fstests@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1754211362-1403600891=:2210
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Tue, 24 Jun 2014, Dave Chinner wrote:

> Date: Tue, 24 Jun 2014 16:45:26 +1000
> From: Dave Chinner <david@fromorbit.com>
> To: Lukáš Czerner <lczerner@redhat.com>
> Cc: fstests@vger.kernel.org, fdmanana@gmail.com
> Subject: Re: [PATCH 2/2] generic/017: Do not create file systems with
>     different block sizes
> 
> On Tue, Jun 24, 2014 at 08:17:17AM +0200, Lukáš Czerner wrote:
> > On Tue, 24 Jun 2014, Dave Chinner wrote:
> > > > That's
> > > > why I removed it. What was done in this test was entirely
> > > > unnecessary and was not done in any other similar test before.
> > > 
> > > Not true.  There are tests that override user specified configs all
> > > over the place. There's at least 50 calls to _scratch_mkfs_xfs with
> > > specific options across all the XFS tests, some of which
> > > specifically override block size so they can test sub-page block
> > > size behaviour.
> > 
> > I said similar test, like other fallocate variants. Looking at the
> > tests there are three xfs tests that set block size and all of them
> > seems to have a reason to do so. None of them iterate through all
> > possible variants of block size.
> 
> True, but we do iterate over other options, like all the different
> quota configurations.
> 
> My point is that tests should be able to iterate if they need to
> exercise boundary conditions. It doesn't matter if it is block size
> or quota or btree leaf size or allocation cluster size. The point is
> that we can iterate them in a single test *all the time* rather on
> the rare occasion that someone runs with the specific test that
> exercises the corner case in question.
> 
> > > Indeed, there's a bunch of specific options passed into
> > > _scratch_mkfs in the btrfs tests, too, so this sort of constrained
> > > test configuration behaviour is not limited to just XFS.
> > > 
> > > IOWs, what needs to happen here is that btrfs needs to grow an
> > > equivalent _scratch_mkfs_btrfs that drops conflicting options and
> > > filters unsupported options so that tests don't need to care about
> > > what a filesystem supports or doesn't support....
> > > 
> > > > Yes, we can test all block size in every test from now on, but
> > > > what's the point?  We have a config file and the user can set
> > > > whatever block size he wants to test. I do not dispute that there
> > > > is a time when we really want to set a specific mkfs options in
> > > > the test, but this is not the case at all.
> > > 
> > > Most people don't test multiple different block sizes, so unless
> > > there is excessive runtime saying "but you can specify it manually"
> > > is not a valid reason for preventing a single test from iterating
> > > over multiple mkfs and/or mount configurations.
> > 
> > That applies to most of the tests and most of the mkfs/mount
> > options. And what you're asking for is that people will start to
> > write tests which iterate through their favourite options within the
> > test itself for no real reason.
> 
> No, I'm not advocating that at all. If the test has a specific
> reason for overriding the user configuration, then it should.

But that's my point, this particular test does not have specific
reason for it. It is mainly testing extent tree manipulation and
even though I agree that there might be bugs relating page_size >
block_size, it is no different than fsx, fsstress or any punch_hole,
zero_range, fallocate test.

It is doing:

"Test multiple fallocate collapse range calls on same file."

> Some configurations are rarely tested, and so having some tests that
> exercise them even when other options are being tested is not a bad
> thing. We catch problem with new changes much faster that way.

I agree, but block size is not one of those, if it is, well then we
have a different problem entirely.

> 
> IOWs, if there is a need to exercise configuration corner cases,
> then it can be done within a single test. If it's not testing such
> corner cases, then iteration is not necessary. And for this test,
> it's exercising sub-page block size behaviour, and so iteration over
> different block sizes is just fine....

Every test that's testing multiple block sizes is exercising
sub-page block size behaviour, that no argument. This test however,
unlike generic/022, generic/016, generic/021 and generic/012 is not
testing block size related corner case.

It's also worth noting that those tests mentioned above does not
iterate over different block sizes.

> 
> > The result will be that those of us
> > who actually run xfstests for different configuration will get much
> > longer runtime.
> 
> Not if we review tests appropriately. ;)
> 
> Are you having problems with the runtime of this test?

I do, it takes around 200s on xfs to run which is definitely one
of the longer running tests and given that I usually do run multiple
tests with different configurations (block size included), than it is a
waste.

With this patch, it's obviously third of the time.

> 
> > I think that xfstests should have a policy not to allow this to
> > happen, but you obviously think otherwise...
> 
> ... because the long standing policy has been "tests can force
> whatever configuration they need to exercise the functionality in
> question". You're advocating that we don't allow tests to do this,
> i.e so the only time sub-page block size functionality is tested is
> when the entire test suite is run with that specific configuration.

That's not what I am advocating for, I am saying that there should
be a specific reason to do this, like for example specific corner
case you mentioned or a bug which only appeared with specific
configuration, or any other valid reason. Testing sub page allocation
is useful for huge portion of our tests, but we certainly do not want
every test to do this on their own. But again there are some tests
where this might be justifiable (like those mentioned above and
those certainly run much *much* faster than 017).

-Lukas

> 
> The idea of a regression test suite is to exercise as much
> functionality as it can as quickly as it can. To adopt apolicy that
> excludes entire classes of code paths unless the user specifically
> configures the test suite to exercise those paths is Just Plain
> Wrong...
> 
> Cheers,
> 
> Dave.
> 
--8323328-1754211362-1403600891=:2210--

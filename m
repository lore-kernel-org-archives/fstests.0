Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54574 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751332AbaFXGRY (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 24 Jun 2014 02:17:24 -0400
Date: Tue, 24 Jun 2014 08:17:17 +0200 (CEST)
From: =?ISO-8859-15?Q?Luk=E1=A8_Czerner?= <lczerner@redhat.com>
Subject: Re: [PATCH 2/2] generic/017: Do not create file systems with different
 block sizes
In-Reply-To: <20140624054854.GG9508@dastard>
Message-ID: <alpine.LFD.2.00.1406240802370.2556@localhost.localdomain>
References: <1403535255-14601-1-git-send-email-lczerner@redhat.com> <1403535255-14601-2-git-send-email-lczerner@redhat.com> <20140624043835.GF9508@dastard> <alpine.LFD.2.00.1406240643160.2556@localhost.localdomain> <20140624054854.GG9508@dastard>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-156497214-1403590640=:2556"
Sender: xfstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, fdmanana@gmail.com
List-ID: <fstests@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-156497214-1403590640=:2556
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Tue, 24 Jun 2014, Dave Chinner wrote:

> Date: Tue, 24 Jun 2014 15:48:54 +1000
> From: Dave Chinner <david@fromorbit.com>
> To: Lukáš Czerner <lczerner@redhat.com>
> Cc: fstests@vger.kernel.org, fdmanana@gmail.com
> Subject: Re: [PATCH 2/2] generic/017: Do not create file systems with
>     different block sizes
> 
> On Tue, Jun 24, 2014 at 06:50:15AM +0200, Lukáš Czerner wrote:
> > On Tue, 24 Jun 2014, Dave Chinner wrote:
> > 
> > > Date: Tue, 24 Jun 2014 14:38:35 +1000
> > > From: Dave Chinner <david@fromorbit.com>
> > > To: Lukas Czerner <lczerner@redhat.com>
> > > Cc: fstests@vger.kernel.org, fdmanana@gmail.com
> > > Subject: Re: [PATCH 2/2] generic/017: Do not create file systems with
> > >     different block sizes
> > > 
> > > On Mon, Jun 23, 2014 at 04:54:15PM +0200, Lukas Czerner wrote:
> > > > User takes care about specifying mkfs options he wishes to test and the
> > > > test itself should not change it if it's not strictly necessary for the
> > > > test itself.
> > > > 
> > > > In this case it is not necessary and we should only test configuration
> > > > provided by the user. Moreover if the block size was already specified
> > > > some mkfs utilities does not handle multiple of the same parameters and
> > > > the mkfs utility fails making it re-try with only provided options
> > > > (ignoring what user specified), which is wrong.
> > > 
> > > I disagree strongly with this justification. The test is perfectly
> > > fine: it is allowed to do whatever it wants with mkfs and mount
> > > options.
> > > 
> > > It is up to the implementations of the specific FSTYP mkfs
> > > implementation called from _scratch_mkfs to handle
> > > conflicting/unsupported options sanely, not the test....
> > 
> > I agree, the test should not care about those options at all.
> 
> That's not what I said. I said the test is perfectly entitled
> to test whatever options it wants to.
> 
> The user specified configs are *behavioural modifiers*, not a
> draconian "this is all we test" rule. 
> 
> > That's
> > why I removed it. What was done in this test was entirely
> > unnecessary and was not done in any other similar test before.
> 
> Not true.  There are tests that override user specified configs all
> over the place. There's at least 50 calls to _scratch_mkfs_xfs with
> specific options across all the XFS tests, some of which
> specifically override block size so they can test sub-page block
> size behaviour.

I said similar test, like other fallocate variants. Looking at the
tests there are three xfs tests that set block size and all of them
seems to have a reason to do so. None of them iterate through all
possible variants of block size.

> 
> Indeed, there's a bunch of specific options passed into
> _scratch_mkfs in the btrfs tests, too, so this sort of constrained
> test configuration behaviour is not limited to just XFS.
> 
> IOWs, what needs to happen here is that btrfs needs to grow an
> equivalent _scratch_mkfs_btrfs that drops conflicting options and
> filters unsupported options so that tests don't need to care about
> what a filesystem supports or doesn't support....
> 
> > Yes, we can test all block size in every test from now on, but
> > what's the point?  We have a config file and the user can set
> > whatever block size he wants to test. I do not dispute that there
> > is a time when we really want to set a specific mkfs options in
> > the test, but this is not the case at all.
> 
> Most people don't test multiple different block sizes, so unless
> there is excessive runtime saying "but you can specify it manually"
> is not a valid reason for preventing a single test from iterating
> over multiple mkfs and/or mount configurations.

That applies to most of the tests and most of the mkfs/mount
options. And what you're asking for is that people will start to
write tests which iterate through their favourite options within the
test itself for no real reason. The result will be that those of us
who actually run xfstests for different configuration will get much
longer runtime.

I think that xfstests should have a policy not to allow this to
happen, but you obviously think otherwise...

-Lukas

> 
> > Moreover, if I want to test specific mkfs configuration the current
> > approach might not work as it will replace the options.
> 
> Only if they conflict. And in that case, it's better to simply run
> the test the way it was intended to be run than it is to fail or
> not_run it...
> 
> Cheers,
> 
> Dave.
> 
--8323328-156497214-1403590640=:2556--

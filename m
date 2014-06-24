Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32546 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751026AbaFXEuY (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 24 Jun 2014 00:50:24 -0400
Date: Tue, 24 Jun 2014 06:50:15 +0200 (CEST)
From: =?ISO-8859-15?Q?Luk=E1=A8_Czerner?= <lczerner@redhat.com>
Subject: Re: [PATCH 2/2] generic/017: Do not create file systems with different
 block sizes
In-Reply-To: <20140624043835.GF9508@dastard>
Message-ID: <alpine.LFD.2.00.1406240643160.2556@localhost.localdomain>
References: <1403535255-14601-1-git-send-email-lczerner@redhat.com> <1403535255-14601-2-git-send-email-lczerner@redhat.com> <20140624043835.GF9508@dastard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: xfstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, fdmanana@gmail.com
List-ID: <fstests@vger.kernel.org>

On Tue, 24 Jun 2014, Dave Chinner wrote:

> Date: Tue, 24 Jun 2014 14:38:35 +1000
> From: Dave Chinner <david@fromorbit.com>
> To: Lukas Czerner <lczerner@redhat.com>
> Cc: fstests@vger.kernel.org, fdmanana@gmail.com
> Subject: Re: [PATCH 2/2] generic/017: Do not create file systems with
>     different block sizes
> 
> On Mon, Jun 23, 2014 at 04:54:15PM +0200, Lukas Czerner wrote:
> > User takes care about specifying mkfs options he wishes to test and the
> > test itself should not change it if it's not strictly necessary for the
> > test itself.
> > 
> > In this case it is not necessary and we should only test configuration
> > provided by the user. Moreover if the block size was already specified
> > some mkfs utilities does not handle multiple of the same parameters and
> > the mkfs utility fails making it re-try with only provided options
> > (ignoring what user specified), which is wrong.
> 
> I disagree strongly with this justification. The test is perfectly
> fine: it is allowed to do whatever it wants with mkfs and mount
> options.
> 
> It is up to the implementations of the specific FSTYP mkfs
> implementation called from _scratch_mkfs to handle
> conflicting/unsupported options sanely, not the test....

I agree, the test should not care about those options at all. That's
why I removed it. What was done in this test was entirely
unnecessary and was not done in any other similar test before.

Yes, we can test all block size in every test from now on, but
what's the point ? We have a config file and the user can set
whatever block size he wants to test. I do not dispute that there is
a time when we really want to set a specific mkfs options in the
test, but this is not the case at all.

Moreover, if I want to test specific mkfs configuration the current
approach might not work as it will replace the options.

-Lukas

> 
> > In this case it's also a problem for btrfs file system which does not
> > support block size < page size.
> 
> i.e. _scratch_mkfs_btrfs needs to either filter that out or
> _fail/_not_run the test if it can't....
> 
> Cheers,
> 
> Dave.
> 

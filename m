Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:21821 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753535AbaKMEWf (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 12 Nov 2014 23:22:35 -0500
Date: Thu, 13 Nov 2014 15:22:31 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: xfstest status on current kernels
Message-ID: <20141113042231.GD28565@dastard>
References: <CAH2r5mu40qp-m7qZTnbsCKORPn_YYdWGZti32WYPFAJMUs1fhw@mail.gmail.com>
 <20141113032626.GA28565@dastard>
 <CAH2r5mtdRt+ZX72s-0NO=uxmhMaiFENC1uRUFSPveKZm3S8X=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5mtdRt+ZX72s-0NO=uxmhMaiFENC1uRUFSPveKZm3S8X=Q@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Steve French <smfrench@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Nov 12, 2014 at 09:38:45PM -0600, Steve French wrote:
> On Wed, Nov 12, 2014 at 9:26 PM, Dave Chinner <david@fromorbit.com> wrote:
> > On Wed, Nov 12, 2014 at 05:31:20PM -0600, Steve French wrote:
> 
> >> I want to make sure that I don't accidentally ignore a test (e.g. test
> >> generic/003 doesn't run with a message " [not run] relatime not
> >> supported by the current kernel" and want to make sure I am not
> >> missing something).
> >
> > You need to such things yourself and determine if the test should
> > have run for your given test configuration.
> 
> I have been going through these one at a time as I have time (to
> see if they are workable on cifs/smb3 etc) - but it can get
> tricky (e.g. in this case relatime may be default behavior for fs so
> lack of a mount option with this exact name may be unnecessarily
> disabling this one on some fs)

I don't think that's the case. Any kernel that supports relatime
supports the relatime mount option. It doesn't matter if the
filesystem defaults to it or not, MS_RELATIME is a valid mount
flag on all supported kernels.

I can't see where a current kernel would reject an attempt to mount
with the MS_RELATIME flag set, so if you're seeing that fail either
the mount program for your filesystem type is rejecting it or you've
got a very old kernel....

> > or test tools weren't built due to missing libraries:
> >
> > generic/010      [not run] dbtest was not built for this platform
> 
> This is a good example, and one run that I had run into a month or
> two ago (at first I had assumed at first
> that it was not runnable on Linux, and then eventually
> figured out the build dependencies for it to work on Ubuntu and Fedora)
> Not always clear to me which of these tests are never going to work on Linux.

We require the supported OS for the test to be defined in every
test. it's pretty easy to check:

$ grep _supported_os tests/generic/010
_supported_os IRIX Linux
$

Try to run a test that isn't supported on Linux and you get:

xfs/095  [not run] not suitable for this OS: Linux

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

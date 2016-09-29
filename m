Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:48493 "EHLO
        ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754436AbcI2FiL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 29 Sep 2016 01:38:11 -0400
Date: Thu, 29 Sep 2016 15:37:52 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] common: add support for the "local" file system type
Message-ID: <20160929053752.GJ9806@dastard>
References: <20160923200526.29674-1-tytso@mit.edu>
 <20160926221814.GC2532@dastard>
 <20160928235713.tt76og3lxuvozrpi@thunk.org>
 <20160929021628.GI9806@dastard>
 <20160929035636.g2776ggv2cundlrh@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160929035636.g2776ggv2cundlrh@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Sep 28, 2016 at 11:56:36PM -0400, Theodore Ts'o wrote:
> On Thu, Sep 29, 2016 at 12:16:29PM +1000, Dave Chinner wrote:
> > 
> > So, sooper-s3kr3t internal google stuff that you can't talk
> > about and may never see the light of day. When it is announced
> > and released, then let's talk about integration....
> 
> Fair enough, I'll carry it as an out-of-tree patch at
> 
> https://github.com/tytso/xfstests
> 
> ... for anyone else who might find it useful for their purposes.
> 
> > xfstests is not designed for validating system call API
> > compliance - it's for exercising /filesystem implementations/.
> > xfstests assumes the syscall API is valid and working, and tries
> > to break the underlying storage implementation.  As such, your
> > example really isn't something you should be using xfstests for
> > - it doesn't test anything like what is needed to verify that
> > the "VFS emulation" is valid and complete and working exactly as
> > documented in the linux man pages.
> 
> Who says there isn't an underlying file system implementation
> which we want to test? In fact we *are* using the right tool for the job.

Nobody outside the google echo chamber can say, Ted, because you
haven't told anyone what it is you want this for. binary emulation
layers (your example, not mine) don't implement persistent
filesystems - they translate syscalls.

So let's revist this when everyone has the same information
available and we can have an informed discussion....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

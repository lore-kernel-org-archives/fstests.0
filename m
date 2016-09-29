Received: from imap.thunk.org ([74.207.234.97]:43106 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750700AbcI2D5E (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 28 Sep 2016 23:57:04 -0400
Date: Wed, 28 Sep 2016 23:56:36 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] common: add support for the "local" file system type
Message-ID: <20160929035636.g2776ggv2cundlrh@thunk.org>
References: <20160923200526.29674-1-tytso@mit.edu>
 <20160926221814.GC2532@dastard>
 <20160928235713.tt76og3lxuvozrpi@thunk.org>
 <20160929021628.GI9806@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160929021628.GI9806@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Sep 29, 2016 at 12:16:29PM +1000, Dave Chinner wrote:
> 
> So, sooper-s3kr3t internal google stuff that you can't talk about
> and may never see the light of day. When it is announced and
> released, then let's talk about integration....

Fair enough, I'll carry it as an out-of-tree patch at

https://github.com/tytso/xfstests

... for anyone else who might find it useful for their purposes.

> xfstests is not designed for validating system call API compliance -
> it's for exercising /filesystem implementations/.  xfstests assumes
> the syscall API is valid and working, and tries to break the
> underlying storage implementation.  As such, your example really
> isn't something you should be using xfstests for - it doesn't test
> anything like what is needed to verify that the "VFS emulation" is
> valid and complete and working exactly as documented in the linux
> man pages.

Who says there isn't an underlying file system implementation which we
want to test?  In fact we *are* using the right tool for the job.
(I'm quite aware of the other testing tools that might be available
including LTP and others, such as the LSB tests.)

Cheers,

							- Ted

Received: from imap.thunk.org ([74.207.234.97]:44546 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752479AbcI2NFM (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 29 Sep 2016 09:05:12 -0400
Date: Thu, 29 Sep 2016 09:05:01 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] common: add support for the "local" file system type
Message-ID: <20160929130501.k7hz2qcp6tgiyji6@thunk.org>
References: <20160923200526.29674-1-tytso@mit.edu>
 <20160926221814.GC2532@dastard>
 <20160928235713.tt76og3lxuvozrpi@thunk.org>
 <20160929021628.GI9806@dastard>
 <20160929035636.g2776ggv2cundlrh@thunk.org>
 <20160929053752.GJ9806@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160929053752.GJ9806@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Sep 29, 2016 at 03:37:52PM +1000, Dave Chinner wrote:
> Nobody outside the google echo chamber can say, Ted, because you
> haven't told anyone what it is you want this for. binary emulation
> layers (your example, not mine) don't implement persistent
> filesystems - they translate syscalls.

Is your only objection that you don't get to can't see what it's going
to test?

That's generally not a reason to object to patches in various open
source projects --- there are plenty of closed source programs for
which we accept kernel patches, for example.

But sure, if that's the way you want to roll, as I said, I'll carry it
as an out of tree patch.

						- Ted

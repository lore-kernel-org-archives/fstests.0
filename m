Received: from imap.thunk.org ([74.207.234.97]:47364 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932656AbcI3DnK (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 29 Sep 2016 23:43:10 -0400
Date: Thu, 29 Sep 2016 23:43:04 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] common: add support for the "local" file system type
Message-ID: <20160930034304.bzauyu3otrgmeahe@thunk.org>
References: <20160923200526.29674-1-tytso@mit.edu>
 <20160926221814.GC2532@dastard>
 <20160928235713.tt76og3lxuvozrpi@thunk.org>
 <20160929021628.GI9806@dastard>
 <20160929035636.g2776ggv2cundlrh@thunk.org>
 <20160929053752.GJ9806@dastard>
 <20160929130501.k7hz2qcp6tgiyji6@thunk.org>
 <20160929224913.GP9806@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160929224913.GP9806@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Sep 30, 2016 at 08:49:13AM +1000, Dave Chinner wrote:
> As it is, Eryu and Eric have already outlined a number of serious
> issues with the implementation (and your testing process). They've
> highlighted a number of magic snowflake conditions we'd have to
> sprinkle throughout random tests and maintain forever more. What's
> missing from your patch request is the information that allows us to
> determine if the benefits of this patchset outweigh the obvious,
> significant, ongoing cost of having to maintain these snowflakes.

The issues Eryu and Eric pointed out (and many thanks for their
review) were ones that are easily fixed, and I can restrict the
changes to common/* (right now only common/rc), and I no longer need
any changes in the tests/* hierarchy.

My first patch had only a single "snowflake" to generic/027 (and it
was one that already had a snowflake exemption for btrfs).  It was
done to work around the fact that _scratch_mkfs_sized wouldn't
restrict the size of the file system.  I now will _notrun any test
which uses _scratch_mkfs_sized, so I don't need that change any
longer.  This leaves only a single enospc test which will be run,
which is a bit unfortunate, but it solves the "I could fill the root
file system if TEST_DEV or SCRATCH_DEV is pointed on my root fs"
problem".

So I believe the maintainance issue is something that can be be
mitigated.

Testing is something that can be done using a standard Linux systems.
(Indeed I did most of my testing using my existing gce-xfstests and
kvm-xfstests frameworks, just because it was easier.)  It's a fair
point that I should make sure it doesn't cause problems when other
file systems are used as the base file system, and if it is used on a
root file system.  Again, these are issues which I can fix in the
patch.  Indeed, all of the the specific issues pointed out by Eric and
Eryu are already fixed in my tree.

In any case, since the commit are only adding some tests in common/rc
(where we have lots of per-file system conditionals anyway), I can
easily maintain this patch out-of-tree, since you seem to have
fundamental philosophical problems with it.

Regards,

						- Ted

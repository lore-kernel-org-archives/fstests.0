Received: from imap.thunk.org ([74.207.234.97]:40426 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755031AbdGSOxG (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 19 Jul 2017 10:53:06 -0400
Date: Wed, 19 Jul 2017 10:53:01 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [RFC PATCH] check: try to fix the test device if it gets
 corrupted
Message-ID: <20170719145301.6ico5wwhwmamuu3k@thunk.org>
References: <20170303090332.GP14226@eguan.usersys.redhat.com>
 <20170303172157.GA5070@birch.djwong.org>
 <20170303230129.apzqe77r4d5jtf63@thunk.org>
 <20170327014802.wc5as2tdgecy3rzu@thunk.org>
 <20170327085103.GQ14226@eguan.usersys.redhat.com>
 <20170716013058.r46jceccqmoedkde@thunk.org>
 <20170717234508.GB4217@magnolia>
 <20170718050507.GU2478@eguan.usersys.redhat.com>
 <20170718173009.r5i73dztecop5tfr@thunk.org>
 <20170719094047.GC2478@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170719094047.GC2478@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jul 19, 2017 at 05:40:47PM +0800, Eryu Guan wrote:
> > 
> > So one thing we could do is _xfs_scratch_repair and _xfs_test_repair?

Hmm, or maybe _xfs_repair_scratch and _xfs_repair_test; since at least
for English speakers verb-object is probably more natural.  But if you
or Darrick have a strong preference I'm don't care that much.

> Then all existing _scratch_xfs_repair calls need a rename, but I'm fine
> with the rename.
> 
> > 
> > The other thing is how much of the cleanup in common/xfs should be
> > segregated into a separate commit (and I'm not sure how competent I'm
> > going to be ate doing that cleanup, but I'm willing to give it a go).
> 
> I think we can do minimal cleanup in this patch (like the rename of
> _scratch_xfs_repair to _xfs_scratch_repair) and do other cleanups in
> separate commits (if there's still any).

If you don't mind I'll do the renames as a separate commit since
that's much easier to verify/review.

Cheers,

						- Ted

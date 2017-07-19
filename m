Received: from mx1.redhat.com ([209.132.183.28]:59956 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751911AbdGSJku (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 19 Jul 2017 05:40:50 -0400
Date: Wed, 19 Jul 2017 17:40:47 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [RFC PATCH] check: try to fix the test device if it gets
 corrupted
Message-ID: <20170719094047.GC2478@eguan.usersys.redhat.com>
References: <20170302232050.31125-1-tytso@mit.edu>
 <20170303090332.GP14226@eguan.usersys.redhat.com>
 <20170303172157.GA5070@birch.djwong.org>
 <20170303230129.apzqe77r4d5jtf63@thunk.org>
 <20170327014802.wc5as2tdgecy3rzu@thunk.org>
 <20170327085103.GQ14226@eguan.usersys.redhat.com>
 <20170716013058.r46jceccqmoedkde@thunk.org>
 <20170717234508.GB4217@magnolia>
 <20170718050507.GU2478@eguan.usersys.redhat.com>
 <20170718173009.r5i73dztecop5tfr@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170718173009.r5i73dztecop5tfr@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jul 18, 2017 at 01:30:09PM -0400, Theodore Ts'o wrote:
> On Tue, Jul 18, 2017 at 01:05:07PM +0800, Eryu Guan wrote:
> > > >  	if [ -f ${RESULT_DIR}/require_test ]; then
> > > > -		_check_test_fs || err=true
> > > > +		if ! _check_test_fs ; then
> > > > +			err=true
> > > > +			echo "Trying to repair broken TEST_DEV file system"
> > > > +			_repair_test_fs
> > 
> > Should we stop running if _repair_test_fs failed to fix TEST_DEV? I
> > think that was what Darrick first suggested. And I think unfixable
> > errors will cause subsequent tests to fail too.
> 
> Seems reasonable to me.  I'll take a look at it.
> 
> > > > +_repair_test_fs()
> > > > +{
> > > > +	case $FSTYP in
> > > > +	xfs)
> > > > +		_repair_xfs_test_fs "$@" >$tmp.repair 2>&1
> > > > +		res=$?
> > 
> > Better to declare res as a local variable. I know this was copied from
> > _repair_scratch_fs, but better to get it improved in new code :)
> 
> Ack.
> 
> > > Structurally this all looks ok, but it's a little weird that we have
> > > _scratch_xfs_repair for the scratch device (object-verb) but
> > > _repair_test_fs (verb-object) for the test device.
> > 
> > My best guess is that _repair_scratch_fs and _repair_test_fs are helpers
> > in a higher level, and are defined in common/rc, they deal with all
> > filesystem types.
> > 
> > _scratch_xfs_repair is xfs specific, and defined in common/xfs, it only
> > deals with xfs. So the naming schema is different but they are also in
> > different "namespace"s, which looks fine to me :)
> 
> I also didn't like _test_repair_fs because it's not clear whether
> "test" is a verb or a noun.
> 
> So one thing we could do is _xfs_scratch_repair and _xfs_test_repair?

Then all existing _scratch_xfs_repair calls need a rename, but I'm fine
with the rename.

> 
> The other thing is how much of the cleanup in common/xfs should be
> segregated into a separate commit (and I'm not sure how competent I'm
> going to be ate doing that cleanup, but I'm willing to give it a go).

I think we can do minimal cleanup in this patch (like the rename of
_scratch_xfs_repair to _xfs_scratch_repair) and do other cleanups in
separate commits (if there's still any).

Thanks!

Eryu

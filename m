Received: from mx1.redhat.com ([209.132.183.28]:60348 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750920AbdHRHzO (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 18 Aug 2017 03:55:14 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A698F80460
        for <fstests@vger.kernel.org>; Fri, 18 Aug 2017 07:55:14 +0000 (UTC)
Date: Fri, 18 Aug 2017 15:55:10 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH V2] xfs: Test infinite loop while searching for a free
 inode slot
Message-ID: <20170818075510.GX14807@eguan.usersys.redhat.com>
References: <20170817133943.10774-1-cmaiolino@redhat.com>
 <20170818054830.GW14807@eguan.usersys.redhat.com>
 <20170818073525.vegynnjxn4j2l63t@hades.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170818073525.vegynnjxn4j2l63t@hades.localdomain>
Sender: fstests-owner@vger.kernel.org
To: Carlos Maiolino <cmaiolino@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Aug 18, 2017 at 09:35:25AM +0200, Carlos Maiolino wrote:
> Hi Eryu,
> 
> > Thanks a lot for the updated version! It looks much better than v1 :)
> > 
> > Though I hit another issue while testing this patch, please see below.
> > 
> > > +
> > > +# agi->freecount is 0 here, corrupt it to show extra free inodes
> > > +$XFS_DB_PROG -x -c "agi 0" -c "write freecount 10" $SCRATCH_DEV >> $seqres.full 2>&1
> > 
> > Minor nit, please use _scratch_xfs_db helper.
> > 
> 
> NP at all
> > > +
> > > +_scratch_mount
> > > +
> > > +# Lock up a buggy kernel
> > > +touch $SCRATCH_MNT/lockupfile >> $seqres.full 2>&1
> > 
> > 
> > XFS: Assertion failed: freecount == be32_to_cpu(agi->agi_freecount), file: fs/xfs/libxfs/xfs_ialloc.c, line: 246
> > 
> > Perhaps test should _notrun with CONFIG_XFS_DEBUG on?
> > 
> 
> The Assert is expected.
> 
> We have debug code to catch the agi->agi_freecount corruption which will explode
> in this assert, such code is debug only though because it will search the
> whole btree and 'manually' count how many free slots are in the tree, then
> compare with agi_freecount.

Yeah, I know it's expected, we turn on fatal assert in debug mode.

> 
> Although, I'm not sure if you notice, but even you hit this assert, you will
> not be able to unmount the filesystem.
> 
> I'm not sure now if simply disable this test on XFS_DEBUG is the best approach,
> hitting the bug in XFS_DEBUG is less catastrophic because it will not lockup,
> but will make the FS unmountable.

It crashed my host immediately, because I have
/proc/sys/kernel/panic_on_oops set to 1.

Anyway, an unmountable fs is as bad as a crash, they all prevent
subsequent tests from running. The underlying bug is fixed, we expect
test to pass, not crash the host or block further testings.

> 
> I'd simply disable it in XFS_DEBUG, once the bug is exactly the same as with non
> debug code, but with a different behavior. Not sure though if there are people
> running xfstests exclusively on XFS_DEBUG.

I believe running xfstests with XFS_DEBUG is pretty common.

Thanks,
Eryu

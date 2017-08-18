Received: from mail-wr0-f181.google.com ([209.85.128.181]:38246 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbdHRHfa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 18 Aug 2017 03:35:30 -0400
Received: by mail-wr0-f181.google.com with SMTP id 5so38868239wrz.5
        for <fstests@vger.kernel.org>; Fri, 18 Aug 2017 00:35:29 -0700 (PDT)
Date: Fri, 18 Aug 2017 09:35:25 +0200
From: Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH V2] xfs: Test infinite loop while searching for a free
 inode slot
Message-ID: <20170818073525.vegynnjxn4j2l63t@hades.localdomain>
References: <20170817133943.10774-1-cmaiolino@redhat.com>
 <20170818054830.GW14807@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170818054830.GW14807@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi Eryu,

> Thanks a lot for the updated version! It looks much better than v1 :)
> 
> Though I hit another issue while testing this patch, please see below.
> 
> > +
> > +# agi->freecount is 0 here, corrupt it to show extra free inodes
> > +$XFS_DB_PROG -x -c "agi 0" -c "write freecount 10" $SCRATCH_DEV >> $seqres.full 2>&1
> 
> Minor nit, please use _scratch_xfs_db helper.
> 

NP at all
> > +
> > +_scratch_mount
> > +
> > +# Lock up a buggy kernel
> > +touch $SCRATCH_MNT/lockupfile >> $seqres.full 2>&1
> 
> 
> XFS: Assertion failed: freecount == be32_to_cpu(agi->agi_freecount), file: fs/xfs/libxfs/xfs_ialloc.c, line: 246
> 
> Perhaps test should _notrun with CONFIG_XFS_DEBUG on?
> 

The Assert is expected.

We have debug code to catch the agi->agi_freecount corruption which will explode
in this assert, such code is debug only though because it will search the
whole btree and 'manually' count how many free slots are in the tree, then
compare with agi_freecount.

Although, I'm not sure if you notice, but even you hit this assert, you will
not be able to unmount the filesystem.

I'm not sure now if simply disable this test on XFS_DEBUG is the best approach,
hitting the bug in XFS_DEBUG is less catastrophic because it will not lockup,
but will make the FS unmountable.

I'd simply disable it in XFS_DEBUG, once the bug is exactly the same as with non
debug code, but with a different behavior. Not sure though if there are people
running xfstests exclusively on XFS_DEBUG.

Any thoughts?

Cheers

> Thanks,
> Eryu
> 
> > +
> > +# If we reach this point, the filesystem is fixed
> > +echo "Silence is golden"
> > +status=0
> > +exit
> > diff --git a/tests/xfs/057.out b/tests/xfs/057.out
> > new file mode 100644
> > index 00000000..185023c7
> > --- /dev/null
> > +++ b/tests/xfs/057.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 057
> > +Silence is golden
> > diff --git a/tests/xfs/group b/tests/xfs/group
> > index cf876a29..37e4e641 100644
> > --- a/tests/xfs/group
> > +++ b/tests/xfs/group
> > @@ -54,6 +54,7 @@
> >  054 auto quick
> >  055 dump ioctl remote tape
> >  056 dump ioctl auto quick
> > +057 auto quick fuzzers dangerous
> >  059 dump ioctl auto quick
> >  060 dump ioctl auto quick
> >  061 dump ioctl auto quick
> > -- 
> > 2.13.5
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Carlos

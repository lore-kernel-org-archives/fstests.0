Received: from mail-wr0-f172.google.com ([209.85.128.172]:34341 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbdHQIwh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 17 Aug 2017 04:52:37 -0400
Received: by mail-wr0-f172.google.com with SMTP id y96so34140177wrc.1
        for <fstests@vger.kernel.org>; Thu, 17 Aug 2017 01:52:36 -0700 (PDT)
Date: Thu, 17 Aug 2017 10:52:32 +0200
From: Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH] xfs: Test infinite loop while searching for a free inode
 slot
Message-ID: <20170817085232.fup4bcyy4eaoufh5@hades.localdomain>
References: <20170815125541.12243-1-cmaiolino@redhat.com>
 <20170816070214.GJ14807@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170816070214.GJ14807@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

> The test passed for me with 4.13-rc kernel with latest upstream
> xfsprogs, but I expected it to fail (hang). Does it hang for you?
> 

Found the problem.

> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
>                                     ^^^ $i not $1
> so I know why I can't reproduce the hang now, fixing this typo works for
> me :)
> 

Yeah, pretty much what I found too :P When rebasing my test agains the updated
tree and using a more meaningful name to these dummy files, I messed up with it
:P

I'll fix up the remaining things and send a V2
> > +done
> 
> How about getting the freecount number via xfs_db (before
> _scratch_mount) instead of assmuing it always be 61?
> 
> freecount=`_scratch_xfs_db -c "agi 0" -c "p freecount" | cut -d' ' -f 3`
> 

> > +
> > +_scratch_unmount
> > +
> > +# agi->freecount is 0 here, corrupt it to show extra free inodes
> > +$XFS_DB_PROG -x -c "agi 0" -c "write -d freecount 10" $SCRATCH_DEV >/dev/null 2>&1
> 
> redirect stdout and stderr to $seqres.full for debug purpose
> 
> > +
> > +_scratch_mount >/dev/null 2>&1
> 
> No need to drop stdout and stderr either.
> 
> > +
> > +# Lock up a buggy kernel
> > +touch $SCRATCH_MNT/lockupfile
> 
> Would this touch return any error message if the kernel bug is fixed? If
> so, I'd drop stdout/stderr of touch.
> 

This should shut down the filesystem because xfs will catch the corrupted
freecount.

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
> > index cf876a29..3ca8e75a 100644
> > --- a/tests/xfs/group
> > +++ b/tests/xfs/group
> > @@ -54,6 +54,7 @@
> >  054 auto quick
> >  055 dump ioctl remote tape
> >  056 dump ioctl auto quick
> > +057 dangerous
> 
> I think it's a good fit to auto and quick group too, and maybe fuzzers
> group.
> 

May I ask what's the 'official' purpose of auto group? I agree of adding it to
fuzzers, but 'auto' group sounds to me like a group of tests being run by
default, which wouldn't be a good idea in this case.


> Thanks,
> Eryu
> 
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

Received: from mx1.redhat.com ([209.132.183.28]:48610 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752588AbdHQJTz (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 17 Aug 2017 05:19:55 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 178BD75EC6
        for <fstests@vger.kernel.org>; Thu, 17 Aug 2017 09:19:55 +0000 (UTC)
Date: Thu, 17 Aug 2017 17:19:47 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfs: Test infinite loop while searching for a free inode
 slot
Message-ID: <20170817091947.GV14807@eguan.usersys.redhat.com>
References: <20170815125541.12243-1-cmaiolino@redhat.com>
 <20170816070214.GJ14807@eguan.usersys.redhat.com>
 <20170817085232.fup4bcyy4eaoufh5@hades.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170817085232.fup4bcyy4eaoufh5@hades.localdomain>
Sender: fstests-owner@vger.kernel.org
To: cmaiolino@redhat.com
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Aug 17, 2017 at 10:52:32AM +0200, Carlos Maiolino wrote:
> > The test passed for me with 4.13-rc kernel with latest upstream
> > xfsprogs, but I expected it to fail (hang). Does it hang for you?
> > 
> 
> Found the problem.
> 
> > > +seq=`basename $0`
> > > +seqres=$RESULT_DIR/$seq
> > > +echo "QA output created by $seq"
> > > +
> >                                     ^^^ $i not $1
> > so I know why I can't reproduce the hang now, fixing this typo works for
> > me :)
> > 
> 
> Yeah, pretty much what I found too :P When rebasing my test agains the updated
> tree and using a more meaningful name to these dummy files, I messed up with it
> :P
> 
> I'll fix up the remaining things and send a V2
> > > +done
> > 
> > How about getting the freecount number via xfs_db (before
> > _scratch_mount) instead of assmuing it always be 61?
> > 
> > freecount=`_scratch_xfs_db -c "agi 0" -c "p freecount" | cut -d' ' -f 3`
> > 
> 
> > > +
> > > +_scratch_unmount
> > > +
> > > +# agi->freecount is 0 here, corrupt it to show extra free inodes
> > > +$XFS_DB_PROG -x -c "agi 0" -c "write -d freecount 10" $SCRATCH_DEV >/dev/null 2>&1
> > 
> > redirect stdout and stderr to $seqres.full for debug purpose
> > 
> > > +
> > > +_scratch_mount >/dev/null 2>&1
> > 
> > No need to drop stdout and stderr either.
> > 
> > > +
> > > +# Lock up a buggy kernel
> > > +touch $SCRATCH_MNT/lockupfile
> > 
> > Would this touch return any error message if the kernel bug is fixed? If
> > so, I'd drop stdout/stderr of touch.
> > 
> 
> This should shut down the filesystem because xfs will catch the corrupted
> freecount.
> 
> > > +
> > > +# If we reach this point, the filesystem is fixed
> > > +echo "Silence is golden"
> > > +status=0
> > > +exit
> > > diff --git a/tests/xfs/057.out b/tests/xfs/057.out
> > > new file mode 100644
> > > index 00000000..185023c7
> > > --- /dev/null
> > > +++ b/tests/xfs/057.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 057
> > > +Silence is golden
> > > diff --git a/tests/xfs/group b/tests/xfs/group
> > > index cf876a29..3ca8e75a 100644
> > > --- a/tests/xfs/group
> > > +++ b/tests/xfs/group
> > > @@ -54,6 +54,7 @@
> > >  054 auto quick
> > >  055 dump ioctl remote tape
> > >  056 dump ioctl auto quick
> > > +057 dangerous
> > 
> > I think it's a good fit to auto and quick group too, and maybe fuzzers
> > group.
> > 
> 
> May I ask what's the 'official' purpose of auto group? I agree of adding it to
> fuzzers, but 'auto' group sounds to me like a group of tests being run by
> default, which wouldn't be a good idea in this case.

I found one email I sent before that explained the auto group
definition, I copied & pasted it here:

"
I searched for Dave's explainations on 'auto' group in his reviews, and
got the following definitions:

- it should be a valid & reliable test (it's finished and have
  deterministic output) [1]
- it passes on current upstream kernels, if it fails, it's likely to be
  resolved in forseeable future [2]
- it should take no longer than 5 minutes to finish [3]

[1] http://www.spinics.net/lists/fstests/msg00938.html
[2] http://www.spinics.net/lists/fstests/msg01548.html
[3] http://www.spinics.net/lists/fstests/msg01719.html
"

So I think it's a good 'auto' test :)

Thanks,
Eryu

Received: from mx1.redhat.com ([209.132.183.28]:48368 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750878AbdGGK0l (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 7 Jul 2017 06:26:41 -0400
Date: Fri, 7 Jul 2017 12:26:36 +0200
From: Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH] xfs test: Buffer resubmittion test
Message-ID: <20170707102636.wlfmanskm2uhpp7b@eorzea.usersys.redhat.com>
References: <20170703153200.14423-1-cmaiolino@redhat.com>
 <20170705125016.GB51285@bfoster.bfoster>
 <20170705161733.GA6300@magnolia>
 <20170707092431.375q5xfpqvy4y6qu@eorzea.usersys.redhat.com>
 <20170707102114.GA61303@bfoster.bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170707102114.GA61303@bfoster.bfoster>
Sender: fstests-owner@vger.kernel.org
To: Brian Foster <bfoster@redhat.com>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Jul 07, 2017 at 06:21:17AM -0400, Brian Foster wrote:
> On Fri, Jul 07, 2017 at 11:24:31AM +0200, Carlos Maiolino wrote:
> > Hi
> > 
> > Thanks for the comments, I agree with all the changes pointed but one inlined
> > below.
> > 
> > > > > +xfs_io -f -d -c 'pwrite -b 1m 0 120m' $mnt/f1 >/dev/null 2>&1
> > > > > +
> > > > > +fsfreeze -f $mnt &
> > > > > +
> > > > > +#Wait fsfreeze to its job
> > > > > +sleep 10
> > > > 
> > > > I think you could use 'wait' here rather than a sleep. But is there a
> > > > reason we need to put the freeze in the background in the first place?
> > > > It seems to me this test will either complete or hang regardless. ;P
> > > 
> > > I had the same thought.
> > 
> > not running fsfreeze in the background won't complete the test. fsfreeze needs
> > some space in the device to complete, and with a full device it will hang until
> > the device is extended with lvextend.
> > 
> > The difference between a fixed filesystem and a buggy one, is whether the
> > filesystem can be properly thawed or not, but both cases will hang in fsfreeze
> > if the device isn't expanded right after freezing the fs.
> > 
> > The main reason of the freeze, is to force xfsaild to run and push ail items, if
> > no space is availale, xfsaild will stay stuck:
> > 
> 
> Ok, I see.. that makes sense. Could you update the comments a bit here
> just to explain why the background task is necessary and that the freeze
> is going to block on the lvextend due to the state of the fs? I also
> think a wait after the lvextend couldn't hurt so it's more clear that
> the freeze is what is blocked, but not a big deal either way.
> 

Sure, no problem at all, I'll work on this, thanks Brian


> Brian
> 
> > ~ $ sudo cat /proc/4712/stack 
> > [<ffffffff813f7e16>] xfs_ail_push_all_sync+0xb6/0x100
> > [<ffffffff813e714f>] xfs_log_quiesce+0x4f/0x3a0
> > [<ffffffff813dd5cd>] xfs_quiesce_attr+0x6d/0xb0
> > [<ffffffff813dd660>] xfs_fs_freeze+0x50/0x80
> > [<ffffffff81246a5f>] freeze_super+0xcf/0x1a0
> > [<ffffffff81258ca3>] do_vfs_ioctl+0x4b3/0x5e0
> > [<ffffffff81258e49>] SyS_ioctl+0x79/0x90
> > [<ffffffff818da677>] entry_SYSCALL_64_fastpath+0x1a/0xa9
> > [<ffffffffffffffff>] 0xffffffffffffffff
> > 
> > 
> > Other than that, I'll agree with everything.
> > 
> > Thanks for the review guys
> > 
> > 
> > > 
> > > > > +
> > > > 
> > > > "extend the volume with sufficient space and unfreeze ..."
> > > > 
> > > > > +lvextend -L $newpsize $vgname/$poolname >/dev/null 2>&1
> > > > > +
> > > > > +fsfreeze -u $mnt
> > > > > +echo "Test OK"
> > > > > +
> > > > > +status=0
> > > > > +exit
> > > > > diff --git a/tests/xfs/999.out b/tests/xfs/999.out
> > > > > new file mode 100644
> > > > > index 0000000..8c3c938
> > > > > --- /dev/null
> > > > > +++ b/tests/xfs/999.out
> > > > > @@ -0,0 +1,2 @@
> > > > > +QA output created by 999
> > > > > +Test OK
> > > > > diff --git a/tests/xfs/group b/tests/xfs/group
> > > > > index 792161a..2bde916 100644
> > > > > --- a/tests/xfs/group
> > > > > +++ b/tests/xfs/group
> > > > > @@ -416,3 +416,4 @@
> > > > >  416 dangerous_fuzzers dangerous_scrub dangerous_repair
> > > > >  417 dangerous_fuzzers dangerous_scrub dangerous_online_repair
> > > > >  418 dangerous_fuzzers dangerous_scrub dangerous_repair
> > > > > +999 dangerous
> > > > 
> > > > I think the auto group makes sense too.
> > > > 
> > > > Also, since the discussion around having a couple tests here (one using
> > > > error injection and this one using dm-thin) it seems like this test
> > > > could be more suited to a generic test.  Nothing in the test really
> > > > depends on a particular filesystem. The header comment could simply be
> > > > updated to explain the specific XFS issue as the inspiration and that
> > > > the test generically exercises the ability to recover/continue after a
> > > > dm-thin ENOPSPC and subsequent volume extend. Thoughts?
> > > 
> > > I agree. :)
> > > 
> > > (new laptop, let's see if this mail even makes it to the ml...)
> > > 
> > > --D
> > > 
> > > > Brian
> > > > 
> > > > > -- 
> > > > > 2.9.4
> > > > > 
> > > > > --
> > > > > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > > > > the body of a message to majordomo@vger.kernel.org
> > > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > -- 
> > Carlos
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Carlos

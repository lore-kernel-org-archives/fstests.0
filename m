Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:52912 "EHLO
        ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751798AbcJGWwf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 7 Oct 2016 18:52:35 -0400
Date: Sat, 8 Oct 2016 09:52:31 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH V2 2/2] fs/super.c: don't fool lockdep in freeze_super()
 and thaw_super() paths
Message-ID: <20161007225231.GY27872@dastard>
References: <20160927172901.GA11879@redhat.com>
 <20160930171434.GA2373@redhat.com>
 <20161002214225.GS9806@dastard>
 <20161003164435.GB6634@redhat.com>
 <20161004114341.GA8572@redhat.com>
 <20161004194435.GW9806@dastard>
 <20161005164432.GB15121@redhat.com>
 <20161006171758.GA21707@redhat.com>
 <20161006215920.GE9806@dastard>
 <20161007171517.GA23721@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161007171517.GA23721@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, Nikolay Borisov <kernel@kyup.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Oct 07, 2016 at 07:15:18PM +0200, Oleg Nesterov wrote:
> On 10/07, Dave Chinner wrote:
> >
> > On Thu, Oct 06, 2016 at 07:17:58PM +0200, Oleg Nesterov wrote:
> > > Probably false positive? Although when I look at the comment above xfs_sync_sb()
> > > I think that may be sometging like below makes sense, but I know absolutely nothing
> > > about fs/ and XFS in particular.
> > >
> > > Oleg.
> > >
> > >
> > > --- x/fs/xfs/xfs_trans.c
> > > +++ x/fs/xfs/xfs_trans.c
> > > @@ -245,7 +245,8 @@ xfs_trans_alloc(
> > >  	atomic_inc(&mp->m_active_trans);
> > >
> > >  	tp = kmem_zone_zalloc(xfs_trans_zone,
> > > -		(flags & XFS_TRANS_NOFS) ? KM_NOFS : KM_SLEEP);
> > > +		(flags & (XFS_TRANS_NOFS | XFS_TRANS_NO_WRITECOUNT))
> > > +			? KM_NOFS : KM_SLEEP);
> > >  	tp->t_magic = XFS_TRANS_HEADER_MAGIC;
> > >  	tp->t_flags = flags;
> > >  	tp->t_mountp = mp;
> >
> > Brief examination says caller should set XFS_TRANS_NOFS, not change
> > the implementation to make XFS_TRANS_NO_WRITECOUNT flag to also mean
> > XFS_TRANS_NOFS.
> 
> I didn't mean the change above can fix the problem, and I don't really
> understand your suggestion.

xfs_syncsb() does:

	tp = xfs_trans_alloc(... , XFS_TRANS_NO_WRITECOUNT, ....);

but it's running in a GFP_NOFS context when a freeze is being
finalised. SO, rather than changing what XFS_TRANS_NO_WRITECOUNT
does in xfs_trans_alloc(), we should tell it to do a GFP_NOFS
allocation. i.e.

	tp = xfs_trans_alloc(... , XFS_TRANS_NOFS | XFS_TRANS_NO_WRITECOUNT, ....);

and nothing inside xfs_trans_alloc() changes at all.

> Obviously any GFP_FS allocation in xfs_fs_freeze()
> paths will trigger the same warning.

Of which there should be none except for that xfs_trans_alloc()
call.

> I added this hack
> 
> 	--- a/fs/xfs/xfs_super.c
> 	+++ b/fs/xfs/xfs_super.c
> 	@@ -1333,10 +1333,15 @@ xfs_fs_freeze(
> 		struct super_block      *sb)
> 	 {
> 		struct xfs_mount        *mp = XFS_M(sb);
> 	+       int ret;
> 	 
> 	+       current->flags |= PF_FSTRANS; // tell kmem_flags_convert() to remove GFP_FS
> 		xfs_save_resvblks(mp);
> 		xfs_quiesce_attr(mp);
> 	-       return xfs_sync_sb(mp, true);
> 	+       ret = xfs_sync_sb(mp, true);
> 	+       current->flags &= ~PF_FSTRANS;
> 	+
> 	+       return ret;
> 	 }

/me shudders

> just for testing purposes and after that I got another warning below. I didn't
> read it carefully yet, but _at first glance_ it looks like the lock inversion
> uncovered by 2/2, although I can be easily wrong. cancel_delayed_work_sync(l_work)
> under sb_internal can hang if xfs_log_worker() waits for this rwsem?`

Actually: I *can't read it*. I've got no fucking clue what lockdep
is trying to say here. This /looks/ like a lockdep is getting
confused between memory reclaim contexts (which /aren't locks/ but
overload interrupt levels) and freeze contexts (which /aren't locks/)
and workqueue locks which /aren't nested/ inside transactions or
freeze contexts. But, really, I can't follow it because I have to
guess at what "lock contexts" are not locks but are something else.

cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

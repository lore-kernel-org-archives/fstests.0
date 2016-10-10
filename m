Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:36834 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751264AbcJJBFp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 9 Oct 2016 21:05:45 -0400
Date: Mon, 10 Oct 2016 12:02:50 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH V2 2/2] fs/super.c: don't fool lockdep in freeze_super()
 and thaw_super() paths
Message-ID: <20161010010250.GO9806@dastard>
References: <20161002214225.GS9806@dastard>
 <20161003164435.GB6634@redhat.com>
 <20161004114341.GA8572@redhat.com>
 <20161004194435.GW9806@dastard>
 <20161005164432.GB15121@redhat.com>
 <20161006171758.GA21707@redhat.com>
 <20161006215920.GE9806@dastard>
 <20161007171517.GA23721@redhat.com>
 <20161007225231.GY27872@dastard>
 <20161009161456.GA11737@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161009161456.GA11737@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, Nikolay Borisov <kernel@kyup.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Oct 09, 2016 at 06:14:57PM +0200, Oleg Nesterov wrote:
> On 10/08, Dave Chinner wrote:
> >
> > On Fri, Oct 07, 2016 at 07:15:18PM +0200, Oleg Nesterov wrote:
> > > > >
> > > > > --- x/fs/xfs/xfs_trans.c
> > > > > +++ x/fs/xfs/xfs_trans.c
> > > > > @@ -245,7 +245,8 @@ xfs_trans_alloc(
> > > > >  	atomic_inc(&mp->m_active_trans);
> > > > >
> > > > >  	tp = kmem_zone_zalloc(xfs_trans_zone,
> > > > > -		(flags & XFS_TRANS_NOFS) ? KM_NOFS : KM_SLEEP);
> > > > > +		(flags & (XFS_TRANS_NOFS | XFS_TRANS_NO_WRITECOUNT))
> > > > > +			? KM_NOFS : KM_SLEEP);
> > > > >  	tp->t_magic = XFS_TRANS_HEADER_MAGIC;
> > > > >  	tp->t_flags = flags;
> > > > >  	tp->t_mountp = mp;
> > > >
> > > > Brief examination says caller should set XFS_TRANS_NOFS, not change
> > > > the implementation to make XFS_TRANS_NO_WRITECOUNT flag to also mean
> > > > XFS_TRANS_NOFS.
> > >
> > > I didn't mean the change above can fix the problem, and I don't really
> > > understand your suggestion.
> >
> > xfs_syncsb() does:
> >
> > 	tp = xfs_trans_alloc(... , XFS_TRANS_NO_WRITECOUNT, ....);
> >
> > but it's running in a GFP_NOFS context when a freeze is being
> > finalised. SO, rather than changing what XFS_TRANS_NO_WRITECOUNT
> > does in xfs_trans_alloc(), we should tell it to do a GFP_NOFS
> > allocation. i.e.
> >
> > 	tp = xfs_trans_alloc(... , XFS_TRANS_NOFS | XFS_TRANS_NO_WRITECOUNT, ....);
> 
> Ah. This is clear but I am not sure it is enough,
> 
> > > Obviously any GFP_FS allocation in xfs_fs_freeze()
> > > paths will trigger the same warning.
> >
> > Of which there should be none except for that xfs_trans_alloc()
> > call.
> 
> Really?

/Should/ is an indication of *intent*. Reality is that there may be
*bugs*. We all know that testing can't prove the absence of bugs, so
even after years and years of exercising the code with producing any
evidence there may still be problems.

So, it's time to waste more time explaining why lockdep is telling
us about something that *isn't a bug*.

> Again, I can be easily wrong, but when I look at xfs_freeze_fs()
> paths I can see
> 
> xfs_fs_freeze()->xfs_quiesce_attr()->xfs_log_quiesce()->xfs_log_unmount_write()
> ->xfs_log_reserve()->xlog_ticket_alloc(KM_SLEEP)

So, the problem being indicated here is that memory reclaim might
either try to a) write back dirty pages (which require allocation
transactions), b) might run a shrinker that requires running a
transaction or c) we might run periodic background inode reclaim.

For the case of a), this /can't happen/ because we've already run
the part of a freeze that stops pages being dirtied and then written
them all back and made them clean. So we won't run transactions from
page cache reclaim and so we can't deadlock.

For the case of b), well, that's even easier - the only shrinker
path we care about here is inode reclaim through super_cache_scan().
Before that shrinker runs anything it calls:

	if (!trylock_super(sb))
		return SHRINK_STOP;

Now, we're running memory allocation for the freeze context, which
means we are holding the sb->s_umount semaphore in write mode. That
means the shrinker is going to /fail to lock the superblock/ and
therefore not run any reclaim on that superblock.

IOWs, while we hold the s_umount lock in write mode across a memory
allocation, the shrinkers run in GFP_NOFS mode automatically. So we
can't run transactions from memory reclaim and so we will can't
deadlock.

For the case of c), xfs_quiesce_attr() does this:

	/* force the log to unpin objects from the now complete transactions */
	xfs_log_force(mp, XFS_LOG_SYNC);

	/* reclaim inodes to do any IO before the freeze completes */
	xfs_reclaim_inodes(mp, 0);
	xfs_reclaim_inodes(mp, SYNC_WAIT);

We basically unpin, clean, and reclaim all the unused inodes the XFS
inode cache. With the shrinker not reclaiming any inodes, and there
being no cached, dirty, unreclaimed inodes remaining in the cache,
there can be no background memory allocations, transactions or IO
triggered memory reclaim in this filesystem. At this point, memory
reclaim /should never block/ trying to reclaim objects from this
filesystem that require transactions to free.

>From this, it should be obvious that we don't even need to
change the code in xfs_syncsb() - in the freeze context that the
allocation is run we've got a clean filesystem where memory reclaim
won't block on the filesystem being frozen, so the code is safe as
it stands.

> > > just for testing purposes and after that I got another warning below. I didn't
> > > read it carefully yet, but _at first glance_ it looks like the lock inversion
> > > uncovered by 2/2, although I can be easily wrong. cancel_delayed_work_sync(l_work)
> > > under sb_internal can hang if xfs_log_worker() waits for this rwsem?`
> >
> > Actually: I *can't read it*. I've got no fucking clue what lockdep
> > is trying to say here. This /looks/ like a lockdep is getting
> > confused
> 
> I can almost never understand what lockdep tells me, it is too clever for me.
> But this time I think it is right.
> 
> Suppose that freeze_super() races with xfs_log_worker() callback.
> 
> freeze_super() takes sb_internal lock and xfs_log_quiesce() calls
> cancel_delayed_work_sync(l_work). This will sleep until xfs_log_worker()
> finishes.
> 
> xfs_log_worker() does a __GFP_FS alloc, triggers reclaim, and blocks
> on the same sb_internal lock. Say, in xfs_do_writepage()->xfs_trans_alloc()
> path.

See above - xfs_log_worker will not block on memory reclaim on the
filesystem because a) there are no dirty pages and b) the superblock
shrinker will not get the sb->s_umount lock and hence operates for
all contexts as though they are doing GFP_NOFS allocations.

Basically, what we are seeing here is yet another case of "lockdep
is just smart enough to be really dumb" because we cannot fully
express or cleanly annotate the contexts in which it is being asked
to validate. Unless we do something we shouldn't be doing (i.e.
marking GFP_KERNEL allocations that are safe with GFP_NOFS to shut
up lockdep), all we've just done is introduce another vector for
lockdep false positives...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

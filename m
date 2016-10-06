Received: from mx2.suse.de ([195.135.220.15]:52305 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750868AbcJFH1o (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 6 Oct 2016 03:27:44 -0400
Date: Thu, 6 Oct 2016 09:27:41 +0200
From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH V2 2/2] fs/super.c: don't fool lockdep in freeze_super()
 and thaw_super() paths
Message-ID: <20161006072741.GB27158@quack2.suse.cz>
References: <20160926161856.GB32458@quack2.suse.cz>
 <20160926165525.GA9338@redhat.com>
 <20160927065135.GA1139@quack2.suse.cz>
 <20160927172901.GA11879@redhat.com>
 <20160930171434.GA2373@redhat.com>
 <20161002214225.GS9806@dastard>
 <20161003164435.GB6634@redhat.com>
 <20161004114341.GA8572@redhat.com>
 <20161004194435.GW9806@dastard>
 <20161005164432.GB15121@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161005164432.GB15121@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, Nikolay Borisov <kernel@kyup.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, fstests@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
List-ID: <fstests@vger.kernel.org>

On Wed 05-10-16 18:44:32, Oleg Nesterov wrote:
> On 10/05, Dave Chinner wrote:
> >
> > On Tue, Oct 04, 2016 at 01:43:43PM +0200, Oleg Nesterov wrote:
> >
> > > plus the following warnings:
> > >
> > > 	[ 1894.500040] run fstests generic/070 at 2016-10-04 05:03:39
> > > 	[ 1895.076655] =================================
> > > 	[ 1895.077136] [ INFO: inconsistent lock state ]
> > > 	[ 1895.077574] 4.8.0 #1 Not tainted
> > > 	[ 1895.077900] ---------------------------------
> > > 	[ 1895.078330] inconsistent {IN-RECLAIM_FS-W} -> {RECLAIM_FS-ON-W} usage.
> > > 	[ 1895.078993] fsstress/18239 [HC0[0]:SC0[0]:HE1:SE1] takes:
> > > 	[ 1895.079522]  (&xfs_nondir_ilock_class){++++?-}, at: [<ffffffffc049ad45>] xfs_ilock+0x165/0x210 [xfs]
> > > 	[ 1895.080529] {IN-RECLAIM_FS-W} state was registered at:
> >
> > And that is a bug in the lockdep annotations for memory allocation because it
> > fails to take into account the current task flags that are set via
> > memalloc_noio_save() to prevent vmalloc from doing GFP_KERNEL allocations. i.e.
> > in _xfs_buf_map_pages():
> 
> OK, I see...
> 
> I'll re-test with the following change:
> 
> 	--- a/kernel/locking/lockdep.c
> 	+++ b/kernel/locking/lockdep.c
> 	@@ -2867,7 +2867,7 @@ static void __lockdep_trace_alloc(gfp_t gfp_mask, unsigned long flags)
> 			return;
> 	 
> 		/* We're only interested __GFP_FS allocations for now */
> 	-       if (!(gfp_mask & __GFP_FS))
> 	+       if ((curr->flags & PF_MEMALLOC_NOIO) || !(gfp_mask & __GFP_FS))
> 			return;
> 
> 
> Hmm. This is off-topic and most probably I missed something... but at
> first glance we can simplify/improve the reclaim-fs lockdep annotations:
> 
> 1. add the global "struct lockdep_map reclaim_fs_map"
> 
> 2. change __lockdep_trace_alloc
> 
> 	-	mark_held_locks(curr, RECLAIM_FS);
> 	+	lock_map_acquire(&reclaim_fs_map);
> 	+	lock_map_release(&reclaim_fs_map);
> 
> 3. turn lockdep_set/clear_current_reclaim_state() into
> 
> 	void lockdep_set_current_reclaim_state(gfp_t gfp_mask)
> 	{
> 		if (gfp_mask & __GFP_FS)
> 			lock_map_acquire(&reclaim_fs_map);
> 	}
> 
> 	void lockdep_clear_current_reclaim_state(gfp_t gfp_mask)
> 	{
> 		if (gfp_mask & __GFP_FS)
> 			lock_map_release(&reclaim_fs_map);
> 	}
> 
> and now we can remove task_struct->lockdep_reclaim_gfp and all other
> RECLAIM_FS hacks in lockdep.c. Plus we can easily extend this logic to
> check more GFP_ flags.

Yeah, looks possible to me. I've added Peter to CC since he's most likely
to know.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

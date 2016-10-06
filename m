Received: from mx1.redhat.com ([209.132.183.28]:40828 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S942442AbcJFRSC (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 6 Oct 2016 13:18:02 -0400
Date: Thu, 6 Oct 2016 19:17:58 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH V2 2/2] fs/super.c: don't fool lockdep in freeze_super()
 and thaw_super() paths
Message-ID: <20161006171758.GA21707@redhat.com>
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
To: Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, Nikolay Borisov <kernel@kyup.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 10/05, Oleg Nesterov wrote:
>
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

and with the change above "./check -b auto" finishes without lockdep warnings,
probably I should send this patch to lockdep maintainers.

Now, with 2/2 applied I got the following:

	[ INFO: inconsistent lock state ]
	4.8.0+ #4 Tainted: G        W
	---------------------------------
	inconsistent {RECLAIM_FS-ON-W} -> {IN-RECLAIM_FS-R} usage.
	kswapd0/32 [HC0[0]:SC0[0]:HE1:SE1] takes:
	 (sb_internal){+++++?}, at: [<ffffffff91292557>] __sb_start_write+0xb7/0xf0
	{RECLAIM_FS-ON-W} state was registered at:
	  [<ffffffff9110735f>] mark_held_locks+0x6f/0xa0
	  [<ffffffff9110a5f3>] lockdep_trace_alloc+0xd3/0x120
	  [<ffffffff9126034f>] kmem_cache_alloc+0x2f/0x280
	  [<ffffffffc023a251>] kmem_zone_alloc+0x81/0x120 [xfs]
	  [<ffffffffc02398bc>] xfs_trans_alloc+0x6c/0x130 [xfs]
	  [<ffffffffc020a2c9>] xfs_sync_sb+0x39/0x80 [xfs]
	  [<ffffffffc02332fd>] xfs_log_sbcount+0x4d/0x50 [xfs]
	  [<ffffffffc02348d7>] xfs_quiesce_attr+0x57/0xb0 [xfs]
	  [<ffffffffc0234951>] xfs_fs_freeze+0x21/0x40 [xfs]
	  [<ffffffff91291e8f>] freeze_super+0xcf/0x190
	  [<ffffffff912a521f>] do_vfs_ioctl+0x55f/0x6c0
	  [<ffffffff912a53f9>] SyS_ioctl+0x79/0x90
	  [<ffffffff918af23c>] entry_SYSCALL_64_fastpath+0x1f/0xbd
	irq event stamp: 36471805
	hardirqs last  enabled at (36471805): [<ffffffff911f9c8d>] clear_page_dirty_for_io+0x1ed/0x2e0
	hardirqs last disabled at (36471804): [<ffffffff911f9c5d>] clear_page_dirty_for_io+0x1bd/0x2e0
	softirqs last  enabled at (36468590): [<ffffffff918b24ea>] __do_softirq+0x37a/0x44d
	softirqs last disabled at (36468579): [<ffffffff910b2f15>] irq_exit+0xe5/0xf0

	other info that might help us debug this:
	 Possible unsafe locking scenario:
	       CPU0
	       ----
	  lock(sb_internal);
	  <Interrupt>
	    lock(sb_internal);

	 *** DEADLOCK ***
	no locks held by kswapd0/32.

	stack backtrace:
	CPU: 0 PID: 32 Comm: kswapd0 Tainted: G        W       4.8.0+ #4
	Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
	 0000000000000086 00000000028a3434 ffff880139b2b520 ffffffff91449193
	 ffff880139b1a680 ffffffff928c1e70 ffff880139b2b570 ffffffff91106c75
	 0000000000000000 0000000000000001 ffff880100000001 000000000000000a
	Call Trace:
	 [<ffffffff91449193>] dump_stack+0x85/0xc2
	 [<ffffffff91106c75>] print_usage_bug+0x215/0x240
	 [<ffffffff9110722b>] mark_lock+0x58b/0x650
	 [<ffffffff91106080>] ? print_shortest_lock_dependencies+0x1a0/0x1a0
	 [<ffffffff91107c4d>] __lock_acquire+0x36d/0x1870
	 [<ffffffff911097dd>] lock_acquire+0x10d/0x200
	 [<ffffffff91292557>] ? __sb_start_write+0xb7/0xf0
	 [<ffffffff91102ecc>] percpu_down_read+0x3c/0x90
	 [<ffffffff91292557>] ? __sb_start_write+0xb7/0xf0
	 [<ffffffff91292557>] __sb_start_write+0xb7/0xf0
	 [<ffffffffc0239933>] xfs_trans_alloc+0xe3/0x130 [xfs]
	 [<ffffffffc0227dd7>] xfs_iomap_write_allocate+0x1f7/0x380 [xfs]
	 [<ffffffffc020c333>] ? xfs_map_blocks+0xe3/0x380 [xfs]
	 [<ffffffff911268b8>] ? rcu_read_lock_sched_held+0x58/0x60
	 [<ffffffffc020c47a>] xfs_map_blocks+0x22a/0x380 [xfs]
	 [<ffffffffc020dbf8>] xfs_do_writepage+0x188/0x6c0 [xfs]
	 [<ffffffffc020e16b>] xfs_vm_writepage+0x3b/0x70 [xfs]
	 [<ffffffff912049b0>] pageout.isra.46+0x190/0x380
	 [<ffffffff91207cab>] shrink_page_list+0x9ab/0xa70
	 [<ffffffff91208592>] shrink_inactive_list+0x252/0x5d0
	 [<ffffffff9120921f>] shrink_node_memcg+0x5af/0x790
	 [<ffffffff912094e1>] shrink_node+0xe1/0x320
	 [<ffffffff9120a9d7>] kswapd+0x387/0x8b0

Probably false positive? Although when I look at the comment above xfs_sync_sb()
I think that may be sometging like below makes sense, but I know absolutely nothing
about fs/ and XFS in particular.

Oleg.


--- x/fs/xfs/xfs_trans.c
+++ x/fs/xfs/xfs_trans.c
@@ -245,7 +245,8 @@ xfs_trans_alloc(
 	atomic_inc(&mp->m_active_trans);
 
 	tp = kmem_zone_zalloc(xfs_trans_zone,
-		(flags & XFS_TRANS_NOFS) ? KM_NOFS : KM_SLEEP);
+		(flags & (XFS_TRANS_NOFS | XFS_TRANS_NO_WRITECOUNT))
+			? KM_NOFS : KM_SLEEP);
 	tp->t_magic = XFS_TRANS_HEADER_MAGIC;
 	tp->t_flags = flags;
 	tp->t_mountp = mp;


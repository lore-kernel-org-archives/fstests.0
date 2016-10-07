Received: from mx1.redhat.com ([209.132.183.28]:54228 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964900AbcJGRPV (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 7 Oct 2016 13:15:21 -0400
Date: Fri, 7 Oct 2016 19:15:18 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH V2 2/2] fs/super.c: don't fool lockdep in freeze_super()
 and thaw_super() paths
Message-ID: <20161007171517.GA23721@redhat.com>
References: <20160927065135.GA1139@quack2.suse.cz>
 <20160927172901.GA11879@redhat.com>
 <20160930171434.GA2373@redhat.com>
 <20161002214225.GS9806@dastard>
 <20161003164435.GB6634@redhat.com>
 <20161004114341.GA8572@redhat.com>
 <20161004194435.GW9806@dastard>
 <20161005164432.GB15121@redhat.com>
 <20161006171758.GA21707@redhat.com>
 <20161006215920.GE9806@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161006215920.GE9806@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, Nikolay Borisov <kernel@kyup.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 10/07, Dave Chinner wrote:
>
> On Thu, Oct 06, 2016 at 07:17:58PM +0200, Oleg Nesterov wrote:
> > Probably false positive? Although when I look at the comment above xfs_sync_sb()
> > I think that may be sometging like below makes sense, but I know absolutely nothing
> > about fs/ and XFS in particular.
> >
> > Oleg.
> >
> >
> > --- x/fs/xfs/xfs_trans.c
> > +++ x/fs/xfs/xfs_trans.c
> > @@ -245,7 +245,8 @@ xfs_trans_alloc(
> >  	atomic_inc(&mp->m_active_trans);
> >
> >  	tp = kmem_zone_zalloc(xfs_trans_zone,
> > -		(flags & XFS_TRANS_NOFS) ? KM_NOFS : KM_SLEEP);
> > +		(flags & (XFS_TRANS_NOFS | XFS_TRANS_NO_WRITECOUNT))
> > +			? KM_NOFS : KM_SLEEP);
> >  	tp->t_magic = XFS_TRANS_HEADER_MAGIC;
> >  	tp->t_flags = flags;
> >  	tp->t_mountp = mp;
>
> Brief examination says caller should set XFS_TRANS_NOFS, not change
> the implementation to make XFS_TRANS_NO_WRITECOUNT flag to also mean
> XFS_TRANS_NOFS.

I didn't mean the change above can fix the problem, and I don't really
understand your suggestion. Obviously any GFP_FS allocation in xfs_fs_freeze()
paths will trigger the same warning.

I added this hack

	--- a/fs/xfs/xfs_super.c
	+++ b/fs/xfs/xfs_super.c
	@@ -1333,10 +1333,15 @@ xfs_fs_freeze(
		struct super_block      *sb)
	 {
		struct xfs_mount        *mp = XFS_M(sb);
	+       int ret;
	 
	+       current->flags |= PF_FSTRANS; // tell kmem_flags_convert() to remove GFP_FS
		xfs_save_resvblks(mp);
		xfs_quiesce_attr(mp);
	-       return xfs_sync_sb(mp, true);
	+       ret = xfs_sync_sb(mp, true);
	+       current->flags &= ~PF_FSTRANS;
	+
	+       return ret;
	 }

just for testing purposes and after that I got another warning below. I didn't
read it carefully yet, but _at first glance_ it looks like the lock inversion
uncovered by 2/2, although I can be easily wrong. cancel_delayed_work_sync(l_work)
under sb_internal can hang if xfs_log_worker() waits for this rwsem?`

Oleg.

=========================================================
[ INFO: possible irq lock inversion dependency detected ]
4.8.0+ #10 Tainted: G        W      
---------------------------------------------------------
kswapd0/32 just changed the state of lock:
 (sb_internal){++++.?}, at: [<ffffffffb92925c7>] __sb_start_write+0xb7/0xf0
but this lock took another, RECLAIM_FS-unsafe lock in the past:
 ((&(&log->l_work)->work)){+.+.+.}

and interrupts could create inverse lock ordering between them.

other info that might help us debug this:
 Possible interrupt unsafe locking scenario:
       CPU0                    CPU1
       ----                    ----
  lock((&(&log->l_work)->work));
                               local_irq_disable();
                               lock(sb_internal);
                               lock((&(&log->l_work)->work));
  <Interrupt>
    lock(sb_internal);

 *** DEADLOCK ***
no locks held by kswapd0/32.

the shortest dependencies between 2nd lock and 1st lock:
 -> ((&(&log->l_work)->work)){+.+.+.} ops: 803 {
    HARDIRQ-ON-W at:
                      [<ffffffffb9107ef1>] __lock_acquire+0x611/0x1870
                      [<ffffffffb91097dd>] lock_acquire+0x10d/0x200
                      [<ffffffffb90cad49>] process_one_work+0x1c9/0x690
                      [<ffffffffb90cb25e>] worker_thread+0x4e/0x480
                      [<ffffffffb90d1d13>] kthread+0xf3/0x110
                      [<ffffffffb9a2146f>] ret_from_fork+0x1f/0x40
    SOFTIRQ-ON-W at:
                      [<ffffffffb9107f23>] __lock_acquire+0x643/0x1870
                      [<ffffffffb91097dd>] lock_acquire+0x10d/0x200
                      [<ffffffffb90cad49>] process_one_work+0x1c9/0x690
                      [<ffffffffb90cb25e>] worker_thread+0x4e/0x480
                      [<ffffffffb90d1d13>] kthread+0xf3/0x110
                      [<ffffffffb9a2146f>] ret_from_fork+0x1f/0x40
    RECLAIM_FS-ON-W at:
                         [<ffffffffb910735f>] mark_held_locks+0x6f/0xa0
                         [<ffffffffb910a5f3>] lockdep_trace_alloc+0xd3/0x120
                         [<ffffffffb92603bf>] kmem_cache_alloc+0x2f/0x280
                         [<ffffffffb941f5e1>] kmem_zone_alloc+0x81/0x120
                         [<ffffffffb941ec4c>] xfs_trans_alloc+0x6c/0x130
                         [<ffffffffb93ef649>] xfs_sync_sb+0x39/0x80
                         [<ffffffffb9423914>] xfs_log_worker+0xd4/0xf0
                         [<ffffffffb90cad70>] process_one_work+0x1f0/0x690
                         [<ffffffffb90cb25e>] worker_thread+0x4e/0x480
                         [<ffffffffb90d1d13>] kthread+0xf3/0x110
                         [<ffffffffb9a2146f>] ret_from_fork+0x1f/0x40
    INITIAL USE at:
                     [<ffffffffb9107b2b>] __lock_acquire+0x24b/0x1870
                     [<ffffffffb91097dd>] lock_acquire+0x10d/0x200
                     [<ffffffffb90cad49>] process_one_work+0x1c9/0x690
                     [<ffffffffb90cb25e>] worker_thread+0x4e/0x480
                     [<ffffffffb90d1d13>] kthread+0xf3/0x110
                     [<ffffffffb9a2146f>] ret_from_fork+0x1f/0x40
  }
  ... key      at: [<ffffffffbb133758>] __key.130101+0x0/0x8
  ... acquired at:
   [<ffffffffb91097dd>] lock_acquire+0x10d/0x200
   [<ffffffffb90c981c>] flush_work+0x4c/0x2c0
   [<ffffffffb90cbe01>] __cancel_work_timer+0x131/0x1f0
   [<ffffffffb90cbef3>] cancel_delayed_work_sync+0x13/0x20
   [<ffffffffb94245a4>] xfs_log_quiesce+0x34/0x3b0
   [<ffffffffb9419c6d>] xfs_quiesce_attr+0x6d/0xb0
   [<ffffffffb9419ce3>] xfs_fs_freeze+0x33/0x50
   [<ffffffffb9291eff>] freeze_super+0xcf/0x190
   [<ffffffffb92a528f>] do_vfs_ioctl+0x55f/0x6c0
   [<ffffffffb92a5469>] SyS_ioctl+0x79/0x90
   [<ffffffffb9a2123c>] entry_SYSCALL_64_fastpath+0x1f/0xbd

-> (sb_internal){++++.?} ops: 28351355 {
   HARDIRQ-ON-W at:
                    [<ffffffffb9107ef1>] __lock_acquire+0x611/0x1870
                    [<ffffffffb91097dd>] lock_acquire+0x10d/0x200
                    [<ffffffffb9a1e3a6>] down_write+0x36/0x70
                    [<ffffffffb9102fb3>] percpu_down_write+0x33/0x100
                    [<ffffffffb9291eed>] freeze_super+0xbd/0x190
                    [<ffffffffb92a528f>] do_vfs_ioctl+0x55f/0x6c0
                    [<ffffffffb92a5469>] SyS_ioctl+0x79/0x90
                    [<ffffffffb9a2123c>] entry_SYSCALL_64_fastpath+0x1f/0xbd
   HARDIRQ-ON-R at:
                    [<ffffffffb9107bed>] __lock_acquire+0x30d/0x1870
                    [<ffffffffb91097dd>] lock_acquire+0x10d/0x200
                    [<ffffffffb91030c8>] percpu_down_read_trylock+0x48/0xa0
                    [<ffffffffb929258a>] __sb_start_write+0x7a/0xf0
                    [<ffffffffb941ecc3>] xfs_trans_alloc+0xe3/0x130
                    [<ffffffffb940dcba>] xfs_vn_update_time+0x7a/0x210
                    [<ffffffffb92b1038>] touch_atime+0xa8/0xd0
                    [<ffffffffb91ed573>] generic_file_read_iter+0x703/0x8d0
                    [<ffffffffb9401513>] xfs_file_buffered_aio_read+0x63/0x170
                    [<ffffffffb9401688>] xfs_file_read_iter+0x68/0xc0
                    [<ffffffffb928de90>] __vfs_read+0xe0/0x150
                    [<ffffffffb928efb5>] vfs_read+0x95/0x140
                    [<ffffffffb92904e8>] SyS_read+0x58/0xc0
                    [<ffffffffb9003edc>] do_syscall_64+0x6c/0x1e0
                    [<ffffffffb9a212ff>] return_from_SYSCALL_64+0x0/0x7a
   SOFTIRQ-ON-W at:
                    [<ffffffffb9107f23>] __lock_acquire+0x643/0x1870
                    [<ffffffffb91097dd>] lock_acquire+0x10d/0x200
                    [<ffffffffb9a1e3a6>] down_write+0x36/0x70
                    [<ffffffffb9102fb3>] percpu_down_write+0x33/0x100
                    [<ffffffffb9291eed>] freeze_super+0xbd/0x190
                    [<ffffffffb92a528f>] do_vfs_ioctl+0x55f/0x6c0
                    [<ffffffffb92a5469>] SyS_ioctl+0x79/0x90
                    [<ffffffffb9a2123c>] entry_SYSCALL_64_fastpath+0x1f/0xbd
   SOFTIRQ-ON-R at:
                    [<ffffffffb9107f23>] __lock_acquire+0x643/0x1870
                    [<ffffffffb91097dd>] lock_acquire+0x10d/0x200
                    [<ffffffffb91030c8>] percpu_down_read_trylock+0x48/0xa0
                    [<ffffffffb929258a>] __sb_start_write+0x7a/0xf0
                    [<ffffffffb941ecc3>] xfs_trans_alloc+0xe3/0x130
                    [<ffffffffb940dcba>] xfs_vn_update_time+0x7a/0x210
                    [<ffffffffb92b1038>] touch_atime+0xa8/0xd0
                    [<ffffffffb91ed573>] generic_file_read_iter+0x703/0x8d0
                    [<ffffffffb9401513>] xfs_file_buffered_aio_read+0x63/0x170
                    [<ffffffffb9401688>] xfs_file_read_iter+0x68/0xc0
                    [<ffffffffb928de90>] __vfs_read+0xe0/0x150
                    [<ffffffffb928efb5>] vfs_read+0x95/0x140
                    [<ffffffffb92904e8>] SyS_read+0x58/0xc0
                    [<ffffffffb9003edc>] do_syscall_64+0x6c/0x1e0
                    [<ffffffffb9a212ff>] return_from_SYSCALL_64+0x0/0x7a
   IN-RECLAIM_FS-R at:
                       [<ffffffffb9107c4d>] __lock_acquire+0x36d/0x1870
                       [<ffffffffb91097dd>] lock_acquire+0x10d/0x200
                       [<ffffffffb9102ecc>] percpu_down_read+0x3c/0x90
                       [<ffffffffb92925c7>] __sb_start_write+0xb7/0xf0
                       [<ffffffffb941ecc3>] xfs_trans_alloc+0xe3/0x130
                       [<ffffffffb940d157>] xfs_iomap_write_allocate+0x1f7/0x380
                       [<ffffffffb93f17fa>] xfs_map_blocks+0x22a/0x380
                       [<ffffffffb93f2f78>] xfs_do_writepage+0x188/0x6c0
                       [<ffffffffb93f34eb>] xfs_vm_writepage+0x3b/0x70
                       [<ffffffffb9204a20>] pageout.isra.46+0x190/0x380
                       [<ffffffffb9207d1b>] shrink_page_list+0x9ab/0xa70
                       [<ffffffffb9208602>] shrink_inactive_list+0x252/0x5d0
                       [<ffffffffb920928f>] shrink_node_memcg+0x5af/0x790
                       [<ffffffffb9209551>] shrink_node+0xe1/0x320
                       [<ffffffffb920aa47>] kswapd+0x387/0x8b0
                       [<ffffffffb90d1d13>] kthread+0xf3/0x110
                       [<ffffffffb9a2146f>] ret_from_fork+0x1f/0x40
   RECLAIM_FS-ON-R at:
                       [<ffffffffb910735f>] mark_held_locks+0x6f/0xa0
                       [<ffffffffb910a5f3>] lockdep_trace_alloc+0xd3/0x120
                       [<ffffffffb92603bf>] kmem_cache_alloc+0x2f/0x280
                       [<ffffffffb941f5e1>] kmem_zone_alloc+0x81/0x120
                       [<ffffffffb941ec4c>] xfs_trans_alloc+0x6c/0x130
                       [<ffffffffb940dcba>] xfs_vn_update_time+0x7a/0x210
                       [<ffffffffb92b1038>] touch_atime+0xa8/0xd0
                       [<ffffffffb91ed573>] generic_file_read_iter+0x703/0x8d0
                       [<ffffffffb9401513>] xfs_file_buffered_aio_read+0x63/0x170
                       [<ffffffffb9401688>] xfs_file_read_iter+0x68/0xc0
                       [<ffffffffb928de90>] __vfs_read+0xe0/0x150
                       [<ffffffffb928efb5>] vfs_read+0x95/0x140
                       [<ffffffffb92904e8>] SyS_read+0x58/0xc0
                       [<ffffffffb9003edc>] do_syscall_64+0x6c/0x1e0
                       [<ffffffffb9a212ff>] return_from_SYSCALL_64+0x0/0x7a
   INITIAL USE at:
                   [<ffffffffb9107b2b>] __lock_acquire+0x24b/0x1870
                   [<ffffffffb91097dd>] lock_acquire+0x10d/0x200
                   [<ffffffffb91030c8>] percpu_down_read_trylock+0x48/0xa0
                   [<ffffffffb929258a>] __sb_start_write+0x7a/0xf0
                   [<ffffffffb941ecc3>] xfs_trans_alloc+0xe3/0x130
                   [<ffffffffb940dcba>] xfs_vn_update_time+0x7a/0x210
                   [<ffffffffb92b1038>] touch_atime+0xa8/0xd0
                   [<ffffffffb91ed573>] generic_file_read_iter+0x703/0x8d0
                   [<ffffffffb9401513>] xfs_file_buffered_aio_read+0x63/0x170
                   [<ffffffffb9401688>] xfs_file_read_iter+0x68/0xc0
                   [<ffffffffb928de90>] __vfs_read+0xe0/0x150
                   [<ffffffffb928efb5>] vfs_read+0x95/0x140
                   [<ffffffffb92904e8>] SyS_read+0x58/0xc0
                   [<ffffffffb9003edc>] do_syscall_64+0x6c/0x1e0
                   [<ffffffffb9a212ff>] return_from_SYSCALL_64+0x0/0x7a
 }
 ... key      at: [<ffffffffba0b1a00>] xfs_fs_type+0x60/0x80
 ... acquired at:
   [<ffffffffb91061d1>] check_usage_forwards+0x151/0x160
   [<ffffffffb9106fea>] mark_lock+0x34a/0x650
   [<ffffffffb9107c4d>] __lock_acquire+0x36d/0x1870
   [<ffffffffb91097dd>] lock_acquire+0x10d/0x200
   [<ffffffffb9102ecc>] percpu_down_read+0x3c/0x90
   [<ffffffffb92925c7>] __sb_start_write+0xb7/0xf0
   [<ffffffffb941ecc3>] xfs_trans_alloc+0xe3/0x130
   [<ffffffffb940d157>] xfs_iomap_write_allocate+0x1f7/0x380
   [<ffffffffb93f17fa>] xfs_map_blocks+0x22a/0x380
   [<ffffffffb93f2f78>] xfs_do_writepage+0x188/0x6c0
   [<ffffffffb93f34eb>] xfs_vm_writepage+0x3b/0x70
   [<ffffffffb9204a20>] pageout.isra.46+0x190/0x380
   [<ffffffffb9207d1b>] shrink_page_list+0x9ab/0xa70
   [<ffffffffb9208602>] shrink_inactive_list+0x252/0x5d0
   [<ffffffffb920928f>] shrink_node_memcg+0x5af/0x790
   [<ffffffffb9209551>] shrink_node+0xe1/0x320
   [<ffffffffb920aa47>] kswapd+0x387/0x8b0
   [<ffffffffb90d1d13>] kthread+0xf3/0x110
   [<ffffffffb9a2146f>] ret_from_fork+0x1f/0x40


stack backtrace:
CPU: 0 PID: 32 Comm: kswapd0 Tainted: G        W       4.8.0+ #10
Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
 0000000000000086 0000000020cdca74 ffff880136c5b490 ffffffffb95b7a73
 ffffffffbae7ed80 ffff880136c5b4f0 ffff880136c5b4d0 ffffffffb91e7c5a
 ffff880136c3aee8 ffff880136c3aee8 ffff880136c3a680 ffffffffb9e8bbdd
Call Trace:
 [<ffffffffb95b7a73>] dump_stack+0x85/0xc2
 [<ffffffffb91e7c5a>] print_irq_inversion_bug.part.36+0x1a4/0x1b0
 [<ffffffffb91061d1>] check_usage_forwards+0x151/0x160
 [<ffffffffb9106fea>] mark_lock+0x34a/0x650
 [<ffffffffb9106080>] ? print_shortest_lock_dependencies+0x1a0/0x1a0
 [<ffffffffb9107c4d>] __lock_acquire+0x36d/0x1870
 [<ffffffffb9107d55>] ? __lock_acquire+0x475/0x1870
 [<ffffffffb91097dd>] lock_acquire+0x10d/0x200
 [<ffffffffb92925c7>] ? __sb_start_write+0xb7/0xf0
 [<ffffffffb9102ecc>] percpu_down_read+0x3c/0x90
 [<ffffffffb92925c7>] ? __sb_start_write+0xb7/0xf0
 [<ffffffffb92925c7>] __sb_start_write+0xb7/0xf0
 [<ffffffffb941ecc3>] xfs_trans_alloc+0xe3/0x130
 [<ffffffffb940d157>] xfs_iomap_write_allocate+0x1f7/0x380
 [<ffffffffb93f16b3>] ? xfs_map_blocks+0xe3/0x380
 [<ffffffffb91268b8>] ? rcu_read_lock_sched_held+0x58/0x60
 [<ffffffffb93f17fa>] xfs_map_blocks+0x22a/0x380
 [<ffffffffb93f2f78>] xfs_do_writepage+0x188/0x6c0
 [<ffffffffb93f34eb>] xfs_vm_writepage+0x3b/0x70
 [<ffffffffb9204a20>] pageout.isra.46+0x190/0x380
 [<ffffffffb9207d1b>] shrink_page_list+0x9ab/0xa70
 [<ffffffffb9208602>] shrink_inactive_list+0x252/0x5d0
 [<ffffffffb920928f>] shrink_node_memcg+0x5af/0x790
 [<ffffffffb9209551>] shrink_node+0xe1/0x320
 [<ffffffffb920aa47>] kswapd+0x387/0x8b0
 [<ffffffffb920a6c0>] ? mem_cgroup_shrink_node+0x2e0/0x2e0
 [<ffffffffb90d1d13>] kthread+0xf3/0x110
 [<ffffffffb9a2146f>] ret_from_fork+0x1f/0x40
 [<ffffffffb90d1c20>] ? kthread_create_on_node+0x230/0x230


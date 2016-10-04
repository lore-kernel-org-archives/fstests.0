Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:18600 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751479AbcJDTok (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 4 Oct 2016 15:44:40 -0400
Date: Wed, 5 Oct 2016 06:44:35 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH V2 2/2] fs/super.c: don't fool lockdep in freeze_super()
 and thaw_super() paths
Message-ID: <20161004194435.GW9806@dastard>
References: <20160926160724.GA6739@redhat.com>
 <20160926160806.GB6748@redhat.com>
 <20160926161856.GB32458@quack2.suse.cz>
 <20160926165525.GA9338@redhat.com>
 <20160927065135.GA1139@quack2.suse.cz>
 <20160927172901.GA11879@redhat.com>
 <20160930171434.GA2373@redhat.com>
 <20161002214225.GS9806@dastard>
 <20161003164435.GB6634@redhat.com>
 <20161004114341.GA8572@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161004114341.GA8572@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, Nikolay Borisov <kernel@kyup.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Oct 04, 2016 at 01:43:43PM +0200, Oleg Nesterov wrote:
> On 10/03, Oleg Nesterov wrote:
> >
> > On 10/03, Dave Chinner wrote:
> > >
> > > On Fri, Sep 30, 2016 at 07:14:34PM +0200, Oleg Nesterov wrote:
> > > > On 09/27, Oleg Nesterov wrote:
> > > > >
> > > > Jan, I gave up.
> > > >
> > > > Whatever I did xfstests-dev/check reports a lot of failures, kernel bugs,
> > > > and finally either crashes the kernel or hangs.
> > >
> > > Did you run the auto group like I suggested? That's the set of tests
> > > that should complete successfully with minimal failures and without
> > > crashing the machine.
> >
> > OK, I'll reserve a testing machine again.
> 
> Fedora 23 running in KVM guest
> 
> kernel v4.8 clean, see .config below
> 
> xfstests from git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> last commit 0bbd20b104765c75faaf8e28a54c32df505ce7fd ("btrfs: test
> free space tree mount options")
> 
> script:
> 
> 	dd if=/dev/zero of=TEST.img bs=1MiB count=8192
> 	dd if=/dev/zero of=SCRATCH.img bs=1MiB count=8192
> 
> 	losetup --find --show TEST.img
> 	losetup --find --show SCRATCH.img
> 
> 	mkfs.xfs -f /dev/loop0
> 	mkfs.xfs -f /dev/loop1
> 
> 	mkdir -p TEST SCRATCH
> 
> 	mount /dev/loop0 TEST
> 	mount /dev/loop1 SCRATCH
> 
> 	TEST_DEV=/dev/loop0 TEST_DIR=TEST SCRATCH_DEV=/dev/loop1 SCRATCH_MNT=SCRATCH ./check -g auto

Looks sane.

> This time it hangs after generic/274:
> 
> 	--- tests/generic/274.out	2016-10-04 04:23:24.209006171 -0400
> 	+++ /root/XFS/xfstests-dev/results//generic/274.out.bad	2016-10-04 05:17:49.291742498 -0400
> 	@@ -3,3 +3,4 @@
> 	preallocation test
> 	------------------------------
> 	done
> 	+./common/rc: line 344:  4693 Segmentation fault      exit
> 	...
> 	(Run 'diff -u tests/generic/274.out /root/XFS/xfstests-dev/results//generic/274.out.bad'  to see the entire diff)
> 
> because of kernel bug:
> 
> 	[ 2730.242537] run fstests generic/274 at 2016-10-04 05:17:34
> 	[ 2730.738352] XFS (loop1): Mounting V5 Filesystem
> 	[ 2730.741451] XFS (loop1): Ending clean mount
> 	[ 2744.508698] ------------[ cut here ]------------
> 	[ 2744.509190] kernel BUG at ./include/linux/swap.h:276!
> 
> static inline void workingset_node_shadows_dec(struct radix_tree_node *node)
> {
> 	VM_BUG_ON(!workingset_node_shadows(node));
> 	node->count -= 1U << RADIX_TREE_COUNT_SHIFT;
> }

Linus had a massive rant about this yesterday. Regression was
introduced between v4.8-rc8 and v4.8 and it took Linus's machine
down. xfstests found a filesystem related kernel bug, as it's
supposed to.

> plus the following warnings:
> 
> 	[ 1894.500040] run fstests generic/070 at 2016-10-04 05:03:39
> 	[ 1895.076655] =================================
> 	[ 1895.077136] [ INFO: inconsistent lock state ]
> 	[ 1895.077574] 4.8.0 #1 Not tainted
> 	[ 1895.077900] ---------------------------------
> 	[ 1895.078330] inconsistent {IN-RECLAIM_FS-W} -> {RECLAIM_FS-ON-W} usage.
> 	[ 1895.078993] fsstress/18239 [HC0[0]:SC0[0]:HE1:SE1] takes:
> 	[ 1895.079522]  (&xfs_nondir_ilock_class){++++?-}, at: [<ffffffffc049ad45>] xfs_ilock+0x165/0x210 [xfs]
> 	[ 1895.080529] {IN-RECLAIM_FS-W} state was registered at:

[snip kswapd doing XFS inode reclaim]

> 	[ 1895.102565] CPU: 0 PID: 18239 Comm: fsstress Not tainted 4.8.0 #1
> 	[ 1895.103160] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
> 	[ 1895.103721]  0000000000000086 000000008f20d9c8 ffff880038b73818 ffffffffb6449133
> 	[ 1895.104486]  ffff880038a5cd00 ffffffffb78bcd70 ffff880038b73868 ffffffffb6106c75
> 	[ 1895.105257]  0000000000000000 0000000000000001 ffff880000000001 0000000000000008
> 	[ 1895.106034] Call Trace:
> 	[ 1895.106281]  [<ffffffffb6449133>] dump_stack+0x85/0xc2
> 	[ 1895.106789]  [<ffffffffb6106c75>] print_usage_bug+0x215/0x240
> 	[ 1895.107352]  [<ffffffffb610722b>] mark_lock+0x58b/0x650
> 	[ 1895.107888]  [<ffffffffb61061e0>] ? check_usage_forwards+0x160/0x160
> 	[ 1895.108506]  [<ffffffffb610735f>] mark_held_locks+0x6f/0xa0
> 	[ 1895.109085]  [<ffffffffb610a5ea>] lockdep_trace_alloc+0xca/0x110
> 	[ 1895.109695]  [<ffffffffb6260b89>] kmem_cache_alloc_node_trace+0x39/0x2a0
> 	[ 1895.110414]  [<ffffffffb623e2ce>] ? vm_map_ram+0x2de/0x490
> 	[ 1895.110995]  [<ffffffffb623e2ce>] vm_map_ram+0x2de/0x490
> 	[ 1895.111536]  [<ffffffffb623e03b>] ? vm_map_ram+0x4b/0x490
> 	[ 1895.112142]  [<ffffffffc04823bc>] _xfs_buf_map_pages+0x6c/0x110 [xfs]
> 	[ 1895.112837]  [<ffffffffc04847f7>] xfs_buf_get_map+0x2c7/0x470 [xfs]
> 	[ 1895.113500]  [<ffffffffc043f5b9>] xfs_attr_rmtval_set+0x2c9/0x450 [xfs]
> 	[ 1895.114235]  [<ffffffffc0438019>] xfs_attr_node_addname+0x4c9/0x5d0 [xfs]
> 	[ 1895.114948]  [<ffffffffc043917c>] xfs_attr_set+0x3dc/0x460 [xfs]
> 	[ 1895.115593]  [<ffffffffc04a8d4f>] xfs_xattr_set+0x4f/0x90 [xfs]
> 	[ 1895.116221]  [<ffffffffb62bb2d0>] generic_setxattr+0x70/0x80
> 	[ 1895.116798]  [<ffffffffb62bba9f>] __vfs_setxattr_noperm+0xaf/0x1a0
> 	[ 1895.117445]  [<ffffffffb63bc525>] ? security_inode_setxattr+0x65/0xb0
> 	[ 1895.118121]  [<ffffffffb62bbc37>] vfs_setxattr+0xa7/0xb0
> 	[ 1895.118651]  [<ffffffffb62bbd69>] setxattr+0x129/0x190

And that is a bug in the lockdep annotations for memory allocation because it
fails to take into account the current task flags that are set via
memalloc_noio_save() to prevent vmalloc from doing GFP_KERNEL allocations. i.e.
in _xfs_buf_map_pages():

                /*
                 * vm_map_ram() will allocate auxillary structures (e.g.
                 * pagetables) with GFP_KERNEL, yet we are likely to be under
                 * GFP_NOFS context here. Hence we need to tell memory reclaim
                 * that we are in such a context via PF_MEMALLOC_NOIO to prevent
                 * memory reclaim re-entering the filesystem here and
                 * potentially deadlocking.
                 */
                noio_flag = memalloc_noio_save();
                do {
                        bp->b_addr = vm_map_ram(bp->b_pages, bp->b_page_count,
                                                -1, PAGE_KERNEL);
                        if (bp->b_addr)
                                break;
                        vm_unmap_aliases();
                } while (retried++ <= 1);
                memalloc_noio_restore(noio_flag);

So: lockdep annotation bug.

> 	[ 2018.537291] run fstests generic/095 at 2016-10-04 05:05:43
> 	[ 2018.733488] XFS (loop1): Unmounting Filesystem
> 	[ 2019.341189] XFS (loop1): Mounting V5 Filesystem
> 	[ 2019.344046] XFS (loop1): Ending clean mount
> 	[ 2019.796930] ------------[ cut here ]------------
> 	[ 2019.797529] WARNING: CPU: 0 PID: 10347 at fs/xfs/xfs_file.c:311 xfs_file_dio_aio_read+0x2d2/0x370 [xfs]
[snip]
> 	[ 2019.814146] WARNING: CPU: 0 PID: 10363 at fs/xfs/xfs_file.c:665 xfs_file_dio_aio_write+0x391/0x460 [xfs]
[snip]

And generic/095 is expected to generate those warnings and filters
them out in the test (the test harness checks dmesg for unexpected
failures). I explained the reason for these warnings yesterday.

In summary: xfstests found a real bug, a lockdep annotation
annoyance, and exercised a path that causes data corruption and
should trigger warnings. Looks to me like xfstests is doing exactly
what it is supposed to be doing doing....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

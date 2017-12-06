Received: from LGEAMRELO12.lge.com ([156.147.23.52]:38185 "EHLO
        lgeamrelo12.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752423AbdLFGXa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 6 Dec 2017 01:23:30 -0500
Subject: Re: False lockdep completion splats with loop device
References: <20171205030352.6xdopj7cpy5zlwzv@thunk.org>
 <de4d8fd6-48a2-60b6-bab4-d2006e48d828@lge.com>
 <20171205150741.xsbp4mtilqfrsukl@thunk.org>
From: Byungchul Park <byungchul.park@lge.com>
Message-ID: <7ef3152c-e723-33fe-a27e-14536f289a84@lge.com>
Date: Wed, 6 Dec 2017 15:23:28 +0900
MIME-Version: 1.0
In-Reply-To: <20171205150741.xsbp4mtilqfrsukl@thunk.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, kernel-team@lge.com
List-ID: <fstests@vger.kernel.org>

On 12/6/2017 12:07 AM, Theodore Ts'o wrote:
> On Tue, Dec 05, 2017 at 02:16:45PM +0900, Byungchul Park wrote:
>>
>> Hello,
>>
>> I believe that the commit e319e1fbd9d42 "block, locking/lockdep: Assign
>> a lock_class per gendisk used for wait_for_completion()" solved the
>> false positive.
>>
>> Could you tell me if it doesn't handle it, with the report? Then, I
>> will follow up and try to solve it.
> 
> No, it doesn't handle it.  And there was some discussion in the linked
> thread on the xfs mailing list that seemed to indicate that it was not
> a complete fix.
> 
> The following is a run of shared/298[1] using the dev branch of ext4.git
> on kernel.org.  The kvm-xfstests appliance can be found at [2], with
> instructions on how to use it at [3].
> 
> [1] https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/tests/shared/298
> [2] https://www.kernel.org/pub/linux/kernel/people/tytso/kvm-xfstests
> [3] https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md

OK, I will check it.

Thanks for informing the way to test.

> 
> 							- Ted
> 
> KERNEL: kernel	4.15.0-rc2-xfstests-00002-ge243560f12d7 #439 SMP Tue Dec 5 09:30:08 EST 2017 i686
> FSTESTVER: e2fsprogs	v1.43.6-85-g7595699d0 (Wed, 6 Sep 2017 22:04:14 -0400)
> FSTESTVER: fio		fio-3.2 (Fri, 3 Nov 2017 15:23:49 -0600)
> FSTESTVER: quota		4d81e8b (Mon, 16 Oct 2017 09:42:44 +0200)
> FSTESTVER: stress-ng	977ae35 (Wed, 6 Sep 2017 23:45:03 -0400)
> FSTESTVER: xfsprogs	v4.14.0-rc2-1-g19ca9b0b (Mon, 27 Nov 2017 10:56:21 -0600)
> FSTESTVER: xfstests-bld	0b27af9 (Tue, 28 Nov 2017 16:28:51 -0500)
> FSTESTVER: xfstests	linux-v3.8-1797-g4f1eaa02 (Tue, 28 Nov 2017 15:49:06 -0500)
> FSTESTCFG: "4k"
> FSTESTSET: "shared/298"
> FSTESTEXC: ""
> FSTESTOPT: "aex"
> MNTOPTS: ""
> CPUS: "2"
> MEM: "2008.27"
>                total        used        free      shared  buff/cache   available
> Mem:           2008          29        1926           8          51        1904
> Swap:             0           0           0
> BEGIN TEST 4k (1 test): Ext4 4k block Tue Dec  5 10:01:43 EST 2017
> DEVICE: /dev/vdd
> EXT_MKFS_OPTIONS: -b 4096
> EXT_MOUNT_OPTIONS: -o block_validity
> FSTYP         -- ext4
> PLATFORM      -- Linux/i686 kvm-xfstests 4.15.0-rc2-xfstests-00002-ge243560f12d7
> MKFS_OPTIONS  -- -b 4096 /dev/vdc
> MOUNT_OPTIONS -- -o acl,user_xattr -o block_validity /dev/vdc /vdc
> 
> shared/298 7s ...	[10:01:45][   11.697717] run fstests shared/298 at 2017-12-05 10:01:45
> [   15.151631] EXT4-fs (loop0): mounted filesystem with ordered data mode. Opts: (null)
> [   16.183394]
> [   16.184011] ======================================================
> [   16.186040] WARNING: possible circular locking dependency detected
> [   16.187693] 4.15.0-rc2-xfstests-00002-ge243560f12d7 #439 Not tainted
> [   16.189044] ------------------------------------------------------
> [   16.190198] ext4lazyinit/648 is trying to acquire lock:
> [   16.191201]  ((gendisk_completion)1 << part_shift(NUMA_NO_NODE)){+.+.}, at: [<8a1ebe9d>] wait_for_completion_io+0x12/0x20
> [   16.193226]
> [   16.193226] but task is already holding lock:
> [   16.194316]  (&meta_group_info[i]->alloc_sem){++++}, at: [<6495768c>] ext4_init_inode_table+0xb3/0x340
> [   16.196090]
> [   16.196090] which lock already depends on the new lock.
> [   16.196090]
> [   16.197603]
> [   16.197603] the existing dependency chain (in reverse order) is:
> [   16.198989]
> [   16.198989] -> #2 (&meta_group_info[i]->alloc_sem){++++}:
> [   16.200270]        lock_acquire+0x7d/0x1a0
> [   16.201067]        down_read+0x34/0x90
> [   16.201783]        __ext4_new_inode+0xcc2/0x14b0
> [   16.202853]        ext4_create+0x8f/0x170
> [   16.203613]        lookup_open+0x284/0x600
> [   16.204409]        path_openat+0x33a/0xa40
> [   16.205230]        do_filp_open+0x5e/0xb0
> [   16.205990]        do_sys_open+0x1a4/0x230
> [   16.206766]        SyS_open+0x1d/0x20
> [   16.207459]        do_fast_syscall_32+0x85/0x2d0
> [   16.208326]        entry_SYSENTER_32+0x4c/0x7b
> [   16.209161]
> [   16.209161] -> #1 (jbd2_handle){++++}:
> [   16.210142]        page_address+0x69/0xd0
> [   16.211048]        copy_page_to_iter+0x32/0x3e0
> [   16.212524]        generic_file_buffered_read+0x308/0x760
> [   16.214279]        generic_file_read_iter+0x15e/0x1f0
> [   16.215957]        ext4_file_read_iter+0x43/0xe0
> [   16.217478]
> [   16.217478] -> #0 ((gendisk_completion)1 << part_shift(NUMA_NO_NODE)){+.+.}:
> [   16.220266]        __lock_acquire+0x1235/0x1300
> [   16.221758]        lock_acquire+0x7d/0x1a0
> [   16.223102]        wait_for_common_io.constprop.0+0x3e/0x150
> [   16.224893]        wait_for_completion_io+0x12/0x20
> [   16.225793]        submit_bio_wait+0x6f/0x80
> [   16.226574]        blkdev_issue_zeroout+0xa6/0x1e0
> [   16.227445]        ext4_init_inode_table+0x173/0x340
> [   16.228347]        ext4_lazyinit_thread+0x263/0x320
> [   16.229233]        kthread+0x12e/0x150
> [   16.229919]        ret_from_fork+0x19/0x24
> [   16.230665]
> [   16.230665] other info that might help us debug this:
> [   16.230665]
> [   16.232104] Chain exists of:
> [   16.232104]   (gendisk_completion)1 << part_shift(NUMA_NO_NODE) --> jbd2_handle --> &meta_group_info[i]->alloc_sem
> [   16.232104]
> [   16.234726]  Possible unsafe locking scenario:
> [   16.234726]
> [   16.236617]        CPU0                    CPU1
> [   16.238109]        ----                    ----
> [   16.239598]   lock(&meta_group_info[i]->alloc_sem);
> [   16.241208]                                lock(jbd2_handle);
> [   16.243061]                                lock(&meta_group_info[i]->alloc_sem);
> [   16.245496]   lock((gendisk_completion)1 << part_shift(NUMA_NO_NODE));
> [   16.247642]
> [   16.247642]  *** DEADLOCK ***
> [   16.247642]
> [   16.249587] 4 locks held by ext4lazyinit/648:
> [   16.250970]  #0:  (&type->s_umount_key#26){++++}, at: [<8c13b129>] ext4_lazyinit_thread+0x6b/0x320
> [   16.252630]  #1:  (sb_writers#3){.+.+}, at: [<4cd23367>] ext4_lazyinit_thread+0x14f/0x320
> [   16.254109]  #2:  (jbd2_handle){++++}, at: [<327c6fca>] start_this_handle+0x303/0x790
> [   16.256235]  #3:  (&meta_group_info[i]->alloc_sem){++++}, at: [<6495768c>] ext4_init_inode_table+0xb3/0x340
> [   16.259407]
> [   16.259407] stack backtrace:
> [   16.260839] CPU: 0 PID: 648 Comm: ext4lazyinit Not tainted 4.15.0-rc2-xfstests-00002-ge243560f12d7 #439
> [   16.263789] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [   16.266438] Call Trace:
> [   16.267068]  dump_stack+0x7d/0xb2
> [   16.267685]  print_circular_bug+0x1d2/0x340
> [   16.268453]  check_prev_add+0x310/0x6b0
> [   16.269161]  ? kvm_sched_clock_read+0x1f/0x40
> [   16.269961]  ? sched_clock+0x9/0x10
> [   16.270607]  __lock_acquire+0x1235/0x1300
> [   16.271345]  ? copy_trace+0x90/0x90
> [   16.272131]  lock_acquire+0x7d/0x1a0
> [   16.273269]  ? wait_for_completion_io+0x12/0x20
> [   16.274777]  wait_for_common_io.constprop.0+0x3e/0x150
> [   16.276452]  ? wait_for_completion_io+0x12/0x20
> [   16.277933]  ? lockdep_init_map+0x12/0x20
> [   16.279246]  wait_for_completion_io+0x12/0x20
> [   16.280682]  submit_bio_wait+0x6f/0x80
> [   16.281910]  ? _cond_resched+0x17/0x30
> [   16.283150]  ? blkdev_issue_zeroout+0x91/0x1e0
> [   16.284576]  blkdev_issue_zeroout+0xa6/0x1e0
> [   16.285976]  ext4_init_inode_table+0x173/0x340
> [   16.287434]  ext4_lazyinit_thread+0x263/0x320
> [   16.288858]  kthread+0x12e/0x150
> [   16.289936]  ? ext4_unregister_li_request.isra.89+0x60/0x60
> [   16.291770]  ? __kthread_create_on_node+0x170/0x170
> [   16.293370]  ret_from_fork+0x19/0x24
>   [10:01:55] 10s
> [   21.970265] EXT4-fs (vdd): mounted filesystem with ordered data mode. Opts: acl,user_xattr,block_validity
> _check_dmesg: something found in dmesg (see /results/ext4/results-4k/shared/298.dmesg)
> Ran: shared/298
> Failures: shared/298
> Failed 1 of 1 tests
> Xunit report: /results/ext4/results-4k/result.xml
> 
> [   22.876380] runtests.sh (230): drop_caches: 3
>                total        used        free      shared  buff/cache   available
> Mem:           2008          35        1939           8          33        1899
> Swap:             0           0           0
> END TEST: Ext4 4k block Tue Dec  5 10:01:56 EST 2017
> 

-- 
Thanks,
Byungchul

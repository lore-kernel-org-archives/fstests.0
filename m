Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56784 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751285AbeEPISe (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 16 May 2018 04:18:34 -0400
Date: Wed, 16 May 2018 16:18:32 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH v2] xfs: test inode allocation state missmatch corruption
Message-ID: <20180516081832.GA4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
References: <20180511161127.15158-1-zlang@redhat.com>
 <20180511233239.GZ23861@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511233239.GZ23861@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, May 12, 2018 at 09:32:39AM +1000, Dave Chinner wrote:
> On Sat, May 12, 2018 at 12:11:27AM +0800, Zorro Lang wrote:
> > There's a situation where the directory structure and the inobt
> > thinks the inode is free, but the inode on disk thinks it is still
> > in use. XFS should detect it and prevent the kernel from oopsing
> > on lookup.
> 
> Isn't this testing the same thing that I recently posted "xfs: test
> inobt/on disk free state mismatches" for?

Hi Dave,

Last week I replied you that we wrote test case for same bug. But I just found
I can't reproduce any bugs on rhel-7.4 kernel and upstream 4.16 kernel by
your case [1], is there anything I misunderstood?

But the case which I wrote for this bug [3] can trigger failures [2]. Even
ignore that dmesg error (which I don't know if it's related with this bug),
it still can trigger an error. And this error can't be triggered after merged
your patch.

Thanks,
Zorro


[1]
# ./check xfs/132
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 ibm-x3650m4-10 4.16.7-200.fc27.x86_64
MKFS_OPTIONS  -- -f -bsize=4096 /dev/mapper/fedora-scratchdev
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/mapper/fedora-scratchdev /mnt/scratch

xfs/132  3s
Ran: xfs/132
Passed all 1 tests

# ./check xfs/132
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 ibm-x3550m3-05 3.10.0-862.el7.x86_64
MKFS_OPTIONS  -- -f -bsize=4096 /dev/sdb2
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sdb2 /mnt/scratch

xfs/132  2s
Ran: xfs/132
Passed all 1 tests

# ./check xfs/132
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 ibm-x3650m4-10 4.16.7-200.fc27.x86_64+debug
MKFS_OPTIONS  -- -f -bsize=4096 /dev/mapper/fedora-scratchdev
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/mapper/fedora-scratchdev /mnt/scratch

xfs/132 3s ... 3s
Ran: xfs/132
Passed all 1 tests

[2]
# ./check xfs/999                                          
FSTYP         -- xfs (non-debug)               
PLATFORM      -- Linux/x86_64 ibm-x3650m4-10 4.16.7-200.fc27.x86_64+debug                      
MKFS_OPTIONS  -- -f -bsize=4096 /dev/mapper/fedora-scratchdev                                  
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/mapper/fedora-scratchdev /mnt/scratch

xfs/999 4s ... - output mismatch (see /root/git/xfstests-zlang/results//xfs/999.out.bad)
    --- tests/xfs/999.out       2018-05-11 11:12:21.129590901 -0400
    +++ /root/git/xfstests-zlang/results//xfs/999.out.bad       2018-05-16 04:04:39.958393813 -0400
    @@ -1,2 +1,2 @@
     QA output created by 999
    -SCRATCH_MNT/dir/newfile: Structure needs cleaning
    +_check_dmesg: something found in dmesg (see /root/git/xfstests-zlang/results//xfs/999.dmesg)
    ...
    (Run 'diff -u tests/xfs/999.out /root/git/xfstests-zlang/results//xfs/999.out.bad'  to see the entire diff)

Ran: xfs/999                                   
Failures: xfs/999                              
Failed 1 of 1 tests

# dmesg
[ 1160.076247] ------------[ cut here ]------------
[ 1160.081403] kernel BUG at lib/list_debug.c:31!
[ 1160.086399] invalid opcode: 0000 [#1] SMP PTI
[ 1160.091274] Modules linked in: sunrpc intel_rapl sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel intel_cstate igb intel_uncore ptp iTCO_wdt iTCO_vendor_support pps_core intel_rapl_perf wmi tpm_tis ipmi_ssif tpm_tis_core cdc_ether usbnet mii tpm i2c_i801 ipmi_si ipmi_devintf lpc_ich ipmi_msghandler shpchp ioatdma dca xfs libcrc32c mgag200 i2c_algo_bit drm_kms_helper ttm drm crc32c_intel megaraid_sas
[ 1160.138576] CPU: 21 PID: 2746 Comm: xfs_io Not tainted 4.16.7-200.fc27.x86_64+debug #1
[ 1160.147412] Hardware name: IBM System x3650 M4 -[7915ON3]-/00J6520, BIOS -[VVE124AUS-1.30]- 11/21/2012
[ 1160.157809] RIP: 0010:__list_add_valid+0x61/0x70
[ 1160.162963] RSP: 0018:ffffb9a28709b970 EFLAGS: 00010282
[ 1160.168796] RAX: 0000000000000058 RBX: ffff8c6da4a7da30 RCX: 0000000000000000
[ 1160.176760] RDX: 0000000000000000 RSI: ffff8c6db71d6c48 RDI: ffff8c6db71d6c48
[ 1160.184723] RBP: ffff8c6db1fe3000 R08: 0000000000000001 R09: 0000000000000000
[ 1160.192687] R10: ffffb9a28709b8f0 R11: 0000000000000000 R12: ffff8c6da4a7dc10
[ 1160.200651] R13: ffff8c6da4a7dc10 R14: ffff8c6db1fe3a88 R15: ffff8c6daff70360
[ 1160.208616] FS:  00007f5911fad840(0000) GS:ffff8c6db7000000(0000) knlGS:0000000000000000
[ 1160.217646] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1160.224058] CR2: 0000564ff49e3290 CR3: 0000000467b92001 CR4: 00000000000606e0
[ 1160.232023] Call Trace:
[ 1160.234756]  inode_sb_list_add+0x47/0x80
[ 1160.239200]  xfs_setup_inode+0x28/0x160 [xfs]
[ 1160.244093]  xfs_ialloc+0x30d/0x520 [xfs]
[ 1160.248600]  xfs_dir_ialloc+0x74/0x240 [xfs]
[ 1160.253370]  ? __lock_is_held+0x59/0xa0
[ 1160.257680]  xfs_create+0x4ed/0x7e0 [xfs]
[ 1160.262188]  xfs_generic_create+0x21b/0x2e0 [xfs]
[ 1160.267442]  ? _raw_spin_unlock+0x24/0x30
[ 1160.271920]  lookup_open+0x5ad/0x750
[ 1160.275915]  ? __wake_up_common_lock+0x63/0xc0
[ 1160.280876]  ? find_held_lock+0x34/0xa0
[ 1160.285158]  path_openat+0x31a/0xc80
[ 1160.289151]  do_filp_open+0x9b/0x110
[ 1160.293145]  ? __alloc_fd+0xe5/0x1f0
[ 1160.297136]  ? _raw_spin_unlock+0x24/0x30
[ 1160.301615]  ? do_sys_open+0x1bd/0x250
[ 1160.305797]  do_sys_open+0x1bd/0x250
[ 1160.309791]  do_syscall_64+0x79/0x220
[ 1160.313878]  entry_SYSCALL_64_after_hwframe+0x42/0xb7
[ 1160.319517] RIP: 0033:0x7f5911b8d6de
[ 1160.323495] RSP: 002b:00007ffd812f97a0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
[ 1160.331947] RAX: ffffffffffffffda RBX: 0000000000000042 RCX: 00007f5911b8d6de
[ 1160.339903] RDX: 0000000000000042 RSI: 00007ffd812fb46e RDI: ffffffffffffff9c
[ 1160.347865] RBP: 0000000000000020 R08: 00007ffd812f99c0 R09: 0000000000000000
[ 1160.355829] R10: 0000000000000180 R11: 0000000000000246 R12: 00007ffd812fb46e
[ 1160.363793] R13: 0000000000000007 R14: 00007ffd812f9a00 R15: 0000000000000180
[ 1160.371762] Code: 0f 0b 48 89 c1 4c 89 c6 48 c7 c7 d0 ba 11 90 e8 e0 ad c4 ff 0f 0b 48 89 f2 4c 89 c1 48 89 fe 48 c7 c7 20 bb 11 90 e8 c9 ad c4 ff <0f> 0b 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 48 8b 07 48 b9 00 
[ 1160.392895] RIP: __list_add_valid+0x61/0x70 RSP: ffffb9a28709b970
[ 1160.399706] ---[ end trace df0b581bb7404c65 ]---
[ 1160.404867] BUG: sleeping function called from invalid context at ./include/linux/percpu-rwsem.h:34
[ 1160.414974] in_atomic(): 1, irqs_disabled(): 0, pid: 2746, name: xfs_io
[ 1160.422365] INFO: lockdep is turned off.
[ 1160.426753] CPU: 21 PID: 2746 Comm: xfs_io Tainted: G      D          4.16.7-200.fc27.x86_64+debug #1
[ 1160.437035] Hardware name: IBM System x3650 M4 -[7915ON3]-/00J6520, BIOS -[VVE124AUS-1.30]- 11/21/2012
[ 1160.447421] Call Trace:
[ 1160.450155]  dump_stack+0x85/0xbf
[ 1160.453857]  ___might_sleep+0x15b/0x240
[ 1160.458140]  exit_signals+0x30/0x240
[ 1160.462131]  do_exit+0xb8/0xd70
[ 1160.465640]  rewind_stack_do_exit+0x17/0x20
[ 1160.470324] note: xfs_io[2746] exited with preempt_count 1
[ 1160.654155] XFS (dm-3): Unmounting Filesystem

[3]
https://marc.info/?l=fstests&m=152605509711179&w=2

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com

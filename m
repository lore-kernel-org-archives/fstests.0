Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:23675 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751524AbeERD7m (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 17 May 2018 23:59:42 -0400
Date: Fri, 18 May 2018 13:59:39 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2] xfs: test inode allocation state missmatch corruption
Message-ID: <20180518035939.GI23861@dastard>
References: <20180511161127.15158-1-zlang@redhat.com>
 <20180511233239.GZ23861@dastard>
 <20180516081832.GA4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516081832.GA4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, May 16, 2018 at 04:18:32PM +0800, Zorro Lang wrote:
> On Sat, May 12, 2018 at 09:32:39AM +1000, Dave Chinner wrote:
> > On Sat, May 12, 2018 at 12:11:27AM +0800, Zorro Lang wrote:
> > > There's a situation where the directory structure and the inobt
> > > thinks the inode is free, but the inode on disk thinks it is still
> > > in use. XFS should detect it and prevent the kernel from oopsing
> > > on lookup.
> > 
> > Isn't this testing the same thing that I recently posted "xfs: test
> > inobt/on disk free state mismatches" for?
> 
> Hi Dave,
> 
> Last week I replied you that we wrote test case for same bug. But I just found
> I can't reproduce any bugs on rhel-7.4 kernel and upstream 4.16 kernel by
> your case [1], is there anything I misunderstood?
> 
> But the case which I wrote for this bug [3] can trigger failures [2]. Even
> ignore that dmesg error (which I don't know if it's related with this bug),
> it still can trigger an error. And this error can't be triggered after merged
> your patch.
> 
> Thanks,
> Zorro
> 
> 
> [1]
> # ./check xfs/132
> FSTYP         -- xfs (non-debug)
> PLATFORM      -- Linux/x86_64 ibm-x3650m4-10 4.16.7-200.fc27.x86_64
> MKFS_OPTIONS  -- -f -bsize=4096 /dev/mapper/fedora-scratchdev
> MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/mapper/fedora-scratchdev /mnt/scratch
> 
> xfs/132  3s
> Ran: xfs/132
> Passed all 1 tests

What did it dump in dmesg? It may be that the filesystem shut down
because of a cascading failure, but I never ran the test on
non-debug builds so I've got no idea what behaviour to expect there.
Whoever runs xfstests without debug being enabled?  :)

I may be that you need KASAN turned on to catch the failure - this
version of the test corrupts dentry cache memory and KASAN was
reliably catching that on unfixed kernels. Memory corruption may not
be immeidately visible on non-debug kernels - it's guaranteed to
kill the machine sooner or later, though.

> [2]
> # ./check xfs/999                                          
> FSTYP         -- xfs (non-debug)               
> PLATFORM      -- Linux/x86_64 ibm-x3650m4-10 4.16.7-200.fc27.x86_64+debug                      
> MKFS_OPTIONS  -- -f -bsize=4096 /dev/mapper/fedora-scratchdev                                  
> MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/mapper/fedora-scratchdev /mnt/scratch
> 
> xfs/999 4s ... - output mismatch (see /root/git/xfstests-zlang/results//xfs/999.out.bad)
>     --- tests/xfs/999.out       2018-05-11 11:12:21.129590901 -0400
>     +++ /root/git/xfstests-zlang/results//xfs/999.out.bad       2018-05-16 04:04:39.958393813 -0400
>     @@ -1,2 +1,2 @@
>      QA output created by 999
>     -SCRATCH_MNT/dir/newfile: Structure needs cleaning
>     +_check_dmesg: something found in dmesg (see /root/git/xfstests-zlang/results//xfs/999.dmesg)
>     ...
>     (Run 'diff -u tests/xfs/999.out /root/git/xfstests-zlang/results//xfs/999.out.bad'  to see the entire diff)
> 
> Ran: xfs/999                                   
> Failures: xfs/999                              
> Failed 1 of 1 tests
> 
> # dmesg
> [ 1160.076247] ------------[ cut here ]------------
> [ 1160.081403] kernel BUG at lib/list_debug.c:31!
> [ 1160.086399] invalid opcode: 0000 [#1] SMP PTI
> [ 1160.091274] Modules linked in: sunrpc intel_rapl sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel intel_cstate igb intel_uncore ptp iTCO_wdt iTCO_vendor_support pps_core intel_rapl_perf wmi tpm_tis ipmi_ssif tpm_tis_core cdc_ether usbnet mii tpm i2c_i801 ipmi_si ipmi_devintf lpc_ich ipmi_msghandler shpchp ioatdma dca xfs libcrc32c mgag200 i2c_algo_bit drm_kms_helper ttm drm crc32c_intel megaraid_sas
> [ 1160.138576] CPU: 21 PID: 2746 Comm: xfs_io Not tainted 4.16.7-200.fc27.x86_64+debug #1
> [ 1160.147412] Hardware name: IBM System x3650 M4 -[7915ON3]-/00J6520, BIOS -[VVE124AUS-1.30]- 11/21/2012
> [ 1160.157809] RIP: 0010:__list_add_valid+0x61/0x70
> [ 1160.162963] RSP: 0018:ffffb9a28709b970 EFLAGS: 00010282
> [ 1160.168796] RAX: 0000000000000058 RBX: ffff8c6da4a7da30 RCX: 0000000000000000
> [ 1160.176760] RDX: 0000000000000000 RSI: ffff8c6db71d6c48 RDI: ffff8c6db71d6c48
> [ 1160.184723] RBP: ffff8c6db1fe3000 R08: 0000000000000001 R09: 0000000000000000
> [ 1160.192687] R10: ffffb9a28709b8f0 R11: 0000000000000000 R12: ffff8c6da4a7dc10
> [ 1160.200651] R13: ffff8c6da4a7dc10 R14: ffff8c6db1fe3a88 R15: ffff8c6daff70360
> [ 1160.208616] FS:  00007f5911fad840(0000) GS:ffff8c6db7000000(0000) knlGS:0000000000000000
> [ 1160.217646] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1160.224058] CR2: 0000564ff49e3290 CR3: 0000000467b92001 CR4: 00000000000606e0
> [ 1160.232023] Call Trace:
> [ 1160.234756]  inode_sb_list_add+0x47/0x80
> [ 1160.239200]  xfs_setup_inode+0x28/0x160 [xfs]
> [ 1160.244093]  xfs_ialloc+0x30d/0x520 [xfs]
> [ 1160.248600]  xfs_dir_ialloc+0x74/0x240 [xfs]

So this has allocated an inode that is already cached in memory,
which is a different symptom of the same problem. 

i.e. there are two fixes for the problem. The initial cold-cache
test fixes were in commit ee457001ed6c ("xfs: catch inode allocation
state mismatch corruption"). The hot cache fixes were in
commit afca6c5b2595 ("xfs: validate cached inodes
are free when allocated"), and the commit message says:

	We recently fixed a similar inode allocation issue caused by
	inobt record corruption problem in xfs_iget_cache_miss() in
	commit ee457001ed6c ("xfs: catch inode allocation state
	mismatch corruption"). This change adds similar checks to
	the cache-hit path to catch it, and turns the reproducer
	into a corruption shutdown situation.

IOWs, the tests are exercising the same corruption, just through
different code paths. So it would seem that we need both tests...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

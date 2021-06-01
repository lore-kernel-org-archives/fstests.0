Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233F1C4708F
	for <linux-fstests@archiver.kernel.org>; Tue,  1 Jun 2021 16:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED839613BD
	for <linux-fstests@archiver.kernel.org>; Tue,  1 Jun 2021 16:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbhFAQ6A (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 1 Jun 2021 12:58:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:53128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232490AbhFAQ6A (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 1 Jun 2021 12:58:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 937A4610C9;
        Tue,  1 Jun 2021 16:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622566578;
        bh=yjUd4L5k8HJmpePEcwh5gD0xsx++zKhpIj3z7OKmXV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n0kdWtNbKgJbeno78J6odzq7kcaiD+4IlcVxvYJThC0VqwAMsQ1cb0WXbEn6p6M3N
         a420ccuUtbx4MVL6KwZJ0/gFIJldEW0vrKI/7EeR2rE/qaW3zLXMwu1syaG1ZpJoBd
         +rUdEjJRmvlKEvRyvqOImKGag+HVMhgcy+CwHHo5qRIBn9gnDxECaM4/hGGhrJ63lV
         CHo16Ae8giw4+HsI9GbfVHWL/Ebl3YkQBvvLdZSTJMJRfyZw/1+4AH4vE+lMEpzGO+
         985ozYOO3NkwuzO+UX8JeP0TyG4OoXF3vfoJM4JAsIvj30jTRzSHziAZfma7ZcU3nJ
         UXHE4pp1iCTog==
Date:   Tue, 1 Jun 2021 09:56:18 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     riteshh <riteshh@linux.ibm.com>
Cc:     fstest <fstests@vger.kernel.org>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>
Subject: Re: xfs_db causing OOM failures while running fstests on 64k
 blocksize
Message-ID: <20210601165618.GA26353@locust>
References: <20210601140059.d3juwiacnx3zyem7@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601140059.d3juwiacnx3zyem7@riteshh-domain>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jun 01, 2021 at 07:30:59PM +0530, riteshh wrote:
> Hello Darrick,
> 
> With 64K blocksize, we are running into this OOM failure invoked by xfs_db on
> our test machines. Due to this, internally many times we are unable to get a
> report of fstests for xfs on Power. This is quite easily seen with 64K blocksize.
> 
> I remember you were mentioning some solution around this in one of the call.
> Something that you may have some patches in your tree, but also that there could

Yeah, we last discussed this on-list in 2018:

https://lore.kernel.org/fstests/151803837117.19313.3481001926133028039.stgit@magnolia/

The patch has been stalled out ever since because I don't often have
time to run the full offline fuzz test suite to compare xfs_check and
xfs_repair to make sure that there are zero things that cause check to
complain while repair remains silent.  It would probably be a good idea
to compare scrub and repair too, but as scrub is still experimental I
don't consider it a blocking issue for disabling xfs_check.

IIRC I think I /did/ actually fix the last of the "check complains but
repair doesn't" bugs last summer, but I never got around to re-checking
after all the patches got merged.

If you want to do that, all you have to do is run the dangerous_repair
group tests with check/repair comparison:

# SCRATCH_XFS_FUZZ_CHECK=1 ./check -g dangerous_repair

Though you probably want a way to run each test individually in parallel
on a vm farm somewhere.

> be some more work required in this area to fix the issue.
> Sorry, I don't recollect our discussion completely. It was something around
> xfs_check and xfs_repair. Could you please help understand once again on why
> this issue? (even with quite high RAM size and small disk size)

xfs_check allocates a large amount of memory to track the state of each
block in the filesystem.  Individually.  See init() in db/check.c.

Repair tracks block state by extent, which is why it scales better
unless the fs is severely fragmented.

> And any known workaround for this?

Don't run xfs_check, or only run fstests with small disks.  (Both suck.)

> Also would you like some help with this work? Since it is anyway required for
> Power, so someone internally from our team can also start to work on this.

Yes please.

--D

> 
> 
> e.g. log
> generic/234		[12:08:15][ 5800.944162] run fstests generic/234 at 2021-04-24 12:08:15
> [ 5802.188921] XFS (vdd): Mounting V5 Filesystem
> [ 5802.280632] XFS (vdd): Ending clean mount
> [ 5802.337718] xfs filesystem being mounted at /vdd supports timestamps until 2038 (0x7fffffff)
> [ 5803.069534] XFS (vdc): Mounting V5 Filesystem
> [ 5803.121686] XFS (vdc): Ending clean mount
> [ 5803.123598] XFS (vdc): Quotacheck needed: Please wait.
> [ 5803.166977] XFS (vdc): Quotacheck: Done.
> [ 5803.170940] xfs filesystem being mounted at /vdc supports timestamps until 2038 (0x7fffffff)
> [ 5831.708588] XFS (vdc): Unmounting Filesystem
> [ 5832.530761] XFS (vdd): Unmounting Filesystem
> [ 5854.828260] xfs_db invoked oom-killer: gfp_mask=0x100cca(GFP_HIGHUSER_MOVABLE), order=0, oom_score_adj=-1000
> [ 5854.828717] CPU: 0 PID: 16727 Comm: xfs_db Not tainted 5.12.0-rc8-00043-g8db5efb83fa9 #20
> [ 5854.828868] Call Trace:
> [ 5854.828916] [c0000000204b7750] [c000000000c0ce88] dump_stack+0xec/0x144 (unreliable)
> [ 5854.829145] [c0000000204b7790] [c00000000042a054] dump_header+0x64/0x414
> [ 5854.829306] [c0000000204b7810] [c000000000427cb8] oom_kill_process+0x108/0x350
> [ 5854.829495] [c0000000204b7850] [c000000000429dd4] out_of_memory+0x874/0x9b0
> [ 5854.829647] [c0000000204b78f0] [c0000000004c95b8] __alloc_pages_slowpath.constprop.85+0xe98/0x11e0
> [ 5854.829852] [c0000000204b7ac0] [c0000000004c9c1c] __alloc_pages_nodemask+0x31c/0x500
> [ 5854.830029] [c0000000204b7b50] [c0000000004f77e4] alloc_pages_vma+0x2b4/0x320
> [ 5854.830209] [c0000000204b7bc0] [c0000000004913c4] __handle_mm_fault+0xb14/0x1790
> [ 5854.830389] [c0000000204b7ca0] [c000000000492390] handle_mm_fault+0x350/0x4c0
> [ 5854.830568] [c0000000204b7d00] [c00000000009c914] ___do_page_fault+0x9a4/0xd30
> [ 5854.830750] [c0000000204b7db0] [c00000000009ccd4] __do_page_fault+0x34/0x90
> [ 5854.830901] [c0000000204b7de0] [c0000000000a6268] do_hash_fault+0x48/0x90
> [ 5854.831053] [c0000000204b7e10] [c000000000008994] data_access_common_virt+0x194/0x1f0
> <...>
> [ 5854.833718] --- interrupt: 300
> [ 5854.833797] Mem-Info:
> [ 5854.833866] active_anon:15 inactive_anon:158676 isolated_anon:0
> [ 5854.833866]  active_file:14 inactive_file:0 isolated_file:0
> [ 5854.833866]  unevictable:0 dirty:0 writeback:0
> [ 5854.833866]  slab_reclaimable:741 slab_unreclaimable:1835
> [ 5854.833866]  mapped:101 shmem:493 pagetables:77 bounce:0
> [ 5854.833866]  free:174 free_pcp:2 free_cma:0
> [ 5854.834514] Node 0 active_anon:960kB inactive_anon:10155264kB active_file:896kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:6464kB dirty:0kB writeback:0kB shmem:31552kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:1280kB pagetables:4928kB all_unreclaimable? yes
> [ 5854.835088] Node 0 Normal free:11136kB min:12800kB low:23104kB high:33408kB reserved_highatomic:0KB active_anon:960kB inactive_anon:10155264kB active_file:896kB inactive_file:0kB unevictable:0kB writepending:0kB present:10485760kB managed:10399232kB mlocked:0kB bounce:0kB free_pcp:128kB local_pcp:128kB free_cma:0kB
> [ 5854.835641] lowmem_reserve[]: 0 0 0
> [ 5854.835787] Node 0 Normal: 94*64kB (UE) 24*128kB (U) 4*256kB (U) 2*512kB (U) 0*1024kB 0*2048kB 0*4096kB 0*8192kB 0*16384kB = 11136kB
> [ 5854.836091] 507 total pagecache pages
> [ 5854.836182] 0 pages in swap cache
> [ 5854.836273] Swap cache stats: add 0, delete 0, find 0/0
> [ 5854.836369] Free swap  = 0kB
> [ 5854.836463] Total swap = 0kB
> [ 5854.836554] 163840 pages RAM
> [ 5854.836645] 0 pages HighMem/MovableOnly
> [ 5854.836737] 1352 pages reserved
> [ 5854.836830] 0 pages cma reserved
> [ 5854.836923] 0 pages hwpoisoned
> [ 5854.837034] Tasks state (memory values in pages):
> [ 5854.837151] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name
> [ 5854.837355] [   1397]     0  1397      512      117    43008        0             0 systemd-journal
> [ 5854.837755] [   1406]     0  1406      122       26    38912        0             0 blkmapd
> [ 5854.837926] [   1606]     0  1606      337       47    40960        0         -1000 systemd-udevd
> [ 5854.838121] [   2496]   101  2496     1502       74    43008        0             0 systemd-timesyn
> [ 5854.838314] [   2498]   106  2498      176       48    38912        0             0 rpcbind
> [ 5854.838483] [   2503]   104  2503      167       47    38912        0          -900 dbus-daemon
> [ 5854.838676] [   2504]     0  2504      126       18    38912        0             0 kvm-xfstests.bo
> [ 5854.838869] [   2505]     0  2505      344       72    40960        0             0 systemd-logind
> [ 5854.839062] [   2537]     0  2537      190       63    38912        0             0 login
> [ 5854.839231] [   2538]     0  2538       60       10    38912        0             0 agetty
> [ 5854.839400] [   2540]     0  2540      190       63    38912        0             0 login
> [ 5854.839570] [   2541]     0  2541      190       63    38912        0             0 login
> [ 5854.839739] [   2613]     0  2613      132       22    38912        0             0 runtests.sh
> [ 5854.839934] [   3114]     0  3114      144       35    38912        0             0 bash
> [ 5854.840105] [   3115]     0  3115      144       35    38912        0             0 bash
> [ 5854.840274] [   3116]     0  3116      144       35    38912        0             0 bash
> [ 5854.840442] [  15152]     0 15152      182       75    38912        0         -1000 bash
> [ 5854.840610] [  16727]     0 16727   157168   157096  1294336        0         -1000 xfs_db
> 
> -ritesh

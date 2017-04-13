Received: from sandeen.net ([63.231.237.45]:56526 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750735AbdDMWth (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 13 Apr 2017 18:49:37 -0400
Received: from [10.0.0.4] (liberator [10.0.0.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 6E8B92A9B
        for <fstests@vger.kernel.org>; Thu, 13 Apr 2017 17:49:36 -0500 (CDT)
Subject: Re: [PATCH] xfs/288: test fragmented multi-fsb readdir
References: <ca07fe07-ac0a-a927-494f-34f7205e81d4@sandeen.net>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <2f107f35-ed81-a70a-0c56-8f57656f6a19@sandeen.net>
Date: Thu, 13 Apr 2017 17:49:36 -0500
MIME-Version: 1.0
In-Reply-To: <ca07fe07-ac0a-a927-494f-34f7205e81d4@sandeen.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On 4/13/17 3:28 PM, Eric Sandeen wrote:
> Test for the patch I just sent to the xfs list,
> xfs: handle array index overrun in xfs_dir2_leaf_readbuf()
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> the .out file is very big; We could probably live without
> it, since the test is just looking for a hang or a KASAN
> splat.


yes, KASAN finds it:

[  967.157394] ==================================================================
[  967.164844] BUG: KASAN: slab-out-of-bounds in xfs_dir2_leaf_readbuf+0x1fb0/0x22b0 [xfs] at addr ffff8800b9b1e538
[  967.175017] Read of size 8 by task find/13180
[  967.179405] CPU: 9 PID: 13180 Comm: find Tainted: G          IO    4.11.0-rc6+ #1
[  967.186887] Hardware name: Dell Inc. PowerEdge M710/0N583M, BIOS 3.0.0 01/31/2011
[  967.194368] Call Trace:
[  967.196830]  dump_stack+0xe3/0x191
[  967.200240]  ? _atomic_dec_and_lock+0x18f/0x18f
[  967.204780]  ? pm_qos_get_value.part.4+0x6/0x6
[  967.209292]  kasan_object_err+0x21/0x70
[  967.213190]  kasan_report+0x26f/0x520
[  967.216948]  ? xfs_dir2_leaf_readbuf+0x1fb0/0x22b0 [xfs]
[  967.222335]  __asan_report_load8_noabort+0x19/0x20
[  967.227272]  xfs_dir2_leaf_readbuf+0x1fb0/0x22b0 [xfs]
[  967.232621]  ? xfs_dir3_get_dtype+0x140/0x140 [xfs]
[  967.237623]  ? xfs_get_cowextsz_hint+0x130/0x130 [xfs]
[  967.242770]  ? kasan_kmalloc+0xad/0xe0
[  967.246706]  xfs_dir2_leaf_getdents+0x4c6/0x10a0 [xfs]
[  967.251964]  ? xfs_dir2_leaf_getdents+0x4c6/0x10a0 [xfs]
[  967.257289]  ? save_trace+0x350/0x350
[  967.261027]  ? __fsnotify_update_child_dentry_flags.part.2+0x260/0x260
[  967.267715]  ? xfs_dir2_leaf_readbuf+0x22b0/0x22b0 [xfs]
[  967.273181]  ? xfs_dir2_isblock+0xa0/0x340 [xfs]
[  967.277899]  ? xfs_dir2_grow_inode+0x890/0x890 [xfs]
[  967.283031]  xfs_readdir+0x3f4/0x880 [xfs]
[  967.287278]  ? xfs_dir2_block_getdents.isra.9+0x970/0x970 [xfs]
[  967.293284]  ? debug_lockdep_rcu_enabled+0x77/0x90
[  967.298192]  ? down_read+0xca/0x1b0
[  967.301714]  ? down_write_killable_nested+0x1b0/0x1b0
[  967.306931]  xfs_file_readdir+0x72/0xa0 [xfs]
[  967.311410]  iterate_dir+0x46d/0x670
[  967.315022]  SyS_getdents+0x1fc/0x400
[  967.318747]  ? SyS_old_readdir+0x230/0x230
[  967.322850]  ? fillonedir+0x260/0x260
[  967.326575]  ? trace_hardirqs_on_caller+0x38b/0x590
[  967.331470]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[  967.336158]  entry_SYSCALL_64_fastpath+0x1f/0xc2
[  967.340831] RIP: 0033:0x7efc1434df5b
[  967.344417] RSP: 002b:00007ffccf244920 EFLAGS: 00000202 ORIG_RAX: 000000000000004e
[  967.352053] RAX: ffffffffffffffda RBX: 000055e74cd8c550 RCX: 00007efc1434df5b
[  967.359184] RDX: 0000000000008000 RSI: 000055e74cd8c550 RDI: 0000000000000004
[  967.366316] RBP: 0000000000000046 R08: 000055e74cd8a960 R09: 0000000000000078
[  967.373449] R10: 0000000000000100 R11: 0000000000000202 R12: 0000000000000000
[  967.380583] R13: 0000000000008040 R14: 00007efc14649b38 R15: 0000000000002710
[  967.387716]  ? entry_SYSCALL_64_fastpath+0x1f/0xc2
[  967.392606] Object at ffff8800b9b1e300, in cache kmalloc-1024 size: 1024
[  967.399343] Allocated:
[  967.401709] PID = 13180
[  967.404164]  save_stack_trace+0x1b/0x20
[  967.408048]  save_stack+0x43/0xd0
[  967.411374]  kasan_kmalloc+0xad/0xe0
[  967.414998]  __kmalloc+0x14d/0x360
[  967.418498]  kmem_alloc+0x81/0x190 [xfs]
[  967.422567]  xfs_dir2_leaf_getdents+0x24a/0x10a0 [xfs]
[  967.427870]  xfs_readdir+0x3f4/0x880 [xfs]
[  967.432066]  xfs_file_readdir+0x72/0xa0 [xfs]
[  967.436490]  iterate_dir+0x46d/0x670
[  967.440070]  SyS_getdents+0x1fc/0x400
[  967.443743]  entry_SYSCALL_64_fastpath+0x1f/0xc2
[  967.448396] Freed:
[  967.450416] PID = 0
[  967.452565]  save_stack_trace+0x1b/0x20
[  967.456406]  save_stack+0x43/0xd0
[  967.459733]  kasan_slab_free+0x73/0xc0
[  967.463511]  kfree+0x109/0x300
[  967.466571]  free_request_size+0x4c/0x60
[  967.470498]  mempool_free+0xca/0x1b0
[  967.474128]  __blk_put_request+0x3a7/0x780
[  967.478229]  blk_finish_request+0x286/0x600
[  967.482475]  scsi_end_request+0x2c8/0x700
[  967.486495]  scsi_io_completion+0x83a/0x1c50
[  967.490796]  scsi_finish_command+0x5a2/0x8e0
[  967.495083]  scsi_softirq_done+0x348/0x480
[  967.499184]  blk_done_softirq+0x40f/0x6d0
[  967.503257]  __do_softirq+0x2e6/0xb5f
[  967.506927] Memory state around the buggy address:
[  967.511775]  ffff8800b9b1e400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  967.519003]  ffff8800b9b1e480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  967.526221] >ffff8800b9b1e500: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
[  967.533440]                                         ^
[  967.538493]  ffff8800b9b1e580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  967.545780]  ffff8800b9b1e600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  967.553084] ==================================================================
[  967.560305] Disabling lock debugging due to kernel taint

Received: from mx1.redhat.com ([209.132.183.28]:13034 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751384AbdJJOnP (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 10 Oct 2017 10:43:15 -0400
Reply-To: sandeen@redhat.com
Subject: Re: [lkp-robot] [fs] 332391a993:
 WARNING:at_fs/iomap.c:#iomap_dio_complete
References: <20171010121627.GD5445@yexl-desktop>
 <x49bmlf5au9.fsf@segfault.boston.devel.redhat.com>
From: Eric Sandeen <esandeen@redhat.com>
Message-ID: <d147de56-a36b-2ce3-202d-a8c1a6d28bd7@redhat.com>
Date: Tue, 10 Oct 2017 09:43:14 -0500
MIME-Version: 1.0
In-Reply-To: <x49bmlf5au9.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>, kernel test robot <xiaolong.ye@intel.com>
Cc: Lukas Czerner <lczerner@redhat.com>, Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, "Darrick J. Wong" <darrick.wong@oracle.com>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, lkp@01.org, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>



On 10/10/17 9:36 AM, Jeff Moyer wrote:
> kernel test robot <xiaolong.ye@intel.com> writes:
> 
>> FYI, we noticed the following commit (built with gcc-6):
>>
>> commit: 332391a9935da939319e473b4680e173df75afcf ("fs: Fix page cache
>> inconsistency when mixing buffered and AIO DIO")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [...]
> 
>> [  170.063040] WARNING: CPU: 0 PID: 33 at fs/iomap.c:731 iomap_dio_complete+0x129/0x130
>> [ 170.068758] Modules linked in: xfs dm_mod rpcsec_gss_krb5
>> auth_rpcgss nfsv4 dns_resolver sr_mod cdrom sg ata_generic pata_acpi
>> ppdev ata_piix parport_pc snd_pcm snd_timer snd soundcore serio_raw
>> pcspkr i2c_piix4 libata floppy parport ip_tables
>> [  170.074819] CPU: 0 PID: 33 Comm: kworker/0:1 Not tainted 4.14.0-rc1-00056-g332391a #1
>> [  170.077915] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
>> [  170.081047] Workqueue: dio/vda iomap_dio_complete_work
>> [  170.081974] task: ffff88012e504a80 task.stack: ffffc90000758000
>> [  170.084465] RIP: 0010:iomap_dio_complete+0x129/0x130
>> [  170.085381] RSP: 0018:ffffc9000075be18 EFLAGS: 00010286
>> [  170.087536] RAX: 00000000fffffff0 RBX: 0000000000000001 RCX: 000000000000000c
>> [  170.088853] RDX: 0000000000000000 RSI: ffffc9000075bc50 RDI: ffff880075715da9
>> [  170.092113] RBP: ffffc9000075be30 R08: ffffc9000075bcf0 R09: ffff880075715da8
>> [  170.093254] R10: 000000000000000c R11: 0000000000000000 R12: ffff88007afa9300
>> [  170.096475] R13: ffff88007ac7ad80 R14: ffff88007afa9338 R15: ffff88007afa9330
>> [  170.098187] FS:  0000000000000000(0000) GS:ffff88013fc00000(0000) knlGS:0000000000000000
>> [  170.101322] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  170.102265] CR2: 00007f3ad48a8020 CR3: 000000007fe16000 CR4: 00000000000006f0
>> [  170.104631] Call Trace:
>> [  170.105146]  iomap_dio_complete_work+0x25/0x80
>> [  170.106704]  process_one_work+0x198/0x3e0
>> [  170.107874]  worker_thread+0x4e/0x3e0
>> [  170.108522]  kthread+0x114/0x150
>> [  170.110683]  ? process_one_work+0x3e0/0x3e0
>> [  170.111362]  ? kthread_create_on_node+0x40/0x40
>> [  170.113111]  ret_from_fork+0x25/0x30
>> [ 170.113752] Code: c9 74 17 49 63 74 24 28 41 8b 54 24 24 85 f6 0f 84
>> 2a ff ff ff e9 3e ff ff ff 41 8b 74 24 28 49 8b 45 00 48 63 de e9 39
>> ff ff ff <0f> ff eb ca 0f 1f 00 0f 1f 44 00 00 55 48 83 ef 30 48 89 e5
>> 41
> 
> The test case is doing buffered and direct writes to the same file from
> different processes, and is intended to trigger the case where
> invalidate_inode_pages2_range fails.  I guess it's easier to hit now
> since we defer completion to a worker thread?  Anyway, we should update
> xfstests to ignore this warning.
> 
> Cheers,
> Jeff

I think this can be fixed in a similar manner to what generic/095 does:

# xfs generates WARNINGs on purpose when applications mix buffered/mmap IO with
# direct IO on the same file. On the other hand, this fio job has been proven
# to be potent, we don't want to simply _disable_dmesg_check which could miss
# other potential bugs. So filter out the intentional WARNINGs, make sure test
# doesn't fail because of this warning and fails on other WARNINGs.

# umount before checking dmesg in case umount triggers any WARNING or Oops
_scratch_unmount

if [ "$FSTYP" == "xfs" ]; then
        _check_dmesg _filter_xfs_dmesg
else
        _check_dmesg
fi

i.e. we can call _check_dmesg with a custom filter in generic/208 that ignores
this specific WARN_ON.

If _check_dmesg is run from the test itself, then the "generic" check_dmesg
from the test harness won't run and the test won't fail.

-Eric


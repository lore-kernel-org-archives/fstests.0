Return-Path: <SRS0=z/AK=4G=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F234C34026
	for <linux-fstests@archiver.kernel.org>; Tue, 18 Feb 2020 09:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EEF42070B
	for <linux-fstests@archiver.kernel.org>; Tue, 18 Feb 2020 09:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgBRJrD (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 18 Feb 2020 04:47:03 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:47988 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726225AbgBRJrD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 18 Feb 2020 04:47:03 -0500
X-IronPort-AV: E=Sophos;i="5.70,456,1574092800"; 
   d="txt'?scan'208";a="83491604"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 18 Feb 2020 17:46:58 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 1366350A9978;
        Tue, 18 Feb 2020 17:37:19 +0800 (CST)
Received: from [10.167.220.84] (10.167.220.84) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Tue, 18 Feb 2020 17:46:54 +0800
Subject: Re: generic/269 hangs on lastest upstream kernel
To:     Jan Kara <jack@suse.cz>
CC:     Theodore Ts'o <tytso@mit.edu>, fstests <fstests@vger.kernel.org>
References: <59a10449-9e0f-f289-2f9f-a2028fb0b3ca@cn.fujitsu.com>
 <20200212105433.GH25573@quack2.suse.cz>
 <00470e6d-0e1c-6060-225b-4c56dd33c083@cn.fujitsu.com>
 <20200213211011.GB6600@quack2.suse.cz>
 <062ac52c-3a16-22ef-6396-53334ed94783@cn.fujitsu.com>
 <20200214150059.GA22815@quack2.suse.cz>
 <a0b06474-f447-7943-1012-2a8d20b9e352@cn.fujitsu.com>
 <20200218082436.GF16121@quack2.suse.cz>
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Message-ID: <83cc6208-3fa3-86bb-eb91-77b90b22d98f@cn.fujitsu.com>
Date:   Tue, 18 Feb 2020 17:46:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20200218082436.GF16121@quack2.suse.cz>
Content-Type: multipart/mixed;
        boundary="------------C2E9089DF55D9370D0020685"
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: 1366350A9978.ABA4A
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

--------------C2E9089DF55D9370D0020685
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit


on 2020/02/18 16:24, Jan Kara wrote:
> On Tue 18-02-20 11:25:37, Yang Xu wrote:
>> on 2020/02/14 23:00, Jan Kara wrote:
>>> On Fri 14-02-20 18:24:50, Yang Xu wrote:
>>>> on 2020/02/14 5:10, Jan Kara wrote:
>>>>> On Thu 13-02-20 16:49:21, Yang Xu wrote:
>>>>>>>> When I test generic/269(ext4) on 5.6.0-rc1 kernel, it hangs.
>>>>>>>> ----------------------------------------------
>>>>>>>> dmesg as below:
>>>>>>>>        76.506753] run fstests generic/269 at 2020-02-11 05:53:44
>>>>>>>> [   76.955667] EXT4-fs (sdc): mounted filesystem with ordered data mode.
>>>>>>>> Opts: acl,                           user_xattr
>>>>>>>> [  100.912511] device virbr0-nic left promiscuous mode
>>>>>>>> [  100.912520] virbr0: port 1(virbr0-nic) entered disabled state
>>>>>>>> [  246.801561] INFO: task dd:17284 blocked for more than 122 seconds.
>>>>>>>> [  246.801564]       Not tainted 5.6.0-rc1 #41
>>>>>>>> [  246.801565] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
>>>>>>>> this mes                           sage.
>>>>>>>> [  246.801566] dd              D    0 17284  16931 0x00000080
>>>>>>>> [  246.801568] Call Trace:
>>>>>>>> [  246.801584]  ? __schedule+0x251/0x690
>>>>>>>> [  246.801586]  schedule+0x40/0xb0
>>>>>>>> [  246.801588]  wb_wait_for_completion+0x52/0x80
>>>>>>>> [  246.801591]  ? finish_wait+0x80/0x80
>>>>>>>> [  246.801592]  __writeback_inodes_sb_nr+0xaa/0xd0
>>>>>>>> [  246.801593]  try_to_writeback_inodes_sb+0x3c/0x50
>>>>>>>
>>>>>>> Interesting. Does the hang resolve eventually or the machine is hung
>>>>>>> permanently? If the hang is permanent, can you do:
>>>>>>>
>>>>>>> echo w >/proc/sysrq-trigger
>>>>>>>
>>>>>>> and send us the stacktraces from dmesg? Thanks!
>>>>>> Yes. the hang is permanent, log as below:
>>>> full dmesg as attach
>>> ...
>>>
>>> Thanks! So the culprit seems to be:
>>>
>>>> [  388.087799] kworker/u12:0   D    0    32      2 0x80004000
>>>> [  388.087803] Workqueue: writeback wb_workfn (flush-8:32)
>>>> [  388.087805] Call Trace:
>>>> [  388.087810]  ? __schedule+0x251/0x690
>>>> [  388.087811]  ? __switch_to_asm+0x34/0x70
>>>> [  388.087812]  ? __switch_to_asm+0x34/0x70
>>>> [  388.087814]  schedule+0x40/0xb0
>>>> [  388.087816]  schedule_timeout+0x20d/0x310
>>>> [  388.087818]  io_schedule_timeout+0x19/0x40
>>>> [  388.087819]  wait_for_completion_io+0x113/0x180
>>>> [  388.087822]  ? wake_up_q+0xa0/0xa0
>>>> [  388.087824]  submit_bio_wait+0x5b/0x80
>>>> [  388.087827]  blkdev_issue_flush+0x81/0xb0
>>>> [  388.087834]  jbd2_cleanup_journal_tail+0x80/0xa0 [jbd2]
>>>> [  388.087837]  jbd2_log_do_checkpoint+0xf4/0x3f0 [jbd2]
>>>> [  388.087840]  __jbd2_log_wait_for_space+0x66/0x190 [jbd2]
>>>> [  388.087843]  ? finish_wait+0x80/0x80
>>>> [  388.087845]  add_transaction_credits+0x27d/0x290 [jbd2]
>>>> [  388.087847]  ? blk_mq_make_request+0x289/0x5d0
>>>> [  388.087849]  start_this_handle+0x10a/0x510 [jbd2]
>>>> [  388.087851]  ? _cond_resched+0x15/0x30
>>>> [  388.087853]  jbd2__journal_start+0xea/0x1f0 [jbd2]
>>>> [  388.087869]  ? ext4_writepages+0x518/0xd90 [ext4]
>>>> [  388.087875]  __ext4_journal_start_sb+0x6e/0x130 [ext4]
>>>> [  388.087883]  ext4_writepages+0x518/0xd90 [ext4]
>>>> [  388.087886]  ? do_writepages+0x41/0xd0
>>>> [  388.087893]  ? ext4_mark_inode_dirty+0x1f0/0x1f0 [ext4]
>>>> [  388.087894]  do_writepages+0x41/0xd0
>>>> [  388.087896]  ? snprintf+0x49/0x60
>>>> [  388.087898]  __writeback_single_inode+0x3d/0x340
>>>> [  388.087899]  writeback_sb_inodes+0x1e5/0x480
>>>> [  388.087901]  wb_writeback+0xfb/0x2f0
>>>> [  388.087902]  wb_workfn+0xf0/0x430
>>>> [  388.087903]  ? __switch_to_asm+0x34/0x70
>>>> [  388.087905]  ? finish_task_switch+0x75/0x250
>>>> [  388.087907]  process_one_work+0x1a7/0x370
>>>> [  388.087909]  worker_thread+0x30/0x380
>>>> [  388.087911]  ? process_one_work+0x370/0x370
>>>> [  388.087912]  kthread+0x10c/0x130
>>>> [  388.087913]  ? kthread_park+0x80/0x80
>>>> [  388.087914]  ret_from_fork+0x35/0x40
>>>
>>> This process is actually waiting for IO to complete while holding
>>> checkpoint_mutex which holds up everybody else. The question is why the IO
>>> doesn't complete - that's definitely outside of filesystem. Maybe a bug in
>>> the block layer, storage driver, or something like that... What does
>>> 'cat /sys/block/<device-with-xfstests>/inflight' show?
>> Sorry for the late reply.
>> This value is 0, it represent it doesn't have inflight data(but it may be
>> counted bug or storage driver bug, is it right?).
>> Also, it doesn't hang on my physical machine, but only hang on vm.
> 
> Hum, curious. Just do make sure, did you check sdc (because that appears to
> be the stuck device)?
Yes, I check sdc, its value is 0.
# cat /sys/block/sdc/inflight
        0        0

> 
>> So what should I do in next step(change storge disk format)?
> 
> I'd try couple of things:
> 
> 1) If you mount ext4 with barrier=0 mount option, does the problem go away?
Yes. Use barrier=0, this case doesn't hang,
> 
> 2) Can you run the test and at the same time run 'blktrace -d /dev/sdc' to
> gather traces? Once the machine is stuck, abort blktrace, process the
> resulting files with 'blkparse -i sdc' and send here compressed blkparse
> output. We should be able to see what was happening with the stuck request
> in the trace and maybe that will tell us something.
The log size is too big(58M) and our emali limit is 5M.
> 
> 								Honza
> 



--------------C2E9089DF55D9370D0020685
Content-Type: text/plain; charset="UTF-8"; name="sdc_blktrace.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="sdc_blktrace.txt"


CPU0 (sdc):
 Reads Queued:       1,108,   27,116KiB  Writes Queued:      61,036,  285,888KiB
 Read Dispatches:    1,700,   25,392KiB  Write Dispatches:   14,740,  285,436KiB
 Reads Requeued:         0               Writes Requeued:         0
 Reads Completed:    1,765,   26,428KiB  Writes Completed:   15,209,  285,448KiB
 Read Merges:            1,       36KiB  Write Merges:       46,135,  185,436KiB
 Read depth:             1               Write depth:             1
 PC Reads Queued:        0,        0KiB  PC Writes Queued:        0,        0KiB
 PC Read Disp.:         16,        2KiB  PC Write Disp.:          0,        0KiB
 PC Reads Req.:          0               PC Writes Req.:          0
 PC Reads Compl.:       16               PC Writes Compl.:        0
 IO unplugs:         2,435               Timer unplugs:       7,863
CPU1 (sdc):
 Reads Queued:       1,005,   24,308KiB  Writes Queued:      61,020,  490,824KiB
 Read Dispatches:    1,767,   27,596KiB  Write Dispatches:   16,107,  439,560KiB
 Reads Requeued:         0               Writes Requeued:         0
 Reads Completed:    1,672,   24,104KiB  Writes Completed:   16,833,  489,500KiB
 Read Merges:            0,        0KiB  Write Merges:       44,537,  180,228KiB
 Read depth:             1               Write depth:             1
 PC Reads Queued:        0,        0KiB  PC Writes Queued:        0,        0KiB
 PC Read Disp.:         28,        3KiB  PC Write Disp.:          0,        0KiB
 PC Reads Req.:          0               PC Writes Req.:          0
 PC Reads Compl.:       28               PC Writes Compl.:        0
 IO unplugs:         2,268               Timer unplugs:       9,094
CPU2 (sdc):
 Reads Queued:       1,047,   25,337KiB  Writes Queued:      99,999,   21,409MiB
 Read Dispatches:    1,703,   24,013KiB  Write Dispatches:   14,016,   21,436MiB
 Reads Requeued:         0               Writes Requeued:         0
 Reads Completed:    1,760,   25,793KiB  Writes Completed:   14,664,   21,410MiB
 Read Merges:            1,        4KiB  Write Merges:       85,721,  343,812KiB
 Read depth:             1               Write depth:             1
 PC Reads Queued:        0,        0KiB  PC Writes Queued:        0,        0KiB
 PC Read Disp.:          1,        0KiB  PC Write Disp.:          0,        0KiB
 PC Reads Req.:          0               PC Writes Req.:          0
 PC Reads Compl.:        1               PC Writes Compl.:        0
 IO unplugs:         2,617               Timer unplugs:       7,643
CPU3 (sdc):
 Reads Queued:       1,090,   29,589KiB  Writes Queued:      57,152,  787,564KiB
 Read Dispatches:    1,728,   29,349KiB  Write Dispatches:   14,100,  812,204KiB
 Reads Requeued:         0               Writes Requeued:         0
 Reads Completed:    1,700,   30,025KiB  Writes Completed:   14,251,  788,148KiB
 Read Merges:            1,      372KiB  Write Merges:       43,240,  174,028KiB
 Read depth:             1               Write depth:             1
 IO unplugs:         2,461               Timer unplugs:       7,297

Total (sdc):
 Reads Queued:       4,250,  106,350KiB  Writes Queued:     279,207,   22,973MiB
 Read Dispatches:    6,898,  106,350KiB  Write Dispatches:   58,963,   22,973MiB
 Reads Requeued:         0               Writes Requeued:         0
 Reads Completed:    6,897,  106,350KiB  Writes Completed:   60,957,   22,973MiB
 Read Merges:            3,      412KiB  Write Merges:      219,633,  883,504KiB
 PC Reads Queued:        0,        0KiB  PC Writes Queued:        0,        0KiB
 PC Read Disp.:         45,        7KiB  PC Write Disp.:          0,        0KiB
 PC Reads Req.:          0               PC Writes Req.:          0
 PC Reads Compl.:       45               PC Writes Compl.:        0
 IO unplugs:         9,781               Timer unplugs:      31,897

Throughput (R/W): 414KiB/s / 89,548KiB/s
Events (sdc): 846,121 entries
Skips: 0 forward (0 -   0.0%)
Input file sdc.blktrace.0 added
Input file sdc.blktrace.1 added
Input file sdc.blktrace.2 added
Input file sdc.blktrace.3 added
--------------C2E9089DF55D9370D0020685--

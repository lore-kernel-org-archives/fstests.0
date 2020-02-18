Return-Path: <SRS0=z/AK=4G=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E956C34022
	for <linux-fstests@archiver.kernel.org>; Tue, 18 Feb 2020 03:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE2020836
	for <linux-fstests@archiver.kernel.org>; Tue, 18 Feb 2020 03:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgBRDZo (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 17 Feb 2020 22:25:44 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:29673 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726237AbgBRDZo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 17 Feb 2020 22:25:44 -0500
X-IronPort-AV: E=Sophos;i="5.70,455,1574092800"; 
   d="scan'208";a="83472648"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 18 Feb 2020 11:25:39 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id DBEFA406AB15;
        Tue, 18 Feb 2020 11:16:00 +0800 (CST)
Received: from [10.167.220.84] (10.167.220.84) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Tue, 18 Feb 2020 11:25:36 +0800
Subject: Re: generic/269 hangs on lastest upstream kernel
To:     Jan Kara <jack@suse.cz>
CC:     Theodore Ts'o <tytso@mit.edu>, fstests <fstests@vger.kernel.org>
References: <59a10449-9e0f-f289-2f9f-a2028fb0b3ca@cn.fujitsu.com>
 <20200212105433.GH25573@quack2.suse.cz>
 <00470e6d-0e1c-6060-225b-4c56dd33c083@cn.fujitsu.com>
 <20200213211011.GB6600@quack2.suse.cz>
 <062ac52c-3a16-22ef-6396-53334ed94783@cn.fujitsu.com>
 <20200214150059.GA22815@quack2.suse.cz>
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Message-ID: <a0b06474-f447-7943-1012-2a8d20b9e352@cn.fujitsu.com>
Date:   Tue, 18 Feb 2020 11:25:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20200214150059.GA22815@quack2.suse.cz>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: DBEFA406AB15.A0DAC
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



on 2020/02/14 23:00, Jan Kara wrote:
> On Fri 14-02-20 18:24:50, Yang Xu wrote:
>> on 2020/02/14 5:10, Jan Kara wrote:
>>> On Thu 13-02-20 16:49:21, Yang Xu wrote:
>>>>>> When I test generic/269(ext4) on 5.6.0-rc1 kernel, it hangs.
>>>>>> ----------------------------------------------
>>>>>> dmesg as below:
>>>>>>       76.506753] run fstests generic/269 at 2020-02-11 05:53:44
>>>>>> [   76.955667] EXT4-fs (sdc): mounted filesystem with ordered data mode.
>>>>>> Opts: acl,                           user_xattr
>>>>>> [  100.912511] device virbr0-nic left promiscuous mode
>>>>>> [  100.912520] virbr0: port 1(virbr0-nic) entered disabled state
>>>>>> [  246.801561] INFO: task dd:17284 blocked for more than 122 seconds.
>>>>>> [  246.801564]       Not tainted 5.6.0-rc1 #41
>>>>>> [  246.801565] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
>>>>>> this mes                           sage.
>>>>>> [  246.801566] dd              D    0 17284  16931 0x00000080
>>>>>> [  246.801568] Call Trace:
>>>>>> [  246.801584]  ? __schedule+0x251/0x690
>>>>>> [  246.801586]  schedule+0x40/0xb0
>>>>>> [  246.801588]  wb_wait_for_completion+0x52/0x80
>>>>>> [  246.801591]  ? finish_wait+0x80/0x80
>>>>>> [  246.801592]  __writeback_inodes_sb_nr+0xaa/0xd0
>>>>>> [  246.801593]  try_to_writeback_inodes_sb+0x3c/0x50
>>>>>
>>>>> Interesting. Does the hang resolve eventually or the machine is hung
>>>>> permanently? If the hang is permanent, can you do:
>>>>>
>>>>> echo w >/proc/sysrq-trigger
>>>>>
>>>>> and send us the stacktraces from dmesg? Thanks!
>>>> Yes. the hang is permanent, log as below:
>> full dmesg as attach
> ...
> 
> Thanks! So the culprit seems to be:
> 
>> [  388.087799] kworker/u12:0   D    0    32      2 0x80004000
>> [  388.087803] Workqueue: writeback wb_workfn (flush-8:32)
>> [  388.087805] Call Trace:
>> [  388.087810]  ? __schedule+0x251/0x690
>> [  388.087811]  ? __switch_to_asm+0x34/0x70
>> [  388.087812]  ? __switch_to_asm+0x34/0x70
>> [  388.087814]  schedule+0x40/0xb0
>> [  388.087816]  schedule_timeout+0x20d/0x310
>> [  388.087818]  io_schedule_timeout+0x19/0x40
>> [  388.087819]  wait_for_completion_io+0x113/0x180
>> [  388.087822]  ? wake_up_q+0xa0/0xa0
>> [  388.087824]  submit_bio_wait+0x5b/0x80
>> [  388.087827]  blkdev_issue_flush+0x81/0xb0
>> [  388.087834]  jbd2_cleanup_journal_tail+0x80/0xa0 [jbd2]
>> [  388.087837]  jbd2_log_do_checkpoint+0xf4/0x3f0 [jbd2]
>> [  388.087840]  __jbd2_log_wait_for_space+0x66/0x190 [jbd2]
>> [  388.087843]  ? finish_wait+0x80/0x80
>> [  388.087845]  add_transaction_credits+0x27d/0x290 [jbd2]
>> [  388.087847]  ? blk_mq_make_request+0x289/0x5d0
>> [  388.087849]  start_this_handle+0x10a/0x510 [jbd2]
>> [  388.087851]  ? _cond_resched+0x15/0x30
>> [  388.087853]  jbd2__journal_start+0xea/0x1f0 [jbd2]
>> [  388.087869]  ? ext4_writepages+0x518/0xd90 [ext4]
>> [  388.087875]  __ext4_journal_start_sb+0x6e/0x130 [ext4]
>> [  388.087883]  ext4_writepages+0x518/0xd90 [ext4]
>> [  388.087886]  ? do_writepages+0x41/0xd0
>> [  388.087893]  ? ext4_mark_inode_dirty+0x1f0/0x1f0 [ext4]
>> [  388.087894]  do_writepages+0x41/0xd0
>> [  388.087896]  ? snprintf+0x49/0x60
>> [  388.087898]  __writeback_single_inode+0x3d/0x340
>> [  388.087899]  writeback_sb_inodes+0x1e5/0x480
>> [  388.087901]  wb_writeback+0xfb/0x2f0
>> [  388.087902]  wb_workfn+0xf0/0x430
>> [  388.087903]  ? __switch_to_asm+0x34/0x70
>> [  388.087905]  ? finish_task_switch+0x75/0x250
>> [  388.087907]  process_one_work+0x1a7/0x370
>> [  388.087909]  worker_thread+0x30/0x380
>> [  388.087911]  ? process_one_work+0x370/0x370
>> [  388.087912]  kthread+0x10c/0x130
>> [  388.087913]  ? kthread_park+0x80/0x80
>> [  388.087914]  ret_from_fork+0x35/0x40
> 
> This process is actually waiting for IO to complete while holding
> checkpoint_mutex which holds up everybody else. The question is why the IO
> doesn't complete - that's definitely outside of filesystem. Maybe a bug in
> the block layer, storage driver, or something like that... What does
> 'cat /sys/block/<device-with-xfstests>/inflight' show?
Sorry for the late reply.
This value is 0, it represent it doesn't have inflight data(but it may 
be counted bug or storage driver bug, is it right?).
Also, it doesn't hang on my physical machine, but only hang on vm.
So what should I do in next step(change storge disk format)?

Best Regards
Yang Xu
> 
> 								Honza
> 



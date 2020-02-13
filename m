Return-Path: <SRS0=rSMp=4C=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF93EC2BA83
	for <linux-fstests@archiver.kernel.org>; Fri, 14 Feb 2020 09:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4D520873
	for <linux-fstests@archiver.kernel.org>; Fri, 14 Feb 2020 09:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbgBNJmK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 14 Feb 2020 04:42:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:46102 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728479AbgBNJmK (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 14 Feb 2020 04:42:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 007A9AFAE;
        Fri, 14 Feb 2020 09:42:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 54E471E0D46; Thu, 13 Feb 2020 22:10:11 +0100 (CET)
Date:   Thu, 13 Feb 2020 22:10:11 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc:     Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
        fstests <fstests@vger.kernel.org>
Subject: Re: generic/269 hangs on lastest upstream kernel
Message-ID: <20200213211011.GB6600@quack2.suse.cz>
References: <59a10449-9e0f-f289-2f9f-a2028fb0b3ca@cn.fujitsu.com>
 <20200212105433.GH25573@quack2.suse.cz>
 <00470e6d-0e1c-6060-225b-4c56dd33c083@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00470e6d-0e1c-6060-225b-4c56dd33c083@cn.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu 13-02-20 16:49:21, Yang Xu wrote:
> > > When I test generic/269(ext4) on 5.6.0-rc1 kernel, it hangs.
> > > ----------------------------------------------
> > > dmesg as below:
> > >     76.506753] run fstests generic/269 at 2020-02-11 05:53:44
> > > [   76.955667] EXT4-fs (sdc): mounted filesystem with ordered data mode.
> > > Opts: acl,                           user_xattr
> > > [  100.912511] device virbr0-nic left promiscuous mode
> > > [  100.912520] virbr0: port 1(virbr0-nic) entered disabled state
> > > [  246.801561] INFO: task dd:17284 blocked for more than 122 seconds.
> > > [  246.801564]       Not tainted 5.6.0-rc1 #41
> > > [  246.801565] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> > > this mes                           sage.
> > > [  246.801566] dd              D    0 17284  16931 0x00000080
> > > [  246.801568] Call Trace:
> > > [  246.801584]  ? __schedule+0x251/0x690
> > > [  246.801586]  schedule+0x40/0xb0
> > > [  246.801588]  wb_wait_for_completion+0x52/0x80
> > > [  246.801591]  ? finish_wait+0x80/0x80
> > > [  246.801592]  __writeback_inodes_sb_nr+0xaa/0xd0
> > > [  246.801593]  try_to_writeback_inodes_sb+0x3c/0x50
> > 
> > Interesting. Does the hang resolve eventually or the machine is hung
> > permanently? If the hang is permanent, can you do:
> > 
> > echo w >/proc/sysrq-trigger
> > 
> > and send us the stacktraces from dmesg? Thanks!
> Yes. the hang is permanent, log as below:
> 
> [  959.451423] fsstress        D    0 20094  20033 0x00000080
> [  959.451424] Call Trace:
> [  959.451425]  ? __schedule+0x251/0x690
> [  959.451426]  schedule+0x40/0xb0
> [  959.451428]  schedule_preempt_disabled+0xa/0x10
> [  959.451429]  __mutex_lock.isra.8+0x2b5/0x4a0
> [  959.451430]  ? __check_object_size+0x162/0x173
> [  959.451431]  lock_rename+0x28/0xb0
> [  959.451433]  do_renameat2+0x2a9/0x530
> [  959.451434]  __x64_sys_renameat2+0x20/0x30
> [  959.451436]  do_syscall_64+0x55/0x1b0
> [  959.451436]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> 
> [  959.453023] dd              D    0 21645  19793 0x00004080
> [  959.453024] Call Trace:
> [  959.453026]  ? __schedule+0x251/0x690
> [  959.453027]  ? __wake_up_common_lock+0x87/0xc0
> [  959.453028]  schedule+0x40/0xb0
> [  959.453030]  jbd2_log_wait_commit+0xac/0x120 [jbd2]
> [  959.453032]  ? finish_wait+0x80/0x80
> [  959.453034]  jbd2_log_do_checkpoint+0x383/0x3f0 [jbd2]
> [  959.453036]  __jbd2_log_wait_for_space+0x66/0x190 [jbd2]
> [  959.453038]  add_transaction_credits+0x27d/0x290 [jbd2]
> [  959.453040]  ? blk_mq_make_request+0x289/0x5d0
> [  959.453042]  start_this_handle+0x10a/0x510 [jbd2]
> [  959.453043]  ? _cond_resched+0x15/0x30
> [  959.453045]  jbd2__journal_start+0xea/0x1f0 [jbd2]
> [  959.453051]  ? ext4_writepages+0x518/0xd90 [ext4]
> [  959.453057]  __ext4_journal_start_sb+0x6e/0x130 [ext4]
> [  959.453063]  ext4_writepages+0x518/0xd90 [ext4]
> [  959.453065]  ? do_writepages+0x41/0xd0
> [  959.453070]  ? ext4_mark_inode_dirty+0x1f0/0x1f0 [ext4]
> [  959.453072]  do_writepages+0x41/0xd0
> [  959.453073]  ? iomap_write_begin+0x4c0/0x4c0
> [  959.453188]  ? xfs_iunlock+0xf3/0x100 [xfs]
> [  959.453189]  __filemap_fdatawrite_range+0xcb/0x100
> [  959.453191]  ? __raw_spin_unlock+0x5/0x10
> [  959.453198]  ext4_release_file+0x6c/0xa0 [ext4]
> [  959.453200]  __fput+0xbe/0x250
> [  959.453201]  task_work_run+0x84/0xa0
> [  959.453203]  exit_to_usermode_loop+0xc8/0xd0
> [  959.453204]  do_syscall_64+0x1a5/0x1b0
> [  959.453205]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  959.453206] RIP: 0033:0x7f368a22f1a8

Is that all that was in dmesg? I'd expect to see also other blocked
processes - in particular a jbd2 thread that should be doing transaction
commit and then also some process that's holding i_rwsem fsstress is
blocked on...

								Honza
> > > [  246.801609]  ext4_nonda_switch+0x7b/0x80 [ext4]
> > > [  246.801618]  ext4_da_write_begin+0x6f/0x480 [ext4]
> > > [  246.801621]  generic_perform_write+0xf4/0x1b0
> > > [  246.801628]  ext4_buffered_write_iter+0x8d/0x120 [ext4]
> > > [  246.801634]  ext4_file_write_iter+0x6e/0x700 [ext4]
> > > [  246.801636]  new_sync_write+0x12d/0x1d0
> > > [  246.801638]  vfs_write+0xa5/0x1a0
> > > [  246.801640]  ksys_write+0x59/0xd0
> > > [  246.801643]  do_syscall_64+0x55/0x1b0
> > > [  246.801645]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > [  246.801646] RIP: 0033:0x7fe9ec947b28
> > > [  246.801650] Code: Bad RIP value.
> > > ----------------------------------------------
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

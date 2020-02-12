Return-Path: <SRS0=afT8=4A=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E59C2BA83
	for <linux-fstests@archiver.kernel.org>; Wed, 12 Feb 2020 10:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA7DC2082F
	for <linux-fstests@archiver.kernel.org>; Wed, 12 Feb 2020 10:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbgBLKyg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 12 Feb 2020 05:54:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:35530 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbgBLKyg (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 12 Feb 2020 05:54:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 72669B326;
        Wed, 12 Feb 2020 10:54:34 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B2FF11E0E01; Wed, 12 Feb 2020 11:54:33 +0100 (CET)
Date:   Wed, 12 Feb 2020 11:54:33 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc:     Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
        fstests <fstests@vger.kernel.org>
Subject: Re: generic/269 hangs on lastest upstream kernel
Message-ID: <20200212105433.GH25573@quack2.suse.cz>
References: <59a10449-9e0f-f289-2f9f-a2028fb0b3ca@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59a10449-9e0f-f289-2f9f-a2028fb0b3ca@cn.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hello!

On Tue 11-02-20 16:14:35, Yang Xu wrote:
> Since xfstests support rename2, this case(generic/269) reports filesystem
> inconsistent problem with ext4 on my system(4.18.0-32.el8.x86_64).

I don't remember seeing this in my testing... It might be specific to that
RHEL kernel.

> When I test generic/269(ext4) on 5.6.0-rc1 kernel, it hangs.
> ----------------------------------------------
> dmesg as below:
>    76.506753] run fstests generic/269 at 2020-02-11 05:53:44
> [   76.955667] EXT4-fs (sdc): mounted filesystem with ordered data mode.
> Opts: acl,                           user_xattr
> [  100.912511] device virbr0-nic left promiscuous mode
> [  100.912520] virbr0: port 1(virbr0-nic) entered disabled state
> [  246.801561] INFO: task dd:17284 blocked for more than 122 seconds.
> [  246.801564]       Not tainted 5.6.0-rc1 #41
> [  246.801565] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> this mes                           sage.
> [  246.801566] dd              D    0 17284  16931 0x00000080
> [  246.801568] Call Trace:
> [  246.801584]  ? __schedule+0x251/0x690
> [  246.801586]  schedule+0x40/0xb0
> [  246.801588]  wb_wait_for_completion+0x52/0x80
> [  246.801591]  ? finish_wait+0x80/0x80
> [  246.801592]  __writeback_inodes_sb_nr+0xaa/0xd0
> [  246.801593]  try_to_writeback_inodes_sb+0x3c/0x50

Interesting. Does the hang resolve eventually or the machine is hung
permanently? If the hang is permanent, can you do:

echo w >/proc/sysrq-trigger

and send us the stacktraces from dmesg? Thanks!

								Honza

> [  246.801609]  ext4_nonda_switch+0x7b/0x80 [ext4]
> [  246.801618]  ext4_da_write_begin+0x6f/0x480 [ext4]
> [  246.801621]  generic_perform_write+0xf4/0x1b0
> [  246.801628]  ext4_buffered_write_iter+0x8d/0x120 [ext4]
> [  246.801634]  ext4_file_write_iter+0x6e/0x700 [ext4]
> [  246.801636]  new_sync_write+0x12d/0x1d0
> [  246.801638]  vfs_write+0xa5/0x1a0
> [  246.801640]  ksys_write+0x59/0xd0
> [  246.801643]  do_syscall_64+0x55/0x1b0
> [  246.801645]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  246.801646] RIP: 0033:0x7fe9ec947b28
> [  246.801650] Code: Bad RIP value.
> ----------------------------------------------
> 
> Does anyone also meet this problem?
> 
> Best Regards
> Yang Xu
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

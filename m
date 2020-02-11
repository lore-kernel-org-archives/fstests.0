Return-Path: <SRS0=vlFl=37=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03945C352A3
	for <linux-fstests@archiver.kernel.org>; Tue, 11 Feb 2020 08:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD30A20675
	for <linux-fstests@archiver.kernel.org>; Tue, 11 Feb 2020 08:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbgBKIOl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 11 Feb 2020 03:14:41 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:51356 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725787AbgBKIOl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 11 Feb 2020 03:14:41 -0500
X-IronPort-AV: E=Sophos;i="5.70,427,1574092800"; 
   d="scan'208";a="83148215"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Feb 2020 16:14:37 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 2BB1650A9963;
        Tue, 11 Feb 2020 16:05:06 +0800 (CST)
Received: from [10.167.220.84] (10.167.220.84) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Tue, 11 Feb 2020 16:14:35 +0800
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Subject: generic/269 hangs on lastest upstream kernel
To:     Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>
CC:     fstests <fstests@vger.kernel.org>
Message-ID: <59a10449-9e0f-f289-2f9f-a2028fb0b3ca@cn.fujitsu.com>
Date:   Tue, 11 Feb 2020 16:14:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: 2BB1650A9963.AA517
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi

Since xfstests support rename2, this case(generic/269) reports 
filesystem inconsistent problem with ext4 on my 
system(4.18.0-32.el8.x86_64).

When I test generic/269(ext4) on 5.6.0-rc1 kernel, it hangs.
----------------------------------------------
dmesg as below:
    76.506753] run fstests generic/269 at 2020-02-11 05:53:44
[   76.955667] EXT4-fs (sdc): mounted filesystem with ordered data mode. 
Opts: acl,                           user_xattr
[  100.912511] device virbr0-nic left promiscuous mode
[  100.912520] virbr0: port 1(virbr0-nic) entered disabled state
[  246.801561] INFO: task dd:17284 blocked for more than 122 seconds.
[  246.801564]       Not tainted 5.6.0-rc1 #41
[  246.801565] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this mes                           sage.
[  246.801566] dd              D    0 17284  16931 0x00000080
[  246.801568] Call Trace:
[  246.801584]  ? __schedule+0x251/0x690
[  246.801586]  schedule+0x40/0xb0
[  246.801588]  wb_wait_for_completion+0x52/0x80
[  246.801591]  ? finish_wait+0x80/0x80
[  246.801592]  __writeback_inodes_sb_nr+0xaa/0xd0
[  246.801593]  try_to_writeback_inodes_sb+0x3c/0x50
[  246.801609]  ext4_nonda_switch+0x7b/0x80 [ext4]
[  246.801618]  ext4_da_write_begin+0x6f/0x480 [ext4]
[  246.801621]  generic_perform_write+0xf4/0x1b0
[  246.801628]  ext4_buffered_write_iter+0x8d/0x120 [ext4]
[  246.801634]  ext4_file_write_iter+0x6e/0x700 [ext4]
[  246.801636]  new_sync_write+0x12d/0x1d0
[  246.801638]  vfs_write+0xa5/0x1a0
[  246.801640]  ksys_write+0x59/0xd0
[  246.801643]  do_syscall_64+0x55/0x1b0
[  246.801645]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  246.801646] RIP: 0033:0x7fe9ec947b28
[  246.801650] Code: Bad RIP value.
----------------------------------------------

Does anyone also meet this problem?

Best Regards
Yang Xu



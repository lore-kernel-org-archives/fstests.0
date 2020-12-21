Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E886C433DB
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Dec 2020 01:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AC0222D07
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Dec 2020 01:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgLUBC4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 20 Dec 2020 20:02:56 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:36942 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726142AbgLUBC4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 20 Dec 2020 20:02:56 -0500
X-IronPort-AV: E=Sophos;i="5.78,435,1599494400"; 
   d="scan'208";a="102760641"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 21 Dec 2020 09:02:07 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 73B7C4CE4BCB;
        Mon, 21 Dec 2020 09:02:04 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 21 Dec 2020 09:02:04 +0800
Message-ID: <5FDFF40A.7090702@cn.fujitsu.com>
Date:   Mon, 21 Dec 2020 09:02:02 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Eryu Guan <guaneryu@gmail.com>
CC:     <fstests@vger.kernel.org>
Subject: Re: [ANNOUNCE] fstests: master branch updated to 0ad1c034838d
References: <5fdf8221.1c69fb81.8c656.9b9d@mx.google.com>
In-Reply-To: <5fdf8221.1c69fb81.8c656.9b9d@mx.google.com>
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 73B7C4CE4BCB.AB6D1
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2020/12/21 0:55, Eryu Guan wrote:
> Hi all,
>
> The master branch of the xfstests repository at:
>
> 	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
>
> have just been updated. As usual, this update contains some new tests and
> various bug fixes and improvements.
>
> New btrfs tests btrfs/154 and btrfs/227 all currently fail with latest kernel.
> And xfs/513 has been updated to catch a xfs bug, but it should pass with latest
> kenrel.
>
> Also, unionmount tests has been improved to run with custom overlay mount
> options by assigning $OVERLAY_MOUNT_OPTIONS to UNIONMOUNT_MNTOPTIONS. You need
> to update your local unionmount tests to latest to contain commit 95be14e
> ("Allow user provided options with or without -o")
>
> Thanks,
> Eryu
>
> The new head of the master branch is commit:
>
> 0ad1c034838d overlay: run unionmount tests with custom overlay mount options
>
> New commits:
>
> Amir Goldstein (1):
>       [0ad1c034838d] overlay: run unionmount tests with custom overlay mount options
>
> Brian Foster (1):
>       [62cf7ce77f4f] generic/563: use a loop device to avoid partition incompatibility
>
> Eric Biggers (1):
>       [a225507009a3] generic: test for creating duplicate filenames in encrypted dir
>
> Feiyu Zhu (1):
>       [0c5013c565b7] src/t_enospc.c: Fix an error for the loop initialization declaration
>
> Filipe Manana (1):
>       [eabfcdfe9084] btrfs: test incremental send after removing a directory and all its files
>
> Kaixu Xia (1):
>       [c2dd12732f31] xfs/513: fix the regression caused by mount option uqnoenforce
>
> Nikolay Borisov (1):
>       [2a7406efecc2] btrfs: Update btrfs/215
>
> Ritesh Harjani (1):
>       [72dc169b442e] generic: Add test to check for mounting a huge sparse dm device
>
> Su Yue (1):
>       [a633d252e3c4] shared/032: add options for jffs2
>
> Xiao Yang (1):
>       [90d76997831e] src/multi_open_unlink: Stop using attr_set
Hi Eryu,

Only applying above patch broke the building of xfstests. :-)
See my explanation on the original patch set.

Best Regards,
Xiao Yang
> ethanwu (1):
>       [9f0744b16961] btrfs: test if rename handles dir item collision correctly
>
>
> Code Diffstat:
>
>  common/overlay                  |   8 ++
>  common/rc                       |  31 ++++++++
>  src/Makefile                    |   2 +-
>  src/btrfs_crc32c_forged_name.py |  91 ++++++++++++++++++++++
>  src/multi_open_unlink.c         |   8 +-
>  src/t_enospc.c                  |   8 +-
>  tests/btrfs/154                 |  64 ++++++++++++++++
>  tests/btrfs/154.out             |   2 +
>  tests/btrfs/215                 |  14 ++--
>  tests/btrfs/227                 | 122 +++++++++++++++++++++++++++++
>  tests/btrfs/227.out             |   6 ++
>  tests/btrfs/group               |   2 +
>  tests/generic/563               |  23 ++++--
>  tests/generic/620               |  62 +++++++++++++++
>  tests/generic/620.out           |   3 +
>  tests/generic/621               | 166 ++++++++++++++++++++++++++++++++++++++++
>  tests/generic/621.out           |  21 +++++
>  tests/generic/group             |   2 +
>  tests/shared/032                |   5 ++
>  tests/xfs/513                   |   4 +-
>  tests/xfs/513.out               |   4 +-
>  21 files changed, 621 insertions(+), 27 deletions(-)
> --
> Eryu Guan
> guaneryu@gmail.com




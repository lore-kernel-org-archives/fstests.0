Return-Path: <SRS0=Qh5O=EB=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3115FC2D0A3
	for <linux-fstests@archiver.kernel.org>; Mon, 26 Oct 2020 06:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E859F22247
	for <linux-fstests@archiver.kernel.org>; Mon, 26 Oct 2020 06:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1768370AbgJZGzR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 26 Oct 2020 02:55:17 -0400
Received: from out20-73.mail.aliyun.com ([115.124.20.73]:37397 "EHLO
        out20-73.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1768361AbgJZGzR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 26 Oct 2020 02:55:17 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07814372|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0118585-0.000592491-0.987549;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047206;MF=guan@eryu.me;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.IoUJyXB_1603695314;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.IoUJyXB_1603695314)
          by smtp.aliyun-inc.com(10.147.41.121);
          Mon, 26 Oct 2020 14:55:14 +0800
Date:   Mon, 26 Oct 2020 14:55:13 +0800
From:   Eryu Guan <guan@eryu.me>
To:     fstests@vger.kernel.org
Subject: Re: [ANNOUNCE] fstests: master branch updated to 31f6949f385a
Message-ID: <20201026065513.GC3853@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

[Seems this ANNOUNCE didn't hit the list, quote it and send again]

On Sun, Oct 25, 2020 at 07:02:50PM +0800, Eryu Guan wrote:
> Hi all,
> 
> The master branch of the xfstests repository at:
> 
> 	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> 
> have just been updated. This is a normal new test & bug fix update. There're
> two new btrfs tests and one ext4 test, and they should all pass with latest
> 5.9.0+ kernel. The rest of the update is random fixes, the only user-visible
> change is that btrfs now supports setting BTRFS_MKFS_OPTIONS as well to define
> the btrfs mkfs options.
> 
> Thanks,
> Eryu
> 
> The new head of the master branch is commit:
> 
> 31f6949f385a ext4: verify unwritten extent conversion in buff-io
> 
> New commits:
> 
> Anand Jain (2):
>       [0cea5f97ef18] btrfs: add a test case for btrfs seed device delete
>       [4504deda8ba7] btrfs/163: replace sprout instead of seed
> 
> Filipe Manana (2):
>       [2eb35a8594dc] check: fix misspelled variable name for sections
>       [a7fdd2e1b1dc] btrfs: add test case for rwf_nowait writes
> 
> Goldwyn Rodrigues (1):
>       [da60e675f641] common/config: Allow environment defined btrfs mkfs options
> 
> Matthew Wilcox (1):
>       [2f65e8db375e] generic/127: to exit if any subtest fails
> 
> Murphy Zhou (1):
>       [85a3354edab0] overlay/073: test with nfs_export being off
> 
> Ritesh Harjani (1):
>       [31f6949f385a] ext4: verify unwritten extent conversion in buff-io
> 
> Yang Xu (1):
>       [e944dd5b9df6] generic/402: Drop useless fail message
> 
> 
> Code Diffstat:
> 
>  check               |   4 +-
>  common/config       |   3 ++
>  tests/btrfs/163     |  25 +++++++---
>  tests/btrfs/163.out |   5 +-
>  tests/btrfs/225     |  82 ++++++++++++++++++++++++++++++
>  tests/btrfs/225.out |  15 ++++++
>  tests/btrfs/226     | 140 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/226.out |  70 ++++++++++++++++++++++++++
>  tests/btrfs/group   |   2 +
>  tests/ext4/046      |  84 +++++++++++++++++++++++++++++++
>  tests/ext4/046.out  |   2 +
>  tests/ext4/group    |   1 +
>  tests/generic/127   |  12 ++---
>  tests/generic/402   |   2 +-
>  tests/overlay/073   |   4 +-
>  15 files changed, 433 insertions(+), 18 deletions(-)
> --
> Eryu Guan
> guan@eryu.me



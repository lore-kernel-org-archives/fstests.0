Return-Path: <SRS0=gT4C=CJ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A8EC433E2
	for <linux-fstests@archiver.kernel.org>; Mon, 31 Aug 2020 01:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C72A420CC7
	for <linux-fstests@archiver.kernel.org>; Mon, 31 Aug 2020 01:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgHaBGv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 30 Aug 2020 21:06:51 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:30423 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726477AbgHaBGv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 30 Aug 2020 21:06:51 -0400
X-IronPort-AV: E=Sophos;i="5.76,373,1592841600"; 
   d="scan'208";a="98714446"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 31 Aug 2020 09:06:46 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 3206548990DC;
        Mon, 31 Aug 2020 09:06:44 +0800 (CST)
Received: from [10.167.220.84] (10.167.220.84) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 31 Aug 2020 09:06:48 +0800
Subject: Re: [ANNOUNCE] fstests: master branch updated to cfea24abcf9a
To:     Eryu Guan <guaneryu@gmail.com>, <fstests@vger.kernel.org>
References: <5f4bd45c.1c69fb81.f3fe2.2df1@mx.google.com>
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Message-ID: <a6d6a3aa-41ae-179f-32a2-528723f74a85@cn.fujitsu.com>
Date:   Mon, 31 Aug 2020 09:06:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <5f4bd45c.1c69fb81.f3fe2.2df1@mx.google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: 3206548990DC.AA57D
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Eryu

I guess this update still missed "xfs/010,030: filter AG header CRC 
error warnings" patch from Darrick.

Best Regards
Yang Xu
> Hi all,
> 
> The master branch of the xfstests repository at:
> 
> 	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> 
> have just been updated. This update mainly contains btrfs new test and fixes.
> And you may see the new btrfs/218 test fail with latest v5.9-rc2 kernel.
> 
> Thanks,
> Eryu
> 
> The new head of the master branch is commit:
> 
> cfea24abcf9a generic/574: fix sporadic failure with test_dummy_encryption
> 
> New commits:
> 
> Eric Biggers (1):
>        [cfea24abcf9a] generic/574: fix sporadic failure with test_dummy_encryption
> 
> Josef Bacik (1):
>        [25824c270360] btrfs: add a test for btrfs seed device stats
> 
> Nikolay Borisov (3):
>        [7b82ef0ff757] btrfs/024: Remove no longer valid test
>        [473d0e1740ca] btrfs/205: Ignore output of chattr command
>        [b9d1dcd13516] common/config: Allow sections names to contain hyphen
> 
> 
> Code Diffstat:
> 
>   common/config         |  2 +-
>   tests/btrfs/024       |  7 -----
>   tests/btrfs/024.out   |  3 ---
>   tests/btrfs/205       |  2 +-
>   tests/btrfs/218       | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/218.out   | 25 ++++++++++++++++++
>   tests/btrfs/group     |  1 +
>   tests/generic/574     | 11 +++++---
>   tests/generic/574.out |  6 ++---
>   9 files changed, 112 insertions(+), 18 deletions(-)
> --
> Eryu Guan
> guaneryu@gmail.com
> 



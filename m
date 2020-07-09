Return-Path: <SRS0=vVM5=AU=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AA7C433E0
	for <linux-fstests@archiver.kernel.org>; Thu,  9 Jul 2020 09:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DCE420708
	for <linux-fstests@archiver.kernel.org>; Thu,  9 Jul 2020 09:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbgGIJ7H (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 9 Jul 2020 05:59:07 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:39815 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726506AbgGIJ7G (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 9 Jul 2020 05:59:06 -0400
X-IronPort-AV: E=Sophos;i="5.75,331,1589212800"; 
   d="scan'208";a="95982794"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 09 Jul 2020 17:59:03 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id CB93A4CE505B;
        Thu,  9 Jul 2020 17:59:01 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 9 Jul 2020 17:59:01 +0800
Message-ID: <5F06EA64.8060006@cn.fujitsu.com>
Date:   Thu, 9 Jul 2020 17:59:00 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
CC:     <fstests@vger.kernel.org>, <darrick.wong@oracle.com>,
        <ira.weiny@intel.com>
Subject: Re: [PATCH v5 0/8] Make fstests support new behavior of DAX
References: <20200709094846.13872-1-yangx.jy@cn.fujitsu.com>
In-Reply-To: <20200709094846.13872-1-yangx.jy@cn.fujitsu.com>
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: CB93A4CE505B.AC51A
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi,

Sorry, please ignore this one. :-(

Thanks,
Xiao Yang
On 2020/7/9 17:48, Xiao Yang wrote:
> The new behavior of DAX on xfs/ext4 has been merged into main kernel
> tree/ext4-dax branch so it is time for fstests to support new behavior
> of DAX.
>
> 1) Refactor common functions and take use of them.
> 2) Move and update xfs/260.
> 3) Add two new tests to verify some features.
>
> References:
> https://lkml.org/lkml/2019/10/20/96
> https://lkml.org/lkml/2020/5/28/949
>
> Xiao Yang (8):
>   common/rc: Introduce new helpers for DAX mount options and
>     FS_XFLAG_DAX
>   fstests: Use _require_scratch_dax_mountopt() and _require_dax_iflag()
>   common/rc: Remove unused _require_scratch_dax()
>   generic/223: Don't clear all mkfs options for _scratch_mkfs_geom()
>     roughly
>   generic/413, xfs/260: Improve format operation for PMD fault testing
>   xfs/260: Move and update xfs/260
>   generic: Verify if statx() can qurey S_DAX flag on regular file
>     correctly
>   generic: Verify the inheritance behavior of FS_XFLAG_DAX flag in
>     various combinations
>
>  common/rc                      |  60 ++++++++--
>  tests/ext4/030                 |   2 +-
>  tests/ext4/031                 |   4 +-
>  tests/generic/223              |   1 -
>  tests/generic/413              |  12 +-
>  tests/generic/462              |   2 +-
>  tests/{xfs/260 => generic/603} |  74 ++++++------
>  tests/generic/603.out          |   2 +
>  tests/generic/604              | 100 +++++++++++++++++
>  tests/generic/604.out          |   2 +
>  tests/generic/605              | 199 +++++++++++++++++++++++++++++++++
>  tests/generic/605.out          |   2 +
>  tests/generic/group            |   3 +
>  tests/xfs/260.out              |   2 -
>  tests/xfs/group                |   1 -
>  15 files changed, 403 insertions(+), 63 deletions(-)
>  rename tests/{xfs/260 => generic/603} (53%)
>  create mode 100644 tests/generic/603.out
>  create mode 100644 tests/generic/604
>  create mode 100644 tests/generic/604.out
>  create mode 100644 tests/generic/605
>  create mode 100644 tests/generic/605.out
>  delete mode 100644 tests/xfs/260.out
>




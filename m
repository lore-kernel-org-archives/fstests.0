Return-Path: <SRS0=Jk7F=BU=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B2BC433E0
	for <linux-fstests@archiver.kernel.org>; Mon, 10 Aug 2020 11:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE56B206C3
	for <linux-fstests@archiver.kernel.org>; Mon, 10 Aug 2020 11:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgHJLNR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 10 Aug 2020 07:13:17 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:41296 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726422AbgHJLNM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 10 Aug 2020 07:13:12 -0400
X-IronPort-AV: E=Sophos;i="5.75,457,1589212800"; 
   d="scan'208";a="97935662"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 10 Aug 2020 19:12:09 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 822014CE34F1;
        Mon, 10 Aug 2020 19:12:06 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 10 Aug 2020 19:12:07 +0800
Message-ID: <5F312B85.5040002@cn.fujitsu.com>
Date:   Mon, 10 Aug 2020 19:12:05 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Eryu Guan <guaneryu@gmail.com>
CC:     <fstests@vger.kernel.org>
Subject: Re: [ANNOUNCE] fstests: master branch updated to 59d1f998fd61
References: <5f3030bc.1c69fb81.7519b.378d@mx.google.com>
In-Reply-To: <5f3030bc.1c69fb81.7519b.378d@mx.google.com>
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 822014CE34F1.A93A6
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2020/8/10 1:21, Eryu Guan wrote:
> Hi all,
>
> The master branch of the xfstests repository at:
>
> 	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
>
> have just been updated. The most notable change is the DAX patchset from Xiao
> Yang, which update & add new tests to test the new DAX mount behavior. Many
> thanks to Xiao Yang for the patchset, and to Ira Weiny and Darrick J. Wong for
> reviewing the patches!
Hi Eryu,

Thank you for applying my patch set. :-)
In addition, I also updated some helpers related to new dax option by
another
separate patch set[1] and hope you can apply it in next update.
[1]:
https://www.spinics.net/lists/fstests/msg14360.html
https://www.spinics.net/lists/fstests/msg14359.html
P.S. The patch set has been reviewed by Ira Weiny.

Best Regards,
Xiao Yang
> There're also some xfs quota related fixes to work with the new kernel &
> xfsprogs behaviors on XFS.
>
> And the new btrfs and ext4 tests currently fail on latest v5.8 kernel.
>
> Thanks,
> Eryu
>
> The new head of the master branch is commit:
>
> 59d1f998fd61 generic: Verify how to change the S_DAX flag on an existing file
>
> New commits:
>
> Bill O'Donnell (2):
>       [7cee3f17280c] xfs/518: modify timer/state commands to remove new g,p timer output
>       [569789e54eb0] xfs/263: filters to accommodate new xfs_quota state command and prevent regression
>
> Darrick J. Wong (4):
>       [fc80a4954604] generic/603: don't run on XFS v4 filesystems
>       [2b3de458c433] xfs/030: repair should actually find the zeroed block pointer in the agfl
>       [9515832478a1] xfs/{263,106}: erase max warnings printout
>       [e5bbd47e7c17] xfs/{050,299}: clear quota warnings in between checks
>
> Jeff Layton (2):
>       [760616041b67] generic/377: filter out xattrs that don't start with 'user.'
>       [85c3ee84f07b] generic/062: use more restrictive filter when querying for attributes
>
> Lukas Czerner (1):
>       [3c9b1fe59ebd] ext4: Test read-only external journal device
>
> Qu Wenruo (1):
>       [912521c9fa1a] btrfs: Add test to check if shrink works well with fstrim
>
> Xiao Yang (9):
>       [f4a1c15b58de] generic/452: Fix the wrong commit id
>       [c1a28a6e3a94] common/rc: Introduce helpers for new dax mount options and FS_XFLAG_DAX
>       [49ba983a76a6] fstests: Use _require_scratch_dax_mountopt() and _require_dax_iflag()
>       [2aaaef91f305] generic/223: Don't clear MKFS_OPTION before calling _scratch_mkfs_geom()
>       [ab0680e58176] generic/413, xfs/260: Improve format operation for PMD fault testing
>       [f85344a72f74] xfs/260: Move and update xfs/260
>       [efb26477fd3c] generic: Verify if statx() can qurey S_DAX flag on regular file correctly
>       [76cfca6472ad] generic: Verify the inheritance behavior of FS_XFLAG_DAX flag in various combinations
>       [59d1f998fd61] generic: Verify how to change the S_DAX flag on an existing file
>
>
> Code Diffstat:
>
>  common/rc                      | 105 ++++++++++++++++++++---
>  tests/btrfs/217                |  62 ++++++++++++++
>  tests/btrfs/217.out            |   2 +
>  tests/btrfs/group              |   1 +
>  tests/ext4/002                 | 139 ++++++++++++++++++++++++++++++
>  tests/ext4/002.out             |  32 +++++++
>  tests/ext4/030                 |   2 +-
>  tests/ext4/031                 |   4 +-
>  tests/ext4/group               |   1 +
>  tests/generic/062              |  10 ++-
>  tests/generic/223              |   1 -
>  tests/generic/377              |   4 +-
>  tests/generic/413              |  12 +--
>  tests/generic/452              |   2 +-
>  tests/generic/462              |   2 +-
>  tests/generic/603              |   4 +
>  tests/{xfs/260 => generic/605} |  79 +++++++++--------
>  tests/generic/605.out          |   2 +
>  tests/generic/606              |  92 ++++++++++++++++++++
>  tests/generic/606.out          |   2 +
>  tests/generic/607              | 189 +++++++++++++++++++++++++++++++++++++++++
>  tests/generic/607.out          |   2 +
>  tests/generic/608              | 121 ++++++++++++++++++++++++++
>  tests/generic/608.out          |   2 +
>  tests/generic/group            |   4 +
>  tests/xfs/030.out              |   1 +
>  tests/xfs/050                  |  23 +++--
>  tests/xfs/106                  |   3 +-
>  tests/xfs/260.out              |   2 -
>  tests/xfs/263                  |  21 ++++-
>  tests/xfs/299                  |  23 +++--
>  tests/xfs/518                  |   8 +-
>  tests/xfs/group                |   1 -
>  33 files changed, 867 insertions(+), 91 deletions(-)
> --
> Eryu Guan
> guaneryu@gmail.com




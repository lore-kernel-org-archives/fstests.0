Return-Path: <SRS0=82tC=BR=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BF4C433DF
	for <linux-fstests@archiver.kernel.org>; Fri,  7 Aug 2020 18:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30DAA2075D
	for <linux-fstests@archiver.kernel.org>; Fri,  7 Aug 2020 18:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgHGSOl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 7 Aug 2020 14:14:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:36759 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbgHGSOk (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 7 Aug 2020 14:14:40 -0400
IronPort-SDR: 2QBoppFd2AynJn0Zkb9758LN1Ifhux4mjNPCECeSM2d4rEmORIqGK/ZxArOp1B+yuzMCnpY0Io
 im8icaxlfdcA==
X-IronPort-AV: E=McAfee;i="6000,8403,9706"; a="132718666"
X-IronPort-AV: E=Sophos;i="5.75,446,1589266800"; 
   d="scan'208";a="132718666"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2020 11:14:39 -0700
IronPort-SDR: kNurkBv/PwxLPBMwHjo8C8WXoKWFZ13agH0QCNH7QnTzcVON++Q7bzrohwUsXbf/dlVLV837pQ
 lWiRZZq2Ov6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,446,1589266800"; 
   d="scan'208";a="316621282"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga004.fm.intel.com with ESMTP; 07 Aug 2020 11:14:39 -0700
Date:   Fri, 7 Aug 2020 11:14:39 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     fstests@vger.kernel.org, darrick.wong@oracle.com,
        guaneryu@gmail.com
Subject: Re: [PATCH v9 0/8] Make fstests support new behavior of DAX
Message-ID: <20200807181438.GB2467625@iweiny-DESK2.sc.intel.com>
References: <20200806021342.10596-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806021342.10596-1-yangx.jy@cn.fujitsu.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Aug 06, 2020 at 10:13:34AM +0800, Xiao Yang wrote:
> The new behavior of DAX on xfs/ext4 has been merged into main kernel
> so it is time for fstests to support new behavior of DAX.

In case it helps...

I think this series has enough review to be applied.  Further tests/changes can
be applied on top of this...  so I'm going to add

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

For the entire series even though I think Xiao has already put a reviewed by on
all of the individual patches already.

Ira

> 
> 1) Refactor common functions and take use of them.
> 2) Move and update xfs/260.
> 3) Add three new tests to verify some features.
> 
> References:
> https://lkml.org/lkml/2019/10/20/96
> https://lkml.org/lkml/2020/5/28/949
> 
> V7->V8:
> 1) Rebase against the latest xfstests.
> 2) Factor out _check_s_dax() and _check_xflag().
> 
> V8->V9:
> 1) Squash a new test(generic/608) into the patch set.
> 2) Add a new combination(without dax option) for all related tests(generic/605,
>    generic/606, generic/608).
> 3) In generic/607, factor out _scratch_mkfs() and export MOUNT_OPTIONS=""
>    for a combination(without dax option).
> 
> Xiao Yang (8):
>   common/rc: Introduce helpers for new dax mount options and FS_XFLAG_DAX
>   fstests: Use _require_scratch_dax_mountopt() and _require_dax_iflag()
>   generic/223: Don't clear MKFS_OPTION before calling _scratch_mkfs_geom()
>   generic/413, xfs/260: Improve format operation for PMD fault testing
>   xfs/260: Move and update xfs/260
>   generic: Verify if statx() can qurey S_DAX flag on regular file correctly
>   generic: Verify the inheritance behavior of FS_XFLAG_DAX flag in various combinations
>   generic: Verify how to change the S_DAX flag on an existing file
> 
>  common/rc                      | 105 ++++++++++++++++--
>  tests/ext4/030                 |   2 +-
>  tests/ext4/031                 |   4 +-
>  tests/generic/223              |   1 -
>  tests/generic/413              |  12 +--
>  tests/generic/462              |   2 +-
>  tests/{xfs/260 => generic/605} |  79 +++++++-------
>  tests/generic/605.out          |   2 +
>  tests/generic/606              |  92 ++++++++++++++++
>  tests/generic/606.out          |   2 +
>  tests/generic/607              | 189 +++++++++++++++++++++++++++++++++
>  tests/generic/607.out          |   2 +
>  tests/generic/608              | 121 +++++++++++++++++++++
>  tests/generic/608.out          |   2 +
>  tests/generic/group            |   4 +
>  tests/xfs/260.out              |   2 -
>  tests/xfs/group                |   1 -
>  17 files changed, 559 insertions(+), 63 deletions(-)
>  rename tests/{xfs/260 => generic/605} (54%)
>  create mode 100644 tests/generic/605.out
>  create mode 100644 tests/generic/606
>  create mode 100644 tests/generic/606.out
>  create mode 100644 tests/generic/607
>  create mode 100644 tests/generic/607.out
>  create mode 100644 tests/generic/608
>  create mode 100644 tests/generic/608.out
>  delete mode 100644 tests/xfs/260.out
> 
> -- 
> 2.21.0
> 
> 
> 

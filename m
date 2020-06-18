Return-Path: <SRS0=wEx+=77=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B565C433DF
	for <linux-fstests@archiver.kernel.org>; Thu, 18 Jun 2020 00:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FB942080D
	for <linux-fstests@archiver.kernel.org>; Thu, 18 Jun 2020 00:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgFRAVa (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 17 Jun 2020 20:21:30 -0400
Received: from mga14.intel.com ([192.55.52.115]:42490 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726815AbgFRAV3 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 17 Jun 2020 20:21:29 -0400
IronPort-SDR: tSx+fTetGPLeweR5/V5QRM2QUQlPzThAL5k7vwR6UO/PRP16eKwMCb/Of/0IwCdHK8y+1l89i6
 2vWq+kDzQ1FQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 17:21:29 -0700
IronPort-SDR: oT9e2FdGgwFnrnPDMXbq0Khr0RAWPC6Qu5LAFf1GFZTs1nPGDQeUqYId+zJSiu3DxWoBpc+uPt
 idsPVSmr0ZWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,524,1583222400"; 
   d="scan'208";a="450446778"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga005.jf.intel.com with ESMTP; 17 Jun 2020 17:21:28 -0700
Date:   Wed, 17 Jun 2020 17:21:28 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Xiao Yang <ice_yangxiao@163.com>
Cc:     fstests@vger.kernel.org, darrick.wong@oracle.com,
        Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: Re: [PATCH v2 0/6] Make fstests support new behavior of DAX
Message-ID: <20200618002128.GP4160762@iweiny-DESK2.sc.intel.com>
References: <20200617093204.20838-1-ice_yangxiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617093204.20838-1-ice_yangxiao@163.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jun 17, 2020 at 05:31:58PM +0800, Xiao Yang wrote:
> From: Xiao Yang <yangx.jy@cn.fujitsu.com>

Also this email for Ross is no longer valid.  I don't believe he is with Intel
any longer.

	ross.zwisler@linux.intel.com

Ira

> 
> The new behavior of DAX on xfs/ext4 has been merged into main kernel
> tree/ext4-dax branch so it is time for fstests to support new behavior
> of DAX.
> 
> References:
> https://lkml.org/lkml/2019/10/20/96
> https://lkml.org/lkml/2020/5/28/949
> 
> Xiao Yang (6):
>   common/rc: Introduce new helpers for DAX mount options and
>     FS_XFLAG_DAX
>   fstests: Use _require_scratch_dax_mountopt() and
>     _require_scratch_dax_iflag()
>   common/rc: Remove unused _require_scratch_dax()
>   generic/223: Don't clear all mkfs options for _scratch_mkfs_geom()
>     roughly
>   generic/413, xfs/260: Improve format operation for PMD fault testing
>   xfs/260: Move xfs/260 to generic
> 
>  common/rc                      | 57 +++++++++++++++++++++++++++++-----
>  tests/ext4/030                 |  2 +-
>  tests/ext4/031                 |  4 +--
>  tests/generic/223              |  1 -
>  tests/generic/413              | 12 ++-----
>  tests/generic/462              |  2 +-
>  tests/{xfs/260 => generic/602} | 12 +++----
>  tests/generic/602.out          |  2 ++
>  tests/generic/group            |  1 +
>  tests/xfs/260.out              |  2 --
>  tests/xfs/group                |  1 -
>  11 files changed, 65 insertions(+), 31 deletions(-)
>  rename tests/{xfs/260 => generic/602} (93%)
>  create mode 100644 tests/generic/602.out
>  delete mode 100644 tests/xfs/260.out
> 
> -- 
> 2.21.0
> 

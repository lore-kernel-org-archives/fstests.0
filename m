Return-Path: <SRS0=QKYl=AL=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B33C433DF
	for <linux-fstests@archiver.kernel.org>; Tue, 30 Jun 2020 20:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B78120768
	for <linux-fstests@archiver.kernel.org>; Tue, 30 Jun 2020 20:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgF3UeY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:34:24 -0400
Received: from mga07.intel.com ([134.134.136.100]:43408 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgF3UeY (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 30 Jun 2020 16:34:24 -0400
IronPort-SDR: 43kftBgYO7+/o42qYorQGeurOohe4PKa5r7kd/ob7KNYFIj4KIozfnnipGfBXlm2bzcCk5XOrk
 wcrPgHxh/MOA==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="211434189"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="211434189"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 13:34:23 -0700
IronPort-SDR: akV4w6zdXyMwsuToXE9nsT941V8pJZTORO7TY80FPbhyU8RrctX7mg8rgkhp/69mM1qf7UC8+e
 0EQH9A9X7/Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="386799230"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga001.fm.intel.com with ESMTP; 30 Jun 2020 13:34:22 -0700
Date:   Tue, 30 Jun 2020 13:34:22 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     fstests@vger.kernel.org, darrick.wong@oracle.com
Subject: Re: [PATCH v3 0/6] Make fstests support new behavior of DAX
Message-ID: <20200630203422.GV2617015@iweiny-DESK2.sc.intel.com>
References: <20200630135951.21202-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630135951.21202-1-yangx.jy@cn.fujitsu.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jun 30, 2020 at 09:59:45PM +0800, Xiao Yang wrote:
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

Have the first 3 patches changed?  If not you could have added my Reviewed-by
from v2?[1]

Not sure if I need to look at them or not.

Ira

[1]
https://lore.kernel.org/fstests/b0d5803e-81e4-bb14-f47b-44036284577e@163.com/T/#mb0235e57045c4f7a3bc70c7745f2b7065bb3e3c1
https://lore.kernel.org/fstests/b0d5803e-81e4-bb14-f47b-44036284577e@163.com/T/#ma472463b67a354484a054cf0c0c1bf3c8567937b
https://lore.kernel.org/fstests/b0d5803e-81e4-bb14-f47b-44036284577e@163.com/T/#m5d44764e500370ceb4a350b4ae0df9bec8c08b56


>   generic/223: Don't clear all mkfs options for _scratch_mkfs_geom()
>     roughly
>   generic/413, xfs/260: Improve format operation for PMD fault testing
>   xfs/260: Move and update xfs/260
> 
>  common/rc                      | 60 ++++++++++++++++++++++++----
>  tests/ext4/030                 |  2 +-
>  tests/ext4/031                 |  4 +-
>  tests/generic/223              |  1 -
>  tests/generic/413              | 12 ++----
>  tests/generic/462              |  2 +-
>  tests/{xfs/260 => generic/603} | 71 +++++++++++++++++-----------------
>  tests/generic/603.out          |  2 +
>  tests/generic/group            |  1 +
>  tests/xfs/260.out              |  2 -
>  tests/xfs/group                |  1 -
>  11 files changed, 97 insertions(+), 61 deletions(-)
>  rename tests/{xfs/260 => generic/603} (54%)
>  create mode 100644 tests/generic/603.out
>  delete mode 100644 tests/xfs/260.out
> 
> -- 
> 2.21.0
> 
> 
> 

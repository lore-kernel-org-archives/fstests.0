Return-Path: <SRS0=82tC=BR=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE4BC433E0
	for <linux-fstests@archiver.kernel.org>; Fri,  7 Aug 2020 16:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 542932075A
	for <linux-fstests@archiver.kernel.org>; Fri,  7 Aug 2020 16:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgHGQKo (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 7 Aug 2020 12:10:44 -0400
Received: from mga11.intel.com ([192.55.52.93]:6910 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbgHGQKn (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 7 Aug 2020 12:10:43 -0400
IronPort-SDR: xtBpHDBS+un9LsBZ/x/YvTU424MRBr8eIF4N8TpX0bCn0ZlAjl4YVHNHbO5sJbncyvOTOrKWlE
 QMiPojxKJsTQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9705"; a="150839190"
X-IronPort-AV: E=Sophos;i="5.75,446,1589266800"; 
   d="scan'208";a="150839190"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2020 09:10:42 -0700
IronPort-SDR: 5X21kNsa9Pt8AHIl75FJCqTFTx8qGhs43LEH9l7DnLXdevhxGg2bPXOn8pWd4z2IKoiv9mHSRe
 638MuKkk+FLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,446,1589266800"; 
   d="scan'208";a="325795507"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga002.fm.intel.com with ESMTP; 07 Aug 2020 09:10:42 -0700
Date:   Fri, 7 Aug 2020 09:10:42 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] tests/generic/452: Fix the wrong commit id
Message-ID: <20200807161042.GR1573827@iweiny-DESK2.sc.intel.com>
References: <20200729051701.15387-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729051701.15387-1-yangx.jy@cn.fujitsu.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 29, 2020 at 01:17:01PM +0800, Xiao Yang wrote:
> The mentioned commit 42d4a99b09cb doesn't exist so use the correct one.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  tests/generic/452 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/452 b/tests/generic/452
> index 1e38b612..f6d6a0d7 100755
> --- a/tests/generic/452
> +++ b/tests/generic/452
> @@ -5,7 +5,7 @@
>  # FS QA Test 452
>  #
>  # This is a regression test for kernel patch:
> -#   commit 42d4a99b09cb ("ext4: fix fault handling when mounted with -o dax,ro")
> +#   commit fd96b8da68d3 ("ext4: fix fault handling when mounted with -o dax,ro")
>  # created by Ross Zwisler <ross.zwisler@linux.intel.com>
>  #
>  seq=`basename $0`
> -- 
> 2.21.0
> 
> 
> 

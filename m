Return-Path: <SRS0=zehT=76=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654CDC433DF
	for <linux-fstests@archiver.kernel.org>; Wed, 17 Jun 2020 20:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32AC32166E
	for <linux-fstests@archiver.kernel.org>; Wed, 17 Jun 2020 20:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgFQU7k (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:59:40 -0400
Received: from mga02.intel.com ([134.134.136.20]:8378 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbgFQU7j (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 17 Jun 2020 16:59:39 -0400
IronPort-SDR: 36hdcf5/6yFMWa2elPdfJn6JMTo9ag2Xm+LiAYqyNkoP5CZGbKdJ7ROYvO/ZSbNkc2QYQIwt4H
 1nDVtyMgDwqQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 13:59:38 -0700
IronPort-SDR: OM54T99guU7cxo4k87e/tPdXO5ZtNoVVLAJB8Fvj0DFRJZPWtfu8EdUNqqQADIwgIGAHPuA2pU
 UpOxKzQ8zhlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,523,1583222400"; 
   d="scan'208";a="299434588"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga004.fm.intel.com with ESMTP; 17 Jun 2020 13:59:38 -0700
Date:   Wed, 17 Jun 2020 13:59:38 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Xiao Yang <ice_yangxiao@163.com>
Cc:     fstests@vger.kernel.org, darrick.wong@oracle.com,
        ross.zwisler@linux.intel.com, Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: Re: [PATCH v2 3/6] common/rc: Remove unused _require_scratch_dax()
Message-ID: <20200617205938.GM4160762@iweiny-DESK2.sc.intel.com>
References: <20200617093204.20838-1-ice_yangxiao@163.com>
 <20200617093204.20838-4-ice_yangxiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617093204.20838-4-ice_yangxiao@163.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jun 17, 2020 at 05:32:01PM +0800, Xiao Yang wrote:
> From: Xiao Yang <yangx.jy@cn.fujitsu.com>
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  common/rc | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index ec7c19e4..dba52002 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3175,19 +3175,6 @@ _require_scratch_shutdown()
>  }
>  
>  # Does dax mount option work on this dev/fs?
> -_require_scratch_dax()
> -{
> -	_require_scratch
> -	_scratch_mkfs > /dev/null 2>&1
> -	_try_scratch_mount -o dax || \
> -		_notrun "mount $SCRATCH_DEV with dax failed"
> -	# Check options to be sure. XFS ignores dax option
> -	# and goes on if dev underneath does not support dax.
> -	_fs_options $SCRATCH_DEV | grep -qw "dax" || \
> -		_notrun "$SCRATCH_DEV $FSTYP does not support -o dax"
> -	_scratch_unmount
> -}
> -
>  _require_scratch_dax_mountopt()
>  {
>  	local mountopt=$1
> -- 
> 2.21.0
> 

Return-Path: <SRS0=5/bx=A2=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68471C433E2
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Jul 2020 02:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41AF720663
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Jul 2020 02:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgGOCbS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 14 Jul 2020 22:31:18 -0400
Received: from mga04.intel.com ([192.55.52.120]:37172 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726933AbgGOCbR (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 14 Jul 2020 22:31:17 -0400
IronPort-SDR: h/FkI13fVGBQnNA7YTkSY4HYO9lbDgXqosD2dQm/s6eRaAk+f7NdmBhULdeaYNPEGfE1VWVERm
 prTSWjj1yhuA==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="146572793"
X-IronPort-AV: E=Sophos;i="5.75,353,1589266800"; 
   d="scan'208";a="146572793"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 19:31:17 -0700
IronPort-SDR: 8T1csp5KdX+MlXyiPm8cFmoLB3yZNG/mwNlyVsqXw7la8oj/NAqGSZcPsqvavcdUC6dsFBmcpj
 xYmfYdWVMd0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,353,1589266800"; 
   d="scan'208";a="486088971"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jul 2020 19:31:17 -0700
Date:   Tue, 14 Jul 2020 19:31:17 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     fstests@vger.kernel.org, darrick.wong@oracle.com
Subject: Re: [PATCH v6 3/7] generic/223: Don't clear all mkfs options for
 _scratch_mkfs_geom() roughly
Message-ID: <20200715023117.GH3008823@iweiny-DESK2.sc.intel.com>
References: <20200714094009.8654-1-yangx.jy@cn.fujitsu.com>
 <20200714094009.8654-4-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714094009.8654-4-yangx.jy@cn.fujitsu.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jul 14, 2020 at 05:40:05PM +0800, Xiao Yang wrote:
> ext4 can accept the last one if the same mkfs options are passed but xfs cannot

I'm having trouble parsing this commit message.  What does 'last one' refer to?

> accept the same mkfs options and reports "xxx option is respecified" error.

Ok I think I understand now.  Some FS's (XFS) do not accept an option more than
once.  So we can't just blindly add options to the end of the MKFS_OPTIONS.  Is
that correct?

> I
> prefer to override the same mkfs option which is defined in MKFS_OPTION so that
> we can have a chance to pass other mkfs options to _scratch_mkfs_geom().

Instead the patch parses the current option string and replaces the value if
the option is already there.  This allows us to specify MKFS_OPTIONS to
generic/223.

I think the code is reasonable although my sed skills are not good enough to
tell for sure...  ;-)

Ira

> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  common/rc         | 14 +++++++++++++-
>  tests/generic/223 |  1 -
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 6c908f2e..567cf83b 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1051,7 +1051,19 @@ _scratch_mkfs_geom()
>  
>      case $FSTYP in
>      xfs)
> -	MKFS_OPTIONS+=" -b size=$blocksize, -d su=$sunit_bytes,sw=$swidth_mult"
> +	if echo "$MKFS_OPTIONS" | egrep -q "b?size="; then
> +		MKFS_OPTIONS=$(echo "$MKFS_OPTIONS" | sed -r "s/(b?size=)[0-9]+/\1$blocksize/")
> +	else
> +		MKFS_OPTIONS+=" -b size=$blocksize"
> +	fi
> +
> +	if echo "$MKFS_OPTIONS" | egrep -q "(su|sunit|sw|swidth)="; then
> +		MKFS_OPTIONS=$(echo "$MKFS_OPTIONS" | sed -r \
> +			-e "s/(su|sunit)=[0-9kmg]+/su=$sunit_bytes/" \
> +			-e "s/(sw|swidth)=[0-9kmg]+/sw=$swidth_mult/")
> +	else
> +		MKFS_OPTIONS+=" -d su=$sunit_bytes,sw=$swidth_mult"
> +	fi
>  	;;
>      ext4|ext4dev)
>  	MKFS_OPTIONS+=" -b $blocksize -E stride=$sunit_blocks,stripe_width=$swidth_blocks"
> diff --git a/tests/generic/223 b/tests/generic/223
> index 6cfd00dd..ba7c9a44 100755
> --- a/tests/generic/223
> +++ b/tests/generic/223
> @@ -41,7 +41,6 @@ for SUNIT_K in 8 16 32 64 128; do
>  	let SUNIT_BLOCKS=$SUNIT_BYTES/$BLOCKSIZE
>  
>  	echo "=== mkfs with su $SUNIT_BLOCKS blocks x 4 ==="
> -	export MKFS_OPTIONS=""
>  	_scratch_mkfs_geom $SUNIT_BYTES 4 $BLOCKSIZE >> $seqres.full 2>&1
>  	_scratch_mount
>  
> -- 
> 2.21.0
> 
> 
> 

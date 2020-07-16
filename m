Return-Path: <SRS0=TGcZ=A3=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59D8C433E4
	for <linux-fstests@archiver.kernel.org>; Thu, 16 Jul 2020 14:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF82C206F5
	for <linux-fstests@archiver.kernel.org>; Thu, 16 Jul 2020 14:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbgGPOpU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:45:20 -0400
Received: from mga04.intel.com ([192.55.52.120]:34096 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726963AbgGPOpT (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 16 Jul 2020 10:45:19 -0400
IronPort-SDR: g/aKR3EkcZlPmEzRLvQ9xZH5Cj4Ya+AJwd9MxZWFSlfYA6WJst2hpIntOJ0ktV+0akPPaeV5Kx
 AV7MH1vZ9oOA==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="146900598"
X-IronPort-AV: E=Sophos;i="5.75,359,1589266800"; 
   d="scan'208";a="146900598"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 07:45:19 -0700
IronPort-SDR: Oe7HWpxlvBCrz+Bvx7a/ZHz+qPCONr+KJVbsi++4yunz8LvEreddKq8BaZOVX9P6c1KExwHL+V
 o4pvda+Lokuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,359,1589266800"; 
   d="scan'208";a="325161691"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jul 2020 07:45:19 -0700
Date:   Thu, 16 Jul 2020 07:45:19 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     fstests@vger.kernel.org, darrick.wong@oracle.com
Subject: Re: [PATCH v2 2/2] common/rc: Update _exclude_scratch_mount_option()
 and _require_dm_target() for new dax option
Message-ID: <20200716144519.GN3008823@iweiny-DESK2.sc.intel.com>
References: <20200715162342.15192-1-yangx.jy@cn.fujitsu.com>
 <20200715162342.15192-2-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715162342.15192-2-yangx.jy@cn.fujitsu.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jul 16, 2020 at 12:23:42AM +0800, Xiao Yang wrote:
> Some tests(e.g. ext4/035) cannot include dax option(dax=inode/dax=never
> is OK) so make _exclude_scratch_mount_option() and _require_dm_target()
> check if old or new dax option is not defined in $MOUNT_OPTIONS.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  common/rc | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 8b19b3f7..7d0b8691 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1896,7 +1896,7 @@ _require_dm_target()
>  	_require_sane_bdev_flush $SCRATCH_DEV
>  	_require_command "$DMSETUP_PROG" dmsetup
>  
> -	echo $MOUNT_OPTIONS | grep -q dax
> +	_normalize_mount_options | egrep -q "dax(=always| |$)"
>  	if [ $? -eq 0 ]; then
>  		case $target in
>  		stripe|linear|log-writes)
> @@ -3452,12 +3452,16 @@ _normalize_mount_options()
>  }
>  
>  # skip test if MOUNT_OPTIONS contains the given strings
> +# For dax option, only accept dax/dax=always mount option
>  _exclude_scratch_mount_option()
>  {
>  	local mnt_opts=$(_normalize_mount_options)
> +	local pattern=$1
> +
> +	echo "$pattern" | grep -q 'dax' && pattern="dax(=always| |$)"
>  
>  	while [ $# -gt 0 ]; do
> -		if echo $mnt_opts | grep -qw "$1"; then
> +		if echo $mnt_opts | egrep -q "$pattern"; then
>  			_notrun "mount option \"$1\" not allowed in this test"
>  		fi
>  		shift
> -- 
> 2.21.0
> 
> 
> 

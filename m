Return-Path: <SRS0=zehT=76=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A722C433E0
	for <linux-fstests@archiver.kernel.org>; Wed, 17 Jun 2020 20:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EED892166E
	for <linux-fstests@archiver.kernel.org>; Wed, 17 Jun 2020 20:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgFQU6T (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:58:19 -0400
Received: from mga01.intel.com ([192.55.52.88]:21774 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726868AbgFQU6T (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 17 Jun 2020 16:58:19 -0400
IronPort-SDR: N7aB/Slhh2StVEkWfArxBjvM2HZHwL6Kip22pEvdm4QQI14s1kctSMYnR9qVYTEXcwSq6zEHx9
 f31jOQfu88Ww==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 13:58:19 -0700
IronPort-SDR: rSMxXcKnAF7s6TpNfCqnOgLDUt9Fp1qVguwJ5XW7psp3Q+A5f0Y7n2KrAtbKg0dv/JfRae+KBv
 M2UpahpO7pCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,523,1583222400"; 
   d="scan'208";a="450388766"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga005.jf.intel.com with ESMTP; 17 Jun 2020 13:58:18 -0700
Date:   Wed, 17 Jun 2020 13:58:18 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Xiao Yang <ice_yangxiao@163.com>
Cc:     fstests@vger.kernel.org, darrick.wong@oracle.com,
        ross.zwisler@linux.intel.com, Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: Re: [PATCH v2 1/6] common/rc: Introduce new helpers for DAX mount
 options and FS_XFLAG_DAX
Message-ID: <20200617205818.GK4160762@iweiny-DESK2.sc.intel.com>
References: <20200617093204.20838-1-ice_yangxiao@163.com>
 <20200617093204.20838-2-ice_yangxiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617093204.20838-2-ice_yangxiao@163.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jun 17, 2020 at 05:31:59PM +0800, Xiao Yang wrote:
> From: Xiao Yang <yangx.jy@cn.fujitsu.com>
> 
> 1) _require_scratch_dax_mountopt() checks both old and new DAX mount option
> 2) _require_scratch_dax_iflag() checks FS_XFLAG_DAX
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Thanks for moving this along.  I've been trying to get my tests modified and
integrated better into the mainline.

Thanks!

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  common/rc | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index a6967831..ec7c19e4 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3188,6 +3188,41 @@ _require_scratch_dax()
>  	_scratch_unmount
>  }
>  
> +_require_scratch_dax_mountopt()
> +{
> +	local mountopt=$1
> +	local output
> +
> +	_require_scratch
> +	_scratch_mkfs > /dev/null 2>&1
> +	_try_scratch_mount -o "$mountopt" || \
> +		_notrun "mount $SCRATCH_DEV with $mountopt failed"
> +
> +	output=$(_fs_options $SCRATCH_DEV)
> +
> +	# For new dax mount option, /proc/mounts shows different outputs if we
> +	# mount with -o dax=inode on ext4 and xfs so skip checking it.
> +	# /proc/mounts shows 'dax=inode' on ext4 but shows nothing on xfs.
> +	if [ "$mountopt" != "dax=inode" ]; then
> +		echo $output | grep -qw "$mountopt" || \
> +			_notrun "$SCRATCH_DEV $FSTYP does not support -o $mountopt"
> +	fi
> +
> +	# For new dax mount option, /proc/mounts shows "dax=never" if we
> +	# mount with -o dax on xfs and underlying device doesn't support dax.
> +	if [ "$mountopt" = "dax" ]; then
> +		echo $output | grep -qw "dax=never" && \
> +			_notrun "$SCRATCH_DEV $FSTYP does not support -o $mountopt"
> +	fi
> +
> +	_scratch_unmount
> +}
> +
> +_require_scratch_dax_iflag()
> +{
> +	_require_xfs_io_command "chattr" "x"
> +}
> +
>  # Does norecovery support by this fs?
>  _require_norecovery()
>  {
> -- 
> 2.21.0
> 

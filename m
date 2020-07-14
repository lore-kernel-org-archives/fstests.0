Return-Path: <SRS0=sm2X=AZ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC33FC433E2
	for <linux-fstests@archiver.kernel.org>; Tue, 14 Jul 2020 07:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0616206F0
	for <linux-fstests@archiver.kernel.org>; Tue, 14 Jul 2020 07:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbgGNHXo (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 14 Jul 2020 03:23:44 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:36877 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725925AbgGNHXo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 14 Jul 2020 03:23:44 -0400
X-IronPort-AV: E=Sophos;i="5.75,350,1589212800"; 
   d="scan'208";a="96303384"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 14 Jul 2020 15:23:36 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 03ECA4CE5059;
        Tue, 14 Jul 2020 15:23:32 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 14 Jul 2020 15:23:32 +0800
Message-ID: <5F0D5D72.5090006@cn.fujitsu.com>
Date:   Tue, 14 Jul 2020 15:23:30 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
CC:     <fstests@vger.kernel.org>, <darrick.wong@oracle.com>,
        <ira.weiny@intel.com>
Subject: Re: [PATCH v5 1/8] common/rc: Introduce new helpers for DAX mount
 options and FS_XFLAG_DAX
References: <20200709094917.13923-1-yangx.jy@cn.fujitsu.com> <20200709094917.13923-2-yangx.jy@cn.fujitsu.com>
In-Reply-To: <20200709094917.13923-2-yangx.jy@cn.fujitsu.com>
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 03ECA4CE5059.AD772
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2020/7/9 17:49, Xiao Yang wrote:
> 1) _require_scratch_dax_mountopt() checks both old and new DAX mount option
> 2) _require_dax_iflag() checks FS_XFLAG_DAX
>
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> ---
>
> V4->V5:
> 1) Rename _require_scratch_dax_iflag to _require_dax_iflag
> 2) Redirect the output of _try_scratch_mount to /dev/null
>
>  common/rc | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/common/rc b/common/rc
> index f17b19f2..498ce230 100644
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
> +	_try_scratch_mount "-o $mountopt" > /dev/null 2>&1 || \
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
Hi Darrick, Ira

I wonder if we just need to check two dax options(i.e. old 'dax' option
and new 'dax=always' option)
because of the following reasons:
1) we cannot detect if underlying device supports dax by mounting
dax=inode or dax=never.
2) dax=always, dax=inode, dax=never are always introduced together on
all distros.

Best Regards,
Xiao Yang
> +
> +_require_dax_iflag()
> +{
> +	_require_xfs_io_command "chattr" "x"
> +}
> +
>  # Does norecovery support by this fs?
>  _require_norecovery()
>  {




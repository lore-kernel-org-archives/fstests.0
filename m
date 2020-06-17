Return-Path: <SRS0=zehT=76=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FB7C433E0
	for <linux-fstests@archiver.kernel.org>; Wed, 17 Jun 2020 20:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E61902166E
	for <linux-fstests@archiver.kernel.org>; Wed, 17 Jun 2020 20:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgFQU6w (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:58:52 -0400
Received: from mga06.intel.com ([134.134.136.31]:55354 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726835AbgFQU6w (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 17 Jun 2020 16:58:52 -0400
IronPort-SDR: FWYbfDvne2Hg52QT71J2yn8fDjMvbVch3H2j3r2TzlAIljbL3GLpuxKb6tnmP6DTMDsYSQM0UI
 a85/F8de7/oQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 13:58:51 -0700
IronPort-SDR: FpkEiCvnLBTuZosku9kHjzYeP5pfi6jCOKqjSnTG0fzLiPWO/2DSy9dw92uRIwxECh/wj3k1Qj
 5kCIGg4TQR+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,523,1583222400"; 
   d="scan'208";a="277401014"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga006.jf.intel.com with ESMTP; 17 Jun 2020 13:58:51 -0700
Date:   Wed, 17 Jun 2020 13:58:51 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Xiao Yang <ice_yangxiao@163.com>
Cc:     fstests@vger.kernel.org, darrick.wong@oracle.com,
        ross.zwisler@linux.intel.com, Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: Re: [PATCH v2 2/6] fstests: Use _require_scratch_dax_mountopt() and
 _require_scratch_dax_iflag()
Message-ID: <20200617205851.GL4160762@iweiny-DESK2.sc.intel.com>
References: <20200617093204.20838-1-ice_yangxiao@163.com>
 <20200617093204.20838-3-ice_yangxiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617093204.20838-3-ice_yangxiao@163.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jun 17, 2020 at 05:32:00PM +0800, Xiao Yang wrote:
> From: Xiao Yang <yangx.jy@cn.fujitsu.com>
> 
> Make related tests use _require_scratch_dax_mountopt() and _require_scratch_dax_iflag()
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  tests/ext4/030    | 2 +-
>  tests/ext4/031    | 4 ++--
>  tests/generic/413 | 2 +-
>  tests/generic/462 | 2 +-
>  tests/xfs/260     | 4 ++--
>  5 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/ext4/030 b/tests/ext4/030
> index 93bbca86..fb5cf451 100755
> --- a/tests/ext4/030
> +++ b/tests/ext4/030
> @@ -33,7 +33,7 @@ rm -f $seqres.full
>  # Modify as appropriate.
>  _supported_os Linux
>  _supported_fs ext4
> -_require_scratch_dax
> +_require_scratch_dax_mountopt "dax"
>  _require_test_program "t_ext4_dax_journal_corruption"
>  _require_command "$CHATTR_PROG" chattr
>  
> diff --git a/tests/ext4/031 b/tests/ext4/031
> index dc58214e..20e2fab7 100755
> --- a/tests/ext4/031
> +++ b/tests/ext4/031
> @@ -37,7 +37,7 @@ MOUNT_OPTIONS=""
>  # Modify as appropriate.
>  _supported_os Linux
>  _supported_fs ext4
> -_require_scratch_dax
> +_require_scratch_dax_mountopt "dax"
>  _require_test_program "t_ext4_dax_inline_corruption"
>  _require_scratch_ext4_feature "inline_data"
>  
> @@ -56,7 +56,7 @@ _scratch_unmount >> $seqres.full 2>&1
>  _try_scratch_mount "-o dax" >> $seqres.full 2>&1
>  
>  if [[ $? != 0 ]]; then
> -	# _require_scratch_dax already verified that we could mount with DAX.
> +	# _require_scratch_dax_mountopt already verified that we could mount with DAX.
>  	# Failure here is expected because we have inline data.
>  	echo "Silence is golden"
>  	status=0
> diff --git a/tests/generic/413 b/tests/generic/413
> index 1ce89aff..19e1b926 100755
> --- a/tests/generic/413
> +++ b/tests/generic/413
> @@ -31,7 +31,7 @@ rm -f $seqres.full
>  _supported_fs generic
>  _supported_os Linux
>  _require_test
> -_require_scratch_dax
> +_require_scratch_dax_mountopt "dax"
>  _require_test_program "feature"
>  _require_test_program "t_mmap_dio"
>  _require_xfs_io_command "falloc"
> diff --git a/tests/generic/462 b/tests/generic/462
> index 1ab6cadc..4a940239 100755
> --- a/tests/generic/462
> +++ b/tests/generic/462
> @@ -37,7 +37,7 @@ rm -f $seqres.full
>  _supported_fs generic
>  _supported_os Linux
>  _require_test
> -_require_scratch_dax
> +_require_scratch_dax_mountopt "dax"
>  _require_test_program "t_mmap_write_ro"
>  # running by unpriviliged user is not necessary to reproduce
>  # this bug, just trying to test more.
> diff --git a/tests/xfs/260 b/tests/xfs/260
> index 3464ffef..fbdc4cd8 100755
> --- a/tests/xfs/260
> +++ b/tests/xfs/260
> @@ -30,10 +30,10 @@ rm -f $seqres.full
>  
>  _supported_fs xfs
>  _supported_os Linux
> -_require_scratch_dax
> +_require_scratch_dax_mountopt "dax"
>  _require_test_program "feature"
>  _require_test_program "t_mmap_dio"
> -_require_xfs_io_command "chattr" "x"
> +_require_scratch_dax_iflag
>  _require_xfs_io_command "falloc"
>  
>  prep_files()
> -- 
> 2.21.0
> 

Return-Path: <SRS0=C+DF=BN=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63586C433E0
	for <linux-fstests@archiver.kernel.org>; Mon,  3 Aug 2020 19:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AA9620672
	for <linux-fstests@archiver.kernel.org>; Mon,  3 Aug 2020 19:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgHCTtU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 3 Aug 2020 15:49:20 -0400
Received: from mga06.intel.com ([134.134.136.31]:62622 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728275AbgHCTtU (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 3 Aug 2020 15:49:20 -0400
IronPort-SDR: oaUYaZhyJKhhwGGd+KaBX4ecjbRx0kwpJTatSEhwnBflZERezBBnnuNJ85d7RYN4dAseoGQk5i
 TSu7KccWkf/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="213731977"
X-IronPort-AV: E=Sophos;i="5.75,431,1589266800"; 
   d="scan'208";a="213731977"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 12:49:19 -0700
IronPort-SDR: vLUIm9+K8mDG36bsUNPS3X+4GZ9bPlDmC9OWojMMtZIM7j7s1uEsTqqFOeNRqoQBh4eLuva8f5
 6Oa4bUJerCuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,431,1589266800"; 
   d="scan'208";a="275460541"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga008.fm.intel.com with ESMTP; 03 Aug 2020 12:49:19 -0700
Date:   Mon, 3 Aug 2020 12:49:19 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     guaneryu@gmail.com, fstests@vger.kernel.org,
        darrick.wong@oracle.com
Subject: Re: [PATCH v8 1/7] common/rc: Introduce helpers for new dax mount
 options and FS_XFLAG_DAX
Message-ID: <20200803194915.GF1573827@iweiny-DESK2.sc.intel.com>
References: <20200803083838.26222-1-yangx.jy@cn.fujitsu.com>
 <20200803083838.26222-2-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803083838.26222-2-yangx.jy@cn.fujitsu.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Aug 03, 2020 at 04:38:32PM +0800, Xiao Yang wrote:
> 1) _check_scratch_dax_mountopt() checks old/new dax mount option and
>    returns a value.
> 2) _require_scratch_dax_mountopt() throws notrun if _check_scratch_dax_mountopt()
>    returns a non-zero value.
> 3) _require_dax_iflag() checks FS_XFLAG_DAX.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  common/rc | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 1b7b2575..d7926bc5 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3188,6 +3188,48 @@ _require_scratch_dax()
>  	_scratch_unmount
>  }
>  
> +# Only accept dax/dax=always mount option becasue dax=always, dax=inode
> +# and dax=never are always introduced together.
> +# Return 0 if filesystem/device supports the specified dax option.
> +# Return 1 if mount fails with the specified dax option.
> +# Return 2 if /proc/mounts shows wrong dax option.
> +# Check new dax=inode, dax=always or dax=never option by passing "dax=always".
> +# Check old dax or new dax=always by passing "dax".
> +_check_scratch_dax_mountopt()

So I think I see what you are trying to say here but I'm not sure the
comment/doc is clear.  How about:

# Check if dax mount options are supported
#
# $1 can be either 'dax=always' or 'dax'
#
# dax=always
#      Check for the new dax options (dax=inode, dax=always or dax=never) by
#      passing "dax=always".
# dax
#      Check for the old dax or new dax=always by passing "dax".
#
# This only accepts 'dax=always' because dax=always, dax=inode
# and dax=never are always supported together.  So if the other options are
# required checking for 'dax=always' indicates support for the other 2.
#
# Return 0 if filesystem/device supports the specified dax option.
# Return 1 if mount fails with the specified dax option.
# Return 2 if /proc/mounts shows wrong dax option.

Ira

> +{
> +	local option=$1
> +
> +	_require_scratch
> +	_scratch_mkfs > /dev/null 2>&1
> +
> +	_try_scratch_mount "-o $option" > /dev/null 2>&1 || return 1
> +
> +	if _fs_options $SCRATCH_DEV | egrep -q "dax(=always|,|$)"; then
> +		_scratch_unmount
> +		return 0
> +	else
> +		_scratch_unmount
> +		return 2
> +	fi
> +}
> +
> +# Throw notrun if _check_scratch_dax_mountopt() returns a non-zero value.
> +_require_scratch_dax_mountopt()
> +{
> +	local mountopt=$1
> +
> +	_check_scratch_dax_mountopt "$mountopt"
> +	local res=$?
> +
> +	[ $res -eq 1 ] && _notrun "mount $SCRATCH_DEV with $mountopt failed"
> +	[ $res -eq 2 ] && _notrun "$SCRATCH_DEV $FSTYP does not support -o $mountopt"
> +}
> +
> +_require_dax_iflag()
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
> 
> 

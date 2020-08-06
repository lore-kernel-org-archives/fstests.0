Return-Path: <SRS0=LCFT=BQ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0599CC433DF
	for <linux-fstests@archiver.kernel.org>; Thu,  6 Aug 2020 18:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F76B206A2
	for <linux-fstests@archiver.kernel.org>; Thu,  6 Aug 2020 18:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p7RcO5fF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgHFSFf (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:05:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36516 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgHFSFZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 6 Aug 2020 14:05:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 076FIEgi051211;
        Thu, 6 Aug 2020 15:18:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=+HhC0j6QZVlRuxHe02Zn0X0sfCWJoj3vOY2iwlfoUCs=;
 b=p7RcO5fFzptMa7J4O3TxuODaiJNiA8/XDNymsmUlx2krr98M0/MNoi0btATs8rdvUBYg
 W+5roTMld0bPZ3hvO8RUn8S38Oh/mxdXbUXZ6chTXVXdqqVyexlB6dfWd1Ks0ejA4raL
 dncLfoBiyCkhfdwj/UgDaKwNTf++xlpQ5orYydpR5FHXShDqT8kJQQ23vCTVl2KTBdXJ
 MVoMhRqjce3eUkIrS4/GpnYXYddAQ5rW64cBanbSZTvqJ8YCl+DqdJ2cK3qXZHCSt0gh
 G5622CEoIr2uklgZS0SEKxeqb/nu3aMBmirdUY7bRn01Ax+Tlq5a+TcTNVJMjx7Nopbf 9A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 32r6fxkm8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 06 Aug 2020 15:18:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 076FDqNH042279;
        Thu, 6 Aug 2020 15:16:14 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 32r6cvkgjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Aug 2020 15:16:13 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 076FGCeS029005;
        Thu, 6 Aug 2020 15:16:12 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Aug 2020 08:16:12 -0700
Date:   Thu, 6 Aug 2020 08:16:11 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     fstests@vger.kernel.org, ira.weiny@intel.com, guaneryu@gmail.com
Subject: Re: [PATCH v9 1/8] common/rc: Introduce helpers for new dax mount
 options and FS_XFLAG_DAX
Message-ID: <20200806151611.GC191798@magnolia>
References: <20200806021342.10596-1-yangx.jy@cn.fujitsu.com>
 <20200806021342.10596-2-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806021342.10596-2-yangx.jy@cn.fujitsu.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9704 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008060109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9704 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 suspectscore=1 spamscore=0 clxscore=1015 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008060110
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Aug 06, 2020 at 10:13:35AM +0800, Xiao Yang wrote:
> 1) _check_scratch_dax_mountopt() checks old/new dax mount option and
>    returns a value.
> 2) _require_scratch_dax_mountopt() throws notrun if _check_scratch_dax_mountopt()
>    returns a non-zero value.
> 3) _require_dax_iflag() checks FS_XFLAG_DAX.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Looks good to me now,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  common/rc | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 1b7b2575..fa70453d 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3188,6 +3188,58 @@ _require_scratch_dax()
>  	_scratch_unmount
>  }
>  
> +# Check if dax mount options are supported
> +#
> +# $1 can be either 'dax=always' or 'dax'
> +#
> +# dax=always
> +#      Check for the new dax options (dax=inode, dax=always or dax=never)
> +#      by passing "dax=always".
> +# dax
> +#      Check for the old dax or new dax=always by passing "dax".
> +#
> +# This only accepts 'dax=always' because dax=always, dax=inode and
> +# dax=never are always supported together.  So if the other options are
> +# required checking for 'dax=always' indicates support for the other 2.
> +#
> +# Return 0 if filesystem/device supports the specified dax option.
> +# Return 1 if mount fails with the specified dax option.
> +# Return 2 if /proc/mounts shows wrong dax option.
> +_check_scratch_dax_mountopt()
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

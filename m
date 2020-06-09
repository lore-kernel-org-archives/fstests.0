Return-Path: <SRS0=3iZY=7W=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3F4C433DF
	for <linux-fstests@archiver.kernel.org>; Tue,  9 Jun 2020 16:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B44B520774
	for <linux-fstests@archiver.kernel.org>; Tue,  9 Jun 2020 16:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mJYrtIoC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731047AbgFIQjV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 9 Jun 2020 12:39:21 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54290 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbgFIQjT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 9 Jun 2020 12:39:19 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 059GcarS052449;
        Tue, 9 Jun 2020 16:39:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=d+fZYMTVV44WYVousW/hpmqQ2KoX1eDMtfDlIblIfNo=;
 b=mJYrtIoC9K6nuXJzihPraKwSjIoVQnxEWJHRPJLe+d5T892Hx0eYUtHA2xZakd/wWuOY
 XWa39HtBqms1DyaOhQo8QgzaVcyeV09/0N5psXb/mrPMCElHtTyVuB5oxAv8V8zYxECy
 xKsa31jDpq2qp92ck9stse0VKr01tKCycmYk5xx/vSuANDQX690//OuZVv/vPOtwV18U
 QjYdZ8fxHzEtSeWyyXbq4CAoU74OWiwYTipVREpSyLQ0WoAM+96Twy6KLZ6exgOI6dhk
 iaRCwr59jcmQHZHMubPa4sKfm5A+CpLRsZeaHapcZI1gCrRIFmlHfOfAOq6TN1LUhWSt Jw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 31g3smwsyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 09 Jun 2020 16:39:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 059GWMpc155907;
        Tue, 9 Jun 2020 16:39:10 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 31gn269t3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Jun 2020 16:39:10 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 059Gd9kf017348;
        Tue, 9 Jun 2020 16:39:09 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Jun 2020 09:39:09 -0700
Date:   Tue, 9 Jun 2020 09:39:08 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     fstests@vger.kernel.org, ira.weiny@intel.com
Subject: Re: [PATCH 1/4] common/rc: Introduce new helpers for DAX mount
 options and FS_XFLAG_DAX
Message-ID: <20200609163908.GA11255@magnolia>
References: <20200603140115.30392-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603140115.30392-1-yangx.jy@cn.fujitsu.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9647 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=1 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006090126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9647 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 cotscore=-2147483648 suspectscore=1
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006090127
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Oh, this wasn't the cover letter. ;)

On Wed, Jun 03, 2020 at 10:01:12PM +0800, Xiao Yang wrote:
> 1) _require_scratch_dax_mountopt() checks both old and new DAX mount option
> 2) _require_scratch_daX_iflag() checks FS_XFLAG_DAX
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
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

What happens if MOUNT_OPTS already contains a dax option?  Should we
clear it out ala _qmount_option, on the assumption that a test that
cares about specific options probably wants to override whatever the
test runner passed in?

--D

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
> 
> 

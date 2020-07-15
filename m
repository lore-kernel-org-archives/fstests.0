Return-Path: <SRS0=5/bx=A2=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065E5C433DF
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Jul 2020 16:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8B38206D5
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Jul 2020 16:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PGYUZbTE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgGOQJ1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 15 Jul 2020 12:09:27 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36220 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgGOQJ0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 15 Jul 2020 12:09:26 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06FFlD18035457;
        Wed, 15 Jul 2020 16:09:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=fFEZOzeT0Mo7juTLNm3jv2EKolTp48SLi8mZ6VB3GLQ=;
 b=PGYUZbTEkoifIgOnLNyyCQDzr9URyLYalYqAXXaO6BewW+cGLkeL4r5FZLMtYtYzutQK
 ARX4YYVEooaAejgAomzS3nm5risn7e2KVLnJrGP26FY3DMs5Ej8khNAX/ak5vBcZwWOO
 vqLoKINzZL1/ukS+Sp9HZdOnd7UuCRkD8MwSrOaOAB/Y+7os6P87QDBOqGTYYQBrAO5J
 ZckbjnTHgqZ4bNDphZ01Uz+wIMjVf5cEyBiMmni8zgy8cyBD/70rlkNfn2P2Y0CvDKQ4
 i2FADYILPKubyKs9SZGih3/ZeaFwItBW9sAKg+UAeMCZEgNUBwguHGf+V3mGlKtTFi9y zg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 3275cmcbnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Jul 2020 16:09:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06FFluAn009719;
        Wed, 15 Jul 2020 16:09:21 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 327q0rgv3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jul 2020 16:09:20 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06FG9JtN014666;
        Wed, 15 Jul 2020 16:09:19 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Jul 2020 09:09:19 -0700
Date:   Wed, 15 Jul 2020 09:09:17 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     fstests@vger.kernel.org, ira.weiny@intel.com
Subject: Re: [PATCH v6 4/7] generic/413, xfs/260: Improve format operation
 for PMD fault testing
Message-ID: <20200715160917.GO7600@magnolia>
References: <20200714094009.8654-1-yangx.jy@cn.fujitsu.com>
 <20200714094009.8654-5-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714094009.8654-5-yangx.jy@cn.fujitsu.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9683 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007150126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9683 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007150126
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jul 14, 2020 at 05:40:06PM +0800, Xiao Yang wrote:
> 1) Simple code and fix the wrong value of stripe_width by _scratch_mkfs_geom().
> 2) Get hugepage size by _get_hugepagesize() and replace fixed 2M with
>    hugepage size because hugepage size/PMD_SIZE is not 2M on some
>    arches(e.g. hugepage size/PMD_SIZE is 512M on arm64).
> 3) For debugging, redirect the output of mkfs to $seqres.full.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Thanks for making this change...

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  common/rc         | 10 ++++++++++
>  tests/generic/413 | 10 ++--------
>  tests/xfs/260     |  4 ++--
>  3 files changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 567cf83b..b6a48241 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -170,6 +170,16 @@ _get_filesize()
>      stat -c %s "$1"
>  }
>  
> +# Get hugepagesize in bytes
> +_get_hugepagesize()
> +{
> +	local hugepgsz=$(awk '/Hugepagesize/ {print $2}' /proc/meminfo)
> +	# Call _notrun if $hugepgsz is not a number
> +	echo "$hugepgsz" | egrep -q ^[0-9]+$ || \
> +		_notrun "Cannot get the value of Hugepagesize"
> +	echo $((hugepgsz * 1024))
> +}
> +
>  _mount()
>  {
>      $MOUNT_PROG `_mount_ops_filter $*`
> diff --git a/tests/generic/413 b/tests/generic/413
> index 19e1b926..dfe2912b 100755
> --- a/tests/generic/413
> +++ b/tests/generic/413
> @@ -111,14 +111,8 @@ do_tests()
>  	t_mmap_dio_dax $((64 * 1024 * 1024))
>  }
>  
> -# make fs 2Mb aligned for PMD fault testing
> -mkfs_opts=""
> -if [ "$FSTYP" == "ext4" ]; then
> -	mkfs_opts="-E stride=512,stripe_width=1"
> -elif [ "$FSTYP" == "xfs" ]; then
> -	mkfs_opts="-d su=2m,sw=1"
> -fi
> -_scratch_mkfs "$mkfs_opts" > /dev/null 2>&1
> +# make fs aligned for PMD fault testing
> +_scratch_mkfs_geom $(_get_hugepagesize) 1 >> $seqres.full 2>&1
>  
>  # mount SCRATCH_DEV with dax option, TEST_DEV not
>  export MOUNT_OPTIONS=""
> diff --git a/tests/xfs/260 b/tests/xfs/260
> index bcdc6041..81b42f01 100755
> --- a/tests/xfs/260
> +++ b/tests/xfs/260
> @@ -121,8 +121,8 @@ do_tests()
>  	t_dax_flag_mmap_dio $((64 * 1024 * 1024))
>  }
>  
> -# make xfs 2Mb aligned for PMD fault testing
> -_scratch_mkfs "-d su=2m,sw=1" > /dev/null 2>&1
> +# make xfs aligned for PMD fault testing
> +_scratch_mkfs_geom $(_get_hugepagesize) 1 >> $seqres.full 2>&1
>  
>  # mount with dax option
>  _scratch_mount "-o dax"
> -- 
> 2.21.0
> 
> 
> 

Return-Path: <SRS0=gdhN=AE=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A082C433DF
	for <linux-fstests@archiver.kernel.org>; Tue, 23 Jun 2020 15:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7446D2070E
	for <linux-fstests@archiver.kernel.org>; Tue, 23 Jun 2020 15:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ssR2iwnt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732910AbgFWP2h (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:28:37 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40644 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732781AbgFWP2h (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 23 Jun 2020 11:28:37 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05NFGsiS142563;
        Tue, 23 Jun 2020 15:28:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=2vOfkvNOPG8ypGhkVbpJP3xmoPc4hYt8q40znDNtkEM=;
 b=ssR2iwntOt7uCZ/WOpeBBv3RKx+xW310YwG4Ww/Noy1cNEcOPLReOCC4Ef53cT9lFQTP
 RgUgt1pD7heXd4pxAV/c/fYq8X9vHJ7kIqfwv4KSUwuyW5RrQmc3j9EKz/BDUseOOsDb
 bxmu9RYHancyTDgxswDwhqZBF2qdn1WGOhD2kx3/SlHmaAHN+kCEmW94NwoWU4WE3cld
 9FHLnuKDxDkXG+NW+do2vZ9lk8i3AS09lcGWdTrjbISTGNKol1htrajVv9C4VJS99kSy
 8l/wSA1cEUPOLo5EWBuiYxg9emFpQPmAq/1YaJuzoM/8O/lOjfCll6M082GlHg7eUtzZ Cg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 31uk2rrk4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Jun 2020 15:28:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05NFJEpV079235;
        Tue, 23 Jun 2020 15:28:21 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 31uk424cj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Jun 2020 15:28:21 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05NFSJiA011261;
        Tue, 23 Jun 2020 15:28:19 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 23 Jun 2020 15:28:18 +0000
Date:   Tue, 23 Jun 2020 08:28:17 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Xiao Yang <ice_yangxiao@163.com>
Cc:     fstests@vger.kernel.org, ira.weiny@intel.com,
        ross.zwisler@linux.intel.com, Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: Re: [PATCH v2 5/6] generic/413, xfs/260: Improve format operation
 for PMD fault testing
Message-ID: <20200623152817.GB7600@magnolia>
References: <20200617093204.20838-1-ice_yangxiao@163.com>
 <20200617093204.20838-6-ice_yangxiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617093204.20838-6-ice_yangxiao@163.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9661 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006120000
 definitions=main-2006230118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9661 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 spamscore=0 clxscore=1011 suspectscore=1
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006120000 definitions=main-2006230118
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jun 17, 2020 at 05:32:03PM +0800, Xiao Yang wrote:
> From: Xiao Yang <yangx.jy@cn.fujitsu.com>
> 
> 1) Simple code and fix the wrong value of stripe_width by _scratch_mkfs_geom().
> 2) Get hugepage size by _get_hugepagesize() and replace fixed 2M with
>    hugepage size because hugepage size/PMD_SIZE is not 2M on some
>    arches.(e.g. hugepage size/PMD_SIZE is 512M on arm64)
> 3) For debugging, redirect the output of mkfs to $seqres.full.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  common/rc         |  7 +++++++
>  tests/generic/413 | 10 ++--------
>  tests/xfs/260     |  4 ++--
>  3 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index bde26010..4852b21b 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -170,6 +170,13 @@ _get_filesize()
>      stat -c %s "$1"
>  }
>  
> +# get hugepagesize in bytes
> +_get_hugepagesize()
> +{
> +	local hugepgsz=$(awk '/Hugepagesize/ {print $2}' /proc/meminfo)
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

These _get_hugepagesize callsites ought to _notrun the test or something
if the relevant data cannot be extracted from /proc/meminfo.

Other than that, I like the way this looks. :)

--D

>  
>  # mount SCRATCH_DEV with dax option, TEST_DEV not
>  export MOUNT_OPTIONS=""
> diff --git a/tests/xfs/260 b/tests/xfs/260
> index fbdc4cd8..7afc20f1 100755
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

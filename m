Return-Path: <SRS0=5/bx=A2=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED74BC433F4
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Jul 2020 16:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8E092078C
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Jul 2020 16:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aMCVyGrQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgGOQIy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 15 Jul 2020 12:08:54 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35314 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbgGOQIr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 15 Jul 2020 12:08:47 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06FFlD5e035448;
        Wed, 15 Jul 2020 16:08:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=DTMMPsqm35JmfTh/WS6oobNmEwxp0fnvY47yqDlTxMQ=;
 b=aMCVyGrQV/Kz+7ZhOSfREge/IHmZBRxYXVCEmMiYR4NF6ZV+O+4IwQ6cqTmMXRj3ftxt
 3L3CxU5QS7KSqLkyBGcFOAj6Ip01PObKssCvDYnSOC1PEbNHfNtXfyXPcwtNE0urOc1N
 DfVMHqPz4Buk0vReiRUfgT5fvV+q0trEINWJvu4wWoPFY8JMO6suWnl435a8QrQAef7X
 nZ4lfoNIWzoYJF/7n9TjphT0phAwr3T/N5xMutImkf+7RhvXeBLKfOaXycsHXNBKNqj2
 8rba/yn0g+9igYY22pMSKMmsS+NlnUDfFGxj0oMCrTXOkWxI8HtGHiRi4VmAIcLoytpg zQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 3275cmcbf3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Jul 2020 16:08:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06FFmxlJ095434;
        Wed, 15 Jul 2020 16:08:06 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 327qc18fuh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jul 2020 16:08:04 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06FG8330010720;
        Wed, 15 Jul 2020 16:08:03 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Jul 2020 09:08:03 -0700
Date:   Wed, 15 Jul 2020 09:08:01 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     fstests@vger.kernel.org, ira.weiny@intel.com
Subject: Re: [PATCH v6 2/7] fstests: Use _require_scratch_dax_mountopt() and
 _require_dax_iflag()
Message-ID: <20200715160801.GN7600@magnolia>
References: <20200714094009.8654-1-yangx.jy@cn.fujitsu.com>
 <20200714094009.8654-3-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714094009.8654-3-yangx.jy@cn.fujitsu.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9683 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007150126
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

On Tue, Jul 14, 2020 at 05:40:04PM +0800, Xiao Yang wrote:
> 1) Make related tests use _require_scratch_dax_mountopt() and _require_dax_iflag()
> 2) Remove unused _require_scratch_dax()
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Looks ok to me,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
> 
> V5->V6:
> Merge the third patch into the second patch.
> 
>  common/rc         | 13 -------------
>  tests/ext4/030    |  2 +-
>  tests/ext4/031    |  4 ++--
>  tests/generic/413 |  2 +-
>  tests/generic/462 |  2 +-
>  tests/xfs/260     |  4 ++--
>  6 files changed, 7 insertions(+), 20 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index aeec1f11..6c908f2e 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3175,19 +3175,6 @@ _require_scratch_shutdown()
>  }
>  
>  # Does dax mount option work on this dev/fs?
> -_require_scratch_dax()
> -{
> -	_require_scratch
> -	_scratch_mkfs > /dev/null 2>&1
> -	_try_scratch_mount -o dax || \
> -		_notrun "mount $SCRATCH_DEV with dax failed"
> -	# Check options to be sure. XFS ignores dax option
> -	# and goes on if dev underneath does not support dax.
> -	_fs_options $SCRATCH_DEV | grep -qw "dax" || \
> -		_notrun "$SCRATCH_DEV $FSTYP does not support -o dax"
> -	_scratch_unmount
> -}
> -
>  # Only accept dax/dax=always mount option becasue dax=always, dax=inode
>  # and dax=never are always introduced together.
>  _require_scratch_dax_mountopt()
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
> index 3464ffef..bcdc6041 100755
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
> +_require_dax_iflag
>  _require_xfs_io_command "falloc"
>  
>  prep_files()
> -- 
> 2.21.0
> 
> 
> 

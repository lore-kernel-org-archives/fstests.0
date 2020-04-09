Return-Path: <SRS0=x5Yn=5Z=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7342C2BA19
	for <linux-fstests@archiver.kernel.org>; Thu,  9 Apr 2020 20:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7BC2082D
	for <linux-fstests@archiver.kernel.org>; Thu,  9 Apr 2020 20:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CK0rLLVz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgDIUuX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 9 Apr 2020 16:50:23 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46078 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbgDIUuX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 9 Apr 2020 16:50:23 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 039KmZVj059787;
        Thu, 9 Apr 2020 20:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=0moIgdLmEBAEORhv0pReqX8vOqmTfNAIxoHrmPpvq0w=;
 b=CK0rLLVzE2BikJHUGvqU8O+1aNnYNJCTyc7SRsX84C7/2HKgmFXqjx/zEi30ajUP6gZe
 1ENeWjMcKzHlDObHIQXcQb4BPZBYRrrdAqe0zTTKK3p9nwzzQhBebT0Ss5zLIYJKgyBU
 +yHVpJR/8p48iAMbUAKpTqwejYvKVTS8xltex0Hi9St8rIjaVx6igkUi0NonT+pAPBsv
 iez02Jyzm0WkaOlVQkAROQRy9iV17golmO1bTmXTA1sMP2VDje3a/c3dcmbWwX7UiblR
 gtz+ZTdKZgj91S/MAantUIsxvLkxrg9OFqghNCbU8c9XJG5a4LCP26HLXiA8GIbB4gJe og== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 3091m13rxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Apr 2020 20:50:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 039Kkn4n104132;
        Thu, 9 Apr 2020 20:48:17 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 309ag5n3sg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Apr 2020 20:48:17 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 039KmFlq015771;
        Thu, 9 Apr 2020 20:48:16 GMT
Received: from localhost (/10.159.243.40)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 Apr 2020 13:48:15 -0700
Date:   Thu, 9 Apr 2020 13:48:14 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     fstests <fstests@vger.kernel.org>,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: Re: [PATCH 1/2] fstests: use _require_symlinks on all necessary tests
Message-ID: <20200409204814.GE6740@magnolia>
References: <83a816c2-fa40-c63f-7709-35863d412ded@redhat.com>
 <5bc398a3-a62d-e67f-1597-98dfee96f2f1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bc398a3-a62d-e67f-1597-98dfee96f2f1@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9586 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004090146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9586 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004090146
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Apr 09, 2020 at 02:09:04PM -0500, Eric Sandeen wrote:
> Consistently use _require_symlinks on all generic tests which
> create a symlink.
> 
> Rename an old require function, "_require_test_symlinks" to simply

Wait, we're adding and renaming at the same time?

One thing per patch, please...

> "_require_symlinks" because it's reasonable to assume that if the
> test device doesn't support it, neither does the scratch device
> and vice versa.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> diff --git a/common/rc b/common/rc
> index 24a8f145..476d3d07 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3481,14 +3481,14 @@ run_check()
>  	"$@" >> $seqres.full 2>&1 || _fail "failed: '$@'"
>  }
>  
> -_require_test_symlinks()
> +_require_symlinks()
>  {
>  	local target=`mktemp -p $TEST_DIR`
>  	local link=`mktemp -p $TEST_DIR -u`
>  	ln -s `basename $target` $link
>  	if [ "$?" -ne 0 ]; then
>  		rm -f $target
> -		_notrun "Require symlinks support"
> +		_notrun "No symlink support"
>  	fi
>  	rm -f $target $link
>  }
> diff --git a/tests/generic/005 b/tests/generic/005
> index 118fca20..c49109e9 100755
> --- a/tests/generic/005
> +++ b/tests/generic/005
> @@ -48,7 +48,7 @@ _touch()
>  # real QA test starts here
>  _supported_fs generic
>  _require_test
> -_require_test_symlinks
> +_require_symlinks
>  
>  _supported_os Linux
>  
> diff --git a/tests/generic/023 b/tests/generic/023
> index ea40f3d2..1cfa25cd 100755
> --- a/tests/generic/023
> +++ b/tests/generic/023
> @@ -30,7 +30,7 @@ _supported_os Linux
>  
>  _require_test
>  _require_renameat2
> -_require_test_symlinks
> +_require_symlinks
>  
>  # real QA test starts here
>  
> diff --git a/tests/generic/024 b/tests/generic/024
> index 531a515f..b6ac4182 100755
> --- a/tests/generic/024
> +++ b/tests/generic/024
> @@ -30,7 +30,7 @@ _supported_os Linux
>  
>  _require_test
>  _require_renameat2 noreplace
> -_require_test_symlinks
> +_require_symlinks
>  
>  # real QA test starts here
>  
> diff --git a/tests/generic/025 b/tests/generic/025
> index e69d655f..e0f71375 100755
> --- a/tests/generic/025
> +++ b/tests/generic/025
> @@ -30,7 +30,6 @@ _supported_os Linux
>  
>  _require_test
>  _require_renameat2 exchange
> -_require_test_symlinks

This drops _require_symlinks, in a add/renaming patch...

/me confused.

--D

>  
>  # real QA test starts here
>  
> diff --git a/tests/generic/062 b/tests/generic/062
> index 3fef02e8..ba744885 100755
> --- a/tests/generic/062
> +++ b/tests/generic/062
> @@ -59,6 +59,7 @@ _supported_os Linux
>  
>  _require_scratch
>  _require_attrs
> +_require_symlinks
>  
>  rm -f $tmp.backup1 $tmp.backup2 $seqres.full
>  
> diff --git a/tests/generic/067 b/tests/generic/067
> index bd72dc85..d4c710d2 100755
> --- a/tests/generic/067
> +++ b/tests/generic/067
> @@ -37,7 +37,7 @@ _cleanup()
>  # Modify as appropriate.
>  _supported_fs generic
>  _supported_os Linux
> -_require_test_symlinks
> +_require_symlinks
>  _require_test
>  _require_scratch
>  _require_loop
> diff --git a/tests/generic/078 b/tests/generic/078
> index a421a8ab..ccc5c8d5 100755
> --- a/tests/generic/078
> +++ b/tests/generic/078
> @@ -30,7 +30,6 @@ _supported_os Linux
>  
>  _require_test
>  _require_renameat2 whiteout
> -_require_test_symlinks
>  
>  # real QA test starts here
>  
> diff --git a/tests/generic/109 b/tests/generic/109
> index 8be70c23..549a95b1 100755
> --- a/tests/generic/109
> +++ b/tests/generic/109
> @@ -29,6 +29,7 @@ _cleanup()
>  _supported_fs generic
>  _supported_os Linux
>  _require_scratch
> +_require_symlinks
>  
>  rm -f $seqres.full
>  
> diff --git a/tests/generic/294 b/tests/generic/294
> index b74579ac..32c89b03 100755
> --- a/tests/generic/294
> +++ b/tests/generic/294
> @@ -32,6 +32,7 @@ _cleanup()
>  _supported_fs generic
>  _supported_os Linux
>  _require_scratch
> +_require_symlinks
>  
>  rm -f $seqres.full
>  _scratch_mkfs > $seqres.full 2>&1 || _fail "Could not mkfs scratch device"
> diff --git a/tests/generic/306 b/tests/generic/306
> index 081d1a89..046f4516 100755
> --- a/tests/generic/306
> +++ b/tests/generic/306
> @@ -33,6 +33,7 @@ _supported_fs generic
>  _supported_os Linux
>  _require_scratch
>  _require_test
> +_require_symlinks
>  
>  DEVNULL=$SCRATCH_MNT/devnull
>  DEVZERO=$SCRATCH_MNT/devzero
> diff --git a/tests/generic/348 b/tests/generic/348
> index 630ff160..e0139d9a 100755
> --- a/tests/generic/348
> +++ b/tests/generic/348
> @@ -32,6 +32,7 @@ _cleanup()
>  _supported_fs generic
>  _supported_os Linux
>  _require_scratch
> +_require_symlinks
>  _require_dm_target flakey
>  
>  rm -f $seqres.full
> diff --git a/tests/generic/360 b/tests/generic/360
> index a9a4f2f9..f15548e2 100755
> --- a/tests/generic/360
> +++ b/tests/generic/360
> @@ -31,6 +31,7 @@ rm -f $seqres.full
>  _supported_fs generic
>  _supported_os Linux
>  _require_test
> +_require_symlinks
>  
>  linkfile=$TEST_DIR/$seq.symlink
>  rm -f $linkfile
> diff --git a/tests/generic/397 b/tests/generic/397
> index f2e22950..c2245bd5 100755
> --- a/tests/generic/397
> +++ b/tests/generic/397
> @@ -36,6 +36,7 @@ rm -f $seqres.full
>  # real QA test starts here
>  _supported_fs generic
>  _supported_os Linux
> +_require_symlinks
>  _require_scratch_encryption
>  _require_command "$KEYCTL_PROG" keyctl
>  
> diff --git a/tests/generic/399 b/tests/generic/399
> index a9b3997a..a4013720 100755
> --- a/tests/generic/399
> +++ b/tests/generic/399
> @@ -43,6 +43,7 @@ rm -f $seqres.full
>  _supported_fs generic
>  _supported_os Linux
>  _require_scratch_encryption
> +_require_symlinks
>  _require_command "$XZ_PROG" xz
>  _require_command "$KEYCTL_PROG" keyctl
>  
> diff --git a/tests/generic/401 b/tests/generic/401
> index 9d45fbcd..00e9bbe0 100755
> --- a/tests/generic/401
> +++ b/tests/generic/401
> @@ -37,6 +37,7 @@ _cleanup()
>  _supported_fs generic
>  _supported_os Linux
>  _require_scratch
> +_require_symlinks
>  _require_test_program "t_dir_type"
>  
>  rm -f $seqres.full
> diff --git a/tests/generic/423 b/tests/generic/423
> index b61d5de0..6db55fd6 100755
> --- a/tests/generic/423
> +++ b/tests/generic/423
> @@ -38,6 +38,7 @@ _require_test
>  _require_test_program "stat_test"
>  _require_test_program "af_unix"
>  _require_statx
> +_require_symlinks
>  
>  function check_stat () {
>  	$here/src/stat_test $* || echo stat_test failed
> diff --git a/tests/generic/440 b/tests/generic/440
> index 1ec1ed48..3446c147 100755
> --- a/tests/generic/440
> +++ b/tests/generic/440
> @@ -38,6 +38,7 @@ rm -f $seqres.full
>  _supported_fs generic
>  _supported_os Linux
>  _require_scratch_encryption
> +_require_symlinks
>  _require_command "$KEYCTL_PROG" keyctl
>  
>  # Set up an encryption-capable filesystem and an encryption key.
> diff --git a/tests/generic/479 b/tests/generic/479
> index ad20aaee..aaf864a4 100755
> --- a/tests/generic/479
> +++ b/tests/generic/479
> @@ -32,6 +32,7 @@ _cleanup()
>  _supported_fs generic
>  _supported_os Linux
>  _require_scratch
> +_require_symlinks
>  _require_dm_target flakey
>  
>  rm -f $seqres.full
> diff --git a/tests/generic/556 b/tests/generic/556
> index b7239e34..4899b403 100755
> --- a/tests/generic/556
> +++ b/tests/generic/556
> @@ -19,6 +19,7 @@ _supported_os Linux
>  _supported_fs generic
>  _require_scratch_nocheck
>  _require_scratch_casefold
> +_require_symlinks
>  _require_check_dmesg
>  _require_attrs
>  
> 

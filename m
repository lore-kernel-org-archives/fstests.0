Return-Path: <SRS0=QKYl=AL=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F65CC433DF
	for <linux-fstests@archiver.kernel.org>; Tue, 30 Jun 2020 15:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 297362074F
	for <linux-fstests@archiver.kernel.org>; Tue, 30 Jun 2020 15:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MqxjeqEX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389617AbgF3Psi (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:48:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49832 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389599AbgF3Psh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 30 Jun 2020 11:48:37 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05UFgMnU007060;
        Tue, 30 Jun 2020 15:48:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=H9rS7Ab+9g6cFkwkAfkRWaVLmHibz9KDLQr7KikhjyA=;
 b=MqxjeqEXwKttAJLfyGd9QzHGDVCBfUGKFYeKcwzUKadEXvUe6FVGSIpbNQui15bzSy+Z
 NhpX6m4wIeZENT9YY5lWETulJ+jR0EcVvH3diTY/618fNhxAyLk0OLpvxOkCq0Xon2yC
 y9T7LsfS3WownWLyGv7tDbyycL09JfNK7jRjkHdJn9r52w4e57h7KRvYzkXEp9lVcRBn
 3R40ClosHVPQCksmwqmuAXkI//De/oQe9l2W9H2EUJrWBQTA9jVhloqk34PMS8eDU5FJ
 3OzeXNItk+S/DLu05TKSbMgtS6QwT64pAPgLWhdiSRi6UTN0MywkjX/daDj1oIcdAjsF AQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 31wxrn5b2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Jun 2020 15:48:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05UFgpKw153917;
        Tue, 30 Jun 2020 15:48:22 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 31y52j3bt8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jun 2020 15:48:22 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05UFmKYx004654;
        Tue, 30 Jun 2020 15:48:21 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Jun 2020 15:48:20 +0000
Date:   Tue, 30 Jun 2020 08:48:19 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/516: Use scratch_xfs_get/set_sb_field api
Message-ID: <20200630154819.GD7600@magnolia>
References: <1593498187-21213-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593498187-21213-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9667 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 suspectscore=1 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006300113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9667 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1011
 malwarescore=0 phishscore=0 adultscore=0 cotscore=-2147483648
 lowpriorityscore=0 suspectscore=1 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006300113
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jun 30, 2020 at 02:23:07PM +0800, Yang Xu wrote:
> When using old xfsprogs, this case fails as below:
>     +write: invalid option -- 'd'
> 
> xfs_db write command support -d options since xfsprogs commit
> 86769b32d01 ("xfs_db: allow recalculating CRCs on invalid metadata").
> For avoid invalid error, use scratch_xfs_set_sb_field api instead.
> 
> Also add missing "rm -f $seqres.full" at the beginning of the test.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>

Looks good to me,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  tests/xfs/516 | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/xfs/516 b/tests/xfs/516
> index ca8c0412..3a7afd0e 100755
> --- a/tests/xfs/516
> +++ b/tests/xfs/516
> @@ -22,6 +22,8 @@ _cleanup()
>  	cd /
>  }
>  
> +rm -f $seqres.full
> +
>  # get standard environment, filters and checks
>  . ./common/rc
>  . ./common/fuzzy
> @@ -60,7 +62,8 @@ __test_mount_opts()
>  	else
>  		echo "mount failed" >> $seqres.full
>  	fi
> -	_scratch_xfs_db -c 'sb 0' -c 'p unit width' >> $seqres.full
> +	_scratch_xfs_get_sb_field unit >> $seqres.full
> +	_scratch_xfs_get_sb_field width  >> $seqres.full
>  
>  	# Run xfs_repair in repair mode to see if it can be baited into nuking
>  	# the root filesystem on account of the sunit update.
> @@ -119,9 +122,12 @@ test_repair_detection()
>  	fi
>  
>  	# Update the superblock like the kernel used to do.
> -	_scratch_xfs_db -c 'sb 0' -c 'p unit width' >> $seqres.full
> -	_scratch_xfs_db -x -c 'sb 0' -c 'write -d unit 256' -c 'write -d width 1024' >> $seqres.full
> -	_scratch_xfs_db -c 'sb 0' -c 'p unit width' >> $seqres.full
> +	_scratch_xfs_get_sb_field unit >> $seqres.full
> +	_scratch_xfs_get_sb_field width >> $seqres.full
> +	_scratch_xfs_set_sb_field unit 256 >> $seqres.full
> +	_scratch_xfs_set_sb_field width 1024 >> $seqres.full
> +	_scratch_xfs_get_sb_field unit >> $seqres.full
> +	_scratch_xfs_get_sb_field width >> $seqres.full
>  
>  	# Run xfs_repair in repair mode to see if it can be baited into nuking
>  	# the root filesystem on account of the sunit update.
> -- 
> 2.23.0
> 
> 
> 

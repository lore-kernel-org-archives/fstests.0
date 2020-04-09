Return-Path: <SRS0=x5Yn=5Z=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DC3C2BA19
	for <linux-fstests@archiver.kernel.org>; Thu,  9 Apr 2020 20:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5309320730
	for <linux-fstests@archiver.kernel.org>; Thu,  9 Apr 2020 20:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qt1NBT5t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgDIUtm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 9 Apr 2020 16:49:42 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45100 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgDIUtm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 9 Apr 2020 16:49:42 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 039KnaPI060374;
        Thu, 9 Apr 2020 20:49:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Ol4q/uMWoelMJkGxNl+YzavftbJiJHSyuSPXg5Hkrec=;
 b=Qt1NBT5tnDufcfbN3nJzANDbhIoUMSHkoXKmJdN735apTLaObmuMMUdiiCZsEvnPnBXG
 bvyHvjz+SJ2cfKP7aytCapuYbnTwdHceYDuVk6p7bYRx18zmclYjAV+ycwwS4hkF9Vap
 Cm/tZP/DiRWeQMF0QsZCfBF4r4nKQ2Zjv9BPEjrO+PW/tJHWQwMWPwy/vEycWfAyQznn
 Qxdj5rvZZkvax85g138grpDJ3eA5T2Ha28en9M+rP1QCuhUmQHF7u7/eV6xaX4VUVE3J
 A9q/hHHHI4Sp2QwefPpsoUG4r55AC0tA+ZmhhnHhgHB7KxNkkaTqCZuu8yXcaLGoIT8l tA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 3091m13rtu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Apr 2020 20:49:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 039KlSvk107794;
        Thu, 9 Apr 2020 20:49:35 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 3091m56eh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Apr 2020 20:49:35 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 039KnYfU025837;
        Thu, 9 Apr 2020 20:49:34 GMT
Received: from localhost (/10.159.243.40)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 Apr 2020 13:49:34 -0700
Date:   Thu, 9 Apr 2020 13:49:33 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     fstests <fstests@vger.kernel.org>,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: Re: [PATCH] fstests: test for fallocate capability in more tests
Message-ID: <20200409204933.GF6740@magnolia>
References: <8202d5fd-041f-455c-e306-4244216d305d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8202d5fd-041f-455c-e306-4244216d305d@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9586 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=953 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004090146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9586 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004090146
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Apr 09, 2020 at 03:06:28PM -0500, Eric Sandeen wrote:
> These 3 tests explicitly call xfs_io's fallocate command, test whether
> it works before running the test.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
> 
> diff --git a/tests/generic/286 b/tests/generic/286
> index 00cb87b7..8be4fbc9 100755
> --- a/tests/generic/286
> +++ b/tests/generic/286
> @@ -23,6 +23,7 @@ _supported_fs generic
>  _supported_os Linux
>  
>  _require_test
> +_require_xfs_io_command "falloc"
>  _require_seek_data_hole
>  
>  src=$TEST_DIR/seek_copy_testfile
> diff --git a/tests/generic/404 b/tests/generic/404
> index 14decdb7..69d7e71e 100755
> --- a/tests/generic/404
> +++ b/tests/generic/404
> @@ -76,6 +76,7 @@ rm -f $seqres.full
>  _supported_fs generic
>  _supported_os Linux
>  _require_test
> +_require_xfs_io_command "falloc"
>  _require_xfs_io_command "finsert"
>  
>  blksize=`_get_block_size $TEST_DIR`
> diff --git a/tests/generic/569 b/tests/generic/569
> index 4573be5a..385fa59f 100755
> --- a/tests/generic/569
> +++ b/tests/generic/569
> @@ -29,6 +29,7 @@ _cleanup()
>  # real QA test starts here
>  _supported_os Linux
>  _supported_fs generic
> +_require_xfs_io_command "falloc"
>  _require_test_program swapon
>  _require_scratch_swapfile
>  
> 

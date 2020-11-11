Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AA4C388F7
	for <linux-fstests@archiver.kernel.org>; Wed, 11 Nov 2020 00:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C61DC21D46
	for <linux-fstests@archiver.kernel.org>; Wed, 11 Nov 2020 00:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="avzBIoqY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731610AbgKKAmZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 10 Nov 2020 19:42:25 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33820 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgKKAmY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 10 Nov 2020 19:42:24 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AB0ZaiL016919;
        Wed, 11 Nov 2020 00:42:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=8FdlbUTfQwS4F3X5zJCDbAlIq1mCzzrdeT5kaRsU8Vc=;
 b=avzBIoqYbbJiVdZho+puupmOmz0XP6mBg/o18LiJE08EEqx9uTOjCq+4sZv5NKnz2tdl
 eQV0WiuKx/jzyQrYaOQHV+Ho1e1o9jQZlj8J6x1B5QzF1lKIEyI6ByIXW0/ivI1Arlax
 otREwQiFb1tbsqTe7rRud+pAlhWFKkgb0gwNOU55bjNpcrfEDAFf/CzkJaT2vdNACvMI
 +QP+KojCjUyhSEGniyt0b9meHQOplrIm80uQTumETDmn3mlH1et5iyAdIr5f5DFhiQtZ
 r6CuLGoSfGA6T3sQfCPsHIOmK7T+XECureUvaxwzIYS9DEotTea4Kp9mSyWQpcdTmvJJ 4w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 34p72emv2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Nov 2020 00:42:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AB0UB2I097782;
        Wed, 11 Nov 2020 00:42:18 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 34p5gxq5yk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Nov 2020 00:42:18 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AB0gHuE028430;
        Wed, 11 Nov 2020 00:42:17 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Nov 2020 16:42:17 -0800
Date:   Tue, 10 Nov 2020 16:42:16 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/426: Remove unused opt variable in
 create_test_files()
Message-ID: <20201111004216.GA9688@magnolia>
References: <20201110022526.7149-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110022526.7149-1-yangx.jy@cn.fujitsu.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9801 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011110001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9801 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=1 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011110001
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Nov 10, 2020 at 10:25:26AM +0800, Xiao Yang wrote:
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  tests/generic/426 | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tests/generic/426 b/tests/generic/426
> index e34d0aca..0bb75f81 100755
> --- a/tests/generic/426
> +++ b/tests/generic/426
> @@ -43,7 +43,6 @@ mkdir -p $testdir
>  create_test_files()
>  {
>  	local dir=$1
> -	local opt=$2
>  
>  	mkdir -p $dir
>  	rm -f $dir/*
> -- 
> 2.21.0
> 
> 
> 

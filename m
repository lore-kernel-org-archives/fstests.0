Return-Path: <SRS0=fS5H=D2=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2361C433E7
	for <linux-fstests@archiver.kernel.org>; Mon, 19 Oct 2020 16:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D39A2225F
	for <linux-fstests@archiver.kernel.org>; Mon, 19 Oct 2020 16:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SpuiPv4w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbgJSQF5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 19 Oct 2020 12:05:57 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39580 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730190AbgJSQF5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 19 Oct 2020 12:05:57 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09JFwbhI132133;
        Mon, 19 Oct 2020 16:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=sSeyybJcdO8r0zkxrH2XgI/vpPtDL/luyLRbJpu8EdA=;
 b=SpuiPv4wsPvYG4fNrLry3YN0tVqNb0kzYb7AOcIunvZcO5V08oYOX616n2mDN0db3kd8
 21AZrOlo5GUp+igqMagdRYV6dwcTgG9WMQiiRnuP5aHg1zDHsHg4vyUzWbUbgcOAbIh9
 X18ucPWprZ7CS+Q/nAyqlIVy4aUJ75xvSwv7SynZAN2wScAjBul692thoicqyjHVNx2O
 VwlRWpqMXwDlB4EwvDrNDiXaCEbKV20aj/GxDHWiZcWZClil/JrgYhDo0UDuKHrauxi+
 229qwjKFJqta74FgFA0fB1G8Ocwtppx79GDG+GPPn+hKmgNCgz7Kww+FcBBWRWupL/ol QA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 347rjkpb9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Oct 2020 16:05:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09JG0rcU158384;
        Mon, 19 Oct 2020 16:03:42 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 348ahv4qbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Oct 2020 16:03:42 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09JG3ebL005774;
        Mon, 19 Oct 2020 16:03:40 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 19 Oct 2020 09:03:39 -0700
Date:   Mon, 19 Oct 2020 09:03:38 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc:     guaneryu@gmail.com, fstests@vger.kernel.org
Subject: Re: [PATCH v2] generic/402: Drop useless fail message
Message-ID: <20201019160338.GC9830@magnolia>
References: <20201018101058.GY3853@desktop>
 <1603076519-14005-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603076519-14005-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9778 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010190110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9778 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=1 clxscore=1015 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010190110
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Oct 19, 2020 at 11:01:59AM +0800, Yang Xu wrote:
> Here won't be "scratch mount failed" messages when mounting SCRATCH_DEV
> failed, because _scratch_mount exits early by invoking the following_fail.
> 
> _scratch_mount
> {
>         _try_scratch_mount $* || _fail "mount failed"
> }
> 
> The message is useless and redundant. So drop it.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---

Looks good to me,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

>  tests/generic/402 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/402 b/tests/generic/402
> index 7fc81864..ddaadf6d 100755
> --- a/tests/generic/402
> +++ b/tests/generic/402
> @@ -102,7 +102,7 @@ run_test()
>  }
>  
>  _scratch_mkfs &>> $seqres.full 2>&1 || _fail "mkfs failed"
> -_scratch_mount || _fail "scratch mount failed"
> +_scratch_mount
>  
>  _require_timestamp_range $SCRATCH_DEV
>  
> -- 
> 2.23.0
> 
> 
> 

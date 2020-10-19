Return-Path: <SRS0=fS5H=D2=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D9DC433DF
	for <linux-fstests@archiver.kernel.org>; Mon, 19 Oct 2020 16:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19F082225F
	for <linux-fstests@archiver.kernel.org>; Mon, 19 Oct 2020 16:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RyrVNaoC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbgJSQES (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 19 Oct 2020 12:04:18 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38136 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730335AbgJSQES (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 19 Oct 2020 12:04:18 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09JFwfrS132158;
        Mon, 19 Oct 2020 16:04:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=+h81mRJUI10vqJbcTm0nFt6/KbVIYe30yoW9llYdig0=;
 b=RyrVNaoCM1Jfa/xjT6vdnGpudHhweKcgKIm8YOfkQ0i+93x4JMWytMmRXI5Or8CDIQaY
 SAtKIK5uNufLT8+vKLFe6muPxDuNJ74xWF0bJHkVuF0fseDi2gItK0oK0wyrmQnIt7VN
 wYBL2YArHrzlpsUDHjl9+KwS6ERPGPybVSDfdkK+W/u9IFHSb5XcL8DAhbhUWl3ZRptC
 b7EvK6/QOj5ponMHvpLieyXJ6/B8JC6NTwRl5ZbnOEBB5n0nGDpOMu+jNSZXCMnhY4gK
 FPzBK1lZmyWPlOYN5tJqT7lI8wvD5cfulCtzB1FFFhio9LywP4MzzPry1zOr8xgvfj7S Kw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 347rjkpb23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Oct 2020 16:04:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09JG1Ykj074243;
        Mon, 19 Oct 2020 16:04:11 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 348agwajua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Oct 2020 16:04:10 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09JG4ARs028187;
        Mon, 19 Oct 2020 16:04:10 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 19 Oct 2020 09:04:10 -0700
Date:   Mon, 19 Oct 2020 09:04:08 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] Fix generic/127 to exit if any subtest fails
Message-ID: <20201019160408.GD9830@magnolia>
References: <20201019125839.GQ20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019125839.GQ20115@casper.infradead.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9778 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=1 bulkscore=0 mlxlogscore=999
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

On Mon, Oct 19, 2020 at 01:58:39PM +0100, Matthew Wilcox wrote:
> 
> If one of the subtests of generic/127 fails, we proceed with the rest of
> the tests, potentially overwriting useful data.  This makes it stop as
> soon as any of the subtests fails.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Yayyyyyyy
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> 
> diff --git a/tests/generic/127 b/tests/generic/127
> index dedd8bbf..d4b2cc38 100755
> --- a/tests/generic/127
> +++ b/tests/generic/127
> @@ -90,16 +90,16 @@ _supported_fs generic
>  _supported_os Linux
>  _require_test
>  
> -_fsx_lite_nommap
> -_fsx_lite_mmap
> +_fsx_lite_nommap || exit
> +_fsx_lite_mmap || exit
>  
> -_fsx_std_nommap
> -_fsx_std_mmap
> +_fsx_std_nommap || exit
> +_fsx_std_mmap || exit
>  
>  #flush cache after write
>  FSX_ARGS="-f $FSX_ARGS"
> -_fsx_std_nommap
> -_fsx_std_mmap
> +_fsx_std_nommap || exit
> +_fsx_std_mmap || exit
>  
>  status=0
>  _cleanup
> 

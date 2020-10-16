Return-Path: <SRS0=RNsM=DX=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BA0C433E7
	for <linux-fstests@archiver.kernel.org>; Fri, 16 Oct 2020 15:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE15A207C4
	for <linux-fstests@archiver.kernel.org>; Fri, 16 Oct 2020 15:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="y3Eg6AP9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410117AbgJPPdf (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 16 Oct 2020 11:33:35 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:51668 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410112AbgJPPde (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 16 Oct 2020 11:33:34 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09GFKjFN010691;
        Fri, 16 Oct 2020 15:33:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=KDP4g9mEjfRvXEbgXY9Bs5sPFmeFyk1teVET6zt/UIU=;
 b=y3Eg6AP9VtWYUkFGkKXnELa3ZeXm91ESlo9SMeMXbSthNdI6+0g4JX+eh+m4Bgt5Iku0
 VicumxGhVUznmU7n/ntf6Jd3gAXLH12RKmylQdXXz8T5ZolHVJgffyjW/UyJdmBBt4EY
 h18lyDzYEfU1anIduUTmMAvj/+LXDSQzvykL7loZKIYV++XewBUimd+C+Tpr7hlmEAtH
 2kxNVkd7WoK4bkY7WN0uT7XYTZNu9gbGZ7DNWwBpJ6LQuHf54eTJyuG+plrOEa3WPert
 f7lMMs5M3LgQUqsrBwLg3UnkmmGwmv2tfX5OCys7fX+eyE6LEf8jfZdgV5F3PL2onbbI 0Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 346g8gqj92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Oct 2020 15:33:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09GFJffL177308;
        Fri, 16 Oct 2020 15:33:23 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 344by6sqjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Oct 2020 15:33:23 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09GFXLXa026252;
        Fri, 16 Oct 2020 15:33:21 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 16 Oct 2020 08:33:21 -0700
Date:   Fri, 16 Oct 2020 08:33:21 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc:     guaneryu@gmail.com, fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] generic/402: use _try_scratch_mount instead of
 _scratch_mount
Message-ID: <20201016153321.GB9830@magnolia>
References: <1602840684-25524-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1602840684-25524-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602840684-25524-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9776 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=1 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010160117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9776 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 suspectscore=1
 priorityscore=1501 phishscore=0 clxscore=1011 spamscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010160117
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Oct 16, 2020 at 05:31:24PM +0800, Yang Xu wrote:
> Here will check the return code of mount option. So update it
> to use _try_scratch_mount
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>  tests/generic/402 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/402 b/tests/generic/402
> index 7fc81864..4c940ac4 100755
> --- a/tests/generic/402
> +++ b/tests/generic/402
> @@ -102,7 +102,7 @@ run_test()
>  }
>  
>  _scratch_mkfs &>> $seqres.full 2>&1 || _fail "mkfs failed"
> -_scratch_mount || _fail "scratch mount failed"
> +_try_scratch_mount || _fail "scratch mount failed"

Why not just drop the "|| _fail" part?  The message isn't much
more specific than the fail message that _scratch_mount emits.

--D

>  
>  _require_timestamp_range $SCRATCH_DEV
>  
> -- 
> 2.23.0
> 
> 
> 

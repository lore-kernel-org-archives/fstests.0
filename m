Return-Path: <SRS0=IIXw=AY=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD8DC433DF
	for <linux-fstests@archiver.kernel.org>; Mon, 13 Jul 2020 16:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 850DF206F5
	for <linux-fstests@archiver.kernel.org>; Mon, 13 Jul 2020 16:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xX40pvxM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbgGMQqQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 13 Jul 2020 12:46:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53428 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729855AbgGMQqP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 13 Jul 2020 12:46:15 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06DGM1eo177415;
        Mon, 13 Jul 2020 16:46:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=XOmZlryJvn0aTQ3GkAhWv3o9MyWP20f8JRun0IvH3w0=;
 b=xX40pvxMjvvCi3Ywt3x58kqwYokVxG7ab2ykfTwLi9MwqCrh0FEmx/bQr9OOFq4Vi0xb
 tHQvZsk7IEf8bGcIbV5/mJFjBWbCT35QnX44q5zv+wqQI7lbCnXzYkLcxqcsrON3SyDp
 DUhTRrUYzgJnrdEQYUYCmujCXZBQ3Qe5KXamObueCXG5397BOQjI/8rEmBN3wSEmEYNI
 XnCPjZRCiiiCLlfUWbTsgc2nOQLoptre1S8qqlxNr0TkXY0f4VCf8FQIzeGdTm+rbfir
 tbu6K/Xi55g5SOY7ekG0uUtY/a5MYTz6JNU0YSHVVxvXW6EFcp19K913BPR3m1Tn7Ezp Lw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 3274ur07h8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Jul 2020 16:46:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06DGNVAF024381;
        Mon, 13 Jul 2020 16:46:00 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 327qb146q1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jul 2020 16:46:00 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06DGjtqC000848;
        Mon, 13 Jul 2020 16:45:56 GMT
Received: from localhost (/10.159.128.100)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Jul 2020 09:45:55 -0700
Date:   Mon, 13 Jul 2020 09:45:54 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Vladimir Zapolskiy <vladimir@tuxera.com>
Cc:     Eryu Guan <guaneryu@gmail.com>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic: assign a number of tests to attr group
Message-ID: <20200713164554.GI7600@magnolia>
References: <20200713122628.16781-1-vladimir@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713122628.16781-1-vladimir@tuxera.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9681 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 spamscore=0 phishscore=0 suspectscore=1 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007130120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9681 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 suspectscore=1 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007130120
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jul 13, 2020 at 03:26:28PM +0300, Vladimir Zapolskiy wrote:
> A few generic tests have a _require_attrs runtime check for support
> of extended file attributes by a tested filesystem, review shows that
> the tests listed below are definitely using extended file attributes,
> thus this implies that the tested filesystem should provide support of
> the feature in general.
> 
> Adding the tests explicitly to attr group of tests allows to get a better
> granularity of selecting or deselecting tests by groups in accordance to
> extended file attributes feature given by a filesystem, the change affects
> the next list of tests:
> 
>   * generic/037
>   * generic/066
>   * generic/103
>   * generic/337
>   * generic/449

Aha! I had long suspected the attr group was missing a few tests...

> Signed-off-by: Vladimir Zapolskiy <vladimir@tuxera.com>

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  tests/generic/group | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/generic/group b/tests/generic/group
> index 3d7effe6d72a..a09c81a09abc 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -39,7 +39,7 @@
>  034 auto quick metadata log
>  035 auto quick
>  036 auto aio rw stress
> -037 metadata auto quick
> +037 auto quick attr metadata
>  038 auto stress
>  039 metadata auto quick log
>  040 metadata auto quick log
> @@ -68,7 +68,7 @@
>  063 auto quick prealloc punch insert
>  064 auto quick prealloc collapse insert
>  065 metadata auto quick log
> -066 metadata auto quick log
> +066 auto quick attr metadata log
>  067 auto quick mount
>  068 other auto freeze stress
>  069 rw udf auto quick
> @@ -105,7 +105,7 @@
>  100 udf auto
>  101 auto quick metadata log
>  102 auto rw
> -103 auto enospc quick
> +103 auto quick attr enospc
>  104 auto quick metadata log
>  105 acl auto quick
>  106 auto quick metadata log
> @@ -339,7 +339,7 @@
>  334 auto clone
>  335 auto quick metadata log
>  336 auto quick metadata log
> -337 auto quick metadata
> +337 auto quick attr metadata
>  338 auto quick rw eio
>  339 auto dir
>  340 auto
> @@ -451,7 +451,7 @@
>  446 auto quick rw punch
>  447 auto clone
>  448 auto quick rw seek
> -449 auto quick acl enospc
> +449 auto quick acl attr enospc
>  450 auto quick rw
>  451 auto quick rw aio
>  452 auto quick dax
> -- 
> 2.25.1
> 

Return-Path: <SRS0=I7qB=ZT=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192D4C432C0
	for <linux-fstests@archiver.kernel.org>; Wed, 27 Nov 2019 16:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF4202075C
	for <linux-fstests@archiver.kernel.org>; Wed, 27 Nov 2019 16:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NAsvaGr6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfK0Qbn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 27 Nov 2019 11:31:43 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57960 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfK0Qbn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Nov 2019 11:31:43 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xARG9s4O117655;
        Wed, 27 Nov 2019 16:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=HvxLWT5muTL/vuLkHbCXsrnrj6XAVF3YGOLOz97tRtI=;
 b=NAsvaGr6sSIEoWsIr8NWQjTk8i9tvLvHBDDQndkFEs1VljSejvQuEjZE7Qh6cNUWcOZ3
 kfJZj419itGOM5gUnScTBZXpMP/wxyfb5jcyUcBZNa9hqH7YP1zxdQcNyD4TaKEJAFFl
 /Ko9YMWzPw1B5DtTA6V/lvoe3ZdTYaGSxvhl6SY5aWREXIvaliF5RWsTxAxvDDK/p740
 rGoahmnz7zepfPIRCG+pbVry1RKJCr51rfdMv8ZYPmYew/yJRJFqOEcueHbNkfHM3lpB
 V+e+XTmIIA+MU5I9Rvy6uh+jlCItWT+zRy0RRCw5xslEwWCqVpUSFZfcx26Q0PdtSz8m ug== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2wev6uepx6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Nov 2019 16:31:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xARGEXbv122901;
        Wed, 27 Nov 2019 16:31:38 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2whrkrnjw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Nov 2019 16:31:38 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xARGVbkR004695;
        Wed, 27 Nov 2019 16:31:37 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 Nov 2019 08:31:37 -0800
Date:   Wed, 27 Nov 2019 08:31:36 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Baihua Lu <lubaihua0331@gmail.com>
Cc:     fstests@vger.kernel.org, guaneryu@gmail.com, balu@microsoft.com,
        Lili.Deng@microsoft.com
Subject: Re: [PATCH] xfs/191-input-validation:Fix issue that the test takes
 too long
Message-ID: <20191127163136.GK6212@magnolia>
References: <20191127104131.112533-1-lubaihua0331@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127104131.112533-1-lubaihua0331@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9454 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911270139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9454 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911270139
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Nov 27, 2019 at 02:41:31AM -0800, Baihua Lu wrote:
> After this test is passed, checking filesystems will execute. Then
> xfs_logprint will be failed and xfs_repair will take a long time because
> there is not really creating the file system in this test and wipefs
> executes before this test. So there is no need checking filesystems.
> 
> Signed-off-by: Baihua Lu <lubaihua0331@gmail.com>

Ok, looks fine.
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  tests/xfs/191-input-validation | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/191-input-validation b/tests/xfs/191-input-validation
> index b6658015..db427349 100755
> --- a/tests/xfs/191-input-validation
> +++ b/tests/xfs/191-input-validation
> @@ -31,7 +31,7 @@ _cleanup()
>  # Modify as appropriate.
>  _supported_fs xfs
>  _supported_os Linux
> -_require_scratch
> +_require_scratch_nocheck
>  _require_xfs_mkfs_validation
>  
>  
> -- 
> 2.17.1
> 

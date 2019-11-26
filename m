Return-Path: <SRS0=JLeR=ZS=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E75FC432C0
	for <linux-fstests@archiver.kernel.org>; Tue, 26 Nov 2019 15:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407652071E
	for <linux-fstests@archiver.kernel.org>; Tue, 26 Nov 2019 15:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K4al13Tp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfKZPgq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 26 Nov 2019 10:36:46 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42258 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfKZPgq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 26 Nov 2019 10:36:46 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAQFUtxl083096;
        Tue, 26 Nov 2019 15:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=nQrzxt8z8FhskyucCvdwFSi1ubqxp+ADg7k5tv76hxs=;
 b=K4al13Tpe9NsTx8npExp3iZUx8keo4T/KQZqyYuS72ZwVgiP+PpzeXp8pHnDJK6yAlgQ
 LBW4TMx0KJcHbjTjfn4u1MeWe0A+UuYShWhT7vZt6pckbl3GFv3zK2XNU1w1O1dhHBmY
 KHrjIDtU0DeCsi1q+0tie7F76qaE1yKjduBnP8hTSW39zjtgGv0kiZZzkcBBgCcm05N9
 ipGwAFF0YfIbDGzPz4XYcKvEsm4wftdgnZ4yE3cMVN5RMAmqf3Jlh90xZ7fMlWZYXkj1
 AQ6Io18jof6Qnv3Z1k8UIgyMoC3V7yS+7MnoD/sPh9qzyOp60Tr3Z4MFYcuBbjucpamj Fw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2wewdr7hm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Nov 2019 15:36:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAQFUrij166011;
        Tue, 26 Nov 2019 15:36:40 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2wh0rcbsa5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Nov 2019 15:36:40 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAQFadQe019432;
        Tue, 26 Nov 2019 15:36:39 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Nov 2019 07:36:38 -0800
Date:   Tue, 26 Nov 2019 07:36:37 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Baihua Lu <lubaihua0331@gmail.com>
Cc:     fstests@vger.kernel.org, guaneryu@gmail.com, balu@microsoft.com,
        Lili.Deng@microsoft.com
Subject: Re: [PATCH] xfs/191-input-validation:Fix issue that the test takes
 too long
Message-ID: <20191126153637.GF6212@magnolia>
References: <20191126052336.98489-1-lubaihua0331@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126052336.98489-1-lubaihua0331@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9453 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911260134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9453 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911260134
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Nov 26, 2019 at 05:23:36AM +0000, Baihua Lu wrote:
> In this test, we don't need to check filesystem on the scratch device for there is not
> really creating the file system. If _check_filesystems executes, xfs_logprint will be
> failed for having dirty log and xfs_repaire will take a long time.

Where did the dirty log come from if we didn't actually format anything?
I thought I had taught fstests to wipefs the scratch device between
each test...

(No objections to the diff itself, I'm simply curious about the commit
message.)

--D

> 
> Signed-off-by: Baihua Lu <lubaihua0331@gmail.com>
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

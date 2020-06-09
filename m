Return-Path: <SRS0=3iZY=7W=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C156CC433DF
	for <linux-fstests@archiver.kernel.org>; Tue,  9 Jun 2020 16:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B0602078C
	for <linux-fstests@archiver.kernel.org>; Tue,  9 Jun 2020 16:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gBNVGtdF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731099AbgFIQKq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 9 Jun 2020 12:10:46 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39942 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731016AbgFIQKp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 9 Jun 2020 12:10:45 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 059G6mi1110656;
        Tue, 9 Jun 2020 16:10:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=EQzHyOQHuujjeJlrMFeHtCXPXxEW3LALerYL8/OKrrA=;
 b=gBNVGtdFnkJhNi/vpM45c1agkCoV72RA8dqqi18os7EpCiYW78Tn1bKovKDzu/xjfkCb
 avNM06b0V5CQ1ZMfqBUdAjuLag3tH9szsuqnpbm8yoFsIu1P6CFAPfY85XKRI8ttb4YD
 pOLLzKFZBz9iJYUcu01CZwtOoWWcvCJIblpB/XborTdePbzmY07Lx6EbEiUBGHm0wlBs
 2ZL+0uVzQuGNONySFULL9fBqi3EUlDMgAwm0i9Tiu7RSvM6OIf8epFkoi+349t6GQbLu
 vZqUNwGXGNan7kWxeyZpdTh+jdsACnv5lz8jis4m5f/6uySsEfo/HVTxZoIg4w/ISN9L Vw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 31g33m5qnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 09 Jun 2020 16:10:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 059G8O4f177048;
        Tue, 9 Jun 2020 16:10:41 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 31gmwrmb11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Jun 2020 16:10:41 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 059GAesW027142;
        Tue, 9 Jun 2020 16:10:40 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Jun 2020 09:10:40 -0700
Date:   Tue, 9 Jun 2020 09:10:39 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/096: filter out the "Discarding..." output
Message-ID: <20200609161039.GA11242@magnolia>
References: <20200609082442.31982-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609082442.31982-1-zlang@redhat.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9647 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006090122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9647 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 adultscore=0 spamscore=0
 cotscore=-2147483648 malwarescore=0 phishscore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006090122
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jun 09, 2020 at 04:24:42PM +0800, Zorro Lang wrote:
> Latest xfsprogs mkfs.xfs prints "Discarding blocks...Done" if the
> disk supports the trim. That breaks the golden image, cause
> unexpected failure, so filter out it.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>

Seems reasonable to me...
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  tests/xfs/096 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/xfs/096 b/tests/xfs/096
> index ef6136af..04bc7b7d 100755
> --- a/tests/xfs/096
> +++ b/tests/xfs/096
> @@ -78,6 +78,7 @@ mkfs_filter()
>  	-e 's/ ftype=[01]//' \
>  	-e '/^log stripe unit.*too large/d' \
>  	-e '/^log stripe unit adjusted/d' \
> +	-e '/Discarding/d' \
>     | grep -v parent
>  }
>  
> -- 
> 2.20.1
> 

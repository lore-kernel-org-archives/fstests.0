Return-Path: <SRS0=RNsM=DX=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0823FC433E7
	for <linux-fstests@archiver.kernel.org>; Fri, 16 Oct 2020 15:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9507720866
	for <linux-fstests@archiver.kernel.org>; Fri, 16 Oct 2020 15:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cP90bNpd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408149AbgJPPeb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 16 Oct 2020 11:34:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43868 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407440AbgJPPeb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 16 Oct 2020 11:34:31 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09GFKUC0096938;
        Fri, 16 Oct 2020 15:34:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=vuMJ/haTps+p/qvkKLKkhByzj9GpoBczjEv+dNf+rwI=;
 b=cP90bNpdDG/co4FPXIjM3tcOtped308f7u0SOLZ6T63wDMGK6PNBlhXcrBsqNyA4BDmw
 BKge5qkJonUbDBbALEV1rq6DXl1nZEimMCkMBPY+b6ryLodMOcK3ET7zHieFVI/qiQb9
 VkdwxEgxMXzkN63STC/c5hh+FgWzJe75SnRQcpGLwKdcUKqw5CJJqOx7Tk+gXhXSJ012
 rs4KiMLjA0QyMy/GNpUHjmyjJuwgQPI9VJV06fJ9g7jti7sZ8ljg9j8+QctF7ZEdK6eK
 SHFcvxy+b3X/k66XHheO/qfPoBiIiXhQi5I5ZaVqSetkxBMqUDNmJP9zuL1evGZo3sNN jw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 3434wm2cyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Oct 2020 15:34:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09GFFOej035032;
        Fri, 16 Oct 2020 15:32:11 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 343pv3cth9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Oct 2020 15:32:11 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09GFWAEC000352;
        Fri, 16 Oct 2020 15:32:10 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 16 Oct 2020 08:32:10 -0700
Date:   Fri, 16 Oct 2020 08:32:10 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc:     guaneryu@gmail.com, fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] xfs/521: use _try_scratch_mount instead of
 _scratch_mount
Message-ID: <20201016153210.GA9830@magnolia>
References: <1602840684-25524-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602840684-25524-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9776 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=1 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010160116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9776 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=1 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010160117
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Oct 16, 2020 at 05:31:23PM +0800, Yang Xu wrote:
> Here will check the return code of mount option. So update it
> to use _try_scratch_mount.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>

Looks good to me,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  tests/xfs/521 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/521 b/tests/xfs/521
> index 3aaa1296..e6c417b8 100755
> --- a/tests/xfs/521
> +++ b/tests/xfs/521
> @@ -49,7 +49,7 @@ echo "Format and mount 100m rt volume"
>  export USE_EXTERNAL=yes
>  export SCRATCH_RTDEV=$rtdev
>  _scratch_mkfs -r size=100m > $seqres.full
> -_scratch_mount || _notrun "Could not mount scratch with synthetic rt volume"
> +_try_scratch_mount || _notrun "Could not mount scratch with synthetic rt volume"
>  
>  testdir=$SCRATCH_MNT/test-$seq
>  mkdir $testdir
> -- 
> 2.23.0
> 
> 
> 

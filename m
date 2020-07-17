Return-Path: <SRS0=NoLx=A4=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBD0C433E0
	for <linux-fstests@archiver.kernel.org>; Fri, 17 Jul 2020 15:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24066204EA
	for <linux-fstests@archiver.kernel.org>; Fri, 17 Jul 2020 15:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GdeHovjZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgGQP47 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 17 Jul 2020 11:56:59 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34482 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgGQP47 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 17 Jul 2020 11:56:59 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06HFWGBL044543;
        Fri, 17 Jul 2020 15:56:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=hFcLP+wJTWhNHjZ1KSpHeel3+ellWfa+PzBT74nvFlI=;
 b=GdeHovjZx336KW946FmnYdCu94xOesRQSJ+d+aP+pSV9yUa4uFD4agJKzAsg1ZWnB6oT
 Mn3CDHwutWO0hyF3hqE3ksfWQQgIDr1wjJDdmi3ezz9LBJY+jBGMXIZaSGFK5nduTdz6
 dDM4V3vWzyPPoTfEDOKtg68NfqRgmAQREJKgniHoCTIqr/EBPdmv92X+G5utJ3sm5YCA
 loKHVt8ll7AM9JVCxZzSEATHh8KWQg/rajR62IKL7XYPfaprZWwlJXrwqNQ1Lus3dTUb
 dZVfjqaiGuVyxsddyY8DnPHJuU6/7GMk/kAchMqq8s9EV0Zd2O0/3Cn7eKWe3y79VP8m RA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 3274urr48e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jul 2020 15:56:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06HFXtwG161226;
        Fri, 17 Jul 2020 15:56:52 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 32bbk0kuwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jul 2020 15:56:52 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06HFupMd007767;
        Fri, 17 Jul 2020 15:56:51 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 17 Jul 2020 08:56:51 -0700
Date:   Fri, 17 Jul 2020 08:56:50 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Vladimir Zapolskiy <vladimir@tuxera.com>
Cc:     Eryu Guan <guaneryu@gmail.com>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/587: associate the test with quota test group
Message-ID: <20200717155650.GN7625@magnolia>
References: <20200717110936.24602-1-vladimir@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717110936.24602-1-vladimir@tuxera.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9685 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 mlxscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007170114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9685 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 suspectscore=1 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007170114
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jul 17, 2020 at 02:09:36PM +0300, Vladimir Zapolskiy wrote:
> The test checks regressions on quota accounting and therefore it relies
> on quota support by a tested filesystem, this makes it reasonable to
> include the test into 'quota' test group for better managing of test
> groups.
> 
> Signed-off-by: Vladimir Zapolskiy <vladimir@tuxera.com>

Oops, sorry I forgot that.
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  tests/generic/group | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/group b/tests/generic/group
> index 0797cc9984c1..23f9cfdc7fcb 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -589,7 +589,7 @@
>  584 auto quick encrypt
>  585 auto rename
>  586 auto quick rw prealloc
> -587 auto quick rw prealloc
> +587 auto quick rw prealloc quota
>  588 auto quick log clone
>  589 auto mount
>  590 auto prealloc preallocrw
> -- 
> 2.25.1
> 

Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29773C4167B
	for <linux-fstests@archiver.kernel.org>; Tue,  8 Dec 2020 18:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBAFC23B4B
	for <linux-fstests@archiver.kernel.org>; Tue,  8 Dec 2020 18:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbgLHS1M (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 8 Dec 2020 13:27:12 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:57546 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730488AbgLHS1L (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 8 Dec 2020 13:27:11 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8IDgmO179662;
        Tue, 8 Dec 2020 18:26:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=R+mh3oLGYDYEAl2rziUpIENEVc3THC8kzhreSjPrIWM=;
 b=a/v9MIcC0yn8AiIcNh5t9or3DT2ZDqFI53gMENrDZVOtRH6RB4Rn6w8okwg/McKP/BLc
 F6IKvj7ZwoM4F80/UKr5nlxrDgBB4KITmJfnDkJ9viSZR3FIfeevP/0AB9DTY2n1uB0Z
 o+RU4GISSkC0nuDlZBe1/mkXzphMeWyElzhAyvP+awp/x3LBv8gAwMMegxICNW2jtvRe
 0szr7/Vb7bRrrdMxzgTmI1XjCQUQOaiqvEm6Akx8Rnt0PZAIiA10EodFXMETjGd/FHOm
 1yba9T6YemlKgQcZyrUhiLaumztvmRYMKQKoaTppXwvBSXGhgbf7ucYToDtrQ6Lnh+mI jw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 357yqbvdg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 08 Dec 2020 18:26:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8IEllt031308;
        Tue, 8 Dec 2020 18:24:25 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 358ksny7hk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Dec 2020 18:24:25 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B8IOOQh016906;
        Tue, 8 Dec 2020 18:24:24 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Dec 2020 10:24:24 -0800
Date:   Tue, 8 Dec 2020 10:24:23 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     guaneryu@gmail.com, fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] src/dmiperf: Stop using attr_setf
Message-ID: <20201208182423.GI106271@magnolia>
References: <20201208064005.1187031-1-yangx.jy@cn.fujitsu.com>
 <20201208064005.1187031-2-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208064005.1187031-2-yangx.jy@cn.fujitsu.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=1
 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 mlxlogscore=999
 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080113
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Dec 08, 2020 at 02:40:05PM +0800, Xiao Yang wrote:
> Avoid the following warning by replacing deprecated
> attr_setf with fsetxattr:
> ---------------------------------------------------
> dmiperf.c:192:2: warning: 'attr_setf' is deprecated: Use fsetxattr instead [-Wdeprecated-declarations]
> ---------------------------------------------------

I frankly wonder if it's time to kill the DMI tests since I've never
seen it and none of the functionality is upstream.

--D

> 
> Also remove unneeded <attr/attributes.h> and $(LIBATTR).
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  src/Makefile  | 2 +-
>  src/dmiperf.c | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/src/Makefile b/src/Makefile
> index 32940142..c0688520 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -33,7 +33,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>  
>  SUBDIRS = log-writes perf
>  
> -LLDLIBS = $(LIBATTR) $(LIBHANDLE) $(LIBACL) -lpthread -lrt
> +LLDLIBS = $(LIBHANDLE) $(LIBACL) -lpthread -lrt
>  
>  ifeq ($(HAVE_XLOG_ASSIGN_LSN), true)
>  LINUX_TARGETS += loggen
> diff --git a/src/dmiperf.c b/src/dmiperf.c
> index 4026dcfb..f9415953 100644
> --- a/src/dmiperf.c
> +++ b/src/dmiperf.c
> @@ -17,7 +17,7 @@
>  #include <stdlib.h>
>  #include <string.h>
>  #include <unistd.h>
> -#include <attr/attributes.h>
> +#include <sys/xattr.h>
>  
>  typedef unsigned int uint_t;
>  
> @@ -189,8 +189,8 @@ mkfile(char *name, char *attr)
>  		perror("open");
>  		exit(1);
>  	}
> -	if (attr_setf(fd, DMFATTRNAME, attr, DMFATTRLEN, ATTR_ROOT) < 0) {
> -		perror("attr_setf");
> +	if (fsetxattr(fd, DMFATTRNAME, attr, DMFATTRLEN, 0) < 0) {
> +		perror("fsetxattr");
>  		exit(1);
>  	}
>  	while (bytes > 0) {
> -- 
> 2.23.0
> 
> 
> 

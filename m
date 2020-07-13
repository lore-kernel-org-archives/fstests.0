Return-Path: <SRS0=IIXw=AY=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AE9C433E3
	for <linux-fstests@archiver.kernel.org>; Mon, 13 Jul 2020 16:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6CF1206F5
	for <linux-fstests@archiver.kernel.org>; Mon, 13 Jul 2020 16:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R7S1sHbV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730194AbgGMQqU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 13 Jul 2020 12:46:20 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48176 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729855AbgGMQqU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 13 Jul 2020 12:46:20 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06DGMpEN009891;
        Mon, 13 Jul 2020 16:46:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=klJaREAJ1hKAQhWod/EKmmuyZkqcQ9n2IsGn2Ck5oY8=;
 b=R7S1sHbVsiiHgCgakMWCUzcdNnpd3oVuL+EQwV+41OkRCK48FDyjfrt5c4xYkmooL8bz
 jhIYArt0Fkv540zSqGr7+TbYkuW7vL3LMZnp95/s6vu3FAbi8SHlkEs4GoBTVZe/Kc2j
 7aDXKvgIFbZuzRYq9WVrqjHBBIWfugsKGbGhLGRZr7fP9iVNnbHzWs4Ruu4Qr9cgnEK0
 4Us/UKvBSFXjaGCwA9UQB522I3BcLORHTuuYLgiPLTOVOOtMEuqP8Fll8qzkcZ8t6D0E
 N45zbSCz8lcB86JI//TlJyVu0hX9xPvtx/qmI57te3xGSWDhia+aFvdBOb6jz1VYXmNm 2A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 32762n82m4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Jul 2020 16:46:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06DGMZSZ094532;
        Mon, 13 Jul 2020 16:46:15 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 327qbvw02p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jul 2020 16:46:15 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06DGkEqZ001010;
        Mon, 13 Jul 2020 16:46:14 GMT
Received: from localhost (/10.159.128.100)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Jul 2020 09:46:14 -0700
Date:   Mon, 13 Jul 2020 09:46:12 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Vladimir Zapolskiy <vladimir@tuxera.com>
Cc:     Eryu Guan <guaneryu@gmail.com>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/079: remove assignment of the test to acl and
 attr groups
Message-ID: <20200713164612.GJ7600@magnolia>
References: <20200713122648.16837-1-vladimir@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713122648.16837-1-vladimir@tuxera.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9681 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007130120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9681 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 suspectscore=1 phishscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007130120
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jul 13, 2020 at 03:26:48PM +0300, Vladimir Zapolskiy wrote:
> The test does not belong to acl group of tests, and expectedly the test
> is supposed to pass on a filesystem which supports file attributes but
> not ACLs.
> 
> In addition the test should be removed from attr group of tests, because
> the attr group specifies tests which operate over extended file attributes,
> this test does not fall into this category.
> 
> The change is intended to improve the assignment of tests to groups
> to get better testing coverage, if a list of run tests is selected by
> test group attributes.
> 
> Signed-off-by: Vladimir Zapolskiy <vladimir@tuxera.com>

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  tests/generic/group | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/group b/tests/generic/group
> index d9ab9a31f2ed..3d7effe6d72a 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -81,7 +81,7 @@
>  076 metadata rw udf auto quick stress
>  077 acl attr auto enospc
>  078 auto quick metadata
> -079 acl attr ioctl metadata auto quick
> +079 auto quick ioctl metadata
>  080 auto quick
>  081 auto quick
>  082 auto quick quota
> -- 
> 2.25.1
> 

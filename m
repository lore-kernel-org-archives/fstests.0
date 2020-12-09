Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB17C433FE
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Dec 2020 19:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B606623CD0
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Dec 2020 19:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgLIT2w (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Dec 2020 14:28:52 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:50324 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgLIT2w (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Dec 2020 14:28:52 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B9JPh21145450;
        Wed, 9 Dec 2020 19:28:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=vYJj5qOOh4L+meunmV9YrxN17lc7QJAOrUCSTTDmqno=;
 b=THrOVX1HiUlnKrXHZLmgxkq1mwbPmMuQU9Ygp0X7XBXVKXVaun1MDjWZ9P1Eh+OQWzch
 aMVBVyra+LwpnDlJiVvB3WcP0DYp3FM4ZbXw36LNLrZNUfRHf9M62IpQ11ebVZdDSe+o
 MpPgqCWNuDnQEa+aIcK+dTo/4PDXDqHR7QqPecnhrccyUzhip6KoMQFkM7rCas+LbH1V
 QTwWveE+PZqNEJ/YBcyqTjSR7ZGQ9KsWdcYnGcN4HQkyKuxrKWyit7BEhriCGs57E5p0
 JM0zfoJRlw+G366FrrCghkuYrPy/ROpi3353hELiMGtg7vogDs15IMM2UFXg+Dilgpxp Yw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 357yqc238p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 09 Dec 2020 19:28:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B9JOiaT154661;
        Wed, 9 Dec 2020 19:28:08 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 358kyv5wvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Dec 2020 19:28:08 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B9JS7Pe032159;
        Wed, 9 Dec 2020 19:28:07 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Dec 2020 11:28:07 -0800
Date:   Wed, 9 Dec 2020 11:28:06 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/rc: filter uncertain stat error output
Message-ID: <20201209192806.GA106260@magnolia>
References: <20201209140738.1057460-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209140738.1057460-1-zlang@redhat.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=1 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012090136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 mlxlogscore=999
 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012090136
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Dec 09, 2020 at 10:07:38PM +0800, Zorro Lang wrote:
> The xfs/348 start to fail with latest coreutils' stat command, the
> mismatched part likes below:
> 
>   -stat: cannot stat 'SCRATCH_MNT/test/DIR': Structure needs cleaning
>   +stat: cannot statx 'SCRATCH_MNT/test/DIR': Structure needs cleaning
> 
> So filter 'statx' to 'stat' to prevent the golden image broken.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>

Murphy Zhou already sent a patch to filter this.

--D

> ---
>  common/rc | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index b5a504e0..95def920 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4345,6 +4345,12 @@ _getcap()
>  	return ${PIPESTATUS[0]}
>  }
>  
> +stat()
> +{
> +	# filter uncertain "statx/stat" error output
> +	command stat $@ 2> >(sed -e 's/statx/stat/' >&2)
> +}
> +
>  init_rc
>  
>  ################################################################################
> -- 
> 2.25.4
> 

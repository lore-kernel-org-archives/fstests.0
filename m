Return-Path: <SRS0=clGf=3F=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC03FC33CB1
	for <linux-fstests@archiver.kernel.org>; Thu, 16 Jan 2020 15:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E01020748
	for <linux-fstests@archiver.kernel.org>; Thu, 16 Jan 2020 15:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qefn/Lzb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgAPPgZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 16 Jan 2020 10:36:25 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:39900 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgAPPgZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 Jan 2020 10:36:25 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00GFNI9M103250;
        Thu, 16 Jan 2020 15:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=gfuRkzGEr/dLoBm9lc48Ihn8oMvOMWI4XiUUdmPR8xI=;
 b=Qefn/Lzb/eRJXO7f/fh60QlHnK8/PDKyNgFP1IaFciuVpvAPjif3BkLHgaAsGvuwy7V9
 bd0dgRAsjX4k/WIqGP3NApNz7DPARyW/ZZD/ee05hSUGlJCdTXhVdhkeouPdPVyVt+Of
 so+XdMAnrK6Whz54+0UKxFyYWSGI+RBGVAxEzvZuyVPLjgNYxHbgQAnG0OjDchmS+kR+
 38Fnbhrzth7bIWpl7qVyVdo8RtRb64KL52BeyDBuusuTjaHyezh2qF7uAbK+Y9jfXWWR
 1PV7YKVWwBayhcQclZFPSjVYsX9fhx411YfF7gzM1INhFPjwSTVwp1/Pyk+dJl0bAgBm zA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2xf74sk7gr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 15:36:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00GFa5qF087537;
        Thu, 16 Jan 2020 15:36:14 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2xj1pt9s19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 15:36:09 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00GFZqnW024310;
        Thu, 16 Jan 2020 15:35:52 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 16 Jan 2020 07:35:52 -0800
Date:   Thu, 16 Jan 2020 07:35:52 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc:     fdmanana@gmail.com, fstests@vger.kernel.org
Subject: Re: [PATCH v2] generic/520: Remove sync in clean_dir
Message-ID: <20200116153552.GA2149943@magnolia>
References: <1577096499-23471-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577096499-23471-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9502 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001160129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9501 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001160129
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Dec 23, 2019 at 06:21:39PM +0800, Yang Xu wrote:
> When I test this case on xfs, it may fail as below:
> --------------------------------------------
>  === link SCRATCH_MNT/A/foo SCRATCH_MNT/bar  with fsync SCRATCH_MNT/A ===
> +umount: /mnt/xfstests/scratch: target is busy.
> +        (In some cases useful info about processes that use
> +         the device is found by lsof(8) or fuser(1))
> ---------------------------------------------
> 
> It fails because somethings is still using the fs when we call sync and then
> try to unmount it. We can simply remove sync as the unmount is supposed to
> persist the file/directory removals.

/me continues to wonder why the target is busy in this case, but as the
sync truly isn't necessary:

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>  tests/generic/520 | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tests/generic/520 b/tests/generic/520
> index 167d7077..d4457370 100755
> --- a/tests/generic/520
> +++ b/tests/generic/520
> @@ -58,7 +58,6 @@ clean_dir()
>  {
>  	_mount_flakey
>  	rm -rf $(find $SCRATCH_MNT/* | grep -v "lost+found")
> -	sync
>  	_unmount_flakey
>  }
>  
> -- 
> 2.18.0
> 
> 
> 

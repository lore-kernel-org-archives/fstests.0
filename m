Return-Path: <SRS0=97QR=4I=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB24C11D00
	for <linux-fstests@archiver.kernel.org>; Thu, 20 Feb 2020 23:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2956208CD
	for <linux-fstests@archiver.kernel.org>; Thu, 20 Feb 2020 23:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TZVZA7XX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbgBTXaN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 20 Feb 2020 18:30:13 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:54914 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbgBTXaN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 20 Feb 2020 18:30:13 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01KNT835119643;
        Thu, 20 Feb 2020 23:30:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=nwXb49C4IEct2JheFhrV1Me5R0n2uwUH/jUdnGDFcD8=;
 b=TZVZA7XXPhZAN3LjIgoHpLrfndRynYvHgePiF6eNhW8LZRJ6uBJ+EbP7im9614JqlDbg
 Pp3qRqsuoiPnZpe/t+YJpYfwsR3mVP3qqdKIDvopv0eX5qRH0pEm8N99NOMItX+oAqON
 CytNRRArjHuOvnbhLC0LfFON8H7CImlRYnHd8YDdpy3Z0HZgNyJudndupgSZNoQADPbz
 g1BTBwsjOJpzKPCKgDQCxGHcgM+hfwD/8en3VFpiJH4a6D2C+AzaCAvlcjQ0vEbqVcdW
 4WXlWb0hHg0FG+Z8IhwvTByfICy+yBqmhnB5wMx4d5wEV7404mvIVH07nM+/NiiC0j9Z FA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2y8ud1d3x9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 23:30:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01KNSZcA158971;
        Thu, 20 Feb 2020 23:30:05 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2y8uddtc82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 23:30:05 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01KNU4td008832;
        Thu, 20 Feb 2020 23:30:04 GMT
Received: from localhost (/10.145.178.17)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Feb 2020 15:30:04 -0800
Date:   Thu, 20 Feb 2020 15:30:04 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc:     guaneryu@gmail.com, fstests@vger.kernel.org
Subject: Re: [PATCH v2 1/2] xfs/029: filter out "extended-header: cycle: 1"
 from output
Message-ID: <20200220233004.GG9511@magnolia>
References: <20200219220935.GD9511@magnolia>
 <1582185528-8173-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582185528-8173-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9537 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002200172
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9537 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002200172
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Feb 20, 2020 at 03:58:47PM +0800, Yang Xu wrote:
> When I test this case(default lsunit 256k), this case will fail,
> as below:
> cycle: 1        version: 2              lsn: 1,0        tail_lsn: 1,0
> length of Log Record: 258048    prev offset: -1         num ops: 1
> 
> ...
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> extended-header: cycle: 1
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ...
> 
> It reports this info because xfs_logprint only read 32k header every time, so it
> needs to read more times. We can filter this useless info.
> 
> common/log also has _filter_logprint function. only library function is
> prefixed with "_", remove '_'.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>  tests/xfs/029 | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/xfs/029 b/tests/xfs/029
> index f532a21b..dbe700ab 100755
> --- a/tests/xfs/029
> +++ b/tests/xfs/029
> @@ -19,7 +19,7 @@ trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
>  . ./common/rc
>  . ./common/filter
>  
> -_filter_logprint()
> +filter_logprint()
>  {
>  	perl -ne '
>  	    s/data device: ([\w|\/.-]+)/data device: DDEV/;
> @@ -31,6 +31,8 @@ _filter_logprint()
>              s/(length of Log Record:) \d+/$1 <LEN>/;
>              s/version: \d/version: <VERN>/;
>  	    s/h_size: \d+/h_size: <H_SIZE>/;
> +	    s/^~+[\r|\n]+$//;
> +	    s/extended-header: cycle: 1[\r|\n]+$//;

I guess this works, but do you want to delete this line for line with
"extended-header: cycle: <some number>"?

>  	    print;
>  	'
>  }
> @@ -45,7 +47,7 @@ echo
>  _scratch_mkfs_xfs | _filter_mkfs 2>/dev/null
>  
>  echo
> -_scratch_xfs_logprint | _filter_logprint
> +_scratch_xfs_logprint | filter_logprint

Thanks for cleaning out the ^ leading underscore.

--D

>  
>  status=0
>  exit
> -- 
> 2.18.0
> 
> 
> 

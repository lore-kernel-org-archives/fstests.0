Return-Path: <SRS0=x6C3=YA=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAFEECE58C
	for <linux-fstests@archiver.kernel.org>; Mon,  7 Oct 2019 15:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C8B2070B
	for <linux-fstests@archiver.kernel.org>; Mon,  7 Oct 2019 15:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HdYuG0zW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfJGPNa (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:13:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42926 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbfJGPNY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 7 Oct 2019 11:13:24 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x97F4HnS103371;
        Mon, 7 Oct 2019 15:13:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=65lGLVGFxEtMnoDqCV3m+1RTSqR/RQHh6OFEIdNh42c=;
 b=HdYuG0zWcPcy5HyNzShUFrdM/If1Rj/TF/zxLNGeC/C/W/uBAlFsTWumhU4hwOOZx3E+
 rGO15aZubTgmZrU7kXjeIcEapbqmXdhJ/Dv9JTOYjm/dkiRre9pPwzXRqfjm3rRJ1W2j
 S0uhE71AFil4G61v1NUT4I3qbovQpIMYswQqE2BdYAXbBsf6+vuFHT0zHQ97LEUBu7bx
 F7jIDIcE7d1pzQsUh7Nsjq6EH89g/aD975edBQUoWwjRPxXffZlXVt4FgZr1Tt1BIIxd
 CKQhW1oUecGJVQ+Dd0PDXfYuC52NQNPH4rm8K/dIm/L6+YiWJ/3HPKAVb12Moh1prWk5 pA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2vek4q7d1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Oct 2019 15:13:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x97FD4m1141829;
        Mon, 7 Oct 2019 15:13:11 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2vg1yu2khb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Oct 2019 15:13:08 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x97FCgkS012198;
        Mon, 7 Oct 2019 15:12:43 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Oct 2019 08:12:42 -0700
Date:   Mon, 7 Oct 2019 08:12:44 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/097: Remove wrong broken assignment operation
Message-ID: <20191007151244.GC13097@magnolia>
References: <1570432515-13184-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570432515-13184-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910070151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910070151
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Oct 07, 2019 at 03:15:15PM +0800, Yang Xu wrote:
> On old kernel, since commit ded188b8609 ("xfs: Fix the situation that mount 
> operation rejects corrupted XFS") running this case got the mismatched output,
> as below:

But why did the output mismatch?  Did the fs heal itself?  Did
allocating 5 more files somehow avoid touching the finobt?  Is the
assignment logic in the loop broken?

--D

> -----------------------------------
>  + check fs
>  + corrupt image
>  + mount image && modify files
> -broken: 1
> +broken: 0
>  + repair fs
>  + mount image (2)
> ------------------------------------
> 
> It fails because the broken is always equal to 0 when _try_scratch_mount
> succeed. So remove this wrong assignment operation.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>  tests/xfs/097 | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/tests/xfs/097 b/tests/xfs/097
> index 1cb7d69c..20791738 100755
> --- a/tests/xfs/097
> +++ b/tests/xfs/097
> @@ -81,8 +81,6 @@ done
>  echo "+ mount image && modify files"
>  broken=1
>  if _try_scratch_mount >> $seqres.full 2>&1; then
> -
> -	broken=0
>  	for x in `seq 65 70`; do
>  		touch "${TESTFILE}.${x}" 2> /dev/null && broken=0
>  	done
> -- 
> 2.18.1
> 
> 
> 

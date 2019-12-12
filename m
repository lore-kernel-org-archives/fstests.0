Return-Path: <SRS0=/sVf=2C=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464A1C43603
	for <linux-fstests@archiver.kernel.org>; Thu, 12 Dec 2019 06:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1873B2073D
	for <linux-fstests@archiver.kernel.org>; Thu, 12 Dec 2019 06:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PUz64voD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfLLGEm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 12 Dec 2019 01:04:42 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:53946 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfLLGEm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 Dec 2019 01:04:42 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBC64MCY011946;
        Thu, 12 Dec 2019 06:04:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=NE2orR4QdPzOdGvAJEIRwmO9A1L29RcYLZA7DpH8D+I=;
 b=PUz64voDlKR7dAsClXLVM9hqX5mvTvK9Cr+vQPy7GRCQXP2LrUk9CSfZn+HuUMxRrn35
 2tPM9QCh2vbjut4h4BirerU0LfbocthJmvfzd/hhZXg6bDfYiUlmBQnrXHicB5U3hoOb
 py4DHWhBzT7lv0naXMvaCUTc3sSazBNNwYpcT5H6lrhAbjelZSOfjWbD4K090WLWTOGA
 74RfhAbqNDYw+4U7Hf9R4EI3KX7dASGXSEiTjr2yjd3+PNE1FeSiZ0kx0bA2pyjAQe1t
 w35VR/3MnIgvXnb/5rhgLTF/tZn4ao0lBAYS3RVBfaQg+1sBi4PDac6fW1TsPV4egUQV 8Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2wr4qrrsmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Dec 2019 06:04:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBC60cAZ107314;
        Thu, 12 Dec 2019 06:04:40 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2wu3k0h0k1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Dec 2019 06:04:40 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBC64df1020191;
        Thu, 12 Dec 2019 06:04:39 GMT
Received: from localhost (/10.159.154.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Dec 2019 22:04:39 -0800
Date:   Wed, 11 Dec 2019 22:04:37 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/filter: prepend 0 to treat offset as octal
Message-ID: <20191212060437.GA99869@magnolia>
References: <20191212031152.1906287-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212031152.1906287-1-naohiro.aota@wdc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9468 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912120038
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9468 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912120039
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Dec 12, 2019 at 12:11:52PM +0900, Naohiro Aota wrote:
> The offsets printed by "od" are octal numbers. So, we need to add "0" at
> the head of the $offset to parse it as an octal number.
> 
> Fixes: 37520a314bd4 ("fstests: Don't use gawk's strtonum")
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

<grumble> Did the original patch author run all the tests that use
_filter_od to make sure there weren't any regressions.  This fixes
xfs/139 for me, so...

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  common/filter | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/filter b/common/filter
> index 6140e58368d7..88fcb6ef68ee 100644
> --- a/common/filter
> +++ b/common/filter
> @@ -495,7 +495,7 @@ _filter_od()
>  		fi
>  
>  		offset="${line%% *}"
> -		printf '%o%s\n' $((offset / BLOCK_SIZE)) "${line#$offset}"
> +		printf '%o%s\n' $(("0$offset" / BLOCK_SIZE)) "${line#$offset}"
>  	done
>  }
>  
> -- 
> 2.24.0
> 

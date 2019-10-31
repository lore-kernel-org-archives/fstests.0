Return-Path: <SRS0=ptrv=YY=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2398CA9EC3
	for <linux-fstests@archiver.kernel.org>; Thu, 31 Oct 2019 03:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 859D52086D
	for <linux-fstests@archiver.kernel.org>; Thu, 31 Oct 2019 03:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JS38/0Ax"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfJaDlO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 30 Oct 2019 23:41:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54796 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfJaDlN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 30 Oct 2019 23:41:13 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9V3dMvp003146;
        Thu, 31 Oct 2019 03:41:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=zyyBIMKCP7KV9jNq9iSEHuvg0uhw7GKFTGAKEcGJds8=;
 b=JS38/0AxoGuqwlizIMD/ZmiSTaPFvcRhjhe5yeM5um1i+qDk0khNhCxKoUKLKvczFdSU
 oGYYqPl5DBSYMjTDl6nbTqKOTikvuJtm5hKPIt65IDn8j+eaB5s282e8K/GnVV3dZU7g
 Pr/KV4jn0aj/P+d5pGzArojt7oODJgAnisAJkHNJsK2Nnbv4GOvuf95Xb5v6Gq1133Fy
 2i1f1N7lx1p0JWJPmMJTp2FQWjIFFisSIeMghVCEzNoB9TlVK0A3iojHe9dRVQ+5YJcd
 99XGaAiNClWQg6O8kIbRMpimFL6Csp/9JcobzY7G0/GjxoHMP8Ngpvc3b4h+KQrWr157 QQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2vxwhfr7sw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Oct 2019 03:41:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9V3cTGf055454;
        Thu, 31 Oct 2019 03:41:09 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2vxwjahhy3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Oct 2019 03:41:08 +0000
Received: from abhmp0023.oracle.com (abhmp0023.oracle.com [141.146.116.29])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9V3f8hl016968;
        Thu, 31 Oct 2019 03:41:08 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 31 Oct 2019 03:41:07 +0000
Date:   Wed, 30 Oct 2019 20:41:06 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Baihua Lu <lubaihua0331@gmail.com>
Cc:     fstests@vger.kernel.org, balu@microsoft.com
Subject: Re: [PATCH] common/rc: fix _require_xfs_io_command utimes check
Message-ID: <20191031034106.GC15224@magnolia>
References: <20191031012553.72731-1-lubaihua0331@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031012553.72731-1-lubaihua0331@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9426 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910310033
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9426 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910310034
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Oct 31, 2019 at 01:25:53AM +0000, Baihua Lu wrote:
> There is an error on checking utimes command. Put quotation mark after four "0".
> 
> Signed-off-by: Baihua Lu <lubaihua0331@gmail.com>

Looks ok to me,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index a2a28f32..657d05d3 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2186,7 +2186,7 @@ _require_xfs_io_command()
>  			_notrun "xfs_io $command support is missing"
>  		;;
>  	"utimes" )
> -		testio=`$XFS_IO_PROG -f -c "utimes" 0 0 0 0 $testfile 2>&1`
> +		testio=`$XFS_IO_PROG -f -c "utimes 0 0 0 0" $testfile 2>&1`
>  		;;
>  	"syncfs")
>  		touch $testfile
> -- 
> 2.17.1
> 

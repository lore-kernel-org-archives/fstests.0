Return-Path: <SRS0=B3p8=Z3=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0563C43603
	for <linux-fstests@archiver.kernel.org>; Thu,  5 Dec 2019 07:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C157824249
	for <linux-fstests@archiver.kernel.org>; Thu,  5 Dec 2019 07:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="raGIOlw4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbfLEHFJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 5 Dec 2019 02:05:09 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57518 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfLEHFJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 5 Dec 2019 02:05:09 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB56wtP2048695;
        Thu, 5 Dec 2019 07:05:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=2JGLrNeYEiSJJ/WjmhIS1E0ReX4B68Q/mv9eyJuUNqo=;
 b=raGIOlw4CFCA+82CYVEap9J7A1V9wJSLJsZZ/fFVj6rgXshXp+O8ODMHK2bKGDN/ZD5p
 Q7Jvpy5Nwa87VptM41tS2exFd5veesDX0r4rDa/F0bmrF8tba0GVvfJX/0Wb/tUOqrWB
 yot21LdldBhCkggJZ23cKchBe/3MuY3NWCxCzkp3JSI0Z3gg4SJS8tzPnDBtpNpcaCix
 IThQnychnj9hd76l/baxCRrCe/jrQr08NpIXS00AeJrGzkC/4hdtnJ0rOz0zFahtPzcm
 FFhwTTdPgkGz+S0qaWjcj8xck/e3XG6Xam/JwgkddEtwxAYeK0jWaAg9cEnHpPNoSiz9 Bw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2wkgcqk43q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Dec 2019 07:05:04 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB5745bV186724;
        Thu, 5 Dec 2019 07:05:04 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2wptnwxwj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Dec 2019 07:05:04 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xB5752JL021887;
        Thu, 5 Dec 2019 07:05:03 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Dec 2019 23:05:02 -0800
Date:   Wed, 4 Dec 2019 23:05:01 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Baihua Lu <lubaihua0331@gmail.com>
Cc:     fstests@vger.kernel.org, guaneryu@gmail.com, balu@microsoft.com,
        Lili.Deng@microsoft.com
Subject: Re: [PATCH] xfs/191-input-validation:The "verion=1 -m crc=1" option
 is valid
Message-ID: <20191205070501.GA13252@magnolia>
References: <20191205040236.26066-1-lubaihua0331@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205040236.26066-1-lubaihua0331@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912050055
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912050055
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Dec 05, 2019 at 04:02:36AM +0000, Baihua Lu wrote:
> The "version=1 -m crc=1" option is valid, so the test should be passed.

# mkfs.xfs -l version=1 -m crc=1 /dev/sda1
V2 logs always enabled for CRC enabled filesystems
Usage: mkfs.xfs
/* blocksize */         [-b size=num]
<other junk>

That's a pass?

<confused>

--D

> 
> Signed-off-by: Baihua Lu <lubaihua0331@gmail.com>
> ---
>  tests/xfs/191-input-validation | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/191-input-validation b/tests/xfs/191-input-validation
> index db427349..b5611c5b 100755
> --- a/tests/xfs/191-input-validation
> +++ b/tests/xfs/191-input-validation
> @@ -217,6 +217,7 @@ do_mkfs_pass -l lazy-count=1 -m crc=0 $SCRATCH_DEV
>  do_mkfs_pass -l version=1 -m crc=0 $SCRATCH_DEV
>  do_mkfs_pass -l version=2 -m crc=0 $SCRATCH_DEV
>  do_mkfs_pass -l version=2 $SCRATCH_DEV
> +do_mkfs_pass -l version=1 -m crc=1 $SCRATCH_DEV
>  
>  # log section, should fail
>  do_mkfs_fail -l size=${fssize}b $SCRATCH_DEV
> @@ -239,7 +240,6 @@ do_mkfs_fail -l internal=1,logdev=$fsimg $SCRATCH_DEV
>  do_mkfs_fail -l lazy-count=1garbage $SCRATCH_DEV
>  do_mkfs_fail -l lazy-count=2 $SCRATCH_DEV
>  do_mkfs_fail -l lazy-count=0 -m crc=1 $SCRATCH_DEV
> -do_mkfs_fail -l version=1 -m crc=1 $SCRATCH_DEV
>  do_mkfs_fail -l version=0  $SCRATCH_DEV
>  
>  
> -- 
> 2.17.1
> 

Return-Path: <SRS0=WAnD=4J=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA31BC35669
	for <linux-fstests@archiver.kernel.org>; Fri, 21 Feb 2020 23:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C74207FD
	for <linux-fstests@archiver.kernel.org>; Fri, 21 Feb 2020 23:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WC55wXF+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgBUXg2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 21 Feb 2020 18:36:28 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55866 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgBUXg2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 21 Feb 2020 18:36:28 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01LNYcQW118310;
        Fri, 21 Feb 2020 23:36:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=TqTFCWrva5SKL45VWxNFN/YphGO+QVobQ6TMSDhSTGM=;
 b=WC55wXF+smsbsioZDSHGuI9gdpc9+t3D1XbqvKmoS6hRD/CMvCmzQ/y/zto9X3JbCAJC
 Afb6D5LJRr+m/grreoIZPNDdbHY/ym8w7FQXuasiS0zmtyx3ygT23Q+e1VFXm1NxJa3P
 3cjMSyRfaiqkbftxdtz18aLmS+7Jhpi4a9GK4snIRrRG4cjGpZ+zRGJ99XSYt+wBIBmh
 +dJamXRcIlg3+a8qECqBNadQd4YmMdjxo5VoMWgslsA0+RwESJeKq3YL+RtistFFvCqt
 R1SwPUznBMn1AGvkiA+pz52mgpHkCn0p9pPqSh0GBihXLrOaNZ1RgzRl27gLH29zqNlJ 7A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2y8ud1kdte-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 23:36:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01LNVt2F162005;
        Fri, 21 Feb 2020 23:36:23 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2y8udr5jdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 23:36:23 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01LNaMvO012784;
        Fri, 21 Feb 2020 23:36:22 GMT
Received: from localhost (/10.145.179.117)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Feb 2020 15:36:21 -0800
Date:   Fri, 21 Feb 2020 15:36:21 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: add an eio group
Message-ID: <20200221233621.GI9511@magnolia>
References: <20200221184309.776863-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221184309.776863-1-tytso@mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9538 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210176
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9538 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002210176
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Feb 21, 2020 at 01:43:09PM -0500, Theodore Ts'o wrote:
> This allows us to run all those tests which simulate disk failures
> using dmerror.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Old MacDonald had a farm, EI<bzrrt>

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  tests/btrfs/group   |  8 ++++----
>  tests/generic/group | 42 +++++++++++++++++++++---------------------
>  tests/xfs/group     |  8 ++++----
>  3 files changed, 29 insertions(+), 29 deletions(-)
> 
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 1947f0d7..16b784d6 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -102,8 +102,8 @@
>  097 auto quick send clone
>  098 auto quick metadata clone log
>  099 auto quick qgroup limit
> -100 auto replace volume
> -101 auto replace volume
> +100 auto replace volume eio
> +101 auto replace volume eio
>  102 auto quick metadata enospc
>  103 auto quick clone compress
>  104 auto qgroup
> @@ -148,7 +148,7 @@
>  143 auto quick
>  144 auto quick send
>  145 auto quick send
> -146 auto quick
> +146 auto quick eio
>  147 auto quick send
>  148 auto quick rw
>  149 auto quick send compress
> @@ -162,7 +162,7 @@
>  157 auto quick raid
>  158 auto quick raid scrub
>  159 auto quick punch log
> -160 auto quick
> +160 auto quick eio
>  161 auto quick volume seed
>  162 auto quick volume seed
>  163 auto quick volume seed
> diff --git a/tests/generic/group b/tests/generic/group
> index a1bf6aca..f93a6430 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -252,9 +252,9 @@
>  247 auto quick rw
>  248 auto quick rw
>  249 auto quick rw
> -250 auto quick prealloc rw
> +250 auto quick prealloc rw eio
>  251 ioctl trim
> -252 auto quick prealloc rw
> +252 auto quick prealloc rw eio
>  253 auto quick clone
>  254 auto quick clone punch
>  255 auto quick prealloc punch
> @@ -267,25 +267,25 @@
>  262 auto quick clone insert
>  263 rw auto quick
>  264 auto quick clone
> -265 auto quick clone
> -266 auto quick clone
> -267 auto quick clone
> -268 auto quick clone
> +265 auto quick clone eio
> +266 auto quick clone eio
> +267 auto quick clone eio
> +268 auto quick clone eio
>  269 auto rw prealloc ioctl enospc stress
>  270 auto quota rw prealloc ioctl enospc stress
> -271 auto quick clone
> -272 auto quick clone
> +271 auto quick clone eio
> +272 auto quick clone eio
>  273 auto rw
>  274 auto rw prealloc enospc
>  275 auto rw enospc
> -276 auto quick clone
> +276 auto quick clone eio
>  277 auto ioctl quick metadata
> -278 auto quick clone
> -279 auto quick clone
> +278 auto quick clone eio
> +279 auto quick clone eio
>  280 auto quota freeze
> -281 auto quick clone
> -282 auto quick clone
> -283 auto quick clone
> +281 auto quick clone eio
> +282 auto quick clone eio
> +283 auto quick clone eio
>  284 auto quick clone
>  285 auto rw seek
>  286 auto quick other seek
> @@ -331,16 +331,16 @@
>  326 auto quick clone
>  327 auto quick clone
>  328 auto quick clone
> -329 auto quick clone
> +329 auto quick clone eio
>  330 auto quick clone
> -331 auto quick clone
> +331 auto quick clone eio
>  332 auto quick clone
>  333 auto clone
>  334 auto clone
>  335 auto quick metadata log
>  336 auto quick metadata log
>  337 auto quick metadata
> -338 auto quick rw
> +338 auto quick rw eio
>  339 auto dir
>  340 auto
>  341 auto quick metadata log
> @@ -443,8 +443,8 @@
>  438 auto
>  439 auto quick punch
>  440 auto quick encrypt
> -441 auto quick
> -442 blockdev
> +441 auto quick eio
> +442 blockdev eio
>  443 auto quick rw
>  444 auto quick acl
>  445 auto quick rw seek prealloc
> @@ -477,7 +477,7 @@
>  472 auto quick swap
>  473 broken
>  474 auto quick shutdown metadata
> -475 shutdown auto log metadata
> +475 shutdown auto log metadata eio
>  476 auto rw
>  477 auto quick exportfs
>  478 auto quick
> @@ -489,7 +489,7 @@
>  484 auto quick
>  485 auto quick insert
>  486 auto quick attr
> -487 auto quick
> +487 auto quick eio
>  488 auto quick
>  489 auto quick attr log
>  490 auto quick rw seek
> diff --git a/tests/xfs/group b/tests/xfs/group
> index 0cbd0647..522d4bc4 100644
> --- a/tests/xfs/group
> +++ b/tests/xfs/group
> @@ -3,7 +3,7 @@
>  003 db auto quick
>  004 db auto quick
>  005 auto quick
> -006 auto quick mount
> +006 auto quick mount eio
>  007 auto quota quick
>  008 rw ioctl auto quick
>  009 rw ioctl auto prealloc quick
> @@ -234,10 +234,10 @@
>  234 auto quick rmap punch
>  235 fuzzers rmap
>  236 auto rmap punch
> -237 auto quick clone
> +237 auto quick clone eio
>  238 auto quick metadata ioctl
>  239 auto quick clone
> -240 auto quick clone
> +240 auto quick clone eio
>  241 auto quick clone
>  242 auto quick prealloc zero
>  243 auto quick clone punch
> @@ -261,7 +261,7 @@
>  261 auto quick quota
>  262 dangerous_fuzzers dangerous_scrub dangerous_online_repair
>  263 auto quick quota
> -264 auto quick mount
> +264 auto quick mount eio
>  265 auto clone
>  266 dump ioctl auto quick
>  267 dump ioctl tape
> -- 
> 2.24.1
> 

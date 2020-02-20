Return-Path: <SRS0=97QR=4I=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E030C11D00
	for <linux-fstests@archiver.kernel.org>; Thu, 20 Feb 2020 23:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 101D020801
	for <linux-fstests@archiver.kernel.org>; Thu, 20 Feb 2020 23:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q/Ow9TXf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbgBTXah (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 20 Feb 2020 18:30:37 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:52802 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbgBTXah (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 20 Feb 2020 18:30:37 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01KNTS8R023490;
        Thu, 20 Feb 2020 23:30:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=jcWX1FykGQf80vVhjf75FY0yIatguCedqvakcJFV3G4=;
 b=Q/Ow9TXfU8kVmqea0rCvXT9IXJ+pkdjhPEZiNIEFqOfsJV/T0iYJfC0hHVM2hfQePkEm
 9MKgZQYUST5BLMgFGDC6JwtRnYN4CxQAyu5cnUgPSQgy6kppcpeMd/84J3D2gX4bg20e
 yeJL/a35LQyRWZWZ6BybwcgxWq1oEvO1TyJ1w2Ehla2PBCAZi4IfKYFwfyvWIgIo3Wl5
 kZtm6g6mlaUQO3FwLPIW8ZnD50QnBIgS5ubctVgMaz00dXFeiXl+JtxVLAjRh/C5SJqR
 aULapl1FZiT2xHgkAFWHJV/mOpHAineT9qnppfTooHShDfDDOUKLHShU8lCJfOFZprsg 7w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2y8uddd4r9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 23:30:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01KNRrIN123299;
        Thu, 20 Feb 2020 23:30:31 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2y8ud50562-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 23:30:31 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01KNUUHI031598;
        Thu, 20 Feb 2020 23:30:30 GMT
Received: from localhost (/10.145.178.17)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Feb 2020 15:30:30 -0800
Date:   Thu, 20 Feb 2020 15:30:30 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc:     guaneryu@gmail.com, fstests@vger.kernel.org
Subject: Re: [PATCH v2 2/2] xfs/044: Remove useless _filter_logprint
Message-ID: <20200220233030.GH9511@magnolia>
References: <20200219220935.GD9511@magnolia>
 <1582185528-8173-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1582185528-8173-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582185528-8173-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9537 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200172
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9537 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200172
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Feb 20, 2020 at 03:58:48PM +0800, Yang Xu wrote:
> xfs/044 has customized  _filter_logprint function, but it was never
> used. So remove it.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  tests/xfs/044 | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/tests/xfs/044 b/tests/xfs/044
> index 4a476985..0c6a421d 100755
> --- a/tests/xfs/044
> +++ b/tests/xfs/044
> @@ -25,18 +25,6 @@ _supported_os Linux
>  
>  _require_logdev
>  
> -_filter_logprint()
> -{
> -	perl -ne '
> -	    s/data device: ([\w|\/.-]+)/data device: DDEV/;
> -	    s/log device: ([\w|\/.-]+) daddr: (\d+) length: (\d+)/log device: LDEV daddr: XXX length: XXX/;
> -	    s/log file: "([\w|\/.-]+)" daddr: (\d+) length: (\d+)/log device: LDEV daddr: XXX length: XXX/;
> -	    s/uuid: ([abcdef\d-]+)\s+format: (.+)/uuid: UUID format: FORMAT/;
> -	    s/skipped (\w+) zeroed blocks/skipped XXX zeroed blocks/;
> -	    print;
> -	'
> -}
> -
>  _check_mount()
>  {
>      echo "    *** mount (expect success)"
> -- 
> 2.18.0
> 
> 
> 

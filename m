Return-Path: <SRS0=KIFJ=4H=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409A2C34031
	for <linux-fstests@archiver.kernel.org>; Wed, 19 Feb 2020 00:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124C9208E4
	for <linux-fstests@archiver.kernel.org>; Wed, 19 Feb 2020 00:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JQk2MxuB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbgBSAcM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 18 Feb 2020 19:32:12 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:51292 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgBSAcM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 18 Feb 2020 19:32:12 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01J0W87N061696;
        Wed, 19 Feb 2020 00:32:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=b+wz0zHNG3U/zQq1uhsyXl3bB2q+4EafuSR9sHqAUyY=;
 b=JQk2MxuBir0EZxUmcibEINke4QOqCGS9ZCRi02LsI/2SRIbGK2oH3vEJaV0Y2DD0Ppys
 Nnfqbu87M5LgkaqjW9imoDvJSo+Qc/5Ruo+59ShSAGZz6nDbMhaFsjF2t9SisbFptlrP
 lHySwdyDiaW6Zvf8jaaKP3cOmah0FWVhrMuhMfKjx+JA795fWTuNj5WhKqqUqeV7cICf
 M9w2HcOF2kKu969na8f8awx0h0G5PzMUabqYakPTfLINd55a9MLF73Epo9FS4fqF9wVa
 h8YwOBNsBZOy2Dk91bGb59OIndeupMy/OCNqBMc2o97gjzrn7GTKlJbCLfxKO8TBkWHK dA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2y699rsqdx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 00:32:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01J0SUQe152041;
        Wed, 19 Feb 2020 00:32:06 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2y82c2d44f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 00:32:06 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01J0W5sI012421;
        Wed, 19 Feb 2020 00:32:05 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Feb 2020 16:32:04 -0800
Date:   Tue, 18 Feb 2020 16:32:04 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/029: filter out "extended-header: cycle: 1" from
 output
Message-ID: <20200219003204.GA9511@magnolia>
References: <1581922940-14074-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581922940-14074-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002190000
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002190000
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Feb 17, 2020 at 03:02:20PM +0800, Yang Xu wrote:
> When I test this case under GPT disklabel type, this case will fail,
> as below:
> cycle: 1        version: 2              lsn: 1,0        tail_lsn: 1,0
> length of Log Record: 258048    prev offset: -1         num ops: 1
> 
> ...
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> extended-header: cycle: 1
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ...
> 
> my mkfs information as below:
> meta-data=/dev/sda7              isize=512    agcount=16, agsize=327680 blks
>          =                       sectsz=512   attr=2, projid32bit=1
>          =                       crc=1        finobt=1, sparse=1, rmapbt=0
>          =                       reflink=1
> data     =                       bsize=4096   blocks=5242880, imaxpct=25
>          =                       sunit=64     swidth=64 blks
> naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
> log      =internal log           bsize=4096   blocks=5184, version=2
>          =                       sectsz=512   sunit=64 blks, lazy-count=1
> realtime =none                   extsz=4096   blocks=0, rtextents=0
> 
> It reports this info because xfs_logprint only read 32k header every time, so it
> needs to read more times. We can filter this useless info.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>  tests/xfs/029 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/029 b/tests/xfs/029
> index f532a21b..99742792 100755
> --- a/tests/xfs/029
> +++ b/tests/xfs/029
> @@ -45,7 +45,7 @@ echo
>  _scratch_mkfs_xfs | _filter_mkfs 2>/dev/null
>  
>  echo
> -_scratch_xfs_logprint | _filter_logprint
> +_scratch_xfs_logprint | _filter_logprint | sed -e "/^~~~/d" -e "/extended-header/d"

Is there a reason not to add that to _filter_logprint?

--D

>  
>  status=0
>  exit
> -- 
> 2.18.0
> 
> 
> 

Return-Path: <SRS0=lR6x=4L=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7472C35671
	for <linux-fstests@archiver.kernel.org>; Sun, 23 Feb 2020 16:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811F52067D
	for <linux-fstests@archiver.kernel.org>; Sun, 23 Feb 2020 16:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wNmO45GH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgBWQhT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 23 Feb 2020 11:37:19 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57684 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgBWQhT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 23 Feb 2020 11:37:19 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01NGYQrk006790;
        Sun, 23 Feb 2020 16:37:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=vsPKX7U0PkoCRXeP6A5b42uOe3eiqMCG+6ozRNMmugY=;
 b=wNmO45GHifY1h4R5H23jNnbgEKlzMpMzIU8aqr0Pr55wEh3Npe2yXHymLQLmRa95x9p7
 5TqCjoNW/4egPZHHEGSUlXM0WIg6dVtW/Z/ejv/hJIjqdT1h4bwSKz3TVEXYiIapzujz
 eSHo0Q1P0cCSPLMH+Bs4IYFlS7aO3h3NJcsGBmEr1qIfHjGKk1mOg8UYdh3u/KgH5xVQ
 q3LvapH0HhcPjI8guNjwAEKfCUhG1lm1KKA/IAGDB4FXgWL2QYuW1DN0bj/imHIjN1dV
 i+DIMsaMxc4pKhjRrtdZcfTeCo4kjlttILFp7wOPJ1P4O97/t1qhDa12uGwwqhieGi9D Lw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2ybvr4g11e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Feb 2020 16:37:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01NGW0j4158024;
        Sun, 23 Feb 2020 16:37:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2ybdseh52a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Feb 2020 16:37:11 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01NGbBgr031400;
        Sun, 23 Feb 2020 16:37:11 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 23 Feb 2020 08:37:10 -0800
Date:   Sun, 23 Feb 2020 08:37:10 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>, fstests@vger.kernel.org
Subject: Re: [PATCH v2] common/log: add -l su option in _xfs_log_config
Message-ID: <20200223163710.GL9504@magnolia>
References: <20200220021709.GF9504@magnolia>
 <1582177081-6235-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200223142208.GD3840@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200223142208.GD3840@desktop>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9540 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002230137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9540 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002230137
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Feb 23, 2020 at 10:22:10PM +0800, Eryu Guan wrote:
> Hi Darrick,
> 
> On Thu, Feb 20, 2020 at 01:38:01PM +0800, Yang Xu wrote:
> > Currently, if we don't specify -l sunit or -l su option, mkfs.xfs
> > will get the stripe size from underlying device.
> > 
> > It works file on most situations. But on some machine, the size of
> > underlying device greater than logbsize of mount options, it will
> > report error like "logbuf size must be greater than or equal to log
> > stripe size". We can specify -l su=4096 to meet this requirement and
> > case can still run normally.
> > 
> > Also, from xfs manpage, version 2 also supports 16k log buf size for
> > mount option and case passed(only generic/054,055 used this api) on
> > my machine. So delete 32k and 64k with different sunit to be consistented

I don't understand why there's a need to be consistent, which means I
don't understand why we'd "delete 32k and 64k with different sunit".
ext4 tests should not be invoking _xfs_log_config()

> > with ext4 test num(10) and we can test all logbuf size.

Hm?  ext4/010 is an inode bitmap fuzz test.

> > 
> > Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> 
> Would you like to review this v2 patch again? I feel more confident if
> xfs maintainer could ack it :)
> 
> Thanks,
> Eryu
> 
> > ---
> >  common/log | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/common/log b/common/log
> > index c7921f50..9b5a2f6d 100644
> > --- a/common/log
> > +++ b/common/log
> > @@ -546,15 +546,15 @@ _xfs_log_config()
> >  {
> >      echo "# mkfs-opt             mount-opt"
> >      echo "# ------------------------------"
> > -    echo "  version=2            logbsize=32k"
> > +    echo "  version=2,su=4096    logbsize=16k"

The straight substitutions look fine to me, but then...

> > +    echo "  version=2,su=16k     logbsize=16k"

...I can't tell why we're adding this extra case here, or why this
has to be here and not in a separate patch justifying the addition?

> >      echo "  version=2,su=4096    logbsize=32k"
> > -    echo "  version=2,su=32768   logbsize=32k"
> > -    echo "  version=2,su=32768   logbsize=64k"

...I also don't think it's a good idea to reduce test coverage, and
definitely not buried in something that sounds like a fix patch.

--D

> > -    echo "  version=2            logbsize=64k"
> > +    echo "  version=2,su=32k     logbsize=32k"
> > +    echo "  version=2,su=4096    logbsize=64k"
> >      echo "  version=2,su=64k     logbsize=64k"
> > -    echo "  version=2            logbsize=128k"
> > +    echo "  version=2,su=4096    logbsize=128k"
> >      echo "  version=2,su=128k    logbsize=128k"
> > -    echo "  version=2            logbsize=256k"
> > +    echo "  version=2,su=4096    logbsize=256k"
> >      echo "  version=2,su=256k    logbsize=256k"
> >  }
> >  
> > -- 
> > 2.18.0
> > 
> > 
> > 

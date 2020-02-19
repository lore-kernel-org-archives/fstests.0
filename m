Return-Path: <SRS0=KIFJ=4H=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE150C5ACC4
	for <linux-fstests@archiver.kernel.org>; Wed, 19 Feb 2020 22:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF679206EF
	for <linux-fstests@archiver.kernel.org>; Wed, 19 Feb 2020 22:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l+VU6SNF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgBSWLh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 19 Feb 2020 17:11:37 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44196 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbgBSWLh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 19 Feb 2020 17:11:37 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01JM9Cs0046942;
        Wed, 19 Feb 2020 22:11:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=kTaHuipvQyiY0vYnYlA9HbetkyXEeYAL+Dm6DVQ/Lhk=;
 b=l+VU6SNFvTRolZ6XaDH9Vn3ZxPbdNJjSqrI6pganIXiqfaNndpAe3zuMYDiQkWCwSSLS
 AcZ0xnrt5KEfjcoSBKEF+iIvxQa8CREf7s9mnkEAhWj1+s2N7kBxJC6HA7eg4VR1W9sY
 YBvvq5syTFigjcXUbj8krdIckIHd/Ydtm7PaUIdJ7HR5kP3ceqtuiY7v15D+cr/KqxKI
 8Y3GGfDVnJFSNGaK2Hpf8xlQX4T4pWIV8cM7ZPsgmT3CvavvxdoQandreCQArSzPaqQu
 I5+UFhxiWa5EehnFaw6N2r+zIW4QowpHlMAASaqMfnbL4eaq2mzrXXFdCP+WXWHvVNZ7 BA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2y8udd662g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 22:11:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01JM8GT8156851;
        Wed, 19 Feb 2020 22:11:31 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2y8udbbpj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 22:11:30 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01JMBTMW023475;
        Wed, 19 Feb 2020 22:11:29 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Feb 2020 14:11:29 -0800
Date:   Wed, 19 Feb 2020 14:11:28 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc:     guaneryu@gmail.com, fstests@vger.kernel.org
Subject: Re: [PATCH v1 1/2] generic/054,055: add _require_v2log
Message-ID: <20200219221128.GE9511@magnolia>
References: <1582010652-1124-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200219050622.GB9504@magnolia>
 <b42c4b51-84b5-15aa-0a9d-a3375e08d66b@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b42c4b51-84b5-15aa-0a9d-a3375e08d66b@cn.fujitsu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002190164
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002190164
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Feb 19, 2020 at 04:48:07PM +0800, Yang Xu wrote:
> 
> 
> on 2020/02/19 13:06, Darrick J. Wong wrote:
> > On Tue, Feb 18, 2020 at 03:24:10PM +0800, Yang Xu wrote:
> > > This two case fail on my server machine with GPT disklabe type,
> > > info as below:
> > > mount failed: -o logbsize=32k
> > > dmesg info as below:
> > > [92633.871954] XFS (sda7): logbuf size must be greater than or equal to log stripe size
> > > 
> > > The min logbuf size is 256k on my server machine. It needs to use _require_v2log to check.
> > 
> > Works fine here.  What is sda7's storage and raid alignment
> > configuration?
> /dev/sda is a SAS disk, raid aligment is 256k.  When I mkfs.xfs -f
> /dev/sda7(20G), its lsunit value is 64blks(block size is 4k).

_require_v2log probably ought to be smarter about that.

But, uh, seeing as generic/05[45] don't currently call _require_v2log,
how did logbsize=32k end up in the mount options to fail those two
tests?

--D

> Best Regards
> Yang Xu
> > 
> > --D
> > 
> > > Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> > > ---
> > >   common/log        | 1 +
> > >   tests/generic/054 | 1 +
> > >   tests/generic/055 | 1 +
> > >   3 files changed, 3 insertions(+)
> > > 
> > > diff --git a/common/log b/common/log
> > > index c7921f50..f82919a6 100644
> > > --- a/common/log
> > > +++ b/common/log
> > > @@ -494,6 +494,7 @@ _log_version()
> > >   _require_v2log()
> > >   {
> > > +    [ "$FSTYP" != xfs ] && return 0
> > >       # test out mkfs to see if it supports "-l version=2"
> > >       export MKFS_OPTIONS="-l version=2"
> > >       if ! _scratch_mkfs_xfs >>$seqres.full 2>&1; then
> > > diff --git a/tests/generic/054 b/tests/generic/054
> > > index 95d40c3c..b4b74615 100755
> > > --- a/tests/generic/054
> > > +++ b/tests/generic/054
> > > @@ -30,6 +30,7 @@ rm -f $seqres.full $tmp.*
> > >   _require_scratch
> > >   _require_scratch_shutdown
> > >   _require_logstate
> > > +_require_v2log
> > >   echo "*** init FS"
> > >   _scratch_unmount >/dev/null 2>&1
> > > diff --git a/tests/generic/055 b/tests/generic/055
> > > index 9715f27b..071c4eaf 100755
> > > --- a/tests/generic/055
> > > +++ b/tests/generic/055
> > > @@ -57,6 +57,7 @@ rm -f $seqres.full $tmp.*
> > >   _require_scratch
> > >   _require_scratch_shutdown
> > >   _require_logstate
> > > +_require_v2log
> > >   QUOTA_OPTION=`_get_quota_option`
> > > -- 
> > > 2.18.0
> > > 
> > > 
> > > 
> > 
> > 
> 
> 

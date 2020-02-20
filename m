Return-Path: <SRS0=97QR=4I=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18721C5ACC4
	for <linux-fstests@archiver.kernel.org>; Thu, 20 Feb 2020 02:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24012465D
	for <linux-fstests@archiver.kernel.org>; Thu, 20 Feb 2020 02:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="miPX8YzI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbgBTCRX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 19 Feb 2020 21:17:23 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:42814 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbgBTCRX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 19 Feb 2020 21:17:23 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01K2HIOo183385;
        Thu, 20 Feb 2020 02:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=DROd7Uz2H0Skva3fw70lvjLz3s7Lk0R3tHjHNtpcTKQ=;
 b=miPX8YzIeU6JEmFfhkAgnE6AhmuZcZCfBXZt+s1jYRFUpr9SdvKaAX3e2jpAfBNpme3g
 6SN/4ewubrc1HZ0/Kki8S6ZW07AcyhKERXFtkreLwcD1eN6uFNJaNGOIm7/t+cxK6MaQ
 oxj9rorrdfkS+8/yG1aO6xj4g1aoPpr7V3wd6coIYuoHZXYndnbBS+uXrONeCboR+TRy
 6V/lh5uA5xnyrWNUfLxfVw4nb70Cvp4U6u4z9Ik8fD6kZUx21RPDvUMe4FF+r4H8cMjK
 J82v09euOlvhYEZZa1TaWzUFh74GUABXEmSPXptQbSh0T2B9juNEOtEvd21YNMhUpf4g ng== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2y8udkevwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 02:17:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01K27mnC096319;
        Thu, 20 Feb 2020 02:17:13 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2y8ud9cbu1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 02:17:12 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01K2HCmL021285;
        Thu, 20 Feb 2020 02:17:12 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Feb 2020 18:17:12 -0800
Date:   Wed, 19 Feb 2020 18:17:09 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc:     guaneryu@gmail.com, fstests@vger.kernel.org
Subject: Re: [PATCH v1 1/2] generic/054,055: add _require_v2log
Message-ID: <20200220021709.GF9504@magnolia>
References: <1582010652-1124-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200219050622.GB9504@magnolia>
 <b42c4b51-84b5-15aa-0a9d-a3375e08d66b@cn.fujitsu.com>
 <20200219221128.GE9511@magnolia>
 <8b833401-4ffa-e8b5-48e2-2ce63a2690ba@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b833401-4ffa-e8b5-48e2-2ce63a2690ba@cn.fujitsu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200015
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 adultscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 mlxlogscore=999 phishscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002200016
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Feb 20, 2020 at 10:01:30AM +0800, Yang Xu wrote:
> 
> 
> on 2020/02/20 6:11, Darrick J. Wong wrote:
> > On Wed, Feb 19, 2020 at 04:48:07PM +0800, Yang Xu wrote:
> > > 
> > > 
> > > on 2020/02/19 13:06, Darrick J. Wong wrote:
> > > > On Tue, Feb 18, 2020 at 03:24:10PM +0800, Yang Xu wrote:
> > > > > This two case fail on my server machine with GPT disklabe type,
> > > > > info as below:
> > > > > mount failed: -o logbsize=32k
> > > > > dmesg info as below:
> > > > > [92633.871954] XFS (sda7): logbuf size must be greater than or equal to log stripe size
> > > > > 
> > > > > The min logbuf size is 256k on my server machine. It needs to use _require_v2log to check.
> > > > 
> > > > Works fine here.  What is sda7's storage and raid alignment
> > > > configuration?
> > > /dev/sda is a SAS disk, raid aligment is 256k.  When I mkfs.xfs -f
> > > /dev/sda7(20G), its lsunit value is 64blks(block size is 4k).
> > 
> > _require_v2log probably ought to be smarter about that.
> maybe _require_v2log to specify logbszie for mount options?
> > 
> > But, uh, seeing as generic/05[45] don't currently call _require_v2log,
> > how did logbsize=32k end up in the mount options to fail those two
> > tests?
> > 
> But generic/05[45] call _get_log_configs. It will use _xfs_log_config
> and _xfs_log_config calls logbszie=32k/64k/128k/256k for mount options.
> So xfs/xfs_super.c xfs_finish_flag will report EINVAL error if logbsize <
> logsunit.  So on my machine this case failed without calling _require_v2log.

logbsize=32k is a perfectly valid option on a fs with a v2 log, provided
the log sunit isn't larger than 32k.  _require_v2log conveniently
_notruns the test when mounting with logbsize=32k fails, but
maybe the problem here is that generic/05[45] need to format the fs with
-l su=0 so that we can exercise full control over the mount options?

--D

> Best Regards
> Yang Xu
> > --D
> > 
> > > Best Regards
> > > Yang Xu
> > > > 
> > > > --D
> > > > 
> > > > > Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> > > > > ---
> > > > >    common/log        | 1 +
> > > > >    tests/generic/054 | 1 +
> > > > >    tests/generic/055 | 1 +
> > > > >    3 files changed, 3 insertions(+)
> > > > > 
> > > > > diff --git a/common/log b/common/log
> > > > > index c7921f50..f82919a6 100644
> > > > > --- a/common/log
> > > > > +++ b/common/log
> > > > > @@ -494,6 +494,7 @@ _log_version()
> > > > >    _require_v2log()
> > > > >    {
> > > > > +    [ "$FSTYP" != xfs ] && return 0
> > > > >        # test out mkfs to see if it supports "-l version=2"
> > > > >        export MKFS_OPTIONS="-l version=2"
> > > > >        if ! _scratch_mkfs_xfs >>$seqres.full 2>&1; then
> > > > > diff --git a/tests/generic/054 b/tests/generic/054
> > > > > index 95d40c3c..b4b74615 100755
> > > > > --- a/tests/generic/054
> > > > > +++ b/tests/generic/054
> > > > > @@ -30,6 +30,7 @@ rm -f $seqres.full $tmp.*
> > > > >    _require_scratch
> > > > >    _require_scratch_shutdown
> > > > >    _require_logstate
> > > > > +_require_v2log
> > > > >    echo "*** init FS"
> > > > >    _scratch_unmount >/dev/null 2>&1
> > > > > diff --git a/tests/generic/055 b/tests/generic/055
> > > > > index 9715f27b..071c4eaf 100755
> > > > > --- a/tests/generic/055
> > > > > +++ b/tests/generic/055
> > > > > @@ -57,6 +57,7 @@ rm -f $seqres.full $tmp.*
> > > > >    _require_scratch
> > > > >    _require_scratch_shutdown
> > > > >    _require_logstate
> > > > > +_require_v2log
> > > > >    QUOTA_OPTION=`_get_quota_option`
> > > > > -- 
> > > > > 2.18.0
> > > > > 
> > > > > 
> > > > > 
> > > > 
> > > > 
> > > 
> > > 
> > 
> > 
> 
> 

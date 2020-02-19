Return-Path: <SRS0=KIFJ=4H=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35057C34022
	for <linux-fstests@archiver.kernel.org>; Wed, 19 Feb 2020 05:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0771E206DB
	for <linux-fstests@archiver.kernel.org>; Wed, 19 Feb 2020 05:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gcGjgagC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbgBSFHs (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 19 Feb 2020 00:07:48 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39424 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgBSFHs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 19 Feb 2020 00:07:48 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01J548Y4026818;
        Wed, 19 Feb 2020 05:07:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=xockQTLJs6gBl4GHczccSEs97KPzDI03CnHm+iUTd+k=;
 b=gcGjgagCi5UkWA8X/X1QaFT1boBdFG22MPvTH7zFRK7EsDqT0M/DaCxH6MXv8L/vvXaf
 IO+mbSlfBa/pJw3OVw6C+l5GbKc85vS+E2QfjZ0yKGhA3AFqbeNCADzDZ8rIs9OC2XGU
 vPalOJ1p3d+Tc19ZqxPbvN8eYY0Y1jXmHnG4TrgnIH0okbdzZ2g+6jodk9fy4X5JAS5w
 Xn7pgMolVxy5QAiaWYFs2ZxPuyXeeayTaFGEzKoFhIqVLBKtSORspPBQ8Fo2GejO8OwE
 SzDIbK9f4FixtLbu8jedZf8ny78GRiUVwIghIV36BW/WhnKHznyVc6e+18We1gNaOc4I AA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2y8ud10k2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 05:07:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01J57hUK011574;
        Wed, 19 Feb 2020 05:07:43 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2y8ud3b6ft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 05:07:43 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01J57hgd009712;
        Wed, 19 Feb 2020 05:07:43 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Feb 2020 21:07:30 -0800
Date:   Tue, 18 Feb 2020 21:07:29 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/029: filter out "extended-header: cycle: 1" from
 output
Message-ID: <20200219050729.GC9504@magnolia>
References: <1581922940-14074-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200219003204.GA9511@magnolia>
 <e5c3a5d8-23d2-4760-a9b0-dbe70c53d3bf@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5c3a5d8-23d2-4760-a9b0-dbe70c53d3bf@cn.fujitsu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002190034
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002190033
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Feb 19, 2020 at 09:27:29AM +0800, Yang Xu wrote:
> 
> 
> on 2020/02/19 8:32, Darrick J. Wong wrote:
> > On Mon, Feb 17, 2020 at 03:02:20PM +0800, Yang Xu wrote:
> > > When I test this case under GPT disklabel type, this case will fail,
> > > as below:
> > > cycle: 1        version: 2              lsn: 1,0        tail_lsn: 1,0
> > > length of Log Record: 258048    prev offset: -1         num ops: 1
> > > 
> > > ...
> > > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > extended-header: cycle: 1
> > > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > ...
> > > 
> > > my mkfs information as below:
> > > meta-data=/dev/sda7              isize=512    agcount=16, agsize=327680 blks
> > >           =                       sectsz=512   attr=2, projid32bit=1
> > >           =                       crc=1        finobt=1, sparse=1, rmapbt=0
> > >           =                       reflink=1
> > > data     =                       bsize=4096   blocks=5242880, imaxpct=25
> > >           =                       sunit=64     swidth=64 blks
> > > naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
> > > log      =internal log           bsize=4096   blocks=5184, version=2
> > >           =                       sectsz=512   sunit=64 blks, lazy-count=1
> > > realtime =none                   extsz=4096   blocks=0, rtextents=0
> > > 
> > > It reports this info because xfs_logprint only read 32k header every time, so it
> > > needs to read more times. We can filter this useless info.
> > > 
> > > Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> > > ---
> > >   tests/xfs/029 | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tests/xfs/029 b/tests/xfs/029
> > > index f532a21b..99742792 100755
> > > --- a/tests/xfs/029
> > > +++ b/tests/xfs/029
> > > @@ -45,7 +45,7 @@ echo
> > >   _scratch_mkfs_xfs | _filter_mkfs 2>/dev/null
> > >   echo
> > > -_scratch_xfs_logprint | _filter_logprint
> > > +_scratch_xfs_logprint | _filter_logprint | sed -e "/^~~~/d" -e "/extended-header/d"
> > 
> > Is there a reason not to add that to _filter_logprint?
> I haven't mastered perl(never used). Can you add that to filter_logprint?

That helper function does not call perl.

--D

> Best Regards
> Yang Xu
> > 
> > --D
> > 
> > >   status=0
> > >   exit
> > > -- 
> > > 2.18.0
> > > 
> > > 
> > > 
> > 
> > 
> 
> 

Return-Path: <SRS0=2A/Q=7X=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5A8C433E0
	for <linux-fstests@archiver.kernel.org>; Wed, 10 Jun 2020 16:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDD332070B
	for <linux-fstests@archiver.kernel.org>; Wed, 10 Jun 2020 16:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uQlB3CI7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgFJQAA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 10 Jun 2020 12:00:00 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57516 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgFJQAA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 10 Jun 2020 12:00:00 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05AFwg7u151603;
        Wed, 10 Jun 2020 15:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=g4y3r3dF0gkkmU00TiZj875VTyLW/jfBzIG0QkHG/XU=;
 b=uQlB3CI7o04CCBXi+bBsT5+RfzVmroN5+8QHFj/BfWMPVJAdLQU4sR9zJmfv3Hp+nqGZ
 ekrV6byPxaeOc9hKunc2tnCrSod3VnP7CuQQvwBaXuvkjpuWomR7w9oq6hehvrrGJna4
 ynx1Ge5mQ8EwqRjG1sW40BxAVJospXSthVIvinUzMVn2HkxL7kdn5LWWRtIpAamQ2ZXk
 YHalllicCfdi/KAXftSQG4B6AEJH6i+PBNvrQXnLoYHSbRu6AHFa2OVlho/4nyws5s9s
 5/Yp1THOK7q9vU48Yb7ZG4Khkz5xhsZyUoLpkeUzFbWbLoD2iEtRPcGF49VQVKuxBfyj ug== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 31g2jrb8av-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Jun 2020 15:59:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05AFwP2D096078;
        Wed, 10 Jun 2020 15:59:53 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 31gn29c9k5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Jun 2020 15:59:53 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05AFxoMG011279;
        Wed, 10 Jun 2020 15:59:50 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Jun 2020 08:59:50 -0700
Date:   Wed, 10 Jun 2020 08:59:49 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     fstests@vger.kernel.org, ira.weiny@intel.com
Subject: Re: [PATCH 4/4] xfs/260: Move xfs/260 to generic
Message-ID: <20200610155949.GD11255@magnolia>
References: <20200603140115.30392-1-yangx.jy@cn.fujitsu.com>
 <20200603140115.30392-4-yangx.jy@cn.fujitsu.com>
 <20200609164218.GB11255@magnolia>
 <5EE07ACD.3080405@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5EE07ACD.3080405@cn.fujitsu.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9647 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=1 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006100121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9647 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 cotscore=-2147483648 priorityscore=1501 spamscore=0 suspectscore=1
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006100121
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jun 10, 2020 at 02:16:45PM +0800, Xiao Yang wrote:
> On 2020/6/10 0:42, Darrick J. Wong wrote:
> > On Wed, Jun 03, 2020 at 10:01:15PM +0800, Xiao Yang wrote:
> > > Both ext4 and xfs support per-inode DAX flag now so move it to generic.
> > > 
> > > Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
> > > ---
> > >   tests/{xfs/260 =>  generic/602} | 12 ++++++++----
> > >   tests/generic/602.out          |  2 ++
> > >   tests/generic/group            |  1 +
> > >   tests/xfs/260.out              |  2 --
> > >   tests/xfs/group                |  1 -
> > >   5 files changed, 11 insertions(+), 7 deletions(-)
> > >   rename tests/{xfs/260 =>  generic/602} (91%)
> > >   create mode 100644 tests/generic/602.out
> > >   delete mode 100644 tests/xfs/260.out
> > > 
> > > diff --git a/tests/xfs/260 b/tests/generic/602
> > > similarity index 91%
> > > rename from tests/xfs/260
> > > rename to tests/generic/602
> > > index fbdc4cd8..0cd20f31 100755
> > > --- a/tests/xfs/260
> > > +++ b/tests/generic/602
> > > @@ -2,7 +2,7 @@
> > >   # SPDX-License-Identifier: GPL-2.0
> > >   # Copyright (c) 2017 Red Hat Inc.  All Rights Reserved.
> > >   #
> > > -# FS QA Test 260
> > > +# FS QA Test 602
> > >   #
> > >   # Test per-inode DAX flag by mmap direct/buffered IO.
> > >   #
> > > @@ -28,7 +28,7 @@ _cleanup()
> > >   # remove previous $seqres.full before test
> > >   rm -f $seqres.full
> > > 
> > > -_supported_fs xfs
> > > +_supported_fs generic
> > >   _supported_os Linux
> > >   _require_scratch_dax_mountopt "dax"
> > >   _require_test_program "feature"
> > > @@ -121,8 +121,12 @@ do_tests()
> > >   	t_dax_flag_mmap_dio $((64 * 1024 * 1024))
> > >   }
> > > 
> > > -# make xfs 2Mb aligned for PMD fault testing
> > > -_scratch_mkfs "-d su=2m,sw=1">  /dev/null 2>&1
> > > +# make 2Mb aligned for PMD fault testing
> > > +mkfs_opts=""
> > > +[ "$FSTYP" = "ext4" ]&&  mkfs_opts="-E stride=512,stripe_width=1"
> > > +[ "$FSTYP" = "xfs" ]&&  mkfs_opts="-d su=2m,sw=1"
> > 
> > /me wonders if this ought to be smart enough to sniff out the hugepage
> > size on the test machine...
> Hi Darrick,
> 
> PMD page is always 2M, I am not sure why we need to sniff out the hugepage
> size?  Could you give me an example?

arm64, which can have 512M hugepages.
ppc64, which can have 16M huge pages (I think?)

--D

> Best Regards,
> Xiao Yang
> > 
> > --D
> > 
> > > +
> > > +_scratch_mkfs "$mkfs_opts">  /dev/null 2>&1
> > > 
> > >   # mount with dax option
> > >   _scratch_mount "-o dax"
> > > diff --git a/tests/generic/602.out b/tests/generic/602.out
> > > new file mode 100644
> > > index 00000000..61976e5e
> > > --- /dev/null
> > > +++ b/tests/generic/602.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 602
> > > +Silence is golden
> > > diff --git a/tests/generic/group b/tests/generic/group
> > > index c6ce029c..4bda3772 100644
> > > --- a/tests/generic/group
> > > +++ b/tests/generic/group
> > > @@ -604,3 +604,4 @@
> > >   599 auto quick remount shutdown
> > >   600 auto quick quota
> > >   601 auto quick quota
> > > +602 auto attr quick dax
> > > diff --git a/tests/xfs/260.out b/tests/xfs/260.out
> > > deleted file mode 100644
> > > index 18ca517c..00000000
> > > --- a/tests/xfs/260.out
> > > +++ /dev/null
> > > @@ -1,2 +0,0 @@
> > > -QA output created by 260
> > > -Silence is golden
> > > diff --git a/tests/xfs/group b/tests/xfs/group
> > > index daf54add..71c30898 100644
> > > --- a/tests/xfs/group
> > > +++ b/tests/xfs/group
> > > @@ -257,7 +257,6 @@
> > >   257 auto quick clone
> > >   258 auto quick clone
> > >   259 auto quick
> > > -260 auto attr quick dax
> > >   261 auto quick quota
> > >   262 dangerous_fuzzers dangerous_scrub dangerous_online_repair
> > >   263 auto quick quota
> > > --
> > > 2.21.0
> > > 
> > > 
> > > 
> > 
> > 
> > .
> > 
> 
> 
> 

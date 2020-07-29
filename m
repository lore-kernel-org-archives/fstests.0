Return-Path: <SRS0=d97O=BI=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAEAC433DF
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jul 2020 03:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83C2520672
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jul 2020 03:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h4gQjQAA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgG2DV4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 28 Jul 2020 23:21:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44042 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgG2DVz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 28 Jul 2020 23:21:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06T3H3W2002365;
        Wed, 29 Jul 2020 03:21:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=r5C2rzYgkLoeCbcQk00khm+0ps9DFpcxujhR7OPsG7w=;
 b=h4gQjQAA6eiWPnaASG2WNuwnRYw49oMyaaKrYQx7BF5r+J+PBGKrV+5GPfIR5ed3yrzo
 G42EzaebMbYo3eEBnnvwfaeUFnVM5d5GCu33FNLgXCI/jGrNhhRCmvsU9InsfVEiYB2w
 oNGJ0bjl83CXPrcfOJ5sOrJb3a/4Uv+OnW4viMcmv+HK8m+P1CZMqYce80P7N2hEHAVz
 7N/gB0w2sAvX+ZNr/DeQo6rrJjWe3H3hQ5HxFoIyLJ3420KScVyfmLijtKNH3fLRXTXT
 CeChgmqzFoO18wR4tGrFMETmyM20gEpX1BfCXzGWl4cJqkR+j0syuQSQ6W6adZA9PxdP ng== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 32hu1jb2kd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Jul 2020 03:21:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06T3IaXe091515;
        Wed, 29 Jul 2020 03:21:49 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 32hu5u03c6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jul 2020 03:21:48 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06T3LlKn028022;
        Wed, 29 Jul 2020 03:21:47 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Jul 2020 20:21:47 -0700
Date:   Tue, 28 Jul 2020 20:21:45 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc:     Eryu Guan <guaneryu@gmail.com>, fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH] xfs: test that reflink forces the log if mounted with
 wsync
Message-ID: <20200729032145.GQ7625@magnolia>
References: <20200729025203.GX7600@magnolia>
 <0fd7ab73-9b6b-7e71-c50a-c829aaa89326@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fd7ab73-9b6b-7e71-c50a-c829aaa89326@cn.fujitsu.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9696 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007290024
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9696 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1011
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007290024
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 29, 2020 at 11:02:09AM +0800, Yang Xu wrote:
> Hi Darrick
> 
> I remember this case has been merged into xfstests.
> 
> See
> https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=06fd8dbbfe314410a2f55168f92e98ab93666013

DOH.  You're right, sorry about that.  self-NAK.

--D

> Best Regards
> Yang Xu
> 
> > From: Darrick J. Wong <darrick.wong@oracle.com>
> > 
> > A code inspection revealed that reflink does not force the log to disk
> > even if the filesystem is mounted with wsync.  Add a regression test for
> > commit 5833112df7e9a ("xfs: reflink should force the log out if mounted
> > with wsync").
> > 
> > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> > ---
> >   tests/xfs/914     |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >   tests/xfs/914.out |    7 ++++++
> >   tests/xfs/group   |    1 +
> >   3 files changed, 73 insertions(+)
> >   create mode 100755 tests/xfs/914
> >   create mode 100644 tests/xfs/914.out
> > 
> > diff --git a/tests/xfs/914 b/tests/xfs/914
> > new file mode 100755
> > index 00000000..b835394a
> > --- /dev/null
> > +++ b/tests/xfs/914
> > @@ -0,0 +1,65 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +# Copyright (c) 2020, Oracle and/or its affiliates.  All Rights Reserved.
> > +#
> > +# FS QA Test No. 914
> > +#
> > +# Make sure that reflink forces the log out if we mount with wsync.  We test
> > +# that it actually forced the log by immediately shutting down the fs without
> > +# flushing the log and then remounting to check file contents.
> > +
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=`pwd`
> > +tmp=/tmp/$$
> > +status=1    # failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +_cleanup()
> > +{
> > +	cd /
> > +	rm -f $tmp.*
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +. ./common/reflink
> > +
> > +# real QA test starts here
> > +_supported_fs xfs
> > +_supported_os Linux
> > +_require_scratch_reflink
> > +_require_cp_reflink
> > +
> > +rm -f $seqres.full
> > +
> > +# Format filesystem and set up quota limits
> > +_scratch_mkfs > $seqres.full
> > +_scratch_mount -o wsync >> $seqres.full
> > +
> > +# Set up initial files
> > +$XFS_IO_PROG -f -c 'pwrite -S 0x58 0 1m -b 1m' $SCRATCH_MNT/a >> $seqres.full
> > +$XFS_IO_PROG -f -c 'pwrite -S 0x59 0 1m -b 1m' $SCRATCH_MNT/c >> $seqres.full
> > +_cp_reflink $SCRATCH_MNT/a $SCRATCH_MNT/e
> > +_cp_reflink $SCRATCH_MNT/c $SCRATCH_MNT/d
> > +touch $SCRATCH_MNT/b
> > +sync
> > +
> > +# Test that setting the reflink flag on the dest file forces the log
> > +echo "test reflink flag not set"
> > +$XFS_IO_PROG -x -c "reflink $SCRATCH_MNT/a" -c 'shutdown' $SCRATCH_MNT/b >> $seqres.full
> > +_scratch_cycle_mount wsync
> > +md5sum $SCRATCH_MNT/a $SCRATCH_MNT/b | _filter_scratch
> > +
> > +# Test forcing the log even if both files are already reflinked
> > +echo "test reflink flag already set"
> > +$XFS_IO_PROG -x -c "reflink $SCRATCH_MNT/a" -c 'shutdown' $SCRATCH_MNT/d >> $seqres.full
> > +_scratch_cycle_mount wsync
> > +md5sum $SCRATCH_MNT/a $SCRATCH_MNT/d | _filter_scratch
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/xfs/914.out b/tests/xfs/914.out
> > new file mode 100644
> > index 00000000..6b19fc65
> > --- /dev/null
> > +++ b/tests/xfs/914.out
> > @@ -0,0 +1,7 @@
> > +QA output created by 914
> > +test reflink flag not set
> > +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> > +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/b
> > +test reflink flag already set
> > +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> > +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/d
> > diff --git a/tests/xfs/group b/tests/xfs/group
> > index d6e8d1c3..a3d87124 100644
> > --- a/tests/xfs/group
> > +++ b/tests/xfs/group
> > @@ -518,3 +518,4 @@
> >   518 auto quick quota
> >   519 auto quick reflink
> >   520 auto quick reflink
> > +914 auto quick reflink
> > 
> > 
> 
> 

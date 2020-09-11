Return-Path: <SRS0=EKaY=CU=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA83C433E2
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Sep 2020 19:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4132822208
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Sep 2020 19:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PZ2eCIsq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgIKTag (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 11 Sep 2020 15:30:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52076 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgIKTaL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 11 Sep 2020 15:30:11 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08BJSrCp196566;
        Fri, 11 Sep 2020 19:30:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=BvmZU8viTo+5GQm3xPre5ZHoM/xz9VMad1oTKxHeagc=;
 b=PZ2eCIsqPhQPzcID9nUFZHt+IY7MZB8gO74whrZEhrKCUqOxIPxWf7HCx4bx9L8+SI2Y
 Fp850kTdfmaEyf6V13RxiS7aVPSCqbG0xwgRDbrRQ7EA8D1DTHI/XTD5kPe7X+Ds190t
 ROvL5E9pTCviZLIlLszcv0YiajKMGE1Vuml2FQ+eClpW+ccvdW8ay9SX/KWWriy4g+lp
 TCeq1zaKrrjwGdPdljUihf3N8eFoMMp0DsEhVr7II0yULr+2G9W0mdbDjFGHJwVnZJ/Q
 4wV8gV7ExT0VbDRnnWRf87MXLY2Kx0FaMGJPr4ueGhAVyim2gNDRrwB1YP1hqfhxzuyM oQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 33c2mmg3hy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Sep 2020 19:30:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08BJPEVs019806;
        Fri, 11 Sep 2020 19:30:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 33cmkdug4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Sep 2020 19:30:07 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08BJU7FQ009150;
        Fri, 11 Sep 2020 19:30:07 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 11 Sep 2020 12:30:07 -0700
Date:   Fri, 11 Sep 2020 12:30:06 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Pavel Reichl <preichl@redhat.com>, fstests@vger.kernel.org
Subject: Re: [PATCH 1/1] generic: add test for boundary in
 xfs_attr_shortform_verify
Message-ID: <20200911193006.GA7954@magnolia>
References: <20200911133855.38997-1-preichl@redhat.com>
 <20200911133855.38997-2-preichl@redhat.com>
 <20200911182346.GH2937@dhcp-12-102.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911182346.GH2937@dhcp-12-102.nay.redhat.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9741 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009110155
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9741 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 clxscore=1011 mlxlogscore=999
 malwarescore=0 suspectscore=1 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009110156
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Sep 12, 2020 at 02:23:46AM +0800, Zorro Lang wrote:
> On Fri, Sep 11, 2020 at 03:38:55PM +0200, Pavel Reichl wrote:
> > Add a regression test to check that the boundary test
> > for the fixed-offset parts of xfs_attr_sf_entry
> > in xfs_attr_shortform_verify is not off by one.
> > 
> > This can be shown by:
> > 
> > touch file
> > setfattr -n user.a file
> > 
> > With help from Zorro. Thanks very much.
> > 
> > Signed-off-by: Pavel Reichl <preichl@redhat.com>
> > ---
> >  tests/generic/609     | 64 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/609.out |  8 ++++++
> >  tests/generic/group   |  1 +
> >  3 files changed, 73 insertions(+)
> >  create mode 100755 tests/generic/609
> >  create mode 100644 tests/generic/609.out
> > 
> > diff --git a/tests/generic/609 b/tests/generic/609
> > new file mode 100755
> > index 00000000..fd632e86
> > --- /dev/null
> > +++ b/tests/generic/609
> > @@ -0,0 +1,64 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2020 Red Hat, Inc. All Rights Reserved.
> > +#
> > +# FS QA Test 609
> > +#
> > +# Verify that metadata won't get corrupted when extended attribute
> > +# name of size one is set.
> 
> You can specify this case cover which upstream fix(commit).
> 
> > +
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=`pwd`
> > +tmp=/tmp/$$
> > +status=1	# failure is the default!
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
> > +. ./common/attr
> > +
> > +# remove previous $seqres.full before test
> > +rm -f $seqres.full
> > +
> > +# real QA test starts here
> > +
> > +_supported_fs generic
> > +_supported_os Linux
> > +_require_scratch
> > +_require_attrs
> > +
> > +TESTFILE="${SCRATCH_MNT}/testfile"
> > +
> > +echo "+ create scratch fs"
> > +_scratch_mkfs > /dev/null 2>&1
> > +
> > +echo "+ mount fs image"
> 
> I don't think such detailed log output for each of step are needed, but you can
> keep it if you'd like that :)
> 
> > +_scratch_mount
> > +
> > +echo "+ make test file"
> > +touch "${TESTFILE}"
> > +
> > +echo "+ set file attributes"
> > +"${SETFATTR_PROG}" -n user.a "${TESTFILE}"
> > +
> > +echo 3 > /proc/sys/vm/drop_caches
> > +sleep 3
> 
> I think you'd better to add a comment to explain why these two lines are needed.

Does _scratch_cycle_mount trigger it too?

> > +
> > +echo "+ get file attributes"
> > +"${GETFATTR_PROG}" --absolute-names -n user.a "${TESTFILE}" | grep "user.a"
> 
> From my testing, this step already can trigger an error if the bug isn't fixed.
> But due to this's a test for fs corruption, maybe a manual filesystem checking
> (_check_scratch_fs) is better at the end?
> 
> > +
> > +echo "+ umount fs image"
> > +umount "${SCRATCH_MNT}"
> 
> Use _scratch_unmount to umount SCRATCH_DEV
> 
> > +
> > +status=0
> > +exit
> > diff --git a/tests/generic/609.out b/tests/generic/609.out
> > new file mode 100644
> > index 00000000..aab84553
> > --- /dev/null
> > +++ b/tests/generic/609.out
> > @@ -0,0 +1,8 @@
> > +QA output created by 609
> > ++ create scratch fs
> > ++ mount fs image
> > ++ make test file
> > ++ set file attributes
> > ++ get file attributes
> > +user.a=""
> > ++ umount fs image
> > diff --git a/tests/generic/group b/tests/generic/group
> > index aa969bcb..66bfb9dd 100644
> > --- a/tests/generic/group
> > +++ b/tests/generic/group
> > @@ -611,3 +611,4 @@
> >  606 auto attr quick dax
> >  607 auto attr quick dax
> >  608 auto attr quick dax
> > +609 auto attr

"auto quick attr"?  Assuming this test runs in under 30s and doesn't
crash the kernel, right?

--D

> > -- 
> > 2.26.2
> > 
> 

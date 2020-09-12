Return-Path: <SRS0=iEcW=CV=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503C0C433E2
	for <linux-fstests@archiver.kernel.org>; Sat, 12 Sep 2020 12:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3D5E208B3
	for <linux-fstests@archiver.kernel.org>; Sat, 12 Sep 2020 12:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FY+8z+kS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbgILMHw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 12 Sep 2020 08:07:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32075 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725833AbgILMHu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 12 Sep 2020 08:07:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599912468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qmxG1DFRcpYoUB/6Lyk5otIG91ESq7Kc9y3SKs9cjug=;
        b=FY+8z+kS3MYeWxg9K/GzE1iu4w2Y5btClA6Rq6iYRj2Ojt02WI1kxUqAooYCckBFkAv+Y5
        Z1We6+KF7zmyCAgszHtxxjg7QULgR5ExOPsaGv8XY9IWenj2oTKxozhkcFUFE86mDJa+Ff
        4xMUAeLGCrrwmn/WLJCBtf5FoK5/C0I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-vNF2QlN_NgCnzk27n58Q7Q-1; Sat, 12 Sep 2020 08:07:46 -0400
X-MC-Unique: vNF2QlN_NgCnzk27n58Q7Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A269C1882FB3;
        Sat, 12 Sep 2020 12:07:45 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1BC4975122;
        Sat, 12 Sep 2020 12:07:44 +0000 (UTC)
Date:   Sat, 12 Sep 2020 20:21:36 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Pavel Reichl <preichl@redhat.com>, fstests@vger.kernel.org
Subject: Re: [PATCH 1/1] generic: add test for boundary in
 xfs_attr_shortform_verify
Message-ID: <20200912122136.GJ2937@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: "Darrick J. Wong" <darrick.wong@oracle.com>,
        Pavel Reichl <preichl@redhat.com>, fstests@vger.kernel.org
References: <20200911133855.38997-1-preichl@redhat.com>
 <20200911133855.38997-2-preichl@redhat.com>
 <20200911182346.GH2937@dhcp-12-102.nay.redhat.com>
 <20200911193006.GA7954@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911193006.GA7954@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Sep 11, 2020 at 12:30:06PM -0700, Darrick J. Wong wrote:
> On Sat, Sep 12, 2020 at 02:23:46AM +0800, Zorro Lang wrote:
> > On Fri, Sep 11, 2020 at 03:38:55PM +0200, Pavel Reichl wrote:
> > > Add a regression test to check that the boundary test
> > > for the fixed-offset parts of xfs_attr_sf_entry
> > > in xfs_attr_shortform_verify is not off by one.
> > > 
> > > This can be shown by:
> > > 
> > > touch file
> > > setfattr -n user.a file
> > > 
> > > With help from Zorro. Thanks very much.
> > > 
> > > Signed-off-by: Pavel Reichl <preichl@redhat.com>
> > > ---
> > >  tests/generic/609     | 64 +++++++++++++++++++++++++++++++++++++++++++
> > >  tests/generic/609.out |  8 ++++++
> > >  tests/generic/group   |  1 +
> > >  3 files changed, 73 insertions(+)
> > >  create mode 100755 tests/generic/609
> > >  create mode 100644 tests/generic/609.out
> > > 
> > > diff --git a/tests/generic/609 b/tests/generic/609
> > > new file mode 100755
> > > index 00000000..fd632e86
> > > --- /dev/null
> > > +++ b/tests/generic/609
> > > @@ -0,0 +1,64 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2020 Red Hat, Inc. All Rights Reserved.
> > > +#
> > > +# FS QA Test 609
> > > +#
> > > +# Verify that metadata won't get corrupted when extended attribute
> > > +# name of size one is set.
> > 
> > You can specify this case cover which upstream fix(commit).
> > 
> > > +
> > > +seq=`basename $0`
> > > +seqres=$RESULT_DIR/$seq
> > > +echo "QA output created by $seq"
> > > +
> > > +here=`pwd`
> > > +tmp=/tmp/$$
> > > +status=1	# failure is the default!
> > > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > > +
> > > +_cleanup()
> > > +{
> > > +	cd /
> > > +	rm -f $tmp.*
> > > +}
> > > +
> > > +# get standard environment, filters and checks
> > > +. ./common/rc
> > > +. ./common/filter
> > > +. ./common/attr
> > > +
> > > +# remove previous $seqres.full before test
> > > +rm -f $seqres.full
> > > +
> > > +# real QA test starts here
> > > +
> > > +_supported_fs generic
> > > +_supported_os Linux
> > > +_require_scratch
> > > +_require_attrs
> > > +
> > > +TESTFILE="${SCRATCH_MNT}/testfile"
> > > +
> > > +echo "+ create scratch fs"
> > > +_scratch_mkfs > /dev/null 2>&1
> > > +
> > > +echo "+ mount fs image"
> > 
> > I don't think such detailed log output for each of step are needed, but you can
> > keep it if you'd like that :)
> > 
> > > +_scratch_mount
> > > +
> > > +echo "+ make test file"
> > > +touch "${TESTFILE}"
> > > +
> > > +echo "+ set file attributes"
> > > +"${SETFATTR_PROG}" -n user.a "${TESTFILE}"
> > > +
> > > +echo 3 > /proc/sys/vm/drop_caches
> > > +sleep 3
> > 
> > I think you'd better to add a comment to explain why these two lines are needed.
> 
> Does _scratch_cycle_mount trigger it too?

Yes, cycle mount can make sure this change ondisk 100% :)

> 
> > > +
> > > +echo "+ get file attributes"
> > > +"${GETFATTR_PROG}" --absolute-names -n user.a "${TESTFILE}" | grep "user.a"
> > 
> > From my testing, this step already can trigger an error if the bug isn't fixed.
> > But due to this's a test for fs corruption, maybe a manual filesystem checking
> > (_check_scratch_fs) is better at the end?
> > 
> > > +
> > > +echo "+ umount fs image"
> > > +umount "${SCRATCH_MNT}"
> > 
> > Use _scratch_unmount to umount SCRATCH_DEV
> > 
> > > +
> > > +status=0
> > > +exit
> > > diff --git a/tests/generic/609.out b/tests/generic/609.out
> > > new file mode 100644
> > > index 00000000..aab84553
> > > --- /dev/null
> > > +++ b/tests/generic/609.out
> > > @@ -0,0 +1,8 @@
> > > +QA output created by 609
> > > ++ create scratch fs
> > > ++ mount fs image
> > > ++ make test file
> > > ++ set file attributes
> > > ++ get file attributes
> > > +user.a=""
> > > ++ umount fs image
> > > diff --git a/tests/generic/group b/tests/generic/group
> > > index aa969bcb..66bfb9dd 100644
> > > --- a/tests/generic/group
> > > +++ b/tests/generic/group
> > > @@ -611,3 +611,4 @@
> > >  606 auto attr quick dax
> > >  607 auto attr quick dax
> > >  608 auto attr quick dax
> > > +609 auto attr
> 
> "auto quick attr"?  Assuming this test runs in under 30s and doesn't
> crash the kernel, right?
> 
> --D
> 
> > > -- 
> > > 2.26.2
> > > 
> > 
> 


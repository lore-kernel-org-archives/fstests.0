Return-Path: <SRS0=iEcW=CV=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2363EC433E2
	for <linux-fstests@archiver.kernel.org>; Sat, 12 Sep 2020 13:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C66BC207BB
	for <linux-fstests@archiver.kernel.org>; Sat, 12 Sep 2020 13:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B9dcUqsl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbgILNUV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 12 Sep 2020 09:20:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43981 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725848AbgILNUU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 12 Sep 2020 09:20:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599916817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zja8KCuhTY4VyitURXRtFFClCglw6IqT2kz+3T6Xffw=;
        b=B9dcUqslVFOQUD8lDLOEmQVj+EWU1xEvg6JduGUnQSR46XpEHWWz8qu8U42oJfvseciedQ
        xmk2203FeBvrtVLmkwNtjffs+LwXclWutpuTailHH1wZnqJkBF/3Jx5k992w3nL0xerlH2
        4v51YIGW9O1KMj2JBHTPo3KaY7ql5Us=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347--nqcl91JOOeQ0c75T-pSMQ-1; Sat, 12 Sep 2020 09:20:15 -0400
X-MC-Unique: -nqcl91JOOeQ0c75T-pSMQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9D09801AC5
        for <fstests@vger.kernel.org>; Sat, 12 Sep 2020 13:20:14 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 674085D9F7;
        Sat, 12 Sep 2020 13:20:14 +0000 (UTC)
Date:   Sat, 12 Sep 2020 21:34:05 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Pavel Reichl <preichl@redhat.com>, fstests@vger.kernel.org
Subject: Re: [PATCH v3 1/1] generic: add test for boundary in
 xfs_attr_shortform_verify
Message-ID: <20200912133404.GL2937@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: Pavel Reichl <preichl@redhat.com>,
        fstests@vger.kernel.org
References: <20200912101953.114089-1-preichl@redhat.com>
 <20200912101953.114089-2-preichl@redhat.com>
 <20200912123134.GK2937@dhcp-12-102.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200912123134.GK2937@dhcp-12-102.nay.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Sep 12, 2020 at 08:31:34PM +0800, Zorro Lang wrote:
> On Sat, Sep 12, 2020 at 12:19:53PM +0200, Pavel Reichl wrote:
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
> 
> This looks good to me, if you don't tend to replace "drop cache" with "cycle
> mount" as Darrick suggested :) Both ways good to me, as you wish.

Oh, a tiny problem when I tried to merge this patch:

Applying: generic: add test for boundary in xfs_attr_shortform_verify
.git/rebase-apply/patch:87: new blank line at EOF.
+


> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>
> 
> Thanks,
> Zorro
> 
> >  tests/generic/609     | 63 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/609.out |  4 +++
> >  tests/generic/group   |  1 +
> >  3 files changed, 68 insertions(+)
> >  create mode 100755 tests/generic/609
> >  create mode 100644 tests/generic/609.out
> > 
> > diff --git a/tests/generic/609 b/tests/generic/609
> > new file mode 100755
> > index 00000000..f048b2ba
> > --- /dev/null
> > +++ b/tests/generic/609
> > @@ -0,0 +1,63 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2020 Red Hat, Inc. All Rights Reserved.
> > +#
> > +# FS QA Test 609
> > +#
> > +# Verify that metadata won't get corrupted when extended attribute
> > +# name of size one is set.
> > +#
> > +# This test verifies the problem fixed in kernel with commit
> > +# f4020438fab0 ("xfs: fix boundary test in xfs_attr_shortform_verify")
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
> > +_scratch_mkfs > $seqres.full 2>&1
> > +_scratch_mount
> > +
> > +localfile="${SCRATCH_MNT}/testfile"
> > +
> > +touch "${localfile}"
> > +"${SETFATTR_PROG}" -n user.a "${localfile}"
> > +
> > +# Make sure that changes are written to disk
> > +echo 3 > /proc/sys/vm/drop_caches
> > +sleep 3
> > +
> > +# If the target bug isn't fixed, getfattr fails
> > +${GETFATTR_PROG} --absolute-names -n user.a $localfile | _filter_scratch
> > +
> > +# Make sure the filesystem isn't corrupted manually
> > +_scratch_unmount
> > +_check_scratch_fs
> > +
> > +status=0
> > +exit
> > diff --git a/tests/generic/609.out b/tests/generic/609.out
> > new file mode 100644
> > index 00000000..d4ae152d
> > --- /dev/null
> > +++ b/tests/generic/609.out
> > @@ -0,0 +1,4 @@
> > +QA output created by 609
> > +# file: SCRATCH_MNT/testfile
> > +user.a=""
> > +
> > diff --git a/tests/generic/group b/tests/generic/group
> > index aa969bcb..6fa83c13 100644
> > --- a/tests/generic/group
> > +++ b/tests/generic/group
> > @@ -611,3 +611,4 @@
> >  606 auto attr quick dax
> >  607 auto attr quick dax
> >  608 auto attr quick dax
> > +609 auto attr quick
> > -- 
> > 2.26.2
> > 


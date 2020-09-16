Return-Path: <SRS0=FsZq=CZ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEB7C43461
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Sep 2020 01:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BD0B2137B
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Sep 2020 01:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JHsm8d2O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgIPBbF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 15 Sep 2020 21:31:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47822 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726039AbgIPBbE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 15 Sep 2020 21:31:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600219863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YnAtpiynjygam5TUqUKBHvkFE7JXuASOBokZs1ED9hs=;
        b=JHsm8d2Or5yzgPrIlYrdFYEqhGVoFjfx+0IbRagjApfUwuXyvavvwz0lQreY/3tKkYnPim
        Kxz2Y0+FvjPhMEY3OpOvtMF46rjS8PL1JEdRlixW0KlGiRUO/xzEVi4AXJpNpLYomuASKs
        3BCK4YStSZFeM3LCll2v350m8e6bcZc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-mHpYruUHOhGnWOPvw-TJbQ-1; Tue, 15 Sep 2020 21:31:01 -0400
X-MC-Unique: mHpYruUHOhGnWOPvw-TJbQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35624186DD20
        for <fstests@vger.kernel.org>; Wed, 16 Sep 2020 01:31:00 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A1AEC19C71
        for <fstests@vger.kernel.org>; Wed, 16 Sep 2020 01:30:59 +0000 (UTC)
Date:   Wed, 16 Sep 2020 09:44:57 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH v5 1/1] generic: add test for boundary in
 xfs_attr_shortform_verify
Message-ID: <20200916014457.GU2937@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: fstests@vger.kernel.org
References: <20200915132651.238212-1-preichl@redhat.com>
 <20200915132651.238212-2-preichl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915132651.238212-2-preichl@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Sep 15, 2020 at 03:26:51PM +0200, Pavel Reichl wrote:
> Add a regression test to check that the boundary test
> for the fixed-offset parts of xfs_attr_sf_entry
> in xfs_attr_shortform_verify is not off by one.
> 
> This can be shown by:
> 
> touch file
> setfattr -n user.a file
> 
> With help from Zorro. Thanks very much.
> 
> Signed-off-by: Pavel Reichl <preichl@redhat.com>
> ---

Looks good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/611     | 58 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/611.out |  2 ++
>  tests/generic/group   |  1 +
>  3 files changed, 61 insertions(+)
>  create mode 100755 tests/generic/611
>  create mode 100644 tests/generic/611.out
> 
> diff --git a/tests/generic/611 b/tests/generic/611
> new file mode 100755
> index 00000000..069db6f9
> --- /dev/null
> +++ b/tests/generic/611
> @@ -0,0 +1,58 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 Red Hat, Inc. All Rights Reserved.
> +#
> +# FS QA Test 611
> +#
> +# Verify that metadata won't get corrupted when extended attribute
> +# name of size one is set.
> +#
> +# This test verifies the problem fixed in kernel with commit
> +# f4020438fab0 ("xfs: fix boundary test in xfs_attr_shortform_verify")
> +
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/attr
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch
> +_require_attrs
> +
> +_scratch_mkfs > $seqres.full 2>&1
> +_scratch_mount
> +
> +localfile="${SCRATCH_MNT}/testfile"
> +
> +touch "${localfile}"
> +"${SETFATTR_PROG}" -n user.a "${localfile}"
> +
> +# Make sure that changes are written to disk
> +_scratch_cycle_mount
> +
> +# If the target bug isn't fixed, getfattr fails
> +${GETFATTR_PROG} --absolute-names -n user.a $localfile | grep 'user.a'
> +
> +status=0
> +exit
> diff --git a/tests/generic/611.out b/tests/generic/611.out
> new file mode 100644
> index 00000000..1ab12434
> --- /dev/null
> +++ b/tests/generic/611.out
> @@ -0,0 +1,2 @@
> +QA output created by 611
> +user.a=""
> diff --git a/tests/generic/group b/tests/generic/group
> index 8eba6c98..4af4b494 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -613,3 +613,4 @@
>  608 auto attr quick dax
>  609 auto quick rw
>  610 auto quick prealloc zero
> +611 auto quick attr
> -- 
> 2.26.2
> 


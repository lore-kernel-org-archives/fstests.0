Return-Path: <SRS0=iEcW=CV=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25F9C433E2
	for <linux-fstests@archiver.kernel.org>; Sat, 12 Sep 2020 04:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D864221E8
	for <linux-fstests@archiver.kernel.org>; Sat, 12 Sep 2020 04:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MKtl2Hvj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725800AbgILEeR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 12 Sep 2020 00:34:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58621 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725795AbgILEeQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 12 Sep 2020 00:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599885253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OSuE4j2uaS6eW+1faemkjguMj2DfnC/Ev/OxwUDqBuI=;
        b=MKtl2HvjH5G3232VFI4ure5O7Tuy3EHodE3QvTIbJvtfRsBpwXlPG8XdIBN2f1F6jcAh1x
        jKxlNE3hT8gij5yIl7juqViRxlI22Dp9lZJd9pXsDaWg5tzz+1QTa2NUniqi8A3e2Vn1rw
        MfNdi3jK9j90frwohgwC+NuRyGsSCnw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-ju9PFBGXMByUalZ-lACypw-1; Sat, 12 Sep 2020 00:34:11 -0400
X-MC-Unique: ju9PFBGXMByUalZ-lACypw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7557018B9EE3
        for <fstests@vger.kernel.org>; Sat, 12 Sep 2020 04:34:10 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E605575120;
        Sat, 12 Sep 2020 04:34:08 +0000 (UTC)
Date:   Sat, 12 Sep 2020 12:47:59 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 1/1] generic: add test for boundary in
 xfs_attr_shortform_verify
Message-ID: <20200912044759.GI2937@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: Pavel Reichl <preichl@redhat.com>,
        fstests@vger.kernel.org
References: <20200911221514.69318-1-preichl@redhat.com>
 <20200911221514.69318-2-preichl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911221514.69318-2-preichl@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Sep 12, 2020 at 12:15:14AM +0200, Pavel Reichl wrote:
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
>  tests/generic/609     | 66 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/609.out |  1 +
>  tests/generic/group   |  1 +
>  3 files changed, 68 insertions(+)
>  create mode 100755 tests/generic/609
>  create mode 100644 tests/generic/609.out
> 
> diff --git a/tests/generic/609 b/tests/generic/609
> new file mode 100755
> index 00000000..2feb37a2
> --- /dev/null
> +++ b/tests/generic/609
> @@ -0,0 +1,66 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 Red Hat, Inc. All Rights Reserved.
> +#
> +# FS QA Test 609
> +#
> +# Verify that metadata won't get corrupted when extended attribute
> +# name of size one is set.
> +#
> +# This test excercises the problem fixed in kernel with commit
                 ^^ exercises?
> +# xfs: fix boundary test in xfs_attr_shortform_verify

As this patch has been merged, specify the commit id might be better:)

f4020438fab0 ("xfs: fix boundary test in xfs_attr_shortform_verify")

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
> +TESTFILE="${SCRATCH_MNT}/testfile"
> +
> +_scratch_mkfs > /dev/null 2>&1
> +
> +_scratch_mount
> +
> +touch "${TESTFILE}"
> +
> +"${SETFATTR_PROG}" -n user.a "${TESTFILE}"
> +
> +# Make sure that changes are written to disk
> +echo 3 > /proc/sys/vm/drop_caches
> +sleep 3
> +
> +if [ ! _check_scratch_fs ]
> +then
> +	echo error detected in filesystem
> +	exit
> +fi

_check_scratch_fs prints error output if it fails, that will break golden file
and cause failure, so don't need to use the "if .... fi" to check that.

> +
> +_scratch_unmount
> +
> +status=0
> +exit

I'd like write this case something like below, just for reference:)

_scratch_mkfs > $seqres.full 2>&1
_scratch_mount

localfile=${SCRATCH_MNT}/testfile

touch $localfile
${SETFATTR_PROG} -n user.a $localfile

# Make sure that changes are written to disk
echo 3 > /proc/sys/vm/drop_caches
sleep 3

# If the target bug isn't fixed, getfattr fails
${GETFATTR_PROG} --absolute-names -n user.a $localfile | _filter_scratch

# Make sure the filesystem isn't corrupted manually
_scratch_unmount
_check_scrach_fs

status=0
exit


> diff --git a/tests/generic/609.out b/tests/generic/609.out
> new file mode 100644
> index 00000000..f85988af
> --- /dev/null
> +++ b/tests/generic/609.out
> @@ -0,0 +1 @@
> +QA output created by 609
> diff --git a/tests/generic/group b/tests/generic/group
> index aa969bcb..6fa83c13 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -611,3 +611,4 @@
>  606 auto attr quick dax
>  607 auto attr quick dax
>  608 auto attr quick dax
> +609 auto attr quick
> -- 
> 2.26.2
> 


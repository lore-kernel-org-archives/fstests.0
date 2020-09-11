Return-Path: <SRS0=EKaY=CU=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55430C43461
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Sep 2020 18:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F296322205
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Sep 2020 18:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hMtApXLj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgIKSKD (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 11 Sep 2020 14:10:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45794 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725841AbgIKSKC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 11 Sep 2020 14:10:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599847800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s2j7Nj7k0FgJXq5RQZK3s+rFDdI3IfoYxQFT6gPuMBI=;
        b=hMtApXLjrqfz3gPJCF5OSk13xiuAJEhOI6qWuqw/VxF2csLwo75beA834x896aHX6WzQy5
        w1ZBZmOk3ShTFin9Nev2ajXYiHATbvhAlEEtwkit/wEDex213vp3xQwRuPeMFtCnHMmOHU
        QHwv7hUPmoqyc0GlKspT4rdG3dwRkhk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-KRGjduBiN22_Zolt7B0KNA-1; Fri, 11 Sep 2020 14:09:58 -0400
X-MC-Unique: KRGjduBiN22_Zolt7B0KNA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2631800135
        for <fstests@vger.kernel.org>; Fri, 11 Sep 2020 18:09:57 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 204B97B7A1;
        Fri, 11 Sep 2020 18:09:56 +0000 (UTC)
Date:   Sat, 12 Sep 2020 02:23:46 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/1] generic: add test for boundary in
 xfs_attr_shortform_verify
Message-ID: <20200911182346.GH2937@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: Pavel Reichl <preichl@redhat.com>,
        fstests@vger.kernel.org
References: <20200911133855.38997-1-preichl@redhat.com>
 <20200911133855.38997-2-preichl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911133855.38997-2-preichl@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Sep 11, 2020 at 03:38:55PM +0200, Pavel Reichl wrote:
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
>  tests/generic/609     | 64 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/609.out |  8 ++++++
>  tests/generic/group   |  1 +
>  3 files changed, 73 insertions(+)
>  create mode 100755 tests/generic/609
>  create mode 100644 tests/generic/609.out
> 
> diff --git a/tests/generic/609 b/tests/generic/609
> new file mode 100755
> index 00000000..fd632e86
> --- /dev/null
> +++ b/tests/generic/609
> @@ -0,0 +1,64 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 Red Hat, Inc. All Rights Reserved.
> +#
> +# FS QA Test 609
> +#
> +# Verify that metadata won't get corrupted when extended attribute
> +# name of size one is set.

You can specify this case cover which upstream fix(commit).

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
> +echo "+ create scratch fs"
> +_scratch_mkfs > /dev/null 2>&1
> +
> +echo "+ mount fs image"

I don't think such detailed log output for each of step are needed, but you can
keep it if you'd like that :)

> +_scratch_mount
> +
> +echo "+ make test file"
> +touch "${TESTFILE}"
> +
> +echo "+ set file attributes"
> +"${SETFATTR_PROG}" -n user.a "${TESTFILE}"
> +
> +echo 3 > /proc/sys/vm/drop_caches
> +sleep 3

I think you'd better to add a comment to explain why these two lines are needed.

> +
> +echo "+ get file attributes"
> +"${GETFATTR_PROG}" --absolute-names -n user.a "${TESTFILE}" | grep "user.a"

From my testing, this step already can trigger an error if the bug isn't fixed.
But due to this's a test for fs corruption, maybe a manual filesystem checking
(_check_scratch_fs) is better at the end?

> +
> +echo "+ umount fs image"
> +umount "${SCRATCH_MNT}"

Use _scratch_unmount to umount SCRATCH_DEV

> +
> +status=0
> +exit
> diff --git a/tests/generic/609.out b/tests/generic/609.out
> new file mode 100644
> index 00000000..aab84553
> --- /dev/null
> +++ b/tests/generic/609.out
> @@ -0,0 +1,8 @@
> +QA output created by 609
> ++ create scratch fs
> ++ mount fs image
> ++ make test file
> ++ set file attributes
> ++ get file attributes
> +user.a=""
> ++ umount fs image
> diff --git a/tests/generic/group b/tests/generic/group
> index aa969bcb..66bfb9dd 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -611,3 +611,4 @@
>  606 auto attr quick dax
>  607 auto attr quick dax
>  608 auto attr quick dax
> +609 auto attr
> -- 
> 2.26.2
> 


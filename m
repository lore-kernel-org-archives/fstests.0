Return-Path: <SRS0=2o40=CW=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CBDC43461
	for <linux-fstests@archiver.kernel.org>; Sun, 13 Sep 2020 16:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7688122204
	for <linux-fstests@archiver.kernel.org>; Sun, 13 Sep 2020 16:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgIMQgu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 13 Sep 2020 12:36:50 -0400
Received: from out20-2.mail.aliyun.com ([115.124.20.2]:35880 "EHLO
        out20-2.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgIMQgs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 13 Sep 2020 12:36:48 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07983988|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0154458-0.000536433-0.984018;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03299;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.IWaQTSk_1600015003;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.IWaQTSk_1600015003)
          by smtp.aliyun-inc.com(10.147.41.138);
          Mon, 14 Sep 2020 00:36:43 +0800
Date:   Mon, 14 Sep 2020 00:36:42 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org, zlang@redhad.com
Subject: Re: [PATCH v3 1/1] generic: add test for boundary in
 xfs_attr_shortform_verify
Message-ID: <20200913163642.GK3853@desktop>
References: <20200912101953.114089-1-preichl@redhat.com>
 <20200912101953.114089-2-preichl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200912101953.114089-2-preichl@redhat.com>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Sep 12, 2020 at 12:19:53PM +0200, Pavel Reichl wrote:
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
>  tests/generic/609     | 63 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/609.out |  4 +++
>  tests/generic/group   |  1 +
>  3 files changed, 68 insertions(+)
>  create mode 100755 tests/generic/609
>  create mode 100644 tests/generic/609.out
> 
> diff --git a/tests/generic/609 b/tests/generic/609
> new file mode 100755
> index 00000000..f048b2ba
> --- /dev/null
> +++ b/tests/generic/609
> @@ -0,0 +1,63 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 Red Hat, Inc. All Rights Reserved.
> +#
> +# FS QA Test 609
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
> +echo 3 > /proc/sys/vm/drop_caches
> +sleep 3

If _scratch_cycle_mount also works, I'd prefer it over a system-wide
drop cache.

And is "sleep 3" really needed?

> +
> +# If the target bug isn't fixed, getfattr fails
> +${GETFATTR_PROG} --absolute-names -n user.a $localfile | _filter_scratch
> +
> +# Make sure the filesystem isn't corrupted manually
> +_scratch_unmount
> +_check_scratch_fs

The test harness will do fsck by default after test, so there's no need
to _check_scratch_fs manually.

Thanks,
Eryu

> +
> +status=0
> +exit
> diff --git a/tests/generic/609.out b/tests/generic/609.out
> new file mode 100644
> index 00000000..d4ae152d
> --- /dev/null
> +++ b/tests/generic/609.out
> @@ -0,0 +1,4 @@
> +QA output created by 609
> +# file: SCRATCH_MNT/testfile
> +user.a=""
> +
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

Return-Path: <SRS0=ByK3=C5=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5521BC43463
	for <linux-fstests@archiver.kernel.org>; Sun, 20 Sep 2020 16:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2188D206E5
	for <linux-fstests@archiver.kernel.org>; Sun, 20 Sep 2020 16:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgITQLB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 20 Sep 2020 12:11:01 -0400
Received: from out20-14.mail.aliyun.com ([115.124.20.14]:40642 "EHLO
        out20-14.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgITQLB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 20 Sep 2020 12:11:01 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07448193|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.28441-0.000771387-0.714819;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03294;MF=guan@eryu.me;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.IZnhOXF_1600618255;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.IZnhOXF_1600618255)
          by smtp.aliyun-inc.com(10.147.41.137);
          Mon, 21 Sep 2020 00:10:55 +0800
Date:   Mon, 21 Sep 2020 00:10:55 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] xfs: Add test for too-small device with stripe
 geometry
Message-ID: <20200920161055.GO3853@desktop>
References: <20200918061514.115764-1-preichl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918061514.115764-1-preichl@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Sep 18, 2020 at 08:15:14AM +0200, Pavel Reichl wrote:
> Verify hat an attempt to create a too-small device with stripe geometry,
> is handled gracefully instead of hitting an assert in align_ag_geometry()
> 
> Signed-off-by: Pavel Reichl <preichl@redhat.com>
> ---
>  tests/xfs/260     | 52 +++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/260.out |  2 ++
>  tests/xfs/group   |  1 +
>  3 files changed, 55 insertions(+)
>  create mode 100755 tests/xfs/260
>  create mode 100644 tests/xfs/260.out
> 
> diff --git a/tests/xfs/260 b/tests/xfs/260
> new file mode 100755
> index 00000000..4e81d634
> --- /dev/null
> +++ b/tests/xfs/260
> @@ -0,0 +1,52 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 YOUR NAME HERE.  All Rights Reserved.
                        ^^^^^^^^^^^^^^^
Please update copyright.

> +#
> +# FS QA Test 260
> +#
> +# Verify that an attempt to create a too-small device with stripe geometry,
> +# is handled gracefully instead of hitting an assert in align_ag_geometry()
> +#
> +# This test verifies the problem fixed in kernel with commit
> +# (mkfs.xfs: fix ASSERT on too-small device with stripe geometry)

This looks like an xfsprogs patch, instead of a kernel patch.

> +#
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
> +	rm -f $localfile
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +echo 'Silence is golden'
> +
> +_supported_fs xfs
> +_supported_os Linux
> +_require_test
> +
> +localfile=$TEST_DIR/260.$$

Instead of hardcoding it, 260 could be replaced by $seq

> +
> +truncate --size=10444800 $localfile

$XFS_IO -c "truncate 10444800" $localfile

Historically, truncate(1) is not recommended as some (very old) distros
don't have it (e.g. RHEL5), though most mordern distros (if not all)
should have it installed, we'd keep things consistent and perfer the
xfs_io way.

Thanks,
Eryu

> +
> +$MKFS_XFS_PROG -dsu=65536,sw=1 $localfile >> $seqres.full 2>&1
> +
> +[ $? -ne 1 ] && echo "${MKFS_XFS_PROG} should fail gracefully"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/xfs/260.out b/tests/xfs/260.out
> new file mode 100644
> index 00000000..18ca517c
> --- /dev/null
> +++ b/tests/xfs/260.out
> @@ -0,0 +1,2 @@
> +QA output created by 260
> +Silence is golden
> diff --git a/tests/xfs/group b/tests/xfs/group
> index ed0d389e..7a6dfed7 100644
> --- a/tests/xfs/group
> +++ b/tests/xfs/group
> @@ -257,6 +257,7 @@
>  257 auto quick clone
>  258 auto quick clone
>  259 auto quick
> +260 auto quick mkfs
>  261 auto quick quota
>  262 dangerous_fuzzers dangerous_scrub dangerous_online_repair
>  263 auto quick quota
> -- 
> 2.26.2

Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0870C433C1
	for <linux-fstests@archiver.kernel.org>; Sun, 28 Mar 2021 14:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6E036196E
	for <linux-fstests@archiver.kernel.org>; Sun, 28 Mar 2021 14:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhC1OSt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 28 Mar 2021 10:18:49 -0400
Received: from out20-25.mail.aliyun.com ([115.124.20.25]:52409 "EHLO
        out20-25.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhC1OSa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 28 Mar 2021 10:18:30 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07437334|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0416869-0.00310213-0.955211;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047203;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.JrYCtEB_1616941107;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.JrYCtEB_1616941107)
          by smtp.aliyun-inc.com(10.147.41.231);
          Sun, 28 Mar 2021 22:18:27 +0800
Date:   Sun, 28 Mar 2021 22:18:27 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org, zlang@redhat.com
Subject: Re: [PATCH v2] xfs: Add test for printing deprec. mount options
Message-ID: <YGCQM+oIgMSKFit8@desktop>
References: <20210319222019.576377-1-preichl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319222019.576377-1-preichl@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Mar 19, 2021 at 11:20:19PM +0100, Pavel Reichl wrote:
> Verify that warnings about deprecated mount options are properly
> printed.
> 
> Verify that no excessive warnings are printed during remounts.
> 
> Signed-off-by: Pavel Reichl <preichl@redhat.com>
> ---
>  tests/xfs/539     | 87 +++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/539.out |  2 ++
>  tests/xfs/group   |  1 +
>  3 files changed, 90 insertions(+)
>  create mode 100755 tests/xfs/539
>  create mode 100644 tests/xfs/539.out
> 
> diff --git a/tests/xfs/539 b/tests/xfs/539
> new file mode 100755
> index 00000000..f90462c3
> --- /dev/null
> +++ b/tests/xfs/539
> @@ -0,0 +1,87 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 Red Hat, Inc.. All Rights Reserved.
> +#
> +# FS QA Test 539
> +#
> +# https://bugzilla.kernel.org/show_bug.cgi?id=211605
> +# Verify that the warnings are not printed on remount if the mount option has
> +# the same value as during the mount
> +#
> +# Regression test for commit:
> +# xfs: Skip repetitive warnings about mount options
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
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +_require_check_dmesg
> +_supported_fs xfs
> +_require_scratch
> +
> +log_tag()
> +{
> +	echo "fstests $seqnum [tag]" > /dev/kmsg
> +}
> +
> +dmesg_since_test_tag()
> +{
> +	dmesg | tac | sed -ne "0,\#fstests $seqnum \[tag\]#p" | \
> +		tac
> +}
> +
> +check_dmesg_for_since_tag()
> +{
> +	dmesg_since_test_tag | egrep -q "$1"
> +}
> +
> +echo "Silence is golden."
> +
> +
> +# Skip old kernels that did not print the warning yet
> +log_tag
> +_scratch_mkfs > $seqres.full 2>&1
> +_scratch_mount -o attr2
> +_scratch_unmount
> +check_dmesg_for_since_tag "XFS: attr2 mount option is deprecated" || \
> +	_notrun "Deprecation warning are not printed at all."
> +
> +# Test mount with default options (attr2 and noikeep) and remount with
> +# 2 groups of options
> +# 1) the defaults (attr2, noikeep)
> +# 2) non defaults (noattr2, ikeep)
> +_scratch_mount
> +for VAR in {attr2,noikeep}; do
> +	log_tag
> +	mount -o $VAR,remount $SCRATCH_MNT

I changed this to _scratch_remount $VAR

> +	check_dmesg_for_since_tag "XFS: $VAR mount option is deprecated." && \
> +		echo "Should not be able to find deprecation warning for $VAR"
> +done
> +for VAR in {noattr2,ikeep}; do
> +	log_tag
> +	mount -o $VAR,remount $SCRATCH_MNT

Same here.

Otherwise patch looks fine to me, thanks!

Eryu

> +	check_dmesg_for_since_tag "XFS: $VAR mount option is deprecated" || \
> +		echo "Could not find deprecation warning for $VAR"
> +done
> +_scratch_unmount
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/xfs/539.out b/tests/xfs/539.out
> new file mode 100644
> index 00000000..1b252fee
> --- /dev/null
> +++ b/tests/xfs/539.out
> @@ -0,0 +1,2 @@
> +QA output created by 539
> +Silence is golden.
> -- 
> 2.30.2

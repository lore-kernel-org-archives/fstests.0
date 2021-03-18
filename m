Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C2BC433E6
	for <linux-fstests@archiver.kernel.org>; Thu, 18 Mar 2021 06:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C47A864F3B
	for <linux-fstests@archiver.kernel.org>; Thu, 18 Mar 2021 06:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhCRG0U (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 18 Mar 2021 02:26:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22511 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229735AbhCRG0A (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 18 Mar 2021 02:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616048760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9bX2rDRAu9tnuZxDHPSuFc6JfA0MsBlTGlzWssPkj5g=;
        b=RkPe6iLChmfjJgaORIh8eZJeHotY58ud86rYSuOaMWBnuQfwyfOS4XBGN+5/Nw5iBXNpO6
        wUpaL3yhRJkJTZAqV6e144w/hP8ECiAhvCYUR0TPdp9uVGUcEWsRaJfygNmLzdDMiB9/bo
        ZEXFPP4f2fb/GO1Qx0Nyq4+YhSoAUtY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-DRxylyX3MPWmmskf9gvdWQ-1; Thu, 18 Mar 2021 02:25:57 -0400
X-MC-Unique: DRxylyX3MPWmmskf9gvdWQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45F97100945E
        for <fstests@vger.kernel.org>; Thu, 18 Mar 2021 06:25:56 +0000 (UTC)
Received: from localhost (unknown [10.66.61.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 974EC19705;
        Thu, 18 Mar 2021 06:25:55 +0000 (UTC)
Date:   Thu, 18 Mar 2021 14:42:04 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/528: Add test for printing deprec. mount options
Message-ID: <20210318064204.GA13946@localhost.localdomain>
Mail-Followup-To: Pavel Reichl <preichl@redhat.com>,
        fstests@vger.kernel.org
References: <20210310210228.58788-1-preichl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310210228.58788-1-preichl@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Mar 10, 2021 at 10:02:28PM +0100, Pavel Reichl wrote:
> Verify that warnings about deprecated mount options are properly
> printed.
> 
> Verify that no excessive warnings are printed during remounts.
> 
> Signed-off-by: Pavel Reichl <preichl@redhat.com>
> ---
>  tests/xfs/528     | 85 +++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/528.out |  2 ++
>  tests/xfs/group   |  1 +
>  3 files changed, 88 insertions(+)
>  create mode 100755 tests/xfs/528
>  create mode 100644 tests/xfs/528.out
> 
> diff --git a/tests/xfs/528 b/tests/xfs/528
> new file mode 100755
> index 00000000..148f6304
> --- /dev/null
> +++ b/tests/xfs/528
> @@ -0,0 +1,85 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 Red Hat, Inc.. All Rights Reserved.
> +#
> +# FS QA Test 528
> +#
> +# Verify that warnings about deprecated mount options are properly printed.
> +#
> +# Verify that no excessive warnings are printed during remounts.

Better to interpret which bug/commit are you testing for.

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

Use _require_check_dmesg to make sure /dev/kmsg is writable.

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
> +umount $SCRATCH_MNT

   ^^ _scratch_unmount

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
> +	check_dmesg_for_since_tag "XFS: $VAR mount option is deprecated." && \
> +		echo "Should not be able to find deprecation warning for $VAR"
> +done
> +for VAR in {noattr2,ikeep}; do
> +	log_tag
> +	mount -o $VAR,remount $SCRATCH_MNT
> +	check_dmesg_for_since_tag "XFS: $VAR mount option is deprecated" || \
> +		echo "Could not find deprecation warning for $VAR"
> +done
> +umount $SCRATCH_MNT

   ^^ _scratch_unmount

Just for making sure, looks like You test if remount print "deprecation warning"
properly. What about mount? Should mount has "proper deprecation warning" output?

Actually, you'd better to describe what's the "proper" behavior, what's not, or
what issue are you trying to cover in a test case.

> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/xfs/528.out b/tests/xfs/528.out
> new file mode 100644
> index 00000000..762dccc0
> --- /dev/null
> +++ b/tests/xfs/528.out
> @@ -0,0 +1,2 @@
> +QA output created by 528
> +Silence is golden.
> diff --git a/tests/xfs/group b/tests/xfs/group
> index e861cec9..ad3bd223 100644
> --- a/tests/xfs/group
> +++ b/tests/xfs/group
> @@ -525,3 +525,4 @@
>  525 auto quick mkfs
>  526 auto quick mkfs
>  527 auto quick quota
> +528 auto quick mount
> -- 
> 2.29.2
> 


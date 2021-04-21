Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A970C433ED
	for <linux-fstests@archiver.kernel.org>; Wed, 21 Apr 2021 16:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A7056144B
	for <linux-fstests@archiver.kernel.org>; Wed, 21 Apr 2021 16:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbhDUQTo (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 21 Apr 2021 12:19:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20847 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237441AbhDUQTn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 21 Apr 2021 12:19:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619021950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zlm+pC/UU7vQVWzYxu1wHbTA7YpC28H2HOIHPwuAgEQ=;
        b=FV+SCqGqMVjKfxJlOyDklSd70AuwnhHnUTUpqI5PXjhmB1UjYchYLzEYYtzpGIQ5G3G3Sn
        IQ7bbJBi+UrtdQ5qalM60cNu1/4NxQAZyUUIHk1188Kvm0/fqrqtKmQJne8eqp+VmIpJzy
        KxD4E4DfLPexL/CMwpZCxsJHpF/26bE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-thk0l4nLNHuusnlpky0uQw-1; Wed, 21 Apr 2021 12:19:08 -0400
X-MC-Unique: thk0l4nLNHuusnlpky0uQw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6076110CE78E
        for <fstests@vger.kernel.org>; Wed, 21 Apr 2021 16:19:07 +0000 (UTC)
Received: from bfoster (ovpn-112-25.rdu2.redhat.com [10.10.112.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CCEF1000358;
        Wed, 21 Apr 2021 16:19:06 +0000 (UTC)
Date:   Wed, 21 Apr 2021 12:19:05 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/495: split the test
Message-ID: <YIBQeWVBJOj2PY0j@bfoster>
References: <20210420223044.51214-1-preichl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420223044.51214-1-preichl@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Apr 21, 2021 at 12:30:44AM +0200, Pavel Reichl wrote:
> Split each swap-file test into its own test. So on file-systems that
> do not support e.g. sparse files (exfat) other swap-file tests can be
> executed.
> 
> Signed-off-by: Pavel Reichl <preichl@redhat.com>
> ---
>  tests/generic/495     | 14 ++----------
>  tests/generic/495.out |  3 ---
>  tests/generic/634     | 50 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/634.out |  2 ++
>  tests/generic/group   |  1 +
>  5 files changed, 55 insertions(+), 15 deletions(-)
>  create mode 100755 tests/generic/634
>  create mode 100644 tests/generic/634.out
> 
...
> diff --git a/tests/generic/634 b/tests/generic/634
> new file mode 100755
> index 00000000..069d9f0e
> --- /dev/null
> +++ b/tests/generic/634
> @@ -0,0 +1,50 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2018 Facebook. All Rights Reserved.
> +#
> +# FS QA Test 634
> +#
> +# Test invalid swap files.
> +# Empty swap file (only swap header)
> +#
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
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +_supported_fs generic
> +_require_scratch_swapfile
> +_require_test_program mkswap
> +_require_test_program swapon
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount
> +
> +rm -f "$SCRATCH_MNT/swap"

This looks spurious now that the fs is initially clean. Otherwise LGTM:

Reviewed-by: Brian Foster <bfoster@redhat.com>

> +touch "$SCRATCH_MNT/swap"
> +$CHATTR_PROG +C "$SCRATCH_MNT/swap" >> $seqres.full 2>&1
> +chmod 0600 "$SCRATCH_MNT/swap"
> +_pwrite_byte 0x61 0 $(get_page_size) "$SCRATCH_MNT/swap" >> $seqres.full
> +"$here/src/mkswap" "$SCRATCH_MNT/swap"
> +"$here/src/swapon" "$SCRATCH_MNT/swap"
> +swapoff "$SCRATCH_MNT/swap" >/dev/null 2>&1
> +
> +status=0
> +exit
> diff --git a/tests/generic/634.out b/tests/generic/634.out
> new file mode 100644
> index 00000000..b90e5758
> --- /dev/null
> +++ b/tests/generic/634.out
> @@ -0,0 +1,2 @@
> +QA output created by 634
> +swapon: Invalid argument
> diff --git a/tests/generic/group b/tests/generic/group
> index 033465f1..158d759b 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -636,3 +636,4 @@
>  631 auto rw overlay rename
>  632 auto quick mount
>  633 auto quick atime attr cap idmapped io_uring mount perms rw unlink
> +634 auto quick swap
> -- 
> 2.30.2
> 


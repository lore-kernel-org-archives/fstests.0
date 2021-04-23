Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF79C433B4
	for <linux-fstests@archiver.kernel.org>; Fri, 23 Apr 2021 11:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3D226115B
	for <linux-fstests@archiver.kernel.org>; Fri, 23 Apr 2021 11:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhDWLeL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 23 Apr 2021 07:34:11 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36886 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhDWLeL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 23 Apr 2021 07:34:11 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id 0FC4A1F43AB9
Subject: Re: [PATCH v2 1/1] generic/495: split the test
To:     Pavel Reichl <preichl@redhat.com>, fstests@vger.kernel.org
Cc:     bfoster@redhat.com, krisman@collabora.com, kernel@collabora.com
References: <20210423100731.14111-1-preichl@redhat.com>
 <20210423100731.14111-2-preichl@redhat.com>
From:   Shreeya Patel <shreeya.patel@collabora.com>
Message-ID: <8328c6fb-9070-bdc4-b089-424bc73e2998@collabora.com>
Date:   Fri, 23 Apr 2021 17:03:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210423100731.14111-2-preichl@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


On 23/04/21 3:37 pm, Pavel Reichl wrote:
> Split each swap-file test into its own test. So on file-systems that
> do not support e.g. sparse files (exfat) other swap-file tests can be
> executed.
>
> Signed-off-by: Pavel Reichl <preichl@redhat.com>
> Reviewed-by: Brian Foster <bfoster@redhat.com>


I tested this patch and it works fine.

Tested-by: Shreeya Patel <shreeya.patel@collabora.com>


> ---
>   tests/generic/495     | 14 ++-----------
>   tests/generic/495.out |  3 ---
>   tests/generic/634     | 49 +++++++++++++++++++++++++++++++++++++++++++
>   tests/generic/634.out |  2 ++
>   tests/generic/group   |  1 +
>   5 files changed, 54 insertions(+), 15 deletions(-)
>   create mode 100755 tests/generic/634
>   create mode 100644 tests/generic/634.out
>
> diff --git a/tests/generic/495 b/tests/generic/495
> index 79a8abb3..f1a8a619 100755
> --- a/tests/generic/495
> +++ b/tests/generic/495
> @@ -4,7 +4,7 @@
>   #
>   # FS QA Test 495
>   #
> -# Test invalid swap files.
> +# Test invalid swap file (with holes)
>   #
>   seq=`basename $0`
>   seqres=$RESULT_DIR/$seq
> @@ -32,11 +32,11 @@ _supported_fs generic
>   _require_scratch_swapfile
>   _require_test_program mkswap
>   _require_test_program swapon
> +_require_sparse_files
>   
>   _scratch_mkfs >> $seqres.full 2>&1
>   _scratch_mount
>   
> -echo "File with holes"
>   # We can't use _format_swapfile because we're using our custom mkswap and
>   # swapon.
>   touch "$SCRATCH_MNT/swap"
> @@ -47,15 +47,5 @@ $XFS_IO_PROG -c "truncate $(($(get_page_size) * 10))" "$SCRATCH_MNT/swap"
>   "$here/src/swapon" "$SCRATCH_MNT/swap"
>   swapoff "$SCRATCH_MNT/swap" >/dev/null 2>&1
>   
> -echo "Empty swap file (only swap header)"
> -rm -f "$SCRATCH_MNT/swap"
> -touch "$SCRATCH_MNT/swap"
> -$CHATTR_PROG +C "$SCRATCH_MNT/swap" >> $seqres.full 2>&1
> -chmod 0600 "$SCRATCH_MNT/swap"
> -_pwrite_byte 0x61 0 $(get_page_size) "$SCRATCH_MNT/swap" >> $seqres.full
> -"$here/src/mkswap" "$SCRATCH_MNT/swap"
> -"$here/src/swapon" "$SCRATCH_MNT/swap"
> -swapoff "$SCRATCH_MNT/swap" >/dev/null 2>&1
> -
>   status=0
>   exit
> diff --git a/tests/generic/495.out b/tests/generic/495.out
> index a7e3b720..16de8245 100644
> --- a/tests/generic/495.out
> +++ b/tests/generic/495.out
> @@ -1,5 +1,2 @@
>   QA output created by 495
> -File with holes
> -swapon: Invalid argument
> -Empty swap file (only swap header)
>   swapon: Invalid argument
> diff --git a/tests/generic/634 b/tests/generic/634
> new file mode 100755
> index 00000000..8e15a4f0
> --- /dev/null
> +++ b/tests/generic/634
> @@ -0,0 +1,49 @@
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
>   631 auto rw overlay rename
>   632 auto quick mount
>   633 auto quick atime attr cap idmapped io_uring mount perms rw unlink
> +634 auto quick swap

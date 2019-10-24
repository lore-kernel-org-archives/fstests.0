Return-Path: <SRS0=fGqU=YR=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC99CA9EAF
	for <linux-fstests@archiver.kernel.org>; Thu, 24 Oct 2019 06:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7156C2166E
	for <linux-fstests@archiver.kernel.org>; Thu, 24 Oct 2019 06:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaMfC4vd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404448AbfJXG3m (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 24 Oct 2019 02:29:42 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37411 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727750AbfJXG3l (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 24 Oct 2019 02:29:41 -0400
Received: by mail-yw1-f67.google.com with SMTP id c185so2302928ywb.4;
        Wed, 23 Oct 2019 23:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NpwmhwXAKQDQClc+SOoYbeJdGjhrVWqn+uo8W1MmdRE=;
        b=aaMfC4vdKvuo0ffqE5qT8wnInLAw5/BoEFCB8tI+fItV8bN3bo7/V63eZYGcedkT+z
         LO5h44E8lf3XAbLJhonlMw6CP3XOAq1hAmcs3fOsBhXVv0YMZjXcmspZ5mQj7w4WEjut
         8SMnTFrmZ+VhKbc4CA1rIik9n2BCDodQc7hoiKyNO1SHE8zeAAxNHQ4ZilA+5f31+LFi
         TpNCLbqle0J0m95zr+03ZPaHIOZ0TOKETN5aPJZ4NpgD4ha8DRtl1lqklMJ6NOJnVOjf
         PAymVjyGsG35TLzOG/TK3nWJMeMlx5ZzmDVjfWOlI7ATXELPDk+IrmBklmuILqg0bYe8
         xYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NpwmhwXAKQDQClc+SOoYbeJdGjhrVWqn+uo8W1MmdRE=;
        b=HbJ0Lt2GBQUaLcnOjXn9MM3ODHsPscNSUsw9Nwi5zPJk4y1DySO8JnBTTswr5OR6BU
         keznv2kzyO8bv5wSpRTQVGjjplDGABULSLNW2QdQ/YAYnMHlIU2IYZaJGNZZeSPpn2Ja
         yerNsCHfMehCcv5DjekAKNd5mbdO4XUHiEtD0830zI0VSwgZDahYrX9EDUokdz3sAsm5
         id7fIeIFcs0+LTtGYl6zG2IK2QGIUcbEMAmCghnYhzVAt/a2FvZnkOI/3nAnWZyo8ba8
         T8w7s151CgZv6UcY6aoJZEm8CAgORfm3zarqtGpmA+jJ7R1K80t6t1ye163a0qFrDC/+
         6JZQ==
X-Gm-Message-State: APjAAAX7gZq73bGNfoKuxw/G/Wb7snXKudyMoAxr4bL4c6sJKcgrZ4OH
        DEU4C2YZgoe71tkLMjT9fKgQ8c2+P+tB5Hqd7YE=
X-Google-Smtp-Source: APXvYqysQ6+rUqT+Ev9d3ryao3+ILYSQJ9KySCKWsG0e4Y97fY76ikQU0woGc9CBHFK9iHXq0j6+L9tZatHIi/TxMpY=
X-Received: by 2002:a0d:e347:: with SMTP id m68mr5439557ywe.181.1571898578623;
 Wed, 23 Oct 2019 23:29:38 -0700 (PDT)
MIME-Version: 1.0
References: <20191024055435.6059-1-cgxu519@mykernel.net>
In-Reply-To: <20191024055435.6059-1-cgxu519@mykernel.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 24 Oct 2019 09:29:27 +0300
Message-ID: <CAOQ4uxixTyXxoTPsuz91+1rB+GupWR256QCAoi7sEbDiRxksyA@mail.gmail.com>
Subject: Re: [PATCH v2] overlay/066: copy-up test for variant sparse files
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     fstests <fstests@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Eryu Guan <guaneryu@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Oct 24, 2019 at 8:54 AM Chengguang Xu <cgxu519@mykernel.net> wrote:
>
> This is intensive copy-up test for sparse files,
> these cases will be mainly used for regression test
> of copy-up improvement for sparse files.
>
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>

You can add:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

after fixing nits below...

> ---
> v1->v2:
> - Call _get_block_size to get fs block size.
> - Add comment for test space requirement.
> - Print meaningful error message when copy-up fail.
> - Adjust random hole range to 1M~5M.
> - Fix typo.
>
>  tests/overlay/066     | 120 ++++++++++++++++++++++++++++++++++++++++++
>  tests/overlay/066.out |   2 +
>  tests/overlay/group   |   1 +
>  3 files changed, 123 insertions(+)
>  create mode 100755 tests/overlay/066
>  create mode 100644 tests/overlay/066.out
>
> diff --git a/tests/overlay/066 b/tests/overlay/066
> new file mode 100755
> index 00000000..b01fc2a4
> --- /dev/null
> +++ b/tests/overlay/066
> @@ -0,0 +1,120 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2019 Chengguang Xu <cgxu519@mykernel.net>
> +# All Rights Reserved.
> +#
> +# FS QA Test 066
> +#
> +# Test overlayfs copy-up function for variant sparse files.
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1       # failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +       cd /
> +       rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_supported_os Linux
> +_require_test
> +_require_scratch
> +
> +# Remove all files from previous tests
> +_scratch_mkfs
> +# We have totally 14 test files in this test,
> +# one file for 100M and 13 files for 10M.

So we need double that amount of space if both upper and lower
do not support holes.

Also it is not obvious to the reader how the number 13 came to
be. It is better to explicitly say 1 empty file + 2^0 .. 2^11 hole size
file, so if ever the test pattern changes, it will be easier to adapt this
formula.

> +_require_fs_space $OVL_BASE_SCRATCH_MNT $((10*1024*13 + 100*1024*1))
> +
> +lowerdir=$OVL_BASE_SCRATCH_MNT/$OVL_LOWER
> +upperdir=$OVL_BASE_SCRATCH_MNT/$OVL_UPPER
> +testfile="copyup_sparse_test"
> +mkdir -p $lowerdir
> +
> +# Create a completely empty hole file.
> +$XFS_IO_PROG -fc "truncate 10M" "${lowerdir}/${testfile}_empty_holefile" \
> +                >>$seqres.full
> +
> +iosize=$(_get_block_size "${lowerdir}")
> +if [ $iosize -le 1024 ]; then
> +       iosize=1
> +else
> +       iosize=`expr $iosize / 1024`
> +fi
> +
> +# Create test files with different hole size patterns.

Better be more verbose in the comment about the pattern of
the files, so reader won't need to follow code to understand.
Also better to have constants to make the algorithm clearer:

max_iosize=2048
file_size=10240
max_pos=`expr $file_size - $max_iosize`

> +while [ $iosize -le 2048 ]; do
> +       pos=$iosize
> +       $XFS_IO_PROG -fc "truncate 10M" \
> +               "${lowerdir}/${testfile}_iosize${iosize}K_holefile" >>$seqres.full
> +       while [ $pos -lt 8192 ]; do
> +               $XFS_IO_PROG -fc "pwrite ${pos}K ${iosize}K" \
> +               "${lowerdir}/${testfile}_iosize${iosize}K_holefile" >>$seqres.full
> +               pos=`expr $pos + $iosize + $iosize`
> +       done
> +       iosize=`expr $iosize + $iosize`
> +done
> +
> +# Create test file with many random holes(1M~5M).
> +$XFS_IO_PROG -fc "truncate 100M" "${lowerdir}/${testfile}_random_holefile" \
> +               >>$seqres.full

Same comment about using constants instead of unexplained numbers,
including:
min_hole=1024
max_hole=5120

> +pos=2048
> +while [ $pos -le 81920 ]; do
> +       iosize=`expr $RANDOM % 5120`
> +       if [ $iosize -lt 1024 ]; then
> +               iosize=`expr $iosize + 1024`
> +       fi

So that is a weird way to express random 1MB~5MB
it results in 2 times higher probability for holes in the range
1MB~2MB and I don't think that was intentional. Better use:

   iosize=$(($RANDOM % ($max_hole - $min_hole) + $min_hole))

Thanks,
Amir.

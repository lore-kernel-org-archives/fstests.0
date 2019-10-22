Return-Path: <SRS0=glCd=YP=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700AACA9EA0
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Oct 2019 13:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354A321783
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Oct 2019 13:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0CeWZtn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732063AbfJVNbq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 22 Oct 2019 09:31:46 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:45560 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfJVNbq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Oct 2019 09:31:46 -0400
Received: by mail-yb1-f193.google.com with SMTP id q143so5124725ybg.12;
        Tue, 22 Oct 2019 06:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m/WO+vAGlo2soHc4G9e3wdg+6WHR5f2PbBSD5EHKkk8=;
        b=N0CeWZtn1MsiDdc0HEbU4GTTqO2tfr2pP4tZZSHFFXqyIw6hcJG3eA45pB3ByIOml/
         M6iFY0Vl5G0zY1H7RE3jEPC8b/TV7IXuwiaFTP05WEnhWQ3OdS3z0XdF04ImOsRLNpqm
         pH6LtPyWkO+eeZFx42tgoderEJtIVa+lJxuSlon8SrC7nXCgTsffqUo8nY+Q16NKyMDP
         JBkPhshDAukjAIqkMGskBZl44juq1meeZ5TnR2Qcn2bEopvKlIA6psbZq1r0Sz2TgAdx
         SABi2zgJGxdaT8cByOXvFeb3iQnoCiAlLaO4ZwE9H2JUbRMWUHYaZzolurRU/ljcFLOP
         S9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m/WO+vAGlo2soHc4G9e3wdg+6WHR5f2PbBSD5EHKkk8=;
        b=Qcuetzv2KTl9UjeNUEuzo2N0+9n0Gc/BczmRaGV65QPyaXDikYS+sDUXDViky8LUh1
         N5uBqT4c10/CfbqNa2muIXge8W/2+MGX44yL6/+0JesnioPAzZAgNcVyIor2KJYIKN3n
         Pa8Avdr/RABhSGusISMmhM6vYz/ny77C9rDqoQrDO3VMbUXXwTcTtKUjTlIUEaVX9dZh
         /Wjr5cvd+Eeua82wMGoX1Ei7cU1s5w4iREUYwB2oxDrZ3vWAD4gHQ+8nPFp7ZfBwLfwm
         j6MZEwn+xhSjP4e4IzgC0M4twJ0baLBmKxdsNvEjq6PilgspwYrbQx9y96YYQSFogRpa
         tSpQ==
X-Gm-Message-State: APjAAAUa86sQ+q7yvq8EaCMlXji2jiBDewZgSW8zI/k++Tq8Po/EPUsr
        oRi5hYkFx0VbIkd0qImgEThudCaqD9vcxWFhbmBhwp7J
X-Google-Smtp-Source: APXvYqyqyr0Q8iIUbIxst9ZZM7Dq02b3swxnLYMQ+mzDISrr5Lt25p8rI4FzqycGM8XLtSZIXwWFhsS2FkbhzWMpKDM=
X-Received: by 2002:a25:8308:: with SMTP id s8mr2333163ybk.126.1571751104822;
 Tue, 22 Oct 2019 06:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191022122621.27374-1-cgxu519@mykernel.net>
In-Reply-To: <20191022122621.27374-1-cgxu519@mykernel.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 22 Oct 2019 16:31:32 +0300
Message-ID: <CAOQ4uxiXwJp4dh_yENsxskbSvuGew2ZqRFyKccdFUMLGWUaz3Q@mail.gmail.com>
Subject: Re: [PATCH] overlay/066: copy-up test for variant sparse files
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

On Tue, Oct 22, 2019 at 3:26 PM Chengguang Xu <cgxu519@mykernel.net> wrote:
>
> This is intensive copy-up test for sparse files,
> these cases are mainly used for regression test
> of copy-up improvement for sparse files.
>
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
> ---
>  tests/overlay/066     | 108 ++++++++++++++++++++++++++++++++++++++++++
>  tests/overlay/066.out |   2 +
>  tests/overlay/group   |   1 +
>  3 files changed, 111 insertions(+)
>  create mode 100755 tests/overlay/066
>  create mode 100644 tests/overlay/066.out
>
> diff --git a/tests/overlay/066 b/tests/overlay/066
> new file mode 100755
> index 00000000..0394b14e
> --- /dev/null
> +++ b/tests/overlay/066
> @@ -0,0 +1,108 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2019 Chengguang Xu <cgxu519@mykernel.net>. All Rights Reserved.
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
> +_require_fs_space $OVL_BASE_SCRATCH_MNT $((10*1024*13 + 100*1024))

Please add a comment about how the above is calculated.
Should it depend on fs reported iosize or blocksize?

> +
> +lowerdir=$OVL_BASE_SCRATCH_MNT/$OVL_LOWER
> +upperdir=$OVL_BASE_SCRATCH_MNT/$OVL_UPPER
> +testfile="copyup_sparse_test"
> +mkdir -p $lowerdir
> +
> +# Create a completely empty hole file.
> +$XFS_IO_PROG -fc "truncate 10M" "${lowerdir}/${testfile}_empty_holefile" >>$seqres.full
> +
> +iosize=`stat -c %o "${lowerdir}/${testfile}_empty_holefile"`

I am not sure why fs reported iosize is interesting for this test case.
If anything you need _get_file_block_size

> +if [ $iosize -le 1024 ]; then
> +       ioszie=1

typo: ioszie

> +else
> +       iosize=`expr $iosize / 1024`
> +fi
> +
> +# Create test files with different hole size patterns.
> +while [ $iosize -le 2048 ]; do
> +       pos=$iosize
> +       $XFS_IO_PROG -fc "truncate 10M" "${lowerdir}/${testfile}_iosize${iosize}K_holefile" >>$seqres.full
> +       while [ $pos -lt 8192 ]; do
> +               $XFS_IO_PROG -fc "pwrite ${pos}K ${iosize}K" "${lowerdir}/${testfile}_iosize${iosize}K_holefile" >>$seqres.full
> +               pos=`expr $pos + $iosize + $iosize`
> +       done
> +       iosize=`expr $iosize + $iosize`
> +done
> +
> +# Create test file with many random holes(1M~2M).
> +$XFS_IO_PROG -fc "truncate 100M" "${lowerdir}/${testfile}_random_holefile" >>$seqres.full
> +pos=2048
> +while [ $pos -le 81920 ]; do
> +       iosize=`expr $RANDOM % 2048`
> +       if [ $iosize -lt 1024 ]; then
> +               iosize=`expr $iosize + 1024`
> +       fi

IOW: iosize=`expr $RANDOM % 1024 + 1024`

> +       $XFS_IO_PROG -fc "pwrite ${pos}K ${iosize}K" "${lowerdir}/${testfile}_random_holefile" >>$seqres.full
> +       pos=`expr $pos + $iosize + $iosize`
> +done
> +
> +_scratch_mount
> +
> +# Open the files should succeed, no errors are expected.
> +for f in $SCRATCH_MNT/*; do
> +       $XFS_IO_PROG -c "open" $f >>$seqres.full
> +done
> +
> +echo "Silence is golden"
> +
> +# Check all copy-up files in upper layer.
> +iosize=`stat -c %o "${lowerdir}/${testfile}_empty_holefile"`
> +if [ $iosize -le 1024 ]; then
> +       ioszie=1

typo: ioszie

> +else
> +       iosize=`expr $iosize / 1024`
> +fi
> +
> +while [ $iosize -le 2048 ]; do
> +       diff "${lowerdir}/${testfile}_iosize${iosize}K_holefile" "${upperdir}/${testfile}_iosize${iosize}K_holefile" >>$seqres.full
> +       iosize=`expr $iosize + $iosize`
> +done
> +
> +diff "${lowerdir}/${testfile}_empty_holefile"  "${upperdir}/${testfile}_empty_holefile"  >>$seqres.full
> +diff "${lowerdir}/${testfile}_random_holefile" "${upperdir}/${testfile}_random_holefile" >>$seqres.full

This expression does not fail the test if file differ?
Did you mean:

diff "${lowerdir}/${testfile}_empty_holefile"
"${upperdir}/${testfile}_empty_holefile"  >>$seqres.full || \
    echo ${testfile}_empty_holefile" copy up failed

> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/overlay/066.out b/tests/overlay/066.out
> new file mode 100644
> index 00000000..b60cc24c
> --- /dev/null
> +++ b/tests/overlay/066.out
> @@ -0,0 +1,2 @@
> +QA output created by 066
> +Silence is golden
> diff --git a/tests/overlay/group b/tests/overlay/group
> index ef8517a1..1dec7db9 100644
> --- a/tests/overlay/group
> +++ b/tests/overlay/group
> @@ -68,3 +68,4 @@
>  063 auto quick whiteout
>  064 auto quick copyup
>  065 auto quick mount
> +066 auto quick copyup

I'm curious, how long does the test run with and without copy up hole
optimization patch?

Thanks,
Amir.

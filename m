Return-Path: <SRS0=M3Lt=2U=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C030C2D0C3
	for <linux-fstests@archiver.kernel.org>; Mon, 30 Dec 2019 07:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A5220409
	for <linux-fstests@archiver.kernel.org>; Mon, 30 Dec 2019 07:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRnLPiSM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfL3He7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 30 Dec 2019 02:34:59 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:40444 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfL3He7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 30 Dec 2019 02:34:59 -0500
Received: by mail-io1-f66.google.com with SMTP id x1so30714185iop.7
        for <fstests@vger.kernel.org>; Sun, 29 Dec 2019 23:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JoOkx5XNmH9sRdpNQ/CQ6RPT15qSgLYFT5uZacv+cG4=;
        b=NRnLPiSMd9N74AZnLbcuAnTGWbX6l7rUK77sa+X8gQyfYYB81/Xyegp+y+rbLfSxEY
         4Xq4lP1siWb2LcWT2Z9SQwVFw7iNekx+6uRpWQW94CbPSRiI0npOPeSc7k+cdk+I0Bm5
         t56SQZL+Cv8W1p3k5BZvSYjyzcdmDwDTFXV6ClydmjlyKZZSm5MJJtIo9eZeGNF0INoD
         4R/lfZhyTqtNOBBQdqPB4DBEETXJROQ/tfP0f3FogwL8M7sin+HWCOTjpZVWhhUdDcsX
         5+LCUvGAS1hskleUeYpmCqbZVL9A93StONJRNhXUM4nBSnUwhPNNBKgvkI65mmJVFiNa
         0yig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JoOkx5XNmH9sRdpNQ/CQ6RPT15qSgLYFT5uZacv+cG4=;
        b=kMEmAUOQfQG7Wl2HPjUr98hw9jMk+VOa+hEGBNLc7r9YpV/nxMdw/F/05ljBed7qKF
         WafHdszOl/se/FbmocnQkQm2j+CXoe/bq8IineJyPL4qMWS4rvvb7dHTbx3S2H5qV4py
         AZfOaJYSNe6NSL2iit1yDQF+Nq4PTbxdgU3R2mBbXx5UqBqr6rn+iL3SSr5v1I3g+vFg
         FEh+AjBJvkdBnY7iYQbBMgkFat31ty4NIV4RU2hUThJVicS1HVbpdF7dVO9e1UWyLZjN
         bAL7aiM3FOfY/Pp1jf/7R9nUMAA1KCGLiLq7aMDJ8aU4r9wp7vFXvX+KVOYVO+V70rmj
         bfWg==
X-Gm-Message-State: APjAAAWfvCCvUyk3KbZEy3FelnBfpvadJnENWxRt5oUNFTbzm9dU5nTe
        BKEt7EWzSl+cUjwXdPmOqlugECh7QxiStjJErqg=
X-Google-Smtp-Source: APXvYqxrPr2cO3Z6SRGYOTI9WE+bwB0btYvdky9jfkoZebNdnKV0p6MrAUogpf9Yxlin+QGr73qRz5Ep5WThcP4MToU=
X-Received: by 2002:a02:3ece:: with SMTP id s197mr50835215jas.30.1577691298962;
 Sun, 29 Dec 2019 23:34:58 -0800 (PST)
MIME-Version: 1.0
References: <CABeXuvr74C0DS-K4_us4CdPPFxp=7RHmCHAZQQmJrh=PZfux-w@mail.gmail.com>
 <20191228221317.16654-1-deepa.kernel@gmail.com>
In-Reply-To: <20191228221317.16654-1-deepa.kernel@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 30 Dec 2019 09:34:47 +0200
Message-ID: <CAOQ4uxifpjjirTyUsCm03TFx8LOvkt0xX+RNyFZU5sHNU+bfqA@mail.gmail.com>
Subject: Re: [PATCH v2] generic/402: Make timestamp range check conditional
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Eryu Guan <guaneryu@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Dec 29, 2019 at 12:13 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> Addition of fs-specific timestamp range checking was added
> in 188d20bcd1eb ("vfs: Add file timestamp range support").
>
> Add a check for whether the kernel supports the limits check
> before running the associated test.
>
> ext4 has been chosen to test for the presence of kernel support
> for this feature. If there is a concern that ext4 could be built
> out of the kernel, I can include a _require_ext4() along the
> lines of _require_ext2().
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> ---
> * Changes since v1:
>   used loopback device instead of mkfs scratch dev
>
>  common/rc         | 26 ++++++++++++++++++++++++++
>  tests/generic/402 |  3 +++
>  2 files changed, 29 insertions(+)
>
> diff --git a/common/rc b/common/rc
> index 816588d6..6248adf7 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1981,6 +1981,32 @@ _run_aiodio()
>      return $status
>  }
>
> +_require_kernel_timestamp_range()
> +{
> +       LOOP_FILE=$SCRATCH_MNT/loop_file
> +       LOOP_MNT=$SCRATCH_MNT/loop_mnt
> +
> +       dd if=/dev/zero of=$LOOP_FILE bs=1M count=2 2>&1 | _filter_dd || _fail "loopback prep failed"
> +
> +       # Use ext4 with 128-byte inodes, which do not have room for extended timestamp
> +       FSTYP=ext4 MKFS_OPTIONS=-I128 \
> +       _mkfs_dev $LOOP_FILE >> $seqres.full 2>&1 || _fail "ext4 mkfs failed"
> +
> +       LOOP_DEV=$(_create_loop_device $LOOP_FILE)
> +       mkdir -p $LOOP_MNT >> $seqres.full 2>&1 || _fail "failed to create $LOOP_MNT"
> +       mount -t ext4 ${LOOP_DEV} ${LOOP_MNT} >> $seqres.full 2>&1 || _fail "ext4 mount failed"
> +       notrun=false
> +       _check_dmesg_for "ext4 filesystem being mounted at ${LOOP_MNT} supports timestamps until 2038" || \
> +               notrun=true
> +
> +       umount ${LOOP_MNT} >> $seqres.full 2>&1 ||_fail "failed to umount $LOOP_MNT"
> +       _destroy_loop_device ${LOOP_DEV} >> $seqres.full 2>&1
> +
> +       if $notrun; then
> +               _notrun "Kernel does not support timestamp limits"
> +       fi
> +}
> +

As a generic helper, this function has a few problems:
1. It assumes scratch dev is mounted (and you're not even calling it
after _scratch_mount)
2. The cleanup() hook won't clean loop mnt/dev if interrupted
3. test doesn't have _require_loop (nor require ext4 as you mentioned)

All this leads me to think that perhaps it would be better off, at least until
kernel has fsinfo, to keep this entire helper inside generic/402,
while addressing
the issues above in the test itself.

A more generic solution would be harder and IMO and overkill at this point.

What do you think?

Thanks,
Amir.

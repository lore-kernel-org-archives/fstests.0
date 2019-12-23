Return-Path: <SRS0=A77W=2N=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26969C2D0C0
	for <linux-fstests@archiver.kernel.org>; Mon, 23 Dec 2019 06:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9A7206B7
	for <linux-fstests@archiver.kernel.org>; Mon, 23 Dec 2019 06:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGyy0XNB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfLWGgY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 23 Dec 2019 01:36:24 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:44771 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfLWGgY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 23 Dec 2019 01:36:24 -0500
Received: by mail-il1-f194.google.com with SMTP id z12so13143410iln.11
        for <fstests@vger.kernel.org>; Sun, 22 Dec 2019 22:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0iBRbU6C/Qo5Loiwb5HhSoYmrxPam8251bR4Dxs9cBg=;
        b=NGyy0XNB1fFFd+ci1+aqV42N4NOJiWInSzNFwmc1JXyO6m8fQ6rLBXBWTWBVSpyG4E
         LnnKKs9X2T9L/wSrfx87GyEY7Jk0lC5norAMdynSvL5b4MPJPte4lXcW/yOT/RyvFL1h
         CvKAQZZR5XFOxXYpWa/GDv7jBP7pwS6d2q6fO8GIEUw2xPALp1ZvcEMP97Ww5jXi2Py5
         +l/BXP5iZFLlH4s3XzvVhrCdEWXp04hDTO2j9lxL7c8+wXhz/rng+6N1Su5fwu672FAQ
         hH8W4DoP3srzgaM2+f/QgN+uh0edsKkxjXqLUXMK4oB/VR0UwJ5Cu6CiQwAxoNIw3bjG
         yChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0iBRbU6C/Qo5Loiwb5HhSoYmrxPam8251bR4Dxs9cBg=;
        b=oX3utf0aepIIEfj2OsQi6CQQPFGB2wu3VunFVS8a/VFjbY9oi3/bbvRIsoADbIciJV
         iV6HNhHbzVGrPJCoAaQ56KQs8g3JOysR1NBfB0fTbHzXG01zqxPnu9J+MzteSD1LOYOI
         OPN2RjD1zSS93bjixA0w67z6VPulIEBu8LhCa/miQlXNqgmCdXxMeMfeqqA0a0h8j9uk
         03A++fmoTOCZ1SkE5cHjV+ut1L1s1U8uYU81l/BM5dcgmwWzwnZynf3eWM5L56QhbBZu
         dOtEKTO+liMmzlhSDeNSs2wrSTMfsXNwoo/agdwH2OJvwrtVG//6+o0A3eOOdNaBFNbw
         v3iQ==
X-Gm-Message-State: APjAAAWV74PJA1WLw2xqPXkhttE3X6vNl0HZS9Mln9yFEXBco9tbR7pN
        e5/BnWhEOIX0YaWrH7nHP7G3jY240ufxfnc6ssQ=
X-Google-Smtp-Source: APXvYqxa/k9M4kSz7SXbAw5E5gvHePhGxbHRfGfvWO6/cIyTMxmobNcywD5TrYPeckbryejCyMZCteOf2XR5XN74vUI=
X-Received: by 2002:a92:d5c3:: with SMTP id d3mr23782176ilq.250.1577082983818;
 Sun, 22 Dec 2019 22:36:23 -0800 (PST)
MIME-Version: 1.0
References: <CABeXuvq+37-WO8KH5en-1LaSGOLbw9zziC4eAqGvpJwe85kudQ@mail.gmail.com>
 <20191223051622.7975-1-deepa.kernel@gmail.com>
In-Reply-To: <20191223051622.7975-1-deepa.kernel@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 23 Dec 2019 08:36:12 +0200
Message-ID: <CAOQ4uxh=aBxGsbPmwup_0iSBuPQd1W42z=DgXh1bFszxwy+16w@mail.gmail.com>
Subject: Re: [PATCH] generic/402: Make timestamp range check conditional
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

On Mon, Dec 23, 2019 at 7:16 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> Addition of fs-specific timestamp range checking was added
> in 188d20bcd1eb ("vfs: Add file timestamp range support").
>
> Add a check for whether the kernel supports the limits check
> before running the associated test.
>
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> ---
>  common/rc         | 11 +++++++++++
>  tests/generic/402 |  3 +++
>  2 files changed, 14 insertions(+)
>
> diff --git a/common/rc b/common/rc
> index 816588d6..472db995 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1981,6 +1981,17 @@ _run_aiodio()
>      return $status
>  }
>
> +_require_kernel_timestamp_range()
> +{
> +       # 128-byte inodes do not have room for extended timestamp
> +       MKFS_OPTIONS=-I128 _scratch_mkfs_ext4 &>> $seqres.full 2>&1 || _fail "ext4 mkfs failed"
> +
> +       mount -t ext4 ${SCRATCH_DEV} ${SCRATCH_MNT}
> +       _check_dmesg_for "ext4 filesystem being mounted at ${SCRATCH_MNT} supports timestamps until 2038" || \
> +               _notrun "Kernel does not support timestamp limits"
> +       umount ${SCRATCH_MNT}
> +}
> +

Deepa,

Thank you for following up.
I am not sure if mkfs.ext4 of scratch partition in a generic test is going to be
very popular - let's see what others have to say.
You can certainly now do that without checking that  ${SCRATCH_DEV} is
a blockdev which is not the case for overlay and networking filesystems.

Why did you choose not to use a loop mounted ext2 for the check as
I suggested?
You can use _require_loop() and _require_ext2() inside the check.
In any case, please also check for failure to mount.

Thanks,
Amir.

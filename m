Return-Path: <SRS0=Sr/I=2O=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9AAC2D0C0
	for <linux-fstests@archiver.kernel.org>; Tue, 24 Dec 2019 01:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742A82073A
	for <linux-fstests@archiver.kernel.org>; Tue, 24 Dec 2019 01:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="On2FndZn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfLXBQH (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 23 Dec 2019 20:16:07 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43906 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfLXBQH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 23 Dec 2019 20:16:07 -0500
Received: by mail-io1-f66.google.com with SMTP id n21so16240125ioo.10
        for <fstests@vger.kernel.org>; Mon, 23 Dec 2019 17:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dh8JeRttAwUFfaEO88QdsuJ+A2Sg+wk7ZPAwNr1AqKU=;
        b=On2FndZnZ+XByFRMc3nSYefHI6pLLvwgNsYBTV+HFs2zZwSwvqFMwxnaNHslP7GVz1
         8A9KZRy54rwR3AYLtoBMoRqFN0vhMK85IYe+xa5CRrcWrMnDQvd+usGE+p/G26tn0A5B
         n2ApL/+OfZo2hWo3rRoqOqFDgC3ktCykWSBApDrhIgY9+Iun489sTizT8WE/KSRM5c+C
         udkF1D0wclUabqzUJH5opBCsLOj/u6OypttbLFHg6BwF0Ma6jNfDGT1p2HDmxSD47HvX
         VG3YBN0hRmikXXkXT2Dazri3hOYbPsFGBGkxImdqFAwHWfSmGhfvgg2lPUlruyVdTPly
         QPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dh8JeRttAwUFfaEO88QdsuJ+A2Sg+wk7ZPAwNr1AqKU=;
        b=MzRuZLSIUyjxl3IqH04nOKSYWgJhqefNXGt4i3+PZLG6ML9Gzh5E5lgiYQV0T8OlmM
         2jiZ87SyTf9C32t2drz87BtHKnp+TY2zl5Aj2IncWhY0WLo52PEpVpP1Ye319HTp7WF3
         3OgC6yDV/NsYQZ2vNCBUXbhwVu5rLAi3F5DMV8jepyMQPwx3PGOsKkSxrqphNvNUIi3P
         FktfIBflb3F/gmvCOB8tThW0zesZo2vc4qdsogJal25/9Bvfr+Uhf6DbdycCHrAtnI9y
         dwwhudbBwueI6t35XZpBWRfwn7af0EwF99tVXJIrOQLYWDaRJJD+Sn/ire+2H6A+wiTr
         JBig==
X-Gm-Message-State: APjAAAVYRN4GjrzqjWkmvZCaKGXJ4yVI3zFmBKLuO8pT0ggUAE6ioKO9
        OiPyeM6ajfiYThHUzjt6h2LDRMi5exx90rsHeRE=
X-Google-Smtp-Source: APXvYqxcwh5rrbn++4L5/j2U9db0EzfNGRDoVjxqurQKOaKU/xr8eBmZljI/KTRqAboRR5xu1fDZOpaEruBX/xYH+4w=
X-Received: by 2002:a02:c787:: with SMTP id n7mr26149015jao.85.1577150166760;
 Mon, 23 Dec 2019 17:16:06 -0800 (PST)
MIME-Version: 1.0
References: <CABeXuvq+37-WO8KH5en-1LaSGOLbw9zziC4eAqGvpJwe85kudQ@mail.gmail.com>
 <20191223051622.7975-1-deepa.kernel@gmail.com> <CAOQ4uxh=aBxGsbPmwup_0iSBuPQd1W42z=DgXh1bFszxwy+16w@mail.gmail.com>
In-Reply-To: <CAOQ4uxh=aBxGsbPmwup_0iSBuPQd1W42z=DgXh1bFszxwy+16w@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Mon, 23 Dec 2019 17:15:54 -0800
Message-ID: <CABeXuvr74C0DS-K4_us4CdPPFxp=7RHmCHAZQQmJrh=PZfux-w@mail.gmail.com>
Subject: Re: [PATCH] generic/402: Make timestamp range check conditional
To:     Amir Goldstein <amir73il@gmail.com>
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

On Sun, Dec 22, 2019 at 10:36 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Mon, Dec 23, 2019 at 7:16 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> >
> > Addition of fs-specific timestamp range checking was added
> > in 188d20bcd1eb ("vfs: Add file timestamp range support").
> >
> > Add a check for whether the kernel supports the limits check
> > before running the associated test.
> >
> > Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> > ---
> >  common/rc         | 11 +++++++++++
> >  tests/generic/402 |  3 +++
> >  2 files changed, 14 insertions(+)
> >
> > diff --git a/common/rc b/common/rc
> > index 816588d6..472db995 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -1981,6 +1981,17 @@ _run_aiodio()
> >      return $status
> >  }
> >
> > +_require_kernel_timestamp_range()
> > +{
> > +       # 128-byte inodes do not have room for extended timestamp
> > +       MKFS_OPTIONS=-I128 _scratch_mkfs_ext4 &>> $seqres.full 2>&1 || _fail "ext4 mkfs failed"
> > +
> > +       mount -t ext4 ${SCRATCH_DEV} ${SCRATCH_MNT}
> > +       _check_dmesg_for "ext4 filesystem being mounted at ${SCRATCH_MNT} supports timestamps until 2038" || \
> > +               _notrun "Kernel does not support timestamp limits"
> > +       umount ${SCRATCH_MNT}
> > +}
> > +
>
> Deepa,
>
> Thank you for following up.
> I am not sure if mkfs.ext4 of scratch partition in a generic test is going to be
> very popular - let's see what others have to say.
> You can certainly now do that without checking that  ${SCRATCH_DEV} is
> a blockdev which is not the case for overlay and networking filesystems.

 _require_block_device() should alleviate this concern. But, I think
making it a loop back device is a good idea.

I meant to check when mkfs.ext4 would fail, but I forgot. I will
change this in v2.

> Why did you choose not to use a loop mounted ext2 for the check as
> I suggested?
> You can use _require_loop() and _require_ext2() inside the check.
> In any case, please also check for failure to mount.

I did not not see anybody creating ext2 filesystem, and I thought that
finding a kernel supporting ext4 was a lot more likely. We can add a
_require_ext4() along the lines of _ext2_reqire() if really necessary.
We should also add "_require_command "$MKFS_EXT4_PROG" mkfs.ext4".

I think it does not matter which filesystem we use unless we get the
warning. Let me know if I missed something.

I will pick one of the two: ext4 (with small inode) or ext2 and do a
loop back device instead for v2. I will also add the suggested-by that
I forgot on this patch.

-Deepa

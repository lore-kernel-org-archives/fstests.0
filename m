Return-Path: <SRS0=Jsw6=3G=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9E2C33C9E
	for <linux-fstests@archiver.kernel.org>; Fri, 17 Jan 2020 19:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137202082F
	for <linux-fstests@archiver.kernel.org>; Fri, 17 Jan 2020 19:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1lXcO4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgAQTCA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 17 Jan 2020 14:02:00 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:39802 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgAQTCA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 17 Jan 2020 14:02:00 -0500
Received: by mail-io1-f67.google.com with SMTP id c16so27125159ioh.6
        for <fstests@vger.kernel.org>; Fri, 17 Jan 2020 11:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HrmGYo08mVnjLImBEtqTFECpfqOfPJAFnX1KuvJxS/0=;
        b=W1lXcO4trg3RhzFhojECUwmTtYfCMPBNUF6Q+cuUSs26UpJbh2UuzooCCP9w1oxaOJ
         paiGo1d6U7V/UMXlXaTw7gGtYJHuNU+CPWJRsElqjRxUEzdP1IMacF+INtOEl6Z2fLEN
         bd2XA3yGqloIJxxXSRSyelyq/AsHHzRMragRSAVwZbV7qQD/JHERX7eM/KWhiUp7IzXg
         l2ZlPIlbd/LiyNQ3p8GZe/d5AS39poprgU05qQBIc+IuLR7WDYjZ70p6UaDOXz5IQ5/S
         vPsLhogPyhg4gEjVA0Oi7rbAbO8ntJ04OGmEo2ZQNUXSlbVhN7CKnbSMg9NYQBiehhnm
         fRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HrmGYo08mVnjLImBEtqTFECpfqOfPJAFnX1KuvJxS/0=;
        b=BbUn3/wO5svgTfm4GC2yqogkbZy5OyT7irkDoUCOgUpWnKeeix1V9cr8a1C+M6AQ+E
         P3SH8pw7FqARxVMXvEEmBJX5YDls2gRl32dpvdBpWXF87gA9fpJWYxReBhS9eXYkHPVZ
         jTipItwJhaz0bjAMEiSmha0DN6uu0YQkyhggBdqFfKxdXXB+kJYpzDyx5y63QYvwVrk8
         kOFZWTqNgNHDuqasDh/dMWapN87M/yzi6wuYNMV2kFVW12dpyB2jIdhhY7KBbAxoDy3c
         gKVe36gzT3q+HEcp5f9O48K2ggnKpOnl6PmYzW/ljvXf8fzdBe8KUPocy2xYk+mXFuEu
         Vj/A==
X-Gm-Message-State: APjAAAXaef9LjXwY6TnJVbkDtEg5Fy9ILl+doePCn8e1V66NzVehZWsa
        gHuK+EDBJB+QuRlRvxqksxKpkOa9hy9htKRf/GI=
X-Google-Smtp-Source: APXvYqzbSN6xo7sGvj+UisBznR9ZEP2tbjNxN8rM247fMWB2Exo+ObUNOvTHYI6Qttcg+aB4LOvf18bcZg4cd+/JewY=
X-Received: by 2002:a6b:8b15:: with SMTP id n21mr32244789iod.110.1579287719664;
 Fri, 17 Jan 2020 11:01:59 -0800 (PST)
MIME-Version: 1.0
References: <CABeXuvr74C0DS-K4_us4CdPPFxp=7RHmCHAZQQmJrh=PZfux-w@mail.gmail.com>
 <20191228221317.16654-1-deepa.kernel@gmail.com> <CAOQ4uxifpjjirTyUsCm03TFx8LOvkt0xX+RNyFZU5sHNU+bfqA@mail.gmail.com>
 <20200108080936.GG893866@desktop> <CAOQ4uxhOGZfLch1HDFACD9fLczpLHxVMoY50ZyJDOyAJBp-WyQ@mail.gmail.com>
 <20200108095021.GH893866@desktop> <CAOQ4uxg7cu5eYskPAEhGrB6MWrt9rzdg1+EadGBOBSmw7iN6hA@mail.gmail.com>
 <CABeXuvrexoO9y894EXU9vc8=BLvLMB8EgOi2OdxT1hp5xHFPvQ@mail.gmail.com>
In-Reply-To: <CABeXuvrexoO9y894EXU9vc8=BLvLMB8EgOi2OdxT1hp5xHFPvQ@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Fri, 17 Jan 2020 11:01:48 -0800
Message-ID: <CABeXuvoDnwS5Km657iDwgWVL=L3muqqJp51owc0kkNcTFRrEYw@mail.gmail.com>
Subject: Re: [PATCH v2] generic/402: Make timestamp range check conditional
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Eryu Guan <guaneryu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jan 17, 2020 at 10:23 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> On Fri, Jan 17, 2020 at 1:09 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > > > I understand why you dislike the ext2+loop test, but please hear me out.
> > > >
> > > > From all the fs types that are supported by the test, only btrfs and ext4 with
> > > > large inode size are y2038 ready.
> > > > For the rest of the cases, we actually have a way to detect kernel support
> > > > from the dmesg warning, without the need for hacky ext2 loop mount.
> > > >
> > > > So how about just:
> > > > 1. moving  _scratch_mount before _require_timestamp_range
> > > > 2. in _require_timestamp_range (untested):
> > > >         if [ $tsmax -lt $((1<<32)) ] && ! _check_dmesg_for "supports
> > >
> > > Yeah, this looks fine. I thought about searching for dmesg warning after
> > > _scratch_mount as well, but that would _notrun if the fs is 2038-safe.
> > > This $tsmax check fixes my concern. Thanks!
> > >
> >
> > Deepa,
> >
> > Do you intend to post the simplified version or would you like me
> > to re-spin your patch?
>
> I intend to do this. Sorry, was distracted by other things. FWIW, just
> (1<<32) is not enough. The kernel prints this warning based on
> (current time + max uptime) <= tsmax. Will post this.

Also we are testing for the following timestamps in the test:

declare -a TIMESTAMPS=(
        $tsmin
         0
        $tsmax
        $((tsmax/2))
        $((tsmax+1))
)

So the test can still fail if the above tsmax test passes, but the
limit patches are not in the kernel.
https://lkml.org/lkml/2019/7/29/1850 has the limits for all the
filesystems I filled in. fat, cifs, hpfs etc. all fall in this
category.

I do not see a good way of doing this unless we test for a fs that
always fails in a predictable way.

Checking for fsinfo maybe is ok. But, at that point we could just rely
on any syscall that got merged after the limits series isn't it?

-Deepa

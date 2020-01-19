Return-Path: <SRS0=QNn/=3I=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6925CC33CB1
	for <linux-fstests@archiver.kernel.org>; Sun, 19 Jan 2020 09:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A352081E
	for <linux-fstests@archiver.kernel.org>; Sun, 19 Jan 2020 09:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWYAUV9P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgASJTg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 19 Jan 2020 04:19:36 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33264 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbgASJTg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 19 Jan 2020 04:19:36 -0500
Received: by mail-io1-f65.google.com with SMTP id z8so30539582ioh.0
        for <fstests@vger.kernel.org>; Sun, 19 Jan 2020 01:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uFA3njeCn98Da0a27+absgx2QkU050+uxs67jFT0jE4=;
        b=iWYAUV9PmcuqOLMJjK4L98Vwz68ZERDomC1XQ16ixiUxIjOEBRAwqzlUBj0Ks3ZPt2
         OJ9DwzrnZ26ucvGhBB4d0rDlHARdXhzVOfZlFFsMeOcBWXrDhKMmR+i/HAAizp1BtzJc
         NE67r4gx+rON1hxcrmRSfMlZ2Z6vsIM2WdWWAZG3Ci30Ghq0q/BdRgJUwlfD2642JPft
         XmuBZ4julOAYgQdZt+S0BsN0x/th7oIB/F0Za7O7Zv29A9VnmDgPiIq9PlFL3HjiesO/
         Mqq5zjvOdKZVIG1zcOcjJszv/0HJoW+449Ofay05IuQJZImJC2ME6wVxgUdKOOdmhlol
         v6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uFA3njeCn98Da0a27+absgx2QkU050+uxs67jFT0jE4=;
        b=Hc9kacYfNx1Ngs+rKTMvliYfvdveC8uy+Pgwg7O6ySKspULUbTNtICbB+aHFz95xzq
         SL2XeNP87eJd0wB8OBWGq91BqMvrP9hf2FQhv6fW5lTLZ6Q2l2lcUtetGbe9UHYyUZVB
         09nDNsihk2SfElSMndG4Bj6KQxS7U8eWYbTNb3BBmOcbYNcxj+9MxLXv/IAFlZOu2lxj
         ybTa6B0LM7/cGFJzba10Sx+Nb95ZxaAPz+FS/Wdh7tKMY+orBrP6vVZ8NPS1YrprjBUh
         FwHCf2GVHqHQWwtHIPK6DriTzcQjrCnnPPVRcu5LsYrnCuHJLit26JNGD0EUus+oL5wS
         QT8Q==
X-Gm-Message-State: APjAAAVVMXTUQA7giPKQHsmoxJAuJ467NhJDpcZYLUJX8B/DlVBXt/ym
        xZQBXvEHH0x3i/R5Uco/0klVSOGJTYlo5tud5Xc=
X-Google-Smtp-Source: APXvYqxI1FjPUXzwo8otVJNsig11BenbeEE0w9WhVxKecU3ZY/re4eWBkLTn02ChH2mdRhoZy4RtIMMyc5Uz0pOU4as=
X-Received: by 2002:a6b:f214:: with SMTP id q20mr39253926ioh.137.1579425575706;
 Sun, 19 Jan 2020 01:19:35 -0800 (PST)
MIME-Version: 1.0
References: <CABeXuvoDnwS5Km657iDwgWVL=L3muqqJp51owc0kkNcTFRrEYw@mail.gmail.com>
 <20200119005744.12852-1-deepa.kernel@gmail.com>
In-Reply-To: <20200119005744.12852-1-deepa.kernel@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 19 Jan 2020 11:19:24 +0200
Message-ID: <CAOQ4uxi9RBFYDFm=Gg=9Ct_apL5sTuUwcAJxj4-PxkCJturfig@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] generic/402: Make timestamp range check conditional
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

On Sun, Jan 19, 2020 at 2:57 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> Addition of fs-specific timestamp range checking was added
> in 188d20bcd1eb ("vfs: Add file timestamp range support").
>
> Add a check for whether the kernel supports the limits check
> before running the associated test.
>
> Based on an off-list discussion, we use a simpler interim approach
> until fsinfo syscall would provide fs timestamp limits info.
> This isn't perfect, but works for filesystems expiring in 2038.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> ---

Excellent! Thank you.

Eryu, you may add any of:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Tested-by: Amir Goldstein <amir73il@gmail.com>

On kernel v5.4, ext2,ext4,xfs,btrfs (default mkfs) still pass.
On Kernel v5.3, ext2,xfs are notrun for lack of kernel support
(instead of failing),
ext4 (256 bytes inodes) still fails
and btrfs still pass, because bash overflows $(($s64max + 1 )) just the same as
the kernel...

Thanks,
Amir.

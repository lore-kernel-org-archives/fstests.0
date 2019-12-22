Return-Path: <SRS0=f7WM=2M=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E34C2D0C8
	for <linux-fstests@archiver.kernel.org>; Sun, 22 Dec 2019 21:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9BCC2063A
	for <linux-fstests@archiver.kernel.org>; Sun, 22 Dec 2019 21:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPm42GaL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfLVVTd (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 22 Dec 2019 16:19:33 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:41264 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfLVVTd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 22 Dec 2019 16:19:33 -0500
Received: by mail-io1-f66.google.com with SMTP id c16so10836782ioo.8;
        Sun, 22 Dec 2019 13:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CXDBDWTdYlT8SsvmmiGVbrDnxW2kEr2Q0Tela7LwImY=;
        b=MPm42GaLew1hMn1xuVmh+3qyAP34+sz0eXNoE+NvEaw2dMN1fH/i+5y91L1bu4mQ46
         dnvVCThft2+m09Au+ZhAubM9Kgml36RGet69Yb461WiUe9UT4MJA4vcAyVoKqV1kmzw2
         N1gxyK5CgnVXXg9820Z8qEfMJMuuskHk/dTa7atc4SdYSnwzyRZKBNF7kJTS05jSwhrx
         KbgeEaUYoFa+v/EWTJpHVaM54GqoAMcdt5MNz9yoHlt9GT9fJ6+bgyZp1oseEGaRkylc
         04OE0zBP00UfYWqOure3Q0sllU8dDhmk3OdFLNfsNjb20Hi6TD+g6I5gkydMHVB0/8TE
         PkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CXDBDWTdYlT8SsvmmiGVbrDnxW2kEr2Q0Tela7LwImY=;
        b=TsifNUzceWT+vxlx/T8weaKcJaNClBxBmRNJUKIoPvmAq5YW+b3XIsFrxQmjvAqyBb
         5HFotvbczYpZ9tQ0BMFBsdGPmvh2dwXsH8WOSsPFBnuHwbulfddOq3HZ/BqXMUl4RKbk
         82Z+jsO7VcTKCryRmrZgxjbtEK1DCq/nejmWp5I8FPpuvGhOvcFBrCqjFqSeXip+mmEU
         82ZrFiQbfvQi4ELLRq3NhoUi0dclerfFnMorzJmlmv7tHRw1YZpnciqA3hJXHLVKhej/
         tsz1AOffNxozeGt0yAqWzwW+d8JB460vQUB90t9SabAcf5cdKzhiq3pe2ZEww3P/7hRD
         2lnw==
X-Gm-Message-State: APjAAAWXOqs3X7VS+at6zcqMRove20Tv/YTcnlGtUnRZJ86Qs+D+Sw9/
        sbR29aw3wGDsftqdKKuEF+bA8n28VviRivVZx2g=
X-Google-Smtp-Source: APXvYqxJ0VSB2rX0tAUagVVNFnU3VZN0ANk6f57lWtBfiDG4yvhNz0roASAxdp+L2dx07/TYFwiAcopxWfijHz/GFmA=
X-Received: by 2002:a6b:6b19:: with SMTP id g25mr18973455ioc.137.1577049572707;
 Sun, 22 Dec 2019 13:19:32 -0800 (PST)
MIME-Version: 1.0
References: <20191221185149.17509-1-amir73il@gmail.com>
In-Reply-To: <20191221185149.17509-1-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 22 Dec 2019 23:19:21 +0200
Message-ID: <CAOQ4uxj2+ma4LEm14WdyXSkrHMrdWkwVzQd4r-WTqGdGJ8g2Rg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Nested overlay exportfs tests
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Dec 21, 2019 at 8:51 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> Eryu,
>

Eryu,

Actually, I needed to make a change to overlay/069, so please hold on
with these.

For test coverage, the interesting cases for nested overlay are:
- lower overlay is samefs
- lower overlay is non-samefs

That last case is especially interesting to exercise xino bit overflow,
because lower overlay uses the high ino bits.

This is not how I implemented overlay/069, so I made this change and
it caught another bug in upstream.

I have more nested tests coming soon, so I will post those along
with v2 of these tests.

Thanks and sorry for the noise,
Amir.

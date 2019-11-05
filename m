Return-Path: <SRS0=5Vws=Y5=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E890C5DF61
	for <linux-fstests@archiver.kernel.org>; Tue,  5 Nov 2019 19:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DDEA21929
	for <linux-fstests@archiver.kernel.org>; Tue,  5 Nov 2019 19:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="It1bio6h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390912AbfKET0k (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 5 Nov 2019 14:26:40 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:44344 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390783AbfKET0j (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 5 Nov 2019 14:26:39 -0500
Received: by mail-yb1-f194.google.com with SMTP id g38so9526885ybe.11;
        Tue, 05 Nov 2019 11:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QaPx4O7IO+juHnetx2kaZUD2w6wterpSs3P4Wd6T41M=;
        b=It1bio6hctZwgMyH78MUdfxvNkMOIFbu+NU5XMn5RbiJWsAAblAVTuu7FXrmDgX/eq
         4Y1gQx9Z2bPqz6OvetRfkpJWknIQePYw8mEfsv0qJnicOHpjDK3pYMmGcTw09rj6V4JH
         DOe/0NFZFY5r5m5KMTC020YRRchTWS3FaQbTnyBjI+0NQL4k9kj/BVEjiTtLwWN9PJZh
         jpXJBJ+6CfYCl30WYSquoheLWf2yz0crnEhrubVdBVdyEOZokS9lHXuml+6NHllko7db
         D4aTH6MunH/XhzsIHH2gn1KPjJ693JTaSB0jrOu4vxgkfDhheDzD9TvkgpfGyFprmz5p
         7pGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QaPx4O7IO+juHnetx2kaZUD2w6wterpSs3P4Wd6T41M=;
        b=dup17pWViDD0HYg2HPNDfLtOOcAb3n4ZHAJNqlA5eWtuA+CeJsApf9RirKvLQd6qJQ
         fIo6Tlu2PcT0CRJfQaa9Pp0NGeCO1Vofwx6ZraJCK43zOhmbaxIfS755GANQtTHL/0f6
         knJOAqdLyb8mnK8vWmQ/Vs7oWLw4gdMg0gYW8L0fffC3rhZ76DUUT7rMqDaAnKXbQh2D
         ysj8KOpbt5KgDiPdPGaVyhzXJL1mUeoKPq3koN+2bCDMDjnwZSx6LtqZbVTkPEd8UHsq
         Mw4osGVv88GXvU1H3F77HftP2TRiH8H4x2i9OhfOkFvUyOgslQAS+nFRow9vJV0l6BmJ
         FuMA==
X-Gm-Message-State: APjAAAUlFOsha/re5F7O6467ylvqUxgDJZ1DWsNl8ci1bnBhXMbKY964
        XwlRUhbNhCxPE9rQpbkUsDQf/7x+H1RU5czWhWM=
X-Google-Smtp-Source: APXvYqw73HxE4JKVXgGuSGOSm1N34LH6eaV7TmNQbKZCZ20GJLmoVn0/J2Usi0xUJjbG0pSLAngDD3ogbJsuWDs90O0=
X-Received: by 2002:a25:1444:: with SMTP id 65mr27231097ybu.132.1572981997332;
 Tue, 05 Nov 2019 11:26:37 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxgy6THDG2NsNSQ+=FP+iSZKeCkNEM9PbxQSB5p5nHvoCA@mail.gmail.com>
 <20191105115431.GD26580@mbp> <CAOQ4uxjm=tWsQpfLkY9O_3qWK86X=kCD19P8zJAQjs5ms_RfZw@mail.gmail.com>
 <20191105153055.GC22987@arrakis.emea.arm.com> <CAOQ4uxjDnu-1eUwAkYW+dRPYAeQsc07on1kk+_emBhZBvj+bAg@mail.gmail.com>
 <20191105182212.GF22987@arrakis.emea.arm.com> <alpine.DEB.2.21.1911051948350.1869@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1911051948350.1869@nanos.tec.linutronix.de>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 5 Nov 2019 21:26:25 +0200
Message-ID: <CAOQ4uxjwSokr=8K02AOVkjb7UK_qCccQ8gAaEnh116oKSeEn6A@mail.gmail.com>
Subject: Re: 5.4-rc1 boot regression with kmemleak enabled
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Theodore Tso <tytso@mit.edu>,
        fstests <fstests@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>, Qian Cai <cai@lca.pw>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Nov 5, 2019 at 8:49 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Tue, 5 Nov 2019, Catalin Marinas wrote:
> > On Tue, Nov 05, 2019 at 08:17:11PM +0200, Amir Goldstein wrote:
> > > [    0.027836] RIP: 0010:get_stack_info+0xa7/0x146
> >
> > Ah, it looks very similar to this report:
> >
> > http://lkml.kernel.org/r/20191019114421.GK9698@uranus.lan
> >
> > Thomas had a patch here:
> >
> > https://lore.kernel.org/linux-mm/alpine.DEB.2.21.1910231950590.1852@nanos.tec.linutronix.de/
> >
> > but not sure whether it has hit mainline yet.
>
> It's queued in tip. Will hit Linus tree during the week.
>

Works for me.
Thanks,
Amir.

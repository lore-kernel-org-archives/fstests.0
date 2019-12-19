Return-Path: <SRS0=0bps=2J=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1179C43603
	for <linux-fstests@archiver.kernel.org>; Thu, 19 Dec 2019 12:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C271320716
	for <linux-fstests@archiver.kernel.org>; Thu, 19 Dec 2019 12:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4Cuz1SO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfLSMJR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 19 Dec 2019 07:09:17 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:43434 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfLSMJR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 Dec 2019 07:09:17 -0500
Received: by mail-io1-f65.google.com with SMTP id n21so3927276ioo.10
        for <fstests@vger.kernel.org>; Thu, 19 Dec 2019 04:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bA/Cx/JDU44UBi3qJtnyoTDa4yYENAUAkjfAlY4opDA=;
        b=M4Cuz1SOHtRnmieD/ZDLkFEpaSt1g1D9HCzcGbvy0lmnkUCdZDjTDgOnAc3xmqa6Ek
         axxniSPvXgCqEb5YJhWhnkssXl6xqxmrrvKfYeyBvzRRg2+VvQZtqHvFRGLlACkdxODi
         aZIDYbow67Av6KAczQRDvSqeBbQWB+c+BkSEJpu4+gb19OJTIulej42f1nfI5fTGf660
         3NyX0AMPmj8Atl9+81/m6yytFLwcCRXW7juE7kZaRHmJDHrvuG1FAWjN9z5y/FCmrttg
         UfYh9l7p0qD8d92YBAICPDK7nfSQrKnRZ5DttkfrJh4bPbakoY2Fv7WcKwpDEosvuGDL
         wCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bA/Cx/JDU44UBi3qJtnyoTDa4yYENAUAkjfAlY4opDA=;
        b=Mwe9S/2wWr5hLUfT0WH4eqP1zSePiZHEKXZCp4rQbIMy9RW1ZHglAfNO+LKjOaKpqh
         35xEnJrlc4irO7Ac7ptIUdSFKLyiLqtAYjVhWK3QVIM9Nn0SBI+5HaqBTnFuc1V5GgOh
         WhW9mFb+Z7KG+6pyBCUkmvbmN6M21B7uvJyikdLvp4SpSjwFOk9b6mqRL3r4DgP2nHic
         mT/gNGLb64aukxoqSUymaQrAkKMdpn+9mTteGUcQlrKKbWJqIm2zBE7TW5VfZ2NapeXn
         gy301LX7QgqO2UE7jSy0l2y0MOSKSTwR79bXKKY4opwlkTPFpMYdlBLpAg2KmPVp2QQA
         xW+g==
X-Gm-Message-State: APjAAAX0yiO+qh8etvoNVfI6CevqHz1oU5GGVkrGd/7ZwqDrbhbVy1lw
        ifhyMStmnH7Gh71Dc4CbuAeB9ZF/a0DqRC6UBHc=
X-Google-Smtp-Source: APXvYqxxHDiY/n7mn2N34yaQTDtKj+aewqDl05gzDOWplRCXo7zR9TL5G2ZieTbsLLTj1thx0EZoIlaaAGAsL6g0F6Y=
X-Received: by 2002:a5d:814f:: with SMTP id f15mr5431380ioo.275.1576757356580;
 Thu, 19 Dec 2019 04:09:16 -0800 (PST)
MIME-Version: 1.0
References: <20190719041231.26500-1-deepa.kernel@gmail.com>
 <CAOQ4uxhxVKhUh_P_NffLbGScpiL0wOrCTLwWJWeSbRRNbHzPrg@mail.gmail.com>
 <CABeXuvoHw8W02JsmZjafnQkOs1=0dodSpBFyJ_Gq+1vs+hFkQQ@mail.gmail.com>
 <CABeXuvqO=04BJw2bWa6d2fv1FTe-B_JsNhVdYTwT=fY=ncOCkw@mail.gmail.com>
 <CAOQ4uxjaFBZZUKyu6YS08ta8pdW_FSjRYA4J7S8+_=Gfi-kO2Q@mail.gmail.com> <CAK8P3a1fYPq6DCqhT6ziJaxETLHt8uUgbHWryHiD4kQWwKLp2Q@mail.gmail.com>
In-Reply-To: <CAK8P3a1fYPq6DCqhT6ziJaxETLHt8uUgbHWryHiD4kQWwKLp2Q@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 19 Dec 2019 14:09:05 +0200
Message-ID: <CAOQ4uxjaqV=d9SPYPPODOT0MNpSARQNQW0=4qb8N4u7ni-hupg@mail.gmail.com>
Subject: Re: [Y2038] [PATCH] generic/402: fix for updated behavior of
 timestamp limits
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        fstests <fstests@vger.kernel.org>, Eryu Guan <guaneryu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Dec 19, 2019 at 10:28 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Dec 18, 2019 at 9:46 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > I don't think there is a clear policy about being friendly to testing
> > less that master kernels in xfstest (Eryu?), but IMO we should try to
> > accommodate
> > this use case, because it is in the best interest of everyone that stable kernel
> > will be regularly tested with xfstests with as little noisy failures
> > as possible.
>
> I think what makes this one particularly hard is that there are most likely
> people that do care about the failure on older kernels being reported and
> would rather backport the kernel changes into their product kernels
> to have them behave sanely.

Getting back to the thread before it diverged into the backport option.

The test used to detect kernel support and be skipped automatically on
old kernel
and now the test fails because the kernel knob and test for it were removed.

I perceive that as a regression to the test.
I don't mind waiting for fsinfo() to fix this regression, as long as
fsinfo() is going to
be backported to stable kernel 5.4???

Deepa,

You added this warning:
pr_warn("Mounted %s file system at %s supports timestamps until ...
along with timestamp clamping

I suggest that you implement kernel support check based on grepping
for this warning after loop mounting an ext2 test image.
A bit over the top and ugly, but the test should be reliable and
mkfs.ext2 is probably available in all xfstest deployments.

xfs/049 makes use of an ext2 loop mount, so your test won't be the
first one to use ext2 for testing other fs.

When kernel gets fsinfo() the test for kernel support can be improved
to using fsinfo() before doing the ext2 loop mount hack.

Thanks,
Amir.

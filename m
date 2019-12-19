Return-Path: <SRS0=0bps=2J=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6387C3F68F
	for <linux-fstests@archiver.kernel.org>; Thu, 19 Dec 2019 08:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0B524688
	for <linux-fstests@archiver.kernel.org>; Thu, 19 Dec 2019 08:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfLSI2m (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 19 Dec 2019 03:28:42 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:33843 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfLSI2m (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 Dec 2019 03:28:42 -0500
Received: from mail-qt1-f179.google.com ([209.85.160.179]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MsI0I-1hoWjC3cDa-00tjlH for <fstests@vger.kernel.org>; Thu, 19 Dec 2019
 09:28:41 +0100
Received: by mail-qt1-f179.google.com with SMTP id k40so4366334qtk.8
        for <fstests@vger.kernel.org>; Thu, 19 Dec 2019 00:28:40 -0800 (PST)
X-Gm-Message-State: APjAAAU4BnDZs7yQroxCpVrAdF0mUpRwiWrIPqnt4AqOPPf/epxmgbiu
        bdFUSythkRLnQ7rmwzEwqFH9toH7QAyETGaTKCU=
X-Google-Smtp-Source: APXvYqxZUPfuVLPAqgkGw8sfPYPCXLsFXyHY9W4ZlmC6TuV4qCSSXimemPtzjBlJfSFm4pztGDRanH9DZ8GKmK07SSU=
X-Received: by 2002:ac8:709a:: with SMTP id y26mr5983674qto.304.1576744119788;
 Thu, 19 Dec 2019 00:28:39 -0800 (PST)
MIME-Version: 1.0
References: <20190719041231.26500-1-deepa.kernel@gmail.com>
 <CAOQ4uxhxVKhUh_P_NffLbGScpiL0wOrCTLwWJWeSbRRNbHzPrg@mail.gmail.com>
 <CABeXuvoHw8W02JsmZjafnQkOs1=0dodSpBFyJ_Gq+1vs+hFkQQ@mail.gmail.com>
 <CABeXuvqO=04BJw2bWa6d2fv1FTe-B_JsNhVdYTwT=fY=ncOCkw@mail.gmail.com> <CAOQ4uxjaFBZZUKyu6YS08ta8pdW_FSjRYA4J7S8+_=Gfi-kO2Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxjaFBZZUKyu6YS08ta8pdW_FSjRYA4J7S8+_=Gfi-kO2Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 19 Dec 2019 09:28:23 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1fYPq6DCqhT6ziJaxETLHt8uUgbHWryHiD4kQWwKLp2Q@mail.gmail.com>
Message-ID: <CAK8P3a1fYPq6DCqhT6ziJaxETLHt8uUgbHWryHiD4kQWwKLp2Q@mail.gmail.com>
Subject: Re: [Y2038] [PATCH] generic/402: fix for updated behavior of
 timestamp limits
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        fstests <fstests@vger.kernel.org>, Eryu Guan <guaneryu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:yP8k9zKU9tt0VCBlALAipdt/T4Vk6//QQEsx5ZiuJlpxMjCDd1e
 2n4PEL06o0o3epA1FysxycXOAHnY9IzQadKqVNmgrKH1MmJLXiCJHyRxU1dBvM8jOvYIuxK
 YClqrDQaY4wYX3VqthC4WbJedUH2mBhBfjYgHM1Wi1+XrO/9SCdBVWsVcF+dmbNpxUWC1Jh
 OF5SxC3tbVTklyVeu/i3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/pyMek4A4kE=:jylZwo4wodP1EHtL1LxKv8
 OztqyqXPm8rKQE33Vvj5BDXYCHhQResxJFik/Rn+XEeNv4SIy9tBVbG9e12MRFlrCXarWTlM/
 jTMWe4HxGiFC/CyVIGMB0fQ+kOxNfn6Ga++n+4LBIwcUeI9wAlalhlPo6jaLShGOx5JHod6/l
 DBgFbdxCkvJqk+Ea80/zy9IO1wxX7wAQnK2yYFvKCmPFqN9GVuy8zWsovs17V3KwYFXr1T/WI
 AqFjR1bfEMA6pTpTeduhfkXfm+ZP2MX02smaLb+MGYHIbdhAN6qwQgtXc1GP6jj57le9KRZQg
 wmGrkNtU9iXyYDsGQ5ely2AmEBqK9LkZ9bCUEk555IN8wV468eXfK3aCGuA/3UULsyehVqm77
 WIXnisZjUgNp+GWYXGbnDlQf0e//4mD35Fl/+yI4Xvcyi9ac4sGFOOZQlddpA5Hv9WBZlthMQ
 BpxWruW8ZvwZmSaLSuKWIpKZH6VITFQtvF+C1nDxZr/Pe7btmJWE99AC+LxoLj/5AMxamtK6F
 ykgCYJgT49WelBKk6ti9wO7GiLzvdUhhhcx4U7+B3FAmvc/TVBTspK1bdQpRQeFx2KgppG/SR
 wLsVazzCghCMQHQWYcvF17L+rl/8UamXIVqXAoGaKJSi+zrDX9/JDkShi1gaFq+9RFqpiD9Nr
 F1fzyDNDlW9y0VK+SeWqAkDmsL+R3k/AYaeJgvVn9pdAbggPia1kOKGSY9AhQdqkVzvGP6R9f
 DhSXxfC8UOYbDzL/eQYqHJEgEUmzkra9835Ub4uXlSsPBl0ILfQIpphvWSzFXJEkPiKTEItsB
 cXfWQYGnB/DZbo+deeuatQw58I1WK1cRrj24ncPYKeuWovyvllRFPGW+Znp4TKMdj5QfCkdsM
 4xzk/Fg0iYFrBR6y4krA==
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Dec 18, 2019 at 9:46 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> I don't think there is a clear policy about being friendly to testing
> less that master kernels in xfstest (Eryu?), but IMO we should try to
> accommodate
> this use case, because it is in the best interest of everyone that stable kernel
> will be regularly tested with xfstests with as little noisy failures
> as possible.

I think what makes this one particularly hard is that there are most likely
people that do care about the failure on older kernels being reported and
would rather backport the kernel changes into their product kernels
to have them behave sanely.

I'm also not sure if we could just backport the changes to stable
kernels after all.

Greg, do you have an opinion on whether the 19 patches from
v5.3-rc6 to cba465b4f982 can be considered stable material?

The best argument that I have seen in favor of treating it as a bugfix
is that the posx man pages require that "The file's relevant timestamp shall
be set to the greatest value supported by the file system that is not greater
than the specified time"[1], and this is something that Linux has always
done wrong before the series (we overflow and underflow out-of-range
arguments to a value that is both file system and CPU architecture
specific).

The main argument against backporting would be that 19 patches
is too much, I think each patch in the series would qualify on its own.
Changing the layout of 'struct super_block' also breaks the module
binary interface, which will annoy some distros that care about this,
but I don't think it's stopping us from adding the patch to a stable
kernel.

       Arnd

[1] https://pubs.opengroup.org/onlinepubs/9699919799/functions/futimens.html

Return-Path: <SRS0=0bps=2J=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC66DC43603
	for <linux-fstests@archiver.kernel.org>; Thu, 19 Dec 2019 11:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89BD42465E
	for <linux-fstests@archiver.kernel.org>; Thu, 19 Dec 2019 11:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfLSLaA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 19 Dec 2019 06:30:00 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:40611 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbfLSLaA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 Dec 2019 06:30:00 -0500
Received: from mail-qk1-f178.google.com ([209.85.222.178]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mwfeu-1hjzv20bHe-00yAQs for <fstests@vger.kernel.org>; Thu, 19 Dec 2019
 12:29:58 +0100
Received: by mail-qk1-f178.google.com with SMTP id z76so4710868qka.2
        for <fstests@vger.kernel.org>; Thu, 19 Dec 2019 03:29:57 -0800 (PST)
X-Gm-Message-State: APjAAAUDguFEr8mcieDSE6lBMT7xu3V5wV5uNn9YoRmOs0PXW+H1X3Xt
        fbfigZ3HM5NJGajXk+JA1hrhquRc84kxhVpKF7Y=
X-Google-Smtp-Source: APXvYqwANkLTDqGhpVpVcU4Os8O02S6IE33LmX7WfEDEtIuOZPke7fhbOMgOhNq1Y9QQ8gyLi8oxmrD2fOZER/BTWK8=
X-Received: by 2002:a05:620a:a5b:: with SMTP id j27mr7612620qka.286.1576754997002;
 Thu, 19 Dec 2019 03:29:57 -0800 (PST)
MIME-Version: 1.0
References: <20190719041231.26500-1-deepa.kernel@gmail.com>
 <CAOQ4uxhxVKhUh_P_NffLbGScpiL0wOrCTLwWJWeSbRRNbHzPrg@mail.gmail.com>
 <CABeXuvoHw8W02JsmZjafnQkOs1=0dodSpBFyJ_Gq+1vs+hFkQQ@mail.gmail.com>
 <CABeXuvqO=04BJw2bWa6d2fv1FTe-B_JsNhVdYTwT=fY=ncOCkw@mail.gmail.com>
 <CAOQ4uxjaFBZZUKyu6YS08ta8pdW_FSjRYA4J7S8+_=Gfi-kO2Q@mail.gmail.com>
 <CAK8P3a1fYPq6DCqhT6ziJaxETLHt8uUgbHWryHiD4kQWwKLp2Q@mail.gmail.com> <20191219084046.GA1026636@kroah.com>
In-Reply-To: <20191219084046.GA1026636@kroah.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 19 Dec 2019 12:29:39 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1HiPLbajjoYQf0N4RBw9eUK6uyC+mOq7LaRmNpgiOgLA@mail.gmail.com>
Message-ID: <CAK8P3a1HiPLbajjoYQf0N4RBw9eUK6uyC+mOq7LaRmNpgiOgLA@mail.gmail.com>
Subject: Re: [Y2038] [PATCH] generic/402: fix for updated behavior of
 timestamp limits
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        fstests <fstests@vger.kernel.org>,
        Eryu Guan <guaneryu@gmail.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:PxoD7PhdohpXK34nb/Ym3jiuAgrK6ve/5I/uba9hOaaFzxGQisH
 QmMaxzFJGU3BLJJSk2c7EEcGIWyLeFd+GeDSeFgDM8XxTu3M86GEweEQvriSYB7DkR2Tglk
 eO/I0B6WT1JAVlW04UO8OqzMY53oV1G4ospb55hq3lEHsUdGo45g/7Ob4QSVK/x9cwCm7EJ
 E01bSGMTPpDlu71/8ikQg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sKaPu+XsFhU=:vTCzsy988TFApNmOYEuEhd
 X6kIk14zccsDdnyYIiDldyPHxCri7onH/1ltWb1HV12ImWbBgvMZHJcNLlJkaesB3Kjm/bmPv
 f2z/c5bkxywh/FuG9tkdPmWRU7kIJKgLWUbPwKKtHfu6iUWjvCEyHsYfKBApty5WxG8BPACwM
 PDblqBTOFh2k2pluedXHB12dVOGu+fceCB25gnNCcsO7PLxDpeNuzD/fdgGespTktFKbsSRBS
 T9u9NOE2lAaqHcBGxX0Y4MmVwwOnZ50l5aukHwV171PzpLM0IiFPYNZklaVWIe8HnEvswTsWT
 pG8LQgBK2hYnF4QY+d5ZClILlni42QNlVqaJ5Bw8Fq88RO9aDeAnPz43gcmH0njcLLqwjQePI
 3mpGeJEihOIkmJ4Li/CGD+psnxRGgkE0m62JvKfIAfKK/d+4u6r6jXQlFcX1TdsU5EIb5h7VI
 4NZcnoLytyLXx+mu18gaQcpOlKC9IP2aNIT+8qZX4u9LMT+Wv5yRDhcVJ7of+Rcg/1mc/wBry
 fgSkxNbb703TaNGnrQqnRr3PDkW8p9BbgYCoUOpqBujgrs31PsG8k81Mwovt9g/9Z2uGECwYq
 pQm+zIH50//neAfwzMdrUhJElmWiCOf9ASDIrZRUAuFsvIxlwA1NWIjCCE608gtJvzG0emPqw
 264y07Ctvu1BEw76jCzk2FaAor+mcUwzfS1WlxWLrsgY2zZHTWXz9C5HsEM8TQXU4Pb8fhSn0
 ywnaBigvcY8rgSNLF3DUY0H1EcEd+jPNy5f1OxYTUOYUf0wToc6/W5FLbTD3pSCwrm/Z24R1D
 mTzssGroDDkJbxm7azmCVjqIOXrxXzFU/P4tA2gmvLPAnAiFAU5hSHN6n3GLWtP0meYBh8jCb
 ObtIN4E5I/cH9tHlusgQ==
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Dec 19, 2019 at 9:40 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> On Thu, Dec 19, 2019 at 09:28:23AM +0100, Arnd Bergmann wrote:
> > On Wed, Dec 18, 2019 at 9:46 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > [1] https://pubs.opengroup.org/onlinepubs/9699919799/functions/futimens.html
>
> Ugh, that's a mess.  Why not just use 5.4 if people really care about
> this type of thing?
>
> But yes, on their own, each individual patch would be fine for stable,
> it's just that I would want someone to "own" the backport and testing of
> such a thing.  If for no other reason than to have someone to "blame"
> for when things go wrong and get them to fix up the fallout :)

I was going to volunteer Deepa and me, but I just tried out what a backport
would look like, and backporting to v4.14 or earlier would involve a
major rewrite unless we also backport Deepa's earlier y2038 patches that
are much more invasive. Backporting to v4.19 (across the mount API
change) would be possible, but this doesn't really help the cause of
getting xfstests to report correct behavior on all stable kernels.

> Who really really wants this in their older kernels?  And are those same
> people already taking all of the stable updates for those kernels as
> well?

I see two potential groups of people:

- the one that started this thread: xfstests correctly reports a failure on
  stable kernels that have a known problem with compliance. If you are
  aiming for 100% pass rate on a test suite, you can either mark a correct
  test case as "skip", or backport the fix. Neither one is super attractive
  here, but it seemed worth considering which one is more harmful. (I
  guess I answered that now -- backporting to v4.14 would be more
  harmful)

- Users of CIP SLTS kernels with extreme service life that may involve
  not upgrading until after y2038 (this is obviously not recommended if
  you connect to a public network, but I'm sure some people do this anyway).
  For running user space, this requires either a 32-bit kernel with the
  linux-5.1 syscall changes or a 64-bit kernel. If you run a 64-bit linux-4.9
  kernel in a deeply embedded non-networked machine, it still makes
  sense to have working inode timestamps and be able to test that.

It may still make sense to backport this to linux-4.19.y-cip or another
downstream version of 4.19, but let's not do it for the normal LTS
kernels then.

       Arnd

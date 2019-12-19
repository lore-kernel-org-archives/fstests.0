Return-Path: <SRS0=0bps=2J=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F66C43603
	for <linux-fstests@archiver.kernel.org>; Thu, 19 Dec 2019 20:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E01227BF
	for <linux-fstests@archiver.kernel.org>; Thu, 19 Dec 2019 20:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfLSUgE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 19 Dec 2019 15:36:04 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:51825 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbfLSUgD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 Dec 2019 15:36:03 -0500
Received: from mail-qt1-f172.google.com ([209.85.160.172]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M3lgJ-1ihDBB0RZT-000ww8 for <fstests@vger.kernel.org>; Thu, 19 Dec 2019
 21:36:02 +0100
Received: by mail-qt1-f172.google.com with SMTP id e5so6191249qtm.6
        for <fstests@vger.kernel.org>; Thu, 19 Dec 2019 12:36:01 -0800 (PST)
X-Gm-Message-State: APjAAAW76iI8CcNtZnLh6K2zYqBDLja+NerLDiv8vSoWP0y5+wpdPQwZ
        6ipNJa9iFbuc77PRWD22mcRKCu1L/DCHdnZh6m4=
X-Google-Smtp-Source: APXvYqzCOuziaz14SGulOETIPesO6mN/dZlwAICRkg8AsymOG/TuwnlyL8fzBqQMOdmB6nnnOH5XwMwmI8/0QG4RcK0=
X-Received: by 2002:ac8:768d:: with SMTP id g13mr8822753qtr.7.1576787761041;
 Thu, 19 Dec 2019 12:36:01 -0800 (PST)
MIME-Version: 1.0
References: <20190719041231.26500-1-deepa.kernel@gmail.com>
 <CAOQ4uxhxVKhUh_P_NffLbGScpiL0wOrCTLwWJWeSbRRNbHzPrg@mail.gmail.com>
 <CABeXuvoHw8W02JsmZjafnQkOs1=0dodSpBFyJ_Gq+1vs+hFkQQ@mail.gmail.com>
 <CABeXuvqO=04BJw2bWa6d2fv1FTe-B_JsNhVdYTwT=fY=ncOCkw@mail.gmail.com>
 <CAOQ4uxjaFBZZUKyu6YS08ta8pdW_FSjRYA4J7S8+_=Gfi-kO2Q@mail.gmail.com>
 <CAK8P3a1fYPq6DCqhT6ziJaxETLHt8uUgbHWryHiD4kQWwKLp2Q@mail.gmail.com>
 <20191219084046.GA1026636@kroah.com> <CAK8P3a1HiPLbajjoYQf0N4RBw9eUK6uyC+mOq7LaRmNpgiOgLA@mail.gmail.com>
 <f913d1f409dd4b2a22bcb71a3ddaeb2b87a00671.camel@codethink.co.uk>
In-Reply-To: <f913d1f409dd4b2a22bcb71a3ddaeb2b87a00671.camel@codethink.co.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 19 Dec 2019 21:35:44 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2bJxxrCFVLcduMykHjBMshA8B2EdV0xeFOOY5fARiN4g@mail.gmail.com>
Message-ID: <CAK8P3a2bJxxrCFVLcduMykHjBMshA8B2EdV0xeFOOY5fARiN4g@mail.gmail.com>
Subject: Re: [Y2038] [PATCH] generic/402: fix for updated behavior of
 timestamp limits
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        fstests <fstests@vger.kernel.org>,
        Eryu Guan <guaneryu@gmail.com>,
        "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:QKVCbAXiZ1nlN8F7R1e1rhiQ3LsjnvX/Lqejmx13J6VhcLnXSzn
 U0bHuNrr3CvKhSku4qkTHzDdkuu99yc+pDOi5o/aJj+Gam19J1wTPsPOINGtI/EDLDqjK0U
 NZEYytv6LZV5H9tG2683OP8/5/Ppr8+DH4dsZ9vU9HQ/Q4RuKFXmLbU4UIVT87kzuFxRy3s
 lFjhXD9doGpENe0y+y4Sw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:irz4Y4tV1zM=:ytKvK6Gv6rMstWjEmBQ6ww
 kO4XEaUEgr8Qpb6ejGMqGNK06BnayNzoFK5tM3DP/PsamIVRfREAK7MtsSAD7IeD5WbJp8evd
 7iGk0Ngxs6DJJsQfwmwrm80gNoqDIbGWi0EOuDusTyxj9pJDg2JCKVhixuDZ9y9AYE60KNUCV
 Q4A8COjlTdMZXz3LlFKEWBElbG7QviGmRLppjWDM/gOTGyEkxGGoZuAOwV1DncdZc/pzJYbQR
 UEwPGCHVnMnWjaizO7PxnvhXmecHySYE2MtGHEzPGzIMuhpYSDBidnAOWloXCTVy2fWyVWYaR
 JMf/BtOFTu1sgWj0YiWh+pWvA7YzcCjKz6YeSV2QOCE+Y0Q8AW6uSn4Ld5+K2vAto0NGA16H4
 VlrLH4+tUrAponlJWy1TEGM+/AdU7fvDtsVEye4M+2u/AcRA59jKoCyYLDfJsyF/GO4M91x0U
 X/UUKhTFp2hDvlqtMZZip94LNtw+vOANIqUH3wAeI2gdOtRr+T46+zj3IN5PFNMEjcpjJN/eX
 QhsLW4YIEiSeZ0L/wy7mDzO5qvuoNEA2UIwJbScea7w/Uhzz0mkQ76grazrrQnbASzz4IZ7c9
 Ku4KpHxe5OkQfgW9gPz8gL0256LKjlokXn+413vknIQ6xhe1GGXAhSdUZRJezDXPYPAD4pA7j
 GjF9b2ckzavU4HFXHUiTAerpP681nAeft/nPAeGmA8NLX5YJOxuFe2STLmrw2RwqnXLhLhyPq
 YpS/IIOKZUR12EsT5KkvYosaOqvftjoSWtNLRwHJ4leMsueuPlbjRuVNtg/mRxmjZ+bKK+GDH
 1MVJkWOL67mBki34U1aU8e1heir8srQXfbroYTKyxQH9W2uE5kObG64XEAHS9wFm0WdVEh5oM
 G020OAiauNlwRj2SC3yw==
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Dec 19, 2019 at 4:48 PM Ben Hutchings
<ben.hutchings@codethink.co.uk> wrote:
> On Thu, 2019-12-19 at 12:29 +0100, Arnd Bergmann wrote:
> [...]
> > - Users of CIP SLTS kernels with extreme service life that may involve
> >   not upgrading until after y2038 (this is obviously not recommended if
> >   you connect to a public network, but I'm sure some people do this anyway).
> >   For running user space, this requires either a 32-bit kernel with the
> >   linux-5.1 syscall changes or a 64-bit kernel. If you run a 64-bit linux-4.9
> >   kernel in a deeply embedded non-networked machine, it still makes
> >   sense to have working inode timestamps and be able to test that.
> [...]
>
> CIP is currently aiming for a 10 year support lifetime, so both of its
> currently existing branches (4.4, 4.19) should be long out of support
> in 2038.  Still, it's possible that some people hope to extend that
> later.

It is also common that end-users keep relying on machines that they
bought for many years after any support contracts end. This may be
fine for a lot of use cases where there is no risk in running an old
operating system, and replacing it is prohibitively expensive, as
software generally does not suddenly stop working after support ends.

With the y2038-safe interfaces and with file system limits, the
difference is that there is a specific point in time when things will
break.

        Arnd

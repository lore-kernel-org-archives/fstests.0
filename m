Return-Path: <SRS0=0bps=2J=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771B6C43603
	for <linux-fstests@archiver.kernel.org>; Thu, 19 Dec 2019 15:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5375B2146E
	for <linux-fstests@archiver.kernel.org>; Thu, 19 Dec 2019 15:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfLSPse (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 19 Dec 2019 10:48:34 -0500
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:54098 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726760AbfLSPse (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 Dec 2019 10:48:34 -0500
Received: from [167.98.27.226] (helo=xylophone)
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1ihy2O-00084g-ID; Thu, 19 Dec 2019 15:48:28 +0000
Message-ID: <f913d1f409dd4b2a22bcb71a3ddaeb2b87a00671.camel@codethink.co.uk>
Subject: Re: [Y2038] [PATCH] generic/402: fix for updated behavior of
 timestamp limits
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Arnd Bergmann <arnd@arndb.de>, Greg KH <gregkh@linuxfoundation.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        fstests <fstests@vger.kernel.org>,
        Eryu Guan <guaneryu@gmail.com>,
        "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Date:   Thu, 19 Dec 2019 15:48:28 +0000
In-Reply-To: <CAK8P3a1HiPLbajjoYQf0N4RBw9eUK6uyC+mOq7LaRmNpgiOgLA@mail.gmail.com>
References: <20190719041231.26500-1-deepa.kernel@gmail.com>
         <CAOQ4uxhxVKhUh_P_NffLbGScpiL0wOrCTLwWJWeSbRRNbHzPrg@mail.gmail.com>
         <CABeXuvoHw8W02JsmZjafnQkOs1=0dodSpBFyJ_Gq+1vs+hFkQQ@mail.gmail.com>
         <CABeXuvqO=04BJw2bWa6d2fv1FTe-B_JsNhVdYTwT=fY=ncOCkw@mail.gmail.com>
         <CAOQ4uxjaFBZZUKyu6YS08ta8pdW_FSjRYA4J7S8+_=Gfi-kO2Q@mail.gmail.com>
         <CAK8P3a1fYPq6DCqhT6ziJaxETLHt8uUgbHWryHiD4kQWwKLp2Q@mail.gmail.com>
         <20191219084046.GA1026636@kroah.com>
         <CAK8P3a1HiPLbajjoYQf0N4RBw9eUK6uyC+mOq7LaRmNpgiOgLA@mail.gmail.com>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

[+cc cip-dev]

On Thu, 2019-12-19 at 12:29 +0100, Arnd Bergmann wrote:
[...]
> - Users of CIP SLTS kernels with extreme service life that may involve
>   not upgrading until after y2038 (this is obviously not recommended if
>   you connect to a public network, but I'm sure some people do this anyway).
>   For running user space, this requires either a 32-bit kernel with the
>   linux-5.1 syscall changes or a 64-bit kernel. If you run a 64-bit linux-4.9
>   kernel in a deeply embedded non-networked machine, it still makes
>   sense to have working inode timestamps and be able to test that.
[...]

CIP is currently aiming for a 10 year support lifetime, so both of its
currently existing branches (4.4, 4.19) should be long out of support
in 2038.  Still, it's possible that some people hope to extend that
later.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom


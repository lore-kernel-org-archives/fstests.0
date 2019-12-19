Return-Path: <SRS0=0bps=2J=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC4CC43603
	for <linux-fstests@archiver.kernel.org>; Thu, 19 Dec 2019 08:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7047D2465E
	for <linux-fstests@archiver.kernel.org>; Thu, 19 Dec 2019 08:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576744850;
	bh=ZF2IkJQJu2JuoOwO1H8iWOQb1qsWX2H0062pdGRfz9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=b0NxMVx2208OV+LTn0i9ADUUZ7jWsJg4qpqmqX/51rtK8OGQw9cshd6EU3f1ssa+W
	 9EfDTM2jpxAc7ex6odHwxP4DpGDN+x+GGhWw1X/+U0fpm10RAfXH6pqwK7G5zMcFy+
	 meRXPXxh21Iqvf2xni4eZ8lm4LWmM2xxDd4UD3YA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfLSIku (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 19 Dec 2019 03:40:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:44374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfLSIku (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 19 Dec 2019 03:40:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25EDD24650;
        Thu, 19 Dec 2019 08:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576744848;
        bh=ZF2IkJQJu2JuoOwO1H8iWOQb1qsWX2H0062pdGRfz9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BzWLmnbnfALLFzFgyvy/ERBUCON0j7qC01rIGHMc7ItVAGq3pkPbg8QpjrmE37hIZ
         sdE72W/niP1eyV4oNK3BOp5oIGwypPnwkKFl2lBMhB62z7KgeoswMhS1JODLekKM8F
         oAv88jZDgkedpHr2MozvADkplRGh4EFYDguOR1bc=
Date:   Thu, 19 Dec 2019 09:40:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        fstests <fstests@vger.kernel.org>, Eryu Guan <guaneryu@gmail.com>
Subject: Re: [Y2038] [PATCH] generic/402: fix for updated behavior of
 timestamp limits
Message-ID: <20191219084046.GA1026636@kroah.com>
References: <20190719041231.26500-1-deepa.kernel@gmail.com>
 <CAOQ4uxhxVKhUh_P_NffLbGScpiL0wOrCTLwWJWeSbRRNbHzPrg@mail.gmail.com>
 <CABeXuvoHw8W02JsmZjafnQkOs1=0dodSpBFyJ_Gq+1vs+hFkQQ@mail.gmail.com>
 <CABeXuvqO=04BJw2bWa6d2fv1FTe-B_JsNhVdYTwT=fY=ncOCkw@mail.gmail.com>
 <CAOQ4uxjaFBZZUKyu6YS08ta8pdW_FSjRYA4J7S8+_=Gfi-kO2Q@mail.gmail.com>
 <CAK8P3a1fYPq6DCqhT6ziJaxETLHt8uUgbHWryHiD4kQWwKLp2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1fYPq6DCqhT6ziJaxETLHt8uUgbHWryHiD4kQWwKLp2Q@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Dec 19, 2019 at 09:28:23AM +0100, Arnd Bergmann wrote:
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
> 
> I'm also not sure if we could just backport the changes to stable
> kernels after all.
> 
> Greg, do you have an opinion on whether the 19 patches from
> v5.3-rc6 to cba465b4f982 can be considered stable material?
> 
> The best argument that I have seen in favor of treating it as a bugfix
> is that the posx man pages require that "The file's relevant timestamp shall
> be set to the greatest value supported by the file system that is not greater
> than the specified time"[1], and this is something that Linux has always
> done wrong before the series (we overflow and underflow out-of-range
> arguments to a value that is both file system and CPU architecture
> specific).
> 
> The main argument against backporting would be that 19 patches
> is too much, I think each patch in the series would qualify on its own.
> Changing the layout of 'struct super_block' also breaks the module
> binary interface, which will annoy some distros that care about this,
> but I don't think it's stopping us from adding the patch to a stable
> kernel.
> 
>        Arnd
> 
> [1] https://pubs.opengroup.org/onlinepubs/9699919799/functions/futimens.html

Ugh, that's a mess.  Why not just use 5.4 if people really care about
this type of thing?

But yes, on their own, each individual patch would be fine for stable,
it's just that I would want someone to "own" the backport and testing of
such a thing.  If for no other reason than to have someone to "blame"
for when things go wrong and get them to fix up the fallout :)

Who really really wants this in their older kernels?  And are those same
people already taking all of the stable updates for those kernels as
well?

thanks,

greg k-h

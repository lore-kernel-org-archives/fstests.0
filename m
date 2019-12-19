Return-Path: <SRS0=0bps=2J=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050E4C43603
	for <linux-fstests@archiver.kernel.org>; Thu, 19 Dec 2019 11:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC4222465E
	for <linux-fstests@archiver.kernel.org>; Thu, 19 Dec 2019 11:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576755344;
	bh=sExd645WBzN1y3kUWDMvit0pLS2wABp94t2tI1Xv1n4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wOq8LK4FNIkg0RmSezJeCHuMBYPi7qxjvhMlZJQZ+XF1dTdh7RFx1VsbMO4/kb8An
	 NFcn0JJh0AULKHPETz35H/B92xbL4oltSk539PxCkF2jYMG9Fz4uzGV6gMxXxyYxlk
	 eSqnCPH/O76E1BjtwyEv49jPx2WalWlyX6T2ijB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfLSLfo (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 19 Dec 2019 06:35:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:40384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfLSLfo (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 19 Dec 2019 06:35:44 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 023D620716;
        Thu, 19 Dec 2019 11:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576755343;
        bh=sExd645WBzN1y3kUWDMvit0pLS2wABp94t2tI1Xv1n4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MKZC2pxv52FGLrxiuAdoWabQXrF1IfghwyC8qmWz+NiMezIqKeDhIJuhPQ+4wOso0
         weWFBGzoNasjkBNPaA/vf1kekqDuyljWe1Uapa4PxRQzcTBuFZ8qcDFgCEHkekMdyS
         E9KXt3lpfMryj2uXw4qi/P+9i7TCTshpcG/76wjA=
Date:   Thu, 19 Dec 2019 12:35:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        fstests <fstests@vger.kernel.org>,
        Eryu Guan <guaneryu@gmail.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: Re: [Y2038] [PATCH] generic/402: fix for updated behavior of
 timestamp limits
Message-ID: <20191219113541.GA1376265@kroah.com>
References: <20190719041231.26500-1-deepa.kernel@gmail.com>
 <CAOQ4uxhxVKhUh_P_NffLbGScpiL0wOrCTLwWJWeSbRRNbHzPrg@mail.gmail.com>
 <CABeXuvoHw8W02JsmZjafnQkOs1=0dodSpBFyJ_Gq+1vs+hFkQQ@mail.gmail.com>
 <CABeXuvqO=04BJw2bWa6d2fv1FTe-B_JsNhVdYTwT=fY=ncOCkw@mail.gmail.com>
 <CAOQ4uxjaFBZZUKyu6YS08ta8pdW_FSjRYA4J7S8+_=Gfi-kO2Q@mail.gmail.com>
 <CAK8P3a1fYPq6DCqhT6ziJaxETLHt8uUgbHWryHiD4kQWwKLp2Q@mail.gmail.com>
 <20191219084046.GA1026636@kroah.com>
 <CAK8P3a1HiPLbajjoYQf0N4RBw9eUK6uyC+mOq7LaRmNpgiOgLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1HiPLbajjoYQf0N4RBw9eUK6uyC+mOq7LaRmNpgiOgLA@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Dec 19, 2019 at 12:29:39PM +0100, Arnd Bergmann wrote:
> On Thu, Dec 19, 2019 at 9:40 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Thu, Dec 19, 2019 at 09:28:23AM +0100, Arnd Bergmann wrote:
> > > On Wed, Dec 18, 2019 at 9:46 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > [1] https://pubs.opengroup.org/onlinepubs/9699919799/functions/futimens.html
> >
> > Ugh, that's a mess.  Why not just use 5.4 if people really care about
> > this type of thing?
> >
> > But yes, on their own, each individual patch would be fine for stable,
> > it's just that I would want someone to "own" the backport and testing of
> > such a thing.  If for no other reason than to have someone to "blame"
> > for when things go wrong and get them to fix up the fallout :)
> 
> I was going to volunteer Deepa and me, but I just tried out what a backport
> would look like, and backporting to v4.14 or earlier would involve a
> major rewrite unless we also backport Deepa's earlier y2038 patches that
> are much more invasive. Backporting to v4.19 (across the mount API
> change) would be possible, but this doesn't really help the cause of
> getting xfstests to report correct behavior on all stable kernels.
> 
> > Who really really wants this in their older kernels?  And are those same
> > people already taking all of the stable updates for those kernels as
> > well?
> 
> I see two potential groups of people:
> 
> - the one that started this thread: xfstests correctly reports a failure on
>   stable kernels that have a known problem with compliance. If you are
>   aiming for 100% pass rate on a test suite, you can either mark a correct
>   test case as "skip", or backport the fix. Neither one is super attractive
>   here, but it seemed worth considering which one is more harmful. (I
>   guess I answered that now -- backporting to v4.14 would be more
>   harmful)

Marking the test as "skip" for older kernels should be just fine for
this.

> - Users of CIP SLTS kernels with extreme service life that may involve
>   not upgrading until after y2038 (this is obviously not recommended if
>   you connect to a public network, but I'm sure some people do this anyway).
>   For running user space, this requires either a 32-bit kernel with the
>   linux-5.1 syscall changes or a 64-bit kernel. If you run a 64-bit linux-4.9
>   kernel in a deeply embedded non-networked machine, it still makes
>   sense to have working inode timestamps and be able to test that.
> 
> It may still make sense to backport this to linux-4.19.y-cip or another
> downstream version of 4.19, but let's not do it for the normal LTS
> kernels then.

CIP is in for a world of hurt for a lot of other reasons, all
self-inflicted :)

I'll let those people deal with the fallout of their odd decisions, but
I will quote a company that is supporting Linux devices in the wild for
20+ years:
	We update the kernel and all software on them for at least 18
	years as these devices are "alive", why would we declare them
	"dead" right away and only provide triage?  That's an insane way
	to support a product.

So let's just leave this as-is, 5.4 should be fine for people worrying
about y2038.

thanks,

greg k-h

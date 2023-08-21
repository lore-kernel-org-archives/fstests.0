Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36201EE4993
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Aug 2023 11:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjHULRe (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 21 Aug 2023 07:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjHULRd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Aug 2023 07:17:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55589D8
        for <fstests@vger.kernel.org>; Mon, 21 Aug 2023 04:17:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D91B9614FE
        for <fstests@vger.kernel.org>; Mon, 21 Aug 2023 11:17:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217D3C433C8
        for <fstests@vger.kernel.org>; Mon, 21 Aug 2023 11:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692616651;
        bh=uPauifxWvZ6uEnEDiJspm0f5CySMWu5Ydxq+k5/HDak=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qpPtpslljSJtJ9hOZHSQkPXXrp06/bfOi+PsCJtIN75DfiOMxsGndRPv9R3Lr4Rtz
         ywfuLFsAgXbgeWQTtrphZR6tGhGasH9I2IdHJGoPVmc9KkeGs8CbD4US10qp/0N8/l
         e7lY3KJ9gpNEODYRP9r6lmjmhZAwoBaDs3f1T9qQuRDlEssTiXP2/1jigTkr2i8Fkg
         SkOrD5g0Qj7vCj/8QG+uEdFqdLvo5NWZjBLPjHiHksLtqel/5JUuwWnpV2QUHiNrgX
         9g5r/10EC95yEIq59GtyLMvR3wbC6SOJClJMkxYWyCjHEQIsi/Sw3pUPx2CetABbSR
         0zALKg6eTZp/w==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-570d8b31b7eso421738eaf.0
        for <fstests@vger.kernel.org>; Mon, 21 Aug 2023 04:17:31 -0700 (PDT)
X-Gm-Message-State: AOJu0YxR8wLUQeCva2uURJ/TsL9mGyXi80Q5CK7oiARS/z5ytEjRgBQL
        pddb8GPfi+73vBqJr4NUFBBtPXTvrVyjEQ+HgsE=
X-Google-Smtp-Source: AGHT+IHaHba5Hk/rUqCOKJpjah2ka5kg5/8UL9jNeHmJ5dFRVlXuug8uClOeOY0dqq8n5+LYyAxiVGgkZDDqylZrvks=
X-Received: by 2002:a4a:655a:0:b0:567:95:a0e5 with SMTP id z26-20020a4a655a000000b005670095a0e5mr5519015oog.0.1692616650201;
 Mon, 21 Aug 2023 04:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <1692024101-3967-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <CAL3q7H7C0mE9tBaipdYPYOCgBVYMTVKQ8=f90khTckt1CbBF4A@mail.gmail.com>
 <9eadebb8-1bc7-1c19-ad3d-04b31271f8dc@fujitsu.com> <20230818124325.vxod6jkdzirdeaak@zlang-mailbox>
 <CAL3q7H5n054jOAW=WgSLJAXCkmbSpHJ1yNGGJ9s7-WpdAkwgPw@mail.gmail.com> <ZOL4kmQ/2ZLEzvmI@dread.disaster.area>
In-Reply-To: <ZOL4kmQ/2ZLEzvmI@dread.disaster.area>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 21 Aug 2023 12:16:54 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6hgU89heBMAeDcFqGmSWtpOZu-haAjGDms1--nSVuSzA@mail.gmail.com>
Message-ID: <CAL3q7H6hgU89heBMAeDcFqGmSWtpOZu-haAjGDms1--nSVuSzA@mail.gmail.com>
Subject: Re: [PATCH] generic/471: Remove this broken case
To:     Dave Chinner <david@fromorbit.com>
Cc:     Zorro Lang <zlang@redhat.com>,
        "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "tytso@mit.edu" <tytso@mit.edu>, "shr@fb.com" <shr@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Aug 21, 2023 at 6:39=E2=80=AFAM Dave Chinner <david@fromorbit.com> =
wrote:
>
> On Sat, Aug 19, 2023 at 05:25:35PM +0100, Filipe Manana wrote:
> > On Fri, Aug 18, 2023 at 1:43=E2=80=AFPM Zorro Lang <zlang@redhat.com> w=
rote:
> > > On Wed, Aug 16, 2023 at 02:58:10PM +0000, Yang Xu (Fujitsu) wrote:
> > > > I think the url that Jens mention should be this[1] when he reviewe=
d
> > > > Stefan V7 patch for "io-uring/xfs: support async buffered writes".
> > > >
> > > > [1]https://lkml.kernel.org/linux-fsdevel/ca60a7dc-b16d-d8ce-f56c-54=
7b449da8c9@kernel.dk/
> > >
> > > Hi Filipe,
> > >
> > > Does above explanation make sense to you?
> >
> > Not completely.
> >
> > It justifies that the test's assumptions are not necessarily correct,
> > that I understood and it's reasonable.
> >
> > However I don't see, neither in that thread nor in this patch's
> > changelog, why the test started to fail (on xfs, it still passes on
> > btrfs and ext4) after adding support for async buffered IO writes to
> > xfs and iomap - as all the writes done by the test are using direct
> > IO.
>
> We changed how timestamps are updated so that they are aware of
> IOCB_NOWAIT. If the IOCB_NOWIAT DIO write now needs to update the
> inode timestamps, it will return -EAGAIN instead of doing
> potentially blocking operations that require IO to complete (i.e.
> taking a transaction reservation).
>
> Hence the first time we go to do a DIO read an inode, it's going to
> do an atime update, which now occurrs from an IOCB_NOWAIT context
> and we return -EAGAIN....
>
> Yes, we added non-blocking timestamp updates as part of the async
> buffered write support, but this was a general XFS IO path change of
> behaviour to address a potential blocking point in *all* IOCB_NOWAIT
> reads and writes, buffered or direct.

Ok, now that's the kind of explanation I would expect in the changelog.

>
> > At least the changelog should point to that thread, and not the one it
> > currently refers to because it doesn't provide any useful information.
> > For completeness it should also justify why the async buffered write
> > support broke the test, as it points out the test fails after those 2
> > commits for buffered write support, yet there are no buffered writes
> > performed by the test.
>
> async buffered writes didn't break the test. The addition of
> nonblocking timestamp updates in XFS is what causes the test to now
> fail.

Ok, so the changelog is very misleading, as it points to commits that,
as far as I can see at least,
have nothing to do with the changes that make timestamp updates aware
of NOWAIT semantics.

So it should be the following commit to be referred (and possibly others):

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D66fa3cedf16abc82d19b943e3289c82e685419d5

>
> Indeed, we may change this XFS behaviour again some day - if we can
> guarantee that we can get a transaciton reservation without blocking
> then we -could- allow the timestamp update to run in IOCB_NOWAIT
> context. Doing this would then mean the test might randomly fail,
> depending on whether the timestamp update can be done without
> blocking or not....
>
> Put simply, the test is not validating that RWF_NOWAIT is behaving
> correctly - it just was a simple operation that kinda exercised
> RWF_NOWAIT semantics when we had no other way to test this code. It
> has outlived it's original purpose, so it should be removed...

Thanks for the detailed explanation.

A simpler version of this, or perhaps a lore link to your reply should
be added to the changelog,
because the current one is more like "remove this test because someone
else told to do so" without
any relevant details.

>
> -Dave.
> --
> Dave Chinner
> david@fromorbit.com

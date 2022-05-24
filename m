Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEE4C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 24 May 2022 12:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbiEXMfN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 May 2022 08:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbiEXMfN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 May 2022 08:35:13 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB70595DF6
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 05:35:08 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id v14so14605147qtc.3
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 05:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2XESRZDMaT2JBC76BPr3P+QcsOK+BrDL5iTRUut5LZs=;
        b=SjO6TZhm6VZldh165V8PkkMPMf07ZNKkEw9Gk3N9HT7fhLLvPCU6RdGjWxEq4yJJC1
         iQfyDIoYIXXk0MImdRacCtO04OBTHiQ2IeFZZsScbuStGBV5/8BUZ8PqpniNFCzQA4aP
         /BM58c4UTqzdIO+6hj7ZEfurfWO6yxFsmfelRqZlxitNiW9ZlB2n9K88m49w4VgBeXyM
         GSDIvqENg9G4UhkTnYfqibctygemjnxpQNVqMSyw+OIBZKGkHBRFejd4roOmSMZ3GWP4
         3+Ak6BjK8Xlcvzjv3bbjOCg7+LmvgsllQvsj6qW4WvExvBcsDxp1zPv95jGzftiNS1PE
         Ul2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2XESRZDMaT2JBC76BPr3P+QcsOK+BrDL5iTRUut5LZs=;
        b=fbR/HVQbzxW8fM31klLdmbkPJ0ItqkDl9eku2f3KMyGOtuqYId34JquN3vd6cZq/kh
         KP86N0DWFddVahb5TgvDVSBOvelK2ltPG8LguaANeyYs/1a4OQ62/V0AlL4aMmd7mpqN
         uBESBnw8lkmmtBLmSR9oHU6qspQwgxJgIRKRHztuqkiRG2mN4eyOD3AG7+Dre1FQJF6g
         PhEX/MnhjqVsgmllALFdUjxsC0zlnaTaVRjePUC404p7ZxFnM/bBWEdhmtuR9PMMKoc3
         UqKHFfyJI1nbjTixpTLPQBl3i2CoImmT5J/5k/V/uQFIxInc7ps4crv8CPCVWULnK1Oj
         tsjA==
X-Gm-Message-State: AOAM531XEKEewXObvusjEbRBUgPMNMFVBdQ6HfUQ4mXuj2yxdZ3tOP3y
        Lh1kodAE9QhA+2xXUYWJ9nnBoiQk1NXsz8NRFz1Yj7VnBPA=
X-Google-Smtp-Source: ABdhPJwEGnwRKJr6svhWVwEVEsZslY/UfM21OJOZBo0AAzF9JbbrzGT9ydkpwTsHjbG+it1LNc5MuYzjpOdKvvwn3mI=
X-Received: by 2002:ac8:5f0a:0:b0:2f9:3b64:b5ba with SMTP id
 x10-20020ac85f0a000000b002f93b64b5bamr4985389qta.2.1653395707901; Tue, 24 May
 2022 05:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220524073411.1943480-1-david@fromorbit.com> <CAOQ4uxi9gFQ4Zr6pfvia8WgjzyQqc2LnAwamw_XDuyR0ndGjBQ@mail.gmail.com>
 <20220524095755.GH2306852@dread.disaster.area> <CAOQ4uxga7SqYFcYWMxD8bZxrU62Lk0G_3tZLU6m7sp5VPUtzmA@mail.gmail.com>
 <20220524101320.GJ2306852@dread.disaster.area> <CAOQ4uxiZ3jQ7oBhAvgGexid8OT8Z223ynop7NdFGF9FRC-ueiA@mail.gmail.com>
 <20220524122850.GM2306852@dread.disaster.area>
In-Reply-To: <20220524122850.GM2306852@dread.disaster.area>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 24 May 2022 15:34:56 +0300
Message-ID: <CAOQ4uxhg8P0_-O1sV88MLOwAEzGa6vjMyN8jSAOgSGYfShns0w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] fstests: _cleanup() overrides are a mess
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 24, 2022 at 3:28 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Tue, May 24, 2022 at 03:14:39PM +0300, Amir Goldstein wrote:
> > On Tue, May 24, 2022 at 1:13 PM Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > On Tue, May 24, 2022 at 01:01:57PM +0300, Amir Goldstein wrote:
> > > > On Tue, May 24, 2022 at 12:57 PM Dave Chinner <david@fromorbit.com> wrote:
> > > > >
> > > > > On Tue, May 24, 2022 at 11:29:17AM +0300, Amir Goldstein wrote:
> > > > > > On Tue, May 24, 2022 at 11:01 AM Dave Chinner <david@fromorbit.com> wrote:
> > > > > > >
> > > > > > > Hi folks,
> > > > > > >
> > > > > > > I pulled on a string a couple of days ago, and it got out of
> > > > > > > control. It all started when I went to kill a test with ctrl-c and
> > > > > > > it, once again, left background processes running that I had to hunt
> > > > > > > down and kill manually.
> > > > > > >
> > > > > > > I then started looking a why this keeps happening, and realised that
> > > > > > > the way we clean up on test completion is messy, inconsistent and
> > > > > > > frequently buggy. So I started cleaning it all up, starting with the
> > > > > > > tests/xfs directory because I saw a lot of low hanging fruit there.
> > > > > > >
> > > > > > > Essentially, we use _cleanup() functions as a way of overriding the
> > > > > > > default trap handler we install in _begin_fstest(). Rather than
> > > > > > > register a new handler, we just redefine the common cleanup function
> > > > > > > and re-implement it (poorly) in every test that does an override.
> > > > > > > Often these overrides are completely unnecessary - I think I reduced
> > > > > > > the total number of overrides in tests/xfs by ~30% (~190 -> ~125),
> > > > > > > and I reudced the number of *unique overrides by a lot more than
> > > > > > > that.
> > > > > > >
> > > > > >
> > > > > > That looks like an awesome improvement!
> > > > > >
> > > > > > > The method for overriding changes to be "stacked cleanups" rather
> > > > > > > than "duplicated cleanups". That is, tests no longer open code:
> > > > > > >
> > > > > > >         cd /
> > > > > > >         rm -rf $tmp.*
> > > > > > >
> > > > > > > THis is what common/preamble::_cleanup() does. We should call that
> > > > > > > function to do this. Hence if we have a local cleanup that we need
> > > > > > > to do, it becomes:
> > > > > > >
> > > > > > > local_cleanup()
> > > > > > > {
> > > > > > >         rm -f $testfile
> > > > > > >         _cleanup
> > > > > > > }
> > > > > > > _register_cleanup local_cleanup
> > > > > >
> > > > > > While removing boilerplate code, we had better not create another boilerplate.
> > > > > > Instead of expecting test writers to always call _cleanup
> > > > > > if we always want _cleanup to be called we can always implicitly
> > > > > > chain it in _register_cleanup():
> > > > > >
> > > > > > --- a/common/preamble
> > > > > > +++ b/common/preamble
> > > > > > @@ -20,7 +20,7 @@ _register_cleanup()
> > > > > >         shift
> > > > > >
> > > > > >         test -n "$cleanup" && cleanup="${cleanup}; "
> > > > > > -       trap "${cleanup}exit \$status" EXIT HUP INT QUIT TERM $*
> > > > > > +       trap "${cleanup}_cleanup; exit \$status" EXIT HUP INT QUIT TERM $*
> > > > > >  }
> > > > >
> > > > > I considered that, but then I found the _no_cleanup cases. IOWs,
> > > > > this doesn't work for the cases where we want to prevent the generic
> > > > > _cleanup function from being run on failure/test exit. Hence the
> > > > > cleanup function stacking behaviour rather than unconditional
> > > > > calling of _cleanup as per above.
> > > > >
> > > >
> > > > I didn't know about those.
> > > > Since you went to all this trouble to find them, can you provide a reference.
> > > > I wonder, what could ever be the reason not to want to rm $tmp.*?
> > >
> > > [PATCH 6/8] fstests: consolidate no cleanup test setup
> > >
> >
> > Ah I see.
> > It might have been better to explicitly opt-out of cleanup
> > only for those tests via _register_no_cleanup or _unregister_cleanup
>
> Premature optimisation.
>

It's not an optimization at all.

The purpose of doing it this way would be to eliminate the human mistakes
(from which you found so many in this work) and create a situation where
_cleanup() is called for all tests, unless the test author really
wants to avoid it.

But anyway, no need to fix everything at one go.
There will still be plenty of ways that a test author can write a
test that does not clean after itself.

Thanks,
Amir.

Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B77C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 24 May 2022 16:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiEXQdS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 May 2022 12:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiEXQdR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 May 2022 12:33:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 084AA5DD19
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 09:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653409995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J67rwq1nS1FHAuR2/h+lzVO4fxuTaioE23bKyhNHDAg=;
        b=Q/4WWN28uS3dzde5lQdJNAXh27tru6/09+N/NWTXPaqhu93zmnAXhQjz/79HY4ZpgebbYr
        WCRTYZxoJYmBnUYj2ZIYY52TkctKY+3vqyzfrtSONZo7TmshmdUwjvHcqEOzHSUeLV3C0m
        ykvud0GMbi/EYijOBraYBKvuugkfSiM=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-bKjy3FXDObiB4hzq9qmQ7Q-1; Tue, 24 May 2022 12:32:11 -0400
X-MC-Unique: bKjy3FXDObiB4hzq9qmQ7Q-1
Received: by mail-oi1-f198.google.com with SMTP id d67-20020acab446000000b0032ae7767585so6604108oif.6
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 09:32:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J67rwq1nS1FHAuR2/h+lzVO4fxuTaioE23bKyhNHDAg=;
        b=ZHrdjp9AoDA3nhAgX3gV9SiDOuwXnnFzW7CJX3TPWKj2WXQ6C0xPBjuGW/puOru9VT
         BGELxaQrvEtKCiBhJdm2RGdo6JUozW6BXFTbst23mRe9P/ZWwfrX4ZsbcUr3h+x7RUd9
         RUHS64543vQbjhLxLPSIgF0Mg/AdbVYpF/jLbuiCVQH9QsLc+R5Ave2sJ38db/A16rJ/
         LpgkBMPSf4dhD3TVsO3vN/F/ap3axPEN0BK46cWGx/aIJwOzUxdRQNFcwLigvpA6ZltR
         u/DdxhFhusn/aeIJXXDWYQi6nRdsqNLR1NU+NMA4mSqJA7dZbvfqBjuN34LpdXbh1Lpx
         q4ow==
X-Gm-Message-State: AOAM531Ytnb9FTOF4vAJy1Wn5e9ADYdigJtQfKm6TIB2tgRRtflAe2R/
        ol2TRGhXKDiFBedwmGzA5DGH8pMHhRvhUz/r7K0WfXOkXiGFN6W8QiQ9OGCtC3F3OVmxwuGYHBR
        QCKXGQh5iRcEV0MV9+g==
X-Received: by 2002:a4a:98cc:0:b0:35e:ba5d:5e9d with SMTP id b12-20020a4a98cc000000b0035eba5d5e9dmr11098582ooj.36.1653409930123;
        Tue, 24 May 2022 09:32:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAz+SRrjg/0KRtUKNrydcwOkJIX4CUetyeEwUmQSyzsSU6Pb+HNnqb4QPevLQ3XbwqmiFQRg==
X-Received: by 2002:a4a:98cc:0:b0:35e:ba5d:5e9d with SMTP id b12-20020a4a98cc000000b0035eba5d5e9dmr11098570ooj.36.1653409929769;
        Tue, 24 May 2022 09:32:09 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y84-20020aca4b57000000b00324f24e623fsm5373792oia.3.2022.05.24.09.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 09:32:09 -0700 (PDT)
Date:   Wed, 25 May 2022 00:32:03 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>
Cc:     fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH 3/8] xfs/*: clean up _cleanup override
Message-ID: <20220524163203.l5nb6o6ougbbsrjx@zlang-mailbox>
References: <20220524073411.1943480-1-david@fromorbit.com>
 <20220524073411.1943480-4-david@fromorbit.com>
 <CAOQ4uxgZwngHevX_FXytAi68k=aqp_N-8Buk50rrJKD0UoK+2g@mail.gmail.com>
 <20220524122703.GL2306852@dread.disaster.area>
 <CAOQ4uxifd8gee1JLG1FN9fF3aSsVeSEuxFqjAf4D8ruCciXWYg@mail.gmail.com>
 <20220524132428.GO2306852@dread.disaster.area>
 <CAOQ4uxhWCKb8_pKU4CCE5Nv2qTqge-AyGBdoX2isrBui4cHdqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhWCKb8_pKU4CCE5Nv2qTqge-AyGBdoX2isrBui4cHdqA@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 24, 2022 at 05:17:44PM +0300, Amir Goldstein wrote:
> On Tue, May 24, 2022 at 4:24 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Tue, May 24, 2022 at 03:55:47PM +0300, Amir Goldstein wrote:
> > > > > > diff --git a/tests/xfs/310 b/tests/xfs/310
> > > > > > index 3214e04b..c635b39a 100755
> > > > > > --- a/tests/xfs/310
> > > > > > +++ b/tests/xfs/310
> > > > > > @@ -9,14 +9,12 @@
> > > > > >  . ./common/preamble
> > > > > >  _begin_fstest auto clone rmap
> > > > > >
> > > > > > -# Override the default cleanup function.
> > > > > > -_cleanup()
> > > > > > +_dmhuge_cleanup()
> > > > > >  {
> > > > > > -       cd /
> > > > > > -       umount $SCRATCH_MNT > /dev/null 2>&1
> > > > > >         _dmhugedisk_cleanup
> > > > > > -       rm -rf $tmp.*
> > > > > > +       _cleanup
> > > > > >  }
> > > > > > +_register_cleanup _dmhuge_cleanup
> > > > >
> > > > > Maybe it's just me, but if the intention is to maybe make this
> > > > > function global someday then the difference with the name
> > > > > _dmhugedisk_cleanup() is confusing.
> > > >
> > > > The names I used here are for classification, so I can grep over
> > > > the _register_cleanup line and easily determine all the tests use
> > > > loop devices, dmflakey, dmerror, etc and then consolidate them all
> > > > into a single cleanup function that works for them all. This is just
> > > > the first step in that process.
> > > >
> > > > > I'd rather keep the local function name local_cleanup
> > > > > in unclear cases like this one.
> > > >
> > > > And that defeats the entire purpose of giving them a descriptive
> > > > name at this point in time.
> > >
> > > I understand. It makes a lot of sense to do that.
> > > It is still VERY confusing that there is a helper _dmhugedisk_cleanup
> > > that SHOULD NOT be used as a trap and a helper _dmhuge_cleanup
> > > that SHOULD be used as a trap, so a better convention is needed.
> >
> > I think you missed my point.
> >
> > _dmhuge_cleanup() is a *temporary name*.
> >
> > It will *go away* once I've processed the other 1000 tests which
> > will also classify anything using dmhugedisk with a _dmhuge_cleanup
> > function. It's a temporary token I can use for further
> > classification and deduplication, nothing more, nothing less.
> >
> 
> Ok if the two confusing names are not going to co-exists I'm fine
> with either name.
> 
> > > I suggest that all consolidated helpers for trap will be called
> > > either _cleanup_* (like cleanup_dump) or _*_cleanup (like _fsstress_cleanup)
> > >
> > > The problem is that there is no convetion in the common/* helpers.
> > > there are _dmhugedisk_cleanup() _dmerror_cleanup() and there are
> > > _cleanup_dump() _cleanup_delay().
> >
> > Exactly the reason why I've used simple names and the only
> > consistency I care about is that I use the same name for the same
> > subsystem cleanup functions. I can't give them globally consistent
> > names at this point and because they are temporary tokens I simply
> > have not tried. I give it a name, copy the function into a register
> > buffer, and then paste it into any other test that uses the same
> > subsystem and has the same cleanup requirements.
> >
> > Once I have all the tests that use dmhugedisk converted to use a
> > local _dmhuge_cleanup function, I'll derive the commonality from
> > them, move it into the existing cleanup function for that subsystem,
> > and register the subsystem cleanup in those tests. _dmhuge_cleanup()
> > then goes away forever.
> >
> > Once everythign is deduplicated and common, changing names will be
> > simple and straight forward. That's when you can argue all you want
> > over the names of functions and I won't care one bit.
> >
> 
> All right, please bear in mind that I try to do this review with as little
> nit picking as I can while still doing a professional review, so some
> questions need to be raised.
> The work you did is huge and impressive and the review is not easy.

Thanks Dave and Amir!

Dave did a huge and impressive change again:) The purpose of this change makes
sense to me, so there's not objections from me. But it really changed too many
cases, and are going to change more. So if anyone has any concern, please show
your review points as early as better. Thanks.

Really appreciate Amir's help, I was bothered by COVID-19 issues during the day,
just got time to read emails. You did give it a careful review line by line,
and asked lots of questions (than I thought) :) That helps a lot! Compare with
"it's fine but not perfect", I care about "it won't break any cases" more.
So if Dave can force on his main work, keep the code stable, we can do later
improvement bit by bit. As you can see, this patchset nearly affect the
whole fstests, more time we take to change it, more patch conflicts might
happen. Then Dave might need to do more 'rebase' jobs.

I'll give it lots of testing (although I'm sure Dave did test) before merging.
I'll try to help it catch the fstests release of this week. But that depends
on when we have the lastest version, and how stable this patchset is :)

Thanks,
Zorro

> 
> Anyway, after fixing the recursive _dmerror_cleanup typo, you may add:
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> 
> Thanks,
> Amir.
> 


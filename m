Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456B0C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 24 May 2022 14:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238149AbiEXOSF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 May 2022 10:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238125AbiEXOR5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 May 2022 10:17:57 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999765E77B
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 07:17:56 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id g21so6322517qtg.5
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 07:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B5LJcksvjNyP2ErkP4iBuITzooja6s9ixPwRkUIFibE=;
        b=FeR/n1WViuo5z/d4RnScZntJB30sxvufKoAUg46DF7RtvcFoFDO72MrVyYHuKSag8t
         K/U2DWJOcMoetdryPOlwdnGEgC5MCxoH5iLbW+p4FbR801ILpi7Pf8wO7Lu16hzMhi9q
         Zo+1uNKYVFat8O1yEAHPfiYam6eFqWI/i8pqKyZqWZ/N0V8vx64VNlJwaFuxgCXoP7AE
         yi/XfroEvPfp5F5m/9EwRbC/m4GLgd+Dw/HDE0O0g5DVZCCTpQIZOfL0d7RZdYjZy72s
         epzFNONcwHSkkFO62+vVQuNdQGjyUPT2/XAjyU0zeOeZTYzIY+OjtLcAhAfHF3NTqrUx
         JR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B5LJcksvjNyP2ErkP4iBuITzooja6s9ixPwRkUIFibE=;
        b=gMENp4aUYEtj3ZIK6HgkCc39bBfbXrw3R69Dim0vIFpMyAoV9n+W1xJpxy5Vz8/XoY
         6CUgBt0DueQKiOtCKMgn7ht+cvcVSgEqXXa3ZTooW24YMQa/M+jYZo1KXCCN8N0JqvBt
         Nqcb6g61FsCljIb1xK1xXUZziJ+z8xBydvu4U7TEhJwGXgw/tYRhdWHNhuyZoMPGkbum
         F+Zz5Hw2AjjKwGBaiBoYdb+Py+UrTAkSgy9Clc73y5D0NHK6h3KXgFFEgC+47adjtVNI
         Wq0fRk9omMyrqMsz0aqzxzvc0ZW9xkHGpky1KaweL6GNNYlNGcgqUVDc0n04do+QrAAn
         fMcw==
X-Gm-Message-State: AOAM530pzlwIFaBLgFnaBR4/3d4Rk/635zkXV2vzYfB6kN7+XPCdCxl4
        rPmmHh/hepGFRd8wSUKR80cZBruZbYwZffCkVgN6G2NJTCEnKA==
X-Google-Smtp-Source: ABdhPJxqTV09JY3V8pXzuaZdj9XyhxhTlkAFc6nHNfwNXHVV5g145BnOfhji3ZAYH9OuWDb8OQmVhEeTst66VM+chd8=
X-Received: by 2002:ac8:5f0a:0:b0:2f9:3b64:b5ba with SMTP id
 x10-20020ac85f0a000000b002f93b64b5bamr5428178qta.2.1653401875661; Tue, 24 May
 2022 07:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220524073411.1943480-1-david@fromorbit.com> <20220524073411.1943480-4-david@fromorbit.com>
 <CAOQ4uxgZwngHevX_FXytAi68k=aqp_N-8Buk50rrJKD0UoK+2g@mail.gmail.com>
 <20220524122703.GL2306852@dread.disaster.area> <CAOQ4uxifd8gee1JLG1FN9fF3aSsVeSEuxFqjAf4D8ruCciXWYg@mail.gmail.com>
 <20220524132428.GO2306852@dread.disaster.area>
In-Reply-To: <20220524132428.GO2306852@dread.disaster.area>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 24 May 2022 17:17:44 +0300
Message-ID: <CAOQ4uxhWCKb8_pKU4CCE5Nv2qTqge-AyGBdoX2isrBui4cHdqA@mail.gmail.com>
Subject: Re: [PATCH 3/8] xfs/*: clean up _cleanup override
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 24, 2022 at 4:24 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Tue, May 24, 2022 at 03:55:47PM +0300, Amir Goldstein wrote:
> > > > > diff --git a/tests/xfs/310 b/tests/xfs/310
> > > > > index 3214e04b..c635b39a 100755
> > > > > --- a/tests/xfs/310
> > > > > +++ b/tests/xfs/310
> > > > > @@ -9,14 +9,12 @@
> > > > >  . ./common/preamble
> > > > >  _begin_fstest auto clone rmap
> > > > >
> > > > > -# Override the default cleanup function.
> > > > > -_cleanup()
> > > > > +_dmhuge_cleanup()
> > > > >  {
> > > > > -       cd /
> > > > > -       umount $SCRATCH_MNT > /dev/null 2>&1
> > > > >         _dmhugedisk_cleanup
> > > > > -       rm -rf $tmp.*
> > > > > +       _cleanup
> > > > >  }
> > > > > +_register_cleanup _dmhuge_cleanup
> > > >
> > > > Maybe it's just me, but if the intention is to maybe make this
> > > > function global someday then the difference with the name
> > > > _dmhugedisk_cleanup() is confusing.
> > >
> > > The names I used here are for classification, so I can grep over
> > > the _register_cleanup line and easily determine all the tests use
> > > loop devices, dmflakey, dmerror, etc and then consolidate them all
> > > into a single cleanup function that works for them all. This is just
> > > the first step in that process.
> > >
> > > > I'd rather keep the local function name local_cleanup
> > > > in unclear cases like this one.
> > >
> > > And that defeats the entire purpose of giving them a descriptive
> > > name at this point in time.
> >
> > I understand. It makes a lot of sense to do that.
> > It is still VERY confusing that there is a helper _dmhugedisk_cleanup
> > that SHOULD NOT be used as a trap and a helper _dmhuge_cleanup
> > that SHOULD be used as a trap, so a better convention is needed.
>
> I think you missed my point.
>
> _dmhuge_cleanup() is a *temporary name*.
>
> It will *go away* once I've processed the other 1000 tests which
> will also classify anything using dmhugedisk with a _dmhuge_cleanup
> function. It's a temporary token I can use for further
> classification and deduplication, nothing more, nothing less.
>

Ok if the two confusing names are not going to co-exists I'm fine
with either name.

> > I suggest that all consolidated helpers for trap will be called
> > either _cleanup_* (like cleanup_dump) or _*_cleanup (like _fsstress_cleanup)
> >
> > The problem is that there is no convetion in the common/* helpers.
> > there are _dmhugedisk_cleanup() _dmerror_cleanup() and there are
> > _cleanup_dump() _cleanup_delay().
>
> Exactly the reason why I've used simple names and the only
> consistency I care about is that I use the same name for the same
> subsystem cleanup functions. I can't give them globally consistent
> names at this point and because they are temporary tokens I simply
> have not tried. I give it a name, copy the function into a register
> buffer, and then paste it into any other test that uses the same
> subsystem and has the same cleanup requirements.
>
> Once I have all the tests that use dmhugedisk converted to use a
> local _dmhuge_cleanup function, I'll derive the commonality from
> them, move it into the existing cleanup function for that subsystem,
> and register the subsystem cleanup in those tests. _dmhuge_cleanup()
> then goes away forever.
>
> Once everythign is deduplicated and common, changing names will be
> simple and straight forward. That's when you can argue all you want
> over the names of functions and I won't care one bit.
>

All right, please bear in mind that I try to do this review with as little
nit picking as I can while still doing a professional review, so some
questions need to be raised.
The work you did is huge and impressive and the review is not easy.

Anyway, after fixing the recursive _dmerror_cleanup typo, you may add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

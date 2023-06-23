Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100D7EB64DD
	for <linux-fstests@archiver.kernel.org>; Fri, 23 Jun 2023 15:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjFWPa2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 23 Jun 2023 11:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjFWPa1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 23 Jun 2023 11:30:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C705C2
        for <fstests@vger.kernel.org>; Fri, 23 Jun 2023 08:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687534179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4OT4W8oKGaCrJ5GV32IvEg4wnmn9I7g1VXgw1R91TWk=;
        b=F8sdCjCS2ytH4Hb4t0mjPHN10J7AG6pRsy49i3AdVio40bCx99vVYbReopEkk0ObNOb+yP
        lekwaTgCwnD/TDWtxt8bhSh8fMNjT2nP22IUdcnKo2N5gL6QWvyTw1Y9xeJuzSQ13JLQq2
        Qdg0D1Gu0n5CuQmDLN1U9Te52ctsDiY=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-3RIXvnbBPJWFecJ7pZvazQ-1; Fri, 23 Jun 2023 11:29:38 -0400
X-MC-Unique: 3RIXvnbBPJWFecJ7pZvazQ-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-543c2537dacso453233a12.2
        for <fstests@vger.kernel.org>; Fri, 23 Jun 2023 08:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687534177; x=1690126177;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4OT4W8oKGaCrJ5GV32IvEg4wnmn9I7g1VXgw1R91TWk=;
        b=duiEwZkVlbS/sEPZVMoL1S3rQJe56Zu09vGpgNEgjp7sCtQbqGk/qkYFnhUeLL/Q4n
         9Esw+TVY84Imq97ZhQ/Wod+agkRqfoGGncjvilGSXmzBPBY8MqWtg9TgczPSzwPm/WdT
         cBrkiQVswTcEm7VaUK8GWymgl7zMueJaV4GfvGmYh712KbmszPiVxXJDLUUY/vhIGdvO
         OtBoVqKm0oGutuGAoxoiYKlPMAQpJnM0MEE8Mbc6tcTHN1LLLj0iYBwTwZVNvl1MUdkI
         XIkHpevODpFNL4rvwbQTDsWbN7Fgl8iGfnSEoCzOhO4BQiX1pAkmewoofZj2Y0bfPmP2
         4vuQ==
X-Gm-Message-State: AC+VfDyBDV5BMVmyZ8fltx5i0tFYa5EyHbd/NOlJqtW4rvmFNDvaji4P
        gDZ0qJ4PPmqiVQKKQQaowI3+BZ6VsBS2O7vdtfrNjUannjQ4G7g4lAPGDvJes4Zd+I6fPIdG+8N
        Z2iGaCdAt7eRJmWw7u/EqfTDMwxzp
X-Received: by 2002:a05:6a20:7f91:b0:104:ad71:f080 with SMTP id d17-20020a056a207f9100b00104ad71f080mr18930771pzj.34.1687534176779;
        Fri, 23 Jun 2023 08:29:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Qxe7+D3r//pPAv75X3aQcc78S01OwpNNQ5nvkjjc3Bl1zOmbwwQVkY85GisKHbczkhZ2CPg==
X-Received: by 2002:a05:6a20:7f91:b0:104:ad71:f080 with SMTP id d17-20020a056a207f9100b00104ad71f080mr18930755pzj.34.1687534176378;
        Fri, 23 Jun 2023 08:29:36 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a8-20020a62bd08000000b0064d4d11b8bfsm6186000pff.59.2023.06.23.08.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 08:29:35 -0700 (PDT)
Date:   Fri, 23 Jun 2023 23:29:31 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>,
        David Disseldorp <ddiss@suse.de>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: reduce runtime of check -n
Message-ID: <20230623152931.plfuztmlzsazpt3a@zlang-mailbox>
References: <20230619105058.2711467-1-amir73il@gmail.com>
 <20230621022355.yk7dy2e6sghcuzrp@zlang-mailbox>
 <20230621112656.2efac042@echidna.fritz.box>
 <CAOQ4uxiwS8GZkgr6KYx9_+uCgv2Z11pdWxV3Qr6tu9cNP_Pwyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiwS8GZkgr6KYx9_+uCgv2Z11pdWxV3Qr6tu9cNP_Pwyw@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jun 21, 2023 at 03:09:35PM +0300, Amir Goldstein wrote:
> On Wed, Jun 21, 2023 at 12:24 PM David Disseldorp <ddiss@suse.de> wrote:
> >
> > Hi Zorro and Amir,
> >
> > On Wed, 21 Jun 2023 10:23:55 +0800, Zorro Lang wrote:
> >
> > > On Mon, Jun 19, 2023 at 01:50:58PM +0300, Amir Goldstein wrote:
> > > > kvm-xfstests invokes check -n twice to pre-process and generate the
> > > > tests-to-run list, which is then being passed as a long list of tests
> > > > for invkoing check in the command line.
> > > >
> > > > check invokes dirname, basename and sed several times per test just
> > > > for doing basic string prefix/suffix trimming.
> > > > Use bash string pattern matching instead which is much faster.
> > > >
> > > > Note that the following pattern matching expression change:
> > > > < test_dir=${test_dir#$SRC_DIR/*}
> > > > > t=${t#$SRC_DIR/}
> > > > does not change the meaning of the expression, because the
> > > > shortest match of "$SRC_DIR/*" that is being trimmed is "$SRC_DIR/"
> > > > and removing the tests/ prefix is what this code intended to do.
> > > >
> > > > With check -n, there is no need to cleanup the results dir,
> > > > but check -n is doing that for every single listed test.
> > > > Move the cleanup of results dir to before actually running the test.
> > > >
> > > > These improvements to check pre-test code cut down several minutes
> > > > from the time until tests actually start to run with kvm-xfstests.
> > > >
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > ---
> > > >
> > > > Zorro,
> > > >
> > > > Just to clarify, this change is not expected to change behavior -
> > > > only to improve runtime of check -n and the things that happen
> > > > before the first test is invoked.
> > > >
> > > > Thanks,
> > > > Amir.
> > > >
> > > >  check | 22 +++++++++-------------
> > > >  1 file changed, 9 insertions(+), 13 deletions(-)
> > > >
> > > > diff --git a/check b/check
> > > > index e36978c1..1a16eccb 100755
> > > > --- a/check
> > > > +++ b/check
> > > > @@ -399,9 +399,9 @@ if $have_test_arg; then
> > > >             *)      # Expand test pattern (e.g. xfs/???, *fs/001)
> > > >                     list=$(cd $SRC_DIR; echo $1)
> > > >                     for t in $list; do
> > > > -                           test_dir=`dirname $t`
> > > > -                           test_dir=${test_dir#$SRC_DIR/*}
> > > > -                           test_name=`basename $t`
> > > > +                           t=${t#$SRC_DIR/}
> > >
> > > Actually I'm not sure what's this line for. We get $list by "cd $SRC_DIR; echo $1",
> > > is there any chance to have "$SRC_DIR" in $t (or $test_dir) ?
> >
> > Indeed, this line can be dropped. One minor change in behaviour here is
> > that a test pattern with a wacky path prefix e.g. ../tests/xfs/00? will
> > no longer work. I think breaking such patterns is okay, but it could
> > also be resolved by more carefully extracting the last two path
> > components.
> >

Hi Amir and David,

Sorry for the late reply, I'm on a holiday of Dragon Boat Festival recently,
will be back tomorrow :)

> 
> I didn't want to drop it because I didn't want to change legacy behavior.

Sure, I didn't want to remove this line in this patch, due to it's not
match the target of this patch. Just speak out to check with you and
others :)

As we agree this line is useless, we can deal with it in later patch
which improves ./check.

> When user's cwd is fstests root directory, it may be natural for some
> users to use bash auto completion to run the command
> ./check tests/generic/001
> 
> so there may well be users out these that pass test names including
> the tests/ prefix and check has always trimmed this prefix.
> 
> There is something a bit confusing about expanding of bash
> patterns:
> 
> When the user uses this syntax:
> ./check tests/generic/00?

I think the "tests/" prefix is not necessary to support :)

> 
> the shell expands that pattern to a list of 9 arguments passed to
> ./check tests/generic/001  tests/generic/002 ...
> 
> But when the user uses the documented syntax:
> ./check generic/00?
> check gets a single argument and $(cd $SRC_DIR; echo $1)
> expands this single argument to a list
> 
> All the above is existing behavior which my patch should
> not have changed.
> 
> > > > +                           test_dir=${t%/*}
> > > > +                           test_name=${t#*/}
> > >
> 
> You may change the above to:
> +                           test_dir=${t%%/*}
> +                           test_name=${t##*/}

OK, this makes more sense to me. I'll give this a test, and merge this
change if no regression. Or you'd like to send a V2 to change more.

> 
> I tested and this deals with "xfs//001" and "xfs//00?"
> correctly (it trimms the longest match to */ prefix or /* suffix
> instead of the shortest match.
> 
> The line below group= could be changed to %%/* as well
> but it does not matter because $group is used as part of
> the results path which can live with //.
> 
> Unfortunately, trimming tests// from tests//xfs/001 without
> also trimming xfs/ is less trivial and while I gave a reason
> why tests/ prefix may be used in the wild, but I can think
> of no good reason why tests// prefix would be used in the wild.
> 
> > > This change looks isn't related with the "check -n". Any reason to change
> > > that? Does the 'dirname' and 'basename' have poor performance, or some systems
> > > miss them?
> > >
> > > I prefer the 'dirname' and 'basename' ways, if there's not a specific reason
> > > to change that. Due to they can deal with more complicated path name, e.g.
> > > "xfs//001". But the "$(cd $SRC_DIR; echo $1)" looks won't generate a path name
> > > likes that, so if you have a proper reason to make this change, that's fine.
> >
> > The per-iteration `dirname` and `basename` subshells add multiple
> > seconds of latency to `./check -n *fs/*` in my test env.

Thanks for this feedback. I understand now.

Thanks,
Zorro

> >
> 
> Exactly.
> Whoever looks at strace of check will observe that it is very noisy with
> execve of dirname and basename.
> 
> The next step would be to use bash dictionary instead of multiple
> invocations of grep to filter tests by match to -g <group> or -g xfs/<group>,
> but that is left for another day...
> 
> Thanks,
> Amir.
> 


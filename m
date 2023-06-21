Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1636EB64D7
	for <linux-fstests@archiver.kernel.org>; Wed, 21 Jun 2023 12:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjFUMJ4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 21 Jun 2023 08:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbjFUMJt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 21 Jun 2023 08:09:49 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41201710
        for <fstests@vger.kernel.org>; Wed, 21 Jun 2023 05:09:47 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-78f554d4949so1371633241.3
        for <fstests@vger.kernel.org>; Wed, 21 Jun 2023 05:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687349387; x=1689941387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9G5MipPr8shuvTxTrl8ojMxW2hqemgqkKzlv+1JJBA=;
        b=QD50TExcRh+I8vGMkCvuF8GbcY/wlO/PYMi7t5OEaJpD+/xa80wxUoChAj5HqIxsa7
         C8a5svn8qCSv0ecMgLl4j8TQIDcJJyILiU9EOqo4qw4nRssirV7W06+7xM/RzCVdN1A5
         xgrYLAZW6UeK6run+s4vtbu7ZxkZbVx+95oi6AUV3lktYD9nKRPW2gBgfCRG0wApIaqT
         3fhwRqoXgNwhsGifvEUKghkmQtDYpMKmqGUe1hnsCb28w+s5M9uVYFNmqPwS0IHVl3zv
         NFaRANGU96wCkUReVpzPF6vo/qSzPitiTlsm5vDmGVsUJb7rcO7jU29QSuh8R1jQLNYV
         gVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687349387; x=1689941387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H9G5MipPr8shuvTxTrl8ojMxW2hqemgqkKzlv+1JJBA=;
        b=SgQzMTawkQhBjW4DIjWt7WWg1vpBGCjzymWknucL6dvzg2oDjvAKn6JVXYPenU/9K9
         nEWfPShdSRbV9c1WG0faYUOScBSBHRFXhlsfYGZuCJXgyZCGll03/9q410Yi/3cEzO4v
         XI1eUxC2RFLCY+oT47BObFgHqMp34gWWP+pMCPnPuMhFWH4YANvdwlW6nwYrHO7vFpSp
         OZ0+04kdgmy1y3njIeTdfmQzisczsFmK0/H7HYRNqHc6Up8IX+3kyM/INwQSJji7yRhF
         M5rMiKRuu3eM1QNhvTe0WngbexQ3vpqPcEPmfo4c9ehmEyJgtw6mCSiYLhx+0HmTmjXv
         2d3Q==
X-Gm-Message-State: AC+VfDxDo5WDRNnOq00PDdbkzkffnncNkdAspUonUcEKvXlngx+rqqjQ
        J5GyjZBIMDSFrM2VpTwXGWudklGznKrzd4IBY/9UXNZoL4k=
X-Google-Smtp-Source: ACHHUZ5pq+jcrTzuOL7857U+716WVS8wGidM+xcXTow/F6Hjx1c7BRoFj8GpZLNd0ZlMDgW7ig7JdSUE1/PAupvZfMs=
X-Received: by 2002:a05:6102:523:b0:440:ae69:603d with SMTP id
 m3-20020a056102052300b00440ae69603dmr4518736vsa.16.1687349386789; Wed, 21 Jun
 2023 05:09:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230619105058.2711467-1-amir73il@gmail.com> <20230621022355.yk7dy2e6sghcuzrp@zlang-mailbox>
 <20230621112656.2efac042@echidna.fritz.box>
In-Reply-To: <20230621112656.2efac042@echidna.fritz.box>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 21 Jun 2023 15:09:35 +0300
Message-ID: <CAOQ4uxiwS8GZkgr6KYx9_+uCgv2Z11pdWxV3Qr6tu9cNP_Pwyw@mail.gmail.com>
Subject: Re: [PATCH] fstests: reduce runtime of check -n
To:     David Disseldorp <ddiss@suse.de>
Cc:     Zorro Lang <zlang@redhat.com>, "Theodore Ts'o" <tytso@mit.edu>,
        fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jun 21, 2023 at 12:24=E2=80=AFPM David Disseldorp <ddiss@suse.de> w=
rote:
>
> Hi Zorro and Amir,
>
> On Wed, 21 Jun 2023 10:23:55 +0800, Zorro Lang wrote:
>
> > On Mon, Jun 19, 2023 at 01:50:58PM +0300, Amir Goldstein wrote:
> > > kvm-xfstests invokes check -n twice to pre-process and generate the
> > > tests-to-run list, which is then being passed as a long list of tests
> > > for invkoing check in the command line.
> > >
> > > check invokes dirname, basename and sed several times per test just
> > > for doing basic string prefix/suffix trimming.
> > > Use bash string pattern matching instead which is much faster.
> > >
> > > Note that the following pattern matching expression change:
> > > < test_dir=3D${test_dir#$SRC_DIR/*}
> > > > t=3D${t#$SRC_DIR/}
> > > does not change the meaning of the expression, because the
> > > shortest match of "$SRC_DIR/*" that is being trimmed is "$SRC_DIR/"
> > > and removing the tests/ prefix is what this code intended to do.
> > >
> > > With check -n, there is no need to cleanup the results dir,
> > > but check -n is doing that for every single listed test.
> > > Move the cleanup of results dir to before actually running the test.
> > >
> > > These improvements to check pre-test code cut down several minutes
> > > from the time until tests actually start to run with kvm-xfstests.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >
> > > Zorro,
> > >
> > > Just to clarify, this change is not expected to change behavior -
> > > only to improve runtime of check -n and the things that happen
> > > before the first test is invoked.
> > >
> > > Thanks,
> > > Amir.
> > >
> > >  check | 22 +++++++++-------------
> > >  1 file changed, 9 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/check b/check
> > > index e36978c1..1a16eccb 100755
> > > --- a/check
> > > +++ b/check
> > > @@ -399,9 +399,9 @@ if $have_test_arg; then
> > >             *)      # Expand test pattern (e.g. xfs/???, *fs/001)
> > >                     list=3D$(cd $SRC_DIR; echo $1)
> > >                     for t in $list; do
> > > -                           test_dir=3D`dirname $t`
> > > -                           test_dir=3D${test_dir#$SRC_DIR/*}
> > > -                           test_name=3D`basename $t`
> > > +                           t=3D${t#$SRC_DIR/}
> >
> > Actually I'm not sure what's this line for. We get $list by "cd $SRC_DI=
R; echo $1",
> > is there any chance to have "$SRC_DIR" in $t (or $test_dir) ?
>
> Indeed, this line can be dropped. One minor change in behaviour here is
> that a test pattern with a wacky path prefix e.g. ../tests/xfs/00? will
> no longer work. I think breaking such patterns is okay, but it could
> also be resolved by more carefully extracting the last two path
> components.
>

I didn't want to drop it because I didn't want to change legacy behavior.
When user's cwd is fstests root directory, it may be natural for some
users to use bash auto completion to run the command
./check tests/generic/001

so there may well be users out these that pass test names including
the tests/ prefix and check has always trimmed this prefix.

There is something a bit confusing about expanding of bash
patterns:

When the user uses this syntax:
./check tests/generic/00?

the shell expands that pattern to a list of 9 arguments passed to
./check tests/generic/001  tests/generic/002 ...

But when the user uses the documented syntax:
./check generic/00?
check gets a single argument and $(cd $SRC_DIR; echo $1)
expands this single argument to a list

All the above is existing behavior which my patch should
not have changed.

> > > +                           test_dir=3D${t%/*}
> > > +                           test_name=3D${t#*/}
> >

You may change the above to:
+                           test_dir=3D${t%%/*}
+                           test_name=3D${t##*/}

I tested and this deals with "xfs//001" and "xfs//00?"
correctly (it trimms the longest match to */ prefix or /* suffix
instead of the shortest match.

The line below group=3D could be changed to %%/* as well
but it does not matter because $group is used as part of
the results path which can live with //.

Unfortunately, trimming tests// from tests//xfs/001 without
also trimming xfs/ is less trivial and while I gave a reason
why tests/ prefix may be used in the wild, but I can think
of no good reason why tests// prefix would be used in the wild.

> > This change looks isn't related with the "check -n". Any reason to chan=
ge
> > that? Does the 'dirname' and 'basename' have poor performance, or some =
systems
> > miss them?
> >
> > I prefer the 'dirname' and 'basename' ways, if there's not a specific r=
eason
> > to change that. Due to they can deal with more complicated path name, e=
.g.
> > "xfs//001". But the "$(cd $SRC_DIR; echo $1)" looks won't generate a pa=
th name
> > likes that, so if you have a proper reason to make this change, that's =
fine.
>
> The per-iteration `dirname` and `basename` subshells add multiple
> seconds of latency to `./check -n *fs/*` in my test env.
>

Exactly.
Whoever looks at strace of check will observe that it is very noisy with
execve of dirname and basename.

The next step would be to use bash dictionary instead of multiple
invocations of grep to filter tests by match to -g <group> or -g xfs/<group=
>,
but that is left for another day...

Thanks,
Amir.

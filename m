Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50765C001DB
	for <linux-fstests@archiver.kernel.org>; Mon, 14 Aug 2023 14:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjHNOz2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 14 Aug 2023 10:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbjHNOy7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 14 Aug 2023 10:54:59 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5667CE5F
        for <fstests@vger.kernel.org>; Mon, 14 Aug 2023 07:54:57 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-79af014b555so1089545241.1
        for <fstests@vger.kernel.org>; Mon, 14 Aug 2023 07:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692024896; x=1692629696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=me46NmCp6qKOLsRrqwuIi+FWOuLww4rqc+BRCYrKazI=;
        b=InkTNn++YjJFYFIZNqR7b/KLiDV8F11b2vBvexibLAMUAdOwJ6HIM7SHPkl50f/b5R
         cRRFdG8SKOFyanO0MlTHGpTOj+jkU2prwiyOAjewTBqEaAdcd59GbiS6R/HO5TKJGFYd
         Te1O2cdIXZvgPgcvin6CiHorctqqJzBob0M7GuJBEWO3LNOzh1sl6wP6+CkZBiFY3Y0R
         PDVaY29fSVCXWdwWCNlTb3FPQ/wKNb0244AJOk1hZ8ipSXCBZlOJy+vjX1jJZvpdgNHb
         AF05At7xabm088TtEB57mtOM0eDf+626S3i1/NqX31IzRZpiVPCJjPk2af9XYn4ca9kn
         TUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692024896; x=1692629696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=me46NmCp6qKOLsRrqwuIi+FWOuLww4rqc+BRCYrKazI=;
        b=Tl3FJJ1bgHoqDiMq09CGrWMY9Ut6ojX8gBt0vPOawyg1ygH2fFe0A1r7Eu03uYKqKf
         FDVtpqjkCez7d7ASScczKf466Pgm8QgFL49JnPWgaDTfuJHi2DiTCJ/rp1zETxwU7+RK
         srxVblwm/bBaA5NEkzim2iFX4cROziPWYcrINb8N7tFprs6iQLOlfRmg/aaX34bkQP1g
         BIjtHiQDrDtOg26jpXDEFfy8aaYzqHPOXJMsPeCwIqkq/V3kg6hBrXu/4X71bESg80g9
         0mmtLIwbUGYaEzaMLj1LNT4LPbD0xDezMJiCk6ueMBHc63ceX3OKA2/Su3wR6zGS9pnY
         NeSw==
X-Gm-Message-State: AOJu0YzgFB6XUrLWcQQOKpJSsncu46VK1xm1/GxW8CUqfVlMr69yh+MU
        M/WFzb1U9RsgAU94DjjqLsbOYHcyyCRRs9ZuGbQ=
X-Google-Smtp-Source: AGHT+IGErp6995FKfhqe1dODAfeiHx3mjJ0X7/AKyZzyrMo9UbgrDxej0rh4S8MmrCZjMHCGwpE5QHt6gnNv3wTqyyw=
X-Received: by 2002:a05:6102:3645:b0:440:b7df:767b with SMTP id
 s5-20020a056102364500b00440b7df767bmr9233263vsu.11.1692024896428; Mon, 14 Aug
 2023 07:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230813140950.678899-1-amir73il@gmail.com> <20230814145015.6w6l2y7dxt4opvov@zlang-mailbox>
In-Reply-To: <20230814145015.6w6l2y7dxt4opvov@zlang-mailbox>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 14 Aug 2023 17:54:45 +0300
Message-ID: <CAOQ4uxha+18YG+LrX76-2BUxuyTYcZ=9+cJOoCGpnLSC21Sxrg@mail.gmail.com>
Subject: Re: [PATCH] check: fix parsing expunge file with comments
To:     Zorro Lang <zlang@redhat.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Aug 14, 2023 at 5:50=E2=80=AFPM Zorro Lang <zlang@redhat.com> wrote=
:
>
> On Sun, Aug 13, 2023 at 05:09:50PM +0300, Amir Goldstein wrote:
> > commit 60054d51 ("check: fix excluded tests are only expunged in the
> > first iteration") change to use exclude_tests array instead of file.
> >
> > The check if a test is in expunge file was using grep -q $TEST_ID FILE
> > so it was checking if the test was a non-exact match to one of the
> > lines, for a common example: "generic/001 # exclude this test" would be
> > a match to test generic/001.
> >
> > The commit regressed this example, because the new code checks for exac=
t
> > match of [ "generic/001" =3D=3D "generic/001 " ]. Change the code to us=
e
> > prefix match to deal with this case and any other suffix correctly.
> >
> > While the original code would also match line "exclude test generic/001=
"
> > I don't think that non-prefix match is a real use case.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  check | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/check b/check
> > index 549725eb..e8152f59 100755
> > --- a/check
> > +++ b/check
> > @@ -592,7 +592,8 @@ _expunge_test()
> >       local TEST_ID=3D"$1"
> >
> >       for f in "${exclude_tests[@]}"; do
> > -             if [ "${TEST_ID}" =3D=3D "$f" ]; then
> > +             # $f may contain traling spaces and comments
> > +             if [[ "$f" =3D=3D ${TEST_ID}* ]]; then
>
> We'll have seqnum with 4 numbers in one day, likes generic/1000. At that =
time,
> generic/100[0-9] will match generic/100*. That's not what we want.
>

Good point.

> I think we'd better to do exact match, or better to match the end of a wo=
rd,
> for example
>
>   local id_regex=3D"^${TEST_ID}\b"
>   if [[ "$f" =3D~ ${id_regex} ]];then
>   ...
>
> I think this will match "generic/100" and "generic/100 # xxxxx". But won'=
t match
> "generic/1001".
>

Nice. Looks good to me.

Thanks,
Amir.

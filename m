Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B023FC001B0
	for <linux-fstests@archiver.kernel.org>; Sun, 13 Aug 2023 18:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjHMSxl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 13 Aug 2023 14:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjHMSxk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 13 Aug 2023 14:53:40 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48BAE6F
        for <fstests@vger.kernel.org>; Sun, 13 Aug 2023 11:53:42 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-76d535567afso22690385a.1
        for <fstests@vger.kernel.org>; Sun, 13 Aug 2023 11:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691952822; x=1692557622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/wXyu4+tWti1+Fec0MywmjxhCB7skFVfIPO6BVH3Jg=;
        b=cpW6GKRhunDIw9krjzTcgl9EW0uQALzqo/GARbIrBwBZE/qhK8HS0KgHJnoaEUV57p
         FoPjhVU6DyQEPWJfaMZSI5hg4bQy8FjwV7s6qOWzJv11huMi4XjCZHZY6N55oxTAwiR0
         noksdxaXoyGDx0g6CLPdkSyiP6LEVbFDcGPF876+8grv+HZvKNz9pNOdQTZ/t9e3tcIv
         l4MzoFTDhV5LOxGQw9JxpbqOeskXRCayYaa/h4mn0XTb5xL5bMhivdyz2Q/gudV5+/Ik
         WA9ImoDwkryJlRREhmEhFlxxYcvZoxBcl5VY9O+SPBzgCvWiFHwJ/4zHGmpt6qpjIgRj
         OdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691952822; x=1692557622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p/wXyu4+tWti1+Fec0MywmjxhCB7skFVfIPO6BVH3Jg=;
        b=eUncHPSxLoJVR2a2Rz7AX53o92tMqbbouqaK7X493MkiH6QmpxQ1i+eDzB2c2S2OYe
         YERoGhOyskfDq5MdXNW7uMVt+3ewMmt3TbMCslJLN8Wnc9FxaGnNfdhdUSL9wyNMRfro
         qiYb0hcJh14LO4HkV0RANx9VWFHq+mmUXNz84wQFuHCxlneBCIfjArMC0sAoJT3s6kK5
         p5ReI6LxTkYxkyYkvtdFGUj5T4c9seQ9unsx52sxEya7znQgLVWrJrqgnjGpQWF/M+jv
         2KRWsGwVMOcUkW+dwF4h7qYjLJKJn6l9SKxOC3GRDX7BP3/69buQ+YXjuINPs7/ozM1Z
         Ztzg==
X-Gm-Message-State: AOJu0YwYr4GjswKgN7voMZzIos/ZLgvcxDuXiC8CG3imSpmTWogJaLnC
        mp3MfOfWz9jfF93y2wW7Sbehc9rMh0A+zgu3BN4=
X-Google-Smtp-Source: AGHT+IGkDoIOmxQEaOEL2JO+MYSBnLNhqx+GOBUK2zpuRM7fbDqV4OKAcRbcVRCM/b7fJNJXQ7nI2T0jlz+A1EMhpxM=
X-Received: by 2002:a05:620a:400b:b0:767:30a5:4ca1 with SMTP id
 h11-20020a05620a400b00b0076730a54ca1mr10171510qko.46.1691952821812; Sun, 13
 Aug 2023 11:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230812151500.553233-1-amir73il@gmail.com> <20230813153523.GQ11377@frogsfrogsfrogs>
In-Reply-To: <20230813153523.GQ11377@frogsfrogsfrogs>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 13 Aug 2023 21:53:30 +0300
Message-ID: <CAOQ4uxiwyCvEshtc9QDUKKXyO0U77cq+ENy7FAz+9v4s7YUoSQ@mail.gmail.com>
Subject: Re: [PATCH] generic/{175,297,298}: fix use of uninitialized var
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Zorro Lang <zlang@redhat.com>,
        Chandan Babu R <chandan.babu@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Aug 13, 2023 at 6:35=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Sat, Aug 12, 2023 at 06:15:00PM +0300, Amir Goldstein wrote:
> > Not sure how those tests pass in regression tests.
> > Probably truncate silently fails and is not critical to the test.
> >
> > in kdevops I get errors like:
> > /data/fstests-install/xfstests/tests/generic/298: line 45: /dev/loop12)=
:
> >            syntax error: operand expected (error token is "/dev/loop12)=
")
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  tests/generic/175 | 2 +-
> >  tests/generic/297 | 2 +-
> >  tests/generic/298 | 2 +-
> >  3 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/tests/generic/175 b/tests/generic/175
> > index 07af2199..14825a39 100755
> > --- a/tests/generic/175
> > +++ b/tests/generic/175
> > @@ -33,7 +33,7 @@ _pwrite_byte 0x61 0 $blksz "$testdir/file1" >> "$seqr=
es.full"
> >
> >  fnr=3D19
> >  echo "Create extents"
> > -truncate -s $(( (2 ** i) * blksz)) "$testdir/file1"
> > +truncate -s $(( (2 ** (fnr + 1)) * blksz)) "$testdir/file1"
> >  for i in $(seq 0 $fnr); do
>
> Hmm.  Frankly I don't remember why I put those truncate calls in there.

You specifically added truncate in commit
ddf6ff2f reflink: ensure that we can handle reflinking a lot of extents
and then it was copied to the two new tests.
maybe this will give you a hint?

> Does the test still work if you remove them entirely?  AFAICT the test
> writes a single block's worth of data to the file, then truncates the
> file size to one block.  Which I think is pointless.
>
> >       echo " ++ Reflink size $i, $((2 ** i)) blocks" >> "$seqres.full"
> >       n=3D$(( (2 ** i) * blksz))
> > diff --git a/tests/generic/297 b/tests/generic/297
> > index 6bdc3e1c..1fc48671 100755
> > --- a/tests/generic/297
> > +++ b/tests/generic/297
> > @@ -42,7 +42,7 @@ _pwrite_byte 0x61 0 $blksz $testdir/file1 >> $seqres.=
full
> >  fnr=3D26               # 2^26 reflink extents should be enough to find=
 a slow op?
> >  timeout=3D8    # guarantee a good long run...
> >  echo "Find a reflink size that takes a long time"
> > -truncate -s $(( (2 ** i) * blksz)) $testdir/file1
> > +truncate -s $(( (2 ** (fnr + 1)) * blksz)) $testdir/file1
> >  for i in $(seq 0 $fnr); do
> >       echo " ++ Reflink size $i, $((2 ** i)) blocks" >> $seqres.full
> >       n=3D$(( (2 ** i) * blksz))
>
> The loop control logic could be converted to:
>
> echo "Find a reflink size that takes a long time"
> deadline=3D"$(( $(date +%s) + timeout ))"
> for ((i =3D 0, now =3D $(date +%s); i < fnr && now < deadline; i++, now =
=3D $(date +%s))); do
>         echo " ++ Reflink size $i, $((2 ** i)) blocks" >> $seqres.full
>         n=3D$(( (2 ** i) * blksz))
>         $XFS_IO_PROG -f -c "reflink $testdir/file1 0 $n $n" $testdir/file=
1 >> $seqres.full 2>&1
> done
>
> (also in 298)
>

Whatever works is fine by me.
Feel free to keep my commit message or drop it.

Thanks,
Amir.

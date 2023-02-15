Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEA2C636D4
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Feb 2023 05:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjBOF6K (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 15 Feb 2023 00:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjBOF6J (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 15 Feb 2023 00:58:09 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956DF1BE2
        for <fstests@vger.kernel.org>; Tue, 14 Feb 2023 21:58:07 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id k6so18851400vsk.1
        for <fstests@vger.kernel.org>; Tue, 14 Feb 2023 21:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676440686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zMVTdFFlhwSTTvoYCY4sgrgrx3ghmu7P1KruEyaVKQg=;
        b=lgo+CjKSIEWzt4baTkxscmTtgJK2s953AZfE2p7woUHqZ3w4PSTenkB/HwnlNoPW2L
         a23RG5VUbCicQZ2EIhwwuvbH/9pc1glwb85fFYDrK7d3BfS0Z0LJoGJiGJfmtd4cG0se
         asuYEysRevFG874ViR+U8g0qQQV4OUDQYs2R+qx+WANz4gStYzYEOZTNeTeJNH1GpeC/
         Ew/OeQ5UNmzUVHiHWKVrQRw39f5MMH+yjVE/PCHXux0huHmzmsKDF1ubTMeV/rCdk44M
         +fiYR+foB9xXK+Sgcqj2phN9Ip7hlqygWLnffIicFCD5qhHZxhFQLAvVbSQg0jv4LBTI
         9KCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676440686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zMVTdFFlhwSTTvoYCY4sgrgrx3ghmu7P1KruEyaVKQg=;
        b=x1WwPuCJ4SVJ4KYZmPGMu5zefluOGKorku5opWXMYTZ855r7WPRzFR817ikaOdbSE1
         S+xAMgZ329+xCpLhHBRhcCOm1Zgi9eNBlyTF74h1s/0f5Zkv/7UZ1q/VVLnP/re82l52
         smFyXuG8HxfiAkAm8ai8cTznzTNK0Q1lNRZdTWMvM17URojKB5+pVFzSwXoDHVZjKLjI
         cFNzhLtLGcrgDHKDiJ17oHYzDsE4nZ46xc2WJF02+GWsFbSeHc2BLj3YrhreMmNV07wu
         8wQXhwRvRIcYcWIuUU1gJr7iCbgiv9R5bUhF/vaDFRjHjw2kFv/zGNJKfRy+842r62Vu
         0mag==
X-Gm-Message-State: AO0yUKWsfjyUEe2lsUljZcovg8GaVUhTAK6azeuivIx2/gUcv8bQ61hK
        MxtIbL/Xg4rOlmBwiBUpinbn5lfuQWh+SjvkK10=
X-Google-Smtp-Source: AK7set8HKPsW8xY1sUkQACG4+ez/jBFmiBVx7iNVzODfy5hB/H0XsJ/y8b6IpxIOF1swF4ZMdHxKrfvwipB9Y2L92yM=
X-Received: by 2002:a67:346:0:b0:412:c65:7446 with SMTP id 67-20020a670346000000b004120c657446mr249345vsd.23.1676440686686;
 Tue, 14 Feb 2023 21:58:06 -0800 (PST)
MIME-Version: 1.0
References: <20230214215431.1425107-1-leah.rumancik@gmail.com> <20230215044941.xgk3crhvv2jlahx6@zlang-mailbox>
In-Reply-To: <20230215044941.xgk3crhvv2jlahx6@zlang-mailbox>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 15 Feb 2023 07:57:55 +0200
Message-ID: <CAOQ4uxguCkBjXydVLbDSGX7-aHd_G_tfD4u4fgvH9QCN=edA-g@mail.gmail.com>
Subject: Re: [PATCH v2] selftest: add tests for debugging testing setup
To:     Zorro Lang <zlang@redhat.com>,
        Leah Rumancik <leah.rumancik@gmail.com>
Cc:     fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Feb 15, 2023 at 6:57 AM Zorro Lang <zlang@redhat.com> wrote:
>
> On Tue, Feb 14, 2023 at 01:54:31PM -0800, Leah Rumancik wrote:
> > Many people have developed infrastructure around xfstests. In order to
> > test a setup, it would be helpful to have dummy tests that have
> > consistent test outcomes. Add a new test folder with the following
> > tests:
> >
> > selftest/001 pass
> > selftest/002 fail from output mismatch
> > selftest/003 fail via _fail
> > selftest/004 skip
> > selftest/005 crash
> > selftest/006 hang
> >
> > Also, create two new groups: 'selftest' which includes tests 001-004 and
> > 'dangerous_selftest' which includes tests 005-006. The selftests will
> > run when running all tests but they are not part of the auto group.
> >
> > Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> > ---
> > v1 -> v2:
> >
> > - change name of folder from 'debug' to 'selftest'
> > - update tags to 'selftest' and 'dangerous_selftest'
> > - add selftest folder to SRC_GROUPS
> > - update copyright tag
> > - add test which _fails
>
> Thanks, this version looks good to me, just each case has a blank line at EOF.
> I'll help to remove those blank lines when I merge this patch.
>
> Reviewed-by: Zorro Lang <zlang@redhat.com>
>
> Thanks,
> Zorro
>
>
> >
> > v1: https://lore.kernel.org/fstests/20230209013143.2586104-1-leah.rumancik@gmail.com/
> >
> >  check                   |  2 +-
> >  doc/group-names.txt     |  2 ++
> >  tests/selftest/001      | 14 ++++++++++++++
> >  tests/selftest/001.out  |  2 ++
> >  tests/selftest/002      | 14 ++++++++++++++
> >  tests/selftest/002.out  |  2 ++
> >  tests/selftest/003      | 16 ++++++++++++++++
> >  tests/selftest/003.out  |  2 ++
> >  tests/selftest/004      | 16 ++++++++++++++++
> >  tests/selftest/004.out  |  2 ++
> >  tests/selftest/005      | 17 +++++++++++++++++
> >  tests/selftest/005.out  |  2 ++
> >  tests/selftest/006      | 20 ++++++++++++++++++++
> >  tests/selftest/006.out  |  2 ++
> >  tests/selftest/Makefile | 24 ++++++++++++++++++++++++
> >  15 files changed, 136 insertions(+), 1 deletion(-)
> >  create mode 100755 tests/selftest/001
> >  create mode 100644 tests/selftest/001.out
> >  create mode 100755 tests/selftest/002
> >  create mode 100644 tests/selftest/002.out
> >  create mode 100755 tests/selftest/003
> >  create mode 100644 tests/selftest/003.out
> >  create mode 100755 tests/selftest/004
> >  create mode 100644 tests/selftest/004.out
> >  create mode 100755 tests/selftest/005
> >  create mode 100644 tests/selftest/005.out
> >  create mode 100755 tests/selftest/006
> >  create mode 100644 tests/selftest/006.out
> >  create mode 100644 tests/selftest/Makefile
> >
> > diff --git a/check b/check
> > index 4827532e..c2065cdc 100755
> > --- a/check
> > +++ b/check
> > @@ -48,7 +48,7 @@ timestamp=${TIMESTAMP:=false}
> >
> >  rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.xlist $tmp.report.* $tmp.arglist
> >
> > -SRC_GROUPS="generic shared"
> > +SRC_GROUPS="generic shared selftest"

I know this is a bit of bikeshedding,
but is it really needed to add selftest/* to SRC_GROUPS and then filter it out
by group?

Seems to me that it would be simpler to not add any new groups and use
./check -g selftest/quick -g selftest/dangerous
to run the tests in the selftests subdir.

Just to be clear, the syntax above already works, nothing new to implement.

I do not object to adding the selftest groups if others like it better this way.

It would also be nice to drop a line in README about running selftests.

Thanks,
Amir.

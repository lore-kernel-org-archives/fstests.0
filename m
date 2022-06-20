Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881DFC43334
	for <linux-fstests@archiver.kernel.org>; Mon, 20 Jun 2022 14:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239848AbiFTO67 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 20 Jun 2022 10:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243047AbiFTO6i (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 20 Jun 2022 10:58:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97844193EA
        for <fstests@vger.kernel.org>; Mon, 20 Jun 2022 07:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655734908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i4NOo3bbQJ4WX15OTw4DfrOOLHUZxD7Uv5WlV81rE14=;
        b=F9hl9MYw2hjH0FfMfrooUzs8WYOpSFpNqqUvbuL8/AMxrUzCWMqMFAqhVfyblZ1ItOu1Y3
        JvuwKgeA7vXmjSlaUKt+WpsUfOf5q9ALPmkI5fAo5QNqwbFwZHMnMDjCHpaJYlBR15AZ0X
        +Ud7Wfp/R3zSidR9Ch7jkIEzetgHiTM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-133-MzPm196cNoKk1w23cmqH8A-1; Mon, 20 Jun 2022 10:21:47 -0400
X-MC-Unique: MzPm196cNoKk1w23cmqH8A-1
Received: by mail-qk1-f199.google.com with SMTP id k188-20020a37a1c5000000b006a6c4ce2623so13206207qke.6
        for <fstests@vger.kernel.org>; Mon, 20 Jun 2022 07:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i4NOo3bbQJ4WX15OTw4DfrOOLHUZxD7Uv5WlV81rE14=;
        b=xbbUpOa5HUZJ23eV+v0LEHBo6ELMkc+asUhGXnqSteX3FFvGZX/mSvpFgB4P9qafqZ
         g8uIYxnPzyVxBnf7DHgOaK3jKoneYSADE02nNSCs1UD6uxAu72YiYpjno1lo1xGwdqV3
         8YE7KbA7hWOa+z3pQKRsE6Msy357DcvEkfj6bIc9fFSEbQ51OYyA9/P0j6lTLPh1wSlf
         NmfwNFC6hIyXnHtFA1n0pN/IbjzY55y8KCyQk0T1KlsQ5PHmNVXqXdkmN9b+H2lYXDj6
         66KW63hKPSH85KO9kQu1+bYV6PECt1/cDMSUHICLtQJDQ5t5U9/ZkmgqrE8U6VBvZ47L
         H7ng==
X-Gm-Message-State: AJIora9Di/lprAb2tM5VZrijpyAzYR7Ea5mtduI4Ym6W7R+TSxBmfzlZ
        5O74/JC5aDWB/j7gMEYtdlUBa7zaQLRzK4qV2q8cu5a7z/HbyS6fhMgFzjzhn0Y2hT/139HVFrv
        zrnRs19fER+HcLO/31Q==
X-Received: by 2002:ac8:5c54:0:b0:305:1a8b:741c with SMTP id j20-20020ac85c54000000b003051a8b741cmr19725680qtj.369.1655734906965;
        Mon, 20 Jun 2022 07:21:46 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u5TWF1SDC3oXVO6ZMhLcPpQhpasH3RygocFdQCUtV28aTwVA4QKhMcNUWQJ59pUagIbWRJ3A==
X-Received: by 2002:ac8:5c54:0:b0:305:1a8b:741c with SMTP id j20-20020ac85c54000000b003051a8b741cmr19725647qtj.369.1655734906616;
        Mon, 20 Jun 2022 07:21:46 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id bs18-20020a05620a471200b006a32bf19502sm12028671qkb.60.2022.06.20.07.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 07:21:45 -0700 (PDT)
Date:   Mon, 20 Jun 2022 22:21:39 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH 2/4] fstests: make sure to unfreeze test and scratch
 mounts
Message-ID: <20220620142139.zukdj3nk4lntwtpx@zlang-mailbox>
References: <20220619134657.1846292-1-amir73il@gmail.com>
 <20220619134657.1846292-3-amir73il@gmail.com>
 <20220620111705.zmujyr3v2f5uw326@zlang-mailbox>
 <CAOQ4uxjcMiT_-0mRWz3+v2pRx+sXdG0a51E=Tt1etgOrZJXrRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjcMiT_-0mRWz3+v2pRx+sXdG0a51E=Tt1etgOrZJXrRA@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jun 20, 2022 at 03:13:33PM +0300, Amir Goldstein wrote:
> On Mon, Jun 20, 2022 at 2:17 PM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Sun, Jun 19, 2022 at 04:46:55PM +0300, Amir Goldstein wrote:
> > > Almost all of the tests that _require_freeze() fail to unfreeze
> > > scratch mount in case the test is interrupted while fs is frozen.
> > >
> > > Move the handling of unfreeze to generic check code.
> > > For now, tests only freeze scratch fs, but to be more robust, unfreeze
> > > both test and scratch fs following a call to _require_freeze().
> > >
> > > Tests could still hang if thier private _cleanup() routine tries
> > > to modify the frozen fs or wait for a blocked process. Fix the
> > > _cleanup() routine of xfs/011 to avoid that.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >  check             | 14 ++++++++------
> > >  common/rc         |  5 +++--
> > >  tests/generic/390 |  2 --
> > >  tests/xfs/011     |  2 --
> > >  tests/xfs/517     |  1 -
> > >  5 files changed, 11 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/check b/check
> > > index de11b37e..d6ee71aa 100755
> > > --- a/check
> > > +++ b/check
> > > @@ -527,17 +527,21 @@ _check_filesystems()
> > >  {
> > >       local ret=0
> > >
> > > +     # Make sure both test and scratch are unfrozen post _require_freeze()
> > > +     if [ -f ${RESULT_DIR}/require_freeze ]; then
> > > +             xfs_freeze -u "$TEST_DIR" >/dev/null 2>&1
> > > +             xfs_freeze -u "$SCRATCH_MNT" >/dev/null 2>&1
> > > +     fi
> >
> > Hi Amir,
> >
> > I'm wondering why not let each freeze related test cases take care of "unfreeze"
> > by itself? If a case freeze a filesystem which isn't on TEST_DEV or SCRATCH_DEV
> > (e.g. a loop device base on a file in $TEST_DIR), or other situations, then the
> > case still can call _require_freeze, but "unfreeze TEST_DIR or SCRATCH_MNT" can't
> > help.
> 
> That's also an option, but:
> 1. It is less robust, leaving room for human mistakes. Why is that better?
> 2. Leftover frozen fs is quite harmful to subsequent test runs, so it
> is important
>     to avoid it
> 3. Tests that freeze loop/dm (generic/459, xfs/428, [*]) can and should cleanup
>     themselves. I will add that too, but in any case...
> 4. unfreeze of tests and scratch fs is harmless even when it is not needed -
>     we may even want to do that at the start of tests run(?)

I think Dave doesn't like to add common steps to thousands of cases, if without
a critical reason. So I hope to get more review points for this kind of changes.

> 
> [*] I noticed that generic/085 which _require_freeze() does not even
>     use xfs_freeze (intentionally) - it uses dmsetup suspend/resume,
>     so I guess _require_freeze() should be removed from that test.

Agree, I think dm suspend through different userspace and kernel interface with
fsfreeze, so that require doesn't make sense.

> 
> Anyway, if you and others insist against this auto-unfreeze approach,
> I will post the patch to unfreeze fs in individual tests, but I won't be
> happy about it.

From the functional side, I think this change makes sense. But if think about
the performance, let's get more opinions at first. If there's not objection,
we can have it.

Thanks,
Zorro

> 
> Thanks,
> Amir.
> 


Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B09C433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 25 May 2022 02:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243744AbiEYCy5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 May 2022 22:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237304AbiEYCyx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 May 2022 22:54:53 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7B571A21
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 19:54:52 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id dm17so15606631qvb.2
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 19:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uZtX8zW866LfkgXWAJ0xUQHbJRtmIMSPZuk0Xz5JEmg=;
        b=EEKcg38UI99YxwSDXoQd/XB8K5VURq8ecLIROFsQ2bWu9CeJRB8toiqGosHn7LFIaU
         eOX0iVHDIsZsO+ubJ9qUzRXeeeuPxou5hAFSfsHGtlu6W5XRQa3RXsTQ2krd6/1JFloy
         pHn43ADMlY6PdwOQ1liezLljMWwTUArjwzRCfpj5aaN0gDaqsn56Oge6iKitHxxcGGNB
         bqbRI6kWSh4+1Z6VtwvZgLCY9Rva32MMF4nN/CRAGHgDyxgab1gU4OXNRkIK4Okqzbml
         AL/z1rIG65AR/Q8EJroUJ1MOGZB1U7CYbBYRdcQLCowrqdoJgH3AH2oE0SqUDOM/6gn/
         wBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uZtX8zW866LfkgXWAJ0xUQHbJRtmIMSPZuk0Xz5JEmg=;
        b=C3voftOgsRVNEHzonDYwZ2q9Cjjfuh9VjXscY1cDT+P2UDWRhEqgYcXCl2RrmMpdX0
         OkrZBo5f4pQjw6nTe9FhXnXI+FDx865VlW4mJCu235EXjACf0rSRXYVjTBolF130mHS1
         dXyaFywA16fGeNQJzt4u18fCDMPwxK6MQY+jfwEhDhLxf0iVKIZaoYtTRgiTlLI8nYhx
         cQP8h446JFZigiOAPJD95A4JUAhS0tZxEwfYpt7PTSXvGuo8vizixPdq+nidIOLRuQNG
         aVcGdoujvygN88QdO+7KaMpNB+ukO+VSpXkbLaPJg64iPogl87WSs6tAG2VdOAo7Apgs
         WkMg==
X-Gm-Message-State: AOAM530rG0kyXp9WTAg7bgmkWg11dwkm+K3+bJxkRXeOF6SbzLdeVXJ8
        Xnc91jzXuFVPT10NaJMi3v9CgopCWTpRQOqmCyk=
X-Google-Smtp-Source: ABdhPJwojomo4kAMfnkqTrGehjijzjpx2K+03bbp0Z9JGzLh2NM+4+qrTb7zDZlxzmtmBCUdcMcpGN9VZoJShJRMpBE=
X-Received: by 2002:a05:6214:1cc4:b0:435:35c3:f0f1 with SMTP id
 g4-20020a0562141cc400b0043535c3f0f1mr24239190qvd.0.1653447291042; Tue, 24 May
 2022 19:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220524073411.1943480-1-david@fromorbit.com> <20220524073411.1943480-4-david@fromorbit.com>
 <CAOQ4uxgZwngHevX_FXytAi68k=aqp_N-8Buk50rrJKD0UoK+2g@mail.gmail.com>
 <20220524122703.GL2306852@dread.disaster.area> <CAOQ4uxifd8gee1JLG1FN9fF3aSsVeSEuxFqjAf4D8ruCciXWYg@mail.gmail.com>
 <20220524132428.GO2306852@dread.disaster.area> <CAOQ4uxhWCKb8_pKU4CCE5Nv2qTqge-AyGBdoX2isrBui4cHdqA@mail.gmail.com>
 <20220524233452.GP2306852@dread.disaster.area>
In-Reply-To: <20220524233452.GP2306852@dread.disaster.area>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 25 May 2022 05:54:39 +0300
Message-ID: <CAOQ4uxhqnK4Gk=Cj4QphE6QQnjYc+hwrAmuH9g+iGAB0N+_5tg@mail.gmail.com>
Subject: Re: [PATCH 3/8] xfs/*: clean up _cleanup override
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests <fstests@vger.kernel.org>, Theodore Tso <tytso@mit.edu>,
        Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, May 25, 2022 at 2:34 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Tue, May 24, 2022 at 05:17:44PM +0300, Amir Goldstein wrote:
> > On Tue, May 24, 2022 at 4:24 PM Dave Chinner <david@fromorbit.com> wrote:
> > > On Tue, May 24, 2022 at 03:55:47PM +0300, Amir Goldstein wrote:
> > The work you did is huge and impressive and the review is not easy.
>
> I disagree - it's not huge or impressive, it's just 4 hours of
> *basic grunt work*. It's not difficult, it's not complex, it's just
> time consuming. *Anyone* can do this.
>
> The problem fstests has is *nobody* is doing these sorts of
> maintenance tasks. We keep adding more tests and with them mountains
> of technical debt, yet nobody wants to take any responsibility for
> addressing the technical debt.
>

Well said.

And it is a sad reality that xfs maintainers are the ones having to clean up
the mess. I'd imagine the xfs maintainer's pile is large enough as it is...

It doesn't have to be this way.
I have said it in LSFMM in "Maintainers don't scale" session lead by Josef
(who stood in for Darrick) - Tech companies have many filesystem developers
on the payroll. They also contribute resources to KernelCI and LTP.
I think it is a matter of communicating to our managers that full/part time
fstests developers on the payroll are a good way to meet their goals.

Coming from fstests, when I first started working with LTP (for fanotify tests)
I was amazed by the different experience:
- Several LTP developers constantly working to improve the infrastructure
- LTP developers reviewing merging and later improving the tests that you post
- At some point, I saw a statement encouraging kernel developers to post
   reproducer in any form they see fit and the LTP developers will make it
   into an LTP test

Good will of developers and weekend projects can only get us so far.
If we want fstests to scale as a project, we need to nudge our managers
to allocate headcount for dedicated fstests work.

For that matter, I also consider the work on "fstests runners'' (i.e.
fstests-bld
and kdevops) as "fstests work", because making fstest more accessible
to a wide audience will encourage more people to improve fstests itself.

Thanks,
Amir.

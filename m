Return-Path: <SRS0=VTFL=24=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75814C33C99
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Jan 2020 06:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43EA6207E0
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Jan 2020 06:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pm1FnKaU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbgAGGrY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 7 Jan 2020 01:47:24 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:47103 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgAGGrX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Jan 2020 01:47:23 -0500
Received: by mail-il1-f194.google.com with SMTP id t17so44786662ilm.13
        for <fstests@vger.kernel.org>; Mon, 06 Jan 2020 22:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JjGotJJ+i9sI7IbCxoiPyja+2LW5R3pOELxIBY0oQcQ=;
        b=pm1FnKaU7xeJEV95P6jIauvonATTqeO2bu7xHjJ1PTMbEdbwLoAZHrAW0xapLeHERX
         lzmmgBicmYxBmQ6t40JupyGwByHmMMRUDcXNBrgOM1LZ5oKOyLprwztFwEg7gup4YVq2
         Zah2xAwYlnSaucm8IzaXbVRmGfR1X+eYa6yDrKE3nuHOXRaboLiur6TMBvwIyCvqrQUW
         bofitWNgvi8z/tXXK9YyhZog/rPU6XWlG1CskijsZuatG3y7OLv9WTPtte8Jm0/wpbKN
         SIKHVo9Dp8rhf4muGa8Pc0MypnYwexrhwL5xNCEI+AFMP3m52W95cttFmfT0s9Nyb1gA
         IUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JjGotJJ+i9sI7IbCxoiPyja+2LW5R3pOELxIBY0oQcQ=;
        b=D1P9h2kOTfgiAC2nzlF/fzHn6044BEhuR4mtSXrkEJwLETm3aXB6Q53sk94W1KtxJh
         0z7Mdy6tqgg4S/VwR0V/WE6BO2JKaXrQK6Rx8yBTuYQn8OETf2b35Jty/XdG7lIG9YO/
         Nlkz4kRmr/N8fG/plEMG7O6XUsLndcRHM7Y+6BLa0IXwmYb+2Y7/zSjwfCYr6Z7G2aSM
         hLv9VgTMdoop8BRq9Kg9njw0t1C5UW3YZD1ASnWFh4F2NAdaBmH1WGy1Na91QF4kTMtJ
         86G5gxx2GbjsE7ShrIZU7ZQ92kCCZ7RFwxZSFilTIYFY0XvPks66xxtPkvsP5YWdXaDK
         cVEg==
X-Gm-Message-State: APjAAAVNCqpAqqHyOYWVO2n9qCCuPsoJYgs/M/w8dx9AFTlxZ+kfWZQE
        hqOjgyhdzWSD07B5eMGdxXmgLeSobBKCAXiX2DM=
X-Google-Smtp-Source: APXvYqxKRIpmIsYVMcVflUAoqqrv/C+OgcKfXPhx7dq08ib2Iq1X7AOUv3sgelDCrIn6XAdr3CR0MEuYCq3ebkJXDAk=
X-Received: by 2002:a92:1087:: with SMTP id 7mr59026658ilq.275.1578379643117;
 Mon, 06 Jan 2020 22:47:23 -0800 (PST)
MIME-Version: 1.0
References: <20200106070654.13249-1-yangx.jy@cn.fujitsu.com>
 <20200106070654.13249-2-yangx.jy@cn.fujitsu.com> <CAOQ4uxh91oRB03UGuqhSgASeY7-OtQD3wMRdOQ-SL0UBgdMPHQ@mail.gmail.com>
 <5E13E895.8020005@cn.fujitsu.com>
In-Reply-To: <5E13E895.8020005@cn.fujitsu.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 7 Jan 2020 08:47:12 +0200
Message-ID: <CAOQ4uxijoQugy_qqpfmyFmF4GcCOenbL7eX8d2aEEGknfe_UQg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fsx: Add '-a' option to skip unsupported keep size automatically
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jan 7, 2020 at 4:10 AM Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:
>
> On 2020/1/6 19:24, Amir Goldstein wrote:
> > A very strong NACK!
> >
> > Why are you making this change?
> > Did you read the description of the tests and try to understand the sequence
> > prescribed in the replay-ops file?
> >
> > Those are reproducers to specific issues that require a very specific sequence
> > of operations and it seems to me that 'keep_size' is there for a reason in every
> > one of those tests.
> >
> > For example, take the test generic/456, which I wrote, it has this link in the
> > comment above fsxops to a very elaborate email from Ted explaining the
> > problem:https://marc.info/?l=linux-ext4&m=151137380830381&w=2
> >
> > You cannot just remove 'keep_size' from the test because then the test
> > doesn't do what it is intended to do.
> >
> > Did you read my reply to Eryu's patch which he referred you to?
> > https://spinics.net/lists/fstests/msg08007.html
> >
> > Instead of allowing test generic/456 to run on fs which doesn't support
> > FL_KEEP_SIZE, you should change the test to*require*  support for
> > FL_KEEP_SIZE as well as require support for punch/zero/collapse:
> >
> > _require_xfs_io_command "falloc" "-k"
> > _require_xfs_io_command "fpunch"
> > _require_xfs_io_command "fzero"
> > _require_xfs_io_command "fcollapse"
> >
> > Same for the other tests that you changed to ignore keep_size.
>
>
> Hi Amir,
>
> Thanks for your comment.
>
> I had a doubt and asked Eryu after sending the second patch:
> https://www.spinics.net/lists/fstests/msg13278.html
>
> Current fsx skips all unsupported ops(e.g. punch_hole, zero_range,
> collapse_range) automatically even if they are specified by
> --replay-ops.  Is this existing logic wrong?

No it is not wrong, but this is different than skipping keep_size.
My point is that when fsx is run with some parameters and
produces a replay-ops log. If that replay-ops log is replayed with
exact same parameters it should produce the exact same sequence.

In the case of punch/zero/collapse, if those are skipped when recording
the ops log, then ops log includes the keyword "skip ..." explicitly, but
but for skipped keep_size, keep_size will simply not be in the log.

IOW, the fsxops logs that are hardcoded in the 4 tests that you changed
have all been created *with* keep_size support and *with* punch/zero/collapse
support, so should also be replayed the same way, because otherwise the test
is simply not doing what it was intended to do.

>
> I read your suggestion before, but i just have a worry:
> xfs_io commands cannot detect the supported flags of fallocate()
> correctly in one case(i.e. xfs_io commands are not supported but
> fallocate(2) supports flags).
>

That is really not a problem.
Why do you think we need to invest energy on this scenario?
Simply update xfsprogs to latest version if you want to run all the tests
in xfstests. That is anyway required for many other tests regardless.

> fsx has many test_ functions to check these flags, so we can make fsx
> call only these test_ functions by adding a option and then report "not
> run" by analyzing the generated output.
>

I think that would be an overkill.
You already have fine _require statements that you can use, so better
use them. The _require statements as I wrote them above also serve
as clear human readable documentation of what this test requires.

Thanks,
Amir.

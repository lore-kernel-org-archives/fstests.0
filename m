Return-Path: <SRS0=hCCx=6I=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5489C54FCB
	for <linux-fstests@archiver.kernel.org>; Fri, 24 Apr 2020 15:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FF3620767
	for <linux-fstests@archiver.kernel.org>; Fri, 24 Apr 2020 15:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLVMQztl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgDXP4W (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbgDXP4V (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 24 Apr 2020 11:56:21 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54BBC09B046
        for <fstests@vger.kernel.org>; Fri, 24 Apr 2020 08:56:21 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id p10so10845005ioh.7
        for <fstests@vger.kernel.org>; Fri, 24 Apr 2020 08:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AT+1BaXu+wwo3N4yUayU0mMauUAnFs/m2kqbDVJ7z7Y=;
        b=FLVMQztl/AEDH4SdVz8y4WsHJ9wBQJUfDYseKJqXKv0VGUHbW7GOvYTNYWazyloMlM
         XEt1dmEZlFLEGe2jZmOeWKawzSg9ONmskyqedsukv8BsTcJ7iJi6HijiEEKMcfwkzdAM
         zsS3lVlQ3+/FJK89V5PgtchmiAGMOjuDs5/J4M+yy9DurXelkKU7xAg0V8ty1wOpbd4B
         2KNKsoX19T55SzqgCEuDslhVmHftC8jqBhuBK+5boAWYP/bMMslwwkkaUsRnyX03sead
         Xlu4pXJxYNVMQysTuoeT4q8LTLXUAZro37QAwQUKs16/h+ZF41aMT6NdrYg482q4qm6P
         /12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AT+1BaXu+wwo3N4yUayU0mMauUAnFs/m2kqbDVJ7z7Y=;
        b=RGI6cF6IYBphNv2YF9irhjwqqyOSFZ+RHtjIVLHjj7cI2efkPLsQ3Ng7l6+lmakZi7
         fn8S1KwXCqUZTkp1YKE15cvQFK9d4iuUlM47pvEwRTb6t5BT6+zAfmAHkTsPPr97aiiy
         OoYfAyXdIuMa/PI7TmXJ2synA+ZJhYz8U+oBRjv8OI4M17stAkjgVIc/NaAKs1vLv89M
         TnA17rMNsgrv+59C1lZlJGnZ4og3J55aeNZ5IdU1LOOEReLqUhinWz6jQO12UwT7BcXt
         UC8seyQa3nDcaqOh4VBeXg3G5iENW8n2ilIzA4bCkAA3zZqUKtmDgKqF3JkqOgX9OHcV
         ALoQ==
X-Gm-Message-State: AGi0Pub8t4aabLP5ty0Vf/QEIFn7XkQfma/5AP2Yk/ZFrTI8o/vpf3Nr
        voLffaJUBT7MznAmQIIz46rx+61rc7C9VPVLlA==
X-Google-Smtp-Source: APiQypLtO00jq3oBEaxzIHF2tyl0W3cl4CjPTD8Dxbd1TaF2cqOtBpVHGuStpmXClAnqdvtoPje/Awaw8sQtVo3WYHE=
X-Received: by 2002:a05:6638:3d2:: with SMTP id r18mr9223303jaq.6.1587743780964;
 Fri, 24 Apr 2020 08:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAM2wg3RX8rKzFw+s=Z03gQpWsDcXQqhcan5vNRaw0BFz7URzFQ@mail.gmail.com>
 <CAOQ4uxhOHXFJatXqnxL1PtmMc9wzMhYR0WVj35AAvcd=DFabcA@mail.gmail.com>
 <CAM2wg3RXdmU03fxgRE-FVAreArv4C7iXrGqGRKKKMWyKG13qmg@mail.gmail.com> <CAOQ4uxiJFii0kgiR94mLzO6YfX+uooQoam0m2+oOMcLn+shFJQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxiJFii0kgiR94mLzO6YfX+uooQoam0m2+oOMcLn+shFJQ@mail.gmail.com>
From:   Arvind Raghavan <raghavan.arvind@gmail.com>
Date:   Fri, 24 Apr 2020 10:56:10 -0500
Message-ID: <CAM2wg3QV2Y67hzq4Gf43Vtrm42ChZZ6sdv6g2d24zJDDh8v3Dg@mail.gmail.com>
Subject: Re: Additional Crashmonkey Tests
To:     Amir Goldstein <amir73il@gmail.com>, fstests@vger.kernel.org
Cc:     Jayashree Mohan <jayashree2912@gmail.com>,
        Vijay Chidambaram <vijay@cs.utexas.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Apr 24, 2020 at 1:24 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Fri, Apr 24, 2020 at 12:53 AM Arvind Raghavan
> <raghavan.arvind@gmail.com> wrote:
> >
> > Hi Amir!
> >
> > We have 9 tests each consisting of several tests grouped around a
> > single operation (rename, falloc, write, dwrite, mmapwrite,
> > unlink, fsetxattr, removexattr, and truncate). The number of
> > tests and runtime for each can be varied by changing how many
> > flags and combinations of files we want to test. Some tests, such
> > as the falloc test, have so many options that they could contain
> > >100 tests and take several minutes. Is there an upper time bound
> > that we should shoot for when building these tests?
>
> No there is no upper time bound.
> It is just important to tag the tests correctly.
> Tests in group quick usually run well under 1 minute (depending on
> system and fs).
>
> Running all the tests in auto group could take several hours and each non
> quick test could take several minutes, so it is not uncommon to add tests
> that run several minutes.
>
> However, you should know that more testers run the quick tests and more often
> that testers running non-quick tests.
>
> So the quick tests that you write will end up being run more often on more
> filesystems by more testers

Ah, got it!

> > For example, the rename test contains 37 tests and takes around
> > 12-15 seconds to run, which is around the same amount of time as
> > Jayashree's initial link test took. I can send out a patch for
> > that test if that runtime seems reasonable.
>
> That would be a good quick test.
>
> I think you should also consider tagging your tests with a group
> more specific to crash consistency test.

Great! It seems that most tests that use
_flakey_drop_and_remount() are tagged with 'log' and 'metadata',
and it seems like both of those tags fit here. We can go ahead
and send the patch with the tags 'auto', 'quick', 'log', and
'metadata', and if we can agree on a crash consistency group (see
below), we could retroactively tag those tests in a different
patch.

> I myself did not tag the _log_writes_replay_log tests I submitted
> for a specific crash consistency group. I used the 'log' group
> same as Jayashree's test. I think we can come up with a better
> group name and tag those existing tests as well, probably some
> others, but I have no suggestion for a good name, sorry.

When Jayashree submitted the first Crashmonkey test, Felipe
mentioned here [1] that the test "should be in the 'quick' and
'log' groups", and that he wasn't sure if it should be added to
the new "crash" group. However, I can't seem to find any tests
labelled with this 'crash' group. Was there a specific reason why
this group would've been removed?

[1] https://www.spinics.net/lists/fstests/msg10772.html

> Thanks,
> Amir.

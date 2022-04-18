Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E220C433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 18 Apr 2022 05:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbiDRF3p (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 18 Apr 2022 01:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiDRF3l (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 18 Apr 2022 01:29:41 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0068012ADA
        for <fstests@vger.kernel.org>; Sun, 17 Apr 2022 22:26:44 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id f14so966383qtq.1
        for <fstests@vger.kernel.org>; Sun, 17 Apr 2022 22:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=/b8FS3yxOoIx5u9AhYza/WgumV0+OqzND5muTmAogKU=;
        b=U2dReivUq3ZRJbfCPUtJr6T7IDzhy+HvbaUmYYidrQGGFWzeX19kIuNhFqnh/UM6TJ
         SDX7Tyw3/6qL04dDr5RoF8Rtoe0Ke6YflDo3LddKsbckwWTaTDLjEktL3NpuSyXemoZM
         UJXZgn0Hd/fs7A0D7EoricZm3DwYrUHyCs0xaOCKCCEEpc558364rK6omUIRzWxnjNjV
         rgqiC74y5HAlRxaJkYjJ//3t5T8UB/eGdhqoAthgES3Mqje8y7KsNH8+bEH6fyYMA6BV
         rS791F1D53PjQ542GF2+Qbo1Y/TtB+XDuhYb4EP6u32DSqe1Munjw72IWL1tNlv8Xnap
         rm5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=/b8FS3yxOoIx5u9AhYza/WgumV0+OqzND5muTmAogKU=;
        b=5ZbEGSybZgjn7+0e25JrkVw763h5IO1vQ/AQ/MEZQijSjRPr1b/MAQMUCVngK2KaYW
         q2/zppSPA2blqHQKb1R7GlD9Owqcf17m3kB706dMN0h/KEftllRD56Mq1FIiXvXpslHo
         GJRRjWPIB5RfrU+LllsscTV0FuySFkjJn2oevG+LP6ShL8rjryVfvbF+dbhl4ElhsqC6
         /8B7qGCe4SiOogiqXoofN5s7xiiQwjN2uFm0AhsbrimLFLh9eaU4zK5t1o57g/OXUdkV
         XewIKuhSBP/+fly1b7j7eyYrYo0PppfxhuWelbg05nnw/HlUpoLoHMCQYelmKvo5awe/
         ymNQ==
X-Gm-Message-State: AOAM53112K5/gCsQMWLc3durgf4BAeXJl9WtlS59ZL6/VV92GcRVQvsJ
        WN5BFrqu1VZKQAPDMFcUoy8Q24SlBEIVKXP2oPUhqw5KH8w=
X-Google-Smtp-Source: ABdhPJzD8UrP9tLAMivLD3eeb3wt8pZTUEolv4KACD6VstEq9d1KPJQsXVTKVokIBlwBtdQivMDwAW0gAnDpR8+NUsU=
X-Received: by 2002:ac8:5dcb:0:b0:2e1:ce48:c186 with SMTP id
 e11-20020ac85dcb000000b002e1ce48c186mr6131559qtx.2.1650259604142; Sun, 17 Apr
 2022 22:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220417174023.3244263-1-amir73il@gmail.com> <20220417174023.3244263-3-amir73il@gmail.com>
 <20220418045226.tjzfcerypfmwybh6@zlang-mailbox>
In-Reply-To: <20220418045226.tjzfcerypfmwybh6@zlang-mailbox>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 18 Apr 2022 08:26:33 +0300
Message-ID: <CAOQ4uxign3xse8nQeE7OHz8=99igQir-EM0Tga4G_5uii1PvVw@mail.gmail.com>
Subject: Re: [PATCH 2/3] common: print hints for reasons of test failures
To:     Amir Goldstein <amir73il@gmail.com>,
        Eryu Guan <guaneryu@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Apr 18, 2022 at 7:52 AM Zorro Lang <zlang@redhat.com> wrote:
>
> On Sun, Apr 17, 2022 at 08:40:22PM +0300, Amir Goldstein wrote:
> > Introduce helpers _known_issue_before_kernel() and
> > _fixed_by_kernel_commit() that can be used to hint testers why a test
> > might be failing and aid in auto-generating of expunge lists for
> > downstream kernel testing.
> >
> > Annotate fix kernel commits for some overlayfs tests and fix kernel
> > version for some overlayfs tests testing for legacy behavior whose
> > fixes are not likely to be backported to stable kernels.
> >
> > This is modeled after LTP's 'make filter-known-fails' and
> > print_failure_hints() using struct tst_tag annotations.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
>
> The _fixed_by_kernel_commit is fine, just not all cases for kernel patch,
> some of them cover patch from userspace packages. So you might change it
> to _fixed_by_upstream_commit, then let its arguments point out the commit
> from which upstream project.
>

I thought about it too and I agree we should have _fixed_by_upstream_commit
In fact, LTP tests are annotated like this: {"linux-git", "8edc6e1688fc"}.

But I decided that even if and when we add _fixed_by_upstream_commit
we had better leave the wrapper _fixed_by_kernel_commit for brevity
because it is by far going to be the most used annotation.
I can add this helper now or it could be added later.

> The _known_issue_before_kernel() is a little ... hard to say. If it's only
> for one base line of a project (e.g. mainline), then it make sense. But if
> for lots of downstream projects, the version number will not totally
> different. Some downstream projects might backport lots of upstream patches,
> without change its base verion.
>
> If it's just used as a hint output, then it more likes a weak version of
> _fixed_by_kernel_commit. When we can't make sure a case cover which specified
> commits, then we use a big version number directly.
>
> If it doesn't aim to be a hint output simply, then we face the problem I
> said above, it just can be used for versions from one base line of a project.

That's exactly what it is. A hint.
Note that I used the release tag as the argument,
so the only difference from _fixed_by_kernel_commit is the hint text.
could have also used:
  _fixed_by_kernel_commit v4.19 "overlayfs stacked file operations"
Anyway, if one is testing a downstream kernel and sees a hint like this:

You _MAY_ be missing a kernel fix...
You _MAY_ be hit by a known issue on kernel < ...

All it is is a hint. Same as in LTP, which is used to test downstream kernels.

And if downstream kernel did backport the fix or the entire feature,
then there is a good chance that the test will pass and hint would not be
displayed at all.

Thanks,
Amir.

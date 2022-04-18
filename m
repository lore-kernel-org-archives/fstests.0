Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA51C433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 18 Apr 2022 10:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbiDRKGj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 18 Apr 2022 06:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiDRKGi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 18 Apr 2022 06:06:38 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1B917A84
        for <fstests@vger.kernel.org>; Mon, 18 Apr 2022 03:03:59 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id bb21so792500qtb.3
        for <fstests@vger.kernel.org>; Mon, 18 Apr 2022 03:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=I0YKtm3gh+WXO1p1Hd10glyeotwvydOCNnVtwUJHcHQ=;
        b=Kzq8fHWEASSTgysB8OUEGYKetGDjMmgSYv1ZO+010OyLF6SSS4FkCO1jMoGxDK/Mjs
         UMpbKREgImSKwDNKp5ghv+mZIIGbv2RVbcX717O/hvsmCmbl4lgnT3LF+3h8+r/uACQM
         Rbl8hbrl0YnCsYENTNtgh1hr84shXRtigBIZSivFYh8L7qRyZE2cWAs9pR4YEVf3ziVi
         xnx/sPeIyztnUtLNasXkUgKvEGOJhEQQeZyC4v7wsJJxpt65+a9M4jg4RnIL1kJrchNK
         JBIriXqkRJd+1lFkEureYin2203lZM63FdWSD8i45gVoH+HCE8OoOcLL49VZWlvtyH0n
         Vxfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=I0YKtm3gh+WXO1p1Hd10glyeotwvydOCNnVtwUJHcHQ=;
        b=hvIg07amnlF54AYUBsTXsNW1t1Q0tZI0NkA7SxTy74jqn1fnC4FulJ7qSx+LrYyt60
         x0iDoOmN/3D271x0kzvZAH6XvHbimArfLmbrGlJP+jA8X7tH5wCnqRS9qpFOuPJ4R/ii
         uIC3I5z7dtfj/wa59hHgTs42pvoCE/WJ4MVWjpnEZmxZr60Krn5Bw+z/3hhfeenyDpdW
         cPHtg0hL48kh/7i3xd1uSMCRFXlMpKHTLVCgMp3XIj9YnuFS7LBe8mJ/EkBzVHJO0Dpx
         fNqY/QcGndug/OF4IzMeUTlYpGhOryDXAG483kdVZ1iklUXtwWWVGlzcFf9npvyX5iXw
         T+hg==
X-Gm-Message-State: AOAM530nFayrU6CK6fdqsJTeU9D5a73rPtwCdO8KUUW4wx+fI0Napg+A
        0PdVTvauRmN6PF0jjUQJYCGSQZ31CnJ0vL/tfvg=
X-Google-Smtp-Source: ABdhPJx9nR5PJIhi11XWdTbvCqEUxdtlRLjnJLtTpqvrQA11oLqvK1B+YdY+4zi2oeU17FH3Jodj88zkiFtI3Ama8ew=
X-Received: by 2002:ac8:5dcb:0:b0:2e1:ce48:c186 with SMTP id
 e11-20020ac85dcb000000b002e1ce48c186mr6566118qtx.2.1650276238308; Mon, 18 Apr
 2022 03:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220417174023.3244263-1-amir73il@gmail.com> <20220417174023.3244263-4-amir73il@gmail.com>
 <20220418050520.h4ufi2qwz6ozpczp@zlang-mailbox> <CAOQ4uxiRA9pY1LEC8EBizYnOO1k=15dXKLsO6VdVOPwx3JN91w@mail.gmail.com>
 <20220418090609.34ynpe2fbi4ptxgp@zlang-mailbox>
In-Reply-To: <20220418090609.34ynpe2fbi4ptxgp@zlang-mailbox>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 18 Apr 2022 13:03:46 +0300
Message-ID: <CAOQ4uxiUPQ7vGwtv5FhhwmRpGTB2ULPSTPwvxDwak8bnmeiDmw@mail.gmail.com>
Subject: Re: [PATCH 3/3] common: add run option to skip tests for known issues
To:     Amir Goldstein <amir73il@gmail.com>,
        Eryu Guan <guaneryu@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

> > > I can understand above 2 patches, but this patch looks weird to me. We can
> > > give a hint to downstream testing (from upstream commit side). But deal with
> > > known issues, that's another story. I'd like to let testers from different
> > > downstream kernels to deal with their known issues checking by themselves,
> > > don't depend on upstream fstests for all.
> > >
> >
> > Not sure I understand your point.
>
> Oh, sorry I didn't explain that clearly. I mean patch [1/3] and [2/3] can be improved
> by more talking, but [3/3] is not reasonable for me.
>
> Let's see what's the purpose of _known_issue_on_fs():
>
> 1) If it trys to work for upstream mainline:
> As a hint, it can be replaced by known commit output [2/3]. As a forcibly "_notrun" to a fs,
> it can be replaced by _supported_fs ^$someonefs with a proper comment [1/3]. As a test driven
> tool... no, I don't like to make xfstests to be place which developers used to record/update/
> remind their "planning to do/fix", they can record them in other place :)
>
> 2) If it trys to help downstream testing:
> It's really helpless for downstream testing, except downstream testers maintain their
> own xfstests, and change `_known_issue_on_fs xxx` for themselves. But as a downstream
> tester, I'd like to maintain our known issues (known failures and skip list) by
> ourselves in another place, not in xfstests inside.
>
> Anyway, let's see reviewpoint from others too :)
>

I understand your POV and agree that the value of _known_issue_on_fs
is questionable, so I don't mind dropping patch 3/3.

Regarding overlay/061, it is not really a problem, I was just using it as
an example. I had already addressed the issue of this test by commit
fdb69864 overlay/061: remove from auto and quick groups

Thanks,
Amir.

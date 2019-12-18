Return-Path: <SRS0=BfoT=2I=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA8DC43603
	for <linux-fstests@archiver.kernel.org>; Wed, 18 Dec 2019 20:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB7224650
	for <linux-fstests@archiver.kernel.org>; Wed, 18 Dec 2019 20:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSDlXFNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfLRUV6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:21:58 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39834 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfLRUV6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 18 Dec 2019 15:21:58 -0500
Received: by mail-io1-f65.google.com with SMTP id c16so1928545ioh.6
        for <fstests@vger.kernel.org>; Wed, 18 Dec 2019 12:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=heRUEK9ZBfLnZIP8LFW7L1w8qzEE36r+KX0l5otDlmA=;
        b=PSDlXFNO09EKOma1edX87YtGoJElThx5jLIPul4NHJnFatEx4LqPbUs7ye/xLs4E8S
         NNo1ZxGRKb2mca8XPrBYnICa2e82ofKHVRtEfAr5sIx+gUGvrz8tX9wdKnD/anSpNb25
         KBarB4i3ISDC+7IQT0DpxwZiNm6OcVDjGHwb5NfTgUjNr3oUdwXXWmeVO/gUrr0dZ53t
         SBU1/PY9JgcQQq41CpWx7wdGXzpu7hxXOaMxMshxH3Xx+oq1qL8hzxPrM4EFOQmAzXk5
         A4ErEHKI2J3U9dQw/4J69qtr1Gve2uaoAM9FbUWR9b5P8k/SxUn79W8T4qb9Kr6mHlfB
         HD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=heRUEK9ZBfLnZIP8LFW7L1w8qzEE36r+KX0l5otDlmA=;
        b=URN/v13QIL1+aHc0vcmLJvyuK4lMmRQRlm/qxh+uAkOzVGw1KMV12TkNgON5ZNoLMm
         0KyQ/HPbCDVHWtQalcGDFgyV9EmwrP273pnbIAgEbWvtRvVVjzVzWdRAlAy4wcfoqpWE
         TaqoM/z+p6JBgOtgXTiBmOC2FyHAnk9DeVa3t23y4UaeZGuprsDGdfZ8/5MTAeu503FH
         AAtZ8Hr9hJGvM3+HTDTY3xp5rc4MRpdrG/7W8F59C9i4JgaFYFIRuuU5ZBInE8GnbxA2
         vGXXyarLY8rrDhrnGyR+JoC0dOCgXR4IlAX48iF3siFaGKpSqzwRsExwLMtvTF5Y4Ns3
         HN0Q==
X-Gm-Message-State: APjAAAVOB0b29JqyInTIbyzvRLM/kcJk/4rdtMF8WPnWaa8MBXKvBHkD
        otivx+NsYWQSCVSG9Vuofd1JV59gK8M3DFpvcIw=
X-Google-Smtp-Source: APXvYqw2joVmgx9vDqH8F45Jij7rIr4MahOVyUOhUmI8+FPTuntMN2TQJbAnOtoOVRtLlATHObVI30a/DmuRI8K5jCo=
X-Received: by 2002:a5d:84d2:: with SMTP id z18mr3315691ior.81.1576700517639;
 Wed, 18 Dec 2019 12:21:57 -0800 (PST)
MIME-Version: 1.0
References: <20190719041231.26500-1-deepa.kernel@gmail.com>
 <CAOQ4uxhxVKhUh_P_NffLbGScpiL0wOrCTLwWJWeSbRRNbHzPrg@mail.gmail.com> <CABeXuvoHw8W02JsmZjafnQkOs1=0dodSpBFyJ_Gq+1vs+hFkQQ@mail.gmail.com>
In-Reply-To: <CABeXuvoHw8W02JsmZjafnQkOs1=0dodSpBFyJ_Gq+1vs+hFkQQ@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Wed, 18 Dec 2019 12:21:46 -0800
Message-ID: <CABeXuvqO=04BJw2bWa6d2fv1FTe-B_JsNhVdYTwT=fY=ncOCkw@mail.gmail.com>
Subject: Re: [PATCH] generic/402: fix for updated behavior of timestamp limits
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Sasha Levin <sashal@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

I looked at this more closely. Here is the patch that added the sysctl
to the kernel previously: https://lkml.org/lkml/2016/11/2/300.

This was meant to be configurable earlier. That is why this made
sense. But, now it is not. We unconditionally clamp to the fs limits.
I looked around to see if we ever expose information about internal
kernel changes to userspace. This is almost never done. And, this is
always in the form of maybe a syscall failing. Given that we don't see
any modified behaviour that the user can point out, I don't think we
can expose the presence of clamping in the kernel.

fsinfo though exposes a fs max and min that could be useful if we fill
in an unknown pattern as default:
https://lwn.net/ml/linux-api/153314004147.18964.11925284995448007945.stgit@warthog.procyon.org.uk/.

I also spoke about this to Arnd, and he also suggested the fsinfo as
an alternative.

Is it easy to not run the test on older kernels? Otherwise, we just
have to rely on fsinfo being merged?

-Deepa

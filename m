Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504C0C46467
	for <linux-fstests@archiver.kernel.org>; Wed,  4 Jan 2023 19:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240225AbjADTjQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 4 Jan 2023 14:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240227AbjADTi7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 4 Jan 2023 14:38:59 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659603E0D4
        for <fstests@vger.kernel.org>; Wed,  4 Jan 2023 11:38:41 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id s5so50019360edc.12
        for <fstests@vger.kernel.org>; Wed, 04 Jan 2023 11:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DJsUcUEbvQoaJWGljNIOUTh0wsOJmkDnnEUSKMNbbrk=;
        b=EmMHVLyQ8/JNAwCMkNodPDHq7o355xLQjGuZ8td1NJMBgbiRkeFAeaXkyL9rNb27jp
         I6XjcCMNvllnb2X0HpnPuKcnn9LJSG0cLMst3ow47wnNnYWgqw7+axz60zTCeGYjDsdX
         7sDAW3b+brpD0ziFYW7iqc31uQGu4lcAr/9RQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DJsUcUEbvQoaJWGljNIOUTh0wsOJmkDnnEUSKMNbbrk=;
        b=04UnBH3Li8aiDmciGEFd3l55VVmdNWF4f4Bhm0NnoA6nCrkxLVepaV3bn76feoWaOu
         J3VIqVOXpSN2RYoLsBY8E/pULr1AXHjyBY3bVMsc35eUQRKEEZ7fsNWgXP1RhNXU/tPq
         Ost7FBiTaBDsncjoaurUII/yeOhZGL95xhT2Meh/A+bO4exotXWdN0dcQ2UUmy+oUxfP
         Sy97hqPcHYNCIpjAH+PW1eQwRidkAFXm77H9hfXNglRiGYoy5iLH9hQfPam23qy15ZsK
         ZuVcghF/znXRaj9UZdXai3+lowDNseR3WHAaeH+HQkGJGXsz8ztL1hzvCsCe2wXzlWTS
         dLAg==
X-Gm-Message-State: AFqh2kp5NErIJEWtYzml6b5Kc1cEUIILMK7CozF+O9z11bHXCO/6lFRY
        iAgxRJlrysAI4EWIN7M1cTwrtQEPY2fp5CPXm33pXQ==
X-Google-Smtp-Source: AMrXdXsbu6cEsmIhUMLkEPwUVvysp9pQo74U4SaRNWvUl+KExJD8JsY1ooAOjcXB+TN5RLbT5BPCto29t12C4zE81b4=
X-Received: by 2002:a05:6402:2292:b0:488:907c:68d4 with SMTP id
 cw18-20020a056402229200b00488907c68d4mr2923186edb.185.1672861119934; Wed, 04
 Jan 2023 11:38:39 -0800 (PST)
MIME-Version: 1.0
References: <20230103-fstests-setgid-v6-2-v2-1-9c70ee2a4113@kernel.org>
 <CAJfpegvbcQ6QTJuAW8CRGd7Zm_K4nvQCixJgD-VkcNU3d7b4Qw@mail.gmail.com> <20230104125913.ziqie73mc7paiz32@wittgenstein>
In-Reply-To: <20230104125913.ziqie73mc7paiz32@wittgenstein>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 4 Jan 2023 20:38:29 +0100
Message-ID: <CAJfpegtJaLzQ_-wUBaCLmctJ8wGQvv0Gq=8OUV6Kfkh6EjFoDg@mail.gmail.com>
Subject: Re: [PATCH v2] generic: update setgid tests
To:     Christian Brauner <brauner@kernel.org>
Cc:     fstests@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Zorro Lang <zlang@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, 4 Jan 2023 at 13:59, Christian Brauner <brauner@kernel.org> wrote:
>
> On Wed, Jan 04, 2023 at 11:53:56AM +0100, Miklos Szeredi wrote:

> > Shouldn't the test ignore sgid without group execute instead?   It's
> > not a security issue and expecting a certain value is not going to
> > help find real issues (e.g. in old distro kernels, where this test
> > will now start failing).
>
> Yeah, I would be fine with just leaving the group-exec and all-exec
> tests 10 and 12 and dropping tests 9 and 11.
>
> >
> > Yeah, doing that is more involved, but I do believe that it would be
> > the right way to go.
>
> Just asking so I'm not missing a subtlety you're thinking of: why would
> this be more involved? Seems easier to me even.

Leaving out 9 and 11 would be a good start.  To be entirely consistent
tests 1 and 3 would need to be modified to ignore the sgid bit in the
result.  That would be the involved part.

Thanks,
Miklos

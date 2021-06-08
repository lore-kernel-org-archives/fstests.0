Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32930C47082
	for <linux-fstests@archiver.kernel.org>; Tue,  8 Jun 2021 07:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09E756127A
	for <linux-fstests@archiver.kernel.org>; Tue,  8 Jun 2021 07:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbhFHHPJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 8 Jun 2021 03:15:09 -0400
Received: from mail-il1-f180.google.com ([209.85.166.180]:40604 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhFHHPJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 8 Jun 2021 03:15:09 -0400
Received: by mail-il1-f180.google.com with SMTP id b14so18343237ilq.7
        for <fstests@vger.kernel.org>; Tue, 08 Jun 2021 00:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gAvxADHMvawgBpHj3fxF3MA2Hmid1r1qCYhlMtav60M=;
        b=D6yKdC1b4iAEc/SWmKV1isUsUi4DOSNwP83RZvaSjLnSGS7NV0QcStODluK7S0NPDl
         1cf4QS6jGb/hkv2pokfrOZ4crbIDZqULzFLlmFLcm+az8YcM7ZI6dI/j4QvT2/OgAwgU
         nI86UvvlMAyBrD92vFzlk4WezFjBMvGSxEXKiVhC+NBZkEuf4kj+xd1v4fR7Ff0/+rog
         NCWm40A4OeiCCNCUoSkilgJrFH2yig/prx8RCVi2r4ujXZPnkJCXpZio+2XtzPq6cBvH
         1v/yPZ/HgNpem+tCe157U0Bl6yn9dlqowduZITi9m2dmXizg6OyDEYX069MG9bgxvTqx
         lPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gAvxADHMvawgBpHj3fxF3MA2Hmid1r1qCYhlMtav60M=;
        b=VAcFTvhQpVFltR4JXmsv7ljnKnOAh2VZc4fttM8JGdI16iC4MPWai7TJSHR1ql3E3j
         xXmw3uW037fegdM+/lvWFOxJX2jIuRyA7lE1r/IsJHYArXqgJKRsxctWxEJvUAOKzpcy
         R+JoexkdTanZdEPBf22xFA/QwgprYeKxp54QiE3HzaGc5PCg5pbmHRH8lC4fseLuxIxK
         Rs52qII4YXX5v0uftOinzfTMdRLcaj2aHkqgNkOI1yc4hDx+Oy2bQkLD9VKv+NhMCKmT
         ZSFl77mEcFtvkyfyFSrffjS2Pun7lP0ifZ/2ReHcHAS2mVA3wLhT/HhnXcoz4axZqlVr
         chQQ==
X-Gm-Message-State: AOAM531rkuCJVLPZHgAINAgUCvRR+Gc690DiL0Pl/dH8X5Jp646+N5Xj
        kP/PIkaePJ8LXOSm8AFs5SZf22Oxw4Dc/2C+0Rf34HCq
X-Google-Smtp-Source: ABdhPJy5m8QFGmTmSBQ8MQNVhlo8AqMSyX7XYbjLx/c/X1UsGcEfgTcv44wn6A0KExbyCSx8XlAH/TP5thGbEWH8rUU=
X-Received: by 2002:a92:c68b:: with SMTP id o11mr18730579ilg.275.1623136336813;
 Tue, 08 Jun 2021 00:12:16 -0700 (PDT)
MIME-Version: 1.0
References: <CABKHH71xokLUpxx4QbLh=H1rGhrOJqOwvx8ZtUOtjyLBZeGmsA@mail.gmail.com>
In-Reply-To: <CABKHH71xokLUpxx4QbLh=H1rGhrOJqOwvx8ZtUOtjyLBZeGmsA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 8 Jun 2021 10:12:05 +0300
Message-ID: <CAOQ4uxiWtx_9PnW5TDGa4CaZPY87p6mzxE4AV4CQkDCNfrom0g@mail.gmail.com>
Subject: Re: Things to look out for while adding FUSE support to XFSTests
To:     Bhumit Attarde <bhumitattarde1@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jun 7, 2021 at 9:29 PM Bhumit Attarde <bhumitattarde1@gmail.com> wr=
ote:
>
> Hello,
>
> I=E2=80=99m a Google Summer of Code[1] student developer at KDE working o=
n
> integrating XFSTests with KDE=E2=80=99s KIO-FUSE[2]. KIO is a KDE framewo=
rk
> that provides and implements abstractions for accessing various types
> of (virtual) filesystems in a cross-platform way. KIO-FUSE is a
> project that lets you mount remote locations on your machine locally
> using FUSE. We=E2=80=99re anticipating that integrating XFSTESTS with KIO=
-FUSE
> would help us uncover previously undetected bugs in KIO-FUSE and
> KIO-slaves[3] (ioslaves) as well as the various protocols themselves.
> You can read a brief summary of the project by visiting the following
> link: Integrating XFSTests with KDE KIO-FUSE[4].
>
> As a part of the project, I=E2=80=99ll be adding FUSE support to XFSTests=
.
> While a patch[5] was submitted for this, it seems to be abandoned. I=E2=
=80=99m
> aiming to build on the mentioned patch, improve & test it after
> rectifying the errors pointed out by the reviewer. Some main changes
> that I will be making are --
> I] changing $SUBTYP to $FUSE_SUBTYP
> II] removing the added check case in `scratch_cleanup_files()`
>
> Is there anything I should keep in mind or need to look out for while
> working on this?

You should address this question to the FUSE maintainer who also
happens to be the author of path [5] (CCed).

Thanks,
Amir.

>
> Thank you.
>
> Best,
> Bhumit Attarde
>
> [1] https://summerofcode.withgoogle.com/
> [2] https://invent.kde.org/system/kio-fuse
> [3] https://api.kde.org/4.14-api/kdelibs-apidocs/kioslave/html/index.html
> [4] https://summerofcode.withgoogle.com/projects/#6429306361741312
> [5] https://patchwork.kernel.org/project/linux-fsdevel/patch/202001081925=
04.GA893@miu.piliscsaba.redhat.com/

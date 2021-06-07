Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF09AC47094
	for <linux-fstests@archiver.kernel.org>; Mon,  7 Jun 2021 18:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFA0D6101A
	for <linux-fstests@archiver.kernel.org>; Mon,  7 Jun 2021 18:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhFGSax (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 7 Jun 2021 14:30:53 -0400
Received: from mail-il1-f182.google.com ([209.85.166.182]:38581 "EHLO
        mail-il1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbhFGSaw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 7 Jun 2021 14:30:52 -0400
Received: by mail-il1-f182.google.com with SMTP id d1so14080087ils.5
        for <fstests@vger.kernel.org>; Mon, 07 Jun 2021 11:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=I13EPQneEoG3DSJ4WelSaPf73gcHaWEJIaUOBeAWvV0=;
        b=cH3ugt6pUl7HaF5zLKvDJm4pLCaoEPdUNR/uZdny5PEbx+h5wEasKxQ5GRPx0HLvAL
         ONPuH6KCoOTO1dYPUOptN+2DmBvClU7F07YDdT61yoAahwa0ZdCKuGJ6E9qrseI/tYx9
         khu6d9ag0DWeB4FUhS/Yt2k7t6hiWWmEAf/nr0RSjUM5xmbv5OIFCU382/DcfgTGoll3
         /rvhxpAu8zzBqysewh0JuJEwagTkHAxopUkGSxeDs0UTyW00PeZ68Fi5OEM7/EAqfRPz
         nwJbFyNTs0Qet+bH2SDlxfXMoAIzwy8Qrgq6FtVusGfYHmSV/hIdThJTMn2ouzBF0/aW
         /vfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=I13EPQneEoG3DSJ4WelSaPf73gcHaWEJIaUOBeAWvV0=;
        b=VoUkqgpJfoO/Lxyd3hMspKvTv6yZAd3A66S8RUHYkHZGL4W1YTDAbNhL9zakugUSP0
         LzlI0bq9SPR9rUFFSwQOliUBo6U0X5ulUWAIf2gJeZj7pPEOCZAMfR3Jl4rdpILToUsH
         dyyj9s5rIFvtxnrIIa5yyt+F6dWaj4z4ojrohH18j7gHlzyg4hPcXtDbTPWH7Kkjhs4I
         pUaJfe925r72f0yYEEfJMVbMlcM93CqgqELqf6t8dTY+s1ueo1WrXuxOmFX+ZV8ixltm
         kKcaikxc6YTQAPaU9dH6S93QB59O2+l1xYxlQF89AVVbwuL3MtdcmAOhyDpU8T1Ajv6b
         ncsQ==
X-Gm-Message-State: AOAM53012Tb2/GEGAh6y121aBi954nyhS3+9o879oaWWu6Hv/O+vMJXi
        g1oXiIpezGOgyXZu5e2mUbJJqKzvpyuyb12E0C3xnvyo81nXVA==
X-Google-Smtp-Source: ABdhPJyH2oHOkJvEdr2f7hpY5eN0f4A+FXXGUA6OAhko3FFAh9/KWSXHaofkVzfQ/OpbDab5nBjQWtbqQ6UEj/LyR5A=
X-Received: by 2002:a92:d90c:: with SMTP id s12mr15934733iln.201.1623090480458;
 Mon, 07 Jun 2021 11:28:00 -0700 (PDT)
MIME-Version: 1.0
From:   Bhumit Attarde <bhumitattarde1@gmail.com>
Date:   Mon, 7 Jun 2021 23:57:50 +0530
Message-ID: <CABKHH71xokLUpxx4QbLh=H1rGhrOJqOwvx8ZtUOtjyLBZeGmsA@mail.gmail.com>
Subject: Things to look out for while adding FUSE support to XFSTests
To:     fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hello,

I=E2=80=99m a Google Summer of Code[1] student developer at KDE working on
integrating XFSTests with KDE=E2=80=99s KIO-FUSE[2]. KIO is a KDE framework
that provides and implements abstractions for accessing various types
of (virtual) filesystems in a cross-platform way. KIO-FUSE is a
project that lets you mount remote locations on your machine locally
using FUSE. We=E2=80=99re anticipating that integrating XFSTESTS with KIO-F=
USE
would help us uncover previously undetected bugs in KIO-FUSE and
KIO-slaves[3] (ioslaves) as well as the various protocols themselves.
You can read a brief summary of the project by visiting the following
link: Integrating XFSTests with KDE KIO-FUSE[4].

As a part of the project, I=E2=80=99ll be adding FUSE support to XFSTests.
While a patch[5] was submitted for this, it seems to be abandoned. I=E2=80=
=99m
aiming to build on the mentioned patch, improve & test it after
rectifying the errors pointed out by the reviewer. Some main changes
that I will be making are --
I] changing $SUBTYP to $FUSE_SUBTYP
II] removing the added check case in `scratch_cleanup_files()`

Is there anything I should keep in mind or need to look out for while
working on this?

Thank you.

Best,
Bhumit Attarde

[1] https://summerofcode.withgoogle.com/
[2] https://invent.kde.org/system/kio-fuse
[3] https://api.kde.org/4.14-api/kdelibs-apidocs/kioslave/html/index.html
[4] https://summerofcode.withgoogle.com/projects/#6429306361741312
[5] https://patchwork.kernel.org/project/linux-fsdevel/patch/20200108192504=
.GA893@miu.piliscsaba.redhat.com/

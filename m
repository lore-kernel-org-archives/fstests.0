Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042CBC433F5
	for <linux-fstests@archiver.kernel.org>; Sat, 23 Apr 2022 07:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbiDWHVI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 23 Apr 2022 03:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiDWHVH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 23 Apr 2022 03:21:07 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55717136969
        for <fstests@vger.kernel.org>; Sat, 23 Apr 2022 00:18:11 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id b189so7354321qkf.11
        for <fstests@vger.kernel.org>; Sat, 23 Apr 2022 00:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7OqGgYlGfepEOKbVK88f2uuHwYT388FEjHefIxWyV7Q=;
        b=T7VoPKwqneFRu7hoZI1OMmQO+oRC7Nda/8abLF8TB2XjNoSzIQRaXP+9yE/6wuNgpL
         YYxhBobtk6Rd/ilu2sbpJFuD0c2EvxQXGL/J/UB1LE0FFd4869jx91TmsfCH1Mj6Uoyp
         qXVHsXFQEJ+Gquvjl0cHzlpoRKbdJrvMdHAKczsTp2Cf0S8OCV024Wq/cI6ZrCpGWJEQ
         hGrpVHk4Kpg4wNHdY1q5A/inFcK105uBpFLn04l09g4LdxdW2YAEVOv0C5PWil+bpD7M
         tFS9bOyxXV556nFz0JAtM9N/rCF1susmpoCv6Ym0YlXxaHp3jm4VhTPPvPgTCiGa4Psl
         iwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7OqGgYlGfepEOKbVK88f2uuHwYT388FEjHefIxWyV7Q=;
        b=v81KNqPWQU/ilurgd6ykcM8lF0VnHVrnY6JArqdxlN67uEzuR2CgTYDxQX3P1XYfr0
         pk8CZnB4PWx3NFnaEiPYqJ9VmVbT91nPYkcvLbShaU6azb//+18fHx6U7v+lhZ2+p85Z
         43klW+P4PZkQGsrKzLj5HVUNhbzcaiwDVAOZBmNhdyUsZzFPT3sf2oGGRHTKQ+MHK3fL
         tyC/rbU02z3g1GQ+x+AggJZhn7tCsYBY3ONuxcGkpk6/NkLtMA5z4F7D3SIGsV7+EiC7
         aRyYh3mJCr3bHnjtPYHH1exNt4dDupANNf0eZdHRQr3lUfddHp4jhT47+wS2A1yLPAlI
         9gUw==
X-Gm-Message-State: AOAM532bI/81EnoV4GhVOxCqNnHSdLLFQhbovoU+I3qOYbZQSZvSFs8x
        jCOyLdi0e1WwBLuwI0ihXk9UQ+TkvcIKuGLBUvQ=
X-Google-Smtp-Source: ABdhPJxl1hoYQkwKLmAZtCEb2G4hCKNfuEuQGc9qUSpINS0H7Mw3iFAqJkuzXByryaWpxMH2cSOd8JV11MQOTLakSNI=
X-Received: by 2002:a05:620a:1aa9:b0:69e:e20e:7961 with SMTP id
 bl41-20020a05620a1aa900b0069ee20e7961mr4845995qkb.19.1650698290430; Sat, 23
 Apr 2022 00:18:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220419131423.2367795-1-brauner@kernel.org> <20220420175221.2502964-1-brauner@kernel.org>
 <20220421054120.suxfy3y7za3mgkkg@zlang-mailbox> <20220421085942.GR1609613@dread.disaster.area>
 <20220421153513.frp7xdbejsoawews@zlang-mailbox> <20220421153717.GA27435@lst.de>
 <20220421155320.agny6epqti2tcmit@wittgenstein>
In-Reply-To: <20220421155320.agny6epqti2tcmit@wittgenstein>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 23 Apr 2022 10:17:59 +0300
Message-ID: <CAOQ4uxhNskcDAuguYYkkvwrwFSw2A_s+MpJj6WcsguOSUSE7mg@mail.gmail.com>
Subject: Re: [PATCH] generic: add test for tmpfs POSIX ACLs
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Dave Chinner <david@fromorbit.com>,
        Eryu Guan <guaneryu@gmail.com>,
        Seth Forshee <sforshee@digitalocean.com>,
        Peter Jin <peter@peterjin.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Apr 21, 2022 at 9:05 PM Christian Brauner <brauner@kernel.org> wrote:
>
> On Thu, Apr 21, 2022 at 05:37:17PM +0200, Christoph Hellwig wrote:
> > On Thu, Apr 21, 2022 at 11:35:13PM +0800, Zorro Lang wrote:
> > > Sure, I won't do that wilfully, just try to ask how we can improve this
> > > huge and 'keep growing' idmapped-mounts.c, not tend to remove the whole
> > > idmapped-mount testing coverage :)
> >
> > It might just be time to split that file up into a few ones if there
> > is a sensible split.  I'll let Christian think about that, though.
>
> Yep, I agree. I think we need to at least rename it to reflect is vfs
> generic nature and then split it into separate test binaries.
> I'll think about a good approach.

The majority of test cases still do require_fs_allow_idmap and from
those who don't, most of them are variants for test cases that run
with and without idmapped mounts and possibly also in_userns.

And this new test case is no exception - there is still idmapping
involved, just not idmapped-mounts.

However you decide to break it up and/or rename the test binary
(I am not sure you must split the binary - only the source files),
I think we need to be more consistent about the groups that the tests
that run this binary are in.

'perms' group is adequate, but adding to the 'idmapped' group and
maybe also to a new 'userns' group would be useful.

BTW, the tests that use src/nsexec should also belong to the userns
group as does overlay/020, the only test that uses the 'unshare' tool.

Thanks,
Amir.

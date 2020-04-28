Return-Path: <SRS0=xPHB=6M=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FE4C83002
	for <linux-fstests@archiver.kernel.org>; Tue, 28 Apr 2020 02:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA46B20728
	for <linux-fstests@archiver.kernel.org>; Tue, 28 Apr 2020 02:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjyipefc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgD1CXQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 27 Apr 2020 22:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726263AbgD1CXQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 27 Apr 2020 22:23:16 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205F2C03C1A8
        for <fstests@vger.kernel.org>; Mon, 27 Apr 2020 19:23:16 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id k6so21238732iob.3
        for <fstests@vger.kernel.org>; Mon, 27 Apr 2020 19:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U9yuUzWOnNMqLUhbB6aG8pYA9wd6wBWmU2rAJAzKMGo=;
        b=gjyipefcLaIYjJ+OocOYKlQ6O8BRqtROCKxLs8J5va54/IByEkcZGqObpTvSSIFIdm
         W5W1nh09wZyXlzy9kRLk+kG9zsfj8Lv1U6jhniR9kvkHqO7zTj4z3x7McvyXyVu+121x
         V1boEfMH/jNv+T/w6+R/4ym/eM8Ed8vP0yZ6GbPzXzvCGsgfU4x5nLZZh/UfkpeGbDMj
         y7CKrWs8YUsxr2tSdfNhp650es8iIZnLsW0/1kfFmuY91ofmqaU8ss3Wb39tuC6D0+3S
         iLP2oZHT2Q3r7PWPG9BKFT6l6GFZwj6fhICC7ievezaDj1gyMF7K4ElrMMf9Exgb1hYn
         iqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U9yuUzWOnNMqLUhbB6aG8pYA9wd6wBWmU2rAJAzKMGo=;
        b=cRpeLwSoHfEgDUYR3Js0IkmjnaKGQBHKcTcWHmixM6iwg32UplQO/cNrpegmaohP3E
         dEASnF2AkbqutaZZ2xGvntds1FFqodrtPWuFPnL0E2St7f3kT9B8LHvBkPAJJGTtdJV+
         IJxpPPlQt6RnZZ9lh6XHJtAQRcfEVCSqOSCwv1F8JAmNw5/5MNWiOt7qtTWBvJNlYVe1
         nTnUTydGaP5EGTQeKBF4D/ee2xjKvCN9NuWrYnIvWsW+8Glm8cWQ0ky2RViDlmjQYqOj
         sAwVhuYMOjzZxy0sZxe2nHaXfc9gG7p/5wY56YyXz9ru2nAddRcD2UVE/UjfVkKSlswt
         L1vw==
X-Gm-Message-State: AGi0Publ5qrTWr+LSH13VyksFRDaSm+f9b9HbKdB3kNd007lKpH4uqrf
        3zc9vYtlVpgQz95hOvVnYUcvR3sS5RtkJbnk+DM=
X-Google-Smtp-Source: APiQypInIvTwrhgn61Sp9wqtKTXMkrPRq2KK9tdtlCfZ7AuGtu+BmT5EbF2vRbFV9wjS2xFTzHRY8VMtnojQGHOqfl4=
X-Received: by 2002:a5d:8417:: with SMTP id i23mr24095451ion.186.1588040595310;
 Mon, 27 Apr 2020 19:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200424165117.6433-1-raghavan.arvind@gmail.com>
 <CAOQ4uxi7ZgRbCUzCppmobDZ+2vAmUhzim16SmUgCMB0jYRMNkQ@mail.gmail.com>
 <CAM2wg3QmfjbAgAQLOGuLxoJwKcB2BxnEgb9LyuxF2S_Z1FFw6g@mail.gmail.com> <CAM2wg3SyE8eMNMN3mJoua0P8dprqXiAVoUhgzdND_hEmywCGXg@mail.gmail.com>
In-Reply-To: <CAM2wg3SyE8eMNMN3mJoua0P8dprqXiAVoUhgzdND_hEmywCGXg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 28 Apr 2020 05:23:04 +0300
Message-ID: <CAOQ4uxi8uUPgJmfYpbEm45U9EKQLDg-kF6mWRkfEEqz7tjgOrQ@mail.gmail.com>
Subject: Re: [PATCH] fstest: Crashmonkey rename tests ported to xfstest
To:     Arvind Raghavan <raghavan.arvind@gmail.com>
Cc:     Jayashree Mohan <jayashree2912@gmail.com>,
        Vijay Chidambaram <vijay@cs.utexas.edu>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

> > > This helper seems overly complicated for the use case in this
> > > test, but it is local to the test. I understand it is auto generated for
> > > other tests but that's not the way to go.
> > > I suggest you look into using existing FSSUM_PROG tool.
> >
> > I agree that seems like a more elegant solution. We essentially
> > have four cases that we need to check:
> >
> > (1) fsync file (meta + data)
> > (2) fdatasync file
> > (3) fsync dir
> > (4) fdatasync dir
> >
> > FSSUM_PROG works great for (3) and (4), since it looks like its
> > intended to be used only on directories. md5sum works well for
> > (2), but it doesn't capture the metadata needed for (1).
> > FSSUM_PROG has a way to print a full "manifest", which contains
> > the metadata/data hashes for each file, so I believe we can
> > grep/cut it out of the manifest output to test for (1). I'll send
> > out a V2 patch if you think this seems like a reasonable
> > approach.
> >
> > Also, see below for a note on FSSUM_PROG.
>
> Upon looking more closely into fssum, I've changed my mind. It
> looks like fssum walks a directory recursively, adding all file
> names, metadata, and data into a checksum. This is useful for a
> filesytem with stronger guarantees, but under POSIX standards,
> the only guarantees for fsycing a dir are that its immediate
> dirents are correct and that its metadata is synced, not
> necessarily the metadata of its children.
>
> Because of this, I believe it would be more readable and concise
> to rewrite this function instead of grep/cutting the output of
> fssum. I can clean it up by removing the echos and case/shifting
> and turn it into something that concisely expresses the
> following:
>
> fsync file     -> stat file, md5sum file
> fdatasync file -> md5sum file
> fsync dir      -> stat dir, ls dir
> fdatasync dir  -> ls dir
>
> Would those changes make more sense?
>

Either this or add support for single file and non recursive mode to fssum.
Either would be fine by me, but latter would make your tests overall better.

[...]
> >
> > I believe there is a minor bug in the fssum program. Below are
> > the relevant lines from the help output.
> >
> > usage: fssum <options> <path>
> >     options:
> >     ...
> >     -[ugoamcdxe]: specify which fields to include in checksum
> >                   calculation.
> >          ...
> >          x      : include xattrs
> >          ...
> >     ...
> >     -x path     : exclude path when building checksum
> >                   (multiple ok)
> >     ...
> >
> > There seems to be a duplicate flag which prevents the user from
> > passing in -x to include the xattrs field in checksum
> > calculation. This can be fixed with a simple patch that changes
> > the latter flag to "-i path", and updates the documentation to
> > say "ignores path when building checksum". I've got such a commit
> > built locally than I can send out in a patch if you think it
> > makes sense. None of the tests in the repo use the flag as AFAIK,
> > but we will end up using it for the xattr tests.

Sure. please send the patch.
Also need to fix the documentation of default flags:
"...The default field mask is ugoamCdES" it omits x.

Thanks,
Amir.

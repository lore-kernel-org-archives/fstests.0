Return-Path: <SRS0=PVdF=5B=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B137FC3F2CE
	for <linux-fstests@archiver.kernel.org>; Mon, 16 Mar 2020 14:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC7C20663
	for <linux-fstests@archiver.kernel.org>; Mon, 16 Mar 2020 14:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="cH0GpFi3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731331AbgCPOBR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:01:17 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:47060 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731388AbgCPOBR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 16 Mar 2020 10:01:17 -0400
Received: by mail-io1-f67.google.com with SMTP id v3so17175007iom.13
        for <fstests@vger.kernel.org>; Mon, 16 Mar 2020 07:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vGFrbL84qNZ1K2nsUs/vYKrsSu89jm2YKljwoZKFFeg=;
        b=cH0GpFi34twJL1JB6pfLn9hJck2UemFugAB6qp/6Q33NJt835WeS5KO29SQxX8dldH
         AGqIJf8GyGlmuNwUzBBSQCrp14X0S7oPkooHXYGaoVy5iqJ3yfs9xJCyeA0+twHTQWkx
         f358UhMAt1rXyJHKlkhXvGF5vAr4unJGs0m5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vGFrbL84qNZ1K2nsUs/vYKrsSu89jm2YKljwoZKFFeg=;
        b=mJ8KPa/lWiblgLjzVxRTVxGBKhjK0fv7P0rKBhct8LtaAVEmjNJlibRibfIEiGySoF
         aDmAoFEK0oGBbxJSN0XmVTK3Rm2vckdNalbEyxIKIIE1xpNNeTGMww8/fvAbH+qsqdWI
         o1y0Ml/Se6berXALgfhcDU5gBH6ZpxvcEHuMXcqV3KCHdxCNrWRRoYLk/cnUBFXYSzlm
         BONpWk4a4AgXvrCLeb+26AjZ+Pn9FyzkzUMSzuEtNzyf94gvpmj9TgYAsK3nbSGnuezd
         8KFF/nMI6DXR0OKYx6GJa147+erAJCHSn0iF9yFyd+3kFVi7vdf9488AtdeEjQUjWDNk
         KWnw==
X-Gm-Message-State: ANhLgQ2Lz8SL9h8ewr0v21hd6XDlD00qloB8KinVYC779PLoRwLPgC0v
        wXSlgT8Vri9m9XqIQ++uDZaZtOgYrpaNTR4NI1eNEw==
X-Google-Smtp-Source: ADFU+vuYjhHSXepOJpDT4joP8mHHjOPqbOr/hOLLWkFnKDmhDakXpU11BzwCeNQtZ39NKC9bQh4vwwzcIXj2ZxbOy6E=
X-Received: by 2002:a02:6658:: with SMTP id l24mr23883jaf.33.1584367275851;
 Mon, 16 Mar 2020 07:01:15 -0700 (PDT)
MIME-Version: 1.0
References: <20191230141423.31695-1-amir73il@gmail.com> <20191230141423.31695-5-amir73il@gmail.com>
 <CAJfpegvHAq+yT1qW4JqTBpviCHUrQqOPMfWEcvhy4Jpr2bLJfQ@mail.gmail.com> <CAOQ4uxiANoiXhdbXMYLsttAHB9nrh_9vMn3z8usS46=H54QJ3A@mail.gmail.com>
In-Reply-To: <CAOQ4uxiANoiXhdbXMYLsttAHB9nrh_9vMn3z8usS46=H54QJ3A@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 16 Mar 2020 15:01:04 +0100
Message-ID: <CAJfpegu3574yJ2nG6xNZQv0bQRUQJtpBeYsZS1K3_e7JdwjUvg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] overlay: test constant ino with nested overlay
 over samefs lower
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Eryu Guan <guaneryu@gmail.com>,
        Jeff Layton <jlayton@poochiereds.net>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Mar 16, 2020 at 2:52 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Mon, Mar 16, 2020 at 2:29 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Mon, Dec 30, 2019 at 3:14 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > Also test that d_ino of readdir entries and i_ino from /proc/locks are
> > > consistent with st_ino and that inode numbers persist after rename to
> > > new parent, drop caches and mount cycle.
> >
> > overlay/070 and overlay/071 fail for me like this:
> >
> >      QA output created by 071
> >     +flock: cannot open lock file
> > /scratch/ovl-mnt/lowertestdir/blkdev: No such device or address
> > ...
> >
> > I.e. there's no block dev with rdev=1/1.
> >
> > I don't see any other way to fix this, than to remove the device
> > tests.
>
> I ran into similar complain when I worked on generic/564.
> Apparently, this is not the first test that uses rdev b/1/1 and c/1/1
> so not sure how those tests work for everyone.
> In generic/564 I used a loopdev as blockdev and /dev/zero as chardev.
>
> > Why are these needed?  Is locking code in any way dependent on
> > file type?
> >
>
> Not strictly needed.
> See that they already skip file types fifo|socket|symlink.
>
> But note that we are not testing locking, we are using /proc/locks
> to get a peek at i_ino, so if we skip also blockdev and chardev, we
> end up testing no special files at all for i_ino consistency.
> Not the end of the world, but then again using loop dev and /dev/zero
> would be quite trivial as well.
>
> If it bothers you, I can post a fix.

Using /dev/loop and /dev/zero sounds good.

Thanks,
Miklos

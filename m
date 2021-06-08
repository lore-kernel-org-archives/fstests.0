Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AE5C47082
	for <linux-fstests@archiver.kernel.org>; Tue,  8 Jun 2021 07:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A4C161285
	for <linux-fstests@archiver.kernel.org>; Tue,  8 Jun 2021 07:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhFHHaq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 8 Jun 2021 03:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhFHHap (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 8 Jun 2021 03:30:45 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C3EC061574
        for <fstests@vger.kernel.org>; Tue,  8 Jun 2021 00:28:37 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id q2so2975688vsr.1
        for <fstests@vger.kernel.org>; Tue, 08 Jun 2021 00:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TfxTI/u+oyNcGhkNgJY7nBcLKh+FDXL1c15OJp4yHzQ=;
        b=Ow2hJbZlbMQZiL3SSXgo+vRQrO/+SeMo3NfxRQJcXc4QNpQN8BHByCSMmqDjjPRafQ
         br6834QGSPCpf9twz75co2CFLGY8anLSYJ4bz57vELvbgBLoIAfw4RdzeO7bim371tDp
         R4/plz0sdaeSXNfYIAiQRQRL76hKf8ffS+Dt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TfxTI/u+oyNcGhkNgJY7nBcLKh+FDXL1c15OJp4yHzQ=;
        b=sd0SxYG0dZB7mTteyjjk3gMzBnnrZXiX53PXXwt3HCCZkl8Y5/bfPzoBlUgyKPe6t2
         RoG7+krFcTfjLAB9FN9E5o66VL5GuIgfJukusb0gDRijQSmaVpd3W3zoDluu/pXLZBOq
         jqhHKEuk4z1nS0cIliukSmGVw2RqDH4vfWqDF/FP2pKKg9JclmAYCpdcFwd6G8Vkpaxi
         oEnZADA6DkqIwUdabk7Fx+9JkW7UdAkKRH5yRlhjD8tQVkoO0MCIDEhBV2YKBkxLIHli
         UxMolPPg4VVYrRu444Z3ocnh15GTNq7rH4dk1OorjspF4X3mS6aG0VLtAFNTAc8YF++M
         I07g==
X-Gm-Message-State: AOAM5329pkqJex+Ge1B8ZcPTTKim10XC51D6Le+aHZB+xh2EyyQ25mLO
        R48piccqtnfwv3hrDoPcYB2kbit+rR4ySdG24MxKPw==
X-Google-Smtp-Source: ABdhPJzf63alQGosrMyzxWN0AW4P3nTyN/5Aiz3XSRSb6vTkT4ayBzE8Lvd4QBTNJxq0rz6lTNTg2BWWPs+uYMitJS0=
X-Received: by 2002:a67:5e82:: with SMTP id s124mr5161659vsb.9.1623137313931;
 Tue, 08 Jun 2021 00:28:33 -0700 (PDT)
MIME-Version: 1.0
References: <CABKHH71xokLUpxx4QbLh=H1rGhrOJqOwvx8ZtUOtjyLBZeGmsA@mail.gmail.com>
 <CAOQ4uxiWtx_9PnW5TDGa4CaZPY87p6mzxE4AV4CQkDCNfrom0g@mail.gmail.com>
In-Reply-To: <CAOQ4uxiWtx_9PnW5TDGa4CaZPY87p6mzxE4AV4CQkDCNfrom0g@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 8 Jun 2021 09:28:23 +0200
Message-ID: <CAJfpegvo9nahb+Lup6bqKjVT9mo2fGRq2c0jn_2yu5rqqSgtqw@mail.gmail.com>
Subject: Re: Things to look out for while adding FUSE support to XFSTests
To:     Bhumit Attarde <bhumitattarde1@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, 8 Jun 2021 at 09:12, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Mon, Jun 7, 2021 at 9:29 PM Bhumit Attarde <bhumitattarde1@gmail.com> =
wrote:
> >
> > Hello,
> >
> > I=E2=80=99m a Google Summer of Code[1] student developer at KDE working=
 on
> > integrating XFSTests with KDE=E2=80=99s KIO-FUSE[2]. KIO is a KDE frame=
work
> > that provides and implements abstractions for accessing various types
> > of (virtual) filesystems in a cross-platform way. KIO-FUSE is a
> > project that lets you mount remote locations on your machine locally
> > using FUSE. We=E2=80=99re anticipating that integrating XFSTESTS with K=
IO-FUSE
> > would help us uncover previously undetected bugs in KIO-FUSE and
> > KIO-slaves[3] (ioslaves) as well as the various protocols themselves.
> > You can read a brief summary of the project by visiting the following
> > link: Integrating XFSTests with KDE KIO-FUSE[4].
> >
> > As a part of the project, I=E2=80=99ll be adding FUSE support to XFSTes=
ts.
> > While a patch[5] was submitted for this, it seems to be abandoned. I=E2=
=80=99m
> > aiming to build on the mentioned patch, improve & test it after
> > rectifying the errors pointed out by the reviewer. Some main changes
> > that I will be making are --
> > I] changing $SUBTYP to $FUSE_SUBTYP
> > II] removing the added check case in `scratch_cleanup_files()`
> >
> > Is there anything I should keep in mind or need to look out for while
> > working on this?

Thanks for picking this up.

I don't have any requirements except that it should work with the
passthrough filesystem found in the libfuse3 source.

Cc'ing fuse-devel to keep the libfuse maintainer in the loop as well.

Thanks,
Miklos

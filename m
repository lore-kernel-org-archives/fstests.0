Return-Path: <SRS0=nTdV=YV=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD56CA9EC0
	for <linux-fstests@archiver.kernel.org>; Mon, 28 Oct 2019 14:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FF9621721
	for <linux-fstests@archiver.kernel.org>; Mon, 28 Oct 2019 14:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VICyGjd6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390116AbfJ1OeY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 28 Oct 2019 10:34:24 -0400
Received: from mail-yw1-f45.google.com ([209.85.161.45]:43184 "EHLO
        mail-yw1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390052AbfJ1OeX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 28 Oct 2019 10:34:23 -0400
Received: by mail-yw1-f45.google.com with SMTP id g77so3832242ywb.10;
        Mon, 28 Oct 2019 07:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rtlMkjR64JJLwLZ/TIFBO0e8u0IR5VRrgIWglRLqZPc=;
        b=VICyGjd6V62n/KZ7RRHun+sgNYrZut2XCbE+vMWM8U3akDsp3kupIjqoUDqg2Bq4aG
         vsJgZ+TSieqzxQdWHcE84WWHXupKeo3eoXX67NwcpXw/3W4Fs+OcV2nql1O37WTgsVln
         fF+KN8nK8UbGXVBD0kYXxHkfWcG8EFHifZA8eYDDdZ/sVV5Q1ZVonjHcWDLn/rV6I+mv
         C62tiD4ShXoVj9XPbWxQRjqXGng1h2+RXBfYBVp5r/23cccMc+c5UzXrzaiislMxkVqM
         qxprAqMCzfXWElAwCdqTY1w8ksZMd6I/IQEDGv6jQ4RMMyQzjgU20exxVohMEw2l/J4k
         GZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rtlMkjR64JJLwLZ/TIFBO0e8u0IR5VRrgIWglRLqZPc=;
        b=PgMmb9sS3r4oQn0OV/72o+4BHBlEWs4HGEdmsZWEkp2DTt+DGsvAmQoyYnELYX9xnu
         6kbgjR4od0KSwvVYIm++YDUQp34864Ib3g/XNyZAR/Gtzzqy1SNHWSmFlknFLjo6//I5
         BBuAK87ScHW7QZdb3HpZ3vxj2C2xs0c1ZPiccuEcq1nit0nkzjW4+DfRp4B7iUuqD3Ii
         XwtAO92AZYF3gdqtczq+fnq+vDe8ZmtATrqutJE+R8gzVXASyZWVUB1DHB20Rup7PhqD
         9HEHb3pF0H1g3makkFL/lDjq25407Yucjn+LUTmsFgcfVP8muYk2hCyfi3dojhNGFViv
         StFg==
X-Gm-Message-State: APjAAAX3WgFkKa0r6uvUbuFXjrinMydsvgUQ7BQ0gGQTLMC9KVseb1Qo
        w59Z7xNx1uC2G/Htb8n+vXOW7MLFp6nN8hdFvEw=
X-Google-Smtp-Source: APXvYqxp2svHkjweKKG+jdQQkVJe4plmW1sW0Uhrhl3k9N+S/B2KcLcEuCkLBbpp+sH8NsKfjEnmcwPOtz9HpZEH2QM=
X-Received: by 2002:a0d:e347:: with SMTP id m68mr12940543ywe.181.1572273262738;
 Mon, 28 Oct 2019 07:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <20191024122923.24689-1-cgxu519@mykernel.net> <CAOQ4uxidZ=g29hGmKxinRA4Gp6CiWbOB9RqLWPPFXwtCB4DWog@mail.gmail.com>
 <16e007f78f9.12a9e815231850.7849365151361114799@mykernel.net>
 <CAOQ4uxgZDKnMGB3pbCJpyH_RxWzbEHLQMB2Mpc10PK=7=xYLOg@mail.gmail.com>
 <16e1244e1c9.ccaa038637864.8395134351025208019@mykernel.net>
 <CAOQ4uxjFvTTbKRW1BChnzfNSqg1yeyM3gjwjZ77i161D_XLFRg@mail.gmail.com> <16e12b4c2d4.107038d9f36138.3957762737837230842@mykernel.net>
In-Reply-To: <16e12b4c2d4.107038d9f36138.3957762737837230842@mykernel.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 28 Oct 2019 16:34:11 +0200
Message-ID: <CAOQ4uxiw2EoeEW4bDCAYypaVZM9Ecqz1w=HHrM4KLaXfZNBNgw@mail.gmail.com>
Subject: Re: [PATCH v3] overlay/066: copy-up test for variant sparse files
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     fstests <fstests@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Eryu Guan <guaneryu@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

>  >
>  > Not sure. I don't think we should target the test by what we know your
>  > patch does, but by maximizing test coverage in a cost effective way.
>  >
>  > Creating a 10M file with so many small holes doesn't add much to test
>  > coverage IMO. If you feel those are needed, you should use a C helper
>  > to create those files more efficiently.
>  >
>  > BTW I think what is missing from test coverage is small holes
>  > that are not aligned to 1M boundary.
>  >
>
> Agreed.
>
> So how about change test pattern to below, it will cover  most of the
> cases that we want. I haven't done test for the performance(test time)
> but I think it will be fast enough.
>
>
> One 4K empty file.
> One 4M empty file.
> One 10M file with random small holes (4K~512K)
> One 100M file with random big holes (1M~5M)
>
>

It sounds like a good addition, but maybe lets keep
the files with aligned holes iosize*10 in size?

Thanks,
Amir.

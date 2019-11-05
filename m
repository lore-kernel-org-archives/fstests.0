Return-Path: <SRS0=5Vws=Y5=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F34CA9ED9
	for <linux-fstests@archiver.kernel.org>; Tue,  5 Nov 2019 07:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC84F2190F
	for <linux-fstests@archiver.kernel.org>; Tue,  5 Nov 2019 07:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bbngnve/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387648AbfKEHhs (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 5 Nov 2019 02:37:48 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:35133 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387484AbfKEHhs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 5 Nov 2019 02:37:48 -0500
Received: by mail-yw1-f68.google.com with SMTP id r131so1419019ywh.2;
        Mon, 04 Nov 2019 23:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rs5hDOsCMZ8VwYEEKd43QfYPUoGpSsM00GrQHPGwTj4=;
        b=Bbngnve/DbUa3XvI/pzlaJjNgPnJ80WYnC0+mtFPw1XrIaQ6MiNmJOU2xowDuYbUgU
         LWLvPRz8xBQQYcSTsYxnZRvrOjQOppjbySJlB8QEwBQxlHbz2Bf7OGFRixwV0Jmtd5gK
         4OeEj/QjXcVMf0AVmA+6cv3GmgcuX34PezgRR5Fmp/ghqvsvo77Bey/Ob2fVI8S0lZ/d
         8MqZtfJ4ukjWZrLKLtJKohkQvuFubH79q6lzEWqdto2z8BSEqMJyFxPjO284T97YYTcC
         PV0F9865/zzpDONiIDs3LUbifUcQLjrzuhaWgx2lh9HqIAhHv8WXiSiCLjkIqC1JCmfs
         sLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rs5hDOsCMZ8VwYEEKd43QfYPUoGpSsM00GrQHPGwTj4=;
        b=iKOyKchEVAg91itLQMCHO3aneD1bQ5QpZv0uv7JTZp6CqVSu866OKhSiSJTIOUY0lW
         sSIJsscPM/0lfRUj6N5oXKs1kkm0ahu/gKA0fUQQfDinTpkIE6WIJxDS1EYzfBFAY0Hy
         mVg3EmELCZ6gj9IpRFy8xHdh8iIMX+lXr6BNmJNlJXZ769GOo3vfJ9ZWmj6UKo+Nxb+6
         ZOmM3a+CNGg4WTcfdypNSFCYaanuAjbt2tM5Ynwt8x1OejB7wcLt+4zlDjuGhPJY1XfE
         7oqXZqfMUaoS30P2WEl54aFWWO1ot1ncmJVi7a+26ngkAYYely0gYwqEuCdYBFFIbfdG
         PByg==
X-Gm-Message-State: APjAAAUMDeFCoXt8IuicNN82HtsoC7ciqPNYjnf+ReWVtSA06LlNDl6S
        R3OUdxpDRmgDCv5r8MA4dkKJ2IACxQEdsHftaZo=
X-Google-Smtp-Source: APXvYqzwYekNamlnElt+M/OD/aeEgGTpHTJkeHZMMO/49Gwxx07WnZDn3L6DtKNFPy4vhN2jb6IfkIzwdX5bnKuXt9U=
X-Received: by 2002:a81:3187:: with SMTP id x129mr24775416ywx.294.1572939467105;
 Mon, 04 Nov 2019 23:37:47 -0800 (PST)
MIME-Version: 1.0
References: <20191029055713.28191-1-cgxu519@mykernel.net> <CAOQ4uxgzZHXOv7K++BArYmaTEHbYr5oCkgXw8WVUsQgh0uyqhg@mail.gmail.com>
 <16e173c434a.11f8ced8d40796.3954073574203284331@mykernel.net>
 <CAOQ4uxjddbot29=cYqLMLyqT=w=pWmLOPqVzvi-5mcXQ3AB3EQ@mail.gmail.com>
 <CAOQ4uxiZgmA6Z8Lq=ac7O9f1+CMnSmyLoAA7TDu6Hyt=-pUctw@mail.gmail.com>
 <16e1afc4097.118c98c8b43000.1263688409904269456@mykernel.net>
 <CAOQ4uxjqMTFc-Fmpg3oGChy01X2JzQoG_jqxk5iEz+bR4yoQjg@mail.gmail.com> <16e3a265656.134a9f8341853.6895214917865048335@mykernel.net>
In-Reply-To: <16e3a265656.134a9f8341853.6895214917865048335@mykernel.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 5 Nov 2019 09:37:36 +0200
Message-ID: <CAOQ4uxhOM7XdmE2hTn=H_trR-Qx1GGdWrN0GmLJ9dveAySMJ2Q@mail.gmail.com>
Subject: Re: [PATCH] overlay/066: adjust test file size && add more test patterns
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

>  > There is a difference between understanding what happened and
>  > reproducing, but there is no reason to choose one method over
>  > the other.
>  >
>  > As a developer, when I get a bug report I would rather have both
>  > an easy reproducer and all the postmortem  information available.
>  > Therefore, please echo xfs_io commands, at least for creation of
>  > random files to full log AND filefrag info, at least for the random
>  > files to full log.
>  >
>
> Actually, xfs_io itself will leave detail information for write operation (pos+write size)
> See below, IMO, it is almost no difference compare to echo xfs_io command.
> So I just added title for those write scenarios in v2.
>
> ---
> iosize=2048K hole test write scenarios --- (This is what I added in v2)
>
> wrote 2097152/2097152 bytes at offset 2097152
> 2 MiB, 512 ops; 0.0007 sec (2.732 GiB/sec and 716083.9161 ops/sec)
> wrote 2097152/2097152 bytes at offset 6291456
> 2 MiB, 512 ops; 0.0006 sec (2.889 GiB/sec and 757396.4497 ops/sec)
> wrote 2097152/2097152 bytes at offset 10485760
> 2 MiB, 512 ops; 0.0007 sec (2.728 GiB/sec and 715083.7989 ops/sec)
> wrote 2097152/2097152 bytes at offset 14680064
> 2 MiB, 512 ops; 0.0007 sec (2.778 GiB/sec and 728307.2546 ops/sec)
>

It's good that you added the titles, but not enough IMO.

It is a social engineering issue, not a technical one.
It is *nicer* for a test to provide a reproducer, than to provide information
that needs to be converted to a reproducer by a developer.

And the main reason to be *nicer* in this case, is that it is zero effort
for the test writer to provide the report in the form of reproducer, simply
by echoing the xfs_io commands via a helper, (e.g. do_io).

Please understand that most of xfstests are reproducers by themselves.
Some random tests (like fsx/fsstress) leave a recorded log of operations
to be used to reproduce a failure.
Some random xfstests log the random seed to log, so it can be used to
reproduce.
In any case, leaving a *simple* one to reproduce a failure is essential.

Thanks,
Amir.

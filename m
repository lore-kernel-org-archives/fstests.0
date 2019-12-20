Return-Path: <SRS0=LJOt=2K=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D337C2D0C0
	for <linux-fstests@archiver.kernel.org>; Fri, 20 Dec 2019 12:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D71EF24684
	for <linux-fstests@archiver.kernel.org>; Fri, 20 Dec 2019 12:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pnZNu6b+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfLTMcY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 20 Dec 2019 07:32:24 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:36121 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfLTMcX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 20 Dec 2019 07:32:23 -0500
Received: by mail-vs1-f66.google.com with SMTP id u14so5943016vsu.3
        for <fstests@vger.kernel.org>; Fri, 20 Dec 2019 04:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=PXJ498Qsx2iWIyDygy5JD9PUgu7++rtiran6c5tCI6w=;
        b=pnZNu6b+6iUwvFfc3ldldRZayMH0Ced3TcxownpZ+xkzTAq/SsGUT3BQ32sXOvUpDX
         E6LG6BtTF/xbuiKa184Y1TAuecuDNLyQNprLsVMlV16TatlBjtYkcowtMZvujA+IA2T/
         Af+H3B2XCH09DfSqx0XOpNeMKpXrdZ+JWjTKRUAGC4AUFHtroswuC4vFHJRXeKXd9F0r
         sSq68glUC2XxZKxGJI9tfjDjYnUqSrDal5fzx73E70ooFHAMJnpHW1pDEHvVC/aXMzk9
         Ta0+VWxywkWdJuEwBg66QUOFn0aYGpSYuVBc7xBCWukYIU9eDGuIWZ7gUoiQsTF6ilT6
         jCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=PXJ498Qsx2iWIyDygy5JD9PUgu7++rtiran6c5tCI6w=;
        b=hAU5UTQtZ/m3X/7GIvDf8CSjGGN52DcsPvdOL81eYVbY19K6vqEGD9AJKVMUtH0EBI
         sQpo20YuXR6WvwV8AEU7cfoiAjrA2uBPdtaVpYK4l+ZOnGuCCIxQIWpEEZEmmf1WDebg
         iHq41ynhbdXDU3abgHxrEaIZT62zucBJiDcDu6AWSbs0GRrD5FZHHT57u1x6FkrT4j02
         h4b2hEaOvd7Ymi9IacG7uf6lHWrGDjHzWb1D34dc5FJYz7AoEOuCtKSaU8bXDaxtxP6t
         XkF30DEpPJYQknMepjXoQgKi41VBPSQ1HQmAgwgP6rfoGWJQe9i5p17dxv7LG1nhPw6q
         +ThQ==
X-Gm-Message-State: APjAAAV1GFB3A0iYMs+WExVw+PLWuFOQ19O2SrIYA4X8ELeJXlqTVo5l
        1PFO4y7XJtJSz/ux9NSB0l6qQNscMHLv5dHvBrWOyw==
X-Google-Smtp-Source: APXvYqwXU6Tl1866TEF0nWXMKXglPUVPKg5It1wAcpSeetOlwh5J+j0Ock6j4Aa1DulKZOOL4ogy2OY0choU9Jbxb40=
X-Received: by 2002:a05:6102:18f:: with SMTP id r15mr8206024vsq.206.1576845142514;
 Fri, 20 Dec 2019 04:32:22 -0800 (PST)
MIME-Version: 1.0
References: <1576215941-19208-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
In-Reply-To: <1576215941-19208-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 20 Dec 2019 12:32:11 +0000
Message-ID: <CAL3q7H6ZNui6MbvBwXq1bAk5tLgxUjAv+QgRUju0veqwxMmPOA@mail.gmail.com>
Subject: Re: [PATCH] generic/520: use fsync instead of sync during clean_dir
To:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc:     fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Dec 13, 2019 at 5:45 AM Yang Xu <xuyang2018.jy@cn.fujitsu.com> wrot=
e:
>
> When I test this case on xfs, it may fail as below:
> --------------------------------------------
>  =3D=3D=3D link SCRATCH_MNT/A/foo SCRATCH_MNT/bar  with fsync SCRATCH_MNT=
/A =3D=3D=3D
> +umount: /mnt/xfstests/scratch: target is busy.
> +        (In some cases useful info about processes that use
> +         the device is found by lsof(8) or fuser(1))
> ---------------------------------------------
>
> I think we don't need to sync all fs and fsync SCRATCH_MNT is enough.

It's indeed strange, and suggests something is still using the
filesystem when trying to unmount it.

I've never hit that problem (I usually only test btrfs), and a loop of
100 iterations running this test has never reproduced that issue (or
any other) for me.

Instead of fsync, I think you can simply do nothing (just remove the
call to 'sync'), as the unmount is supposed to persist the
file/directory removals.
Does the problem reproduces this way?

thanks

>
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>  tests/generic/520 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/generic/520 b/tests/generic/520
> index 167d7077..a16467ca 100755
> --- a/tests/generic/520
> +++ b/tests/generic/520
> @@ -58,7 +58,7 @@ clean_dir()
>  {
>         _mount_flakey
>         rm -rf $(find $SCRATCH_MNT/* | grep -v "lost+found")
> -       sync
> +       $XFS_IO_PROG -c "fsync" $SCRATCH_MNT
>         _unmount_flakey
>  }
>
> --
> 2.18.0
>
>
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D

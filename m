Return-Path: <SRS0=b8ZK=3W=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE372C35249
	for <linux-fstests@archiver.kernel.org>; Sun,  2 Feb 2020 15:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A039A20658
	for <linux-fstests@archiver.kernel.org>; Sun,  2 Feb 2020 15:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOeCTq2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgBBPU2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 2 Feb 2020 10:20:28 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:42923 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbgBBPU2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 2 Feb 2020 10:20:28 -0500
Received: by mail-io1-f68.google.com with SMTP id s6so3457181iol.9
        for <fstests@vger.kernel.org>; Sun, 02 Feb 2020 07:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DFOFvtIGy1UY3lZiFay8F8yixFKOV18Q53unwpZHZFE=;
        b=DOeCTq2eV7micjW9p23sJmgvb84WI5cX2rye40XMJoRnBLQDimgg0+OzyYfkcMEMja
         ztbZ4d729xx9iMYgZg8oYV5HhlXHnmFnp2xVQ46rw+Sgqp5uvCxGvWVipE/a95OLslPz
         EF/Qlm7BW8zuo6PecVFGCsoPTW0tmBIHFdZHQK7GeCXGcnVMstzsGRPfAkAOpb7H5KV/
         ZMm3cqiagjl7jlQ2eQxU6zHzd671cGAj21RzgKVEFrJzwYk/GJ9qF1PppT5Ugh819bfB
         riVtwQi6DedRfvkGEAa6iZKORd5NUSlqHq2vti7EP2GfHoz/3Atia7nx2IN262N28C9/
         5Yng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DFOFvtIGy1UY3lZiFay8F8yixFKOV18Q53unwpZHZFE=;
        b=dl5RQuyV6lcgXpSrH/R7nDavMhYvBU/Y9ztjisa1/OIF+3eHR678iFU+k9TxqKr2AH
         IVhlZl2tO0O6YSGN42idm0TbXMeLtxkhTk2KdfVIwKnCzYf4X8FbXjXNFBHolOpakaiQ
         2zNXp0gNCmu32TBNG+WxXWqyCDyGSl9YGJ2UrLJZ5wN0uQ3fA/ZeMxppaYWO4znAELCP
         jCsY4kGtBvsL8YUUsJ40ezzMrs4nvHUs1q2m9EpaWsSwjIjTr6lObyhxmb/nrR0UrVao
         v1oSQkPR4+iYM1kxHZRWhWMBd6hV03LcBbeKLPSAATaYihuQ78S15NgL4f3jblSkd1hQ
         Estw==
X-Gm-Message-State: APjAAAUvFqoV2cRcr6QDoS6/8UksvjSaUA0JTNFEwflOyXVNRD11OkiV
        RFt7k4Bq/f1oWRAHVgfwIE03xEH4rmk5ysuKuXE=
X-Google-Smtp-Source: APXvYqwq3EGpgyPmrIvDVyfnyQY8oknbcWguIb+IvXCfGMlhttdo96jiS7hVxIzXIsDKTZdYIlyqrtUR0YK5G5SILe0=
X-Received: by 2002:a5e:a616:: with SMTP id q22mr15804898ioi.250.1580656827126;
 Sun, 02 Feb 2020 07:20:27 -0800 (PST)
MIME-Version: 1.0
References: <5e36cedf.1c69fb81.eb779.dabd@mx.google.com>
In-Reply-To: <5e36cedf.1c69fb81.eb779.dabd@mx.google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 2 Feb 2020 17:20:16 +0200
Message-ID: <CAOQ4uxh-zH77=fbcuKZtnhf8qk5GWGphChyjmkSn6ZXBZ2JGNQ@mail.gmail.com>
Subject: Re: [ANNOUNCE] fstests: master branch updated to 61c6d0c30574
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Feb 2, 2020 at 3:30 PM Eryu Guan <guaneryu@gmail.com> wrote:
>
> Hi all,
>
> The master branch of the xfstests repository at:
>
>         git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
>
> have just been updated. This update mainly pulls in the new overlay tests from
> Amir Goldstein and a new xfs test, along with other various fixes. The new
> overlay tests should not fail on v5.5 kernel,

Unfortunately, commit 4c37e71b713e
ovl: fix wrong WARN_ON() in ovl_cache_update_ino()

Was not included in v5.5 and is waiting on linux-next for merge to v5.6-rc1,
so overlay/071 fails on a false positive WARN_ON_ONCE() on the first run
after boot.

Thanks,
Amir.

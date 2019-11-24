Return-Path: <SRS0=YV7M=ZQ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62245C432C0
	for <linux-fstests@archiver.kernel.org>; Sun, 24 Nov 2019 16:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC63207FC
	for <linux-fstests@archiver.kernel.org>; Sun, 24 Nov 2019 16:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+ZiVpk2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfKXQxg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 24 Nov 2019 11:53:36 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:42994 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfKXQxg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 24 Nov 2019 11:53:36 -0500
Received: by mail-yb1-f196.google.com with SMTP id a11so5021400ybc.9
        for <fstests@vger.kernel.org>; Sun, 24 Nov 2019 08:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H4v0kEjI7CikYgS8wBsOZ+4dczNhrvU99aECmPLKMxI=;
        b=C+ZiVpk2hgme8byzfi0j+WNhUx78/dSDCKH+XBEp20RiEfPeJFazsjAHqfxkMp2V2x
         QI1qrFhOSgYZSZpNcVkxNIKsAv+wmdtnPmdEc949lkZXXBEZU0EeAc/rlc6vhuGEK1qf
         ViokwVZd9riulQ/nwR9tCPPbbSJplifFT0aLWr/LWMa7s6rDsL6akQOVE4aDANV25vkr
         qM02OOXzYrv3F1UMDAhtaEhMc8HPWNeSWY0qWqlOXnhg3v4nuVojPSSD2614pLXdfX6j
         jGW+SVCpB2UUXEHVOzgb2rUyg4c99hCvJgHuXHonfmq8n46z0zA7Jh/6WWTfeyEoukrh
         dprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H4v0kEjI7CikYgS8wBsOZ+4dczNhrvU99aECmPLKMxI=;
        b=EIlaSGcuLqYLw8QUM5QVhgY+WTxhFG4Tg67bHqE1LktKOINVU67W6MDtydRewsLfVG
         V8oHjg9VSoXsFsC0Iv9qDZ9sGngrONunRdQZmAEJFo05PtZA9wdTx/gsj3ofpzyxOEMa
         hjHiA+My0aaOldoZJ+kVVFm0pmDuTgPPUPFmlJ6lA52RzycXesC2s/S/wvPID3teUWlT
         /OYKBthNdY3Y0taW5zypCugHEjXCzDKKHnw9UoTt9JLBKCb+wCO2332PbAEtHv++n56l
         UCEMzECWpEXJx3KQFKe2R4Yz6m1+hziqsbn6cSS/EHX1chOam1Qq7P0PRbOd6cMbvqmJ
         /rNw==
X-Gm-Message-State: APjAAAXWAN6kmC8AvR2fNAHhhIA3toUMI+6ndWPV7SA1fJPVMPIkO+6u
        6NlNvEECVqoUoDc9mMapJStQ9kY6NI/X+Sxunoi1cJ4A
X-Google-Smtp-Source: APXvYqziGVKu6zpGQeqzPGYBJbJA7a/YRLuJ6Fm6yIwdy3ui4QF/hQpJPyXM0HOwgQbgKj7nFamqHmP7KB4/Jgq5QJc=
X-Received: by 2002:a25:c50c:: with SMTP id v12mr19852794ybe.428.1574614415522;
 Sun, 24 Nov 2019 08:53:35 -0800 (PST)
MIME-Version: 1.0
References: <5ddaafc5.1c69fb81.7e284.ad99@mx.google.com>
In-Reply-To: <5ddaafc5.1c69fb81.7e284.ad99@mx.google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 24 Nov 2019 18:53:24 +0200
Message-ID: <CAOQ4uxhy24fy61W8wp_TAkZKJ5N4a7S5A3oQ-vzqsKVjdV6sEg@mail.gmail.com>
Subject: Re: [ANNOUNCE] fstests: master branch updated to 67a76593ba2e
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Nov 24, 2019 at 6:29 PM Eryu Guan <guaneryu@gmail.com> wrote:
>
> Hi all,
>
> The master branch of the xfstests repository at:
>
>         git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
>
> have just been updated. This is basically a bugfix update, the only new test is
> btrfs/201, which currently fails with latest upstream kernel.

Also generic/402 with -overlay has changed from notrun to fail.

Fix has been posted:
https://lore.kernel.org/linux-fsdevel/20191111073000.2957-1-amir73il@gmail.com/

Thanks,
Amir.

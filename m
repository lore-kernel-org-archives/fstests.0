Return-Path: <SRS0=G1tu=X3=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BE7C4360C
	for <linux-fstests@archiver.kernel.org>; Wed,  2 Oct 2019 22:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9263420679
	for <linux-fstests@archiver.kernel.org>; Wed,  2 Oct 2019 22:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9ozEAlx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbfJBWGW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 2 Oct 2019 18:06:22 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42362 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfJBWGV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 2 Oct 2019 18:06:21 -0400
Received: by mail-io1-f67.google.com with SMTP id n197so875124iod.9
        for <fstests@vger.kernel.org>; Wed, 02 Oct 2019 15:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E6PCd6IpKKN208bd94OE+og8FEln2I9nB5CrEcKBivQ=;
        b=R9ozEAlxzQbyZ8I2FgFRor0McwKB9IxMzRZA1JrgaKf7xJMj6pZB+jq0gEhYnIWhGJ
         geM1MGce/SZ9j9mrC1E6KlH1LEV9lux/e9Ryu1qiDPGfqhCdXrv4INWH6J0rnt+wjwJ0
         oszVOv/94AX8g1TwJQl1Urb3E7M4QrXAQDaFwD0ptMQuAZ+YkBROmt95a1gDGm9/Idmf
         INd642EFsUJ0bx4JAndacSGyy2f4Te9SsStT8eNeeLP8knLNgnPrgwMbhWz1rZfviIqF
         XF3gBq2D8xMdoGmGWRDGH9kFSCxbuSwIvoJoXzluBpOqJeK9Ze7mlm9rlvlsGVYdr220
         QM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E6PCd6IpKKN208bd94OE+og8FEln2I9nB5CrEcKBivQ=;
        b=FgkNRP5njqob0AKuwmHbT3B79SYyORTDcNsE2pXEP1EGZtV/O5lywOVUyrabNWoZby
         Z6t/23CKIMizrRJc4rYZlSQFRqdI9DBh2yg7yt9uudXcAtGmUV6XvJ8EVWAPqAIqkTT5
         SNXSxYvi7gjijUmqfh98cGOdTO060KswJEjx7D9TDbozNyQkKp8MEfM3gKTPZicyMc1A
         TGaAS3vbwfqXrUDPeJwrxp8CNFPlmvQOgrYrc7jKS4QZ/e7TWIZTdfG+So/MhcY4AB63
         SW4q+l/I2xDY2/kcEeAb2OEB1igVRlqFMc5YWm8N27E2v4XxO1bb4RhTNan75zQTIizM
         WMFg==
X-Gm-Message-State: APjAAAUGiSataZjwg5HZ2Mv92U3JTE/VpvD9uLPlgYdY1T8RV73Re9Zr
        AWJrqRsWUBAuYafyk2lICNCZrh4g/Y7GKqiU80BrRBT6
X-Google-Smtp-Source: APXvYqxJnS9Ez5k2b2F4PKRC65Ne1V6Ea9qC8tnW4RSKSc7ZntE8lrCS4bOq5K94R0nmzsD3/drEpYfF5RdnWD9UONU=
X-Received: by 2002:a92:1559:: with SMTP id v86mr6790712ilk.130.1570053980987;
 Wed, 02 Oct 2019 15:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190719041231.26500-1-deepa.kernel@gmail.com> <20190721164748.GK7943@desktop>
In-Reply-To: <20190721164748.GK7943@desktop>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Wed, 2 Oct 2019 15:06:09 -0700
Message-ID: <CABeXuvq_JgPVMvxdbefKviGAWUPaxTh=FsEJUb5A-wsOAqYvSg@mail.gmail.com>
Subject: Re: [PATCH] generic/402: fix for updated behavior of timestamp limits
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     fstests@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Jul 21, 2019 at 9:47 AM Eryu Guan <guaneryu@gmail.com> wrote:
>
> On Thu, Jul 18, 2019 at 09:12:31PM -0700, Deepa Dinamani wrote:
> > The mount behavior will not be altered because of the unsupported
> > timestamps on the filesystems.
>
> It'd be better to provide more details in the commit log, e.g. what
> kind of mount behavior and what's the changes being made to the tests.
>
> >
> > Adjust the test accordingly.
> >
> > An updated series to be posted after the merge window is hosted at
> > <https://github.com/deepa-hub/vfs/tree/limits>
> >
> > Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
>
> Thanks for the update! But I'd like to wait for the kernel patches
> merged into mainline first. Would you please send out a notification by
> replying this thread then? Thanks a lot!

This series has been merged now:
https://git.kernel.org/torvalds/c/cfb82e1df8b7c76991ea12958855897c2fb4debc

-Deepa

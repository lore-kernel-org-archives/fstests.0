Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F3FC433DB
	for <linux-fstests@archiver.kernel.org>; Wed, 24 Mar 2021 14:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FDC061A07
	for <linux-fstests@archiver.kernel.org>; Wed, 24 Mar 2021 14:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbhCXOBh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 24 Mar 2021 10:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235592AbhCXOBa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 24 Mar 2021 10:01:30 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9050CC061763
        for <fstests@vger.kernel.org>; Wed, 24 Mar 2021 07:01:30 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id k8so21579826iop.12
        for <fstests@vger.kernel.org>; Wed, 24 Mar 2021 07:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/XDEitzPwMZe1IovWsX+wSy2FlpG1gqUXovaqzjeXvY=;
        b=Jl3BBAE9NGrrdQZRvW3Mw8eDOTqbZWQ1DtYiY8KBmPM6E+YO1eT3/6FTTQCwtQle8r
         BnkfGXJ//tbpfdT5mUcWRA0DggwbQ+X9+fAxEQkzCJKujhwA10lz3M/AwcQEXn+S2lf5
         BZ0Yn60SHFeW4Cw1A57pxPr/ToUKrUKCQh7Mr5BBqOALdbSKZwvvqQCGBlPDzKuAsu30
         leHRovFOy3GYMX1vU5OXDdfrW8YlZ52L1qO4lqbnoxHwH4Ui1+MVTxXMe83ZQKZpEg7k
         Wxpwm4uE/fN5OKSiVT4jouUbG30tLIdG7Q3dbDXRHSbHj1OWGob5Xxv0hAe3lGfa30B0
         LIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/XDEitzPwMZe1IovWsX+wSy2FlpG1gqUXovaqzjeXvY=;
        b=Nxc84Phud27UVHmN2ygollprMonJKouoEEU2VvBKosBRI4j+gmU2BXfhSr3/wXxibq
         IrsyZOy74X9LpC04dBORHyKGmM0c5plvG9BER1zeCcmK9z6RI9Np0rmvZTsyEXPiL7mZ
         veBWdOJbHTRQ3PKxa79+MoTlwirs6L9b1jJKqIbj8s/2FPTyOqGE0Rll19w/J5ozYSty
         lYYyyQv25Xk7WDPJpZEEkDONeAxGQs/IPHG6xmieumQpGv0AxTSXqVHrE+QT1NETBRDv
         49OeD12EdT6fxpg0gmOYY7b5vdfNOOt1ymboG2cfIbBODxMXZwkKMCLxsFkCPWt8y6iQ
         vfEg==
X-Gm-Message-State: AOAM533l879XladBLbWjpfW2qXsXv+b9ZYKT+Li7TDEv5dC2dfii9aJY
        2FQ8YIQ5JJVBxasJFFE3M7/4qyZ5bZZHIIbpTLY=
X-Google-Smtp-Source: ABdhPJwRt8OG4SvCNMDuz+uDfwcPkak1kui+N+50gpDE1feOVo0OJfO9PMG2A+CdUFC4tH06IluIXW2zdTKJQOXoBME=
X-Received: by 2002:a02:9382:: with SMTP id z2mr3097205jah.120.1616594489671;
 Wed, 24 Mar 2021 07:01:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210322134522.916512-1-brauner@kernel.org> <20210322135002.6tyexslvqfiaari7@wittgenstein>
 <20210322142115.4ehetdcopvmvs7fl@wittgenstein> <CAOQ4uxjB3aDehSeomAvi-7rUJRZmmR=GQFAqod9SzSoGu5PjnA@mail.gmail.com>
 <20210324084126.ke7mden2s3a35koa@wittgenstein> <CAOQ4uxjwN+3xAjen5G8pRccYX_4bSCrcQUR5pqi2bFRpGPeSqw@mail.gmail.com>
 <20210324134554.rio27zsmsfzs6eqa@wittgenstein>
In-Reply-To: <20210324134554.rio27zsmsfzs6eqa@wittgenstein>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 24 Mar 2021 16:01:18 +0200
Message-ID: <CAOQ4uxg4hkwgyFX=uq-M+jytEPs64069vn-YyhY_Y+x8jrdBjQ@mail.gmail.com>
Subject: Re: [PATCH v10 0/6] fstests: add idmapped mounts tests
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Christian Brauner <brauner@kernel.org>, Eryu Guan <guan@eryu.me>,
        fstests <fstests@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

> > Meanwhile, found a bug in Makefile:
> >
> > --- a/src/idmapped-mounts/Makefile
> > +++ b/src/idmapped-mounts/Makefile
> > @@ -25,11 +25,11 @@ depend: .dep
> >
> >  include $(BUILDRULES)
> >
> > -idmapped-mounts:
> > +idmapped-mounts: $(CFILES_IDMAPPED_MOUNTS)
> >         @echo "    [CC]    $@"
> >         $(Q)$(LTLINK) $(CFILES_IDMAPPED_MOUNTS) -o $@ $(CFLAGS)
> > $(LDFLAGS) $(LDLIBS)
> >
> > -mount-idmapped:
> > +mount-idmapped: $(CFILES_MOUNT_IDMAPPED)
> >         @echo "    [CC]    $@"
> >         $(Q)$(LTLINK) $(CFILES_MOUNT_IDMAPPED) -o $@ $(CFLAGS)
> > $(LDFLAGS) $(LDLIBS)
>
> Stupid question maybe but what is the reason for this change?
> It builds fine without those lines.
>
> Building idmapped-mounts
> [CC]    idmapped-mounts
> [CC]    mount-idmapped
>

My mistake. You are right. It should be fine as is.
I may have messed up something else while building.

You may take the fix or leave it - as you wish.

Thanks,
Amir.

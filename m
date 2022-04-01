Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA356C433F5
	for <linux-fstests@archiver.kernel.org>; Fri,  1 Apr 2022 07:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243232AbiDAHSn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 1 Apr 2022 03:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343811AbiDAHSm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 1 Apr 2022 03:18:42 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272B725D5EA
        for <fstests@vger.kernel.org>; Fri,  1 Apr 2022 00:16:52 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id t2so1482858qtw.9
        for <fstests@vger.kernel.org>; Fri, 01 Apr 2022 00:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CMtvpwwPC1IhrXTDjwdQbE54XwOLGBVRxY0f073b0oo=;
        b=F44u6y6p8upYL8HWr2ZTsWY+R16OlewgJFS+iEIcyEZvyw9cnaGjfcKlxkTgtYT1SA
         xvN/zuWHVRCrvxFPbO57mWt0yTxtkjqg4enm3Xu0wTOgj6h3VCjFOXCwf7gYpmOK+19+
         otny8LppLC9a5tM6TsX/6GpQ4o17M+8qCktPstvWCIFhM1ZkNdE2kBkwiMb4W28Jgr00
         yh0u8kEs7Nt/XV12wZAuTMtlfDu6UDV/EZ98YzN5Z7LJI+SmO/Kyh+td5IkPFbI7WLWA
         ARUq6EG6Ana7QtN/SgKYzwsGEvubG7j/J97wjS6jnCzg7HRTH73E0ap2JGSok798coKN
         gm/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CMtvpwwPC1IhrXTDjwdQbE54XwOLGBVRxY0f073b0oo=;
        b=q5amMzZ1dtBK+1GzROHsIRX2OLeYADKYQvAEMlq3LZOPOxj0EfzThrMCiwAeqpQRHY
         eiywrjq53kWyn+KF8Kt15f76/rUlQFk0SpCxoGc3qkciN9TOkWtVWyA9bwnHMQS3aPF1
         9KLEEp7L7eWo/Wq81iWmW5cE1aDKDIa0pUDguTJnrgH9QwMgwd1n4aXL801dVfxRX35+
         sesfZVTPiNJE9BeJ/FTBN52Kg5kuL3nB0ZiesVmcPgni810Ol2RRehCCJ13AvqN2UwVt
         tlXnlriIU61yono9EQqDGek1rsOTKOTxdtcZsQSnBMl/vuNNStIEuVO7M3MsPUVMxq6M
         NnpQ==
X-Gm-Message-State: AOAM5320MZAK9Td4rLyZ6FB/I89WrTAm9UN1yHLhdDYfo/yHmBYP0o1O
        mwVd9doQGnZz7S5CnggTBkED7x1GjihYZhyzsv8=
X-Google-Smtp-Source: ABdhPJwjd6EIuUGAMnhS9zou8bxs+w/9+NlcBNglx8CBEgZBx2iIOfV35dOG457zCjyhINw6ZA9ulHyMYm6OzCLRF3Y=
X-Received: by 2002:ac8:5dcb:0:b0:2e1:ce48:c186 with SMTP id
 e11-20020ac85dcb000000b002e1ce48c186mr7540044qtx.2.1648797411160; Fri, 01 Apr
 2022 00:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220331112318.1377494-1-brauner@kernel.org> <20220331112318.1377494-21-brauner@kernel.org>
 <CAOQ4uxj-EndoH7ZT=sWRJ4VpXDXW4AyrFYByug7bYqria7LMPw@mail.gmail.com> <20220331114128.6j7lnp2h6f5ip4rf@wittgenstein>
In-Reply-To: <20220331114128.6j7lnp2h6f5ip4rf@wittgenstein>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 1 Apr 2022 10:16:39 +0300
Message-ID: <CAOQ4uxj5uPhXcKk09_ZC2UVq6p3z2Zt0PjTE4AxKg=tqMuQqww@mail.gmail.com>
Subject: Re: [PATCH v3] common: allow to run all tests on idmapped mounts
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>, Eryu Guan <guan@eryu.me>,
        fstests <fstests@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Rodrigo Campos Catelin <rodrigo@sdfg.com.ar>,
        Seth Forshee <sforshee@digitalocean.com>,
        Luca Bocassi <luca.boccassi@microsoft.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>,
        Eryu Guan <guaneryu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Mar 31, 2022 at 2:41 PM Christian Brauner <brauner@kernel.org> wrote:
>
> On Thu, Mar 31, 2022 at 02:35:55PM +0300, Amir Goldstein wrote:
> > On Thu, Mar 31, 2022 at 2:25 PM Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > In addition to the generic and filesystem-specific idmapped mount
> > > testsuites that already exist upstream today add simple infrastructure
> > > so any test can be run on idmapped mounts simply by setting
> > > IDMAPPED_MOUNTS=true in the config file or section. The main user for
> > > now will be overlay to verify it works correctly on idmapped mounts.
> > >
> > > Note that the infrastructure is completely generic so every filesystem that
> > > supports idmapped mounts can simply run all of their tests idmapped. But
> > > note that not all ways to create a mount have been converted yet. That
> > > includes e.g. _dmthin_mount and direct calls to _mount in various tests.
> > >
> > > In addition, there will be corner-cases. For example, xfs doesn't allow
> > > bulkstat on idmapped mounts because it is a filesystem wide operation,
> > > i.e. you can retrieve information for any inode in the filesystem so the
> > > operation cannot be scoped reasonably under a single mount. So xfstests
> > > testing bulkstat will fail as it's blocked. Similar for some btrfs
> > > ioctl()s.
> > >
> > > While we could of course restrict this testmode to -overlay for which we
> > > know things work correctly we should not do this. It would mean that
> > > people won't start using it and so we won't see issues unless someone
> > > sits down and goes through more than 1000 tests and figures out for each
> > > individual one whether it needs to be skipped or not.
> > >
> > > So instead allow this mode but for all filesystems so people can start
> > > running and reporting failures and we can fix them up or block them as
> > > we detect them.
> > >
> > > Cc: Amir Goldstein <amir73il@gmail.com>
> > > Cc: Eryu Guan <guaneryu@gmail.com>
> > > Cc: Christoph Hellwig <hch@lst.de>
> > > Cc: <fstests@vger.kernel.org>
> > > Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> > > ---
> > > /* v2 */
> > > unchanged
> > >
> > > /* v3 */
> > > - Amir Goldstein <amir73il@gmail.com>:
> > >   - Add more detailed explanation about the current state and
> > >     expectations of the newly added IDMAPPED_MOUNTS support.
> >
> > Please document the new envvar in README with a *short* disclaimer
> > about expectations with and without -overlay and please add an [idmapped]
> > section to the multi section config example in README.overlay.
> >
> > Sorry if I wasn't clear about what better documentation of expectations
> > the text in the commit message is important but is no replacement for
> > documentation.
>
> Will do. Since I'm upstreaming the patch separately I will hold off on
> resending because of this. Instead I'll start upstreaming this in
> parallel.
>

Excellent!

Thanks,
Amir.

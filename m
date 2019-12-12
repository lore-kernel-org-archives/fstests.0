Return-Path: <SRS0=/sVf=2C=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA4FC43603
	for <linux-fstests@archiver.kernel.org>; Thu, 12 Dec 2019 21:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9FC2253D
	for <linux-fstests@archiver.kernel.org>; Thu, 12 Dec 2019 21:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRBAbE33"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731187AbfLLVz1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 12 Dec 2019 16:55:27 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:33094 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730784AbfLLVz1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 Dec 2019 16:55:27 -0500
Received: by mail-io1-f67.google.com with SMTP id s25so295487iob.0
        for <fstests@vger.kernel.org>; Thu, 12 Dec 2019 13:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1DSdSRi2qXGSpbBPqJwoIrcfYipBfThdv3SdpHmdfe0=;
        b=FRBAbE33ERrggzr3cxWD5VT2KpNbtuT118eOf1AK+Htv7iBvbg9TPvHcRToQyn0oNI
         5Eap6OBirgCSGM0JomTw0LeI5EGQuO0NOhyQD14nMQ3Ok2DCywk2GaLOAdqmtM7GvBGj
         JujpygaqB9/K9MHJVihQo2t/Lo0o1JXRZlsouAS0x2QvEeGWSLHjvGn4X9SfbkARXJye
         Vq4kMP1NAsMfgu+C5RgMk/zLKifayOF/zrFRZrl2FSHUCcOnjo/Rvf+F90MaBNTf/cQK
         XZXVtk9aNDU09qU96mEP6cG5F7SByuDh0yBhCU8ZCUkzH4HrH0973Unjr4yAHZhohCaf
         xP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1DSdSRi2qXGSpbBPqJwoIrcfYipBfThdv3SdpHmdfe0=;
        b=VIvKtGToFa1gX1IU2u/0OHUmbOYy3yKMIgTi43CQxILd0xdl/Y0ln3Yv9V6F67S0Iq
         J4MD0VNqRx+HFoRrey9Ovo6tbnFX2Nb92zb2Sbi6MfJ0zDMSPZEAAfAyIMjMIdwq6rhl
         XX8nTbkDpX7yT3VYHk0ng0oeH5ripns3gkr9FOyKQVUrDsPANPtaLwstRblrFP37G47D
         1GEfVJGuXPLWH0s8R6uGIpHHFjfoH7h12S0lCfPIgTSVQtWhx4mBWoOa6IRTEJUhcykX
         73+6I+WlewDd5Yw6LqQeCrduAnmQCawxv4mD7IwnsLqoYr52Kd7i4SVxcpsjMK/OlECX
         ldtg==
X-Gm-Message-State: APjAAAWlcFyxsAse9/mEheANFMrp2kcGgfw/wHbP3SHah1UYA/c+9Dc2
        bfF1PJ7n00GolJ7cE/UNbXOW4+F5GIxoR3JtoWlO/Q==
X-Google-Smtp-Source: APXvYqw0LWL2gmoLFzEb2aG7Bbr2KbTa9axNMuz5D8p2xiTAp/ArbEKA5/Vf4DRvWpi+nrDmIv8K9FgJ9j/BjA9yGRY=
X-Received: by 2002:a6b:8b15:: with SMTP id n21mr4980821iod.110.1576187726557;
 Thu, 12 Dec 2019 13:55:26 -0800 (PST)
MIME-Version: 1.0
References: <20190719041231.26500-1-deepa.kernel@gmail.com> <CAOQ4uxhxVKhUh_P_NffLbGScpiL0wOrCTLwWJWeSbRRNbHzPrg@mail.gmail.com>
In-Reply-To: <CAOQ4uxhxVKhUh_P_NffLbGScpiL0wOrCTLwWJWeSbRRNbHzPrg@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Thu, 12 Dec 2019 13:55:15 -0800
Message-ID: <CABeXuvoHw8W02JsmZjafnQkOs1=0dodSpBFyJ_Gq+1vs+hFkQQ@mail.gmail.com>
Subject: Re: [PATCH] generic/402: fix for updated behavior of timestamp limits
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Sasha Levin <sashal@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

> >  {
> >         local device=${1:-$TEST_DEV}
> > -       local sysfsdir=/proc/sys/fs/fs-timestamp-check-on
> > -
> > -       if [ ! -e $sysfsdir ]; then
> > -               _notrun "no kernel support for y2038 sysfs switch"
> > -       fi
> >
>
> Deepa,
>
> This change, which is already merged removed the test for kernel support
> and replaced it with test only for filesystem support.
>
> This impacts people validating stable kernel releases with xfstest, because
> this test now always fails on stable kernels and I don't think that timestamp
> clamping behavior is going to stable kernels.
>
> Of course stable kernel testers can exclude this test, but this will remove test
> coverage and may result in silent breakage of > y2038 timetamps in stable
> kernels.
>
> I think test should identify if kernel had clamping behavior and change the
> expected timestamp values accordingly, similar to how the test was before
> adjusting it to new behavior.
>
> Do you agree? Can you make these changes?

Initially, we were going to allow rw mounts for filesystems which
could not update timestamps. And, this was a big change in behavior.
That is why we had the behavior exposed from the kernel.
I wasn't aware that the failing fstests would cause such a nuisence.
Since everybody seems to just rely on all the fstests passing, yes I
agree that bringing this back would be the easiest to not fail on
stable kernels.
I will post the kernel and the xfstest patch.

Thanks for helping me catch it.

-Deepa

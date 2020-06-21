Return-Path: <SRS0=f9yW=AC=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9104FC433E0
	for <linux-fstests@archiver.kernel.org>; Sun, 21 Jun 2020 18:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7055825222
	for <linux-fstests@archiver.kernel.org>; Sun, 21 Jun 2020 18:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLj1cxyW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgFUSWu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 21 Jun 2020 14:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbgFUSWt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 21 Jun 2020 14:22:49 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E38C061794
        for <fstests@vger.kernel.org>; Sun, 21 Jun 2020 11:22:49 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id x9so190427ila.3
        for <fstests@vger.kernel.org>; Sun, 21 Jun 2020 11:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CtGbLXTgKYGyKS7kUt5TF1YRDbkPrst/gZ4+9f5mOkU=;
        b=bLj1cxyWxU5EPc4PgYABmM6TZceVN/AcROMtP4T/TcHOfTyNjeRLEA+VsZx1t+DAQv
         Z7wpRzMVnrLj7uHNfVJ8q+Ez3t8udp2QOR8BVpjh5mf3Q/EkJK3JsJRNPrtpUD5ua8sV
         fvhVBIHIE/N8MAhgywvDksMgyum2ge/1Nu+LJcieHqYNK15fh5XZleiK+Y8CrnFN4lx6
         KusHQ+6P+T11xlUdK9KP23OkqUk4R0ROW1EVkMTxZSgbO/NZFJSrnSJWcG9amvGfpcP8
         AEmlZXeVy/j1pJ5m8dK02vBxhPblIcl04y8uhBhqfoGRRsPl5mQOwYH68uyy4VOXVRGP
         fFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CtGbLXTgKYGyKS7kUt5TF1YRDbkPrst/gZ4+9f5mOkU=;
        b=BnAkjUfVYIhD9GnxTgLHaK0Mjn1IlkkVdcfm7RbLOJmytwFAwYOhfANvG4Eg4tLaFY
         F9haspXbFwAv6RKrC5KHDbzxRnWDlJk6i0SLkAswfY1h6S/FbFjToxJIM+1ky5+UmylF
         qvMK4MUeiqj8kfikXFN9PXVKdCPNa5e1KBd1UksjDDXzL1BqNIXXZkuMlyf47GnkzOdR
         7My809vK5dkQAk38sV4h3uHRbFHMUTWCUB9TovvKd62SCfmZxYGohkTFx7cA3N5V+JRc
         gwLobVoMcWjqXibdPlOTJ9tviQoNOD2EaCCSk3D2K+FizYZ7Jg46V8yH67wXBOok8Omz
         yPPw==
X-Gm-Message-State: AOAM532q1CXja+OA7y2LODbisvLRcz/tEmRHMkropbbOJ2+wwyF2hdtM
        O3HlwDETTuc9TQY593nA3XLuEwfZAJl3hQpOUWw=
X-Google-Smtp-Source: ABdhPJx5/ZCPnMNIWzsImwqWYsR1fevd4AUqnzts7rnQSdEvAhHuM9SyN7mUBniKDj8dI7SRZlRctmqW0dyOWgN32Gs=
X-Received: by 2002:a92:c9ce:: with SMTP id k14mr13579600ilq.250.1592763768962;
 Sun, 21 Jun 2020 11:22:48 -0700 (PDT)
MIME-Version: 1.0
References: <5eefa052.1c69fb81.fa995.4360@mx.google.com>
In-Reply-To: <5eefa052.1c69fb81.fa995.4360@mx.google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 21 Jun 2020 21:22:37 +0300
Message-ID: <CAOQ4uxg82j7fecA4eGWphsbt0OjWK=eWauC1+YkB7RKfTO3Vpg@mail.gmail.com>
Subject: Re: [ANNOUNCE] fstests: master branch updated to aae8fbecf42b
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>, Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Jun 21, 2020 at 9:01 PM Eryu Guan <guaneryu@gmail.com> wrote:
>
> Hi all,
>
> The master branch of the xfstests repository at:
>
>         git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
>
> have just been updated. As usual, this update mainly contains various bug fixes,
> and there're also 3 new tests, which should all pass with latest v5.8-rc1
> kernel.
>
> My apology for being absent for so long, I've been very busy with other tasks
> in the past a few weeks (and perhaps will be busy too in next a few weeks :( ).
>
> There're still some patches pending in the list, as always, any reviews &
> comments are welcomed!
>
> - the unionmount patchset from Amir Goldstein, I have some concerns on wrapping
>   another testsuite in fstests, but I'll look into it more carefully later

FWIW, for all I care, the unionmount testsuite can be maintained in
the fstests repo.
It's not like it has a large developers community.
You can think of it like any other helper program under src to drive tests a bit
more sophisticated than bash is up for.
We even already have python helpers under src/perf.
Only unionmount is written in python3, so not sure if that creates any
challenges.

Would love to hear your thoughts.

Thanks,
Amir.

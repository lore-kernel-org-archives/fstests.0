Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4C4C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 21 Jul 2022 15:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiGUPHZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 21 Jul 2022 11:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiGUPHY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 21 Jul 2022 11:07:24 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91A12A962
        for <fstests@vger.kernel.org>; Thu, 21 Jul 2022 08:07:23 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id w129so838525vkg.10
        for <fstests@vger.kernel.org>; Thu, 21 Jul 2022 08:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I8eZlYWOlL5M+hDoMfiJSRrSG5s5uISwyxAVi5iHiVs=;
        b=mPNx6i0/k3OUnZ2cfqis8rTwFo9ijjMwNrfr2HTn41aifc+GVi5lEYTsz8SffBtO9m
         wtQ4NA4H2nW+0MBleCdgvgSDPYHXm723AY/MGOvkfhFxAXTT2qUD42mtcTg4chgxoaU1
         a4ZgeI9xKRKCjWHATkcJlpyLtYdkBGz9EWrGz7DstVGHJvL0/vL8+/Hc2YCmV98WiqNk
         CFAcB1Fd2hpYCZ3gA9TIOcd/L5roiJBShAaBxGhOwl4Tp0Okv+4xo09ivvgsbAnOGZ6i
         mOAw04V37KhJZazw/pAdRo0w4OOM9IHvQAmMoURCql+03vbQfbOIx/J+OT7WwPVRdrXC
         Go5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I8eZlYWOlL5M+hDoMfiJSRrSG5s5uISwyxAVi5iHiVs=;
        b=dpPFOyAFBAHkcJGHut13iTvZfNaIfPsfxY2piyDpxmvigCMn/XaSEoFusxWGCN9zQN
         13+lAGAf115Qx3LX00RD2/Yi6eJUA9fvGK53ivx3wVesJ5zzgoYcFXVN0ouHMlXwkhVf
         tcNecZTeXUGr32PPb47sjnOJNuDaJrAO72I+JO7sYcd442N/pIO21OyyXNYCzRQwblNw
         oVgpAIK4LAPZh4I/hDyF7dytq6ZrdYnN+3PsWhfSEG1YLQ0W1HIbF9wgWRHp2az+ngr1
         de9JbEhjHs9UUxjIfmzYnfiegVyCw1WBSZisqPb0Uxo6U5l3AfyvyO1XewPnr28ySQm4
         H/DA==
X-Gm-Message-State: AJIora9K2hX3Ofhe9jDBcG3kNXLmX8t5ZEfoBaz3/QphRs4NUg5Q9zBo
        WjRdgbvhFoouIjm8k8+RUoztMSZLiW4QsquK6WifbQHEDX1n9Q==
X-Google-Smtp-Source: AGRyM1s0ulrP1DnTecqUnxpvhYv7cDpktVF922YVe1ytNdBCZthO7wD5QnfBfcPZ06dmEJ/nb+Mzd6vj/DqTUJkhA/4=
X-Received: by 2002:a1f:2aca:0:b0:370:9de2:51f7 with SMTP id
 q193-20020a1f2aca000000b003709de251f7mr16143188vkq.11.1658416042967; Thu, 21
 Jul 2022 08:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <YpjVcHuxhEQwPusN@bombadil.infradead.org> <CAOQ4uxi0eY3ybXbL6TEZv27HUoBaSTcthjC7aHRCTzACfyq52w@mail.gmail.com>
 <CAB=NE6XAL1+OXV0X5zBZCMWsqsy-xz9E6rkwPkGOHRXyG4sohg@mail.gmail.com>
 <CAOQ4uxjbJWt06bx_iE2mh=JemuM+fAAGU2WGYV7vOWQzvY4wMQ@mail.gmail.com>
 <CAOQ4uxjHp5iz4kP1qRbQtXSu3frVUhvxr23Gc0jzW9nY+_ep3A@mail.gmail.com> <YtlmsH6vohI2/ttV@bombadil.infradead.org>
In-Reply-To: <YtlmsH6vohI2/ttV@bombadil.infradead.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 21 Jul 2022 17:07:11 +0200
Message-ID: <CAOQ4uxj0G-inckcdPK+=FXDhBM-cS4FF3Ba-NuBrpD6vHSsTuQ@mail.gmail.com>
Subject: Re: Collaborating updates of kdevops xfstests repo
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     chandanrmail@gmail.com, Josef Bacik <josef@toxicpanda.com>,
        Zorro Lang <zlang@redhat.com>,
        fstests <fstests@vger.kernel.org>,
        Anthony Iliopoulos <ailiopoulos@suse.de>,
        Pankaj Raghav <p.raghav@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jul 21, 2022 at 4:46 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Thu, Jul 21, 2022 at 11:15:04AM +0200, Amir Goldstein wrote:
> > Hi Luis,
> >
> > I have been on vacation and partly still on vacation.
> > Quick question.
> >
> > Soon I will want to update the shared xfstetsts repo - it has not been
> > updated since v2022.07.10
>
> That's slightly over a month.

Correction. It has not been updated since LSFMM on April 2022.
So far it didn't matter much for my tests of 5.10.y, because I was
backporting fixes from before v5.17 that already has fstests in April.

I will push an update before testing the next round of xfs 5.10.y backports.

Thanks,
Amir.

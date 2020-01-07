Return-Path: <SRS0=VTFL=24=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D851FC33C99
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Jan 2020 08:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4D82080A
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Jan 2020 08:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ohLNmuBh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgAGItT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 7 Jan 2020 03:49:19 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:36572 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgAGItT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Jan 2020 03:49:19 -0500
Received: by mail-il1-f195.google.com with SMTP id b15so45101055iln.3
        for <fstests@vger.kernel.org>; Tue, 07 Jan 2020 00:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mp9LrD5WTx2WpgVFWg50lk3uCtXwyYHuu9bloaKpD9I=;
        b=ohLNmuBhQ0YRSD22LoDaRazMLLIlU9K4yHYt5JMsvGp5tGjuy47sYBocZJF2XtQhCH
         rB1BC2lLnPcHpqdtdQ8uD7zcu05LjN+VdRaGkJImbVaPj/mURitEsHZZ/x/uZf0hZl6S
         O8DTUMYGZ8j8bGfKlrrUcQnwWppY/72yfDGcQ4ulnR7w1Z8DGQhuUzqzTOedzqtG3rU7
         gWz3eXJNfjhnSlDj57bXM72VOZFsLw62APRa+eGfa5YD4RRRh6dqUWIEJg6ZIGl5Ybqx
         snJPQhmHzO3A2l26/W1qpuWF9rB9aRzJ24HWPxjQXoe0Hie0jel2DmsZWcYgnnCz31jO
         1o1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mp9LrD5WTx2WpgVFWg50lk3uCtXwyYHuu9bloaKpD9I=;
        b=iHCCmafw3aLx7cw7WmKiiQi3N9qU0pw8LkivDclom0dBHEQM7pBqnFdvQ97R89UnfO
         NBQzV8++rtnGatDW2iOG14Ax/PCeRfxnWWbL5jI9eqloNdtuYBjUELIACQUM+JFyrdFK
         O0jsXjYyk4dnMFHEj9ioWVfs3fGv2y8vRbZeYMQRSWkOF3RJZs9kcb+dbSljYfjIhWrx
         Ih2cjF3HPMgDn0bLoYoy0N4AgvIB+czA0vkRqbUrAd69gmvtyunOyB4rifTN1o/hS0Yr
         a8d0EXywTbCkqp1byjCvcfX0oIOLGnHUvdJ+NawabCx1lRQ98dA0gVXqjaCynzCub1a1
         zFzg==
X-Gm-Message-State: APjAAAVo/qi7/mr9zhEHdTSfeNaHPgRuWx9KCeu6NmJwpCIYo6qw4ixh
        Oyxqb4uk+ssIcOCqPjhYRPGYczoINAdr5h6LingyYeQv
X-Google-Smtp-Source: APXvYqzEgbYatZTGFlEjC8r98CWHKb7ubs826iVots9QM9LLkjUu9md1/GCY6Zig6LLfGPIlhn+nMrsz5WK6aZ0yJ24=
X-Received: by 2002:a92:5c8a:: with SMTP id d10mr95003698ilg.137.1578386958621;
 Tue, 07 Jan 2020 00:49:18 -0800 (PST)
MIME-Version: 1.0
References: <20200106070654.13249-1-yangx.jy@cn.fujitsu.com>
 <20200106070654.13249-2-yangx.jy@cn.fujitsu.com> <CAOQ4uxh91oRB03UGuqhSgASeY7-OtQD3wMRdOQ-SL0UBgdMPHQ@mail.gmail.com>
 <5E13E895.8020005@cn.fujitsu.com> <CAOQ4uxijoQugy_qqpfmyFmF4GcCOenbL7eX8d2aEEGknfe_UQg@mail.gmail.com>
 <5E1436D1.9030601@cn.fujitsu.com>
In-Reply-To: <5E1436D1.9030601@cn.fujitsu.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 7 Jan 2020 10:49:07 +0200
Message-ID: <CAOQ4uxjYmGXsRhGe76KSqfS3k-aMsad=bGdmm-wwMOXyDKFRyA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fsx: Add '-a' option to skip unsupported keep size automatically
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jan 7, 2020 at 9:45 AM Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:
>
> On 2020/1/7 14:47, Amir Goldstein wrote:
> > No it is not wrong, but this is different than skipping keep_size.
> > My point is that when fsx is run with some parameters and
> > produces a replay-ops log. If that replay-ops log is replayed with
> > exact same parameters it should produce the exact same sequence.
> >
> > In the case of punch/zero/collapse, if those are skipped when recording
> > the ops log, then ops log includes the keyword "skip ..." explicitly, but
> > but for skipped keep_size, keep_size will simply not be in the log.
> Hi Amir,
>
> If keep_size is not supported, ops log can also includes the keyword
> "skip ..." by Eryu's patch:
> https://lore.kernel.org/fstests/20191022123115.12250-1-eguan@linux.alibaba.com/
>
> Do you want to add require support for keep_size/punch/zero/collapse and
> accept Eryu's patch as well?
>

I am perfectly fine with Eryu's patch and I think it is correct to merge it,
but it is completely independent to fixing the 4 tests.

Eryu's patch is changing the way the ops log is recorded (for the better),
but it doesn't change (and I think it is wrong to change) the way that ops
log is replayed.

The hardcoded ops logs in those 4 tests are not going to change because
you modify fsx.

The hardcoded ops logs in those 4 tests intentionally include the keep_size
directive, so those tests should not be run on NFS.

Thanks,
Amir.

Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC20FC43381
	for <linux-fstests@archiver.kernel.org>; Tue, 26 Jan 2021 18:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0FFE22286
	for <linux-fstests@archiver.kernel.org>; Tue, 26 Jan 2021 18:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391120AbhAZRVs (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 26 Jan 2021 12:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390549AbhAZIsd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 26 Jan 2021 03:48:33 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEEDC06174A
        for <fstests@vger.kernel.org>; Tue, 26 Jan 2021 00:47:51 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id h11so8622167vsa.10
        for <fstests@vger.kernel.org>; Tue, 26 Jan 2021 00:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eJJVXT7Zm3sSCpG8sNIQkas+aRxWJnV+8pTflNpI0kE=;
        b=Vs+AYALnh9wAuAwQAOqQKViVTSsS9zXofeAMuo/KhL+SHGC+6ElIBykrEZyZlMW0ef
         NDrr1BlmHxjI7XnTrTTTdzo5EGaKjcr6N2+e4EFKauBx6Kt4ywtFtM2iuetRgkqSVL3N
         pATNtykcc84AQLXdnCutOczvC+EM2RuJVFuPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eJJVXT7Zm3sSCpG8sNIQkas+aRxWJnV+8pTflNpI0kE=;
        b=YdSAZxFvvFxT/D1DPGJyxC1GiGAa5f3WWECanePNPEurusYiMOMLBgl+TO7xhud/88
         GxYa/O13M2Y/7ObkSfNXr6eJAGr+1IS6aftuK8uktr64NSANesWFa88GNWDsGQFDQ7xy
         Z8dyzp4LH1TWI2j7Bl+mRgJ0oNDSDylLUcde0MNa493bDyaXXwvLcQ7/txKnWI1+tG6x
         M1dmO0XoRyJY+mhJ46lzj4n4ZOxlu3nwS9f1CtdeFDc4lhugdm5LkamjOYcUwT0EOANr
         aPvMF56XbTYrcbzF3JQFWHhUpNDqWmm/CuMjdbRryX3/KNbC0qW4AvctgzcYxxsfNm4V
         5OBQ==
X-Gm-Message-State: AOAM531/r/6Uq5VvzGloDWt0/C9hasrdXIFVUvuKiQdAvS0nZHNe5fKy
        HuwKPZUo2Q/EBmSJzDvOeg6MzqjdbW2v5I2dHvv+aw==
X-Google-Smtp-Source: ABdhPJzTJTbo0jmbcnLg+/acyVUVHuN4RVsFfiB8gDL/6YB6EXHp1QNRrIyXM7OZEe95WP//ZCgNQDP7wNVVXeoudz8=
X-Received: by 2002:a67:8844:: with SMTP id k65mr3457158vsd.9.1611650870537;
 Tue, 26 Jan 2021 00:47:50 -0800 (PST)
MIME-Version: 1.0
References: <20210116165619.494265-1-amir73il@gmail.com> <20210116165619.494265-5-amir73il@gmail.com>
 <CAOQ4uxiXUN7LkzNLZto6iK2YuDdxp7PGoQMGCm89p1kNWUf=YA@mail.gmail.com>
In-Reply-To: <CAOQ4uxiXUN7LkzNLZto6iK2YuDdxp7PGoQMGCm89p1kNWUf=YA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 26 Jan 2021 09:47:39 +0100
Message-ID: <CAJfpegu0igQWqaaq3RT5jHx=GLZ80+4rM6uk8yM0+ri4Ks_0bA@mail.gmail.com>
Subject: Re: [PATCH 4/4] overlay: Test lost immutable/append-only flags on copy-up
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Eryu Guan <guaneryu@gmail.com>, Icenowy Zheng <icenowy@aosc.io>,
        Chengguang Xu <cgxu519@mykernel.net>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jan 25, 2021 at 2:24 PM Amir Goldstein <amir73il@gmail.com> wrote:

> Miklos,
>
> Do you plan to followup on your VFS implementation for the
> {s,g}etxflags methods?

Definitely.  Will try for 5.12, but no garantees.

Thanks,
Miklos

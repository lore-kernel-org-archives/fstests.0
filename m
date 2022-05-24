Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5C2C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 24 May 2022 10:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236343AbiEXKtU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 May 2022 06:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbiEXKtS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 May 2022 06:49:18 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3AD60059
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 03:49:18 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id w17so1483561qtk.13
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 03:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uEtUQDMZRU+wg0D20KdXPdrPpVCeQRpHFsJHMyBQU00=;
        b=h+URbLe4MJXisGigz/Kd8VBoONPXNBXvEk/j0S5mZBaevFEFA1Q4Ubq4e6g/kpPG7A
         4PlMqo83vcKMm2XbtitFKO4X+fSMmJMSqMzvOPiJ7kENqOadtD5OYeihPinQzheozq85
         EPJTtH3wrmTlH+kJYK/LuuMgiVG8WLeHeIrQOTFhkKd/XZbm7jT8KhIDAitqvipTHCVG
         aSAM0GYXaXJzeDWq+Xs++HHY1taGOmkGmjpyyAAscwUViodP3vopigR9TO218mbSLebH
         t8hi7GfzTg+Ke0dul/LN+2uNZnbDOgVSPaq+lB8IGs7x4ZuUuGvsyzpRzVsxmdqib1sE
         6Fqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uEtUQDMZRU+wg0D20KdXPdrPpVCeQRpHFsJHMyBQU00=;
        b=qsH19fqu2gUxyr1CMCSZl4SVXmZwAO3xugfmnKq/UdM1Y3PaT1GK56gMM1Xg9IIJFT
         0ZGbV2D+Eys/yR4t43tVONbgVJ0sYARObOciixn/3KJEpvgM07gQ9vJDiC48qYUdbwBM
         J10dsEuT7m6xdW3yhiN7Hszu9QPTpV46L1zLACQ9J2x3enU0u9e3VlzHPHbHWHuQG04D
         8Q60b05qCQ9Usqh922PfzMqHcwckAbYi2NfqYZdJ8m1i8yV725nRHiUN9MRYy6kqGNky
         iPEUodVYub4J3ohoRqH/Co2ozbSIzGbbuZCLs9zHXw0eRoN3/zJPXRVk+ezunIpGBXww
         nlIg==
X-Gm-Message-State: AOAM530p4VYZ3ATY2oHSTZHqOFijKZ38UWe/O4NJ4Pl+gaCEr3DyKzFC
        UauguGqvnQ5dOUP6ty/xgIr7IgKgGvNcr+7y+gNGDNrYshE=
X-Google-Smtp-Source: ABdhPJwV3Lr0XXSQ4eAhRBbLKHUp17Wu3bM6S5YwwWQ9F3f1XqtLWmaDyhUQBfHZZvcq5MtSij9l54J2H6P7Xcb1LGM=
X-Received: by 2002:ac8:5f0a:0:b0:2f9:3b64:b5ba with SMTP id
 x10-20020ac85f0a000000b002f93b64b5bamr4607021qta.2.1653389357298; Tue, 24 May
 2022 03:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220524073411.1943480-1-david@fromorbit.com> <20220524073411.1943480-9-david@fromorbit.com>
In-Reply-To: <20220524073411.1943480-9-david@fromorbit.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 24 May 2022 13:49:05 +0300
Message-ID: <CAOQ4uxj4wiROLSw7_bJZxhHngBha+OT64ezDKWe-cxEQzmeaYg@mail.gmail.com>
Subject: Re: [PATCH 8/8] fstests: cleanup _cleanup usage in shared
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 24, 2022 at 1:17 PM Dave Chinner <david@fromorbit.com> wrote:
>
> From: Dave Chinner <dchinner@redhat.com>
>
> To match the cleanup of tests/xfs
>
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---

Makes sense.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

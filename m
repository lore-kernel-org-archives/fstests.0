Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C246C433B4
	for <linux-fstests@archiver.kernel.org>; Mon, 26 Apr 2021 11:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B88C61165
	for <linux-fstests@archiver.kernel.org>; Mon, 26 Apr 2021 11:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbhDZL1B (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 26 Apr 2021 07:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbhDZL1A (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 26 Apr 2021 07:27:00 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9EEC061574
        for <fstests@vger.kernel.org>; Mon, 26 Apr 2021 04:26:19 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id b17so46286600ilh.6
        for <fstests@vger.kernel.org>; Mon, 26 Apr 2021 04:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CsNw5+RYw3GC1bAjUOccWYo94d05FPf0MKg48O1E1tE=;
        b=EOhG7pZ70+r/Jy6PdRmt/UyQ0jvnAVe0b2nzkkqTc+A9BAPwSNGfdFXx5rudDSLn5G
         2HVodHub9p8JNGJ/mR9XOpyjKwzUaBjwfhtf3B0UH4znhs7A4Cc2dX4VdV9u5umMiMwG
         BYj3s5qMr0cBvSEBhXy2zDwSw7TZAARQd3jY6o6H0oY+mcWhVlpe4j5wja15CZ4LS2aN
         zqkJFhXznCWOU7WNLVaJ4BZBNeVhfUwt2KsFjniZQCCXuX9dNxySdggZmBdIjehHXDUi
         I1vpkW1DG668gKJ9R+t1YKhfgdDYUfzNRqB98Nltk7O/c5DmvzBX4ag+KbyaHFrU7rP8
         x4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CsNw5+RYw3GC1bAjUOccWYo94d05FPf0MKg48O1E1tE=;
        b=BTBoPzeynemWLWH8fVsG1QfErES3//ZpNWMqvcwKDaJ1VGLnBK9qAfnScPHDGPXyox
         +j0fiY8zHvD1J0MjJz9R49tWBufAAX03ys6uSj1OnRo15IGuaaMaimhBUI71KkFqCmIf
         N9RzBew9da+4srmvrTnALgw3/P6cNDjkfYuhoCC/ppDr2hTg1apiB1DRMbUvg+5wU56a
         Qc7y+gi4ircWVypNgvGQ4UUz57LjE4O2y+gGu8P+qBzOM/zQ9CRHlMBiWKH4Rodg1fbR
         mmLhJA8W7/A9dW1hsY6fUES7yhdJdMOYz9SnzcSq3WgbMqIpPObCFprhPwjGaGqscO4G
         cHjw==
X-Gm-Message-State: AOAM533p7+HuWHIRtafxRKRLufuVMuBhakDn168aWh7mQuGmj5YHw9oG
        TkDCe9t/f8s1cKIAJ6T1/otRhJfSfsblomlYczs=
X-Google-Smtp-Source: ABdhPJxb9Emo7l103m+iftx0xDWkXR0g++/Vgi7lFZdbG7ErPmunDkrUYhEgLsIusIljw+koHVJKDDKTR9qVTZ14pmw=
X-Received: by 2002:a92:b74a:: with SMTP id c10mr13112238ilm.72.1619436378985;
 Mon, 26 Apr 2021 04:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <1619423823-21256-1-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1619423823-21256-1-git-send-email-xuyang2018.jy@fujitsu.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 26 Apr 2021 14:26:08 +0300
Message-ID: <CAOQ4uxgRvXk7n6=1vhhVNMn3vbqGFnnm4zs5FR65-_Bz+OAs9w@mail.gmail.com>
Subject: Re: [PATCH] generic/631: Remove useless nfs_export=off
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Apr 26, 2021 at 9:56 AM Yang Xu <xuyang2018.jy@fujitsu.com> wrote:
>
> The nfs_export feature was introduced since kernel v4.16-rc1 after
> commit f168f1098dd9038 ("ovl: add support for "nfs_export" configuration").
> On old kernel, this case will result in infinite loop because overlay
> mount failed because of unrecognized mount options nfs_export=off.
>
> In kernel documentation, overlay.rst said "the mount options index=off,nfs_export=on
> are conflicting for a read-write mount and will result in an error.".
> So using single index=off is also ok in here.
>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  tests/generic/631 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/generic/631 b/tests/generic/631
> index c43f3de3..0fa47e49 100755
> --- a/tests/generic/631
> +++ b/tests/generic/631
> @@ -74,7 +74,7 @@ worker() {
>         local l="lowerdir=$SCRATCH_MNT/lowerdir:$SCRATCH_MNT/lowerdir1"
>         local u="upperdir=$SCRATCH_MNT/upperdir$tag"
>         local w="workdir=$SCRATCH_MNT/workdir$tag"
> -       local i="index=off,nfs_export=off"
> +       local i="index=off"

It's not clear to me why index=off is needed for the test.
I imagine that the mount options were copied from the container runtime,
which uses index=off as a workaround for mount failures due to leaked
overlayfs mounts. It doesn't look like this would be a concern for this test.

Anyway, removing nfs_export is fine, so

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

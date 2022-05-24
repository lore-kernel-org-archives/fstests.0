Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8F0C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 24 May 2022 09:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbiEXJll (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 May 2022 05:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbiEXJlj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 May 2022 05:41:39 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE91424591
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 02:41:37 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id y11so388624qvr.9
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 02:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jr6BCQ94k8f/M0treLz3jfkwjPg1Xj6KNnjA6IkVo0s=;
        b=alMg2VApxv9eSKkVFaN8kA5tWESQ95DI0yN/I6JRZe8qbjDlKXTZ3pXYK2dq50pfKK
         A3K+wCWBnetfUNW+euDVuANjncfH3AfFrAzpV1fMNgVwJ8z85s93WHw7mHkRgAd4dzwj
         siO6o/HVDc77QClEBVOzvhHl0SJcfhG1Zf1TnM/D8hVSpFQn/oXg3Nfkg9/LRsAGRW65
         ftPzOwh8DMLl7q+EOiMNLnFsC3D4wyKz/bGMGJQ9Owat9ZbBOmpTWae/f0nL43J//uFx
         wuq7ksRxuOjvAqhAzya3JpsKHHrXHRHkf004i91jSugGsSWT8VrXYLvP+4+SpXZNofxz
         4r+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jr6BCQ94k8f/M0treLz3jfkwjPg1Xj6KNnjA6IkVo0s=;
        b=ybRR81Dj7HnZDqHDwu1AvZibzk/kEVlNUoltwlOClL6N2K5LG9O+CY3aHZmM6gv4eC
         YgEy59dNtR/qJ7FFb3YlK9yd6ZAhKdqr3YwZjjg8qmydh6R9MhP+Fod1pxn1iPJL5egv
         VmJIii+TKcxNAmhOsRmOQhGdKMz4KiSmp87DmtH8df7KX2l/jrpgNI4spGRu/6x8Pr1f
         RXxiuzINulmyvXO200ZtH6CzPBvPt3AvB2kIPbCiP5/5Mhy/X1js9eNrf8saMssgq1mU
         M3xq+4Ntori49QR/uODNQVJtZeZdeau32dMok4WAFgmKor7BP55aIHuVvKym96DCtE6l
         6j8g==
X-Gm-Message-State: AOAM533/JIsJy8wZeXcw3HYE0dhh5k5NuUJX4BohoakXBRKanpgy1i2q
        5I8GO1IL4dF3KPFdMsKxfMAFQ7yO8vAVHX+oZP11oo2pCgXROQ==
X-Google-Smtp-Source: ABdhPJxSvdQjPsDxTeo9A4wOmO+O+PLaOWW5DJiYVKDfd1jYU62DCyOpwi+C/nHm9/eoD9nlIQVMKnNm+ANPhDNjxGQ=
X-Received: by 2002:a05:6214:1cc4:b0:435:35c3:f0f1 with SMTP id
 g4-20020a0562141cc400b0043535c3f0f1mr20518059qvd.0.1653385297116; Tue, 24 May
 2022 02:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220524073411.1943480-1-david@fromorbit.com> <20220524073411.1943480-2-david@fromorbit.com>
In-Reply-To: <20220524073411.1943480-2-david@fromorbit.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 24 May 2022 12:41:25 +0300
Message-ID: <CAOQ4uxhqGEYgMYGuFsFV_AtuwyJhpzRrZw2rYDo-Dn_xziOYZw@mail.gmail.com>
Subject: Re: [PATCH 1/8] generic/038: kill background threads on interrupt
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 24, 2022 at 12:12 PM Dave Chinner <david@fromorbit.com> wrote:
>
> From: Dave Chinner <dchinner@redhat.com>
>
> When I ctrl-c g/038, it either does nothing or it leaves processes
> running in the background. It is not cleaning up it's background
> processes correctly, so add kill vectors into the cleanup. Make sure
> we only kill in the cleanup trap if the background processes are
> running.
>
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  tests/generic/038 | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/tests/generic/038 b/tests/generic/038
> index c6cea94e..0462ea13 100755
> --- a/tests/generic/038
> +++ b/tests/generic/038
> @@ -36,6 +36,10 @@ _begin_fstest auto stress trim
>  # Override the default cleanup function.
>  _cleanup()
>  {
> +       [ -n "${create_pids}" ] && kill ${create_pids[@]}
> +       [ -n "${fallocate_pids}" ] && kill ${fallocate_pids[@]}
> +       [ -n "${trim_pids}" ] && kill ${trim_pids[@]}
> +       wait

Following the pattern of recently fixed generic/019,
Please redirect stderr of kill to /dev/null
and I think we would rather not wait in cleanup callbacks
which could potentially block forever?

>         rm -fr $tmp

I suppose another patch is going to replace that with the proper _cleanup()?
Patches from vger have been VERY slowly trickling into my mailbox.

>  }
>
> @@ -47,6 +51,8 @@ _supported_fs generic
>  _require_scratch
>  _require_xfs_io_command "falloc"
>
> +echo "Silence is golden"
> +
>  # Keep allocating and deallocating 1G of data space with the goal of creating
>  # and deleting 1 block group constantly. The intention is to race with the
>  # fstrim loop below.
> @@ -121,6 +127,7 @@ _scratch_mount
>  _require_fs_space $SCRATCH_MNT $((10 * 1024 * 1024))
>  _require_batched_discard $SCRATCH_MNT
>
> +
>  for ((i = 0; i < $((4 * $LOAD_FACTOR)); i++)); do
>         trim_loop &
>         trim_pids[$i]=$!
> @@ -136,12 +143,9 @@ create_files "foobar"
>  kill ${fallocate_pids[@]}
>  kill ${trim_pids[@]}
>  wait
> +unset create_pids

This one should be moved up to after the wait in  create_files()

Thanks,
Amir.

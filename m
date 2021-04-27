Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1904CC433B4
	for <linux-fstests@archiver.kernel.org>; Tue, 27 Apr 2021 06:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAA9160FDC
	for <linux-fstests@archiver.kernel.org>; Tue, 27 Apr 2021 06:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbhD0Go6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 27 Apr 2021 02:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhD0Go6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 27 Apr 2021 02:44:58 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C83C061574
        for <fstests@vger.kernel.org>; Mon, 26 Apr 2021 23:44:06 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id k25so15559207iob.6
        for <fstests@vger.kernel.org>; Mon, 26 Apr 2021 23:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PbgajxE2a3DMiRi0XnJLajL5kXs6u1W+gcPwvxysMQA=;
        b=jCTwuA8oJtTfBmIK1clUVnayb1wbQqVYycjWo1fOKOTP1ap4i+LDUmDpX4nOWRGxun
         56pyR9TwmJte5pz/3axGpuV53NQjT0Nx6PFuvJ2+/h6lHYq9A36Wj5AWZY7UDWLF1+7m
         v0EMfKvPWFIpmiR0LBAf+6YPb0TGYWB73wRlBX/ZvZclqVA7ErwrzTuvRr9yNykLMaFB
         m/CU1lZR1mj9VWsKUEoMzJTASD6B6zKz5zceYYuQF52t4MKOLpl3ldfhrOcQxZmSN75S
         Y7xXFxeLuF5Gyzlm539GrcqhC6nGsUO7nZEBqnMoHbdfq4Jztowp8q+BITfYeHLJxnij
         keRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PbgajxE2a3DMiRi0XnJLajL5kXs6u1W+gcPwvxysMQA=;
        b=IWj4iQHzk6jWcRR5peX+QIdbz/B72w2/NhbR9HO2bwev5jvm35pt+a0tsg8uCQepoW
         bKdBpwhYYNo9lDlqVygP+kw2hRSdobuCHDk68TYNgUO80QGa3v7IEBrUnd7bf9MQYwHF
         c5YFG52T7bZ/S+WYpR2HVF6yftiSDZ5U/4iFgx1fjfMnzlXaOX3QT3+qRZIqUtvyhvrB
         dKuN6SJEzI5uaViK0wBV51BZ2hTVfZw7UOwrOMpIw+4QxuxXDMfY1CFmchQKgfdZWi85
         aR+9w2d4s3+Ddtx+iWACQyxpJDpaUlBw9eXQxrOX8OKBs2PWMgfZgUz/zYy0VpbB9VZ7
         YWLA==
X-Gm-Message-State: AOAM531d5q1jU6W8xmykvhCqIEV+IzDYZbF2+q0ntF/n0HnqXSWwe27n
        ZrMuYVI0VoPjFeVJ2fA5fosQHReVFjMZLK5p9amgPMNSCXk=
X-Google-Smtp-Source: ABdhPJzcVP61WUEaAnAwBjuhsWwGyGR6BJHHUVSUWbw7m/xaRAZfrC1VZGALFk2N9t9QVLf6G8Cu01o2eAY3FPJKKik=
X-Received: by 2002:a05:6638:379c:: with SMTP id w28mr11574743jal.81.1619505845560;
 Mon, 26 Apr 2021 23:44:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210426205012.13241-1-jack@suse.cz> <20210426205012.13241-3-jack@suse.cz>
In-Reply-To: <20210426205012.13241-3-jack@suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 27 Apr 2021 09:43:54 +0300
Message-ID: <CAOQ4uxjKD_SGD=6_Ow_Jw1AzgkakgrE=OPBVi9=X+GM0dLehyw@mail.gmail.com>
Subject: Re: [PATCH 2/2] Don't run tests that require block devices for
 virtual filesystems
To:     Jan Kara <jack@suse.cz>
Cc:     fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Apr 26, 2021 at 11:50 PM Jan Kara <jack@suse.cz> wrote:
>
> Some tests require block device based filesystems (e.g. because they
> setup dm device in a particular way). These tests then fail for tmpfs in

I don't understand. _require_dm_target has:

        # require SCRATCH_DEV to be a valid block device with sane BLKFLSBUF
        # behaviour
        _require_block_device $SCRATCH_DEV
        _require_sane_bdev_flush $SCRATCH_DEV

and generic/563 has explicit _require_block_device

Why does tmpfs pass these checks?

> unusual ways (usually trying to call mkfs.tmpfs). Annotate these tests
> as requiring block device based filesystem so that we gracefully exit
> with _notrun. Also there's no point in simulating successful _mkfs_dev
> for such filesystems since the test is unlikely to test anything
> sensible. So delete that workaround from _mkfs_dev.
>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  common/rc         | 28 +++++++++++++---------------
>  tests/generic/081 |  2 +-
>  tests/generic/347 |  2 +-
>  tests/generic/459 |  2 +-
>  tests/generic/470 |  2 +-
>  tests/generic/500 |  2 +-
>  tests/generic/563 |  2 +-
>  tests/generic/620 |  2 +-
>  8 files changed, 20 insertions(+), 22 deletions(-)
>
> diff --git a/common/rc b/common/rc
> index 2dd1b8ad9e35..aa51ccea0be2 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -677,21 +677,6 @@ _mkfs_dev()
>  {
>      local tmp=`mktemp -u`
>      case $FSTYP in
> -    nfs*)
> -       # do nothing for nfs
> -       ;;
> -    9p)
> -       # do nothing for 9p
> -       ;;
> -    virtiofs)
> -       # do nothing for virtiofs
> -       ;;
> -    overlay)
> -       # do nothing for overlay
> -       ;;
> -    pvfs2)
> -       # do nothing for pvfs2
> -       ;;
>      udf)
>          $MKFS_UDF_PROG $MKFS_OPTIONS $* 2>$tmp.mkfserr 1>$tmp.mkfsstd
>         ;;
> @@ -1469,6 +1454,19 @@ _supported_fs()
>         then
>             return
>         fi
> +       if [ "$f" = "blkdev" ]
> +       then
> +           case $FSTYP in
> +           nfs*)
> +           9p)
> +           virtiofs)
> +           overlay)
> +           pvfs2)
> +           tmpfs)
> +               break
> +               ;;
> +           esac
> +       fi
>      done
>
>      _notrun "not suitable for this filesystem type: $FSTYP"
> diff --git a/tests/generic/081 b/tests/generic/081
> index 5dff079852d3..3800a8cf9ef3 100755
> --- a/tests/generic/081
> +++ b/tests/generic/081
> @@ -49,7 +49,7 @@ _cleanup()
>  . ./common/filter
>
>  # real QA test starts here
> -_supported_fs generic
> +_supported_fs blkdev
>  _require_test
>  _require_scratch_nocheck
>  _require_dm_target snapshot
> diff --git a/tests/generic/347 b/tests/generic/347
> index cbc5150a3e54..693f2f8d5ec3 100755
> --- a/tests/generic/347
> +++ b/tests/generic/347
> @@ -56,7 +56,7 @@ _workout()
>  . ./common/rc
>  . ./common/dmthin
>
> -_supported_fs generic
> +_supported_fs blkdev
>  _require_scratch_nocheck
>  _require_dm_target thin-pool
>
> diff --git a/tests/generic/459 b/tests/generic/459
> index a0b1507c28e4..6b37a4f2f056 100755
> --- a/tests/generic/459
> +++ b/tests/generic/459
> @@ -43,7 +43,7 @@ _cleanup()
>
>  # This tests for filesystem lockup not consistency, so don't check for fs
>  # consistency after test
> -_supported_fs generic
> +_supported_fs blkdev
>  _require_scratch_nocheck
>  _require_dm_target thin-pool
>  _require_dm_target snapshot
> diff --git a/tests/generic/470 b/tests/generic/470
> index d925affe60cf..36d047edf1c0 100755
> --- a/tests/generic/470
> +++ b/tests/generic/470
> @@ -34,7 +34,7 @@ _cleanup()
>  rm -f $seqres.full
>
>  # real QA test starts here
> -_supported_fs generic
> +_supported_fs blkdev
>  _require_scratch_nocheck
>  _require_log_writes_dax_mountopt "dax"
>  _require_dm_target thin-pool
> diff --git a/tests/generic/500 b/tests/generic/500
> index 085ddbf3d906..11599e786c41 100755
> --- a/tests/generic/500
> +++ b/tests/generic/500
> @@ -44,7 +44,7 @@ _cleanup()
>  rm -f $seqres.full
>
>  # real QA test starts here
> -_supported_fs generic
> +_supported_fs blkdev
>  _require_scratch_nocheck
>  _require_dm_target thin-pool
>
> diff --git a/tests/generic/563 b/tests/generic/563
> index fe7394c0910c..c0cf9e9e7c97 100755
> --- a/tests/generic/563
> +++ b/tests/generic/563
> @@ -41,7 +41,7 @@ rm -f $seqres.full
>  # real QA test starts here
>
>  # Modify as appropriate.
> -_supported_fs generic
> +_supported_fs blkdev
>  _require_scratch_nocheck
>  _require_cgroup2 io
>  _require_loop
> diff --git a/tests/generic/620 b/tests/generic/620
> index 605594419d6c..6c80849f6457 100755
> --- a/tests/generic/620
> +++ b/tests/generic/620
> @@ -40,7 +40,7 @@ _cleanup()
>  rm -f $seqres.full
>
>  # Modify as appropriate.
> -_supported_fs generic
> +_supported_fs blkdev
>  _require_scratch_size_nocheck $((4 * 1024 * 1024)) #kB
>  _require_scratch_16T_support
>  _require_dmhugedisk
> --
> 2.26.2
>

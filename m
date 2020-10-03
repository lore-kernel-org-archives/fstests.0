Return-Path: <SRS0=D0rD=DK=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF20C4363D
	for <linux-fstests@archiver.kernel.org>; Sat,  3 Oct 2020 09:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 022DE206CA
	for <linux-fstests@archiver.kernel.org>; Sat,  3 Oct 2020 09:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZxx3+cz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725767AbgJCJ53 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 3 Oct 2020 05:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgJCJ53 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 3 Oct 2020 05:57:29 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D42C0613D0
        for <fstests@vger.kernel.org>; Sat,  3 Oct 2020 02:57:28 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id e5so3463985ils.10
        for <fstests@vger.kernel.org>; Sat, 03 Oct 2020 02:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ajjafjLT4az3+TPdgefjjMdFRtslL2j/fTrsEIM5Nhw=;
        b=JZxx3+czx7l/YO34FGCx6h8ZY7U0g80jqfAK0l3LluMd7jRw4XWgt3FxMihBcv0Tri
         3H5yZjlmmdSJcEU0cePP6uDylaOILCZpK4WB6sAfUuWq1jPcHon3TjeCrCZv8JiZjhDe
         o7A4pT6VZKUiOmXNutj2wklDO3lgnNPVS51mrTtHvUfgrjG0yRsUwt/JyLYqwneNNx7d
         kXr22q0PPjxnvXOnIXy2EBGwhyZ4w4mf+0Rpfi++SwnrkNSUt9/r2wg12jwouH26gqjN
         WuN9a7zOHaPv4NRzd3Du1hLGfH58qyAmngLlsZLdd5T4wEm+eS5yKspQqyvUEix4laPq
         oHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ajjafjLT4az3+TPdgefjjMdFRtslL2j/fTrsEIM5Nhw=;
        b=kBJbAvhO4GVUxgzWphFwzQhiBAMq36gD0aKiYm/NYl07S46gCx82e2SUVUHHTGjsUq
         k6utt91TsmfsXeBDmct1gi+/A71ZAm1cuYVmz6ln7QJdDccRdbqBwKkVImNB2yYTS9aw
         wrV1Ow0irL5K5hDqHw7pb2waXLCQUxTfr8xvHBjevdBkN/RqkRwWOHEqHJzHnpx/RGdR
         /492yJ0BWS8faNwkc8t+UsjNgZkhqjak+6TEofWJREpb6NrUVk6zT+lyZTAQOmyL90PZ
         AL2BFpQuvyP2QLUtcnq5Hgm4zrRXLyoKg2DmhnPU+dfPRUHfRGU1aDr17/tGJohPRIWu
         P9rQ==
X-Gm-Message-State: AOAM532ExbuUpTiYq5y2nbnUAu1m/DNwf/s7uDZ5guxOM+LlHmEm3ZMZ
        X9pezJvkvsEH8mPylpa8ogkKBmIaEey8V8zRlDMWQyVmvFU=
X-Google-Smtp-Source: ABdhPJyfcP+Ru7YPFXixXyZb3njZPIk4Q1UaXcEvBz75YGw4p8XEhAgZVba+p19Gm1r+O07/SegN/mD5gVmPAK/cBsY=
X-Received: by 2002:a92:8b41:: with SMTP id i62mr5306420ild.9.1601719047963;
 Sat, 03 Oct 2020 02:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201003033735.32452-1-yangx.jy@cn.fujitsu.com>
In-Reply-To: <20201003033735.32452-1-yangx.jy@cn.fujitsu.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 3 Oct 2020 12:57:17 +0300
Message-ID: <CAOQ4uxj_CDORVFFLm+dP7NuU0gDT7-AtgqOpUAqUzomqqzh0Sg@mail.gmail.com>
Subject: Re: [PATCH] overlay/071: Don't compare inode numbers in lower overlay
 and nested overlay
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Oct 3, 2020 at 6:57 AM Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:
>
> 1) If underlying filesystem is ext4, the lower overlay inodes do not
>    have the MSB set (e.g. file ino 8590721028 = 0x2000C0004) because
>    ext4 has a known inode number limit of 32bit (see ovl_can_decode_fh).
> 2) With nested xino feature, the nested overlay inodes have the MSB set
>    (e.g. file ino 9223372045445496836  = 0x80000002000C0004).
> It is expected different inode numbers which casue the failure of
> overlay/071, so fix this failure by removing the unneeded comparision.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

In case someone is wondering why I added this comparison
to the test in the first place - I have no idea.
Maybe it is a remnant of a sanity test while debugging.
There is no comparison between "lower" to "overlay" inode numbers
in any of the variants of test overlay/017 this test is forked from.
There is no requirement for those inode numbers to be the same.

> ---
>  tests/overlay/071 | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/tests/overlay/071 b/tests/overlay/071
> index ac2324c8..90770936 100755
> --- a/tests/overlay/071
> +++ b/tests/overlay/071
> @@ -194,12 +194,8 @@ mount_dirs
>  record_inode_numbers $SCRATCH_MNT/lowertestdir $tmp.lower.lo
>  record_inode_numbers $SCRATCH_MNT/uppertestdir $tmp.lower.up
>
> -# Compare inode numbers in lower overlay vs. nested overlay
> -# With nested xino lower/lower, all inode numbers overflow xino bits and
> -# d_ino/i_ino in nested overlay are the same as in lower overlay.
> -check_inode_numbers $lowertestdir $tmp.lower.lo $tmp.before.lo
> -
>  # Record inode numbers before copy up from nested upper
> +record_inode_numbers $lowertestdir $tmp.before.lo
>  record_inode_numbers $uppertestdir $tmp.before.up
>
>  # Copy up all files
> --
> 2.25.1
>
>
>

Return-Path: <SRS0=/sVf=2C=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD31EC43603
	for <linux-fstests@archiver.kernel.org>; Thu, 12 Dec 2019 13:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2B021655
	for <linux-fstests@archiver.kernel.org>; Thu, 12 Dec 2019 13:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rIgd0LwE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbfLLNMF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 12 Dec 2019 08:12:05 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:36902 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728996AbfLLNMF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 Dec 2019 08:12:05 -0500
Received: by mail-yw1-f67.google.com with SMTP id z7so574085ywd.4
        for <fstests@vger.kernel.org>; Thu, 12 Dec 2019 05:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dwfS5lkHSUw2lne61fqO6fE/fuZSuL5rveQ+/dk7iCs=;
        b=rIgd0LwEkPZxwG24eVNzvztEaevNIVCnBBslUoNv6YlwLA+1wtkZ8sxaAP6/g6Unhk
         66utO1AhwoDfmNoY+45nlwTHzzy9VoxNQKc2rE5YQGJ1sB/e/JV0iCc8IsaN5OBvTFg3
         pni1Qayf82fyPEh3kefM0LQEviuqdHvxOxBtxLXMEYse5X19hjRyXCWbduALiDasde5T
         6WHXoVeqglM5MTnCV160TAnQrXyryxan8x6xOtID2POhiLrER55bLKfoNhdIyZpzkODS
         oPSL5pHilMFiiF+e7JBN5VU9YTU9EFFj/ij2W4Zq8MeQppkPSzun2xMpZ7f8QOdQ6f4F
         OZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dwfS5lkHSUw2lne61fqO6fE/fuZSuL5rveQ+/dk7iCs=;
        b=AIuYu7VKIaIOL8owEkvNwM5Sj6AL2Tj+MnBrIwoeS4cLRBzACi5nbsphMhmaLw4g8E
         3Ew7sNmzeHqBQPYwUlu8/3VQPRyr+8y+sWF2XNBhClKM+r9La+XQ53KAiq2U+k0YqW2I
         46ASL7X72pSDJEAW4KdBoWmBqldgaEJ7rzHxNqU3XME3oDNgmqAG9AWAo8V2Iwnxl1vm
         RShsEF1S1V150p/XeFBx258E1Wg5qYR5culMZmdKSEIxfvD7/LvWp4Mch9wZcC6oxQ/l
         oyL/bJEFyMIru/2EIsEYX27x7XfxlpHETVtjNvoeLtRjYuLo39duuTO5EG2xr8YAkzbk
         xV0w==
X-Gm-Message-State: APjAAAU50pplnVo26BFCuVh/ZmFfXnpdwl69GjKw71yCIstuqNwlzsPM
        i54f6mvgPsCwdUgFpLXn95Xe/jG8dHKOXv2CetaGVg==
X-Google-Smtp-Source: APXvYqw6M7BkF6J7bJa7lbuDLuR7zCRnv3axmLWMvEU0O7KHvIUM4NLZeWWMqaKNr34ZovYoehfZRNCRn6OCzojrFs4=
X-Received: by 2002:a81:598b:: with SMTP id n133mr3893705ywb.379.1576156324189;
 Thu, 12 Dec 2019 05:12:04 -0800 (PST)
MIME-Version: 1.0
References: <20190719041231.26500-1-deepa.kernel@gmail.com>
In-Reply-To: <20190719041231.26500-1-deepa.kernel@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 12 Dec 2019 15:11:53 +0200
Message-ID: <CAOQ4uxhxVKhUh_P_NffLbGScpiL0wOrCTLwWJWeSbRRNbHzPrg@mail.gmail.com>
Subject: Re: [PATCH] generic/402: fix for updated behavior of timestamp limits
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        y2038@lists.linaro.org, Sasha Levin <sashal@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jul 19, 2019 at 7:21 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> The mount behavior will not be altered because of the unsupported
> timestamps on the filesystems.
>
> Adjust the test accordingly.
>
> An updated series to be posted after the merge window is hosted at
> <https://github.com/deepa-hub/vfs/tree/limits>
>
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> ---
>  common/rc             | 36 +++++++++---------
>  tests/generic/402     | 87 ++++++++++++++++---------------------------
>  tests/generic/402.out |  2 +-
>  3 files changed, 53 insertions(+), 72 deletions(-)
>
> diff --git a/common/rc b/common/rc
> index 25203bb4..39a2deb0 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1959,16 +1959,9 @@ _run_aiodio()
>      return $status
>  }
>
> -# this test requires y2038 sysfs switch and filesystem
> -# timestamp ranges support.
> -_require_y2038()
> +_require_timestamp_range()
>  {
>         local device=${1:-$TEST_DEV}
> -       local sysfsdir=/proc/sys/fs/fs-timestamp-check-on
> -
> -       if [ ! -e $sysfsdir ]; then
> -               _notrun "no kernel support for y2038 sysfs switch"
> -       fi
>

Deepa,

This change, which is already merged removed the test for kernel support
and replaced it with test only for filesystem support.

This impacts people validating stable kernel releases with xfstest, because
this test now always fails on stable kernels and I don't think that timestamp
clamping behavior is going to stable kernels.

Of course stable kernel testers can exclude this test, but this will remove test
coverage and may result in silent breakage of > y2038 timetamps in stable
kernels.

I think test should identify if kernel had clamping behavior and change the
expected timestamp values accordingly, similar to how the test was before
adjusting it to new behavior.

Do you agree? Can you make these changes?

Thanks,
Amir.

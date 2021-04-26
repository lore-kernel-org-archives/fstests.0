Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD654C433ED
	for <linux-fstests@archiver.kernel.org>; Mon, 26 Apr 2021 10:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EFED61165
	for <linux-fstests@archiver.kernel.org>; Mon, 26 Apr 2021 10:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbhDZKIi (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 26 Apr 2021 06:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbhDZKIh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 26 Apr 2021 06:08:37 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52869C061756
        for <fstests@vger.kernel.org>; Mon, 26 Apr 2021 03:07:55 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id t189so718955vkb.4
        for <fstests@vger.kernel.org>; Mon, 26 Apr 2021 03:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uimxQoIa7JbhI8zrNCjhaYnZ0Tb2e0iXvvM6dW4IbuE=;
        b=aBdYNP/dm9/pVxhqnUMI32x3d+qxQquo0dyL+Zdz34FTh+B+qALsDz/zPWO2d1zOUt
         zjacIBOpTIJj5XZo9YGEa6jtNhU536RwusjEc+PeBXYKKYP9RN+oncHLqKTIC9O0cUZH
         AfcygbsLLJioTipEYa8KSUhAm17HLMRXsa5ME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uimxQoIa7JbhI8zrNCjhaYnZ0Tb2e0iXvvM6dW4IbuE=;
        b=fABwurK0XkM17ij6WxOHBIB3h8e4a/zzUdpvDUrvdepHsowoYWnIwXBR4LdKWF97dh
         5p3PnOnl9Lx3Z4Zg2Agca8blUS4Skd5HCqiZqYN3zwOhozgiScb2hhypR3WUQ8NU21P1
         QWDpBdEHFBq2JCZI+SiV+e6yFcCc6risnFBVv9StwF49M6Lw3qG59Ye6joNQBosxvdxu
         ef8W67pydh3NVVl5u3T7KHllNoUCTJ635Ferd8ZVfJrDMm4Et2B/rDbZvFbMJxoaNj0Q
         TppwmM6XB+MeBTGWKc9yG5hjg/M14Z3pLUqrwfuxw8CUBrrkNzgXJHpMr01exk+z2E5D
         Pf+Q==
X-Gm-Message-State: AOAM530OaYV/AiwddcbAp8xuG5yaMV/NMGe7k9625CxR1fcPSLmWs3UZ
        OOSqwe8eBWGxyj0r72a9ZRuzjROUv6wtBZpwxyLEXQ==
X-Google-Smtp-Source: ABdhPJyAZ2yhZUlsD4SclAzGLsqyw1wLcZNh1zV06g1ZQd3bALQYuIVwVnJQAjlp3uXpWTpZNfN9R2kR19/cMrVN610=
X-Received: by 2002:ac5:cb50:: with SMTP id s16mr11244702vkl.14.1619431674482;
 Mon, 26 Apr 2021 03:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210425071445.29547-1-amir73il@gmail.com>
In-Reply-To: <20210425071445.29547-1-amir73il@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 26 Apr 2021 12:07:43 +0200
Message-ID: <CAJfpeguHn32-BJV=986963SCGs8RwBN+fMEfRdwc1d_LFecFxw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Test overlayfs readdir cache
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Eryu Guan <guaneryu@gmail.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Apr 25, 2021 at 9:14 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> Eryu,
>
> This extends the generic t_dir_offset2 helper program to verify
> some cases of missing/stale entries and adds a new generic test which
> passes on overlayfs (and other fs) on upstream kernel.
>
> The overlayfs specific test fails on upstream kernel and the fix commit
> is currently in linux-next.  As usual, you may want to wait with merging
> until the fix commit hits upstream.
>
> Based on feedback from Miklos, I changed the test to check for the
> missing/stale entries on a new fd, while old fd is kept open, because
> POSIX allows for stale/missing entries in the old fd.
>
> I was looking into another speculated bug in overlayfs which involves
> multiple calls to getdents.  Although it turned out that overlayfs does
> not have the speculated bug, I left both generic and overlay test with
> multiple calls to getdents in order to excersize the relevant code.
>
> The attached patch was used to verify that the overlayfs test excercises
> the call to ovl_cache_update_ino() with stale entries.
> Overlayfs populates the merge dir readdir cache with a list of files in
> the first getdents call, but updates d_ino of files on the list in
> subsequent getdents calls.  By that time, the last entry is stale and the
> following warning is printed (on linux-next with patch below applied):
> [   ] overlayfs: failed to look up (m100) for ino (0)
> [   ] overlayfs: failed to look up (f100) for ino (0)
>
> Miklos,
>
> Do you think it is worth the trouble to set p->is_whiteout and skip
> dir_emit() in this case? and do we need to worry about lookup_one_len()
> returning -ENOENT in this case?

So lookup_one_len() first does a cached lookup, and if found returns
that.  If not then it calls the filesystem's ->lookup() callback,
which in this case is ovl_lookup().  AFAICS ovl_lookup() will never
return ENOENT, even if the underlying filesystem does.

Which means it's not necessary to worry about that case.

The other case you found it that in case of a stale direntry the i_ino
update will be skipped and so it will return an inconsistent result,
right?   Fixing that looks worthwhile, yes.

Thanks,
Miklos

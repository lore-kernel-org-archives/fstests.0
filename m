Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCB8C43460
	for <linux-fstests@archiver.kernel.org>; Mon, 26 Apr 2021 13:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA3306052B
	for <linux-fstests@archiver.kernel.org>; Mon, 26 Apr 2021 13:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbhDZNNv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 26 Apr 2021 09:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233376AbhDZNNv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 26 Apr 2021 09:13:51 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED45C061574
        for <fstests@vger.kernel.org>; Mon, 26 Apr 2021 06:13:08 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id x16so131336vsq.2
        for <fstests@vger.kernel.org>; Mon, 26 Apr 2021 06:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6cSCYZMPvFvIIvPWybwb0R74Ie0W9MA3Z010zNhVCzM=;
        b=hLYVgcjzp33wHE1CeiMD9oTKXb5qrS6pfCIEd4hEnYeyml7yASPJesvNAx4i+K30Dg
         NrVrYMzgXacp2faVIJpnnyt0N7oMiKEHBhyUYS5iQMYCHgKf809+eE1aejaykZMNuth/
         eUK9buomMKMzYz7jmZK9gsx43mdIxYDhYW0hE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6cSCYZMPvFvIIvPWybwb0R74Ie0W9MA3Z010zNhVCzM=;
        b=QuEYjOR3+oXRWHCehT/bfpHkeiblSbuip8RKWZLLbJPGWysi4zfm+OkIVKz5n2Vs4Z
         P9Lq4pmn14G8jN8T9y5+WWXnNP2qXq7GV6RrzkUYeoisCWgfK9vSd73liI32Swj6dsen
         4s1wfDNWroKN666ZB9SOxaMHaMFPPop8/ojFnJpqNJvFawkE3081PBdVrCYthqpmCVqz
         7OJotyKmRZOZAo9Cmg/UBlYkqdr3DNX/VFl/Du3Vhy3aroe+uemtcEg42Vwv2HB3TO8D
         pjrOLtc+DjuZSEYzOYiAIisJ04+enaUb5i94WjYnOAwkTvvsPBEIYWNgZ9d0dT/S4ocf
         g3aQ==
X-Gm-Message-State: AOAM531DMHi6mkojXOwypfyYNDF3PmCyqw/V8sYTEWwJUGuWuPvorOz6
        tlRCIQvQyfxdg3h/hp7fm7c2eCFU9eTTzmQw3Z2wyw==
X-Google-Smtp-Source: ABdhPJysY4OLj+iCo294Vgr6gM0QVcZNzovLuEIRVUNcf3HSJoGO79yTiAmNxWd1X9Tpi2P/I3ObL+x92ESGI08rjpY=
X-Received: by 2002:a67:68c5:: with SMTP id d188mr3460068vsc.0.1619442788088;
 Mon, 26 Apr 2021 06:13:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210425071445.29547-1-amir73il@gmail.com> <CAJfpeguHn32-BJV=986963SCGs8RwBN+fMEfRdwc1d_LFecFxw@mail.gmail.com>
 <CAOQ4uxiEx-KcMYdfM9yLygvD5eYgs_58kOvr0NabKqgpB0ybug@mail.gmail.com>
In-Reply-To: <CAOQ4uxiEx-KcMYdfM9yLygvD5eYgs_58kOvr0NabKqgpB0ybug@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 26 Apr 2021 15:12:57 +0200
Message-ID: <CAJfpegvf=6FPgSBfz73Lu+7DV2T8A+E4CzzsNjfqSbmJccY4VA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Test overlayfs readdir cache
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Eryu Guan <guaneryu@gmail.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Apr 26, 2021 at 12:15 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Mon, Apr 26, 2021 at 1:07 PM Miklos Szeredi <miklos@szeredi.hu> wrote:

> > The other case you found it that in case of a stale direntry the i_ino
> > update will be skipped and so it will return an inconsistent result,
> > right?
>
> Right. It returns a stale entry with the old real ino.
> Not sure if that is an "inconsistent" result.
> inconsistent w.r.t what?

It's inconsistent with previous (before the entry got deleted)
st_ino/i_ino.  This should actually be testable.

But it was a long time ago that I fully understood the readdir code,
so I might be missing something.

Thanks,
Miklos

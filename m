Return-Path: <SRS0=LJOt=2K=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FDEC43603
	for <linux-fstests@archiver.kernel.org>; Fri, 20 Dec 2019 22:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298D02146E
	for <linux-fstests@archiver.kernel.org>; Fri, 20 Dec 2019 22:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sVx275mT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfLTWpP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 20 Dec 2019 17:45:15 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:36194 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfLTWpO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 20 Dec 2019 17:45:14 -0500
Received: by mail-il1-f196.google.com with SMTP id b15so9289164iln.3
        for <fstests@vger.kernel.org>; Fri, 20 Dec 2019 14:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HUHvY2ovNDkEoq/r8w4grFsNYqTttbEgQgH77yG6HHo=;
        b=sVx275mT78+3IA19apCSbwF1E88yd3bM63dvgNaqHr4weNKvsFxDFm2qhtuLC7G9zf
         gjMlzLGwDXXfkuPtjD5R1wmP+9bYTVTk5hzUAXRjv5FCnAfFHMLkX/VIl3v9Vw2izx0m
         gqYqZQfHc5h+U/j4ovmQU+KBCdQ9Ltb7xXUIEIRoPC82OsFbw0sItJqoLrVn3A7wHx79
         wvL/ZT/GIlUE9NUHf0din2xaHKRcdGH41n54Q9DWQ0sMlwQcMABoZ0goR08vbc2lP9Tw
         EKmSJOEkabNGp/feI0MVUF+6JQ6BZRiCme4M8yRCDqi992Vzv4Gei0Rmzt6UYy3+lZsn
         xAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HUHvY2ovNDkEoq/r8w4grFsNYqTttbEgQgH77yG6HHo=;
        b=tRv6fx9LKH0/vYMrN6QXNsfSzxk9pNLnjhgjORaxAC/AtYeHqQstVJ5g5CKrVED14t
         5elp929XGyFoIYyWC4Naa26yNwUnazWzUwzSPKD3Kydt8YAlk+nYmVF5IL5PzVgp5FF6
         liuMxRRZMNAg4IlOeN2ijZ5tuIbaFrkbjI3D1UbwFxCkoqHKR5/lqxrdvA8qG/ZUXerF
         8bsLfe6zYDknggtdKCVLlmHw/8kTXKiFIhML8cQAW6eD836KernllIWMfxgdtSfePfHk
         EsENqPgjZGcKm8OfsTr71SiCXG9HGvXomnQqYKddWS3BJgbGm62u1ay035up9aBF18zv
         hc9g==
X-Gm-Message-State: APjAAAXZN3ETOXc7Nkf+hQ1xeby9SBNNQv0FzW93YN8bDXvKGT+BZhZV
        1s/E25lw/0WjHN1t38ppjVadP0ThA5Y1RSS6dzE=
X-Google-Smtp-Source: APXvYqyazoOC9/MOLaT9EckeD8fePsWe44YvftlHRynvQ4n1ZrD16UhBDZJxQ4Jlm8C+BHzPNVxEVnIziorbI/z5hNs=
X-Received: by 2002:a92:1906:: with SMTP id 6mr15126137ilz.130.1576881913470;
 Fri, 20 Dec 2019 14:45:13 -0800 (PST)
MIME-Version: 1.0
References: <20190719041231.26500-1-deepa.kernel@gmail.com>
 <CAOQ4uxhxVKhUh_P_NffLbGScpiL0wOrCTLwWJWeSbRRNbHzPrg@mail.gmail.com>
 <CABeXuvoHw8W02JsmZjafnQkOs1=0dodSpBFyJ_Gq+1vs+hFkQQ@mail.gmail.com>
 <CABeXuvqO=04BJw2bWa6d2fv1FTe-B_JsNhVdYTwT=fY=ncOCkw@mail.gmail.com>
 <CAOQ4uxjaFBZZUKyu6YS08ta8pdW_FSjRYA4J7S8+_=Gfi-kO2Q@mail.gmail.com>
 <CAK8P3a1fYPq6DCqhT6ziJaxETLHt8uUgbHWryHiD4kQWwKLp2Q@mail.gmail.com> <CAOQ4uxjaqV=d9SPYPPODOT0MNpSARQNQW0=4qb8N4u7ni-hupg@mail.gmail.com>
In-Reply-To: <CAOQ4uxjaqV=d9SPYPPODOT0MNpSARQNQW0=4qb8N4u7ni-hupg@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Fri, 20 Dec 2019 14:45:00 -0800
Message-ID: <CABeXuvq+37-WO8KH5en-1LaSGOLbw9zziC4eAqGvpJwe85kudQ@mail.gmail.com>
Subject: Re: [Y2038] [PATCH] generic/402: fix for updated behavior of
 timestamp limits
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sashal@kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        fstests <fstests@vger.kernel.org>, Eryu Guan <guaneryu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

> Deepa,
>
> You added this warning:
> pr_warn("Mounted %s file system at %s supports timestamps until ...
> along with timestamp clamping
>
> I suggest that you implement kernel support check based on grepping
> for this warning after loop mounting an ext2 test image.
> A bit over the top and ugly, but the test should be reliable and
> mkfs.ext2 is probably available in all xfstest deployments.
>
> xfs/049 makes use of an ext2 loop mount, so your test won't be the
> first one to use ext2 for testing other fs.

Ok, this can work. Let me give this a try.

Thanks,
Deepa

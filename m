Received: from mail-yw0-f170.google.com ([209.85.161.170]:57295 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751688AbdKLJu5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 12 Nov 2017 04:50:57 -0500
Received: by mail-yw0-f170.google.com with SMTP id r186so2818460ywe.13
        for <fstests@vger.kernel.org>; Sun, 12 Nov 2017 01:50:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5a080ffd.958d620a.7689f.68d1@mx.google.com>
References: <5a080ffd.958d620a.7689f.68d1@mx.google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 12 Nov 2017 11:50:55 +0200
Message-ID: <CAOQ4uxgveiWmid80JCQaozT4eYQiMyJjYTQkmVYFnk0cB9iuyg@mail.gmail.com>
Subject: Re: [ANNOUNCE] fstests: master branch updated to 1e24e5173efa
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests <fstests@vger.kernel.org>, Jeff Layton <jlayton@poochiereds.net>, "J. Bruce Fields" <bfields@fieldses.org>
List-ID: <fstests@vger.kernel.org>

On Sun, Nov 12, 2017 at 11:09 AM, Eryu Guan <guaneryu@gmail.com> wrote:
> Hi all,
>
> The master branch of the xfstests repository at:
>
>         git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
>
> have just been updated. This update contains a new open_by_handle test from
> Amir and the remaining bits from Darrick to prepare for v4.15 merge window.
> Other commits are random bug fixes.
>
> New failures I've noticed in this update:
> - generic/467 fails on NFSv3 and NFSv4.0 (passes on NFSv4.[12] though)

Can you please share the failure errors on NFSv3.

Test is also failing on tmpfs, which was acknowledged by nfsd maintainers
as a tmpfs bug or at least very undesired behavior for exported tmpfs.

Thanks,
Amir.

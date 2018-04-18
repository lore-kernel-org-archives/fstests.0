Received: from mail-ot0-f170.google.com ([74.125.82.170]:39366 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752733AbeDROXT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 18 Apr 2018 10:23:19 -0400
Received: by mail-ot0-f170.google.com with SMTP id a14-v6so2098719otf.6
        for <fstests@vger.kernel.org>; Wed, 18 Apr 2018 07:23:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1524061018-20413-1-git-send-email-amir73il@gmail.com>
References: <1524061018-20413-1-git-send-email-amir73il@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 18 Apr 2018 16:23:18 +0200
Message-ID: <CAJfpegsQ01V9Jyboy+9W9eahMDNM7nggLHFkbD=13hNhX+Du0g@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix failing overlay nonsamefs fstests
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Eryu Guan <eguan@redhat.com>, overlayfs <linux-unionfs@vger.kernel.org>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Apr 18, 2018 at 4:16 PM, Amir Goldstein <amir73il@gmail.com> wrote:

> FYI, Miklos has a patch set in review to fix the last of the
> non-standard behavior tracking test that is still failing (overlay/016).
> After that patch set is merged, all overlay tests will be expected to
> pass on master - new era ;-)

Oh, we can write new tests that don't pass ;)

For example -ostrictatime mounts are not going to behave POSIX'ly (and
probably nobody cares, but still).  And we have that minor weirdness
with directory nlink being constant 1.   And probably some others.

Not that there's a hurry to test these... So yeah, having all tests
pass would be nice :)

Thanks,
Miklos

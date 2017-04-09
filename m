Received: from mail-oi0-f65.google.com ([209.85.218.65]:33146 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751825AbdDIKGL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 9 Apr 2017 06:06:11 -0400
Received: by mail-oi0-f65.google.com with SMTP id t63so2935373oih.0
        for <fstests@vger.kernel.org>; Sun, 09 Apr 2017 03:06:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <58ea0380.c78e630a.22dd3.a5d5@mx.google.com>
References: <58ea0380.c78e630a.22dd3.a5d5@mx.google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 9 Apr 2017 13:06:10 +0300
Message-ID: <CAOQ4uxjz9hvj3RuHEj8apvG3onVPCZYd6USBznKh5z7m7u_8Wg@mail.gmail.com>
Subject: Re: [ANNOUNCE] fstests: master branch updated to a589a208405d
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Sun, Apr 9, 2017 at 12:48 PM, Eryu Guan <guaneryu@gmail.com> wrote:
> Hi all,
>
> The master branch of the xfstests repository at:
>
>         git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
>
> have just been updated. This is a normal update that has two new tests added,
> one generic test and one overlay test, and other improvements and bug fixes.
> Note that IRIX support is removed in the new test template, eventually we may
> want to remove whole IRIX support.
>
> New failures I've noticed in this update:
> - overlay/030 fails as append-only dirs are not honored in truncate operation

Actually, it's append-only regular files that are not honored.
chattr +a on directories seems to be honored correctly.
One of my earlier emails had some wrong statements wrt directories
which may have confused you.

>
> Thanks,
> Eryu
>
> The new head of the master branch is commit:
>
> a589a208405d src/t_immutable: add ftruncate to append only tests
>
> New commits:
>
> Amir Goldstein (4):
>       [e1a49994e579] fstests: _require_chattr() must get an input arg
>       [8a8a4b95b25c] generic/079: use _require_test_program
>       [941ea73ec3c5] overlay: test immutable and append-only upper files
>       [a589a208405d] src/t_immutable: add ftruncate to append only tests
>
> Filipe Manana (3):
>       [a62c85dbabf3] common/rc: check fs supports xfs_io falloc's specific flags
>       [c7cbc1cd614a] generic: test for number of bytes used by files after buffered writes
>       [f3c84f3d553e] generic/071: check if fs supports fallocate KEEP_SIZE flag
>
> Qu Wenruo (1):
>       [073b2def71ff] fstests: Remove IRIX os support from template
>
>
> Code Diffstat:
>
>  common/rc             |  27 ++++++-----
>  new                   |   2 +-
>  src/t_immutable.c     |  15 ++++++
>  tests/generic/071     |   2 +-
>  tests/generic/079     |   6 +--
>  tests/generic/422     | 127 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/422.out |  41 ++++++++++++++++
>  tests/generic/group   |   1 +
>  tests/overlay/027     |   2 +-
>  tests/overlay/030     |  73 +++++++++++++++++++++++++++++
>  tests/overlay/030.out |   5 ++
>  tests/overlay/group   |   1 +
>  12 files changed, 283 insertions(+), 19 deletions(-)
> --
> Eryu Guan
> eguan@redhat.com

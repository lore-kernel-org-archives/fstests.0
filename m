Received: from mail-oi0-f47.google.com ([209.85.218.47]:36284 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751493AbcLRHzV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 18 Dec 2016 02:55:21 -0500
Received: by mail-oi0-f47.google.com with SMTP id v84so117982759oie.3
        for <fstests@vger.kernel.org>; Sat, 17 Dec 2016 23:55:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201612180708.uBI78GRO017851@int-mx14.intmail.prod.int.phx2.redhat.com>
References: <201612180708.uBI78GRO017851@int-mx14.intmail.prod.int.phx2.redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 18 Dec 2016 09:55:20 +0200
Message-ID: <CAOQ4uxhHYmQzV1dMFZ2zB5C7eevNfWiozD2mBZZaYmzLjmx0rA@mail.gmail.com>
Subject: Re: [ANNOUNCE] fstests: master branch updated to c1cd6b1d57e1
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Sun, Dec 18, 2016 at 9:08 AM, Eryu Guan <eguan@redhat.com> wrote:
> Hi all,
>
> The master branch of the xfstests repository at:
>
>         git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
>
> have just been updated. There're new generic and overlay tests in this update,
> as well as generic, overlay and reflink test fixes, and improvements on
> excluding tests. Many thanks to Amir who has contributed 5 patches, including
> new overlay tests and fixes and bug fix to check, also many thanks to others
> who has contributed patches and reviewed patches!
>
> New failure I noticed in this update:
> - overlay/017,8 are new cases that fail on current Linus tree (4.9)

Yes, as you know, fixes for these use cases are still in early stages of design.
FYI, test overlay/016 is also bound to fail on 4.9 as well as on upcoming
4.10-rc1. A fix was included in 4.10 pull request, but its merge was deferred
to next merge window.

The reason that you still don't see the failure of overlay/016 is because
Dave's fix for xfs_io "open" was not yet merged and test overlay/016 has:
_require_xfs_io_command "open"


>
> Thanks,
> Eryu
>
> The new head of the master branch is commit:
>
> c1cd6b1d57e1 generic: make sure file size resource limit is honored by fs
>
> New commits:
>
> Amir Goldstein (5):
>       [2257d91fe4a5] check: fix excluding test groups
>       [131db6b27139] overlay/016: do not cd into $SCRATCH_MNT
>       [fa8ec339e6cf] overlay: test unstable inode number
>       [f69c41e5df58] overlay: associate tests to copyup group
>       [d6e6c05c45bc] overlay: test hardlink breakage on copy up
>
> Darrick J. Wong (1):
>       [f613638308c9] reflink: don't test disjoint block sharing sets
>
> Eric Biggers (1):
>       [84db46e3d327] generic/062: don't assume same readdir order after re-creating directory
>
> Eryu Guan (1):
>       [c1cd6b1d57e1] generic: make sure file size resource limit is honored by fs
>
> Wang Xiaoguang (1):
>       [815015e9ee82] generic: make 17[1-4] work well when btrfs compression is enabled
>
>
> Code Diffstat:
>
>  check                 | 29 ++++++++-------
>  common/populate       | 67 ++++++++++++++++++++++++++++++++++
>  common/reflink        |  9 +++++
>  tests/generic/062     |  7 ++--
>  tests/generic/119     |  1 +
>  tests/generic/171     |  4 +--
>  tests/generic/172     |  5 +--
>  tests/generic/173     |  4 +--
>  tests/generic/174     |  4 +--
>  tests/generic/256     | 66 ++++------------------------------
>  tests/generic/394     | 73 +++++++++++++++++++++++++++++++++++++
>  tests/generic/394.out |  2 ++
>  tests/generic/group   |  1 +
>  tests/overlay/016     | 13 ++++---
>  tests/overlay/016.out |  4 +--
>  tests/overlay/017     | 99 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/overlay/017.out |  7 ++++
>  tests/overlay/018     | 89 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/overlay/018.out |  2 ++
>  tests/overlay/group   |  6 ++--
>  20 files changed, 399 insertions(+), 93 deletions(-)
> --
> Eryu Guan
> eguan@redhat.com

Received: from mail-ot0-f195.google.com ([74.125.82.195]:33917 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750770AbdAVGFi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 22 Jan 2017 01:05:38 -0500
Received: by mail-ot0-f195.google.com with SMTP id 73so11990089otj.1
        for <fstests@vger.kernel.org>; Sat, 21 Jan 2017 22:05:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201701220526.v0M5QnTT003455@int-mx13.intmail.prod.int.phx2.redhat.com>
References: <201701220526.v0M5QnTT003455@int-mx13.intmail.prod.int.phx2.redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 22 Jan 2017 08:05:37 +0200
Message-ID: <CAOQ4uxhKoVhwGLqLXy5zPwBGhGOK=j+eEhse5wVbTO7XgaNJgw@mail.gmail.com>
Subject: Re: [ANNOUNCE] fstests: master branch updated to 8485d738b418
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Sun, Jan 22, 2017 at 7:26 AM, Eryu Guan <eguan@redhat.com> wrote:
> Hi all,
>
> The master branch of the xfstests repository at:
>
>         git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
>
> have just been updated. There're new generic, overlay and btrfs tests in this
> update, and as usual, various fixes.
>
> New failures I've noticed in this update:
> - xfs/348 fails, new tests added to it but the fixes are not in Linus tree yet

Perhaps worth mentioning that xfs/348 will ASSERT kernel with XFS_DEBUG=y
Fix is in Linus' master, heading for rc5

> - btrfs/13[3-5], these new btrfs incremental send tests fail
> - generic/405 fails on extN filesystems, it's an e2fsprogs bug
>
> Thanks,
> Eryu
>
> The new head of the master branch is commit:
>
> 8485d738b418 btrfs: incremental send after replacing directory
>
> New commits:
>
> Amir Goldstein (3):
>       [91e16aa7c502] overlay: test concurrent copy up
>       [707a5890cadb] xfs: test fstat with malformed inode mode
>       [9b80c46ed0d3] xfs: test readlink/readdir with malformed inode mode
>
> Boyang Xue (2):
>       [6f4776c4b50b] common/dmthin: call $UDEV_SETTLE_PROG before 'dmsetup remove'
>       [66768bcaec8c] generic/405: test mkfs against thin provision device
>
> Christoph Hellwig (1):
>       [8c3d7ebd2390] xfs/004: account for XFS reservations changes in 4.10-rc
>
> David Sterba (1):
>       [acb8acd2367a] common/btrfs: add helper to detect dump-super or btrfs-show-super
>
> Eric Sandeen (1):
>       [2ad516747539] tools: compare-failures script
>
> Filipe Manana (3):
>       [6fc65f42eb9b] btrfs: incremental send after replacing a top level inode
>       [7cf665d9a422] btrfs: incremental send after moving a directory
>       [8485d738b418] btrfs: incremental send after replacing directory
>
> Lakshmipathi.G (1):
>       [8a0831c03ce5] README: Fix Quick start typo
>
> Xiao Yang (1):
>       [3241b54ed48e] common/rc: Fix _supports_filetype function
>
>
> Code Diffstat:
>
>  README                 |   5 +-
>  common/btrfs           |  11 ++++
>  common/dmthin          |   3 +
>  common/rc              |   6 +-
>  tests/btrfs/011        |   2 +-
>  tests/btrfs/133        | 127 +++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/133.out    |   8 +++
>  tests/btrfs/134        | 125 ++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/134.out    |   6 ++
>  tests/btrfs/135        | 159 +++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/135.out    |   8 +++
>  tests/btrfs/group      |   3 +
>  tests/generic/405      |  73 +++++++++++++++++++++++
>  tests/generic/405.out  |   2 +
>  tests/generic/group    |   1 +
>  tests/overlay/021      | 135 +++++++++++++++++++++++++++++++++++++++++
>  tests/overlay/021.out  |   2 +
>  tests/overlay/group    |   1 +
>  tests/xfs/004          |  23 ++-----
>  tests/xfs/348          |  25 ++++++++
>  tests/xfs/348.out      | 112 ++++++++++++++++++++++++++++++++++
>  tools/compare-failures |  67 +++++++++++++++++++++
>  22 files changed, 882 insertions(+), 22 deletions(-)
> --
> Eryu Guan
> eguan@redhat.com

Received: from mail-pf1-f195.google.com ([209.85.210.195]:43668 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730078AbeKEBZH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 4 Nov 2018 20:25:07 -0500
Date: Mon, 5 Nov 2018 00:09:31 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH 0/7] fstests: test Btrfs swapfile support
Message-ID: <20181104160931.GE12788@desktop>
References: <cover.1541193856.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1541193856.git.osandov@fb.com>
Sender: fstests-owner@vger.kernel.org
To: Omar Sandoval <osandov@osandov.com>
Cc: fstests@vger.kernel.org, kernel-team@fb.com, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Nov 02, 2018 at 02:29:35PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> This series fixes a couple of generic swapfile tests and adds some
> Btrfs-specific swapfile tests. Btrfs swapfile support is scheduled for
> 4.21 [1].
> 
> 1: https://www.spinics.net/lists/linux-btrfs/msg83454.html
> 
> Thanks!

Thanks for the fixes and new tests!

> 
> Omar Sandoval (7):
>   generic/{472,496,497}: fix $seeqres typo
>   generic/{472,496}: fix swap file creation on Btrfs

I've merged above two patches, they're two obvious bug fixes.

>   btrfs: test swap file activation restrictions
>   btrfs: test invalid operations on a swap file
>   btrfs: test swap files on multiple devices
>   btrfs: test device add/remove/replace with an active swap file
>   btrfs: test balance and resize with an active swap file

These tests look fine to me, but it'd be really great if btrfs folks
could help review above tests and provide Reviewed-by tags.

And perhaps we could add test 17[56] to 'volume' group, as they do
device operations. And similarly, add the last test to 'balance' group.

Thanks,
Eryu

> 
>  tests/btrfs/173     | 55 ++++++++++++++++++++++++++++++
>  tests/btrfs/173.out |  5 +++
>  tests/btrfs/174     | 66 ++++++++++++++++++++++++++++++++++++
>  tests/btrfs/174.out | 10 ++++++
>  tests/btrfs/175     | 73 ++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/175.out |  8 +++++
>  tests/btrfs/176     | 82 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/176.out |  5 +++
>  tests/btrfs/177     | 64 +++++++++++++++++++++++++++++++++++
>  tests/btrfs/177.out |  6 ++++
>  tests/btrfs/group   |  5 +++
>  tests/generic/472   | 16 ++++-----
>  tests/generic/496   |  8 ++---
>  tests/generic/497   |  2 +-
>  14 files changed, 391 insertions(+), 14 deletions(-)
>  create mode 100755 tests/btrfs/173
>  create mode 100644 tests/btrfs/173.out
>  create mode 100755 tests/btrfs/174
>  create mode 100644 tests/btrfs/174.out
>  create mode 100755 tests/btrfs/175
>  create mode 100644 tests/btrfs/175.out
>  create mode 100755 tests/btrfs/176
>  create mode 100644 tests/btrfs/176.out
>  create mode 100755 tests/btrfs/177
>  create mode 100644 tests/btrfs/177.out
> 
> -- 
> 2.19.1
> 

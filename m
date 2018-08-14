Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54966 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727670AbeHNJl1 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 14 Aug 2018 05:41:27 -0400
Date: Tue, 14 Aug 2018 14:55:35 +0800
From: Xiong Murphy Zhou <xzhou@redhat.com>
Subject: Re: [ANNOUNCE] fstests: master branch updated to c2c34214652a
Message-ID: <20180814065535.5t5iyymkzwaxdew2@XZHOUW.usersys.redhat.com>
References: <5b704fe0.1c69fb81.4f152.ebd0@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b704fe0.1c69fb81.4f152.ebd0@mx.google.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi Eryu,

On Sun, Aug 12, 2018 at 11:18:51PM +0800, Eryu Guan wrote:
> Hi all,
> 
> The master branch of the xfstests repository at:
> 
> 	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> 
> have just been updated. This is a normal update that contains two new tests
> (generic and btrfs test) and three minor bug fixes. Please note that the two
> new tests both fail currently, hopefully the fixes all will be landed in 4.19
> kernel.

Thanks very much for the re-wording!

Xiong

> 
> Thanks,
> Eryu
> 
> The new head of the master branch is commit:
> 
> c2c34214652a generic: show locks info owned by dead process
> 
> New commits:
> 
> Filipe Manana (1):
>       [7931e0696c8e] btrfs: test writing into unwritten extent right before snapshotting
> 
> Lu Fengqi (1):
>       [aa0b82a9fd97] src/stat_test: fix undefined reference to `xfstests_statx'
> 
> Omar Sandoval (1):
>       [ed6826096002] generic/228: fix restoration of kernel.core_pattern sysctl
> 
> Xiong Murphy Zhou (1):
>       [c2c34214652a] generic: show locks info owned by dead process
> 
> Zorro Lang (1):
>       [a4f1e0a585fd] xfs/288: notrun if xfs_db write command fails
> 
> 
> Code Diffstat:
> 
>  src/statx.h           |  2 +-
>  tests/btrfs/170       | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/170.out   |  8 ++++++
>  tests/btrfs/group     |  1 +
>  tests/generic/228     |  2 +-
>  tests/generic/504     | 59 ++++++++++++++++++++++++++++++++++++++++
>  tests/generic/504.out |  2 ++
>  tests/generic/group   |  1 +
>  tests/xfs/288         |  8 ++++++
>  9 files changed, 156 insertions(+), 2 deletions(-)
> --
> Eryu Guan
> guaneryu@gmail.com

Received: from mail-pf1-f193.google.com ([209.85.210.193]:34498 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfF1JrV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 28 Jun 2019 05:47:21 -0400
Received: by mail-pf1-f193.google.com with SMTP id c85so2717443pfc.1
        for <fstests@vger.kernel.org>; Fri, 28 Jun 2019 02:47:21 -0700 (PDT)
Date: Fri, 28 Jun 2019 17:47:14 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH 4/5] shared,generic: move shared/006 to generic/
Message-ID: <20190628094714.GE7943@desktop>
References: <20190623230956.24670-1-tytso@mit.edu>
 <20190623230956.24670-4-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190623230956.24670-4-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Jun 23, 2019 at 07:09:55PM -0400, Theodore Ts'o wrote:
> The shared/006 uses _scratch_mkfs_sized to create a limited size file
> system, and then creates inodes until it gets ENOSPC, and then checks
> to make sure the file system is consistent.  It then remounts the file
> system, removes all of the files, and makes sure the file system is
> consistent afterwards.
> 
> This test was marked as only being supported on ext[234] and xfs, and
> so it was in shared.  However, I've tested and this test works just
> fine on btrfs, ubifs, tmpfs, and should work on all file systems that

This is because the $free_inode is 0 and $loop is 1, so we end up
creating only 1000 files in the test without hitting ENOSPC at all.

Perhaps we could introduce a new require rule to check if fs supports
fixed inode number (just check if '_get_free_inode $TEST_DIR' returns
non-zero).

> support _scratch_mkfs_sized, since even if there isn't a fixed inode
> table, the file system will eventually run out of disk space.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  tests/{shared/006 => generic/558} | 4 +---
>  tests/generic/558.out             | 2 ++
>  tests/generic/group               | 1 +
>  tests/shared/006.out              | 2 --
>  tests/shared/group                | 1 -
>  5 files changed, 4 insertions(+), 6 deletions(-)
>  rename tests/{shared/006 => generic/558} (96%)
>  create mode 100644 tests/generic/558.out
>  delete mode 100644 tests/shared/006.out
> 
> diff --git a/tests/shared/006 b/tests/generic/558
> similarity index 96%
> rename from tests/shared/006
> rename to tests/generic/558
> index aa65e9a2..8bfc65fa 100755
> --- a/tests/shared/006
> +++ b/tests/generic/558
> @@ -2,7 +2,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Copyright (c) 2014 Red Hat Inc.  All Rights Reserved.
>  #
> -# FS QA Test No. shared/006
> +# FS QA Test No. generic/558
>  #
>  # Stress test fs by using up all inodes and check fs.
>  #
> @@ -42,9 +42,7 @@ create_file()
>  . ./common/filter
>  
>  # real QA test starts here
> -_supported_fs ext4 ext3 ext2 xfs

_supported_fs generic

Thanks,
Eryu

>  _supported_os Linux
> -
>  _require_scratch
>  
>  rm -f $seqres.full
> diff --git a/tests/generic/558.out b/tests/generic/558.out
> new file mode 100644
> index 00000000..9a6c4e79
> --- /dev/null
> +++ b/tests/generic/558.out
> @@ -0,0 +1,2 @@
> +QA output created by 558
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index 543c0627..8fc85b63 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -560,3 +560,4 @@
>  555 auto quick cap
>  556 auto quick casefold
>  557 auto quick log
> +558 auto enospc
> diff --git a/tests/shared/006.out b/tests/shared/006.out
> deleted file mode 100644
> index 675c1b7c..00000000
> --- a/tests/shared/006.out
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -QA output created by 006
> -Silence is golden
> diff --git a/tests/shared/group b/tests/shared/group
> index 3507d7d4..2cf910bd 100644
> --- a/tests/shared/group
> +++ b/tests/shared/group
> @@ -4,7 +4,6 @@
>  # - comment line before each group is "new" description
>  #
>  002 auto metadata quick log
> -006 auto enospc
>  008 auto stress dedupe
>  009 auto stress dedupe
>  010 auto stress dedupe
> -- 
> 2.22.0
> 

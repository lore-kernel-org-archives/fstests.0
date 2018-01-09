Received: from mx2.suse.de ([195.135.220.15]:33678 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751592AbeAIO7j (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 9 Jan 2018 09:59:39 -0500
Subject: Re: [PATCH] generic/015: Change the test filesystem size to 101mb
References: <1515401010-26802-1-git-send-email-nborisov@suse.com>
From: Nikolay Borisov <nborisov@suse.com>
Message-ID: <6de2f198-91d7-f71f-47d1-d8a6846401ff@suse.com>
Date: Tue, 9 Jan 2018 16:59:37 +0200
MIME-Version: 1.0
In-Reply-To: <1515401010-26802-1-git-send-email-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On  8.01.2018 10:43, Nikolay Borisov wrote:
> This test has been failing for btrfs for quite some time,
> at least since 4.7. There are 2 implementation details of btrfs that
> it exposes:
> 
> 1. Currently btrfs filesystem under 100mb are created in Mixed block
> group mode. Freespace accounting for it is not 100% accurate - I've
> observed around 100-200kb discrepancy between a newly created filesystem,
> then writing a file and deleting it and checking the free space. This
> falls within %3 and not %1 as hardcoded in the test. 
> 
> 2. BTRFS won't flush it's delayed allocation on file deletion if less
> than 32mb are deleted. On such files we need to perform sync (missing
> in the test) or wait until time elapses for transaction commit.
> 
> Since mixed mode is somewhat deprecated and btrfs is not really intended
> to be used on really small devices let's just adjust the test to
> create a 101mb fs, which doesn't use mixed mode and really test
> freespace accounting.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

After further experimentation this test is indeed hitting a very
pathological edge case. So when we create a btrfs file system in mixed
mode with default raid levels the system chunk occupies 0-4mb. As such
we can never allocate a chunk which spans this range so the -1mb in
btrfs_calc_avail_data_space is not required in this case. Anyway, I
believe this to be a really minor nuisance not worth complicating the
code to fix, so I'd suggest this test change be merged.

> ---
>  tests/generic/015 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/015 b/tests/generic/015
> index 78f2b13..416c4ae 100755
> --- a/tests/generic/015
> +++ b/tests/generic/015
> @@ -53,7 +53,7 @@ _supported_os Linux
>  _require_scratch
>  _require_no_large_scratch_dev
>  
> -_scratch_mkfs_sized `expr 50 \* 1024 \* 1024` >/dev/null 2>&1 \
> +_scratch_mkfs_sized `expr 101 \* 1024 \* 1024` >/dev/null 2>&1 \
>      || _fail "mkfs failed"
>  _scratch_mount || _fail "mount failed"
>  out=$SCRATCH_MNT/fillup.$$
> 

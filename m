Received: from userp2120.oracle.com ([156.151.31.85]:50300 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfFKWYj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 11 Jun 2019 18:24:39 -0400
Date: Tue, 11 Jun 2019 15:24:34 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] fstests: don't oom the box opening tmpfiles (take 2)
Message-ID: <20190611222434.GJ1688126@magnolia>
References: <20190609171229.27779-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190609171229.27779-1-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Eryu Guan <guaneryu@gmail.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Jun 09, 2019 at 08:12:29PM +0300, Amir Goldstein wrote:
> For the t_open_tmpfiles tests that run multiple jobs in parallel,
> limit ourselves to half of file-max for all jobs combined,
> so that we don't OOM the test machine.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

LGTM ...
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
> 
> Eryu,
> 
> Reducing max allowed file by factor of 2 wasn't good enough for the
> multi jobs variants of the tests. They still OOM mytest machine
> (with 2GB RAM).
> 
> Thanks,
> Amir.
> 
>  tests/generic/531 | 4 ++--
>  tests/xfs/502     | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/generic/531 b/tests/generic/531
> index 8ce4cc93..ea77eec2 100755
> --- a/tests/generic/531
> +++ b/tests/generic/531
> @@ -41,10 +41,10 @@ _scratch_mount
>  # Try to load up all the CPUs, two threads per CPU.
>  nr_cpus=$(( $(getconf _NPROCESSORS_ONLN) * 2 ))
>  
> -# Set ULIMIT_NOFILE to min(file-max / 2, 50000 files per LOAD_FACTOR)
> +# Set ULIMIT_NOFILE to min(file-max / $nr_cpus / 2, 50000 files per LOAD_FACTOR)
>  # so that this test doesn't take forever or OOM the box
>  max_files=$((50000 * LOAD_FACTOR))
> -max_allowable_files=$(( $(cat /proc/sys/fs/file-max) / 2 ))
> +max_allowable_files=$(( $(cat /proc/sys/fs/file-max) / $nr_cpus / 2 ))
>  test $max_allowable_files -gt 0 && test $max_files -gt $max_allowable_files && \
>  	max_files=$max_allowable_files
>  ulimit -n $max_files
> diff --git a/tests/xfs/502 b/tests/xfs/502
> index 0a7921a3..1b747a1a 100755
> --- a/tests/xfs/502
> +++ b/tests/xfs/502
> @@ -43,10 +43,10 @@ _scratch_mount
>  # Load up all the CPUs, two threads per CPU.
>  nr_cpus=$(( $(getconf _NPROCESSORS_ONLN) * 2 ))
>  
> -# Set ULIMIT_NOFILE to min(file-max / 2, 30000 files per cpu per LOAD_FACTOR)
> +# Set ULIMIT_NOFILE to min(file-max / $nr_cpus / 2, 30000 files per cpu per LOAD_FACTOR)
>  # so that this test doesn't take forever or OOM the box
>  max_files=$((30000 * LOAD_FACTOR))
> -max_allowable_files=$(( $(cat /proc/sys/fs/file-max) / 2 ))
> +max_allowable_files=$(( $(cat /proc/sys/fs/file-max) / $nr_cpus / 2 ))
>  test $max_allowable_files -gt 0 && test $max_files -gt $max_allowable_files && \
>  	max_files=$max_allowable_files
>  ulimit -n $max_files
> -- 
> 2.17.1
> 

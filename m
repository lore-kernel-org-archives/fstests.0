Received: from sandeen.net ([63.231.237.45]:60756 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbeIMVil (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 13 Sep 2018 17:38:41 -0400
Subject: Re: [PATCH] shared/010: avoid dedupe testing blocked on large fs
References: <20180912101547.28835-1-zlang@redhat.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <2fc0ab97-1fb1-7502-6eff-fbfbbade05d5@sandeen.net>
Date: Thu, 13 Sep 2018 11:28:26 -0500
MIME-Version: 1.0
In-Reply-To: <20180912101547.28835-1-zlang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 9/12/18 5:15 AM, Zorro Lang wrote:
> When test on large fs (--large-fs), xfstests preallocates a large
> file in SCRATCH_MNT/ at first. Duperemove will take too long time
> to deal with that large file (many days on 500T XFS). So move
> working directory to a sub-dir underlying $SCRATCH_MNT/.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>

Looks fine to me - 

Reviewed-by: Eric Sandeen <sandeen@redhat.com>

But - I'm not sure what you mean about "testdir?"

> ---
> 
> Hi,
> 
> Besides fix this issue, this patch fix another issue passingly. I left
> a bad variable named "testdir" in this case. This patch can fix it.
> 
> If maintainer feels I should fix it in another patch, please tell me:-P
> 
> Thanks,
> Zorro
> 
>  tests/shared/010 | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/shared/010 b/tests/shared/010
> index 1817081b..04f55890 100755
> --- a/tests/shared/010
> +++ b/tests/shared/010
> @@ -65,15 +65,17 @@ function end_test()
>  sleep_time=$((50 * TIME_FACTOR))
>  
>  # Start fsstress
> +testdir="$SCRATCH_MNT/dir"
> +mkdir $testdir
>  fsstress_opts="-r -n 1000 -p $((5 * LOAD_FACTOR))"
> -$FSSTRESS_PROG $fsstress_opts -d $SCRATCH_MNT -l 0 >> $seqres.full 2>&1 &
> +$FSSTRESS_PROG $fsstress_opts -d $testdir -l 0 >> $seqres.full 2>&1 &
>  dedup_pids=""
>  dupe_run=$TEST_DIR/${seq}-running
>  # Start several dedupe processes on same directory
>  touch $dupe_run
>  for ((i = 0; i < $((2 * LOAD_FACTOR)); i++)); do
>  	while [ -e $dupe_run ]; do
> -		$DUPEREMOVE_PROG -dr --dedupe-options=same $SCRATCH_MNT/ \
> +		$DUPEREMOVE_PROG -dr --dedupe-options=same $testdir \
>  			>>$seqres.full 2>&1
>  	done &
>  	dedup_pids="$! $dedup_pids"
> 

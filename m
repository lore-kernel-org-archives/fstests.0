Received: from mx2.suse.de ([195.135.220.15]:38713 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758848AbdKPI7V (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 16 Nov 2017 03:59:21 -0500
Subject: Re: [PATCH v2] fstests: btrfs/143: make test case more reliable
References: <20171023205733.14896-1-bo.li.liu@oracle.com>
 <20171115234759.19168-1-bo.li.liu@oracle.com>
From: Nikolay Borisov <nborisov@suse.com>
Message-ID: <2a63cffe-294f-21b9-2095-6c66a9015233@suse.com>
Date: Thu, 16 Nov 2017 10:59:18 +0200
MIME-Version: 1.0
In-Reply-To: <20171115234759.19168-1-bo.li.liu@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Liu Bo <bo.li.liu@oracle.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 16.11.2017 01:47, Liu Bo wrote:
> This changes to use '_scratch_cycle_mount' to drop all caches btrfs could have
> in order to avoid an issue that drop_caches somehow doesn't work on Nikolay's
> box.
> 
> Also use bash -c to run 'read' only when %pid is odd so that we can read the
> faulty disk.
> 
> Reported-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
> ---
> v2: Change 'fadvise -d' to _scratch_cycle_mount.
> 
> To Nikolay,
> 
> I didn't add your tested-by, but could you please verify if this also
> works on your test box?

Just did around 50 runs and didn't fail once. Without it failed on the
second iteration so :

Tested-by: Nikolay Borisov <nborisov@suse.com>

> 
> 
>  tests/btrfs/143 | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/tests/btrfs/143 b/tests/btrfs/143
> index da7bfd8..3875b6c 100755
> --- a/tests/btrfs/143
> +++ b/tests/btrfs/143
> @@ -127,16 +127,16 @@ echo "step 3......repair the bad copy" >>$seqres.full
>  # since raid1 consists of two copies, and the bad copy was put on stripe #1
>  # while the good copy lies on stripe #0, the bad copy only gets access when the
>  # reader's pid % 2 == 1 is true
> -while true; do
> -	# start_fail only fails the following buffered read so the repair is
> -	# supposed to work.
> -	echo 3 > /proc/sys/vm/drop_caches
> -	start_fail
> -	$XFS_IO_PROG -c "pread 0 4K" "$SCRATCH_MNT/foobar" > /dev/null &
> -	pid=$!
> -	wait
> -	stop_fail
> -	[ $((pid % 2)) == 1 ] && break
> +while [[ -z ${result} ]]; do
> +    # invalidate the page cache.
> +    _scratch_cycle_mount
> +
> +    start_fail
> +    result=$(bash -c "
> +        if [[ \$((\$\$ % 2)) -eq 1 ]]; then
> +                exec $XFS_IO_PROG -c \"pread 0 4K\" \"$SCRATCH_MNT/foobar\"
> +        fi");
> +    stop_fail
>  done
>  
>  _scratch_unmount
> 

Received: from aserp1040.oracle.com ([141.146.126.69]:35072 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753814AbdIDP4A (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 4 Sep 2017 11:56:00 -0400
Date: Mon, 4 Sep 2017 08:55:50 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] kvm-xfstests: use aio=native for test drives
Message-ID: <20170904155550.GC4660@magnolia>
References: <1504527328-24615-1-git-send-email-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504527328-24615-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Eryu Guan <eguan@redhat.com>, Josef Bacik <jbacik@fb.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Sep 04, 2017 at 03:15:28PM +0300, Amir Goldstein wrote:
> Lost IOs have been observed with the default aio=threads with
> QEMU 2.5.0 when running crash consistency tests.
> The issue has not been observed with QEMU 2.9.0.
> Native AIO is probably better for our goal which is test proofing
> production systems.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Ted,
> 
> Not sure you have been following the crash consistency tests threads.
> 
> Anyway, I ran into an issue of sucessfuly completed bio's that
> did not make it to storage device when running in kvm-xfstests.
> 
> Josef reported that he did not observe the issue with newer QEMU
> and the issue is gone with aio=native on my version of QEMU.
> 
> Crash consistency tests still can't run properly on kvm-xfstests
> without this fix to kernel:
> https://git.kernel.org/pub/scm/linux/kernel/git/josef/btrfs-next.git/commit/?h=dm-log-writes-fixes&id=08c7d64773091c7d2e0147da7064aa4dc297629d
> After the fix is merged I will post a patch to enable running
> dm-log-write tests in kvm-xfstest.
> 
> Mean while, the change to aio=native seems like a good move
> anyway and if I observed a bio black hole in one test, who's to say
> they don't exist for other tests as well.
> 
> Amir.
> 
> 
>  kvm-xfstests/kvm-xfstests | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/kvm-xfstests/kvm-xfstests b/kvm-xfstests/kvm-xfstests
> index 305e2f5..98bd76a 100755
> --- a/kvm-xfstests/kvm-xfstests
> +++ b/kvm-xfstests/kvm-xfstests
> @@ -101,15 +101,22 @@ chmod 400 "$VDH"
>  
>  mkdir -p /tmp/kvm-xfstests-$USER
>  
> +# Lost IOs have been observed with the default aio=threads with
> +# QEMU 2.5.0 when running crash consistency tests.

Note however that Ubuntu 16.04 LTS is still on qemu 2.5, so perhaps
it's worth the trouble to check the qemu version prior to enabling
native aio support?

--D

> +# The issue has not been observed with QEMU 2.9.0.
> +# Native AIO is probably better for our goal which is test proofing
> +# production systems.
> +AIO=",aio=native"
> +
>  $NO_ACTION $IONICE $QEMU -boot order=c $NET \
>  	-machine type=pc,accel=kvm:tcg \
>  	-drive file=$ROOT_FS,if=virtio$SNAPSHOT \
> -	-drive file=$VDB,cache=none,if=virtio,format=raw \
> -	-drive file=$VDC,cache=none,if=virtio,format=raw \
> -	-drive file=$VDD,cache=none,if=virtio,format=raw \
> -	-drive file=$VDE,cache=none,if=virtio,format=raw \
> -	-drive file=$VDF,cache=none,if=virtio,format=raw \
> -	-drive file=$VDG,cache=none,if=virtio,format=raw \
> +	-drive file=$VDB,cache=none,if=virtio,format=raw$AIO \
> +	-drive file=$VDC,cache=none,if=virtio,format=raw$AIO \
> +	-drive file=$VDD,cache=none,if=virtio,format=raw$AIO \
> +	-drive file=$VDE,cache=none,if=virtio,format=raw$AIO \
> +	-drive file=$VDF,cache=none,if=virtio,format=raw$AIO \
> +	-drive file=$VDG,cache=none,if=virtio,format=raw$AIO \
>  	-drive file=$VDH,cache=unsafe,readonly,if=virtio \
>  	-vga none -nographic -smp $NR_CPU -m $MEM \
>  	-fsdev local,id=v_tmp,path=/tmp/kvm-xfstests-$USER,security_model=none \
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

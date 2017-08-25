Received: from mx1.redhat.com ([209.132.183.28]:59306 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751453AbdHYFbP (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 25 Aug 2017 01:31:15 -0400
Date: Fri, 25 Aug 2017 13:31:13 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/108: tolerate old lvm utility versions
Message-ID: <20170825053113.GR31418@eguan.usersys.redhat.com>
References: <1503578906-11387-1-git-send-email-idryomov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1503578906-11387-1-git-send-email-idryomov@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Aug 24, 2017 at 02:48:26PM +0200, Ilya Dryomov wrote:
> lvm utility in Ubuntu 14.04 LTS treats -l 100%FREE as a hard number and
> not as an approximate upper limit.  With ~5G scratch partition and ~128M

I just looked for an Ubuntu 14.04 LTS box and confirmed lvcreate does
support '-l 100%FREE'. Even on distributions as old as RHEL6 support
this usage too. Perpahs there were other things went wrong in your test
environment?

Thanks,
Eryu

> scsi_debug device, vg_108 is 1279+31=1310 extents long, but only 31*2=62
> can be allocated with -i 2:
> 
>   # lvm lvcreate -i 2 -I 4m -l 100%FREE -n lv_108 vg_108
>   Insufficient suitable allocatable extents for logical volume lv_108: 1248 more required
> 
> Set the size to allocate to 100M.
> 
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  tests/generic/108 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/108 b/tests/generic/108
> index 1525dfb64a47..0caec7d02d72 100755
> --- a/tests/generic/108
> +++ b/tests/generic/108
> @@ -74,7 +74,7 @@ $LVM_PROG pvcreate -f $SCSI_DEBUG_DEV $SCRATCH_DEV >>$seqres.full 2>&1
>  $LVM_PROG vgcreate -f $vgname $SCSI_DEBUG_DEV $SCRATCH_DEV >>$seqres.full 2>&1
>  # We use yes pipe instead of 'lvcreate --yes' because old version of lvm
>  # (like 2.02.95 in RHEL6) don't support --yes option
> -yes | $LVM_PROG lvcreate -i 2 -I 4m -l 100%FREE -n $lvname $vgname \
> +yes | $LVM_PROG lvcreate -i 2 -I 4m -L 100m -n $lvname $vgname \
>  	>>$seqres.full 2>&1
>  # wait for lv creation to fully complete
>  $UDEV_SETTLE_PROG >>$seqres.full 2>&1
> -- 
> 2.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

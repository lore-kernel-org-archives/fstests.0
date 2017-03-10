Received: from mail-ot0-f196.google.com ([74.125.82.196]:35526 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbdCJHnh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 10 Mar 2017 02:43:37 -0500
Received: by mail-ot0-f196.google.com with SMTP id a12so9379643ota.2
        for <fstests@vger.kernel.org>; Thu, 09 Mar 2017 23:43:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170310063343.8722-1-eguan@redhat.com>
References: <20170310063343.8722-1-eguan@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 10 Mar 2017 09:43:36 +0200
Message-ID: <CAOQ4uxjYMz0vTxDsRaZoPmYyNuU1mjNUyZsFGw1PUontRep1Cw@mail.gmail.com>
Subject: Re: [PATCH] common/rc: use findmnt to check mounted device
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri, Mar 10, 2017 at 8:33 AM, Eryu Guan <eguan@redhat.com> wrote:
> Doing 'grep -F "$dev on "' to find the mounted device is not
> always accurate, e.g.
>
>  SCRATCH_DEV=/vda6 is mounted but not on SCRATCH_MNT=/vda6/ovl-mnt - aborting
>  Already mounted result:
>  /dev/vda6 on /vda6 type xfs (rw,relatime,context=system_u:object_r:nfs_t:s0,attr2,inode64,noquota)
>
> Fix it by using findmnt command and specifying the $dev as mount
> source, print the result in "$dev $mnt" format. This works for local
> filesystems, network filesystems and overlayfs, avoids all kinds of
> tricky and error-prone grep pattern/regex.
>
> Also fixed the if-then-fi format in _check_mounted_on() while we're
> at it.
>
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---

Looks good. Also passed my kvm-xfstests -c overlay run.

>  common/rc | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/common/rc b/common/rc
> index 495d0f3..45b227a 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1438,24 +1438,19 @@ _check_mounted_on()
>         local mnt=$4
>         local type=$5
>
> -       # Note that we use -F here so grep doesn't try to interpret an NFS over
> -       # IPv6 server as a regular expression.  Because of that, we cannot use
> -       # ^$dev so we use "$dev on " to avoid matching $dev to mount point field
> -       # for overlay case, where $dev is a directory.
> -       local mount_rec=`_mount | grep -F "$dev on "`
> +       # find $dev as the source, and print result in "$dev $mnt" format
> +       local mount_rec=`findmnt -rnc -S $dev -o SOURCE,TARGET`
>         [ -n "$mount_rec" ] || return 1 # 1 = not mounted
>
>         # if it's mounted, make sure its on $mnt
> -       if ! (echo $mount_rec | grep -q "$dev on $mnt")
> -       then
> +       if [ "$mount_rec" != "$dev $mnt" ]; then
>                 echo "$devname=$dev is mounted but not on $mntname=$mnt - aborting"
>                 echo "Already mounted result:"
>                 echo $mount_rec
>                 return 2 # 2 = mounted on wrong mnt
>         fi
>
> -       if [ -n "$type" -a "`_fs_type $dev`" != "$type" ]
> -       then
> +       if [ -n "$type" -a "`_fs_type $dev`" != "$type" ]; then
>                 echo "$devname=$dev is mounted but not a type $type filesystem"
>                 # raw $DF_PROG cannot handle NFS/CIFS/overlay correctly
>                 _df_device $dev
> --
> 2.9.3
>

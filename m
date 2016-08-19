Received: from mx4-phx2.redhat.com ([209.132.183.25]:45633 "EHLO
        mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753671AbcHSRzV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 19 Aug 2016 13:55:21 -0400
Date: Fri, 19 Aug 2016 13:55:12 -0400 (EDT)
From: Zirong Lang <zlang@redhat.com>
Message-ID: <618760559.2359845.1471629312793.JavaMail.zimbra@redhat.com>
In-Reply-To: <1471629105-13359-1-git-send-email-zlang@redhat.com>
References: <1471629105-13359-1-git-send-email-zlang@redhat.com>
Subject: Re: [PATCH 1/2] common/rc: add functions to check or write objects
 under /sys/fs/$FSTYP
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: fstests@vger.kernel.org
Cc: xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

Sorry, I sent wrong patch. Please ignore this patch.
This's not the real [PATCH 1/2].  I'll resend both patches later.

Thanks,
Zorro

----- =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6 -----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: "Zorro Lang" <zlang@redhat.com>
> =E6=94=B6=E4=BB=B6=E4=BA=BA: fstests@vger.kernel.org
> =E6=8A=84=E9=80=81: xfs@oss.sgi.com, "Zorro Lang" <zlang@redhat.com>
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: =E6=98=9F=E6=9C=9F=E5=85=AD, 2016=
=E5=B9=B4 8 =E6=9C=88 20=E6=97=A5 =E4=B8=8A=E5=8D=88 1:51:44
> =E4=B8=BB=E9=A2=98: [PATCH 1/2] common/rc: add functions to check or wr=
ite objects under /sys/fs/$FSTYP
>=20
> XFS add more configurations in /sys/fs/xfs recently. For use
> them, this patch add some common functions for:
>   1. "require" a file/dir in /sys/fs/${FSTYP}.
>   2. write a file in /sys/fs/${FSTYP}.
>=20
> For common use, these functions can be used by other filesystems.
>=20
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
>  common/rc | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>=20
> diff --git a/common/rc b/common/rc
> index 51092a0..d5edfef 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3556,6 +3556,48 @@ run_fsx()
>  	fi
>  }
> =20
> +# Test for the existence of a sysfs entry at /sys/fs/$FSTYP/$DEV/$ENTR=
Y
> +_require_fs_sysfs()
> +{
> +	local dev=3D$1
> +	local entry=3D$2
> +	local tmp_mnt=3D`mktemp -d`
> +
> +	if [ ! -b "$dev" -o -z "$entry" ];then
> +		_fail "Usage: _require_fs_sysfs <device> <sysfs_path>"
> +        fi
> +
> +	local dname=3D$(_short_dev $dev)
> +	_mount -t $FSTYP `_common_dev_mount_options` $dev $tmp_mnt
> +	if [ $? -ne 0 ];then
> +		rm -f $tmp_mnt
> +		_fail "_require_fs_sysfs: could not mount, mkfs first in your test?"
> +	elif [ ! -e /sys/fs/${FSTYP}/${dname}/${entry} ];then
> +		$UMOUNT_PROG $tmp_mnt
> +		rm -f $tmp_mnt
> +		_notrun "/sys/fs/${FSTYP}/${dname}/${entry}: No such file or directo=
ry"
> +	fi
> +	$UMOUNT_PROG $tmp_mnt
> +	rm -rf $tmp_mnt
> +}
> +
> +# Write "content" into /sys/fs/$FSTYP/$DEV/$ENTRY
> +_set_fs_sysfs_param()
> +{
> +	local dev=3D$1
> +	shift
> +	local entry=3D$1
> +	shift
> +	local content=3D"$*"
> +
> +	if [ ! -b "$dev" -o -z "$entry" -o -z "$content" ];then
> +		_fail "Usage: _set_sys_fs_param <mounted_device> <entry> <content>"
> +	fi
> +
> +	local dname=3D$(_short_dev $dev)
> +	echo "$content" > /sys/fs/${FSTYP}/${dname}/${entry}
> +}
> +
>  init_rc
> =20
>  ######################################################################=
##########
> --
> 2.5.5
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

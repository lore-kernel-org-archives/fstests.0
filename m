Received: from szxga05-in.huawei.com ([45.249.212.191]:2774 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2409582AbfIXLQG (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 24 Sep 2019 07:16:06 -0400
Subject: Re: [PATCH xfstests] overlay: Enable character device to be the base
 fs partition
References: <1569318025-36831-1-git-send-email-chengzhihao1@huawei.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <27af8d4f-8653-469f-73bb-d388180d93c9@huawei.com>
Date: Tue, 24 Sep 2019 19:15:56 +0800
MIME-Version: 1.0
In-Reply-To: <1569318025-36831-1-git-send-email-chengzhihao1@huawei.com>
Content-Type: multipart/mixed;
        boundary="------------ED80660566D73B2ABC02FFCD"
Sender: fstests-owner@vger.kernel.org
To: guaneryu@gmail.com, amir73il@gmail.com, david.oberhollenzer@sigma-star.at, ebiggers@google.com, yi.zhang@huawei.com
Cc: fstests@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

--------------ED80660566D73B2ABC02FFCD
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by aserp3020.oracle.com id x8OBEX64013793

After incorporating patches, use overlay usecases to test character devic=
e-based base fs, and all overlay usecases are executed:

FSTYP         -- overlay  # FSTYP has be overridden as 'overlay'
PLATFORM      -- Linux/x86_64 localhost
MKFS_OPTIONS  -- /tmp/scratch
MOUNT_OPTIONS -- /tmp/scratch /tmp/scratch/ovl-mnt

overlay/001	[not run] This test requires at least 8GB free on /tmp/scratc=
h to run
overlay/002	 1s
overlay/003	 0s
overlay/004	 0s
overlay/005	 1s
overlay/006	 0s
overlay/007	 0s
overlay/008	 0s
overlay/009	 0s
overlay/010	 0s
overlay/011	 1s
overlay/012	 0s
overlay/013	 0s
overlay/014	 1s
...

Attachments:
setup.sh: Create character device for base fs (UBIFS)
local.config: Xfstests local configuration

=D4=DA 2019/9/24 17:40, Zhihao Cheng =D0=B4=B5=C0:
> When running overlay tests using character devices as base fs partition=
s,
> all overlay usecase results become 'notrun'. Function
> '_overay_config_override' (common/config) detects that the current base
> fs partition is not a block device and will set FSTYP to base fs. The
> overlay usecase will check the current FSTYP, and if it is not 'overlay=
'
> or 'generic', it will skip the execution.
>=20
> For example, using UBIFS as base fs skips all overlay usecases:
>=20
>   FSTYP         -- ubifs       # FSTYP should be overridden as 'overlay=
'
>   MKFS_OPTIONS  -- /dev/ubi0_1 # Character device
>   MOUNT_OPTIONS -- -t ubifs /dev/ubi0_1 /tmp/scratch
>=20
>   overlay/001	[not run] not suitable for this filesystem type: ubifs
>   overlay/002	[not run] not suitable for this filesystem type: ubifs
>   overlay/003	[not run] not suitable for this filesystem type: ubifs
>   ...
>=20
> When checking that the base fs partition is a block/character device,
> FSTYP is overwritten as 'overlay'. This patch allows the base fs
> partition to be a character device that can also execute overlay
> usecases (such as ubifs).
>=20
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
>  common/config | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/common/config b/common/config
> index 4c86a49..a22acdb 100644
> --- a/common/config
> +++ b/common/config
> @@ -550,7 +550,7 @@ _overlay_config_override()
>  	#    the new OVL_BASE_SCRATCH/TEST_DEV/MNT vars are set to the values
>  	#    of the configured base fs and SCRATCH/TEST_DEV vars are set to t=
he
>  	#    overlayfs base and mount dirs inside base fs mount.
> -	[ -b "$TEST_DEV" ] || return 0
> +	[ -b "$TEST_DEV" ] || [ -c "$TEST_DEV" ] || return 0
> =20
>  	# Config file may specify base fs type, but we obay -overlay flag
>  	[ "$FSTYP" =3D=3D overlay ] || export OVL_BASE_FSTYP=3D"$FSTYP"
> @@ -570,7 +570,7 @@ _overlay_config_override()
>  	export TEST_DIR=3D"$OVL_BASE_TEST_DIR/$OVL_MNT"
>  	export MOUNT_OPTIONS=3D"$OVERLAY_MOUNT_OPTIONS"
> =20
> -	[ -b "$SCRATCH_DEV" ] || return 0
> +	[ -b "$SCRATCH_DEV" ] || [ -c "$SCRATCH_DEV" ] || return 0
> =20
>  	# Store original base fs vars
>  	export OVL_BASE_SCRATCH_DEV=3D"$SCRATCH_DEV"
>=20

--------------ED80660566D73B2ABC02FFCD
Content-Type: text/plain; charset="UTF-8"; name="local.config"
Content-Disposition: attachment; filename="local.config"
Content-Transfer-Encoding: 7bit

export FSTYP=ubifs
export TEST_DEV=/dev/ubi0_0
export TEST_DIR=/tmp/test
export TEST_FS_MOUNT_OPTS="-t ubifs"
export SCRATCH_DEV=/dev/ubi0_1
export SCRATCH_MNT=/tmp/scratch
export MOUNT_OPTIONS="-t ubifs"

--------------ED80660566D73B2ABC02FFCD
Content-Type: text/plain; charset="UTF-8"; name="setup.sh"
Content-Disposition: attachment; filename="setup.sh"
Content-Transfer-Encoding: 7bit

#!/bin/bash

set -e

TMP=/tmp/test
SMP=/tmp/scratch
umount $TMP $SMP 2>/dev/null || true
mkdir -p $TMP $SMP

modprobe -r ubifs 2>/dev/null || true
for i in $(seq 0 1)
do
	ubidetach -p /dev/mtd$i 2>/dev/null || true
done
modprobe -r ubi 2>/dev/null || true
modprobe -r nandsim 2>/dev/null || true

mtd=/dev/mtd0
ubi=/dev/ubi0

ARCH=$(uname -m)
if test "$ARCH" == ppc || test "$ARCH" == armv7l
then
	# 512MB, 8-bits, page size 4KB, OOB 128B, block 128KB
	ID="0x20,0xac,0x00,0x16"
	TSIZE=128MiB
	SSIZE=350MiB
else
	# 2GB, 8-bits, page size 4KB, OOB 128B, block 128KB
	ID="0x20,0xa5,0x00,0x16"
	TSIZE=400MiB
	SSIZE=1500MiB
fi
modprobe nandsim id_bytes=$ID
flash_erase -q -j $mtd 0 0
modprobe ubi
modprobe ubifs

ubiattach -p $mtd
ubimkvol $ubi -N test -s $TSIZE
ubimkvol $ubi -N scratch -s $SSIZE

exit 0

--------------ED80660566D73B2ABC02FFCD--

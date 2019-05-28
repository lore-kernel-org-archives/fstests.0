Received: from mx2.suse.de ([195.135.220.15]:39352 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726973AbfE1MsM (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 28 May 2019 08:48:12 -0400
Subject: Re: [PATCH] fstests: generic/260: Make it handle btrfs more
 gracefully
References: <20190528081859.6203-1-wqu@suse.com>
From: Nikolay Borisov <nborisov@suse.com>
Message-ID: <5b41fcb4-ab2d-65b7-f43c-b67919347b0c@suse.com>
Date: Tue, 28 May 2019 15:48:09 +0300
MIME-Version: 1.0
In-Reply-To: <20190528081859.6203-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 28.05.19 =D0=B3. 11:18 =D1=87., Qu Wenruo wrote:
> If a filesystem doesn't map its logical address space (normally the
> bytenr/blocknr returned by fiemap) directly to its devices(s), the
> following assumptions used in the test case is no longer true:
> - trim range start beyond the end of fs should fail
> - trim range start beyond the end of fs with len set should fail
>=20
> Under the following example, even with just one device, btrfs can still
> trim the fs correctly while breaking above assumption:
>=20
> 0		1G		1.25G
> |---------------|///////////////|-----------------| <- btrfs logical
> 		   |				       address space
>         ------------  mapped as SINGLE
>         |
> 0	V	256M
> |///////////////|			<- device address space
>=20
> Thus trim range start=3D1G len=3D256M will cause btrfs to trim the 256M
> block group, thus return correct result.
>=20
> Furthermore, there is no definitely behavior for whether a fs should
> trim the unmapped space.
> Btrfs currently will always trim the unmapped space, but the behavior
> can change as large trim can be very expensive.
>=20
> Despite the change to skip certain tests for btrfs, still run the
> following tests for btrfs:
> - trim start=3DU64_MAX with lenght set
>   This will expose a bug that btrfs doesn't check overflow of the range.
>   This bug will be fixed soon.
>=20
> - trim beyond the end of the fs
>   This will expose a bug where btrfs could send trim command beyond the
>   end of its device.
>   This bug is a regression, can be fixed by reverting c2d1b3aae336 ("bt=
rfs:
>   Honour FITRIM range constraints during free space trim")
>=20
> With proper fixes for btrfs, this test case should pass on btrfs, ext4,
> xfs.
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  common/rc             | 11 +++++++
>  tests/generic/260     | 75 ++++++++++++++++++++++++++++---------------
>  tests/generic/260.out |  9 +-----
>  3 files changed, 62 insertions(+), 33 deletions(-)
>=20
> diff --git a/common/rc b/common/rc
> index 17b89d5d..d7a5898f 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4005,6 +4005,17 @@ _require_fibmap()
>  	rm -f $file
>  }
> =20
> +# Check if the logical address (returned by fiemap) of a fs is 1:1 map=
ped to
> +# its underlying fs

"underlying device" ?

> +_is_fs_direct_mapped()
> +{
> +	if [ "$FSTYP" =3D=3D "btrfs" ]; then
> +		echo "0"
> +	else
> +		echo "1"
> +	fi
> +}

Instead of using echo just return 0 or 1 then see below

> +
>  _try_wipe_scratch_devs()
>  {
>  	test -x "$WIPEFS_PROG" || return 0
> diff --git a/tests/generic/260 b/tests/generic/260
> index 9e652dee..452f88c1 100755
> --- a/tests/generic/260
> +++ b/tests/generic/260
> @@ -27,40 +27,51 @@ _supported_fs generic
>  _supported_os Linux
>  _require_math
> =20
> +rm -f $seqres.full
> +
>  _require_scratch
>  _scratch_mkfs >/dev/null 2>&1
>  _scratch_mount
> =20
>  _require_batched_discard $SCRATCH_MNT
> =20
> +
>  fssize=3D$($DF_PROG -k | grep "$SCRATCH_MNT" | grep "$SCRATCH_DEV"  | =
awk '{print $3}')
> =20
>  beyond_eofs=3D$(_math "$fssize*2048")
>  max_64bit=3D$(_math "2^64 - 1")
> =20
> -# All these tests should return EINVAL
> -# since the start is beyond the end of
> -# the file system
> -
> -echo "[+] Start beyond the end of fs (should fail)"
> -out=3D$($FSTRIM_PROG -o $beyond_eofs $SCRATCH_MNT 2>&1)
> -[ $? -eq 0 ] && status=3D1
> -echo $out | _filter_scratch
> -
> -echo "[+] Start beyond the end of fs with len set (should fail)"
> -out=3D$($FSTRIM_PROG -o $beyond_eofs -l1M $SCRATCH_MNT 2>&1)
> -[ $? -eq 0 ] && status=3D1
> -echo $out | _filter_scratch
> -
> -echo "[+] Start =3D 2^64-1 (should fail)"
> -out=3D$($FSTRIM_PROG -o $max_64bit $SCRATCH_MNT 2>&1)
> -[ $? -eq 0 ] && status=3D1
> -echo $out | _filter_scratch
> +# For filesystem with direct mapping, all these tests should return EI=
NVAL
> +# since the start is beyond the end of the file system
> +#
> +# Skip these tests if the filesystem has its own address space mapping=
,
> +# as it's implementation dependent.
> +# E.g btrfs can map its physical address of (devid=3D1, physical=3D1M,=
 len=3D1M)
> +# and (devid=3D2, physical=3D2M, len=3D1M) combined as RAID1, and mapp=
ed to its
> +# address space (logical=3D1G, len=3D1M), thus making trim beyond the =
end of
> +# fs (device) meaningless.
> +
> +echo "[+] Optional trim range test (fs dependent)"
> +if [ $(_is_fs_direct_mapped) -eq 1 ]; then

this check is rather ugly, instead if you return 0 on success (i.e it's
directly mapped) it can be rewritten simply as:

if is_fs_direct_mapped; then

which is a lot cleaner than the $() fuckery

> +	echo "[+] Start beyond the end of fs (should fail)" >> $seqres.full
> +	$FSTRIM_PROG -o $beyond_eofs $SCRATCH_MNT >> $seqres.full 2>&1
> +	[ $? -eq 0 ] && status=3D1
> +
> +	echo "[+] Start beyond the end of fs with len set (should fail)" >> $=
seqres.full
> +	$FSTRIM_PROG -o $beyond_eofs -l1M $SCRATCH_MNT >> $seqres.full 2>&1
> +	[ $? -eq 0 ] && status=3D1
> +
> +	# indirectly mapped fs may use this special value to trim their
> +	# unmapped space, so don't do this for indirectly mapped fs.
> +	echo "[+] Start =3D 2^64-1 (should fail)" >> $seqres.full
> +	$FSTRIM_PROG -o $max_64bit $SCRATCH_MNT 2>&1 >> $seqres.full 2>&1
> +	[ $? -eq 0 ] && status=3D1
> +fi
> =20
> -echo "[+] Start =3D 2^64-1 and len is set (should fail)"
> -out=3D$($FSTRIM_PROG -o $max_64bit -l1M $SCRATCH_MNT 2>&1)
> +# This should fail due to overflow no matter how the fs is implemented
> +echo "[+] Start =3D 2^64-1 and len is set (should fail)" >> $seqres.fu=
ll
> +$FSTRIM_PROG -o $max_64bit -l1M $SCRATCH_MNT >> $seqres.full 2>&1
>  [ $? -eq 0 ] && status=3D1
> -echo $out | _filter_scratch
> =20
>  _scratch_unmount
>  _scratch_mkfs >/dev/null 2>&1
> @@ -86,10 +97,12 @@ _scratch_unmount
>  _scratch_mkfs >/dev/null 2>&1
>  _scratch_mount
> =20
> +echo "[+] Trim an empty fs" >> $seqres.full
>  # This is a bit fuzzy, but since the file system is fresh
>  # there should be at least (fssize/2) free space to trim.
>  # This is supposed to catch wrong FITRIM argument handling
>  bytes=3D$($FSTRIM_PROG -v -o10M $SCRATCH_MNT | _filter_fstrim)
> +echo "$bytes trimed" >> $seqres.full

Does it bring any value printing those strings in seqres.full given the
output of the executed command won't be there. I think not.

> =20
>  if [ $bytes -gt $(_math "$fssize*1024") ]; then
>  	status=3D1
> @@ -101,7 +114,7 @@ fi
>  # It is because btrfs does not have not-yet-used parts of the device
>  # mapped and since we got here right after the mkfs, there is not
>  # enough free extents in the root tree.
> -if [ $bytes -le $(_math "$fssize*512") ] && [ $FSTYP !=3D "btrfs" ]; t=
hen
> +if [ $bytes -le $(_math "$fssize*512") ] && [ $(_is_fs_direct_mapped) =
-eq 1 ]; then

same thing here - make is_fs_direct_mapped plain 'return 0/1' and check
its ret val directly.

>  	status=3D1
>  	echo "After the full fs discard $bytes bytes were discarded"\
>  	     "however the file system is $(_math "$fssize*1024") bytes long."
> @@ -141,14 +154,24 @@ esac
>  _scratch_unmount
>  _scratch_mkfs >/dev/null 2>&1
>  _scratch_mount
> +
> +echo "[+] Try to trim beyond the end of the fs" >> $seqres.full
>  # It should fail since $start is beyond the end of file system
> -$FSTRIM_PROG -o$start -l10M $SCRATCH_MNT &> /dev/null
> -if [ $? -eq 0 ]; then
> +$FSTRIM_PROG -o$start -l10M $SCRATCH_MNT >> $seqres.full 2>&1
> +ret=3D$?
> +if [ $ret -eq 0 ] && [ $(_is_fs_direct_mapped) -eq 1 ]; then
>  	status=3D1
>  	echo "It seems that fs logic handling start"\
>  	     "argument overflows"
>  fi
> =20
> +# For indirectly mapped fs, it shouldn't fail.
> +# Btrfs will fail due to a bug in boundary check
> +if [ $ret -ne 0 ] && [ $(_is_fs_direct_mapped) -eq 0 ]; then
> +	status=3D1
> +	echo "Unexpected error happened during trim"
> +fi
> +
>  _scratch_unmount
>  _scratch_mkfs >/dev/null 2>&1
>  _scratch_mount
> @@ -160,8 +183,10 @@ _scratch_mount
>  # It is because btrfs does not have not-yet-used parts of the device
>  # mapped and since we got here right after the mkfs, there is not
>  # enough free extents in the root tree.
> +echo "[+] Try to trim the fs with large enough len" >> $seqres.full
>  bytes=3D$($FSTRIM_PROG -v -l$len $SCRATCH_MNT | _filter_fstrim)
> -if [ $bytes -le $(_math "$fssize*512") ] && [ $FSTYP !=3D "btrfs" ]; t=
hen
> +echo "$bytes trimed" >> $seqres.full
> +if [ $bytes -le $(_math "$fssize*512") ] && [ $(_is_fs_direct_mapped) =
=3D=3D 1 ]; then
>  	status=3D1
>  	echo "It seems that fs logic handling len argument overflows"
>  fi
> diff --git a/tests/generic/260.out b/tests/generic/260.out
> index a16c4f74..f4ee2f72 100644
> --- a/tests/generic/260.out
> +++ b/tests/generic/260.out
> @@ -1,12 +1,5 @@
>  QA output created by 260
> -[+] Start beyond the end of fs (should fail)
> -fstrim: SCRATCH_MNT: FITRIM ioctl failed: Invalid argument
> -[+] Start beyond the end of fs with len set (should fail)
> -fstrim: SCRATCH_MNT: FITRIM ioctl failed: Invalid argument
> -[+] Start =3D 2^64-1 (should fail)
> -fstrim: SCRATCH_MNT: FITRIM ioctl failed: Invalid argument
> -[+] Start =3D 2^64-1 and len is set (should fail)
> -fstrim: SCRATCH_MNT: FITRIM ioctl failed: Invalid argument
> +[+] Optional trim range test (fs dependent)
>  [+] Default length (should succeed)
>  [+] Default length with start set (should succeed)
>  [+] Length beyond the end of fs (should succeed)
>=20

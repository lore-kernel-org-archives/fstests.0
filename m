Received: from mx2.suse.de ([195.135.220.15]:36296 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726027AbfDENVN (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 5 Apr 2019 09:21:13 -0400
Subject: Re: [PATCH v2] fstests: btrfs/048: amend property validation cases
References: <20190403165419.12666-1-anand.jain@oracle.com>
 <20190403170437.14448-1-anand.jain@oracle.com>
From: Nikolay Borisov <nborisov@suse.com>
Message-ID: <7de2d0fd-e777-2bec-5731-15ba2f2af4f2@suse.com>
Date: Fri, 5 Apr 2019 16:21:10 +0300
MIME-Version: 1.0
In-Reply-To: <20190403170437.14448-1-anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 3.04.19 =D0=B3. 20:04 =D1=87., Anand Jain wrote:
> Add more property validation cases which are fixed by the patches [1]
>  [1]
>   btrfs: fix vanished compression property after failed set
>   btrfs: fix zstd compression parameter
>=20
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> ---
> v2: correct kernel patch titles in the test header and change log
>=20
>  tests/btrfs/048     | 23 +++++++++++++++++++++++
>  tests/btrfs/048.out | 16 ++++++++++++++++
>  2 files changed, 39 insertions(+)
>=20
> diff --git a/tests/btrfs/048 b/tests/btrfs/048
> index 588219579cc6..f6de0b8ca8b1 100755
> --- a/tests/btrfs/048
> +++ b/tests/btrfs/048
> @@ -6,6 +6,9 @@
>  #
>  # Btrfs properties test. The btrfs properties feature was introduced i=
n the
>  # linux kernel 3.14.
> +# Fails without the kernel patches:
> +#  btrfs: fix vanished compression property after failed set
> +#  btrfs: fix zstd compression parameter
>  #
>  seq=3D`basename $0`
>  seqres=3D$RESULT_DIR/$seq
> @@ -34,6 +37,7 @@ _supported_os Linux
>  _require_test
>  _require_scratch
>  _require_btrfs_command "property"
> +_require_btrfs_command inspect-internal dump-super
> =20
>  send_files_dir=3D$TEST_DIR/btrfs-test-$seq
> =20
> @@ -203,5 +207,24 @@ $BTRFS_UTIL_PROG property get $SCRATCH_MNT/sv1 com=
pression
>  touch $SCRATCH_MNT/sv1/file2
>  $BTRFS_UTIL_PROG property get $SCRATCH_MNT/sv1/file2 compression
> =20
> +echo -e "\nTesting argument validation, should fail"
> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'lz' | _filter_=
scratch
> +echo "***"
> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'zli' | _filter=
_scratch
> +echo "***"
> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'zst' | _filter=
_scratch
> +
> +echo -e "\nTesting if property is persistent across failed validation"
> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'lzo'
> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'zli' | _filter=
_scratch
> +$BTRFS_UTIL_PROG property get $SCRATCH_MNT compression
> +
> +echo -e "\nTesting generation is unchanged after failed validation"
> +$BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
> +$BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV | grep '^gen=
eration'
> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'lz' | _filter_=
scratch
> +$BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
> +$BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV | grep '^gen=
eration'
> +
>  status=3D0
>  exit
> diff --git a/tests/btrfs/048.out b/tests/btrfs/048.out
> index 3e4e3d28950a..00f39bc01227 100644
> --- a/tests/btrfs/048.out
> +++ b/tests/btrfs/048.out
> @@ -76,3 +76,19 @@ compression=3Dzlib
>  Testing subvolume property inheritance
>  compression=3Dlzo
>  compression=3Dlzo
> +
> +Testing argument validation, should fail
> +ERROR: failed to set compression for /mnt/scratch: Invalid argument
> +***
> +ERROR: failed to set compression for /mnt/scratch: Invalid argument
> +***
> +ERROR: failed to set compression for /mnt/scratch: Invalid argument
> +
> +Testing if property is persistent across failed validation
> +ERROR: failed to set compression for /mnt/scratch: Invalid argument
> +compression=3Dlzo
> +
> +Testing generation is unchanged after failed validation
> +generation		7
> +ERROR: failed to set compression for /mnt/scratch: Invalid argument
> +generation		7
>=20

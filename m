Received: from mx2.suse.de ([195.135.220.15]:53640 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726111AbfCZPDh (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 26 Mar 2019 11:03:37 -0400
Subject: Re: [PATCH] btrfs: Enable btrfs/003
References: <20190319105851.9280-1-nborisov@suse.com>
From: Nikolay Borisov <nborisov@suse.com>
Message-ID: <dc51b658-639b-d2a6-93f7-bbc84a10fbf3@suse.com>
Date: Tue, 26 Mar 2019 17:03:34 +0200
MIME-Version: 1.0
In-Reply-To: <20190319105851.9280-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, guaneryu@gmail.com
List-ID: <fstests@vger.kernel.org>



On 19.03.19 =D0=B3. 12:58 =D1=87., Nikolay Borisov wrote:
> For a long time this test has been failing on all kinds of VM configura=
tion,
> which are using virtio_blk devices. This is due to the fact that scsi
> devices are deletable and virtio_blk are not. However, this only preven=
ts
> device replace case to run and has no negative effect on the other
> useful test cases.
>=20
> Re-enable btrfs/003 to run by making _require_deletable_scratch_dev_poo=
l
> private to the test case and modifying it to return success (0) or
> failure (1) if devices are not deletable. Further modify the replace
> test case to check the return value of this function and skip it if
> devices are not deletable.
>=20
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Ping

> ---
>  common/rc       | 12 ------------
>  tests/btrfs/003 | 19 ++++++++++++++++++-
>  2 files changed, 18 insertions(+), 13 deletions(-)
>=20
> diff --git a/common/rc b/common/rc
> index 1c42515ff0ea..5693ba3cad18 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2961,18 +2961,6 @@ _require_scratch_dev_pool_equal_size()
>  	done
>  }
> =20
> -# We will check if the device is deletable
> -_require_deletable_scratch_dev_pool()
> -{
> -	local i
> -	local x
> -	for i in $SCRATCH_DEV_POOL; do
> -		x=3D`echo $i | cut -d"/" -f 3`
> -		if [ ! -f /sys/class/block/${x}/device/delete ]; then
> -			_notrun "$i is a device which is not deletable"
> -		fi
> -	done
> -}
> =20
>  # Check that fio is present, and it is able to execute given jobfile
>  _require_fio()
> diff --git a/tests/btrfs/003 b/tests/btrfs/003
> index 938030ef4c65..2aeb9fe6325a 100755
> --- a/tests/btrfs/003
> +++ b/tests/btrfs/003
> @@ -17,6 +17,21 @@ dev_removed=3D0
>  removed_dev_htl=3D""
>  trap "_cleanup; exit \$status" 0 1 2 3 15
> =20
> +# Check if all scratch dev pools are deletable
> +_require_deletable_scratch_dev_pool()
> +{
> +	local i
> +	local x
> +	for i in $SCRATCH_DEV_POOL; do
> +		x=3D`echo $i | cut -d"/" -f 3`
> +		if [ ! -f /sys/class/block/${x}/device/delete ]; then
> +			return 1
> +		fi
> +	done
> +
> +	return 0
> +}
> +
>  _cleanup()
>  {
>      cd /
> @@ -35,7 +50,6 @@ _supported_fs btrfs
>  _supported_os Linux
>  _require_scratch
>  _require_scratch_dev_pool 4
> -_require_deletable_scratch_dev_pool
>  _require_command "$WIPEFS_PROG" wipefs
> =20
>  rm -f $seqres.full
> @@ -111,6 +125,9 @@ _test_replace()
>  	local ds
>  	local d
> =20
> +	# If scratch devs are not deletable skip this test
> +	if ! _require_deletable_scratch_dev_pool; then return 0; fi
> +
>  	# exclude the first and the last disk in the disk pool
>  	n=3D$(($n-1))
>  	ds=3D${devs[@]:1:$(($n-1))}
>=20

Received: from mout.gmx.net ([212.227.15.18]:48811 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751802AbeBTMWR (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 20 Feb 2018 07:22:17 -0500
Subject: Re: [PATCH] btrfs/150: add _scratch_dev_pool_get/put to run the test
 as expected
References: <80c576ca-2ca0-ff83-cd9e-9622e2ce28ce@jp.fujitsu.com>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <929dde87-cf88-e5ec-d626-d85ec9893fdb@gmx.com>
Date: Tue, 20 Feb 2018 20:21:59 +0800
MIME-Version: 1.0
In-Reply-To: <80c576ca-2ca0-ff83-cd9e-9622e2ce28ce@jp.fujitsu.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aJ4Lq4xYduH7uAZeWi3lDRQSSfBrkZ3c5"
Sender: fstests-owner@vger.kernel.org
To: "Misono, Tomohiro" <misono.tomohiro@jp.fujitsu.com>, fstests@vger.kernel.org
Cc: bo.li.liu@oracle.com, linux-btrfs <linux-btrfs@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aJ4Lq4xYduH7uAZeWi3lDRQSSfBrkZ3c5
Content-Type: multipart/mixed; boundary="jjcuico7WJfvTjWocZxP1OmUQKv23E0gF";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: "Misono, Tomohiro" <misono.tomohiro@jp.fujitsu.com>,
 fstests@vger.kernel.org
Cc: bo.li.liu@oracle.com, linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <929dde87-cf88-e5ec-d626-d85ec9893fdb@gmx.com>
Subject: Re: [PATCH] btrfs/150: add _scratch_dev_pool_get/put to run the test
 as expected
References: <80c576ca-2ca0-ff83-cd9e-9622e2ce28ce@jp.fujitsu.com>
In-Reply-To: <80c576ca-2ca0-ff83-cd9e-9622e2ce28ce@jp.fujitsu.com>

--jjcuico7WJfvTjWocZxP1OmUQKv23E0gF
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2018=E5=B9=B402=E6=9C=8820=E6=97=A5 13:34, Misono, Tomohiro wrote:
> btrfs/150 uses RAID1 profile and make SCRATCH_DEV fail for test.
> However, if SCRATCH_DEV_POOL consists more than two devices, SCRATCH_DE=
V
> may not be used for RAID1 pair and the tests may not run as expected.
>=20
> Fix this by add _scratch_dev_pool_get/put like other tests (141, 143
> etc.) do.
>=20
> Signed-off-by: Tomohiro Misono <misono.tomohiro@jp.fujitsu.com>

Indeed, if we have more devices, it's highly possible that the first
device doesn't have data stripe of the raid1 chunk on it.

(And under most case it won't have data stripe, since during mkfs we use
the first device to contain temporary chunks, so unallocated space of
devid 1 is smaller compared to other devices, and chunk allocator will
use device with more unallocated space)

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>  tests/btrfs/150 | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/tests/btrfs/150 b/tests/btrfs/150
> index 97041b6c..1e4586be 100755
> --- a/tests/btrfs/150
> +++ b/tests/btrfs/150
> @@ -55,6 +55,7 @@ _supported_os Linux
>  _require_scratch
>  _require_fail_make_request
>  _require_scratch_dev_pool 2
> +_scratch_dev_pool_get 2
> =20
>  SYSFS_BDEV=3D`_sysfs_dev $SCRATCH_DEV`
>  enable_io_failure()
> @@ -100,6 +101,7 @@ while [[ -z $result ]]; do
>  	disable_io_failure
>  done
> =20
> +_scratch_dev_pool_put
>  # success, all done
>  status=3D0
>  exit
>=20


--jjcuico7WJfvTjWocZxP1OmUQKv23E0gF--

--aJ4Lq4xYduH7uAZeWi3lDRQSSfBrkZ3c5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAlqMEucXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qjalwf/e8Aq+i331UkDZqKzyFZlxMUa
lmz6ts3p5jY2G1O11AZ7zHbwJavCTbUeFVGGZHC7zt5wTRgF6oIPfOCri7BpxMkz
jfi60xamr8cQ4DfPIyfybQE5nEd9izj15HBu9Hf7nI4s7jBeevDEtak2gkeKSn9k
0O9ivoFjgsBnxkGpDyVXtSWxiTPy8lguzWHR+U4HLcFgPQFamtPf7JWqoaHT1RYH
qWbWNiXeLcDQyvH+ugg8yv/VxyReLUWJT8tPRxXn7dAUcQz1WVYrX9l0LK7bpwkN
8W3h+Jzmso0+H93nkS3rgW+M6Gvzg4GuTQU/bKet6b95ZDTrBC4jDIooBOl6YA==
=Wpsq
-----END PGP SIGNATURE-----

--aJ4Lq4xYduH7uAZeWi3lDRQSSfBrkZ3c5--

Received: from mout.gmx.net ([212.227.17.20]:55975 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932472AbeAHMyV (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 8 Jan 2018 07:54:21 -0500
Subject: Re: [PATCH] generic/015: Change the test filesystem size to 101mb
References: <1515401010-26802-1-git-send-email-nborisov@suse.com>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <2ee54197-b45a-c89d-80c0-e511b497d2e3@gmx.com>
Date: Mon, 8 Jan 2018 20:54:01 +0800
MIME-Version: 1.0
In-Reply-To: <1515401010-26802-1-git-send-email-nborisov@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9BVg7DicOBzg7w6d2COf0xyP6uESkcaRD"
Sender: fstests-owner@vger.kernel.org
To: Nikolay Borisov <nborisov@suse.com>, fstests@vger.kernel.org
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9BVg7DicOBzg7w6d2COf0xyP6uESkcaRD
Content-Type: multipart/mixed; boundary="nXUM22G2fW91pNrXpvpwXlAvt96HdbYq8";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Nikolay Borisov <nborisov@suse.com>, fstests@vger.kernel.org
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org
Message-ID: <2ee54197-b45a-c89d-80c0-e511b497d2e3@gmx.com>
Subject: Re: [PATCH] generic/015: Change the test filesystem size to 101mb
References: <1515401010-26802-1-git-send-email-nborisov@suse.com>
In-Reply-To: <1515401010-26802-1-git-send-email-nborisov@suse.com>

--nXUM22G2fW91pNrXpvpwXlAvt96HdbYq8
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2018=E5=B9=B401=E6=9C=8808=E6=97=A5 16:43, Nikolay Borisov wrote:
> This test has been failing for btrfs for quite some time,
> at least since 4.7. There are 2 implementation details of btrfs that
> it exposes:
>=20
> 1. Currently btrfs filesystem under 100mb are created in Mixed block
> group mode. Freespace accounting for it is not 100% accurate - I've
> observed around 100-200kb discrepancy between a newly created filesyste=
m,
> then writing a file and deleting it and checking the free space. This
> falls within %3 and not %1 as hardcoded in the test.
>=20
> 2. BTRFS won't flush it's delayed allocation on file deletion if less
> than 32mb are deleted. On such files we need to perform sync (missing
> in the test) or wait until time elapses for transaction commit.

I'm a little confused about the 32mb limit.

My personal guess about the reason to delay space freeing would be:
1) Performance
   Btrfs tree operation (at least for write) is slow due to its tree
   design.
   So it may makes sense to delay space freeing.

   But in that case, 32MB may seems to small to really improve the
   performance. (Max file extent size is 128M, delaying one item
   deletion doesn't really improve performance)

2) To avoid later new allocation to rewrite the data.
   It's possible that freed space of deleted inode A get allocated to
   new file extents. And a power loss happens before we commit the
   transaction.

   In that case, if everything else works fine, we should be reverted to
   previous transaction where deleted inode A still exists.
   But we lost its data, as its data is overwritten by other file
   extents. And any read will just cause csum error.

   But in that case, there shouldn't be any 32MB limit, but all deletion
   of orphan inodes should be delayed.

   And further more, this can be addressed using log tree, to log such
   deletion so at recovery time, we just delete that inode.

So I'm wonder if we can improve btrfs deletion behavior.


>=20
> Since mixed mode is somewhat deprecated and btrfs is not really intende=
d
> to be used on really small devices let's just adjust the test to
> create a 101mb fs, which doesn't use mixed mode and really test
> freespace accounting.

Despite of some btrfs related questions, I'm wondering if there is any
standard specifying (POSIX?) how a filesystem should behave when
unlinking a file.

Should the space freeing be synchronized? And how should statfs report
available space?

In short, I'm wondering if this test and its expected behavior is
generic enough for all filesystems.

Thanks,
Qu

>=20
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  tests/generic/015 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/generic/015 b/tests/generic/015
> index 78f2b13..416c4ae 100755
> --- a/tests/generic/015
> +++ b/tests/generic/015
> @@ -53,7 +53,7 @@ _supported_os Linux
>  _require_scratch
>  _require_no_large_scratch_dev
> =20
> -_scratch_mkfs_sized `expr 50 \* 1024 \* 1024` >/dev/null 2>&1 \
> +_scratch_mkfs_sized `expr 101 \* 1024 \* 1024` >/dev/null 2>&1 \
>      || _fail "mkfs failed"
>  _scratch_mount || _fail "mount failed"
>  out=3D$SCRATCH_MNT/fillup.$$
>=20


--nXUM22G2fW91pNrXpvpwXlAvt96HdbYq8--

--9BVg7DicOBzg7w6d2COf0xyP6uESkcaRD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAlpTaekXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qjsPQf9Hftzy6KvEZBz3K4mN8AGVkU8
0ti4uP0YQvwVDDn7I70GSqWh12bkKHVYBPJ9Z7Dbt3RyXcsLmkUfEe3lAOR1xlMH
CtwDe+EMKUbf8ydxG6RCZAYNTNAOCUXbr+qqo0DiTtkfktUUwFBohvezPirZmEOI
OlCzMPHfvbSl6BhcTbDPZZ4EqdPl4pHVHKtQTOSXjZ11e8LfUVElFwk0YJ67IMLe
HFgKrz9Op9Swy7rLPKRiH1i0StQ+fGxKeJTpShaWnODoToDoYfcEF6d7WWCFmTix
dnGz0aUbAKjm2lOMqdiZS5qBRfvT6ZgHYHYWwO9mOmkPb8wf2Iql+rhdRSCNCA==
=IBqX
-----END PGP SIGNATURE-----

--9BVg7DicOBzg7w6d2COf0xyP6uESkcaRD--

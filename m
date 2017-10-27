Received: from synology.com ([59.124.61.242]:46473 "EHLO synology.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751399AbdJ0BAM (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 26 Oct 2017 21:00:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Fri, 27 Oct 2017 08:59:56 +0800
From: robbieko <robbieko@synology.com>
Subject: Re: [PATCH] btrfs: fix offset in test Btrfs delalloc accounting
 overflow
In-Reply-To: <1508997735-10630-1-git-send-email-robbieko@synology.com>
References: <1508997735-10630-1-git-send-email-robbieko@synology.com>
Message-ID: <109c849920c03821ba300e721c1a8164@synology.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: osandov@osandov.com
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

include Omar Sandoval.

robbieko =E6=96=BC 2017-10-26 14:02 =E5=AF=AB=E5=88=B0:
> From: Robbie Ko <robbieko@synology.com>
>=20
> Found it when test btrfs delalloc accounting overflow, Fix offset=20
> error.
> We will fill in the gaps between the created extents,
> then outstanding extents will all be merged into 1.
>=20
> Signed-off-by: Robbie Ko <robbieko@synology.com>
> ---
>  tests/btrfs/010 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/btrfs/010 b/tests/btrfs/010
> index ea201ad..00cac67 100755
> --- a/tests/btrfs/010
> +++ b/tests/btrfs/010
> @@ -58,7 +58,7 @@ done
>  # Fill in the gaps between the created extents. The outstanding=20
> extents will
>  # all be merged into 1, but there will still be 32k reserved.
>  for ((i =3D 0; i < 32 * 1024; i++)); do
> -	$XFS_IO_PROG -f -c "pwrite $((2 * 4096 * i + 1)) 4096" "$test_file"
> >>"$seqres.full"
> +	$XFS_IO_PROG -f -c "pwrite $((2 * 4096 * i + 4096)) 4096"
> "$test_file" >>"$seqres.full"
>  done
>=20
>  # Flush the delayed allocations.

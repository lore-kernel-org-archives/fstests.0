Received: from mx6-phx2.redhat.com ([209.132.183.39]:57743 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521AbbG2CC3 convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 28 Jul 2015 22:02:29 -0400
Date: Tue, 28 Jul 2015 22:02:28 -0400 (EDT)
From: Zirong Lang <zlang@redhat.com>
Message-ID: <763081039.330155.1438135348391.JavaMail.zimbra@redhat.com>
In-Reply-To: <1438093504-25230-1-git-send-email-eguan@redhat.com>
References: <1438093504-25230-1-git-send-email-eguan@redhat.com>
Subject: Re: [PATCH] common: fix _count_extents and _count_holes
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



----- =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6 -----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: "Eryu Guan" <eguan@redhat.com>
> =E6=94=B6=E4=BB=B6=E4=BA=BA: fstests@vger.kernel.org
> =E6=8A=84=E9=80=81: zlang@redhat.com, "Eryu Guan" <eguan@redhat.com>
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: =E6=98=9F=E6=9C=9F=E4=BA=8C, 2015=
=E5=B9=B4 7 =E6=9C=88 28=E6=97=A5 =E4=B8=8B=E5=8D=88 10:25:04
> =E4=B8=BB=E9=A2=98: [PATCH] common: fix _count_extents and _count_holes
>=20
> In _count_extents and _count_holes, the output of 'xfs_io -c "fiemap"'
> is saved in var res, but the following "echo $res" will merge the
> original output into one line. e.g.
>=20
> 	0: [0..63]: 96..159
> 	1: [64..127]: hole
>=20
> will be
>=20
> 	0: [0..63]: 96..159 1: [64..127]: hole
>=20
> so the extent count is always 0 if there's a hole.
>=20
> This makes generic/046 fail occasionally. (Seems it's easier to
> reproduce when the system is under some presure, e.g. with fsstress
> running.)
>=20
> Tested the new _count_extents and _count_holes with generic/04[3-9] and
> tests all passed as expect.
>=20
> Reported-by: Zorro Lang <zlang@redhat.com>
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---
>  common/rc | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/common/rc b/common/rc
> index 15e7795..0d3570f 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2434,14 +2434,12 @@ _require_fiemap()
> =20
>  _count_extents()
>  {
> -	res=3D`$XFS_IO_PROG -c "fiemap" $1 | tail -n +2`
> -	echo $res | grep -v hole | wc -l | $AWK_PROG '{print $1}'
> +	$XFS_IO_PROG -c "fiemap" $1 | tail -n +2 | grep -v hole | wc -l

Maybe just give quotation marks to $res will be ok, likes echo "$res"|....

And I think $AWK_PROG '{print $1}' try to ensure no blank at the end. So
keep it will be better, although I haven't seen "wc -l" print blank after=
 number;)

>  }
> =20
>  _count_holes()
>  {
> -	res=3D`$XFS_IO_PROG -c "fiemap" $1 | tail -n +2`
> -	echo $res | grep hole | wc -l | $AWK_PROG '{print $1}'
> +	$XFS_IO_PROG -c "fiemap" $1 | tail -n +2 | grep hole | wc -l
>  }
> =20
>  # arg 1 is dev to remove and is output of the below eg.
> --
> 2.4.3
>=20
>=20

Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AAA13E888
	for <fstests@vger.kernel.org>; Mon, 24 Jun 2024 13:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719236041; cv=none; b=rpphKtK4CkUp/yBTRavTC635KVEk9/YttfGCnFY1B6tZaLNhbVcfXtdGklZ1sejq15PFVSzI0uIRUY12mTDi2/M6YxnX53kObTkIdC36gPf43MuQ043VVa/yl05zSAhmp1fyP3B8o5Kn3PonWMIB3+/OgGLGqWhreLqr3O56Lu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719236041; c=relaxed/simple;
	bh=jzu/rKFf/2lyAQoWwoZtRfajwGObgiGrTFy6d6gXKuY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=u5eqibGxUPohU9IBRWbPA0ERuZwKDCtgjzlQS2nOHXP57GBGrO7YOPzkD6Ww9dDSUBNWi9zrMkMnyOXBnoNl6L2ms1oi4b8kWC53A2PdjZt0Q+PKAnQ+i79Ixv9/b1ecS6iXT6At0Vgxv6nf0QYtnNNGGhrhldTboycqh6Qw+F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=aQH936xp; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aQH936xp"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240624133356euoutp022b5d674764dcd54dab3d1158e0722298~b9BECM3DJ2373823738euoutp02r
	for <fstests@vger.kernel.org>; Mon, 24 Jun 2024 13:33:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240624133356euoutp022b5d674764dcd54dab3d1158e0722298~b9BECM3DJ2373823738euoutp02r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719236036;
	bh=645YQykb1YEY0Q1T9pEcKtyhj2y5j8bvWXYeh4Qakew=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=aQH936xpKhcpvOEfUKKqDbtb6ZXMf4vVhRdL7pxcyfeqUGBvHu4cpn2Rc5r9JOOlR
	 1sYG3RO4d4IBaUVBs21vMJqUmlf8s8Fr6d+2nJsLR3i4JoJ7aVFpvJU/u/+z+RZNsr
	 /rbO7k/BIypLEckVzZQgwkN8dKCCf7qdCoYv6fE4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240624133356eucas1p27d7f419df2d86d98593340e0f410854d~b9BD3aJgb2457924579eucas1p2n;
	Mon, 24 Jun 2024 13:33:56 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 25.47.09624.4C579766; Mon, 24
	Jun 2024 14:33:56 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240624133356eucas1p1e6af0454f24979b6072e933d9add8b3c~b9BDi1gEU0393003930eucas1p1R;
	Mon, 24 Jun 2024 13:33:56 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240624133356eusmtrp10c697639e949ca4bd20e7abd6699d30a~b9BDiK3z-2932329323eusmtrp14;
	Mon, 24 Jun 2024 13:33:56 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-32-667975c4a28b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 93.44.08810.4C579766; Mon, 24
	Jun 2024 14:33:56 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240624133355eusmtip28836e0bc10a4dd2651176ea195f965de~b9BDXgMzd0399503995eusmtip2R;
	Mon, 24 Jun 2024 13:33:55 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Mon, 24 Jun 2024 14:33:55 +0100
Received: from CAMSVWEXC01.scsc.local ([::1]) by CAMSVWEXC01.scsc.local
	([fe80::7d73:5123:34e0:4f73%13]) with mapi id 15.00.1497.012; Mon, 24 Jun
	2024 14:33:55 +0100
From: Daniel Gomez <da.gomez@samsung.com>
To: Zorro Lang <zlang@redhat.com>
CC: "fstests@vger.kernel.org" <fstests@vger.kernel.org>, Pankaj Raghav
	<p.raghav@samsung.com>, "mcgrof@kernel.org" <mcgrof@kernel.org>,
	"hughd@google.com" <hughd@google.com>
Subject: Re: [PATCH 3/5] common/rc: add recreation support for tmpfs
Thread-Topic: [PATCH 3/5] common/rc: add recreation support for tmpfs
Thread-Index: AQHaviKG3vJmF77yrkuJpj7O4MHjRLHLfNUAgAtsb4A=
Date: Mon, 24 Jun 2024 13:33:55 +0000
Message-ID: <y4z23gapu72ndr3kun7kx3pakrjlej57grqsocc6wgti5y3kqa@hmeylbnnnkza>
In-Reply-To: <20240617070654.t3dvlvm4br354mpv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9D43EA4D51796441BF4044E85AF30B0F@scsc.local>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7djP87pHSivTDFomSlqcbtnLbvH0Ux+L
	xY0JTxkt9p7cyerA4rFgU6nHplWdbB7v911l8/i8SS6AJYrLJiU1J7MstUjfLoErY/2B+awF
	y0Qr1kzZxNTAeJS/i5GTQ0LAROLQ9E9MXYxcHEICKxglPi36wQzhfGGUeH7wNzuE85lRYvmN
	5WwwLTPnv2eESCxnlJi77i4jXNW6hm42COcMo8SXzsOsEM5KRol5D6eygvSzCWhK7Du5iR3E
	FhFQlFjz8yLYRmaBjYwSl+a9A1siLOAisbNlGhNEkatE+6T7rBC2lcTbph6wGhYBVYmn61+A
	1fAK+Eos7P4HZnMKxEhcn3kRbAGjgKzEo5W/wGxmAXGJW0/mM0E8ISixaPYeZghbTOLfrodQ
	z+lInL3+hBHCNpDYunQfC4StLPFo7nlmiDk6Egt2f2KDsC0ldnUsZoKwtSWWLXzNDHGPoMTJ
	mU+gejdzSqxZ4gZhu0jcunaZHcIWlnh1fAv7BEadWUjOm4VkxSwkK2YhWTELyYoFjKyrGMVT
	S4tz01OLDfNSy/WKE3OLS/PS9ZLzczcxApPP6X/HP+1gnPvqo94hRiYOxkOMEhzMSiK80+vL
	0oR4UxIrq1KL8uOLSnNSiw8xSnOwKInzqqbIpwoJpCeWpGanphakFsFkmTg4pRqYslvXs1/l
	kFy35bH+TovIi32HxSUWfb3XePW9RcQHhXU75x58/iL+eMtdtiuq7p9PLjX8NFVXfFHSEpMn
	7qp/Ah8sbtkQp1D60EJFwGCaCMOdRuUzJ358OZvmzxwza+LB1gTJ7tR81+KCJT+YHIPMZv8o
	eTmle1HE54L5l6oD3+inrnQ/bfveMOJp4afXCxKPqF7w0X11z2rVW6mtpzg/sOxT2nH3Y/NG
	71MMWrpL9jo8W6N2sdngekuVfx2P5lfhf7HmZz7uvlZbnvNKOXH3q/svQjksHRUYj6h9nC++
	WLb24quTicvWd1c/eqqw8fzpSK4alZ1WvWvXSbs1uj0V2xAWISdypvn6n4LT/lWeSUosxRmJ
	hlrMRcWJAN1DB0GtAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsVy+t/xe7pHSivTDK7uZbY43bKX3eLppz4W
	ixsTnjJa7D25k9WBxWPBplKPTas62Tze77vK5vF5k1wAS5SeTVF+aUmqQkZ+cYmtUrShhZGe
	oaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexvoD81kLlolWrJmyiamB8Sh/FyMnh4SA
	icTM+e8Zuxi5OIQEljJKzHrQzAqRkJHY+OUqlC0s8edaFxtE0UdGiZ/P77BAOGcYJS7fPswK
	4axklDiw/QULSAubgKbEvpOb2EFsEQFFiTU/LzKDFDELbGSUuDTvHRtIQljARWJnyzQmiCJX
	ifZJ91khbCuJt009YDUsAqoST9e/AKvhFfCVWNj9jwliWy+TxJKf/8ASnAIxEtdnXgTbxigg
	K/Fo5S8wm1lAXOLWk/lMEE8ISCzZc54ZwhaVePn4H9RzOhJnrz9hhLANJLYu3ccCYStLPJoL
	Uc8MVLNg9yc2CNtSYlfHYiYIW1ti2cLXzBDHCUqcnPmEZQKjzCwkq2chaZ+FpH0WkvZZSNoX
	MLKuYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECEwt24793LyDcd6rj3qHGJk4GA8xSnAwK4nw
	Tq8vSxPiTUmsrEotyo8vKs1JLT7EaAoMvInMUqLJ+cDkllcSb2hmYGpoYmZpYGppZqwkzutZ
	0JEoJJCeWJKanZpakFoE08fEwSnVwDRFy7Imt9jS72yT/1o5ta3Bnx5+ljo+XfyAu+bUqosv
	Up7t/Hh9Z6NSmeNT25SmOb1LJ309yO+d4Pu1ab1lZc/PRV7JYTtsI95smCV1ZeOZ+YaJIvNe
	/pad/cdfisUqZNmGWsl/d1Zw1QY21xks0TpzLy34tROXy58lh0rTE+zfWQi4TembEuaoxO2j
	eu2JCZtwbMfvYI5Iz0vnD9ttKbcSutii+8VtlTpvWZzIr+AClb+B4hfaMrUn3ZLcpXd72d2j
	XR7vlViKpshFThORdpOVmCWYPaFo22mNu88Zr3SEtzCufmS3uOBE/vRodVc/rWA2H8GuaIuf
	3a802FOiMlsSQwzmdb2o++YQJw40pDgj0VCLuag4EQAaH56NtgMAAA==
X-CMS-MailID: 20240624133356eucas1p1e6af0454f24979b6072e933d9add8b3c
X-Msg-Generator: CA
X-RootMTR: 20240614061727eucas1p20922542ef700d0f41dc9cc9628392518
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240614061727eucas1p20922542ef700d0f41dc9cc9628392518
References: <20240614061722.1080-1-da.gomez@samsung.com>
	<CGME20240614061727eucas1p20922542ef700d0f41dc9cc9628392518@eucas1p2.samsung.com>
	<20240614061722.1080-4-da.gomez@samsung.com>
	<20240617070654.t3dvlvm4br354mpv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Mon, Jun 17, 2024 at 03:06:54PM GMT, Zorro Lang wrote:
> On Fri, Jun 14, 2024 at 06:17:25AM +0000, Daniel Gomez wrote:
> > Add support for test device recreation (RECREATE_TEST_DEV=3Dtrue) for
> > tmpfs. This allows to inherit the tmpfs profile extra mount options
> > (TMPFS_MOUNT_OPTIONS) for the test device.
> >=20
> > Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> > ---
> >  common/rc | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/common/rc b/common/rc
> > index 163041fea..7f995b0fa 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -457,7 +457,7 @@ _test_mount()
> >      fi
> > =20
> >      _test_options mount
> > -    _mount -t $FSTYP$FUSE_SUBTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SE=
LINUX_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
> > +    _mount -t $FSTYP$FUSE_SUBTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SE=
LINUX_MOUNT_OPTIONS $TMPFS_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
>=20
> We shouldn't use a FSTYP specific parameter in a common mount line.
> Better to set it in a "$FSTYP=3Dtmpfs" branch. I notice that we set:
>=20
>         tmpfs)
>                 # We need to specify the size at mount, use 1G by default
>                 echo "-o size=3D1G $TMPFS_MOUNT_OPTIONS"
>=20
> in _common_mount_opts(). Then it will be set in MOUNT_OPTIONS and
> TEST_FS_MOUNT_OPTS, won't that help?

No for the recreation path with specific section variables as we have not y=
et
source '. common/rc'. Dropping changes in _test_mount() and force reading t=
est
mount options makes $TMPFS_MOUNT_OPTION available for the test in the recre=
ation
path.

diff --git a/check b/check
index 723a52e30..b3f7d7b14 100755
--- a/check
+++ b/check
@@ -773,6 +773,7 @@ function run_section()
                        status=3D1
                        exit
                fi
+               _test_mount_opts
                if ! _test_mount
                then
                        echo "check: failed to mount $TEST_DEV on $TEST_DIR=
"

I understand from Darrick's comment that the change above in _test_mount() =
is
wrong. Would this solution be okay? Not sure if this is a bug but I'd guess=
 all
specific mount options are now ignored in the recreation path (not only tmp=
fs).

>=20
> Thanks,
> Zorro
>=20
>=20
> >      mount_ret=3D$?
> >      [ $mount_ret -ne 0 ] && return $mount_ret
> >      _idmapped_mount $TEST_DEV $TEST_DIR
> > @@ -604,6 +604,9 @@ _test_mkfs()
> >      pvfs2)
> >  	# do nothing for pvfs2
> >  	;;
> > +	tmpfs)
> > +	# do nothing for tmpfs
> > +	;;
> >      udf)
> >          $MKFS_UDF_PROG $MKFS_OPTIONS $* $TEST_DEV > /dev/null
> >  	;;
> > --=20
> > 2.43.0
> >=20
> =

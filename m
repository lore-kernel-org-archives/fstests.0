Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC5E4DA08
	for <fstests@vger.kernel.org>; Fri, 28 Jun 2024 22:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719613761; cv=none; b=n5cEmq4lAqF+bQUiDm7wHjkJSWmYMCU0uHHv7cLndLSRlu3WShaNc+N/IBzCD6tIWjSA6tsSso8S9imR0pK4p/uTbkoAIxXn6ByxeologrusN9SIqgLKV9l/9voo+f0ZeGBJQ3PwXaM6x6RXW4OnR7loEr90koOENeFVOu5bGyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719613761; c=relaxed/simple;
	bh=oi6rwe0lbjZjyaNLXFkmlBMOqO6A7+rVBn5wjA185dk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=rxdBEw7LHRwOmYNW6lcCbOT+IzNBJU70tV8oGKIT17eKYodRp5yJ5XXajYsOiouEWn5GTLzE7FkBXWk5JGuLcZrZhE4ajsxqLy2BrFWHoP7Vq8HZxYwNRlLGdFS6mMSAzMQiwSepP+ndbFWgceyBP2QIpBmRgPa9dyHHbvx31E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=XNtXq5ZO; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XNtXq5ZO"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240628222911euoutp01eb419b98c59e56776cd590b70f1ced5d~dS5iYUKzx0059600596euoutp01C
	for <fstests@vger.kernel.org>; Fri, 28 Jun 2024 22:29:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240628222911euoutp01eb419b98c59e56776cd590b70f1ced5d~dS5iYUKzx0059600596euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719613751;
	bh=BDpEqicvUwLodN7g+6VLqY5S/VzhUrLdsP9Tp9pmHPY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=XNtXq5ZO4dYDfw+fILh/5OjZZUcARSoRRwrkjV8dxKyrXyUBuRefjSTI9n7uVkCRB
	 B3wGe8AxVgoRrwCPTzeSGGpbjrO0LdwhTW13YGaSHeLc6E8PLe+0mGZ8hQuYpXNCRd
	 GP8QwqOcHoNUVokB5mc+B7dmLiBwMyp2Z/p0g7K4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240628222911eucas1p244ec644e18cb93612fbe81c6063b4626~dS5h-zvzm1182511825eucas1p2K;
	Fri, 28 Jun 2024 22:29:11 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 28.45.09624.6393F766; Fri, 28
	Jun 2024 23:29:10 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240628222909eucas1p14cc65fa216ec5e7bcf397a3a36903704~dS5gwfKxO0727807278eucas1p1s;
	Fri, 28 Jun 2024 22:29:09 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240628222909eusmtrp1f01ff9a705b5e5db441ee1cf4e7483f4~dS5gv8tJt1215812158eusmtrp1c;
	Fri, 28 Jun 2024 22:29:09 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-92-667f39367b87
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 3A.E9.08810.5393F766; Fri, 28
	Jun 2024 23:29:09 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240628222909eusmtip2561895482b7604859071cd21774965bd~dS5gcD4RI0164001640eusmtip2t;
	Fri, 28 Jun 2024 22:29:09 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Fri, 28 Jun 2024 23:29:06 +0100
Received: from CAMSVWEXC01.scsc.local ([::1]) by CAMSVWEXC01.scsc.local
	([fe80::7d73:5123:34e0:4f73%13]) with mapi id 15.00.1497.012; Fri, 28 Jun
	2024 23:29:06 +0100
From: Daniel Gomez <da.gomez@samsung.com>
To: Zorro Lang <zlang@redhat.com>
CC: "Darrick J. Wong" <djwong@kernel.org>, "fstests@vger.kernel.org"
	<fstests@vger.kernel.org>, Pankaj Raghav <p.raghav@samsung.com>,
	"mcgrof@kernel.org" <mcgrof@kernel.org>, "hughd@google.com"
	<hughd@google.com>
Subject: Re: [PATCH 3/5] common/rc: add recreation support for tmpfs
Thread-Topic: [PATCH 3/5] common/rc: add recreation support for tmpfs
Thread-Index: AQHaviKG3vJmF77yrkuJpj7O4MHjRLHLfNUAgAtsb4CABZv+AIABQt2A
Date: Fri, 28 Jun 2024 22:29:05 +0000
Message-ID: <5rbzx2ugjmxwbwg7sie2b2kgswdumegye2ncq2uf3uumngucrr@qhasezhndajh>
In-Reply-To: <20240628031328.z3ehybrb2cnatksi@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6209E972C718474DB37327C608ADF962@scsc.local>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsWy7djPc7pmlvVpBk8XmFtcfsJncbplL7vF
	0099LBY3JjxltNh7cierA6vHgk2lHptWdbJ5vN93lc3j8ya5AJYoLpuU1JzMstQifbsEroz/
	92MLfhpVzNixgbWB8btyFyMnh4SAiUT//X9MXYxcHEICKxgldk09zw7hfGGUeHv0P1TmM6PE
	/+kfmGBavt6cwwiRWM4o8eZeKwtcVe/ek+wgVUICZxglDr/zg0isZJRoPdXJCJJgE9CU2Hdy
	E1iRiICixJqfF5lBipgFbjFK/O0/zAaSEBZwkdjZMo0JoshVon3SfVYI203i5YK/LCA2i4Cq
	xPGzh8BqeAV8JT59awWyOTg4BWIkXpwIAAkzCshKPFr5C2wXs4C4xK0n86FeEJRYNHsPM4Qt
	JvFv10M2CFtH4uz1J4wQtoHE1qX7WCBsZYkv7cfZIOboSCzY/QnKtpT4cWUqE4StLbFs4Wtm
	iHMEJU7OfAIOFQmB3ZwSny9PY4UY5CIx79hnqAXCEq+Ob2GfwKgzC8l9s5DsmIVkxywkO2Yh
	2bGAkXUVo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYAI6/e/4px2Mc1991DvEyMTBeIhR
	goNZSYSXP7MuTYg3JbGyKrUoP76oNCe1+BCjNAeLkjivaop8qpBAemJJanZqakFqEUyWiYNT
	qoGp3bObScP6sn/uOtMTDY3Tgs97Tzdn2BTmYRjt6PU7ZevSgJnmkxfO26cg5WbGyT1DKOxy
	21GvbZH1L40MJWyWrbbSr+38Fx/7XUw68t4EM5uDrBd2uXfOKP9y+NAzn6DuC8/52g8u2m45
	24O7ic9AfyETc5GJssdnh7cvZl+c/UG0Yuu3Nj6F5rLE9uO3JVMKmM/JTniY3JH1LWpr2SKr
	Y59PuJ48OGWhRZvs4uq53DO7eV0OL+cW9MqsWfr9Ac8Gf9ZcfW6ZXFfpIzoWjg5T/S8cveWy
	LpplWtOunMiNv60j55sd0rTZuzjD58ahwKBZ5j6Pmd6JTOJkNb/c0+OxRqpgs5tkn1jQ44IM
	FyWW4oxEQy3mouJEAA0ckCWvAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsVy+t/xe7qmlvVpBq3rVS0uP+GzON2yl93i
	6ac+FosbE54yWuw9uZPVgdVjwaZSj02rOtk83u+7yubxeZNcAEuUnk1RfmlJqkJGfnGJrVK0
	oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsb/+7EFP40qZuzYwNrA+F25i5GT
	Q0LAROLrzTmMXYxcHEICSxkl+k/0MUMkZCQ2frnKCmELS/y51sUGUfSRUeLJX5AiEOcMo8St
	h3NYIJyVjBIzDh1nA2lhE9CU2HdyEzuILSKgKLHm50WwDmaBW4wSf/sPgxUJC7hI7GyZxgRR
	5CrRPuk+K4TtJvFywV8WEJtFQFXi+NlDYDW8Ar4Sn761MkFsW8ws8ePjIyCHg4NTIEbixYkA
	kBpGAVmJRyt/gS1mFhCXuPVkPhPEDwISS/ach/pNVOLl439Qv+lInL3+hBHCNpDYunQfC4St
	LPGlHeIZZqCaBbs/QdmWEj+uTGWCsLUlli18zQxxm6DEyZlPWCYwysxCsnoWkvZZSNpnIWmf
	haR9ASPrKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMD0su3Yz807GOe9+qh3iJGJg/EQowQH
	s5IIL39mXZoQb0piZVVqUX58UWlOavEhRlNg2E1klhJNzgcmuLySeEMzA1NDEzNLA1NLM2Ml
	cV7Pgo5EIYH0xJLU7NTUgtQimD4mDk6pBqbZla2HFoZ2Ln2WPas/kGOuyY20izN4FrfEBD2R
	sdgYGRxju36iVnbW9UmlCRN5fA63TA4WeebKXZYQZvFbhfmapLFWVV+e/ax9zZcOe7PHNpx/
	FpK8OiBFeONbA5szPtPiJcISKrI2pYjPfXdhVvy7C83s7Dfmem2v/sfox19xsubsrHihfr2P
	UUVJFfdaT894yXD4Un/QcoXFDdL/v3youHvM7ah1w8lfDC/9n86X8vn2+5PnnnLGLfPXME7r
	nqxtnhV4rOSf5ZHfm1YdVnDUk/maKluxebJ/pp7GqQV+NdXfel1TJn6rjd1hKLItXuJwVtH+
	/0eXTpp99e1+l3IDnRPLLuS0Tvk0PfnP4z4lluKMREMt5qLiRADBakPTuAMAAA==
X-CMS-MailID: 20240628222909eucas1p14cc65fa216ec5e7bcf397a3a36903704
X-Msg-Generator: CA
X-RootMTR: 20240614061727eucas1p20922542ef700d0f41dc9cc9628392518
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240614061727eucas1p20922542ef700d0f41dc9cc9628392518
References: <20240614061722.1080-1-da.gomez@samsung.com>
	<CGME20240614061727eucas1p20922542ef700d0f41dc9cc9628392518@eucas1p2.samsung.com>
	<20240614061722.1080-4-da.gomez@samsung.com>
	<20240617070654.t3dvlvm4br354mpv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
	<y4z23gapu72ndr3kun7kx3pakrjlej57grqsocc6wgti5y3kqa@hmeylbnnnkza>
	<20240628031328.z3ehybrb2cnatksi@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Fri, Jun 28, 2024 at 11:13:28AM GMT, Zorro Lang wrote:
> On Mon, Jun 24, 2024 at 01:33:55PM +0000, Daniel Gomez wrote:
> > On Mon, Jun 17, 2024 at 03:06:54PM GMT, Zorro Lang wrote:
> > > On Fri, Jun 14, 2024 at 06:17:25AM +0000, Daniel Gomez wrote:
> > > > Add support for test device recreation (RECREATE_TEST_DEV=3Dtrue) f=
or
> > > > tmpfs. This allows to inherit the tmpfs profile extra mount options
> > > > (TMPFS_MOUNT_OPTIONS) for the test device.
> > > >=20
> > > > Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> > > > ---
> > > >  common/rc | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/common/rc b/common/rc
> > > > index 163041fea..7f995b0fa 100644
> > > > --- a/common/rc
> > > > +++ b/common/rc
> > > > @@ -457,7 +457,7 @@ _test_mount()
> > > >      fi
> > > > =20
> > > >      _test_options mount
> > > > -    _mount -t $FSTYP$FUSE_SUBTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS=
 $SELINUX_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
> > > > +    _mount -t $FSTYP$FUSE_SUBTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS=
 $SELINUX_MOUNT_OPTIONS $TMPFS_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
> > >=20
> > > We shouldn't use a FSTYP specific parameter in a common mount line.
> > > Better to set it in a "$FSTYP=3Dtmpfs" branch. I notice that we set:
> > >=20
> > >         tmpfs)
> > >                 # We need to specify the size at mount, use 1G by def=
ault
> > >                 echo "-o size=3D1G $TMPFS_MOUNT_OPTIONS"
> > >=20
> > > in _common_mount_opts(). Then it will be set in MOUNT_OPTIONS and
> > > TEST_FS_MOUNT_OPTS, won't that help?
> >=20
> > No for the recreation path with specific section variables as we have n=
ot yet
> > source '. common/rc'. Dropping changes in _test_mount() and force readi=
ng test
> > mount options makes $TMPFS_MOUNT_OPTION available for the test in the r=
ecreation
> > path.
> >=20
> > diff --git a/check b/check
> > index 723a52e30..b3f7d7b14 100755
> > --- a/check
> > +++ b/check
> > @@ -773,6 +773,7 @@ function run_section()
> >                         status=3D1
> >                         exit
> >                 fi
> > +               _test_mount_opts
>=20
> Actually the get_next_config function (from common/config) should have re=
loaded
> the mount and mkfs paramters.
>=20
> run_section()
> {
>         ...
>         get_next_config $section
>         ...
>=20
>         if $RECREATE_TEST_DEV || [ "$OLD_FSTYP" !=3D "$FSTYP" ]; then
>                 ...
>                 if ! _test_mkfs >$tmp.err 2>&1
>                 ...
>                 if ! _test_mount
>                 ...
> }
>=20
> But why it doesn't?
>=20
> Oh, due to the get_next_config does things as this:
>=20
> get_next_config() {
>         ...
>         unset MOUNT_OPTIONS
>         unset TEST_FS_MOUNT_OPTS
>         unset MKFS_OPTIONS
>         unset FSCK_OPTIONS
>         ...
>         if [ ! -z "$OLD_FSTYP" ] && [ $OLD_FSTYP !=3D $FSTYP ]; then
>                 [ -z "$MOUNT_OPTIONS" ] && _mount_opts
>                 [ -z "$TEST_FS_MOUNT_OPTS" ] && _test_mount_opts
>                 [ -z "$MKFS_OPTIONS" ] && _mkfs_opts
>                 [ -z "$FSCK_OPTIONS" ] && _fsck_opts
>                 ...
>         else
>                 [ -z "$MOUNT_OPTIONS" ] && export MOUNT_OPTIONS=3D$OLD_MO=
UNT_OPTIONS
>                 [ -z "$TEST_FS_MOUNT_OPTS" ] && export TEST_FS_MOUNT_OPTS=
=3D$OLD_TEST_FS_MOUNT_OPTS
>                 [ -z "$MKFS_OPTIONS" ] && export MKFS_OPTIONS=3D$OLD_MKFS=
_OPTIONS
>                 [ -z "$FSCK_OPTIONS" ] && export FSCK_OPTIONS=3D$OLD_FSCK=
_OPTIONS
>                 [ -z "$USE_EXTERNAL" ] && export USE_EXTERNAL=3D$OLD_USE_=
EXTERNAL
>         fi
>         ...
> }
>=20
> Only if the later FSTYP is different with the former one, then get_next_c=
onfig
> reloads those OPTIONS.
>=20
> 1) That helps you don't need to set duplicated paramters in each section.
> 2) But that causes you can't reset/reload something likes TEST_FS_MOUNT_O=
PTS,
> except you set MOUNT_OPTIONS, TEST_FS_MOUNT_OPTS, ... directly.
>=20
> I'm not sure how many people depends on the 1)st behavior long time. And =
how
> many people hope to remove the limitation of [ $OLD_FSTYP !=3D $FSTYP ]. =
Any change
> will be default behavior change.
>=20
> But we might can bring the $RECREATE_TEST_DEV into get_next_config(), lik=
es:
>   if $RECREATE_TEST_DEV || ([ -n "$OLD_FSTYP" ] && [ "$OLD_FSTYP" !=3D "$=
FSTYP" ])
>=20
> I didn't give it a test, any better ideas are welcome :)

This looks good to me to allow parsing specific fs mount options in section=
s.
I've also tested and works for my test case. Below my changes after droppin=
g
the above:

diff --git a/common/config b/common/config
index 43b32b93d..c739c4578 100644
--- a/common/config
+++ b/common/config
@@ -802,7 +802,7 @@ get_next_config() {
        fi

        parse_config_section $1
-       if [ ! -z "$OLD_FSTYP" ] && [ $OLD_FSTYP !=3D $FSTYP ]; then
+       if $RECREATE_TEST_DEV || ([ ! -z "$OLD_FSTYP" ] && [ $OLD_FSTYP !=
=3D $FSTYP ]); then
                [ -z "$MOUNT_OPTIONS" ] && _mount_opts
                [ -z "$TEST_FS_MOUNT_OPTS" ] && _test_mount_opts
                [ -z "$MKFS_OPTIONS" ] && _mkfs_opts

I think this is also the original intention of the recreation TEST_DEV
(commit [1]).

[1] f8e4f532f18d7517430d9849bfc042305d7f7f4d (check: Allow to recreate
TEST_DEV)

> Thanks,
> Zorro
>=20
> >                 if ! _test_mount
> >                 then
> >                         echo "check: failed to mount $TEST_DEV on $TEST=
_DIR"
> >=20
> > I understand from Darrick's comment that the change above in _test_moun=
t() is
> > wrong. Would this solution be okay? Not sure if this is a bug but I'd g=
uess all
> > specific mount options are now ignored in the recreation path (not only=
 tmpfs).
>=20
>=20
>=20
> >=20
> > >=20
> > > Thanks,
> > > Zorro
> > >=20
> > >=20
> > > >      mount_ret=3D$?
> > > >      [ $mount_ret -ne 0 ] && return $mount_ret
> > > >      _idmapped_mount $TEST_DEV $TEST_DIR
> > > > @@ -604,6 +604,9 @@ _test_mkfs()
> > > >      pvfs2)
> > > >  	# do nothing for pvfs2
> > > >  	;;
> > > > +	tmpfs)
> > > > +	# do nothing for tmpfs
> > > > +	;;
> > > >      udf)
> > > >          $MKFS_UDF_PROG $MKFS_OPTIONS $* $TEST_DEV > /dev/null
> > > >  	;;
> > > > --=20
> > > > 2.43.0
> > > >=20
> > >=20
> >=20
> =

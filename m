Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238CC45010
	for <fstests@vger.kernel.org>; Mon, 24 Jun 2024 20:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719262649; cv=none; b=CQ0yrFF0NWWbHRRDbZoVk3GJouUNCA0Aaf/zHs1fBXqJA2ns/8velGUVjcnHb83EQuwTeVePCbqWsW6GQuP1azxW/rVFZhDWlvKDevf1BLIt2ODEs6QbbJLE3FbF43O3EdkqGS8NATFnzEgIDgxhdlh1YooahHTCqI66/4Ebcq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719262649; c=relaxed/simple;
	bh=eyJHg5F5d7R6NTyPlNbQGpe+CbNjcywIQuk85WYaVAQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=KofOQ8PyiUkwC/HnzahaagTgE1Kff+r7KMxiZJfuUy5F+3k7g1Vd2eVcUhfscgyaDQ2edYdckZZtE/uaysdHy3lyJ1arIxaHwSt9B8yvqDWLylqot4G2LIGWyLo/gIRLbWc8Gj7sriiv7j4YcnA/yPkdvGCxhdaZiTg+90w/F08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZQIO3fcf; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZQIO3fcf"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240624205724euoutp012601f4739a0580fd9f8e7c82da504a2b~cDEQ_vi7g0507105071euoutp011
	for <fstests@vger.kernel.org>; Mon, 24 Jun 2024 20:57:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240624205724euoutp012601f4739a0580fd9f8e7c82da504a2b~cDEQ_vi7g0507105071euoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719262645;
	bh=nKUoMfDZNUs2w67iKjpbB8oEwRHYSzWXhXPnhZ+dv24=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=ZQIO3fcfMnYtEVZ/BVP8xOFH4QS5Jm07eTUCsO2xXDs1tucPO8nrquv6Zc6ZaShsp
	 MLvBQO8YJEp7uuCrmuO2aVVUcaycTZ9+eCZQs7iWHcq2Jp6xpG+asWJbMaWciSsmC4
	 +Prb4f2BmMB+mXkXCZoNaxLekNSqgYEP5PjefElk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240624205724eucas1p182e8733d35ea202b35d9ad2529b800bc~cDEQs-D6p2039920399eucas1p1h;
	Mon, 24 Jun 2024 20:57:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 0D.5B.09624.4BDD9766; Mon, 24
	Jun 2024 21:57:24 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240624205723eucas1p1af4c65861a148a1dd76e553fb494c11c~cDEPgDuMc1072610726eucas1p1_;
	Mon, 24 Jun 2024 20:57:23 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240624205723eusmtrp2b38808b43ececb5ad839ce757535620c~cDEPflczr1964519645eusmtrp2W;
	Mon, 24 Jun 2024 20:57:23 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-14-6679ddb4620a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 5A.D0.09010.3BDD9766; Mon, 24
	Jun 2024 21:57:23 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240624205723eusmtip17192ae66bd702073d169990654b2caa3~cDEPPByJR1202012020eusmtip1O;
	Mon, 24 Jun 2024 20:57:23 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Mon, 24 Jun 2024 21:57:22 +0100
Received: from CAMSVWEXC01.scsc.local ([::1]) by CAMSVWEXC01.scsc.local
	([fe80::7d73:5123:34e0:4f73%13]) with mapi id 15.00.1497.012; Mon, 24 Jun
	2024 21:57:22 +0100
From: Daniel Gomez <da.gomez@samsung.com>
To: "Darrick J. Wong" <djwong@kernel.org>
CC: "fstests@vger.kernel.org" <fstests@vger.kernel.org>, Pankaj Raghav
	<p.raghav@samsung.com>, "mcgrof@kernel.org" <mcgrof@kernel.org>,
	"hughd@google.com" <hughd@google.com>
Subject: Re: [PATCH 5/5] common/rc: print scratch and test mount options
Thread-Topic: [PATCH 5/5] common/rc: print scratch and test mount options
Thread-Index: AQHaviKGDA6KUdYWlUyy/G+RuOXD4LHHWaWAgA+XnQCAACe0AIAATDWA
Date: Mon, 24 Jun 2024 20:57:21 +0000
Message-ID: <gjz244x6sscng7gywkm46ynpsub6lrm45wi7ykfwd56mzafja6@4aamywtggevd>
In-Reply-To: <20240624162434.GH103020@frogsfrogsfrogs>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0E3CFC5F312A4E42B3021421EE8970B5@scsc.local>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsWy7djP87pb7lamGRyYIm9x+QmfxemWvewW
	Tz/1sVjcmPCU0YHFY8GmUo9NqzrZPD5vkgtgjuKySUnNySxLLdK3S+DKeN+1nr1gh3rF9I57
	LA2Mj2W7GDk5JARMJP6s3crexcjFISSwglFi8+HrbBDOF0aJ3XcXM0E4nxklbnRNYYZpaf1+
	hQUisZxRYu/lJWxwVf9PXmeFcM4wShxadZYZwlnJKHHzwiQmkH42AU2JfSc3sYPYIkD2kW/X
	wJYwC2xklLg07x0bSEJYwENi2puTjBBFnhLLW7axQthuEsd+bQdrZhFQlfi2einYUbwCvhI7
	FjwDirNzcAqYSXwvBokyCshKPFr5C6yaWUBc4taT+UwQLwhKLJq9B+odMYl/ux6yQdg6Emev
	P2GEsA0kti7dxwJhK0t8aT/OBjFHR2LB7k9QtqXEnGV3oGxtiWULX0NdIyhxcuYTcBBJCKzm
	lOi9uAJqmYtE38TpUAuEJV4d38I+gVFnFpL7ZiHZMQvJjllIdsxCsmMBI+sqRvHU0uLc9NRi
	w7zUcr3ixNzi0rx0veT83E2MwHRz+t/xTzsY5776qHeIkYmD8RCjBAezkgjv9PqyNCHelMTK
	qtSi/Pii0pzU4kOM0hwsSuK8qinyqUIC6YklqdmpqQWpRTBZJg5OqQam0iMPPBp/nCiIakk2
	+1rO8fd8UZXD6epNO+XddXo+Xv7N4aQUebCIo3nC4qoHLNmHJYOON2xceXna56reB9sb/vL9
	tXttfbR38Uc59m/uk/SFz84OmLXtkyHXwmTOmuNetjfvnFFK7+nM6hT7e8W8/UR0l0beoV3/
	4lrEl6U7vG1ZpLS34eznxS91/EVOWVh8OCtxpC5N+do0aYUDVlNdbtQ2da+I/9Ak8jjTyG5S
	jLL96lNXY06EJfhmeBcZ182+rPtQW+ZTvq62nvVT8UVuWzfPMpkQ6nRXpNxgq7aq/4+lMZkK
	pzoFclpl3tQZ5oXPWdhvq/2Nb+2JzoXe4pdfC3JLPWf+Nv8rh6JTtYgSS3FGoqEWc1FxIgCp
	+ZqCpgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsVy+t/xu7qb71amGey8yWdx+QmfxemWvewW
	Tz/1sVjcmPCU0YHFY8GmUo9NqzrZPD5vkgtgjtKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx
	1DM0No+1MjJV0rezSUnNySxLLdK3S9DLeN+1nr1gh3rF9I57LA2Mj2W7GDk5JARMJFq/X2Hp
	YuTiEBJYyijx+99qZoiEjMTGL1dZIWxhiT/Xutggij4ySnxe3gvVcYZRYsuOLVCZlYwSfadf
	M4K0sAloSuw7uYkdxBYBso98u8YEUsQssJFR4tK8d2wgCWEBD4lpb04yQhR5Sixv2cYKYbtJ
	HPu1HayZRUBV4tvqpWA38Qr4SuxY8AwsLiRwlUni9QKuLkZ2Dk4BM4nvxSBRRgFZiUcrf4FV
	MAuIS9x6Mp8J4gMBiSV7zkN9Jirx8vE/qM90JM5ef8IIYRtIbF26jwXCVpb40n6cDWKOjsSC
	3Z+gbEuJOcvuQNnaEssWvoa6TFDi5MwnLBMYZWYhWT0LSfssJO2zkLTPQtK+gJF1FaNIamlx
	bnpusZFecWJucWleul5yfu4mRmAi2Xbs55YdjCtffdQ7xMjEwXiIUYKDWUmEd3p9WZoQb0pi
	ZVVqUX58UWlOavEhRlNgyE1klhJNzgemsrySeEMzA1NDEzNLA1NLM2MlcV7Pgo5EIYH0xJLU
	7NTUgtQimD4mDk6pBqb48kSenHmmlv2NL2989q2fsMw1dOm3IqUnG27wlde+CqvhP7lql5/8
	uVajCx6Ki56JpQuZcTqWyBWuuju5xjxSmG9xjVbyop1f/kl+ayyeHXNGXMYj5r/1fu33ulL2
	KQxzuX9yLF52Yo+G5cku+3ka06fn6S7rnbvzgXRiUFah1r+ZK4JS1lYpNMzacVgmQIT16rY4
	PtP7hs69V3vnW+zJ/7hQbqbShmW196dVdgb0d7223nhvgWVU39r1FZu3PC//Fa8wr8d8juO9
	o33yr7U7F3bZGB9YvervtOdTD2lmhsbca9J9fjOyxFvlZitrb++ct9dmmp5msQjvfvKqTUf0
	Ylb4n81rN1y4uK74q6oSS3FGoqEWc1FxIgAilYL/rQMAAA==
X-CMS-MailID: 20240624205723eucas1p1af4c65861a148a1dd76e553fb494c11c
X-Msg-Generator: CA
X-RootMTR: 20240614061728eucas1p2d7488fbbd2887c5d60d2bd1e3fd48580
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240614061728eucas1p2d7488fbbd2887c5d60d2bd1e3fd48580
References: <20240614061722.1080-1-da.gomez@samsung.com>
	<CGME20240614061728eucas1p2d7488fbbd2887c5d60d2bd1e3fd48580@eucas1p2.samsung.com>
	<20240614061722.1080-6-da.gomez@samsung.com>
	<20240614155555.GE6110@frogsfrogsfrogs>
	<xxx2zqe7wyw7negkjjhgrhnykdw247jguaaykjdm2j2rpfwkcv@26mxj7pbpkae>
	<20240624162434.GH103020@frogsfrogsfrogs>

On Mon, Jun 24, 2024 at 09:24:34AM GMT, Darrick J. Wong wrote:
> On Mon, Jun 24, 2024 at 02:02:33PM +0000, Daniel Gomez wrote:
> > On Fri, Jun 14, 2024 at 08:55:55AM GMT, Darrick J. Wong wrote:
> > > On Fri, Jun 14, 2024 at 06:17:26AM +0000, Daniel Gomez wrote:
> > > > Mount options for a SCRATCH device might not be the same in the TES=
T
> > > > device if RECREATE_TEST_DEV is not enabled. So, print mount options=
 for
> > > > each device to clarify this.
> > > >=20
> > > > Add mount and mkfs info for TEST devices so we get the same informa=
tion
> > > > being printed for both devices.
> > > >=20
> > > > Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> > > > ---
> > > >  check     |  4 ++++
> > > >  common/rc | 20 ++++++++++++++++++--
> > > >  2 files changed, 22 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/check b/check
> > > > index 723a52e30..e02d28b39 100755
> > > > --- a/check
> > > > +++ b/check
> > > > @@ -807,7 +807,11 @@ function run_section()
> > > >  	# print out our test configuration
> > > >  	echo "FSTYP         -- `_full_fstyp_details`"
> > > >  	echo "PLATFORM      -- `_full_platform_details`"
> > > > +	echo "TEST device:"
> > > > +	echo "MKFS_OPTIONS  -- `_test_mkfs_options`"
> > > > +	echo "MOUNT_OPTIONS -- `_test_mount_options`"
> > > >  	if [ ! -z "$SCRATCH_DEV" ]; then
> > > > +	  echo "SCRATCH device:"
> > > >  	  echo "MKFS_OPTIONS  -- `_scratch_mkfs_options`"
> > > >  	  echo "MOUNT_OPTIONS -- `_scratch_mount_options`"
> > >=20
> > > Now there are two lines that start with "MKFS_OPTIONS"; will this bre=
ak
> > > anyone's parsing scripts?  Or should these be prefixed:
> > >=20
> > > echo "TEST_MKFS_OPTIONS -- `_test_mkfs_options`"
> > > ...
> > > echo "SCRATCH_MKFS_OPTIONS -- `_scratch_mkfs_options`"
> > >=20
> > > ?
> >=20
> > This looks like my initial version, but I prefer the 'sub-menu style' b=
ecause
> > we did not have these variables before. However, I think it makes sense=
 to
> > introduce them so we can differentiate between them.=20
>=20
> The trouble is, if your parsing script were doing something like
> splitting on "-- " then the "TEST device:" string would not split
> properly and you'd have to add context retention of some sort to know
> which "MKFS_OPTIONS" this was for.  Better just to namespace the new
> lines from the start.  I guess for compatibility's sake then we'd have
> to have:
>=20
> TEST_MKFS_OPTIONS -- -o foo=3Dbar
> MKFS_OPTIONS      -- -o foo=3Dbaz
>=20
> in the output, along with a comment somewhere in the source that the
> non-prefixed scratch mkfs options is that way for hyst[eo]rical output
> parsing reasons.

We are also reporting as MOUNT_OPTIONS the scratch mount options. But
$MOUNT_OPTIONS are just the 'common' options, a subset of the scratch mount
options.

But I agree with only adding information for TEST device.

>=20
> --D
>=20
> > I guess introducing this change would break anyone's parsing scripts re=
gardless?
> > However, I do think is necessary to specify the mount differences.
> > >=20
> > > Also should these four variables be captured explicitly by the report=
s
> > > that are generated by common/report ?
> >=20
> > I guess the report only includes the scratch mount options. I will upda=
te it to
> > include the new specific test and scratch mount/mkfs options.
> >=20
> > >=20
> > > --D
> > >=20
> > > >  	fi
> > > > diff --git a/common/rc b/common/rc
> > > > index a42792c37..b351a82eb 100644
> > > > --- a/common/rc
> > > > +++ b/common/rc
> > > > @@ -235,6 +235,17 @@ _scratch_mount_options()
> > > >  					$SCRATCH_DEV $SCRATCH_MNT
> > > >  }
> > > > =20
> > > > +_test_mount_options()
> > > > +{
> > > > +	_test_options mount
> > > > +
> > > > +	if $RECREATE_TEST_DEV || [ "$OLD_FSTYP" !=3D "$FSTYP" ]; then
> > > > +		echo $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $T=
MPFS_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
> > > > +	else
> > > > +		echo $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $*=
 $TEST_DEV $TEST_DIR
> > > > +	fi
> > > > +}
> > > > +
> > > >  _supports_filetype()
> > > >  {
> > > >  	local dir=3D$1
> > > > @@ -456,8 +467,7 @@ _test_mount()
> > > >          return $?
> > > >      fi
> > > > =20
> > > > -    _test_options mount
> > > > -    _mount -t $FSTYP$FUSE_SUBTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS=
 $SELINUX_MOUNT_OPTIONS $TMPFS_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
> > > > +    _mount -t $FSTYP$FUSE_SUBTYP `_test_mount_options $*`
> > > >      mount_ret=3D$?
> > > >      [ $mount_ret -ne 0 ] && return $mount_ret
> > > >      _idmapped_mount $TEST_DEV $TEST_DIR
> > > > @@ -571,6 +581,12 @@ _metadump_dev() {
> > > >  	esac
> > > >  }
> > > > =20
> > > > +_test_mkfs_options()
> > > > +{
> > > > +	_test_options mkfs
> > > > +	echo $TEST_OPTIONS $MKFS_OPTIONS $* $TEST_DEV
> > > > +}
> > > > +
> > > >  _test_mkfs()
> > > >  {
> > > >      case $FSTYP in
> > > > --=20
> > > > 2.43.0
> > > > =

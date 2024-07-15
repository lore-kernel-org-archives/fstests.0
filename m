Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F2429CA
	for <fstests@vger.kernel.org>; Mon, 15 Jul 2024 08:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721031458; cv=none; b=lzv+/hBsumAbBKw8qQumbIiLBEFlp1+klqiVS2HynAvXn/Lsj3LA5qpDTKMTZ8HsRurvfGOq6ocnJhX1Jh5r3gMD39yQWBuX5b2tSoYgHhBCKp8TxRSEduH38ZmNRwH2AFnVrKc6ycSahqB5fxelk6YGXBx8MP3cB3Fh9l2kTNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721031458; c=relaxed/simple;
	bh=GoM+AifZjp1AMa9V1+WgmhYwEw4zurIpT3r/wfTmgNA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=Xb3EbQirbbSOHOsiaVxHgZa/Jo6sch0sqT/b0tVrZ1BOhvHhsklEyUMphoy3aWnYNffKSlRLDZRXsyJ8K1SHIpAQ0WqLBpIiNQzVaWpOQJDu1IyMejYh00ERUjekGIoyGpoECc18mnJhSTcUNYpiulmysulibgC7pZpEefGgLjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ix+Pwitk; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ix+Pwitk"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240715081733euoutp010987f9a2eb08e0cf64950294de2f2cc7~iVP0kyVAl2147421474euoutp01R
	for <fstests@vger.kernel.org>; Mon, 15 Jul 2024 08:17:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240715081733euoutp010987f9a2eb08e0cf64950294de2f2cc7~iVP0kyVAl2147421474euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721031453;
	bh=BiaPb8WUTddmRoIPhc8z0Z7v72Jm6Q9DRVtEg2AyY8g=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=ix+PwitkncCA+urMWBuHujo7CwoBvxyc2A7CcRVEqwMUCTKFx2M8aBWY8REuLrod9
	 NCO0Kcec4qDxC4rWTN1cCrrE4SKm3PW5sS82CatZoBTSw1kqTe+Q53PjU8p+eQdjGT
	 j7CK39348cOPcolj/luk0gRJm/xqv+Vw2RHbGXWw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240715081733eucas1p2c06ce752495ff9cf1c34f8c1728c836b~iVP0TpCTp1329313293eucas1p2q;
	Mon, 15 Jul 2024 08:17:33 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id CA.9C.09620.D1BD4966; Mon, 15
	Jul 2024 09:17:33 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240715081733eucas1p1c3231e3abbf00fb4b529ecefb4587e6e~iVPz8tNca1294512945eucas1p1e;
	Mon, 15 Jul 2024 08:17:33 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240715081733eusmtrp1237930c0975403657ee305a31c16ddd1~iVPz75Oek2388223882eusmtrp1O;
	Mon, 15 Jul 2024 08:17:33 +0000 (GMT)
X-AuditID: cbfec7f5-d1bff70000002594-db-6694db1d2610
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 99.5C.09010.D1BD4966; Mon, 15
	Jul 2024 09:17:33 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240715081732eusmtip15e6915e334ed591e4874194b2fc92494~iVPzxFzhg0538605386eusmtip1y;
	Mon, 15 Jul 2024 08:17:32 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Mon, 15 Jul 2024 09:17:31 +0100
Received: from CAMSVWEXC01.scsc.local ([::1]) by CAMSVWEXC01.scsc.local
	([fe80::7d73:5123:34e0:4f73%13]) with mapi id 15.00.1497.012; Mon, 15 Jul
	2024 09:17:31 +0100
From: Daniel Gomez <da.gomez@samsung.com>
To: Zorro Lang <zlang@kernel.org>
CC: "fstests@vger.kernel.org" <fstests@vger.kernel.org>, "Darrick J. Wong"
	<djwong@kernel.org>, Zorro Lang <zlang@redhat.com>, "mcgrof@kernel.org"
	<mcgrof@kernel.org>, "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [PATCH v2 4/5] common/rc: read config section mount options for
 scratch devs
Thread-Topic: [PATCH v2 4/5] common/rc: read config section mount options
	for scratch devs
Thread-Index: AQHay8ZuobgB0V0DZkyEHSYB2UUxjLHy2T0AgASdUQA=
Date: Mon, 15 Jul 2024 08:17:31 +0000
Message-ID: <xc5udcdk77wkwerqvgbnzxtkvcwzx7uylecscmkw2fkxqh5urf@6bzj5jocpndb>
In-Reply-To: <20240712093341.ftesijixy2yrjlxx@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8C00E87753A4C04292A795F69658DE3A@scsc.local>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsWy7djP87qyt6ekGdy6K2Nx+QmfxemWvewW
	NyY8ZbTYf/QRi8XekztZHVg9Nq3qZPN4v+8qm8fnTXIBzFFcNimpOZllqUX6dglcGQfvL2Yv
	WMJX8W7PBNYGxuXcXYycHBICJhJ/b3xi62Lk4hASWMEo8e/SEkYI5wujRPOtxUwgVUICnxkl
	1vTUwXRM3rCLHaJoOaPEn/MwHUBFTxdfY4VwzjBKHHixkBGifSWjxPqLxiA2m4CmxL6Tm9hB
	bBEBRYm3R3rAupkFbjJKfD19jBUkISwQLfG/9yETRFGMxPbfExghbCuJH6e+sIHYLAKqEqvm
	HQer5xXwlTi/5CDYUE6g+q/fd4PVMwrISjxa+QssziwgLnHryXwmiB8EJRbN3sMMYYtJ/Nv1
	kA3C1pE4e/0JI4RtILF16T4WCFtRouPYTTaIOToSC3Z/grItJb7f/cYEYWtLLFv4mhniHkGJ
	kzOfsIA8JiGwnVNi27FGVohBLhIn7/6DWiAs8er4FvYJjDqzkNw3C8mOWUh2zEKyYxaSHQsY
	WVcxiqeWFuempxYb56WW6xUn5haX5qXrJefnbmIEpp7T/45/3cG44tVHvUOMTByMhxglOJiV
	RHhXskxME+JNSaysSi3Kjy8qzUktPsQozcGiJM6rmiKfKiSQnliSmp2aWpBaBJNl4uCUamDi
	KT0od1533vfe/eli95tOc7GsOjH95ldblbTAS2ZTefwcTTXzXWM0Lr684qDhN6d3XVxw6qQY
	m+593DeKG8z+6nD9XJIcYCts0KzTZTvZZdfxhsxzu7YdUvu21tNqEc85pvBb9sznZ2wQeGfR
	auTGKiHb1/K9WH9hy+TiDWXHzued3BUsFvqdefGe1BtG4lIiN7sOmPVzOs0T8d7DWOX5aelG
	na13P8RIfnniYShZ0Dh3dtO8Qnahlm29ifoyhmX1qZ0K2WpKl01rrfw4L++Oee/qarZNemqx
	8NFpTDNlBHcVZVftDbxn8miBy07JNRyyFf+7L3/zsMnzj7JZ+SoxhaPEOVI2zGJH+1JuJZbi
	jERDLeai4kQAi7HNg6wDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsVy+t/xu7qyt6ekGTzoYbW4/ITP4nTLXnaL
	GxOeMlrsP/qIxWLvyZ2sDqwem1Z1snm833eVzePzJrkA5ig9m6L80pJUhYz84hJbpWhDCyM9
	Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jIP3F7MXLOGreLdnAmsD43LuLkZODgkB
	E4nJG3axdzFycQgJLGWU2Lf/LhtEQkZi45errBC2sMSfa11sEEUfGSXWbdrBBOGcYZQ43rGD
	BcJZySjxYNcsRpAWNgFNiX0nN7GD2CICihJvj/QwghQxC9xklPh6+hjYXGGBaIn/vQ+ZIIpi
	JKYfnwDVYCXx49QXsDtYBFQlVs07DlbPK+ArcX7JQbAaIYH5TBLPd3OC2JxAvV+/7wZbzCgg
	K/Fo5S+wGmYBcYlbT+YzQfwgILFkz3lmCFtU4uXjf1C/6Uicvf6EEcI2kNi6dB8LhK0o0XHs
	JhvEHB2JBbs/QdmWEt/vfmOCsLUlli18zQxxm6DEyZlPWCYwysxCsnoWkvZZSNpnIWmfhaR9
	ASPrKkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMDEsu3Yzy07GFe++qh3iJGJg/EQowQHs5II
	70qWiWlCvCmJlVWpRfnxRaU5qcWHGE2BYTeRWUo0OR+Y2vJK4g3NDEwNTcwsDUwtzYyVxHk9
	CzoShQTSE0tSs1NTC1KLYPqYODilGph095bXxmyd/sim9ij//osrNKbPVbTps6r53BWryFR+
	o1KYTWuyzfRNP/a+3rgiTO2b+tk3nbefPJ1/WfgQ21nOT+ezPt1/fKC/J/2u0Yal29w3LpS0
	Wx3rLxFW0+mXe7XXfcYcsQSrD0vPLHGtX8Vg5KHkf+d5o5HV4gUamlO3/0jg1ONO19p8jeX5
	SlHLF2/KQtOzrvF+PPxvQffEJb89I5l1HjTxG9y/uM1I5/C8d7XVyQonS9/usYg6vUji9aaW
	zztmHYkRff7xVkVw1/OyGb1/fFc1fmHIjkprqajpOS1j2qcoGlvCxVK+/129wV7d/fdO3F7+
	o8Uw0VXjb+2msN9dZrMOCvP/uiRhs7tFiaU4I9FQi7moOBEASwa7grUDAAA=
X-CMS-MailID: 20240715081733eucas1p1c3231e3abbf00fb4b529ecefb4587e6e
X-Msg-Generator: CA
X-RootMTR: 20240712094934eucas1p1311bcdc37bccf98bdf5496cedd8df495
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240712094934eucas1p1311bcdc37bccf98bdf5496cedd8df495
References: <20240630-common-fixes-v2-0-16d26fb1dee0@samsung.com>
	<20240630-common-fixes-v2-4-16d26fb1dee0@samsung.com>
	<CGME20240712094934eucas1p1311bcdc37bccf98bdf5496cedd8df495@eucas1p1.samsung.com>
	<20240712093341.ftesijixy2yrjlxx@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Fri, Jul 12, 2024 at 05:49:24PM GMT, Zorro Lang wrote:
> On Sun, Jun 30, 2024 at 11:52:43PM +0200, Daniel Gomez via B4 Relay wrote=
:
> > From: Daniel Gomez <da.gomez@samsung.com>
> >=20
> > MOUNT_OPTIONS for scratch devices do not have specific fs mount options
> > values (such as TMPFS_MOUNT_OPTIONS) from the config section. So, allow
> > the scratch mount options to inherit section config values by reading
> > them from _common_mount_opts().
> >=20
> > Move $* to the end so scratch device can be umount/mount. Otherwise, we
> > end up with multiple mounts in the same scratch directory.
> >=20
> > Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> > ---
> >  common/rc | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/common/rc b/common/rc
> > index 51827119c..627dbaaaa 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -231,8 +231,8 @@ _scratch_mount_options()
> >  {
> >  	_scratch_options mount
> > =20
> > -	echo `_common_dev_mount_options $*` $SCRATCH_OPTIONS \
> > -					$SCRATCH_DEV $SCRATCH_MNT
> > +	echo `_common_mount_opts` $SCRATCH_OPTIONS \
> > +					$SCRATCH_DEV $SCRATCH_MNT $*
>=20
> Oh, you want to get the "specific fs mount options". But sorry this
> change brings in many regression failures, e.g. generic/219, generic/691,
> generc/381, generic/382 ... fail (on ext4 and so on).

I'm assuming the scratch device should have the default mount options provi=
ded
by _common_mount_opts(). Otherwise, I would have to include the default mou=
nt
options ('-o size=3D1G <section-mount-option>') in every section of my conf=
ig. So,
why a scratch device should not have the defaults?

>=20
> Thanks,
> Zorro
>=20
> >  }
> > =20
> >  _supports_filetype()
> >=20
> > --=20
> > 2.43.0
> >=20
> >=20
> > =

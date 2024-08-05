Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8209614E2FA
	for <fstests@vger.kernel.org>; Mon,  5 Aug 2024 12:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722859481; cv=none; b=WB+BMXOTT/v+QCrqsef9xdwZGhHDkygxuKnJNH8SbMU9qfzvMNLP7N2jXS6oBXE1ggqLXN9sC/zQHEAuV5YFk50+I0656oWIrlTbWHomqQZOkJvA+LOzrMmjh1e4IUSpPPWrVnpICxtQq5tmHp7jFeEUOsJfye9/kQ+0MJQyjnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722859481; c=relaxed/simple;
	bh=rKNhMBgxmbECGfORsvJfL2p+JJm/cgCZjJcFJI8cJGw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=QG+Allb6lZ/mASGz/5o+DcSPnhCw2OGhDO8ZVWtICaPZ28zSNfS5xQcqIq8pOd8J8kItOVVNB/oD/nsyor5XkmgceNYOQAcBQ24+7aPB6g073kNHea5eyQFP1Yjz2Uo33mM/yVL042gPPbuFRkFJnyfqMghZjV20uREdoBADITY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=SRJH9JZ/; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SRJH9JZ/"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240805120430euoutp012926b2b1012dd566eec317404119f447~o04_FnGY81176811768euoutp01E
	for <fstests@vger.kernel.org>; Mon,  5 Aug 2024 12:04:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240805120430euoutp012926b2b1012dd566eec317404119f447~o04_FnGY81176811768euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1722859470;
	bh=SFRYA9kalX7+v7aQKRIXscvDyuTNOffo8fZUkEW60/Y=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=SRJH9JZ/e9pTAc2xZmPH9PXfO/Z2AIUPbI126IKqg6JKZ3BjreZNWhMpy2x1HC6Qx
	 cOI1QFU5X9bStAARXNjDtMnwb2aeKaiL3G8ZjmG91u5f3fTWcjIb3yjvzm9H/xi2X1
	 r9vYoVJlYEZQMgwg4tRBUxJMfwAjEABlEl2NfAuk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240805120430eucas1p15a00aa0adc88567419b8b948a1f2c2b4~o0498lBKY0965609656eucas1p1v;
	Mon,  5 Aug 2024 12:04:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 96.C4.09620.ECFB0B66; Mon,  5
	Aug 2024 13:04:30 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240805120430eucas1p18d8da6f42c1d56ea9d1a066a90a87df1~o049hIAt_0575505755eucas1p14;
	Mon,  5 Aug 2024 12:04:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240805120430eusmtrp1602b39f7ad27688967e9d8af82486c0c~o049gau4h0880408804eusmtrp1d;
	Mon,  5 Aug 2024 12:04:30 +0000 (GMT)
X-AuditID: cbfec7f5-d31ff70000002594-f2-66b0bfce4adf
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id E7.A1.09010.ECFB0B66; Mon,  5
	Aug 2024 13:04:30 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240805120430eusmtip1ddfa7b5fed854c93dc0a4d756e7c4940~o049U5Sjb3195031950eusmtip1j;
	Mon,  5 Aug 2024 12:04:30 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Mon, 5 Aug 2024 13:04:29 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
	([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Mon, 5 Aug
	2024 13:04:29 +0100
From: Daniel Gomez <da.gomez@samsung.com>
To: Zorro Lang <zlang@kernel.org>
CC: "fstests@vger.kernel.org" <fstests@vger.kernel.org>, "Darrick J. Wong"
	<djwong@kernel.org>, Zorro Lang <zlang@redhat.com>, "mcgrof@kernel.org"
	<mcgrof@kernel.org>, "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [PATCH v2 4/5] common/rc: read config section mount options for
 scratch devs
Thread-Topic: [PATCH v2 4/5] common/rc: read config section mount options
	for scratch devs
Thread-Index: AQHay8ZuobgB0V0DZkyEHSYB2UUxjLHy2T0AgCXdr4A=
Date: Mon, 5 Aug 2024 12:04:29 +0000
Message-ID: <bihbprnxplarjpmydllesefqfwpsx77n4aksnh3madutu52bcp@k245lusqxu6w>
In-Reply-To: <20240712093341.ftesijixy2yrjlxx@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-ID: <937F0FC6C84FB5448C9570B5D03FDE8A@scsc.local>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsWy7djPc7rn9m9IM3i8UNni8hM+i9Mte9kt
	bkx4ymix/+gjFou9J3eyOrB6bFrVyebxft9VNo/Pm+QCmKO4bFJSczLLUov07RK4MqY19LIV
	fBep+Pisn7WB8ZtAFyMnh4SAicTea0/YQWwhgRWMEksWhHYxcgHZXxglnl35yw7hfGaUuLD3
	OBtMx7kzj1ghEssZJRpOtrLCVR27fpsZwjnNKPHk4WSEwbe+pIHYbAKaEvtObgKLiwgoSrw9
	0sMI0sAscJNR4uvpY6wgCWGBaIn/vQ+ZIIpiJLb/ngBUxAFkW0m8WVYFYrIIqEhsP5ECUsEr
	4CvxcucfsE5OoOqv33czgtiMArISj1b+AlvFLCAucevJfCaIDwQlFs3ewwxhi0n82/UQ6jMd
	ibPXnzBC2AYSW5fuY4GwFSU6jt1kg5ijI7Fg9yco21Ji5+ppTBC2tsSyha+ZIe4RlDg58wkL
	yFsSAts5Jd6ePQs1yEXixbuPULawxKvjW9gnMOrMQnLfLCQ7ZiHZMQvJjllIdixgZF3FKJ5a
	WpybnlpsnJdarlecmFtcmpeul5yfu4kRmHZO/zv+dQfjilcf9Q4xMnEwHmKU4GBWEuHtKt2Q
	JsSbklhZlVqUH19UmpNafIhRmoNFSZxXNUU+VUggPbEkNTs1tSC1CCbLxMEp1cAktytfJWeh
	0injfL13foxTVntJ7VjikFC23HKPqu327RfTPmdEXdR1KbE6IJKiu7Hv+XKn0xq7X79r36Sa
	tPDtxU2BVTprfz/NYto5J2Wx257HW9bXO+5jPHxUsuuDcuUl75cWtitvqZ3hSDvM4r9xg2qD
	t0/WnwwWqxC9+xZbS3v2XtsooX/q/lIGU977bZvj3t+qlLC5XuB2/G6lytnAFJH111WyThrs
	eeuU2hwhvLd1ymGG5D07vsnfqLPanHRurvTrT3p3goWyt5udW+qe9fQq4yWTpx9mlgVt3T3Z
	V5T9ZzTPI5b1Fw5udbaMLObtv7vSDhgfk5cIJjw/aifmyNf/RnA1q9jVRXmHWGqVWIozEg21
	mIuKEwGrpTv8qgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsVy+t/xu7rn9m9IM9jwi93i8hM+i9Mte9kt
	bkx4ymix/+gjFou9J3eyOrB6bFrVyebxft9VNo/Pm+QCmKP0bIryS0tSFTLyi0tslaINLYz0
	DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0MqY19LIVfBep+Pisn7WB8ZtAFyMnh4SA
	icS5M49Yuxi5OIQEljJKNB1awgyRkJHY+OUqK4QtLPHnWhcbiC0k8JFR4vetPIiG04wSt9et
	ZoJwVjBKtLxdA1bFJqApse/kJnYQW0RAUeLtkR5GkCJmgZuMEl9PHwMbKywQLfG/9yETRFGM
	xPTjE4AaOIBsK4k3y6pATBYBFYntJ1JAKngFfCVe7vzDCnHEfCaJ57s5QWxOoM6v33czgtiM
	ArISj1b+AlvLLCAucevJfCaIBwQkluw5D/WYqMTLx/+gHtOROHv9CSOEbSCxdek+FghbUaLj
	2E02iDk6Egt2f4KyLSV2rp7GBGFrSyxb+JoZ4jZBiZMzn7BMYJSZhWT1LCTts5C0z0LSPgtJ
	+wJG1lWMIqmlxbnpucVGesWJucWleel6yfm5mxiBKWXbsZ9bdjCufPVR7xAjEwfjIUYJDmYl
	Ed6u0g1pQrwpiZVVqUX58UWlOanFhxhNgUE3kVlKNDkfmNTySuINzQxMDU3MLA1MLc2MlcR5
	PQs6EoUE0hNLUrNTUwtSi2D6mDg4pRqYNLvi9++d6iLb+frpnEtaiRNW3p4avCaM4dnhh+V9
	93y7b+tavzwVFmzipcD9JohD6Lh4TXtynNXEWWHJG47p8uRPbneYs6P9pcn0eTVra5K0Fwt8
	+Ph6+Z9lpc/YeddmKFxeeufgtAledt8Z1RfZL/Ga8FehzDYges8ep8s2vKn9YoJCpTarqm5e
	/l2ZenuK8haB25cD92bc+nr21buC3qYbiQeUFrhxZ80rvcge/e3dFP/das9Oq1XfuLlu0xOx
	MuMLT441lvzebOm4dIV7w8xvTqLhElsuecquDvh0rnn93IcuZ3QXpgcqfOxMTI0R4t/+trv6
	z9o53Ox5vY9jnZcyHd7DW7eWi6PlWQkwX7IUZyQaajEXFScCAGdF3KayAwAA
X-CMS-MailID: 20240805120430eucas1p18d8da6f42c1d56ea9d1a066a90a87df1
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

Kindly ping.

Following my previous question, I'm trying to elaborate more:

Could you please clarify why these specific filesystem mount options should=
 not
be applied to scratch devices? If this is a regression, could it be due to
the application of $EXT_MOUNT_OPTIONS? And maybe a configuration issue?

The purpose of this change was to provide the common mount options for scra=
tch
devices, so that I can inherit the required options for tmpfs (e.g., '-o si=
ze=3D1G
$TMPFS_MOUNT_OPTIONS').

Here is my current configuration, but it seems I'm missing something, as I'=
m
expecting the scratch (and test) mounts to inherit $TMPFS_MOUNT_OPTIONS whe=
n
running ./check -s <config>.

mkdir -p /media/scratch
mkdir -p /media/test
export FSTYP=3Dtmpfs
export SCRATCH_DEV=3D/media/scratch
export SCRATCH_MNT=3D/media/scratch
export TEST_DEV=3D/media/test
export TEST_DIR=3D/media/test
export RECREATE_TEST_DEV=3Dtrue

# Test with default mount options
[tmpfs_default]

[tmpfs_noswap_huge_never]
TMPFS_MOUNT_OPTIONS=3D"-o noswap,huge=3Dnever"

[tmpfs_noswap_huge_always]
TMPFS_MOUNT_OPTIONS=3D"-o noswap,huge=3Dalways"

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

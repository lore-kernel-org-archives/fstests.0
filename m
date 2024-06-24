Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FB51E511
	for <fstests@vger.kernel.org>; Mon, 24 Jun 2024 14:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719237760; cv=none; b=jxL1FakVAGMf1HUe+uPtYMUBms6l/cN+qJru/kkQXEO4Ws4fnpmpoQ4CpKpG6f2xm0xEU7SwyG9QSurLR3rGqPhGSRvNbTOUrCo8elZmFyiAScPPCdzfoxNVqBLdX3yBak5YHZHe38ZIicdfaXHd3GQeQFVBxsJrahpypeZa+cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719237760; c=relaxed/simple;
	bh=/hV2Wo7A5u7ZAOVKMzDsypZYPRuuv/13xEX57DoPGBE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=aP+EakSMLuqULDj9O3PC2Ab9IWOtNCIZYmh1gFlAfjuhISpMzWFPrOJZdeVDikBuy+3dKwYDA7zxhSm79ZEJef/N90D4adpzfQQunjq1DIAHKK8wkJumJoncn5DWdLFzwYnJMfx8zQIXHtD9atMdeUE3f9WNKo6rHXivNuDjEqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=upMYB6c4; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="upMYB6c4"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240624140235euoutp01dbbe0901440854b0f36b4cef5f5f61fd~b9aFAqw_q1285412854euoutp01g
	for <fstests@vger.kernel.org>; Mon, 24 Jun 2024 14:02:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240624140235euoutp01dbbe0901440854b0f36b4cef5f5f61fd~b9aFAqw_q1285412854euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719237755;
	bh=feviSioNGQ3880VRgo18SvrNdmvlfrp0XZy37LoEgfI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=upMYB6c4XxWxppP13ogtUKMMlntFnI9LNHWtllTNJlTe9OlHY4nBsodJZyCXgORbE
	 dpVCCjB1TYR+vtPV8wgZBHDVNaMk7ZtRs/P5FBr0sjY2WvSgVDtrUS5zjjSWp5yw/C
	 cwnC9Y8MfHGNf2DSiLhnTpKyzDsJPd4RZL9bo520=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240624140235eucas1p16dda4a96ad7e710035d28901f72f0ca2~b9aExtO6o1118311183eucas1p1s;
	Mon, 24 Jun 2024 14:02:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 09.CE.09624.B7C79766; Mon, 24
	Jun 2024 15:02:35 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240624140235eucas1p21b508580227a466ad436d168a13ce8bf~b9aEfIQaG2019920199eucas1p2m;
	Mon, 24 Jun 2024 14:02:35 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240624140235eusmtrp12bdf42d5a9a407853156d2da46a4b8d7~b9aEeaVvC1522215222eusmtrp1Z;
	Mon, 24 Jun 2024 14:02:35 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-09-66797c7bbfd9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 4D.A6.09010.A7C79766; Mon, 24
	Jun 2024 15:02:34 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240624140234eusmtip1eb431227d13b739b8b72ac24a8800f1e~b9aEPJm0j0387803878eusmtip1h;
	Mon, 24 Jun 2024 14:02:34 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Mon, 24 Jun 2024 15:02:34 +0100
Received: from CAMSVWEXC01.scsc.local ([::1]) by CAMSVWEXC01.scsc.local
	([fe80::7d73:5123:34e0:4f73%13]) with mapi id 15.00.1497.012; Mon, 24 Jun
	2024 15:02:34 +0100
From: Daniel Gomez <da.gomez@samsung.com>
To: "Darrick J. Wong" <djwong@kernel.org>
CC: "fstests@vger.kernel.org" <fstests@vger.kernel.org>, Pankaj Raghav
	<p.raghav@samsung.com>, "mcgrof@kernel.org" <mcgrof@kernel.org>,
	"hughd@google.com" <hughd@google.com>
Subject: Re: [PATCH 5/5] common/rc: print scratch and test mount options
Thread-Topic: [PATCH 5/5] common/rc: print scratch and test mount options
Thread-Index: AQHaviKGDA6KUdYWlUyy/G+RuOXD4LHHWaWAgA+XnQA=
Date: Mon, 24 Jun 2024 14:02:33 +0000
Message-ID: <xxx2zqe7wyw7negkjjhgrhnykdw247jguaaykjdm2j2rpfwkcv@26mxj7pbpkae>
In-Reply-To: <20240614155555.GE6110@frogsfrogsfrogs>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5E19A778B90E9545AE239EC3FE9DA43C@scsc.local>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsWy7djPc7rVNZVpBr+fiVpcfsJncbplL7vF
	0099LBY3JjxldGDxWLCp1GPTqk42j8+b5AKYo7hsUlJzMstSi/TtErgy1jxbwFYwX6Zi8lO1
	Bsa3ol2MnBwSAiYSR5qeMncxcnEICaxglDg/cy4jhPOFUWLX3lmMIFVCAp8ZJWYeNILpmHVy
	MlTHckaJGzd62CEcoKIl86cwQThnGCU2foHJrGSU6F69lhmkn01AU2LfyU3sILYIkH3k2zWw
	DmaBjYwSl+a9YwNJCAt4SEx7c5IRoshTYnnLNlYI20pix/aDYHEWAVWJxZ23mUBsXgFfifWX
	joIN5QQ6sH3CbjCbUUBW4tHKX2A2s4C4xK0n85kgnhCUWDR7DzOELSbxb9dDNghbR+Ls9SeM
	ELaBxNal+1ggbGWJR3PPM0PM0ZFYsPsTG4RtKTFhySyo+doSyxa+Zoa4R1Di5MwnLCCPSQgs
	55T433cWaqiLxMQ9/VC2sMSr41vYJzDqzEJy3ywkO2Yh2TELyY5ZSHYsYGRdxSieWlqcm55a
	bJiXWq5XnJhbXJqXrpecn7uJEZhuTv87/mkH49xXH/UOMTJxMB5ilOBgVhLhnV5flibEm5JY
	WZValB9fVJqTWnyIUZqDRUmcVzVFPlVIID2xJDU7NbUgtQgmy8TBKdXA5Gww46JE0RE7l0Xy
	jZcnNrJ/2eScJb5yFa/N7AduJfybvi3r+n7lyOLnN5TetPz00k6zLvMIrcgLq/7xijutmOvV
	zg8XGFjljOcdD2SZG7iZwa37/Pm1u7drG770iu90f9FUzeBlpqck/v3/j/bLnFu3hR3Jure0
	gvV5hrf+rWuPvWYfYVEodA65a5JeuT/Dgfu57PEpV6at1GzIWm6UGHVtu7FtO7+StG1YR8eR
	c+8uWVin3nZQ481w8W6WiC543i7Ets/GxYkvkTv7zlaN/JtrLb+IL8//9qXK3vUb853q9ZPP
	WJtf21j7OWt19MJPvwUXWk5Pir9ze5LVn5+6U5+7XpIt/qzWwm9pI/dJiaU4I9FQi7moOBEA
	G8NgHKYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsVy+t/xu7pVNZVpBp9vWltcfsJncbplL7vF
	0099LBY3JjxldGDxWLCp1GPTqk42j8+b5AKYo/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws
	9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQy1jxbwFYwX6Zi8lO1Bsa3ol2MnBwSAiYSs05OZu5i
	5OIQEljKKPF972JGiISMxMYvV1khbGGJP9e62CCKPjJKTJj1iRHCOcMocenyBBYIZyWjxNX/
	b8Ba2AQ0Jfad3MQOYosA2Ue+XWMCKWIW2AjUMe8dG0hCWMBDYtqbk4wQRZ4Sy1u2sULYVhI7
	th8Ei7MIqEos7rzNBGLzCvhKrL90lB1i21NGid2rT7GAJDiBvmifsBtsG6OArMSjlb/AbGYB
	cYlbT+YzQTwhILFkz3lmCFtU4uXjf1DP6Uicvf4E6mkDia1L97FA2MoSj+ZC1DMD1SzY/YkN
	wraUmLBkFtR8bYllC18zQxwnKHFy5hOWCYwys5CsnoWkfRaS9llI2mchaV/AyLqKUSS1tDg3
	PbfYSK84Mbe4NC9dLzk/dxMjMJlsO/Zzyw7Gla8+6h1iZOJgPMQowcGsJMI7vb4sTYg3JbGy
	KrUoP76oNCe1+BCjKTDwJjJLiSbnA9NZXkm8oZmBqaGJmaWBqaWZsZI4r2dBR6KQQHpiSWp2
	ampBahFMHxMHp1QDk+ndpbcWGhgc4M2JcN8gcURn9otXG/N2W794O28GQ7z/qh7hNYpBgjrl
	76Q5z7Wo/7V06jGase3Uv+I99rfCA/gSnnU52Aluung5flHGrdNs987yPbqm5Dhn48V66Us/
	Fx04r3upueSn4P9lNbqP1ocUrn71ylnr0a/DPa6cDtv/lJ2IT+5U1Tjb7d/M1XHJwEIr8dm2
	+eIWKjd2/ni91UnXwf6sP+/JcoOQkwGH/T8UxN1mjbdpPvTkzX3nrOK7y42V5otqJX2eef/y
	izLjb/kFHAL8dwUzLFVZua/5c902kX63mGOOWMz+B/9zbsed11mw1/5SHYPgRv/C7iYLwXoV
	OeaikkllHh8fmIn+UmIpzkg01GIuKk4EAJkuaemvAwAA
X-CMS-MailID: 20240624140235eucas1p21b508580227a466ad436d168a13ce8bf
X-Msg-Generator: CA
X-RootMTR: 20240614061728eucas1p2d7488fbbd2887c5d60d2bd1e3fd48580
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240614061728eucas1p2d7488fbbd2887c5d60d2bd1e3fd48580
References: <20240614061722.1080-1-da.gomez@samsung.com>
	<CGME20240614061728eucas1p2d7488fbbd2887c5d60d2bd1e3fd48580@eucas1p2.samsung.com>
	<20240614061722.1080-6-da.gomez@samsung.com>
	<20240614155555.GE6110@frogsfrogsfrogs>

On Fri, Jun 14, 2024 at 08:55:55AM GMT, Darrick J. Wong wrote:
> On Fri, Jun 14, 2024 at 06:17:26AM +0000, Daniel Gomez wrote:
> > Mount options for a SCRATCH device might not be the same in the TEST
> > device if RECREATE_TEST_DEV is not enabled. So, print mount options for
> > each device to clarify this.
> >=20
> > Add mount and mkfs info for TEST devices so we get the same information
> > being printed for both devices.
> >=20
> > Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> > ---
> >  check     |  4 ++++
> >  common/rc | 20 ++++++++++++++++++--
> >  2 files changed, 22 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/check b/check
> > index 723a52e30..e02d28b39 100755
> > --- a/check
> > +++ b/check
> > @@ -807,7 +807,11 @@ function run_section()
> >  	# print out our test configuration
> >  	echo "FSTYP         -- `_full_fstyp_details`"
> >  	echo "PLATFORM      -- `_full_platform_details`"
> > +	echo "TEST device:"
> > +	echo "MKFS_OPTIONS  -- `_test_mkfs_options`"
> > +	echo "MOUNT_OPTIONS -- `_test_mount_options`"
> >  	if [ ! -z "$SCRATCH_DEV" ]; then
> > +	  echo "SCRATCH device:"
> >  	  echo "MKFS_OPTIONS  -- `_scratch_mkfs_options`"
> >  	  echo "MOUNT_OPTIONS -- `_scratch_mount_options`"
>=20
> Now there are two lines that start with "MKFS_OPTIONS"; will this break
> anyone's parsing scripts?  Or should these be prefixed:
>=20
> echo "TEST_MKFS_OPTIONS -- `_test_mkfs_options`"
> ...
> echo "SCRATCH_MKFS_OPTIONS -- `_scratch_mkfs_options`"
>=20
> ?

This looks like my initial version, but I prefer the 'sub-menu style' becau=
se
we did not have these variables before. However, I think it makes sense to
introduce them so we can differentiate between them.=20

I guess introducing this change would break anyone's parsing scripts regard=
less?
However, I do think is necessary to specify the mount differences.

>=20
> Also should these four variables be captured explicitly by the reports
> that are generated by common/report ?

I guess the report only includes the scratch mount options. I will update i=
t to
include the new specific test and scratch mount/mkfs options.

>=20
> --D
>=20
> >  	fi
> > diff --git a/common/rc b/common/rc
> > index a42792c37..b351a82eb 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -235,6 +235,17 @@ _scratch_mount_options()
> >  					$SCRATCH_DEV $SCRATCH_MNT
> >  }
> > =20
> > +_test_mount_options()
> > +{
> > +	_test_options mount
> > +
> > +	if $RECREATE_TEST_DEV || [ "$OLD_FSTYP" !=3D "$FSTYP" ]; then
> > +		echo $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $TMPFS=
_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
> > +	else
> > +		echo $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $* $TE=
ST_DEV $TEST_DIR
> > +	fi
> > +}
> > +
> >  _supports_filetype()
> >  {
> >  	local dir=3D$1
> > @@ -456,8 +467,7 @@ _test_mount()
> >          return $?
> >      fi
> > =20
> > -    _test_options mount
> > -    _mount -t $FSTYP$FUSE_SUBTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SE=
LINUX_MOUNT_OPTIONS $TMPFS_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
> > +    _mount -t $FSTYP$FUSE_SUBTYP `_test_mount_options $*`
> >      mount_ret=3D$?
> >      [ $mount_ret -ne 0 ] && return $mount_ret
> >      _idmapped_mount $TEST_DEV $TEST_DIR
> > @@ -571,6 +581,12 @@ _metadump_dev() {
> >  	esac
> >  }
> > =20
> > +_test_mkfs_options()
> > +{
> > +	_test_options mkfs
> > +	echo $TEST_OPTIONS $MKFS_OPTIONS $* $TEST_DEV
> > +}
> > +
> >  _test_mkfs()
> >  {
> >      case $FSTYP in
> > --=20
> > 2.43.0
> > =

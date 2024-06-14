Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8272C143741
	for <fstests@vger.kernel.org>; Fri, 14 Jun 2024 06:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718345858; cv=none; b=cvxDFW6U1DIJJyhLu/AAfI1x4p7MGpmjFt6e3LaF8J4KoYmpl6U2Z3Nb2dYlYtwK9eVQRq2MlVu12C4buU03+BBgLQdBJpTs8Fs43XXLATo753a6Qp5Zan+SWiBURJmwF3tepxDl4mbAq05/NRGDA7t+3N6RcsuJDpBNkbJlFLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718345858; c=relaxed/simple;
	bh=jya+gA1rQLF/gqQwdGzF+SvRaSTrIBlFvevrrRHR96g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=btI0XI9WPQCBwWv837GHAZbCDR75ddCfbn55fblzYhaFgC5JeTDoJeLv7cwx7mYhx4ZLiZ1W+6+S8ONTXZL8TQcsImIEBAMSbv8BUX24wCALYBOVDUmf90mFc6ERZJE1KuTPPHx3KWdhclbhft7eMTMAN17kQn1AOweJNXUnGyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=lsmyT9xV; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lsmyT9xV"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240614061727euoutp02ed5d926f49d88ef521b2eb24294d129d~YynGjZLIZ0372003720euoutp02O
	for <fstests@vger.kernel.org>; Fri, 14 Jun 2024 06:17:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240614061727euoutp02ed5d926f49d88ef521b2eb24294d129d~YynGjZLIZ0372003720euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718345847;
	bh=M7YxrhyGjN7gsaXxz4E3/I2qDVCePB1Ps03ONrmG6MQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=lsmyT9xVW8A2VN0GNTW8J/Aobaidwto1N9X3stwoH/5HheuOJ9aNWH9eHWVagT8jC
	 Bsn07UZRjdmQphE2vZWomve5VjP1MdQzAVDOqKl6Sugx+4U2ZiJXWf9YCe9IpxwvN6
	 fZKMRfHhwBg4GWZ9SAsGnkIYeIWQbrI1eFpiQYNw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240614061727eucas1p1385e02fd2a649c66fdde87843f4972a7~YynGV334k0342203422eucas1p1N;
	Fri, 14 Jun 2024 06:17:27 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id EC.B9.09624.670EB666; Fri, 14
	Jun 2024 07:17:26 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240614061726eucas1p1adfe39fea57e14eeab2fe58a08392fd4~YynFxTEOS1173811738eucas1p12;
	Fri, 14 Jun 2024 06:17:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240614061726eusmtrp1a791f5640dc46c4766e474288d37d2f4~YynFwng301586915869eusmtrp1k;
	Fri, 14 Jun 2024 06:17:26 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-51-666be0761597
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 7C.C5.09010.670EB666; Fri, 14
	Jun 2024 07:17:26 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240614061726eusmtip15c6e89132e906d57e5400ed4c5cade6d~YynFmRbo91662616626eusmtip1b;
	Fri, 14 Jun 2024 06:17:26 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Fri, 14 Jun 2024 07:17:25 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
	([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Fri, 14 Jun
	2024 07:17:25 +0100
From: Daniel Gomez <da.gomez@samsung.com>
To: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
CC: Pankaj Raghav <p.raghav@samsung.com>, "mcgrof@kernel.org"
	<mcgrof@kernel.org>, "hughd@google.com" <hughd@google.com>
Subject: [PATCH 1/5] generic/449: not run on tmpfs earlier
Thread-Topic: [PATCH 1/5] generic/449: not run on tmpfs earlier
Thread-Index: AQHaviKFjjC3cvEcmEaWr+YftWr41g==
Date: Fri, 14 Jun 2024 06:17:24 +0000
Message-ID: <20240614061722.1080-2-da.gomez@samsung.com>
In-Reply-To: <20240614061722.1080-1-da.gomez@samsung.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRmVeSWpSXmKPExsWy7djP87plD7LTDDZOsbA43bKX3eLppz4W
	ixsTnjI6MHss2FTqsWlVJ5vH501yAcxRXDYpqTmZZalF+nYJXBl3jpcU/GGrePt2PlMD4x3W
	LkZODgkBE4neN12MILaQwApGia2XlCHsL4wSO5+ldTFyAdmfGSVWnbjC1sXIAdaw4oUeRHw5
	o8Tn5s+scEU3ut6xQThnGCX2Hr8A5axklDjwZALYDjYBTYl9Jzexg9giAuYSszsms4HYzAJV
	Eufat7KCrBAWsJJ4uDYFxBQRsJe4NpcPolpP4tLce2BTWARUJXZcnAn2Aa+AhcTzlqNgEzkF
	LCXW7WoDizMKyEo8WvmLHWK6uMStJ/OZID4WlFg0ew8zhC0m8W/XQzYIW0fi7PUnjBC2gcTW
	pftYIGxFiY5jN6Gu1JO4MXUKlK0tsWzha2aIGwQlTs58wgLyroTAZE6J5d+fQA11kTiyphNq
	sbDEq+Nb2CFsGYnTk3tYJjBqz0Jy3ywkO2Yh2TELyY4FjCyrGMVTS4tz01OLDfNSy/WKE3OL
	S/PS9ZLzczcxApPI6X/HP+1gnPvqo94hRiYOxkOMEhzMSiK8sxZmpQnxpiRWVqUW5ccXleak
	Fh9ilOZgURLnVU2RTxUSSE8sSc1OTS1ILYLJMnFwSjUwaTwxWV+ufUNSJuSV7e03z2Z9DnRY
	4qj1lS2Ee6sXy+TFNwymyDEtU7radTdKomdOjdV9q8UGW1i+GAk73JnZL/+zdHLY9/elms8v
	Ha7KrJnZsdDj7I9GH9dforLnIs7P/hRpJWmz/OI8lhoj1ZVXV0o2nv0Tflhbje/75axKnmfZ
	e9fkfavd/kDZs1qMxW/xARfnhRoP+6WvFT3nV7/v8qKF79De1psfe48vaxb5fncJu9n1N38t
	yvgnlfvZf9u7d66lrpDNwcDcT+dO7hfQ1nEyuD/zxUc2Z17xFZHqXQU1nrM6Hq8WyYlS/fTr
	n3fAM9cymWkKF85O+zgrcPFkJ86iq9vuOD8qvxhwTOTFfSWW4oxEQy3mouJEADAREP+RAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsVy+t/xu7plD7LTDPbeFrE43bKX3eLppz4W
	ixsTnjI6MHss2FTqsWlVJ5vH501yAcxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbm
	sVZGpkr6djYpqTmZZalF+nYJehl3jpcU/GGrePt2PlMD4x3WLkYODgkBE4kVL/S6GLk4hASW
	MkosvLmMuYuREyguI7Hxy1VWCFtY4s+1LjaIoo+MEtt+3GeGcM4wSvxYupYJwlnJKPFszil2
	kBY2AU2JfSc3gdkiAuYSszsms4HYzAJVEufat4KtFhawkni4NgXEFBGwl7g2lw+iWk/i0tx7
	jCA2i4CqxI6LM8GO4BWwkHjecpQdpFwIyD62Tw8kzClgKbFuVxtYCaOArMSjlb/YIRaJS9x6
	Mp8J4n4BiSV7zkP9JSrx8vE/qL90JM5ef8IIYRtIbF26jwXCVpToOHYT6mA9iRtTp0DZ2hLL
	Fr5mhjhHUOLkzCcsExilZyFZNwtJyywkLbOQtCxgZFnFKJJaWpybnltspFecmFtcmpeul5yf
	u4kRmAi2Hfu5ZQfjylcf9Q4xMnEwHmKU4GBWEuGdtTArTYg3JbGyKrUoP76oNCe1+BCjKTCI
	JjJLiSbnA1NRXkm8oZmBqaGJmaWBqaWZsZI4r2dBR6KQQHpiSWp2ampBahFMHxMHp1QD01qR
	GTsaQp99S7t+U0tpDaP53FI5U9fa1u7P0acObpizw8VL8pRbvtDc+sLVuVx7Nu8y+yhrLLvL
	fl/BifkVP5k3TmcI3n5sxcZZLF7zHnfEWm+JSPlfd8dIqrG/aOrfE1W6twrXzLjXyMJ6cFNp
	WO67C/ZJVSovnm38WaMW5OBfx536aWXbP4PdMmwnu8N8Q7XFpWsLLWdFcez7/754RuuWu+m5
	YZteP27/G3abKf+/34X1PUndb90vBrteY+vq5BJi4ei3E1rscO/5wq3WP3u+PVDumjq5ny9c
	dGs/R5Kej/GBkqnehtKxvLb+i1o3Gwk+8Pjuz7176YmyZIlft1NNXjLPk27v193popehxFKc
	kWioxVxUnAgAW9zIG40DAAA=
X-CMS-MailID: 20240614061726eucas1p1adfe39fea57e14eeab2fe58a08392fd4
X-Msg-Generator: CA
X-RootMTR: 20240614061726eucas1p1adfe39fea57e14eeab2fe58a08392fd4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240614061726eucas1p1adfe39fea57e14eeab2fe58a08392fd4
References: <20240614061722.1080-1-da.gomez@samsung.com>
	<CGME20240614061726eucas1p1adfe39fea57e14eeab2fe58a08392fd4@eucas1p1.samsung.com>

From: Hugh Dickins <hughd@google.com>

Do not waste 14 minutes to discover that tmpfs succeeds in
setting acls despite running out of space for user attrs.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 tests/generic/449 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/generic/449 b/tests/generic/449
index 2b77a6a49..ffbad12e9 100755
--- a/tests/generic/449
+++ b/tests/generic/449
@@ -23,6 +23,12 @@ _require_scratch
 _require_test
 _require_acls
 _require_attrs trusted
+_require_block_device $SCRATCH_DEV # hack to exclude tmpfs for now
+
+if [ "$FSTYP" =3D "tmpfs" ]; then
+	# Do not waste 14 minutes to discover this:
+	_notrun "$FSTYP succeeds in setting acls despite running out of space for=
 user attrs"
+fi
=20
 _scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1
 _scratch_mount || _fail "mount failed"
--=20
2.43.0

Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2DC145A05
	for <fstests@vger.kernel.org>; Fri, 14 Jun 2024 06:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718346288; cv=none; b=moma/Dw5nq/Mtt+YDxxGKERmYpdBwRWzQzP13q5I54FgeZhMuSXqrTfjQ3k92kB4UdoHCfa04CFVH3cu1lhdChyJYIWGpSKfdn+DUb4rY0+gayBB2HsDj9PS3PcD2UX1sBnK+ggolia4Ry+zkZ7HpqLXrcbgRsI0Xq8YUMO0ea0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718346288; c=relaxed/simple;
	bh=JpFvTYQ4M+asjczDCV1H93cO3wrO8xDwO7YugmYj8z8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=TOy9snmjjvGPZKag7OURq1NcxMQ2BUH5sajC7tjrH+wFbI5yO4EdE6e9fbIOnSVpOkk8xv+U5xi0ZgVmz8Egv727JOSP/TKJkl8QJrytaFxWc5aVrba7N2M/YwIJ8Z1uE143G0ss+ex0IdYtJK6zBd0Qg7d4MJjBk15Fkbd5/vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Gc36PTS4; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Gc36PTS4"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240614061728euoutp0134f566ad658d999a2ce34868a8540e95~YynHY4-5V1698916989euoutp01X
	for <fstests@vger.kernel.org>; Fri, 14 Jun 2024 06:17:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240614061728euoutp0134f566ad658d999a2ce34868a8540e95~YynHY4-5V1698916989euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718345848;
	bh=iHR6kQ59OJ5JZ1znGwcVhKjeCdAbt+XVF+cBGhUHroM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=Gc36PTS4UcjyrpBzenBgX/wiEzWF0GcSiCWsHmP1WIlRGSGQ1l7fUYdlG/O9k/wop
	 c9/LKKdH8HQJD+auYhnq9K8RhLKwbQ9KYNUCEPyopi3pXQsboAoK5mdQ1Iwb3p0k+o
	 fZ27qdHrDU24jop5Sy69IqN3YhNMbWJ5fsmnc4sg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240614061728eucas1p1dc0704de091339ab8714981cb13499ea~YynHSmyK00342203422eucas1p1Q;
	Fri, 14 Jun 2024 06:17:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id D3.74.09620.770EB666; Fri, 14
	Jun 2024 07:17:27 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240614061727eucas1p20922542ef700d0f41dc9cc9628392518~YynGil23r0512605126eucas1p2i;
	Fri, 14 Jun 2024 06:17:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240614061727eusmtrp2b102049d7e17d97d2d00f7bef2a54845~YynGh2O2E1975119751eusmtrp2W;
	Fri, 14 Jun 2024 06:17:27 +0000 (GMT)
X-AuditID: cbfec7f5-d31ff70000002594-40-666be077fe34
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id C5.B7.08810.770EB666; Fri, 14
	Jun 2024 07:17:27 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240614061727eusmtip2095c20ae24434f748690dfe155767793~YynGWihb23255232552eusmtip2k;
	Fri, 14 Jun 2024 06:17:27 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Fri, 14 Jun 2024 07:17:26 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
	([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Fri, 14 Jun
	2024 07:17:26 +0100
From: Daniel Gomez <da.gomez@samsung.com>
To: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
CC: Pankaj Raghav <p.raghav@samsung.com>, "mcgrof@kernel.org"
	<mcgrof@kernel.org>, "hughd@google.com" <hughd@google.com>, Daniel Gomez
	<da.gomez@samsung.com>
Subject: [PATCH 3/5] common/rc: add recreation support for tmpfs
Thread-Topic: [PATCH 3/5] common/rc: add recreation support for tmpfs
Thread-Index: AQHaviKG3vJmF77yrkuJpj7O4MHjRA==
Date: Fri, 14 Jun 2024 06:17:25 +0000
Message-ID: <20240614061722.1080-4-da.gomez@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42LZduzned3yB9lpBnvm21icbtnLbvH0Ux+L
	xY0JTxkdmD0WbCr12LSqk83j8ya5AOYoLpuU1JzMstQifbsErozOf+kFOzkqfuw7ydLAeIut
	i5GTQ0LAROL2029MXYxcHEICKxgljj1pYoVwvjBKbO64BpX5zCgx4+4r5i5GDrCWy/MFQLqF
	BJYzSjx6HQBX82vXeUYI5wyjxI7ua1DOSkaJPe+XMoG0sAloSuw7uYkdxBYRMJeY3TGZDaSI
	WWAho8S3hc9YQRLCAg4SD+buZ4YocpVon3SfFcLWk5jQ3csGcgaLgKrEqlkZIGFeAQuJR7P3
	gc3kFLCUWLerDaycUUBW4tHKX2BxZgFxiVtP5jNBPC0osWj2HmYIW0zi366H0MDQkTh7/Qkj
	hG0gsXXpPhYIW1Gi49hNNog5ehI3pk6BsrUlli18zQxxg6DEyZlPoOqnc0o82lAHYbtI3Nl4
	hh3CFpZ4dXwLlC0j8X/nfKYJjNqzkJw3C8mKWUhWzEKyYgEjyypG8dTS4tz01GLjvNRyveLE
	3OLSvHS95PzcTYzARHL63/GvOxhXvPqod4iRiYPxEKMEB7OSCO+shVlpQrwpiZVVqUX58UWl
	OanFhxilOViUxHlVU+RThQTSE0tSs1NTC1KLYLJMHJxSDUyBf+Zt07pjkmDvqmf2Il92lVNW
	db46B9861c/ZglO5zd4GXOi0/SSxfOKv2wbev51jpO9tODgxyGJDZoFNsPuuDrWnBp+Vjsie
	9Zp8LHJhdPQDlctFWifSBZiMrP7fCXSp+c0hWSMqs1RHcZJ0gbpB3E71Oz//GbN9uRNlt84u
	OunRlLelvvoBmTd11rYGJ75a5lV/4lJ8ks6XstCD+R9fmp1fu9jnq35O7tPs27di/FfIKKqz
	fj/e73Re4q1+9pl7vK53hc/YSBSde5s993bnt+f7GtvWVyknJPU79XZ/lPTVDZP5ZGKeu6v7
	UtIG/r86/t67Uoxu2q49GnJrjvTnzGcm2sy3kjoPHixQU2Ipzkg01GIuKk4EAIhNwraTAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsVy+t/xe7rlD7LTDJ5c57A43bKX3eLppz4W
	ixsTnjI6MHss2FTqsWlVJ5vH501yAcxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbm
	sVZGpkr6djYpqTmZZalF+nYJehmd/9ILdnJU/Nh3kqWB8RZbFyMHh4SAicTl+QJdjFwcQgJL
	GSWWdjUydzFyAsVlJDZ+ucoKYQtL/LnWxQZR9JFR4viB5SwQzhlGibNrZ7CAVAkJrGSUuDsn
	EsRmE9CU2HdyEzuILSJgLjG7YzJYN7PAQkaJbwufgY0VFnCQeDB3PzNEkatE+6T7rBC2nsSE
	7l6w81gEVCVWzcoACfMKWEg8mr2PHSQsBGQf26cHEuYUsJRYt6sNrJNRQFbi0cpfYGuZBcQl
	bj2ZzwTxgIDEkj3noR4TlXj5+B/UYzoSZ68/YYSwDSS2Lt3HAmErSnQcu8kGMUdP4sbUKVC2
	tsSyha+ZIc4RlDg58wnLBEbpWUjWzULSMgtJyywkLQsYWVYxiqSWFuem5xYb6hUn5haX5qXr
	JefnbmIEpoJtx35u3sE479VHvUOMTByMhxglOJiVRHhnLcxKE+JNSaysSi3Kjy8qzUktPsRo
	CgyhicxSosn5wGSUVxJvaGZgamhiZmlgamlmrCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXA
	pK4StLWuUC7S5F0z37N1YuUfJ+7Z0hHDfP/fv43/Vt7/z+G5sFft4LNQdUPdrVM7HFazrg+R
	fqrg4mdSlVHdUySyzNlP492b250H9tbwfJtzXDf9xr3/D97dWVz/YE/fh4B8puNBPA8UZnz5
	3fBQUS341qG7kU2P/lhynv7JwZJxS7eZ3z3ocYtz0MGulpXq1ne+fF/Sav1y9ZJjVdsU/OQU
	fzRl+2UbaknO1bXrCXoc5lSt4c6w8qud+CefQ6L+kRwyq2OD44znWq6/eMgmicVr+4S9M9/X
	1qkFr/qcajfd+IxYy9ztvKtZxWsr/mjn9DbUah9afOdywIltK0XbRFQkJi/9+fod26svhR6O
	SizFGYmGWsxFxYkA2Sejgo4DAAA=
X-CMS-MailID: 20240614061727eucas1p20922542ef700d0f41dc9cc9628392518
X-Msg-Generator: CA
X-RootMTR: 20240614061727eucas1p20922542ef700d0f41dc9cc9628392518
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240614061727eucas1p20922542ef700d0f41dc9cc9628392518
References: <20240614061722.1080-1-da.gomez@samsung.com>
	<CGME20240614061727eucas1p20922542ef700d0f41dc9cc9628392518@eucas1p2.samsung.com>

Add support for test device recreation (RECREATE_TEST_DEV=3Dtrue) for
tmpfs. This allows to inherit the tmpfs profile extra mount options
(TMPFS_MOUNT_OPTIONS) for the test device.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 common/rc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 163041fea..7f995b0fa 100644
--- a/common/rc
+++ b/common/rc
@@ -457,7 +457,7 @@ _test_mount()
     fi
=20
     _test_options mount
-    _mount -t $FSTYP$FUSE_SUBTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINU=
X_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
+    _mount -t $FSTYP$FUSE_SUBTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINU=
X_MOUNT_OPTIONS $TMPFS_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
     mount_ret=3D$?
     [ $mount_ret -ne 0 ] && return $mount_ret
     _idmapped_mount $TEST_DEV $TEST_DIR
@@ -604,6 +604,9 @@ _test_mkfs()
     pvfs2)
 	# do nothing for pvfs2
 	;;
+	tmpfs)
+	# do nothing for tmpfs
+	;;
     udf)
         $MKFS_UDF_PROG $MKFS_OPTIONS $* $TEST_DEV > /dev/null
 	;;
--=20
2.43.0

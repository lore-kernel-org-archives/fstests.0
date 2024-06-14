Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EECD3EA7B
	for <fstests@vger.kernel.org>; Fri, 14 Jun 2024 06:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718345857; cv=none; b=prdhHLpHMc/kt3yDZAUYn78BJ90/oL+9mMK8mksL7fbXPRo7dn+wnhEMe0Z+g4GaFt1yp+HXeKGb7KGwmN6uNQh5IXST0FWmVYK1tbdyBSQSnVN02MRAGxZNotSLaHw1oJj+DM7fA4G195IMfJbH0dYg/P7ftT6ZuOofdxfejE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718345857; c=relaxed/simple;
	bh=VaYqxus4qenVQf8KtNY8nvqclpqZurah5H/tEVxzrs8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=s1JotjciGk37KVnfs75wq9rPI2h9OvRthzdqupmL9T90IM5dXNeRbMI3fK/Bxc4/zNKk5MgNKRp/bGQo6QR4SpEs5xTHvlFSx0O0xwn6XcnSp1TbdT3AGLjk6it7DtmD79Sbn7CdBtRfDCaqdGFheZ+7jEo/S2l+8geFwye3lII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=CbwKQDMC; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CbwKQDMC"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240614061728euoutp02a5a79f6c779e0975a799d239d8efcb8e~YynHjLlvd0937309373euoutp02C
	for <fstests@vger.kernel.org>; Fri, 14 Jun 2024 06:17:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240614061728euoutp02a5a79f6c779e0975a799d239d8efcb8e~YynHjLlvd0937309373euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718345848;
	bh=8NCSmTrJSc/f5hHik1YO9vtEi1Khb42+C4ewEPTSeUA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=CbwKQDMC1hnAFRNkDP89ZFPYNoO2DCb6hFtRuo7v8fgqHauFX9azT/6FamYXTFvdx
	 OujhnVXSY/ySezHSk898ncmLujLKhEpaDR38uu2+3dXYjUXs08RQPYxIardDkHoMWH
	 6QMffa5kKUc65oRvkXGbIATbKVf7o0CsznTUcGo4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240614061728eucas1p181ce12fbc0ec7e69b17adf6b8c58714e~YynHbZ12V1171511715eucas1p11;
	Fri, 14 Jun 2024 06:17:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 8E.E9.09875.870EB666; Fri, 14
	Jun 2024 07:17:28 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240614061727eucas1p19ba98d45511f9226f1c5cf1752b419b5~YynG5Dpjg0342203422eucas1p1P;
	Fri, 14 Jun 2024 06:17:27 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240614061727eusmtrp1386a63311e93d6893779b3233180ee20~YynG4Qei21655316553eusmtrp1V;
	Fri, 14 Jun 2024 06:17:27 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-6d-666be0789753
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id AD.C5.09010.770EB666; Fri, 14
	Jun 2024 07:17:27 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240614061727eusmtip114710655ae39f6f57c388534907ba608~YynGv_NMG2137921379eusmtip1Y;
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
Subject: [PATCH 4/5] common/rc: fix scratch mount options for tmpfs
Thread-Topic: [PATCH 4/5] common/rc: fix scratch mount options for tmpfs
Thread-Index: AQHaviKG7LBDn2pSnkKBi8GAx++1Pw==
Date: Fri, 14 Jun 2024 06:17:25 +0000
Message-ID: <20240614061722.1080-5-da.gomez@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42LZduznOd2KB9lpBi++cFicbtnLbvH0Ux+L
	xY0JTxkdmD0WbCr12LSqk83j8ya5AOYoLpuU1JzMstQifbsErox1MyYxF7SxVny5cIy5gXEu
	SxcjB4eEgInExancXYxcHEICKxgl3uw8xw7hfGGU2L/3EAuE85lR4siUaWxdjJxgHW9O/IGq
	Ws4ocb5lNjtc1fUd56BazjBK7Oi+xgjhrGSU2PN+KRNIP5uApsS+k5vYQWwRAXOJ2R2T2UCK
	mAUWMkp8W/iMFSQhLOAs0byziQmiyEPiT+MXqAY9ifcbZzGCnM4ioCqxalYGSJhXwEJi26IG
	RhCbU8BSYt2uNrAxjAKyEo9W/gJrZRYQl7j1ZD4TxA+CEotm72GGsMUk/u16CPWbjsTZ608Y
	IWwDia1L97FA2IoSHcduskHM0ZO4MXUKlK0tsWzha2aIGwQlTs58Ava9hMB0TolbB6dBLXCR
	ePL8CNRQYYlXx7ewQ9gyEqcn97BMYNSeheS+WUh2zEKyYxaSHQsYWVYxiqeWFuempxYb5aWW
	6xUn5haX5qXrJefnbmIEppPT/45/2cG4/NVHvUOMTByMhxglOJiVRHhnLcxKE+JNSaysSi3K
	jy8qzUktPsQozcGiJM6rmiKfKiSQnliSmp2aWpBaBJNl4uCUamDaEa7fYWVgsvYM08Zzn295
	hnKlP5x4X9zA7KvD7d+ZHwzV5cvWXZ31dWvjDB0Bhn+/p0gKpDAeKzu0fQGvNeP0ytt/rMNc
	k94fCHxu4cQqd//U9YeX70x7wl6yZXPB/ltOvjv+uvU5yNavn/Nmr83/+xvCaxRNdgtF9Fk0
	mX5mSQx4Wtk1RzWr5PO0B3svzqpVfG2caVHuIPVTrOdzCZPM1ukh2TesJ/5dm1zJHPbyzJzK
	yKrseQtbff/tln8xTSPniuwRn2fTNiz/XrGJ2Sf3yctjdlfMi9u4gnW5fq8XPtD5dMXjp11v
	z93/8emF7j1pi39JG3YtfP/rSN/SD/Zauz83veNNO1wWlLj/cjIfpxJLcUaioRZzUXEiACu2
	NeWWAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsVy+t/xu7rlD7LTDKZ9UrI43bKX3eLppz4W
	ixsTnjI6MHss2FTqsWlVJ5vH501yAcxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbm
	sVZGpkr6djYpqTmZZalF+nYJehnrZkxiLmhjrfhy4RhzA+Ncli5GTg4JAROJNyf+sHcxcnEI
	CSxllOjdNI0ZIiEjsfHLVVYIW1jiz7UuNoiij4wSW488YoVwzjBKnF07A2yUkMBKRom7cyJB
	bDYBTYl9Jzexg9giAuYSszsmg3UzCyxklPi28BnYWGEBZ4nmnU1MEEUeEn8av0A16Em83ziL
	sYuRg4NFQFVi1awMkDCvgIXEtkUNYGEhIPvYPj2QMKeApcS6XW1gExkFZCUerfwFNoVZQFzi
	1pP5TBAPCEgs2XMe6jFRiZeP/0E9piNx9voTRgjbQGLr0n3QUFGU6Dh2kw1ijp7EjalToGxt
	iWULXzNDnCMocXLmE5YJjNKzkKybhaRlFpKWWUhaFjCyrGIUSS0tzk3PLTbSK07MLS7NS9dL
	zs/dxAhMB9uO/dyyg3Hlq496hxiZOBgPMUpwMCuJ8M5amJUmxJuSWFmVWpQfX1Sak1p8iNEU
	GEITmaVEk/OBCSmvJN7QzMDU0MTM0sDU0sxYSZzXs6AjUUggPbEkNTs1tSC1CKaPiYNTqoGJ
	0cNnrneJ6icxXSuVN6UProna+LHKLVn5f+a6wJPPM3ZHh/lfeLadaztj2IKI23+z/3FP2mkW
	88XZTefAdgHGcK9m8f6yx1JhUQ6hzwVP/98/5fPEyRkTmO69VAw6dDrx+OzCwxNldhYf6e7P
	2/5VRO5TJr966+ZbfaXTJjzKa9Z/6ze5xK+A/dOzP09cuM8vj1HtXvDeV/VXd/GTi7NOcPYt
	W8TyOOYrZ//23F3mdvUd7BIp3ir8Zw8+mB1a8svjyRe3h4/092QyM0ULuZkpHOyTYds+pzBM
	Su/p1PPhebG5V3cELd8e9Dw86qjMFaWXRTOvlCjHy0mLtX/R+swpJ31WoGn6Vs7WD/GxDPFK
	LMUZiYZazEXFiQAPyyAekAMAAA==
X-CMS-MailID: 20240614061727eucas1p19ba98d45511f9226f1c5cf1752b419b5
X-Msg-Generator: CA
X-RootMTR: 20240614061727eucas1p19ba98d45511f9226f1c5cf1752b419b5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240614061727eucas1p19ba98d45511f9226f1c5cf1752b419b5
References: <20240614061722.1080-1-da.gomez@samsung.com>
	<CGME20240614061727eucas1p19ba98d45511f9226f1c5cf1752b419b5@eucas1p1.samsung.com>

Make sure tmpfs scratch device inherits the extra tmpfs mount options
variable (TMPFS_MOUNT_OPTIONS).

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 7f995b0fa..a42792c37 100644
--- a/common/rc
+++ b/common/rc
@@ -224,7 +224,7 @@ _test_options()
 # hosted on $SCRATCH_DEV, so can't use external scratch devices).
 _common_dev_mount_options()
 {
-	echo $MOUNT_OPTIONS $SELINUX_MOUNT_OPTIONS $*
+	echo $MOUNT_OPTIONS $SELINUX_MOUNT_OPTIONS $TMPFS_MOUNT_OPTIONS $*
 }
=20
 _scratch_mount_options()
--=20
2.43.0

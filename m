Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924C81448D7
	for <fstests@vger.kernel.org>; Fri, 14 Jun 2024 06:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718345857; cv=none; b=T513seh1CJNul2H56QPuGy6NM0d+XPi1PlWjzRCqUjdqt5Siua0UdBJFscJTUHLWKjmE91eflf4KJ9l9+avBa9yX4qT1A5VYY0+IqC/FABe4AVahavJANLBfZKYOU0si8Z+6RGQ91e7zxNu0NtxUIPkCWvizcE1lG706E9K7gQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718345857; c=relaxed/simple;
	bh=oFG37xGsX3MdCgmBJjmNiJUJ9Y7OK01SvQ3tDUxbKMQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=bOBlfgXyb40Iq7eeHiA4wd+Vw4Cc7HDyBGA9VgtL3MFNZQgYQqeK6OtjQ0CPh1/VP3CPfdeh29ahTzmhJUPnfpDIWHU/bMgM/VboX7vWPnLzJ+DRzuuxxfEJOgXEPAT7AOKswHj4uJkreVm4Detf1jqf0VgkogykN+2B3beObSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=QTpE79Fb; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QTpE79Fb"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240614061727euoutp02d4d5323d92c972cbe788300a86d6a69b~YynGq2_ax0937309373euoutp02B
	for <fstests@vger.kernel.org>; Fri, 14 Jun 2024 06:17:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240614061727euoutp02d4d5323d92c972cbe788300a86d6a69b~YynGq2_ax0937309373euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718345847;
	bh=oFG37xGsX3MdCgmBJjmNiJUJ9Y7OK01SvQ3tDUxbKMQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=QTpE79FbrNyHzEqoml/CyWF07giuy15EZvNv0du06g1cAxE2Eps7d5P4bZLbhP+3j
	 2BGnOVxmsWdHR6v2wUhTo5W+MzZ/rQ/veaDxPREtHMxYSb/k4/x/5Bqp690Qlg8UTV
	 2CkVxpihPNCYOIpFhkwN783PKCrlO6KfOKKlbmDg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240614061727eucas1p138ba276a7179b6e2c2508ce57b1c5c5b~YynGibQiW1174711747eucas1p1o;
	Fri, 14 Jun 2024 06:17:27 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 73.74.09620.770EB666; Fri, 14
	Jun 2024 07:17:27 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240614061726eucas1p2da9aac47102bf2a5c590c0d07f04bed7~YynGKfp8c0868308683eucas1p2i;
	Fri, 14 Jun 2024 06:17:26 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240614061726eusmtrp22df7355631636591df48114241c40da4~YynGKAtyh1924819248eusmtrp2g;
	Fri, 14 Jun 2024 06:17:26 +0000 (GMT)
X-AuditID: cbfec7f5-d31ff70000002594-3e-666be07712ac
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 85.B7.08810.670EB666; Fri, 14
	Jun 2024 07:17:26 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240614061726eusmtip1ce6d9b3afd468b9504403658f0ae89ce~YynF-JzKB1662616626eusmtip1c;
	Fri, 14 Jun 2024 06:17:26 +0000 (GMT)
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
Subject: [PATCH 2/5] common/config: fix RECREATE_TEST_DEV initialization
Thread-Topic: [PATCH 2/5] common/config: fix RECREATE_TEST_DEV
	initialization
Thread-Index: AQHaviKG/M0IxN7t8E2aYXs9AVkdHg==
Date: Fri, 14 Jun 2024 06:17:24 +0000
Message-ID: <20240614061722.1080-3-da.gomez@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42LZduzned3yB9lpBjNOsVucbtnLbvH0Ux+L
	xY0JTxkdmD0WbCr12LSqk83j8ya5AOYoLpuU1JzMstQifbsEroxz5/8xF8xnr3i6dBpTA+Ns
	ti5GTg4JAROJnSe7WboYuTiEBFYwSpxYPIMRwvnCKLH9wnomCOczo8Til+8YYVpar6yBSixn
	lGifNo0FrurpvK2sEM4ZRokd3deghq1klNjzfikTSD+bgKbEvpOb2EFsEQFzidkdk9lAipgF
	FjJKfFv4jBUkISzgIfFy/xNGiCJ/ia3tG1ggbD2JMy0fwGwWAVWJHRdngtXzClhI9O5+DbaA
	U8BSYt2uNrA4o4CsxKOVv8CWMQuIS9x6Mp8J4glBiUWz9zBD2GIS/3Y9hIaHjsTZ60+gHjWQ
	2Lp0HwuErSjRcewmG8QcPYkbU6dA2doSyxa+Zoa4QVDi5Mwn4LCQEJjNKbHmQy9QEQeQ4yIx
	Z4ksxBxhiVfHt7BD2DIS/3fOZ5rAqD0LyXmzkKyYhWTFLCQrFjCyrGIUTy0tzk1PLTbOSy3X
	K07MLS7NS9dLzs/dxAhMKKf/Hf+6g3HFq496hxiZOBgPMUpwMCuJ8M5amJUmxJuSWFmVWpQf
	X1Sak1p8iFGag0VJnFc1RT5VSCA9sSQ1OzW1ILUIJsvEwSnVwGQtZ6aY03CA4b37/3kqInrL
	L0sEW7drzVpSv3t/vPRTlT1yQtxXa8Uidt/gvzXRk39XlX0T/+O/2x2WqIUyq6hvqpP3U9EU
	PtL053SFjLrBAm/Hfymvbduvfk94Hmvkc9RfbPY8tYwzPz0DN507Eq8S0HiuUOPpNo/j3iwt
	C67lmot/+Z+gZrusqsXFNtr7cX7nioMSL844Ve/VWKP3Vdx+zb0HlitPO/rHmopnnzC9IGBc
	dkd2+u71ko9mTz59P/WZa96VuTe+/cszmvxG/uebbbafk09LPNoUPbXjZbNcTndNrHil84bb
	juazO7IL9m3Sv5X7j+XgSYcWXdtGy3lnPv3dWnm1k0siY1eQnhJLcUaioRZzUXEiAFdc7K6X
	AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRmVeSWpSXmKPExsVy+t/xu7plD7LTDI481bU43bKX3eLppz4W
	ixsTnjI6MHss2FTqsWlVJ5vH501yAcxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbm
	sVZGpkr6djYpqTmZZalF+nYJehnnzv9jLpjPXvF06TSmBsbZbF2MnBwSAiYSrVfWMHUxcnEI
	CSxllFj47AIrREJGYuOXq1C2sMSfa11sEEUfGSVaL2xkhHDOMEqcXTuDBaRKSGAlo8TdOZEg
	NpuApsS+k5vYQWwRAXOJ2R2TwbqZBRYySnxb+AxsrLCAh8TL/U8YIYp8JY5NfscMYetJnGn5
	ADaURUBVYsfFmWD1vAIWEr27XwPdygG0zELi2D49kDCngKXEul1tYCWMArISj1b+AtvLLCAu
	cevJfCaIDwQkluw5zwxhi0q8fPwP6jMdibPXIU6QEDCQ2Lp0HwuErSjRcewmG8QcPYkbU6dA
	2doSyxa+ZoY4R1Di5MwnLBMYpWchWTcLScssJC2zkLQsYGRZxSiSWlqcm55bbKhXnJhbXJqX
	rpecn7uJEZgQth37uXkH47xXH/UOMTJxMB5ilOBgVhLhnbUwK02INyWxsiq1KD++qDQntfgQ
	oykwiCYyS4km5wNTUl5JvKGZgamhiZmlgamlmbGSOK9nQUeikEB6YklqdmpqQWoRTB8TB6dU
	A9Pm7U8PX7pRxreruOWQw4kpW/OE7UqTE08sKnVrFZdTMlVrk/Db07Iz7MHy12en+86Z2VNY
	usHzmbz/Uo+7Jh86Sg8s704pSP+5ifvSpqw7Z0+ECcy9nuV9ef+y84IHZgcmvYi+OkMk7Lri
	Oa0NKraxYfP0D2xYcp53ho9nY8CXW5VXWq4febtA7vnTZtkVvPPrmfaVP1n0Ne2zvRyXh0uJ
	nFFS/bSCHYeYy1eW505X0Muxrdx/4sCl3spsJ/92l2tP99xXZVx1vmKCrFpV2KndhrstYruC
	BVYwxJl++nNaZ07zXzeHbaFBOwwqQ5NSp7aU1yyotq/+Irfo1NWAXTNUJv46Gv9Jf3vTWXE+
	TxMlluKMREMt5qLiRACeAdhMkQMAAA==
X-CMS-MailID: 20240614061726eucas1p2da9aac47102bf2a5c590c0d07f04bed7
X-Msg-Generator: CA
X-RootMTR: 20240614061726eucas1p2da9aac47102bf2a5c590c0d07f04bed7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240614061726eucas1p2da9aac47102bf2a5c590c0d07f04bed7
References: <20240614061722.1080-1-da.gomez@samsung.com>
	<CGME20240614061726eucas1p2da9aac47102bf2a5c590c0d07f04bed7@eucas1p2.samsung.com>

Do not allow the overwriting of the RECREATE_TEST_DEV variable. When
this variable is enabled, common/rc -> common/config will reset it
to false after the test device recreation process. This allows for
differentiation in mount options for SCRATCH and TEST.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 common/config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/config b/common/config
index a1cd14de6..43b32b93d 100644
--- a/common/config
+++ b/common/config
@@ -94,7 +94,7 @@ export PWD=3D`pwd`
 export MALLOCLIB=3D${MALLOCLIB:=3D/usr/lib/libefence.a}
 export LOCAL_CONFIGURE_OPTIONS=3D${LOCAL_CONFIGURE_OPTIONS:=3D--enable-rea=
dline=3Dyes}
=20
-export RECREATE_TEST_DEV=3Dfalse
+export RECREATE_TEST_DEV=3D${RECREATE_TEST_DEV:=3Dfalse}
=20
 # Handle mkfs.$fstyp which does (or does not) require -f to overwrite
 set_mkfs_prog_path_with_opts()
--=20
2.43.0

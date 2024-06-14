Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4D3146D57
	for <fstests@vger.kernel.org>; Fri, 14 Jun 2024 06:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718346286; cv=none; b=YrG3p8oc0vwm4GpFMQbDcYfGOnaP4rOk0RCbvzcbnXGcM8D+MkGUy9SDV4TPJl4PO02IDYuUl3NskUYghTmVbOtxKCaolP9rotD5w5XmkkjqkP+LwaUnP/FnKzkT3Y106dw9jGthdebiH6PxyOb4G8zeFfhxBf0Fc8Fb/yBOIJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718346286; c=relaxed/simple;
	bh=iDmMtCkprs8uumQasrxAMiXITtz27ee/UynnA5SvLtg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=Jfa5MG0dEHDepizXxu9quytlCL6dIpQaT7UChDA7scbTMXqhYvCJA6mK5Nytu31N5oU4cecPzIKuGY1HGcXN1Bd7I0YGL9Stprqf9x6RWf3VnYEk0y4eYak8BMCqji2Y+HxMl2XWgmy7WJUi61pdGZ0xUma6KI3iFgMQ0vB2/AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rVna5Svd; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rVna5Svd"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240614061729euoutp01f856e7f63e7f9b9af7f33c0e5979ef80~YynISfIJ61680416804euoutp01g
	for <fstests@vger.kernel.org>; Fri, 14 Jun 2024 06:17:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240614061729euoutp01f856e7f63e7f9b9af7f33c0e5979ef80~YynISfIJ61680416804euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718345849;
	bh=s2oSevXb7kXA/PXzWQSNV/0WDopRY9fSPMGsPPccsYk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=rVna5SvdgJSe+NKX8LL1o5+CwNcZnnLPsc6BiLzHHCl2Xx54DWlVd+bnO5GnWy5wR
	 M+VlnYjg8APv4A0jRFM5TWqvyBBs0ciUf70DU/MxAplvDho+FyUUDPS2xyY0UjA05+
	 +2OotxfDY1B6wS6vji4fUOnpaTNtgj61jV8nRFks=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240614061728eucas1p19a6b9ef0226c245ab58aee38e4278e9a~YynIDPUMZ2499024990eucas1p18;
	Fri, 14 Jun 2024 06:17:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 8F.E9.09875.870EB666; Fri, 14
	Jun 2024 07:17:28 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240614061728eucas1p2d7488fbbd2887c5d60d2bd1e3fd48580~YynHocN8i2060620606eucas1p28;
	Fri, 14 Jun 2024 06:17:28 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240614061728eusmtrp122c4589aee1dc8968aca0e4ec1d39f7e~YynHn9LnC1655316553eusmtrp1X;
	Fri, 14 Jun 2024 06:17:28 +0000 (GMT)
X-AuditID: cbfec7f4-131ff70000002693-72-666be0787d2d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 0E.C5.09010.870EB666; Fri, 14
	Jun 2024 07:17:28 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240614061728eusmtip2f22086396f8f2f76b49344eba5067289~YynHeogs90542205422eusmtip29;
	Fri, 14 Jun 2024 06:17:28 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Fri, 14 Jun 2024 07:17:27 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
	([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Fri, 14 Jun
	2024 07:17:27 +0100
From: Daniel Gomez <da.gomez@samsung.com>
To: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
CC: Pankaj Raghav <p.raghav@samsung.com>, "mcgrof@kernel.org"
	<mcgrof@kernel.org>, "hughd@google.com" <hughd@google.com>, Daniel Gomez
	<da.gomez@samsung.com>
Subject: [PATCH 5/5] common/rc: print scratch and test mount options
Thread-Topic: [PATCH 5/5] common/rc: print scratch and test mount options
Thread-Index: AQHaviKGDA6KUdYWlUyy/G+RuOXD4A==
Date: Fri, 14 Jun 2024 06:17:26 +0000
Message-ID: <20240614061722.1080-6-da.gomez@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42LZduzned2KB9lpBldOG1icbtnLbvH0Ux+L
	xY0JTxkdmD0WbCr12LSqk83j8ya5AOYoLpuU1JzMstQifbsEroyvf74yFWwTrFj76T1zA+M7
	3i5GTg4JAROJFXefMHUxcnEICaxglHh0bjsjhPOFUeLx3/XsEM5nRomDO++ywLQsaz3ECpFY
	ziixYdIRRriqP/2/WSCcM4wSUw8dgJq8klFi67brjCD9bAKaEvtObmIHsUUEzCVmd0xmAyli
	FljIKPFt4TNWkISwgItE94/rLBBFnhLLW7axQth6En3vzoPFWQRUJb51z2MDsXkFLCROP94O
	FucUsJRYt6sNrJ5RQFbi0cpfYMuYBcQlbj2ZzwTxhKDEotl7mCFsMYl/ux6yQdg6EmevP2GE
	sA0kti7dB/W0okTHsZtsEHP0JG5MnQJla0ssW/iaGeIGQYmTM5+AvS8hMJ1TYk37H6AjOIAc
	F4kDR50g5ghLvDq+hR3ClpE4PbmHZQKj9iwk581CsmIWkhWzkKxYwMiyilE8tbQ4Nz212Cgv
	tVyvODG3uDQvXS85P3cTIzChnP53/MsOxuWvPuodYmTiYDzEKMHBrCTCO2thVpoQb0piZVVq
	UX58UWlOavEhRmkOFiVxXtUU+VQhgfTEktTs1NSC1CKYLBMHp1QDk2lCgvxv/yxzjtPSdWce
	vVRWSZpQ1r6fdeWcguDJL9rES/vz51W0V81PK7zIu0O8+fF/6beybm9PLn9Tsu/erRbGOdM4
	32jpJW7SXJI6obC/R8Sob8+uTScEzCcnsNv112W+PW+xcd2Th3elBKVXxhd6zPadfODeTSUR
	8+dHlUwfWMyrCeGXXlDJerh+sVo+4wyx0+dXlUwPNqoseqimbjRfQ6a2aNW8tOI/3pYCwoVl
	RzbIKi/TsF6vFC9ibnHkVkrAzn878usDFh2eN8dcyK6y+TRfRvWSz34tTxeq6xtVzo66tOzR
	YuWV6+5sT+xSn+qmd+Jh47nbqhXc+kxH5lVvWqbHvE/oypvEo6f2KbEUZyQaajEXFScCADKp
	RYCXAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsVy+t/xe7oVD7LTDM4cELU43bKX3eLppz4W
	ixsTnjI6MHss2FTqsWlVJ5vH501yAcxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbm
	sVZGpkr6djYpqTmZZalF+nYJehlf/3xlKtgmWLH203vmBsZ3vF2MnBwSAiYSy1oPsXYxcnEI
	CSxllPj66zI7REJGYuOXq6wQtrDEn2tdbBBFHxkl9l2cwwLhnGGUaO85BeWsZJT49Xs1E0gL
	m4CmxL6Tm8BGiQiYS8zumAzWziywkFHi28JnYHOFBVwkun9cZ4Eo8pRY3rKNFcLWk+h7dx4s
	ziKgKvGtex4biM0rYCFx+vF2oDgH0DYLiWP79EDCnAKWEut2tYG1MgrISjxa+QtsL7OAuMSt
	J/OZIF4QkFiy5zwzhC0q8fLxP6jXdCTOXn/CCGEbSGxduo8FwlaU6Dh2kw1ijp7EjalToGxt
	iWULXzNDnCMocXLmE5YJjNKzkKybhaRlFpKWWUhaFjCyrGIUSS0tzk3PLTbSK07MLS7NS9dL
	zs/dxAhMCduO/dyyg3Hlq496hxiZOBgPMUpwMCuJ8M5amJUmxJuSWFmVWpQfX1Sak1p8iNEU
	GEQTmaVEk/OBSSmvJN7QzMDU0MTM0sDU0sxYSZzXs6AjUUggPbEkNTs1tSC1CKaPiYNTqoHJ
	MyBK4oiC7NJXxkKmrouElhdwaweFWIgqiXV2vlz2+sn1Ge9W/7kiZXM6NvCG6P2ANgXOQ4sD
	ms8uPhi5ZFlQbapl9sqzR7/c+txd+mH3Cb5nV/ZOe2F1yPBzSkcM0+1ioyVPvXyUEoLvfbkR
	PrFCPce3hfexfO2H20kr/q37rrvjivIFZYMApa86rYFPsl4/65JnaSjhCbaIZ1twsuTMZFEx
	o8m8vbsVZ301XuLNW6Vu8njuykq92n9Xq//Pysz5xXn18oXFZx7c2Lln/oRTu9k5Oy/FuqTs
	P8qm27J3P9O3LTtcZ7C57/u6Te9gc/bFaRlb4uRveK1cVSa5d7+hZ6OthKJsauwy/X+2q1jd
	lViKMxINtZiLihMBJa5ufJIDAAA=
X-CMS-MailID: 20240614061728eucas1p2d7488fbbd2887c5d60d2bd1e3fd48580
X-Msg-Generator: CA
X-RootMTR: 20240614061728eucas1p2d7488fbbd2887c5d60d2bd1e3fd48580
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240614061728eucas1p2d7488fbbd2887c5d60d2bd1e3fd48580
References: <20240614061722.1080-1-da.gomez@samsung.com>
	<CGME20240614061728eucas1p2d7488fbbd2887c5d60d2bd1e3fd48580@eucas1p2.samsung.com>

Mount options for a SCRATCH device might not be the same in the TEST
device if RECREATE_TEST_DEV is not enabled. So, print mount options for
each device to clarify this.

Add mount and mkfs info for TEST devices so we get the same information
being printed for both devices.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 check     |  4 ++++
 common/rc | 20 ++++++++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/check b/check
index 723a52e30..e02d28b39 100755
--- a/check
+++ b/check
@@ -807,7 +807,11 @@ function run_section()
 	# print out our test configuration
 	echo "FSTYP         -- `_full_fstyp_details`"
 	echo "PLATFORM      -- `_full_platform_details`"
+	echo "TEST device:"
+	echo "MKFS_OPTIONS  -- `_test_mkfs_options`"
+	echo "MOUNT_OPTIONS -- `_test_mount_options`"
 	if [ ! -z "$SCRATCH_DEV" ]; then
+	  echo "SCRATCH device:"
 	  echo "MKFS_OPTIONS  -- `_scratch_mkfs_options`"
 	  echo "MOUNT_OPTIONS -- `_scratch_mount_options`"
 	fi
diff --git a/common/rc b/common/rc
index a42792c37..b351a82eb 100644
--- a/common/rc
+++ b/common/rc
@@ -235,6 +235,17 @@ _scratch_mount_options()
 					$SCRATCH_DEV $SCRATCH_MNT
 }
=20
+_test_mount_options()
+{
+	_test_options mount
+
+	if $RECREATE_TEST_DEV || [ "$OLD_FSTYP" !=3D "$FSTYP" ]; then
+		echo $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $TMPFS_MOU=
NT_OPTIONS $* $TEST_DEV $TEST_DIR
+	else
+		echo $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $* $TEST_D=
EV $TEST_DIR
+	fi
+}
+
 _supports_filetype()
 {
 	local dir=3D$1
@@ -456,8 +467,7 @@ _test_mount()
         return $?
     fi
=20
-    _test_options mount
-    _mount -t $FSTYP$FUSE_SUBTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINU=
X_MOUNT_OPTIONS $TMPFS_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
+    _mount -t $FSTYP$FUSE_SUBTYP `_test_mount_options $*`
     mount_ret=3D$?
     [ $mount_ret -ne 0 ] && return $mount_ret
     _idmapped_mount $TEST_DEV $TEST_DIR
@@ -571,6 +581,12 @@ _metadump_dev() {
 	esac
 }
=20
+_test_mkfs_options()
+{
+	_test_options mkfs
+	echo $TEST_OPTIONS $MKFS_OPTIONS $* $TEST_DEV
+}
+
 _test_mkfs()
 {
     case $FSTYP in
--=20
2.43.0

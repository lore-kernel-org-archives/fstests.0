Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.254.224.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794372665;
	b=J0XRabV9juh1Y064bhAFOFkOOvb6oGaWy9AxNj7bvUShny//M9VYJcx66KWlNHRLtPao
	 Yi0yCAIUp4+i4zby27eeKTzU8u7WQX5rJ5zu8xQNhXahH0UeIIL4BMT6DDY9uNrfyIbV1
	 wsVXZ5G4iwMsDiBefBukL68IX1D3UJJ0No0DENOshFI61miV0TB/uC9kmFM9a3lMV5KWT
	 P5GoGpn0wWCuv8Xv2j2E4STlCgVi5e5a2Qi8jPoA6xIpe/3h/HxnV9nA7C22ZzsMWt6th
	 KVDemQCUKyOIoWhQxuTCMUzWQbC1toDhMmB2hbeNba8G2hckysOfBIG/P/Oaifi+nLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794372665;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Mime-Version:Subject:Reply-To:Sender:From:To:CC:X-Priority:
	 X-Content-Kind-Code:In-Reply-To:X-CPGS-Detection:X-Drm-Type:
	 X-Msg-Generator:X-Msg-Type:X-Reply-Demand:Message-ID:Date:
	 X-CMS-MailID:Content-Transfer-Encoding:Content-Type:X-Sendblock-Type:
	 CMS-TYPE:X-CPGSPASS:X-CPGSPASS:cpgsPolicy:X-CFilter-Loop:
	 X-CMS-RootMailID:References;
	bh=gh+NftpSqHgfZZ/G5//YTCUgo/7r9ac0BfabcTGSh/0=;
	b=yxQ32PIEkCeqVzWd5tSVwvpopP4NXzWbB5Qlp6UTdliJKbUlAbRPFXpfFKQG+VxJd59w
	 K+be0CQ1HIvKXMizOS621y6OF0tg08qhEri9/q7KTxWWIpculaeVIcFo6Hgxjcdqke4aI
	 5earthCZIfJj52V224obbSmeHeBrBlsEPaAL690F97d8pOgGwoW8bJDcVMY1+BZyI3ApW
	 jGvwXiR4dhmAKNkYgKDAuY07NfT4guUzY41DSKfcLLz7sCd1v5C98AKika8ESl0DvtpvE
	 mjfp+xoccLLuDodmgmpcuB8qiztsXDbZNfNXEtQADAfQ1UJ6wZZFKHiSQzL07hKQRIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=D7VkqrrN;
	arc=none smtp.remote-ip=203.254.224.25
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B01606A31C
	for <fstests@vger.kernel.org>; Wed, 11 Nov 2026 04:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0B01606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=D7VkqrrN
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20261111045102epoutp0215a9e0cb69733f38cf827519bf884793~m5G4RZKsi3073230732epoutp025
	for <fstests@vger.kernel.org>; Wed, 11 Nov 2026 04:51:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20261111045102epoutp0215a9e0cb69733f38cf827519bf884793~m5G4RZKsi3073230732epoutp025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1794372662;
	bh=gh+NftpSqHgfZZ/G5//YTCUgo/7r9ac0BfabcTGSh/0=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=D7VkqrrNmvPWwYDYAZPA0NfHRhsJUTZ8YAsnBRZwiks3y74bCQUDXJjL3ZnHiYUVs
	 TzP8vF6+f3ZOMWNwYgFYpzunpPPZEs/SM6aXVEAXiHN6ISHnBBkIwWOLfAdCHcGyFb
	 8TNUkYHz3NODmFMlKiwroNjcjrHO5Fa+WiXG6ibs=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPS id
	20261111045102epcas2p1b71cc6e9fba61bc89699db8efb11129f~m5G37_zDP2721727217epcas2p1C;
	Wed, 11 Nov 2026 04:51:02 +0000 (GMT)
Received: from epcas2p2.samsung.com (unknown [182.195.38.210]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4jPWLZ18Bzz6B9m7; Wed, 11 Nov
	2026 04:51:02 +0000 (GMT)
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Subject: RE: [PATCH] overlay/077: check a stale entry in an impure dir on
 any hash seed
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From: Daejun Park <daejun7.park@samsung.com>
To: Daejun Park <daejun7.park@samsung.com>, "fstests@vger.kernel.org"
	<fstests@vger.kernel.org>
CC: Zorro Lang <zlang@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>, Hungyu Lin <dennylin0707@gmail.com>,
	"linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20261110-ovl077-stale-next-v1-1-948a5a434ae2@samsung.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20261111045101epcms2p442a57243edc0297369214e5d89d43d5e@epcms2p4>
Date: Wed, 11 Nov 2026 13:51:01 +0900
X-CMS-MailID: 20261111045101epcms2p442a57243edc0297369214e5d89d43d5e
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261110080502epcas2p31a01ccf5c32fd27f361a2364db9c3d87
References: <20261110-ovl077-stale-next-v1-1-948a5a434ae2@samsung.com>
	<CGME20261110080502epcas2p31a01ccf5c32fd27f361a2364db9c3d87@epcms2p4>

Your mail below did not reach my mailbox, so I could not reply to it
directly.

https://lore.kernel.org/all/CAOQ4uxgxzee1dqLcYHPWFhkcAxP_WRrJn5DiiL9mB0ZjC83vbQ@mail.gmail.com/

On Tue, Nov 10, 2026 at 04:33:50PM +0100, Amir Goldstein wrote:
> For the problem of spurious test failure, I suggest to relax the expectation
> for the first entry in the buffer or to fix ext4 to avoid emitting the stale
> entry.

Thanks. v2 will relax the expectation in t_dir_offset2: the d_ino of
the unlinked file's entry is not checked when it is the first entry of
the first getdents call after the unlink.

Best regards,
Daejun

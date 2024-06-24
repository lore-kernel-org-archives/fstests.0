Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34F113F44D
	for <fstests@vger.kernel.org>; Mon, 24 Jun 2024 13:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719237040; cv=none; b=XTypfyZubfp1UYxmR4PP1MuU1zV19OHJ+wI558Fdm2pBKDS4VvU3dgIXG69NleksfaNq5MKJrK00G1u2TPLO6XfcEyYCKY7khjpHpdQIINZyVG+4iy6vDghh0XkQ6k6e96hTszhp+x0j7gvpFx2WBLEldlzCnb4Mn8I1CCztkpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719237040; c=relaxed/simple;
	bh=NEytsdm6oiwfVDdLwmiauf6GpiRIF/gKOa+BspWDrYA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=T32CkzUwqXr9JTPEt7ntTQOdF5G8BrBGBIXeuWTRK/QEKnRUgzcG9cTBBEn/mKtPWimDk52X3lFFfldJUr5iC2llaWRiDaDx7KQ5/AgdIMxvCA0CKWUOdbMlMDJVEenWS7axyUWtlDIMY/ID7rgGg9DSzU5iN5YItu/bnoa/LhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=nR0e2BgO; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nR0e2BgO"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240624135035euoutp0199ff05b165d33c65fe7a5bbd44dd207d~b9PmjgMFl0315403154euoutp01w
	for <fstests@vger.kernel.org>; Mon, 24 Jun 2024 13:50:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240624135035euoutp0199ff05b165d33c65fe7a5bbd44dd207d~b9PmjgMFl0315403154euoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719237035;
	bh=NEytsdm6oiwfVDdLwmiauf6GpiRIF/gKOa+BspWDrYA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=nR0e2BgOYYnvGa1FNO6vs3fyrizfLQ8wTHM/iHBlCXD04dsqdJUp4hqds41oE1MSU
	 FPgD7LwUHtq3gcRE9Ov6C1QbfclQ8xeJ4JLwC4RutSv6EGtPAk60NYGdQ2sdoonLBJ
	 PDTl2G3OQDNbgMpaiLYz8Av73n3L2xoNlcN7hoNo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240624135035eucas1p17df61a5a520986abd7ee52e88978ce77~b9PmVutYF1489514895eucas1p1Y;
	Mon, 24 Jun 2024 13:50:35 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 7A.BB.09624.BA979766; Mon, 24
	Jun 2024 14:50:35 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240624135035eucas1p1c13f88e20b3a81aa617a5c91ea347c3e~b9Pl7WrDJ0382403824eucas1p1y;
	Mon, 24 Jun 2024 13:50:35 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240624135035eusmtrp17d70656bf8f46f18d6efbb93a85bf325~b9Pl6b3SY0607206072eusmtrp1c;
	Mon, 24 Jun 2024 13:50:35 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-2f-667979abede0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id F3.97.08810.BA979766; Mon, 24
	Jun 2024 14:50:35 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240624135034eusmtip2ad6b77d3d30315c1d9d5feba51bd3301~b9PlvwWGK1807618076eusmtip2c;
	Mon, 24 Jun 2024 13:50:34 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Mon, 24 Jun 2024 14:50:34 +0100
Received: from CAMSVWEXC01.scsc.local ([::1]) by CAMSVWEXC01.scsc.local
	([fe80::7d73:5123:34e0:4f73%13]) with mapi id 15.00.1497.012; Mon, 24 Jun
	2024 14:50:34 +0100
From: Daniel Gomez <da.gomez@samsung.com>
To: "Darrick J. Wong" <djwong@kernel.org>
CC: "fstests@vger.kernel.org" <fstests@vger.kernel.org>, Pankaj Raghav
	<p.raghav@samsung.com>, "mcgrof@kernel.org" <mcgrof@kernel.org>,
	"hughd@google.com" <hughd@google.com>
Subject: Re: [PATCH 4/5] common/rc: fix scratch mount options for tmpfs
Thread-Topic: [PATCH 4/5] common/rc: fix scratch mount options for tmpfs
Thread-Index: AQHaviKG7LBDn2pSnkKBi8GAx++1P7HHV0gAgA+WmoA=
Date: Mon, 24 Jun 2024 13:50:33 +0000
Message-ID: <jnyfwimjjfi56fqbfb4lvrauzinkgokdsftxa4k4o5o7eomokm@ghgk5vt46rcz>
In-Reply-To: <20240614154728.GC6110@frogsfrogsfrogs>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="utf-8"
Content-ID: <79990FC2F2A8904D86CAE4794D356CAC@scsc.local>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsWy7djP87qrKyvTDDpmylpcfsJncbplL7vF
	0099LBY3JjxldGDxWLCp1GPTqk42j8+b5AKYo7hsUlJzMstSi/TtErgy7rRNYC24Il1x8XZ2
	A+MPqS5GTg4JAROJbaffM3YxcnEICaxglJgy8yYThPOFUWLjx0VsEM5nRok1W5eywLQ8fT4P
	qmU5o0T3+rMscFXX391mhnDOMEpsvfIaylkJVDbnMhtIP5uApsS+k5vYQWwRIPvIt2tgG5kF
	NjJKXJr3DqxIWMBdYtbbJ1BFHhJ/Gr9A2VYS23sfsILYLAKqEh8aW8DivAK+EivPLAazOYEO
	7L23gwnEZhSQlXi08hdYnFlAXOLWk/lMEE8ISiyavYcZwhaT+LfrIRuErSNx9voTRgjbQGLr
	0n1QTytLPJp7HqieA2iOpsT6XfoQIy0lfs9dywZhK0pM6X4IdY6gxMmZT8DBIiGwnFOiY957
	qL0uEpeP/4eaLyzx6vgW9gmMOrOQnDcLYcUsJCtmIVkxC8mKBYysqxjFU0uLc9NTiw3zUsv1
	ihNzi0vz0vWS83M3MQKTzel/xz/tYJz76qPeIUYmDsZDjBIczEoivNPry9KEeFMSK6tSi/Lj
	i0pzUosPMUpzsCiJ86qmyKcKCaQnlqRmp6YWpBbBZJk4OKUamNofbzI00hW3va7/4KN8R/Yy
	yY+vnzFHcnDPXDnLo0JOJf+57kkd5kcFzqtrpxW+U1NUemlktOaB/v9P25ru9lc6sco2K5/8
	xWfDcb9t/fRl7gk5PS6hd07k7quadvNb6PaA3Tz3J/MqZQmYO+/86JGzpyv4XMKLT/LsD22D
	TXR8Oqv2/Gy/4F31bc6/vbNm+Fsc2vfhY+hjjiwFfzYGp7j8Yp+FK2xTlS1nPd649orNYkal
	cvUNC/smqfb5utuGnDYqMP7kVb3i4h5d44m392x6bPBf/9LTZxdFfjBqK9x1ucLDuNt9y8yP
	ftbOU9Zdm+vpl3OT+2Z32LMPNxU++83y+tg6Jzos/YG/5PZ1W5RYijMSDbWYi4oTAatOLFml
	AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsVy+t/xe7qrKyvTDKb3sFhcfsJncbplL7vF
	0099LBY3JjxldGDxWLCp1GPTqk42j8+b5AKYo/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws
	9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQy7rRNYC24Il1x8XZ2A+MPqS5GTg4JAROJp8/nMXYx
	cnEICSxllFi7+TMbREJGYuOXq6wQtrDEn2tdbBBFHxkl9q1pY4dwzjBKPNs5lQnCWcko0Xry
	KRNIC5uApsS+k5vYQWwRIPvIt2tgRcwCGxklLs17B7ZDWMBdYtbbJ1BFHhJ/Gr9A2VYS23sf
	gO1mEVCV+NDYAhbnFfCVWHlmMdTqp4wS29vnM4IkOIG+6L23A2wzo4CsxKOVv8AamAXEJW49
	mc8E8YSAxJI955khbFGJl4//QT2nI3H2+hNGCNtAYuvSfSwQtrLEo7kg9RxAczQl1u/Shxhp
	KfF77lo2CFtRYkr3Q6jbBCVOznzCMoFRZhaSzbMQumch6Z6FpHsWku4FjKyrGEVSS4tz03OL
	DfWKE3OLS/PS9ZLzczcxAhPJtmM/N+9gnPfqo94hRiYOxkOMEhzMSiK80+vL0oR4UxIrq1KL
	8uOLSnNSiw8xmgKDbiKzlGhyPjCV5ZXEG5oZmBqamFkamFqaGSuJ83oWdCQKCaQnlqRmp6YW
	pBbB9DFxcEo1MHm2FW08aHKPWXDSjpfvyl7zeL7ba7769ga9V6cCM1PO5RhM96xlDzqgr828
	YdWfyrPragXecT+WuWAaGuIta94+V7nw085Cs6C1tcJ5Dw+HW4eYBkZ9unfxn+/nm13/t63V
	+aW29pTs7lIvdjW5IIl7yyXuvGTmVZ79vnmmwrLJ+xfY3TN/qTfH+fsa/fMqlikq7XGMJ4pv
	fPopc7ypa/WyHaf4D2QfYTKc+J2fZ+6TVYvrdr7YJtv73PAQZ4NCAgfz2ViGherNpepsl1Yd
	NOswv1QZv2ddKUvzTON1sol5TkVHryyYYShYlnn+6umzR6Pe26lavIoN9u6rNSt6eFY+mnvN
	BZGw7E+X7xw5ZqHEUpyRaKjFXFScCAAj6fWwrQMAAA==
X-CMS-MailID: 20240624135035eucas1p1c13f88e20b3a81aa617a5c91ea347c3e
X-Msg-Generator: CA
X-RootMTR: 20240614061727eucas1p19ba98d45511f9226f1c5cf1752b419b5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240614061727eucas1p19ba98d45511f9226f1c5cf1752b419b5
References: <20240614061722.1080-1-da.gomez@samsung.com>
	<CGME20240614061727eucas1p19ba98d45511f9226f1c5cf1752b419b5@eucas1p1.samsung.com>
	<20240614061722.1080-5-da.gomez@samsung.com>
	<20240614154728.GC6110@frogsfrogsfrogs>

T24gRnJpLCBKdW4gMTQsIDIwMjQgYXQgMDg6NDc6MjhBTSBHTVQsIERhcnJpY2sgSi4gV29uZyB3
cm90ZToNCj4gT24gRnJpLCBKdW4gMTQsIDIwMjQgYXQgMDY6MTc6MjVBTSArMDAwMCwgRGFuaWVs
IEdvbWV6IHdyb3RlOg0KPiA+IE1ha2Ugc3VyZSB0bXBmcyBzY3JhdGNoIGRldmljZSBpbmhlcml0
cyB0aGUgZXh0cmEgdG1wZnMgbW91bnQgb3B0aW9ucw0KPiA+IHZhcmlhYmxlIChUTVBGU19NT1VO
VF9PUFRJT05TKS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgR29tZXogPGRhLmdv
bWV6QHNhbXN1bmcuY29tPg0KPiA+IC0tLQ0KPiA+ICBjb21tb24vcmMgfCAyICstDQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRp
ZmYgLS1naXQgYS9jb21tb24vcmMgYi9jb21tb24vcmMNCj4gPiBpbmRleCA3Zjk5NWIwZmEuLmE0
Mjc5MmMzNyAxMDA2NDQNCj4gPiAtLS0gYS9jb21tb24vcmMNCj4gPiArKysgYi9jb21tb24vcmMN
Cj4gPiBAQCAtMjI0LDcgKzIyNCw3IEBAIF90ZXN0X29wdGlvbnMoKQ0KPiA+ICAjIGhvc3RlZCBv
biAkU0NSQVRDSF9ERVYsIHNvIGNhbid0IHVzZSBleHRlcm5hbCBzY3JhdGNoIGRldmljZXMpLg0K
PiA+ICBfY29tbW9uX2Rldl9tb3VudF9vcHRpb25zKCkNCj4gPiAgew0KPiA+IC0JZWNobyAkTU9V
TlRfT1BUSU9OUyAkU0VMSU5VWF9NT1VOVF9PUFRJT05TICQqDQo+ID4gKwllY2hvICRNT1VOVF9P
UFRJT05TICRTRUxJTlVYX01PVU5UX09QVElPTlMgJFRNUEZTX01PVU5UX09QVElPTlMgJCoNCj4g
DQo+IFdoeSBpcyBpdCBuZWNlc3NhcnkgdG8gaW5jbHVkZSB0bXBmcyBtb3VudCBvcHRpb25zIGZv
ciBhbGwgZnMgdHlwZXM/DQo+IFhGUyBkb2VzIG5vdCBhY2NlcHQgdG1wZnMgbW91bnQgb3B0aW9u
cy4NCg0KWW91IGFyZSByaWdodC4gV2Ugc2hvdWxkIG5vdCBkbyB0aGlzLg0KDQpIb3dldmVyLCBf
c2NyYXRjaF9tb3VudF9vcHRpb25zKCkgY2FsbHMgX2NvbW1vbl9kZXZfbW91bnRfb3B0aW9ucygp
IGlnbm9yaW5nIHRoZQ0Kc3BlY2lmaWMgbW91bnQgb3B0aW9ucyBiYXNlZCBvbiBmc3R5cC4gUmVw
bGFjaW5nIGl0IHdpdGggX2NvbW1vbl9tb3VudF9vcHRzKCkNCm1ha2VzIHRoaXMgd29yay4gSW4g
YWRkaXRpb24sIF9jb21tb25fZGV2X21vdW50X29wdGlvbnMoKSBmdW5jdGlvbiBkZXNjcmlwdGlv
bg0Kc2F5cyAnVXNlZCBmb3IgbW91bnRpbmcgbm9uLXNjcmF0Y2ggZGV2aWNlcyB3aXRoIHRoZSBz
YWZlIHNldCBvZiBzY3JhdGNoIG1vdW50DQpvcHRpb25zJy4gU28sIHdoeSBpcyBpdCB1c2VkIHRv
IG1vdW50IHNjcmF0Y2ggZGV2aWNlcz8NCg0KVGhpcyBmaXhlcyB0aGUgaXNzdWU6DQoNCmRpZmYg
LS1naXQgYS9jb21tb24vcmMgYi9jb21tb24vcmMNCmluZGV4IDUxODI3MTE5Yy4uNjI3ZGJhYWFh
IDEwMDY0NA0KLS0tIGEvY29tbW9uL3JjDQorKysgYi9jb21tb24vcmMNCkBAIC0yMzEsOCArMjMx
LDggQEAgX3NjcmF0Y2hfbW91bnRfb3B0aW9ucygpDQogew0KICAgICAgICBfc2NyYXRjaF9vcHRp
b25zIG1vdW50DQoNCi0gICAgICAgZWNobyBgX2NvbW1vbl9kZXZfbW91bnRfb3B0aW9ucyAkKmAg
JFNDUkFUQ0hfT1BUSU9OUyBcDQotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgJFNDUkFUQ0hfREVWICRTQ1JBVENIX01OVA0KKyAgICAgICBlY2hvIGBfY29tbW9uX21vdW50
X29wdHNgICRTQ1JBVENIX09QVElPTlMgXA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICRTQ1JBVENIX0RFViAkU0NSQVRDSF9NTlQgJCoNCiB9DQoNCj4gDQo+IEZvciB0
aGF0IG1hdHRlciwgd2h5IGlzIFRNUEZTX01PVU5UX09QVElPTlMgbmVjZXNzYXJ5IGF0IGFsbD8g
IFNob3VsZG4ndA0KPiB0aGF0IHNpbXBseSBiZSAiTU9VTlRfT1BUSU9OUz08c3R1ZmY+IEZTVFlQ
PXRtcGZzIC4vY2hlY2siID8NCg0KVE1QRlNfTU9VTlRfT1BUSU9OUyBpcyB1c2VkIHRvIHNwZWNp
ZnkgbW91bnQgb3B0aW9ucyBpbiBlYWNoIHNlY3Rpb24gb2YgdGhlDQpjb25maWd1cmF0aW9uIGZp
bGUuIEZvciBleGFtcGxlLCB0aGUgZm9sbG93aW5nIHNuaXBwZXQgaXMgcGFydCBvZiBteSBjb25m
IGZpbGU6DQoNCmBgYA0KW3RtcGZzX25vc3dhcF9odWdlX2Fsd2F5c10NClRNUEZTX01PVU5UX09Q
VElPTlM9Ii1vIG5vc3dhcCxodWdlPWFsd2F5cyINCg0KW3RtcGZzX25vc3dhcF9odWdlX3dpdGhp
bl9zaXplXQ0KVE1QRlNfTU9VTlRfT1BUSU9OUz0iLW8gbm9zd2FwLGh1Z2U9d2l0aGluX3NpemUi
DQpgYGANCg0KVGhlbiBJIHJ1biAtcyBvcHRpb24gdG8gc3dpdGNoIGJldHdlZW4gcHJvZmlsZXMs
IGUuZy4sICdjaGVjayAtcw0KdG1wZnNfbm9zd2FwX2h1Z2Vfd2l0aGluX3NpemUgLVIgeHVuaXQg
LWcgYXV0bycuDQoNCknigJltIG5vdCBzdXJlIGlmIHRoaXMgYWRkcmVzc2VzIHlvdXIgcXVlc3Rp
b24uIFBsZWFzZSBsZXQgbWUga25vdyBpZiBJDQptaXN1bmRlcnN0b29kLg0KDQo+IA0KPiAtLUQN
Cj4gDQo+ID4gIH0NCj4gPiAgDQo+ID4gIF9zY3JhdGNoX21vdW50X29wdGlvbnMoKQ0KPiA+IC0t
IA0KPiA+IDIuNDMuMA0KPiA+IA==

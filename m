Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A322146D43
	for <fstests@vger.kernel.org>; Fri, 14 Jun 2024 06:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718346287; cv=none; b=XVKlUJY4jnQd0ZeF4UxHCDjWmPhL0dcPedq8JLlZs6YpuUdRAXS7XDtdh8e605FC13SL1dogW+d/eKzfvsgBG5scwt9G3G+kXe/Ma9fXbvOF949bsXeeohNisaD4+0my4XhrAKMPlaoN9l4o9+tA+SXpHS5KLFQKHdEXj59DjTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718346287; c=relaxed/simple;
	bh=abD9o9I3SKhwBo7MXu1vVbE+u3MS842rvOvrUcO8tXg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version:
	 References; b=TbcwonUMdMp6rIbUJ1WnYVZy+7gS3XxoBN9ZZd2b6AKf0+RZL6B8UtBhUSQS0Hng3bTyVzPnep8rMUuOLs6MDQvJMIoofCI9zt49aVexp/EXcbvysFnZVLiJe5gFvmvESI7+GGENVFxYYIFuZU7blgD4p9Kfd+ha54Xn6DlkuRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=I5rnzQ4b; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="I5rnzQ4b"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240614061727euoutp01961f05af2a8f5e43607899bf685b98cd~YynGZMeuI1698916989euoutp01V
	for <fstests@vger.kernel.org>; Fri, 14 Jun 2024 06:17:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240614061727euoutp01961f05af2a8f5e43607899bf685b98cd~YynGZMeuI1698916989euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718345847;
	bh=abD9o9I3SKhwBo7MXu1vVbE+u3MS842rvOvrUcO8tXg=;
	h=From:To:CC:Subject:Date:References:From;
	b=I5rnzQ4banux0Sdx/ZyUVnM0zDq/PL0ZAq46MfTC+X2hsRT+RpkC07PbGf6/0P/JP
	 JR68/vZO0D/acxFaycY1u/jL8sRDhgFcnR6shYJLGHqGESyQWYklRbkYMWzfxbHnN/
	 0eN1D3BCdSvWH0jxRZkaNWrh3Ch9mhdCFdK1jSZA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240614061726eucas1p19da76a811041d70ec6af96ca1ec1e8db~YynF6GCve0345403454eucas1p1b;
	Fri, 14 Jun 2024 06:17:26 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 3E.E9.09875.670EB666; Fri, 14
	Jun 2024 07:17:26 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240614061726eucas1p13b3cf24fce9d28ce29ee029224bf4378~YynFgugja3149731497eucas1p1h;
	Fri, 14 Jun 2024 06:17:26 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240614061726eusmtrp23b058ac07290c8e0c98639ad55d5fb82~YynFgLlr11975119751eusmtrp2V;
	Fri, 14 Jun 2024 06:17:26 +0000 (GMT)
X-AuditID: cbfec7f4-131ff70000002693-6a-666be0763ad0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 25.B7.08810.570EB666; Fri, 14
	Jun 2024 07:17:25 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240614061725eusmtip1f0b0f34f490a12244c42b09122de75c2~YynFRPizv2030820308eusmtip1h;
	Fri, 14 Jun 2024 06:17:25 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Fri, 14 Jun 2024 07:17:25 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
	([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Fri, 14 Jun
	2024 07:17:25 +0100
From: Daniel Gomez <da.gomez@samsung.com>
To: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
CC: Pankaj Raghav <p.raghav@samsung.com>, "mcgrof@kernel.org"
	<mcgrof@kernel.org>, "hughd@google.com" <hughd@google.com>, Daniel Gomez
	<da.gomez@samsung.com>
Subject: [PATCH 0/5] tmpfs fixes
Thread-Topic: [PATCH 0/5] tmpfs fixes
Thread-Index: AQHaviKFlboN2YFsI06i8D9G81wBrg==
Date: Fri, 14 Jun 2024 06:17:24 +0000
Message-ID: <20240614061722.1080-1-da.gomez@samsung.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="utf-8"
Content-ID: <3ADF470E724CF1428CAFF9ACE4032DBA@scsc.local>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42LZduznOd2yB9lpBse3SFucbtnLbvH0Ux+L
	xY0JTxkdmD0WbCr12LSqk83j8ya5AOYoLpuU1JzMstQifbsErozeBwdZCk6IVhycs52tgbFB
	tIuRk0NCwERixqQLzF2MXBxCAisYJZY8XM8K4XxhlHjQfgMq85lRovP9EzaYlvlbdrFBJJYz
	Sqx7/4oFrur/+h52COcMo8Te4xegylYyShx4MoERpJ9NQFNi38lN7CC2iIC5xOyOyWBFzAIL
	GSW+LXzGCpIQFlCQ2DT7LFSRqsT0G4+hbD2Jo4v6mUFsFqD4joszwep5BSwkznU9AzuQUUBW
	4tHKX2D1zALiEreezGeCOFxQYtHsPcwQtpjEv10PoR7SkTh7/QkjhG0gsXXpPhYIW1Gi49hN
	oBoOoDmaEut36UOMtJToOAKxihmoZEr3Q3aIEwQlTs58AtXazikx4ZwXhO0isXzdNai1whKv
	jm9hh7BlJP7vnM80gVF7FpJLZyFsm4Vk2ywk22Yh2baAkXUVo3hqaXFuemqxUV5quV5xYm5x
	aV66XnJ+7iZGYJI5/e/4lx2My1991DvEyMTBeIhRgoNZSYR31sKsNCHelMTKqtSi/Pii0pzU
	4kOM0hwsSuK8qinyqUIC6YklqdmpqQWpRTBZJg5OqQamHkY5UZPO+FfbFs6o/6Nz9+UVzdil
	F5dFH9cSL0h0z9G6wPP30TUZn20Hpziu3zxN/ukG29mZXROmp9Wr2jmmue7RyvryrqPKMLc6
	s+vqxflBFhd6i2PbHwjWznZaOcUoKP7sLMf1b5f/Vns+gS3iKetn/wq9n9p9k+5uvFtke3WL
	YE2Y8H33BGaTDxdr9v9MC+y5u9p+NsPLN20Rd/aERtlUPN1WW9mjd9j04aEzGZwHKpIecxy6
	c/0d280P2xm2JtVom+37e2fiDZvTkZednueoWygFBDcp/njHYvQps/zYUbX/d98YXzG74ij7
	+67igb6A3OK6HfZyIsesleesF+ub7VPC+tAu8XehidI8JZbijERDLeai4kQA6BLP/6EDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRmVeSWpSXmKPExsVy+t/xu7qlD7LTDG6221icbtnLbvH0Ux+L
	xY0JTxkdmD0WbCr12LSqk83j8ya5AOYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2Pz
	WCsjUyV9O5uU1JzMstQifbsEvYzeBwdZCk6IVhycs52tgbFBtIuRk0NCwERi/pZdbF2MXBxC
	AksZJbp7LzBBJGQkNn65ygphC0v8udYFVfSRUaJ54Qwo5wyjxI+la5kgnJWMEs/mnGIHaWET
	0JTYd3ITmC0iYC4xu2MyWAezwEJGiW8Ln4HNFRZQkNg0+yxUkarE9BuPoWw9iaOL+plBbBag
	+I6LM8HqeQUsJM51PWMDsRkFZCUerfwFVs8sIC5x68l8qLsFJJbsOc8MYYtKvHz8D+oHHYmz
	158wQtgGEluX7mOBsBUlOo7dBJrJATRHU2L9Ln2IkZYSHUcgVjEDlUzpfsgOcYKgxMmZT1gm
	MErNQrJ5FkL3LCTds5B0z0LSvYCRdRWjSGppcW56brGhXnFibnFpXrpecn7uJkZgQth27Ofm
	HYzzXn3UO8TIxMF4iFGCg1lJhHfWwqw0Id6UxMqq1KL8+KLSnNTiQ4ymwBCayCwlmpwPTEl5
	JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC6YklqdmpqQWpRTB9TBycUg1MJy0WNSoG2t8Q/7Hk
	0HImI+mvv7YsP7B4t3Inr/0pr59XtyfPSXNd9Ytn6cnpSw9FWrKuCVTYeueL2O9vHULnjvWf
	UToXrO5Qordw/ylp2wqjxrMZk69xlor7dTSz3ehPObuu6vfHx6+DS8oNmZhnl65cLjPbhc01
	enq+wGyWG74ftK5bNq07evq9tdiKR9o/Xf8tTUgUu3RIgl3F4377+UuF5/p7veXr3Vv8K+3O
	uLz/PmH7cUfWhdM1rWItKw8K/vG5vyR6Z+rMTc+Ob2rQCo90uCVmtc3iImcJ7yKXo/c+fmib
	uibh5KmHRULXaySsOJ0PeEsf+P5s4+Tyyf7V6y1YeGun51zo2WnVFDzJTImlOCPRUIu5qDgR
	ADto6qSRAwAA
X-CMS-MailID: 20240614061726eucas1p13b3cf24fce9d28ce29ee029224bf4378
X-Msg-Generator: CA
X-RootMTR: 20240614061726eucas1p13b3cf24fce9d28ce29ee029224bf4378
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240614061726eucas1p13b3cf24fce9d28ce29ee029224bf4378
References: <CGME20240614061726eucas1p13b3cf24fce9d28ce29ee029224bf4378@eucas1p1.samsung.com>

VGhpcyBzZXJpZXMgYWRkcmVzc2VzIHNvbWUgbWlub3IgaXNzdWVzIGZvdW5kIGluIHRtcGZzIEZT
UUEgc3VpdCB0ZXN0IGNhc2UuDQoNClRoZSBsYXN0IHBhdGNoIGFkZHMgaW5mb3JtYXRpb24gYWJv
dXQgbWtmcyBhbmQgbW91bnQgb3B0aW9ucyBmb3IgVEVTVCBhbmQNClNDUkFUQ0ggZGV2aWNlcy4g
VGhpcyBpcyBpbXBvcnRhbnQgdG8gY2xhcmlmeSBlc3BlY2lhbGx5IGlmIFJFQ1JFQVRFX1RFU1Rf
REVWDQppcyBkaXNhYmxlZCAod2hpY2ggaXMgdGhlIGRlZmF1bHQgY2FzZSkuIFRoZSBuZXcgb3V0
cHV0IHdpbGwgbG9vayBsaWtlIHRoZQ0KZm9sbG93aW5nOg0KDQpTRUNUSU9OICAgICAgIC0tIHRt
cGZzX25vc3dhcF9odWdlX2Fsd2F5cw0KUkVDUkVBVElORyAgICAtLSB0bXBmcyBvbiAvbWVkaWEv
dGVzdA0KRlNUWVAgICAgICAgICAtLSB0bXBmcw0KUExBVEZPUk0gICAgICAtLSBMaW51eC9hYXJj
aDY0IGxvY2FsaG9zdCA2LjEwLjAtcmMzLWRnYyAjNiBTTVAgVGh1IEp1biAxMyAyMjo0ODo0NiBD
RVNUIDIwMjQNClRFU1QgZGV2aWNlOg0KTUtGU19PUFRJT05TICAtLSAvbWVkaWEvdGVzdA0KTU9V
TlRfT1BUSU9OUyAtLSAtbyBzaXplPTFHIC9tZWRpYS90ZXN0IC9tZWRpYS90ZXN0DQpTQ1JBVENI
IGRldmljZToNCk1LRlNfT1BUSU9OUyAgLS0gL21lZGlhL3NjcmF0Y2gNCk1PVU5UX09QVElPTlMg
LS0gLW8gc2l6ZT0xRyAtbyBub3N3YXAsaHVnZT1hbHdheXMgL21lZGlhL3NjcmF0Y2ggL21lZGlh
L3NjcmF0Y2gNCg0KUmVnYXJkaW5nICRUTVBGU19NT1VOVF9PUFRJT05TLCB3aGVuIGl0IGlzIGRl
ZmluZWQgaW4gdGhlIFtkZWZhdWx0XSBzZWN0aW9uIG9mDQphIGNvbmZpZ3VyYXRpb24gZmlsZSwg
dGhlIG1vdW50IG9wdGlvbnMgc3BlY2lmaWVkIHRoZXJlIHdpbGwgYmUgcHJlZml4ZWQgdG8gdGhl
DQp0ZXN0IHNlY3Rpb24gb3B0aW9ucy4gSXMgdGhpcyB0aGUgY29ycmVjdCBhbmQgZXhwZWN0ZWQg
YmVoYXZpb3VyPw0KDQpFeGFtcGxlOg0KDQpgYGBsb2NhbGhvc3QuY29uZmlnDQpbZGVmYXVsdF0N
CkZTVFlQPXRtcGZzDQpURVNUX0RJUj0vbWVkaWEvdGVzdA0KU0NSQVRDSF9NTlQ9L21lZGlhL3Nj
cmF0Y2gNClNDUkFUQ0hfREVWPS9tZWRpYS9zY3JhdGNoDQpSRVNVTFRfQkFTRT0kUFdEL3Jlc3Vs
dHMvJEhPU1QvJCh1bmFtZSAtcikNClRFU1RfREVWPS9tZWRpYS90ZXN0DQpDQU5PTl9ERVZTPXll
cw0KVE1QRlNfTU9VTlRfT1BUSU9OUz0iLW8gc2l6ZT0zRyINCg0KW3RtcGZzX25vc3dhcF9odWdl
X2Fsd2F5c10NClRNUEZTX01PVU5UX09QVElPTlM9Ii1vIG5vc3dhcCxodWdlPWFsd2F5cyINCmBg
YA0KDQpOb3RlOiBUaGUgYWJvdmUgY29uZmlnIHdvdWxkIHJlc3VsdCBpbiAnLW8gc2l6ZT0xRyAt
byBzaXplPTNHIC1vDQpub3N3YXAsaHVnZT1hbHdheXMnIGF0IG1vdW50IHRpbWUgZm9yIHRtcGZz
X25vc3dhcF9odWdlX2Fsd2F5cyBzZWN0aW9uLiBUaGUgJy1vDQpzaXplPTFHJyBpcyBhIGhhcmRj
b2RlZCBwcmVmaXggbW91bnQgb3B0aW9uLg0KDQpEYW5pZWwNCg0KRGFuaWVsIEdvbWV6ICg0KToN
CiAgY29tbW9uL2NvbmZpZzogZml4IFJFQ1JFQVRFX1RFU1RfREVWIGluaXRpYWxpemF0aW9uDQog
IGNvbW1vbi9yYzogYWRkIHJlY3JlYXRpb24gc3VwcG9ydCBmb3IgdG1wZnMNCiAgY29tbW9uL3Jj
OiBmaXggc2NyYXRjaCBtb3VudCBvcHRpb25zIGZvciB0bXBmcw0KICBjb21tb24vcmM6IHByaW50
IHNjcmF0Y2ggYW5kIHRlc3QgbW91bnQgb3B0aW9ucw0KDQpIdWdoIERpY2tpbnMgKDEpOg0KICBn
ZW5lcmljLzQ0OTogbm90IHJ1biBvbiB0bXBmcyBlYXJsaWVyDQoNCiBjaGVjayAgICAgICAgICAg
ICB8ICA0ICsrKysNCiBjb21tb24vY29uZmlnICAgICB8ICAyICstDQogY29tbW9uL3JjICAgICAg
ICAgfCAyNSArKysrKysrKysrKysrKysrKysrKysrLS0tDQogdGVzdHMvZ2VuZXJpYy80NDkgfCAg
NiArKysrKysNCiA0IGZpbGVzIGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pDQoNCi0tIA0KMi40My4wDQo=

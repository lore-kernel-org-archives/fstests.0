Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246158F7D
	for <fstests@vger.kernel.org>; Tue,  2 Apr 2024 01:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712022120; cv=none; b=tMPtoAAWVVl4iASkJuvh5BlWmayGqOppe+5IyvgSapVUeheZ94uUSzF5X1k2LqwOWRsyGEVMuLqooNW9InYxUcmrQvLWLoFSfbzZryJDsE2UnbjgPUEBDoIgfBBk/04jrtEbQ+dFwOw+NqMnDwJzW08ZKr9o13SkAwcZ/ZWo/wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712022120; c=relaxed/simple;
	bh=Kw1f9IAsu9W/V3TWhK2Rcj/wjH1q8AwzjofxOHjMHL8=;
	h=Date:From:To:Subject:Content-Type:MIME-Version:Message-ID; b=hkJy1PgCzWa9Ga8o+vIrFez1vuvAYyzSEzeKMjyo+D/ptQJbzj39iAV+SVV70BzEznccwCqGfkBvReWrxv7nisbNYuYCk9qOAvFQ3kG6dQ0CJtlajFxOQL0ffuZ/ty9Hz3Y3SBPpWP+ss9N/KA6lebgVGzR/LAsL9vi8yhvUI4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=URA9ovIU; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="URA9ovIU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=PG7z8cCBpshHp1VKSqm7SXSC9HrYP7fIxx8ytzygNYI=; b=U
	RA9ovIU56weT8EB2MRvmTrq0eXyYMaNWRYFjzX1xVk3W3hoom6HIf31yG4axtUiq
	eVn1AkYoT52ASrJ4JAG6pYlQg8Dk2ql/OMQF7Nx1ovXvH2Qf/KiWc8MJBdb7QA81
	gdXH9tQnM/Ze1CIb7rrCpaz9mOHrEAd5ove8spr0uc=
Received: from caixiaobin0807$163.com ( [121.8.166.34] ) by
 ajax-webmail-wmsvr-40-113 (Coremail) ; Tue, 2 Apr 2024 09:41:49 +0800 (CST)
Date: Tue, 2 Apr 2024 09:41:49 +0800 (CST)
From: =?UTF-8?B?6JSh5pmT5paM?= <caixiaobin0807@163.com>
To: fstests@vger.kernel.org
Subject: about the format problem at generic/556, and supply a fix patch
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
X-NTES-SC: AL_Qu2aAPyZvUkr7yefY+lS+TNp0o1WAZrw5qd9m/YQdt4emADc/RgfXn1HA2vz0uIRgpFyFtB6y1nKYQVk7q1h
Content-Type: multipart/mixed; 
	boundary="----=_Part_34368_563218519.1712022109784"
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5c043f11.244a.18e9c783e59.Coremail.caixiaobin0807@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3nw9dYgtm1EcgAA--.42162W
X-CM-SenderInfo: xfdl5xpdrex0iqyqlqqrwthudrp/1tbiqBq0XWVODI2dLAAHsH
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

------=_Part_34368_563218519.1712022109784
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

CkhpLCB3aGVuIEkgdGVzdCBteSBwcm9qZWN0IHdpdGggeGZzdGVzdHMsIEkgZm91bmQgdGhhdMKg
Zm9ybWF0IHByb2JsZW0gYXQgZ2VuZXJpYy81NTYsIGl0IGxvb2tzIG5vIGxpa2UgYSBzY3JpcHQs
IHNvIEkgYWRqdXN0IGZvcm1hdCBhbmQgbG9vayBzbyB3ZWxsLgoKCkJlbG93IGlzIHRoZSBjb25j
ZW50IG9mIHRoZSBwYXRjaCwgYW5kIHBhdGNoIGZpbGUgYXTCoGF0dGFjaG1lbnRzOgoKCgpGcm9t
IDQwZmY3NTNmZmIzZGQ0YWI4Nzg5Njk5ZGM0NWE4M2VjZTY0YTM2MjYgTW9uIFNlcCAxNyAwMDow
MDowMCAyMDAxCkZyb206ICJjYWkueGlhb2JpbiIgPGNhaS54aWFvYmluQGdkLWxpbnV4LmNvbT4K
RGF0ZTogV2VkLCAyMCBNYXIgMjAyNCAxMToxMzoyOSArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGdl
bmVyaWMvNTU2OiByZXZlcnNlIHRoZSBvcmRlciBvZiBjb21tZW50cyB0byBtYWtlIHRoZSBmaWxl
CsKgbG9vayBtb3JlIGxpa2UgYSBzY3JpcHQgZmlsZQoKCi0tLQrCoHRlc3RzL2dlbmVyaWMvNTU2
IHwgMiArLQrCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoK
CmRpZmYgLS1naXQgYS90ZXN0cy9nZW5lcmljLzU1NiBiL3Rlc3RzL2dlbmVyaWMvNTU2CmluZGV4
IDQwNGEzMjQzLi5jY2VmYmNjNCAxMDA3NTUKLS0tIGEvdGVzdHMvZ2VuZXJpYy81NTYKKysrIGIv
dGVzdHMvZ2VuZXJpYy81NTYKQEAgLTEsNSArMSw1IEBACi0jIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiBHUEwtMi4wKwrCoCMhL2Jpbi9iYXNoCisjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBH
UEwtMi4wKwrCoCMgRlMgUUEgVGVzdCBOby4gNTU2CsKgIwrCoCMgVGVzdCB0aGUgYmFzaWMgZnVu
Y3Rpb25hbGl0eSBvZiBmaWxlc3lzdGVtcyB3aXRoIGNhc2UtaW5zZW5zaXRpdmUKLS3CoAoyLjI1
LjEKCgpUaGFuayB5b3UgYW5kIGxvb2tpbmcgZm9yd2FyZCB0byB5b3VyIHJlcGx5Lg==
------=_Part_34368_563218519.1712022109784
Content-Type: application/octet-stream; 
	name=0001-generic-556-reverse-the-order-of-comments-to-make-th.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-generic-556-reverse-the-order-of-comments-to-make-th.patch"

RnJvbSA0MGZmNzUzZmZiM2RkNGFiODc4OTY5OWRjNDVhODNlY2U2NGEzNjI2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiY2FpLnhpYW9iaW4iIDxjYWkueGlhb2JpbkBnZC1saW51eC5j
b20+CkRhdGU6IFdlZCwgMjAgTWFyIDIwMjQgMTE6MTM6MjkgKzA4MDAKU3ViamVjdDogW1BBVENI
XSBnZW5lcmljLzU1NjogcmV2ZXJzZSB0aGUgb3JkZXIgb2YgY29tbWVudHMgdG8gbWFrZSB0aGUg
ZmlsZQogbG9vayBtb3JlIGxpa2UgYSBzY3JpcHQgZmlsZQoKLS0tCiB0ZXN0cy9nZW5lcmljLzU1
NiB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoK
ZGlmZiAtLWdpdCBhL3Rlc3RzL2dlbmVyaWMvNTU2IGIvdGVzdHMvZ2VuZXJpYy81NTYKaW5kZXgg
NDA0YTMyNDMuLmNjZWZiY2M0IDEwMDc1NQotLS0gYS90ZXN0cy9nZW5lcmljLzU1NgorKysgYi90
ZXN0cy9nZW5lcmljLzU1NgpAQCAtMSw1ICsxLDUgQEAKLSMgU1BEWC1MaWNlbnNlLUlkZW50aWZp
ZXI6IEdQTC0yLjArCiAjIS9iaW4vYmFzaAorIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BM
LTIuMCsKICMgRlMgUUEgVGVzdCBOby4gNTU2CiAjCiAjIFRlc3QgdGhlIGJhc2ljIGZ1bmN0aW9u
YWxpdHkgb2YgZmlsZXN5c3RlbXMgd2l0aCBjYXNlLWluc2Vuc2l0aXZlCi0tIAoyLjI1LjEKCg==

------=_Part_34368_563218519.1712022109784--


Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D52B1849
	for <fstests@vger.kernel.org>; Sun,  7 Apr 2024 02:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712455872; cv=none; b=tmhFmX0ViXtHThKr4oCkB34MevSD3GnTAmzZDzBCzH4hBIuJo7fT4GuYWkspSiof+oNRHD9mkyTuwfQOllBotwtwmv5bWdw22qSjPqtdRv3wjxU9+1YXEGkyzXZfqxFmyeYGBOz4Gcor85rTjgVVfjpxikfrDQ5+jrXBcVMII9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712455872; c=relaxed/simple;
	bh=GxY7eYkJr9RZ1DZGwW/V4OynEDM7eAV7DyMyEWb3J/4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=FhlUdmaYkC8NSfITX8P83OMVlCHrpnlnMkeKTJ7gWAdAoOLe6eodFm4oS+FfNB6x+3cxUln7WAuNCOCkYW5VuWns3DXx1QA5iXo3qbsigPLA5rTs9Dfz2WCF8miAEwiGSJfsNcW2e/alrY2G5p/jwck9FGlgxAXtrjt4vCxjFOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FhApBXS+; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FhApBXS+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=bIgUTGHZDQY3snmoFMwAZdHdTXz56ZtM8+pZ9HH26PE=; b=F
	hApBXS+vGswpTHbNd6ElMHI0m15NR+MD0M1yH4Ogpm8UUfM2RLyXknTe1DpBgQLm
	8lY8eYyFpCrG8OTyGJWkrId88z2Tm1+wfaPlKkJ3twXoT4B2TfMDD1IVUQXlaaHO
	aGvdLM6ujagpBswrGKikjWIDDRKKQtIEP2mvNalmPs=
Received: from caixiaobin0807$163.com ( [121.8.166.34] ) by
 ajax-webmail-wmsvr-40-113 (Coremail) ; Sun, 7 Apr 2024 10:10:34 +0800 (CST)
Date: Sun, 7 Apr 2024 10:10:34 +0800 (CST)
From: =?GBK?B?sszP/rHz?= <caixiaobin0807@163.com>
To: "Zorro Lang" <zlang@redhat.com>
Cc: fstests@vger.kernel.org
Subject: Re:Re: Re: about the format problem at generic/556, and supply a
 fix patch
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <20240403105445.qqzzah7b5usx4cwf@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <5c043f11.244a.18e9c783e59.Coremail.caixiaobin0807@163.com>
 <20240402155135.156ab20a@echidna>
 <13624bfb.869c.18e9d78f712.Coremail.caixiaobin0807@163.com>
 <20240403105445.qqzzah7b5usx4cwf@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
X-NTES-SC: AL_Qu2aAPieukAo4iGbbOlS+TNp0o1WAZrw5qd9m/YQdt4emADc/RgfXn1HA2vz0uInX7Vw9CkI7T9pgBfPmZ6t
Content-Type: multipart/mixed; 
	boundary="----=_Part_44311_946111732.1712455834148"
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <24c3e367.2ec8.18eb6525a25.Coremail.caixiaobin0807@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3v4qaABJmlhUCAA--.2110W
X-CM-SenderInfo: xfdl5xpdrex0iqyqlqqrwthudrp/1tbiqBS4XWVODNsUIAADsS
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

------=_Part_44311_946111732.1712455834148
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

CkF0IDIwMjQtMDQtMDMgMTg6NTQ6NDUsICJab3JybyBMYW5nIiA8emxhbmdAcmVkaGF0LmNvbT4g
d3JvdGU6Cj5PbiBUdWUsIEFwciAwMiwgMjAyNCBhdCAwMjoyMjoxNFBNICswODAwLCCyzM/+sfMg
d3JvdGU6Cj4+IAo+Cj5Mb29rcyBsaWtlIHRoZXJlJ3JlIG1hbnkgc3BlY2lhbCBjaGFyYWN0ZXJz
IGluIHRoaXMgcGF0Y2gsIHBsZWFzZSBzZW5kIGEKPm5vcm1hbCAicHVyZSB0ZXh0IiBwYXRjaCwg
d2l0aCBhIHByb3BlciBzdWJqZWN0IGFuZCBjb21taXQgbG9nLiAKCj4KVGhlIGNvbnRlbnQgb2Yg
cGF0Y2ggYXMgYmVsb3cgYW5kIHNlZSBhdHRhY2htZW50IGZvciB0aGUgZmlsZS4KCkZyb20gZWRm
NzRkNjBhODM1NTRhZDJjODVhODZhYjAzMjc2N2VhZmU3NWE5ZSBNb24gU2VwIDE3IDAwOjAwOjAw
IDIwMDEKRnJvbTogY3owODA3YmluIDxjYWl4aWFvYmluMDgwN0AxNjMuY29tPgpEYXRlOiBTdW4s
IDcgQXByIDIwMjQgMDk6NDc6MjAgKzA4MDAKU3ViamVjdDogW1BBVENIXSBnZW5lcmljLzU1Njog
bW92ZSBzaGViYW5nIHRvIGZpcnN0IGxpbmUuCgpUaGVyZSBpcyBmb3JtYXQgcHJvYmxlbSBvZiB0
ZXN0cy9nZW5lcmljLzU1NiBmaWxlIGFuZCBsb29rcyBub3QgbGlrZSBhIHNjcmlwdCB3aGVuIGl0
IHJ1bi4KU28gbWFrZXMgYSBjaGFuZ2Ugb2Ygb3JkZXIgb2YgZmlyc3QgbGluZSB0byBsb29rcyB3
ZWxsLgotLS0KIHRlc3RzL2dlbmVyaWMvNTU2IHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdHMvZ2VuZXJpYy81NTYg
Yi90ZXN0cy9nZW5lcmljLzU1NgppbmRleCA0MDRhMzI0My4uY2NlZmJjYzQgMTAwNzU1Ci0tLSBh
L3Rlc3RzL2dlbmVyaWMvNTU2CisrKyBiL3Rlc3RzL2dlbmVyaWMvNTU2CkBAIC0xLDUgKzEsNSBA
QAotIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCsKICMhL2Jpbi9iYXNoCisjIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wKwogIyBGUyBRQSBUZXN0IE5vLiA1NTYKICMK
ICMgVGVzdCB0aGUgYmFzaWMgZnVuY3Rpb25hbGl0eSBvZiBmaWxlc3lzdGVtcyB3aXRoIGNhc2Ut
aW5zZW5zaXRpdmUKLS0gCjIuMjUuMQoKSWYgdGhlcmUgaXMgYW55IHF1ZXN0aW9uIGFib3V0IHRo
ZSBwYXRjaCwgcGxlYXNlIHRlbGwgbWUgaG93IHRvIGRvLCBhbmQgSSB3aWxsIGZpeCBpdC4KVGhh
bmsgeW91IGZvciByZXBseS4=
------=_Part_44311_946111732.1712455834148
Content-Type: application/octet-stream; 
	name=0001-generic-556-move-shebang-to-first-line.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-generic-556-move-shebang-to-first-line.patch"

RnJvbSBlZGY3NGQ2MGE4MzU1NGFkMmM4NWE4NmFiMDMyNzY3ZWFmZTc1YTllIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBjejA4MDdiaW4gPGNhaXhpYW9iaW4wODA3QDE2My5jb20+CkRh
dGU6IFN1biwgNyBBcHIgMjAyNCAwOTo0NzoyMCArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGdlbmVy
aWMvNTU2OiBtb3ZlIHNoZWJhbmcgdG8gZmlyc3QgbGluZS4KClRoZXJlIGlzIGZvcm1hdCBwcm9i
bGVtIG9mIHRlc3RzL2dlbmVyaWMvNTU2IGZpbGUgYW5kIGxvb2tzIG5vdCBsaWtlIGEgc2NyaXB0
IHdoZW4gaXQgcnVuLgpTbyBtYWtlcyBhIGNoYW5nZSBvZiBvcmRlciBvZiBmaXJzdCBsaW5lIHRv
IGxvb2tzIHdlbGwuCi0tLQogdGVzdHMvZ2VuZXJpYy81NTYgfCAyICstCiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS90ZXN0cy9nZW5l
cmljLzU1NiBiL3Rlc3RzL2dlbmVyaWMvNTU2CmluZGV4IDQwNGEzMjQzLi5jY2VmYmNjNCAxMDA3
NTUKLS0tIGEvdGVzdHMvZ2VuZXJpYy81NTYKKysrIGIvdGVzdHMvZ2VuZXJpYy81NTYKQEAgLTEs
NSArMSw1IEBACi0jIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wKwogIyEvYmluL2Jh
c2gKKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjArCiAjIEZTIFFBIFRlc3QgTm8u
IDU1NgogIwogIyBUZXN0IHRoZSBiYXNpYyBmdW5jdGlvbmFsaXR5IG9mIGZpbGVzeXN0ZW1zIHdp
dGggY2FzZS1pbnNlbnNpdGl2ZQotLSAKMi4yNS4xCgo=
------=_Part_44311_946111732.1712455834148--


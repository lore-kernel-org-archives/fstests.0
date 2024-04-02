Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245F7219FF
	for <fstests@vger.kernel.org>; Tue,  2 Apr 2024 06:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712038948; cv=none; b=Piz6KLOT7ivTMM4SwFfJrT1jCdUUVK6udT9ovPVsIPFu5AqvIkoTEibSQWNRztXPgqtnhW3o8De7Fqnznk5xsLDHX1lx0FSlQGvfZw+zSz10Hg7Ru4ZBAf+oQuLNan5txS/ryD3NUXglPXG8CagNzlas72jcxbccx/WfW42i6nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712038948; c=relaxed/simple;
	bh=6rQEP3gluiYtZqoU6rZKIiEWzDiOSBtElmRErmiumII=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=MRzrTFzh188A+i7n0YfozGad2CJwzzozyelKIrYnvE4fGhqfkv04rJbSgheQGGpHkmAtJhhM95owXjt16TY0vItzs+antzgn3JB5Ep57pRO0Sd3q9kpuPhKBUj7mNNMyQbrsaafiT3z2kT/K2o8i5B9GLNMRpV33dbUcGsj10LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=AISXnR+k reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="AISXnR+k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=AZ7YmKmQqv6asCMYtAG4paF9HO933iKRGoC9nCRznnw=; b=A
	ISXnR+kIDdNYq07SGrzOgHVE9yn44QmM2kpvJkhVSF54LPlDMu7XiYvMaTk1xz6n
	By3sD5FwbFlk2v23KHlSsGy6hIeYnJWuGenT21sNN038MIs5bwuiXPBHfX4OtW6A
	Q20kQj1DQ0BzVrApA33OaMIRRxe/bNqyf1GR7WmnwI=
Received: from caixiaobin0807$163.com ( [121.8.166.34] ) by
 ajax-webmail-wmsvr-40-113 (Coremail) ; Tue, 2 Apr 2024 14:22:14 +0800 (CST)
Date: Tue, 2 Apr 2024 14:22:14 +0800 (CST)
From: =?UTF-8?B?6JSh5pmT5paM?= <caixiaobin0807@163.com>
To: "David Disseldorp" <ddiss@suse.de>
Cc: fstests@vger.kernel.org
Subject: Re:Re: about the format problem at generic/556, and supply a fix
 patch
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <20240402155135.156ab20a@echidna>
References: <5c043f11.244a.18e9c783e59.Coremail.caixiaobin0807@163.com>
 <20240402155135.156ab20a@echidna>
X-NTES-SC: AL_Qu2aAPyYt0Eo4iKQZulS+TNp0o1WAZrw5qd9m/YQdt4emADc/RgfXn1HA2vz0uIVLwoDNaCZE41M88B6M5Yp
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <13624bfb.869c.18e9d78f712.Coremail.caixiaobin0807@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3H40WpAtmrHwlAA--.1671W
X-CM-SenderInfo: xfdl5xpdrex0iqyqlqqrwthudrp/xtbB0hO0XWWXw6rIlgADsu
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKQXQgMjAyNC0wNC0wMiAxMjo1MTozNSwgIkRhdmlkIERpc3NlbGRvcnAiIDxkZGlzc0BzdXNl
LmRlPiB3cm90ZToKPkhpLAo+Cj5PbiBUdWUsIDIgQXByIDIwMjQgMDk6NDE6NDkgKzA4MDAgKENT
VCksIOiUoeaZk+aWjCB3cm90ZToKPi4uLgo+PiBGcm9tIDQwZmY3NTNmZmIzZGQ0YWI4Nzg5Njk5
ZGM0NWE4M2VjZTY0YTM2MjYgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxCj4+IEZyb206ICJjYWku
eGlhb2JpbiIgPGNhaS54aWFvYmluQGdkLWxpbnV4LmNvbT4KPj4gRGF0ZTogV2VkLCAyMCBNYXIg
MjAyNCAxMToxMzoyOSArMDgwMAo+PiBTdWJqZWN0OiBbUEFUQ0hdIGdlbmVyaWMvNTU2OiByZXZl
cnNlIHRoZSBvcmRlciBvZiBjb21tZW50cyB0byBtYWtlIHRoZSBmaWxlCj4+IMKgbG9vayBtb3Jl
IGxpa2UgYSBzY3JpcHQgZmlsZQo+PiAKPj4gCj4+IC0tLQo+PiDCoHRlc3RzL2dlbmVyaWMvNTU2
IHwgMiArLQo+PiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQo+PiAKPj4gCj4+IGRpZmYgLS1naXQgYS90ZXN0cy9nZW5lcmljLzU1NiBiL3Rlc3RzL2dlbmVy
aWMvNTU2Cj4+IGluZGV4IDQwNGEzMjQzLi5jY2VmYmNjNCAxMDA3NTUKPj4gLS0tIGEvdGVzdHMv
Z2VuZXJpYy81NTYKPj4gKysrIGIvdGVzdHMvZ2VuZXJpYy81NTYKPj4gQEAgLTEsNSArMSw1IEBA
Cj4+IC0jIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wKwo+PiDCoCMhL2Jpbi9iYXNo
Cj4+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wKwo+PiDCoCMgRlMgUUEgVGVz
dCBOby4gNTU2Cj4+IMKgIwo+PiDCoCMgVGVzdCB0aGUgYmFzaWMgZnVuY3Rpb25hbGl0eSBvZiBm
aWxlc3lzdGVtcyB3aXRoIGNhc2UtaW5zZW5zaXRpdmUKPgo+TG9va3MgZmluZSB0byBtZSwgYWx0
aG91Z2ggSSdkIHN1Z2dlc3QgYSBzaW1wbGVyIHBhdGNoIGRlc2NyaXB0aW9uOgo+ICBnZW5lcmlj
LzU1NjogbW92ZSBzaGViYW5nIHRvIGZpcnN0IGxpbmUKCj4KPlJldmlld2VkLWJ5OiBEYXZpZCBE
aXNzZWxkb3JwIDxkZGlzc0BzdXNlLmRlPgoKCldvdywgeW91ciBzdWdnZXN0aW9uIGlzIGdvb2Qu
IERvIEkgbmVlZCB0byBwcm92aWRlIGFub3RoZXIgcGF0Y2ggd2l0aCBhIGNvcnJlY3Rpb24gY29t
bWl0PwpUaGFuayB5b3UgZm9yIHlvdXIgcmVwbHku

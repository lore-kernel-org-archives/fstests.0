Received: from m4a0041g.houston.softwaregrp.com ([15.124.2.87]:52465 "EHLO
        m4a0041g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726725AbfHGJdf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 7 Aug 2019 05:33:35 -0400
Received: FROM m4a0041g.houston.softwaregrp.com (15.120.17.146) BY m4a0041g.houston.softwaregrp.com WITH ESMTP
 FOR fstests@vger.kernel.org;
 Wed,  7 Aug 2019 09:33:26 +0000
From: Yong Sun <YoSun@suse.com>
Subject: [PATCH] xfs/097: Add suitable metadata options in mkfs when test
 finobt
Date: Wed, 7 Aug 2019 09:21:27 +0000
Message-ID: <6032f83fcdfc4291875b07a8ee4cac52MN2PR18MB3437AD56AD6901531FEF5626DBD40@MN2PR18MB3437.namprd18.prod.outlook.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="gb2312"
Content-ID: <D3F04729517FE24B8CAD5D8EF65F164D@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

SGkgYWxsLAoKV2hlbiB0ZXN0IHhmcy8wOTcgaW4gbXkgdGVzdCBtYWNoaW5lLCBpdCBhbHdheXMg
c2tpcHMgYW5kIHByaW50ICJbbm90IHJ1bl0gZmlub2J0IG5vdCBlbmFibGVkIi4gSSBhZGQgb25l
IGxpbmUgY2hhbmdlLCBhbmQgdGhpcyB0ZXN0IGNvdWxkIHJ1bnMgT0suCgoKU2lnbmVkLW9mZi1i
eTogWW9uZyBTdW4gPHlvc3VuQHN1c2UuY29tPgotLS0KIHRlc3RzL3hmcy8wOTcgfCAyICstCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQg
YS90ZXN0cy94ZnMvMDk3IGIvdGVzdHMveGZzLzA5NwppbmRleCA2OGVhZTFkNC4uMWNiN2Q2OWMg
MTAwNzU1Ci0tLSBhL3Rlc3RzL3hmcy8wOTcKKysrIGIvdGVzdHMveGZzLzA5NwpAQCAtNDYsNyAr
NDYsNyBAQCBURVNURElSPSIke1NDUkFUQ0hfTU5UfS9zY3JhdGNoZGlyIgogVEVTVEZJTEU9IiR7
VEVTVERJUn0vdGVzdGZpbGUiCgogZWNobyAiKyBjcmVhdGUgc2NyYXRjaCBmcyIKLV9zY3JhdGNo
X21rZnNfeGZzID4gL2Rldi9udWxsCitfc2NyYXRjaF9ta2ZzX3hmcyAtbSBjcmM9MSxmaW5vYnQ9
MSA+IC9kZXYvbnVsbAoKIGVjaG8gIisgbW91bnQgZnMgaW1hZ2UiCiBfc2NyYXRjaF9tb3VudAot
LSAKMi4yMS4w

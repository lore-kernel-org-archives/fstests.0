Received: from mail-eopbgr740119.outbound.protection.outlook.com ([40.107.74.119]:49984
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726587AbfEaN2R (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 31 May 2019 09:28:17 -0400
From: Tom Talpey <ttalpey@microsoft.com>
Subject: RE: NFS & CIFS support dedupe now?? Was: Re: [PATCH] generic/517:
 notrun on NFS due to unaligned dedupe in test
Date: Fri, 31 May 2019 13:28:12 +0000
Message-ID: <CY4PR21MB0149348B4B4049D9C87BAA39A0190@CY4PR21MB0149.namprd21.prod.outlook.com>
References: <20190530094147.14512-1-xzhou@redhat.com>
 <20190530152606.GA5383@magnolia> <20190530155851.GB5383@magnolia>
 <87woi6yk53.fsf@suse.com>
In-Reply-To: <87woi6yk53.fsf@suse.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: =?utf-8?B?QXVyw6lsaWVuIEFwdGVs?= <aaptel@suse.com>, "Darrick J. Wong" <darrick.wong@oracle.com>, "sfrench@samba.org" <sfrench@samba.org>, "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>, "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>, "fengxiaoli0714@gmail.com" <fengxiaoli0714@gmail.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>, Murphy Zhou <xzhou@redhat.com>, "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>, "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1jaWZzLW93bmVyQHZn
ZXIua2VybmVsLm9yZyA8bGludXgtY2lmcy1vd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uDQo+IEJl
aGFsZiBPZiBBdXLDqWxpZW4gQXB0ZWwNCj4gU2VudDogRnJpZGF5LCBNYXkgMzEsIDIwMTkgNjo0
OSBBTQ0KPiBUbzogRGFycmljayBKLiBXb25nIDxkYXJyaWNrLndvbmdAb3JhY2xlLmNvbT47IHNm
cmVuY2hAc2FtYmEub3JnOw0KPiBhbm5hLnNjaHVtYWtlckBuZXRhcHAuY29tOyB0cm9uZC5teWts
ZWJ1c3RAaGFtbWVyc3BhY2UuY29tOw0KPiBmZW5neGlhb2xpMDcxNEBnbWFpbC5jb20NCj4gQ2M6
IGZzdGVzdHNAdmdlci5rZXJuZWwub3JnOyBNdXJwaHkgWmhvdSA8eHpob3VAcmVkaGF0LmNvbT47
IGxpbnV4LQ0KPiBjaWZzQHZnZXIua2VybmVsLm9yZzsgbGludXgtbmZzQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtZnNkZXZlbCA8bGludXgtDQo+IGZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg0KPiBT
dWJqZWN0OiBSZTogTkZTICYgQ0lGUyBzdXBwb3J0IGRlZHVwZSBub3c/PyBXYXM6IFJlOiBbUEFU
Q0hdIGdlbmVyaWMvNTE3Og0KPiBub3RydW4gb24gTkZTIGR1ZSB0byB1bmFsaWduZWQgZGVkdXBl
IGluIHRlc3QNCj4gDQo+ICJEYXJyaWNrIEouIFdvbmciIDxkYXJyaWNrLndvbmdAb3JhY2xlLmNv
bT4gd3JpdGVzOg0KPiA+IChOb3Qgc3VyZSBhYm91dCBjaWZzLCBzaW5jZSBJIGRvbid0IGhhdmUg
YSBXaW5kb3dzIFNlcnZlciBoYW5keSkNCj4gPg0KPiA+IEknbSBub3QgYW4gZXhwZXJ0IGluIENJ
RlMgb3IgTkZTLCBzbyBJJ20gYXNraW5nOiBkbyBlaXRoZXIgc3VwcG9ydA0KPiA+IGRlZHVwZSBv
ciBpcyB0aGlzIGEga2VybmVsIGJ1Zz8NCj4gDQo+IEFGQUlLLCB0aGUgU01CIHByb3RvY29sIGhh
cyAyIGlvY3RsIHRvIGRvIHNlcnZlciBzaWRlIGNvcGllczoNCj4gLSBGU0NUTF9TUlZfQ09QWUNI
VU5LIFsxXSBnZW5lcmljDQo+IC0gRlNDVExfRFVQTElDQVRFX0VYVEVOVFNfVE9fRklMRSBbMl0s
IG9ubHkgc3VwcG9ydGVkIG9uIHdpbmRvd3MgIm5ldyINCj4gQ29XDQo+ICAgZmlsZXN5c3RlbSBS
ZUZTDQoNCldpbmRvd3MgYWxzbyBzdXBwb3J0cyB0aGUgVDEwIGNvcHkgb2ZmbG9hZCwgd2hlbiB0
aGUgYmFja2VuZCBzdG9yYWdlIChlLmcuIGEgU0FOKSBzdXBwb3J0cyBpdC4NCg0KVGhlcmUgaXMg
bm8gZXhwbGljaXQgc3VwcG9ydCBmb3IgZGVkdXAgaW4gU01CLCB0aGF0IGlzIGNvbnNpZGVyZWQg
YSBiYWNrZW5kIHN0b3JhZ2UgZnVuY3Rpb24gYW5kIGlzIG5vdCBzdXJmYWNlZCBpbiB0aGUgcHJv
dG9jb2wuIFRoZXJlIGFyZSwgaG93ZXZlciwgc29tZSBhdHRyaWJ1dGVzIHJlbGV2YW50IHRvIGRl
ZHVwIHdoaWNoIGFyZSBwYXNzZWQgdGhyb3VnaC4NCg0KVG9tLg0KDQo=

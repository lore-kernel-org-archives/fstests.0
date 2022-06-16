Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8874AC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 16 Jun 2022 04:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349040AbiFPEhh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 16 Jun 2022 00:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242923AbiFPEhg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 Jun 2022 00:37:36 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FD35F70
        for <fstests@vger.kernel.org>; Wed, 15 Jun 2022 21:37:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzqnXsEWq/YZAaMPqluVSVHFX0lBhgTXGMa2mVeKisZ2cNlBHbpAzTkb7Qz4sMFCeEH5tF6kKoYZR4XY/aRTkPSLEnGVUPI0KG+kn6gK/pD0iZLpGwL/as9QrMzajB9lvXHrw6oa6BFYX9MY8GbBXcInh+2W7JVQlCAGJUY4PMqQSWCzQ6pi/oP5nHxnvPvrjB1Uabyb8HKO52aICGr1v7ZLxp4LTP6HogU5MhRGSah1XMmeoaec8YXIJ0iCm2nxKoJKsogdVEuyUkPhMe0eLlAhnSNmzhIWUYjzbqZMBhVDvWAe/2VM2+nbdmdxt4hsng7pSF7IGMMbbIkTq5kf3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OdIo2eEJYq7IVAL00FxWtG0TaCCcuRoRi1LWzK6kt4=;
 b=TFj0ryPPXi7pzxmgsiq3DvR05Lioler+VdjyJfdXvpjGBM/xfToT1lHHOOhY8ErtZPNX8bGC2mmarrUIUQHvcsj7YeUFFA7du24QqdD0EwJ51Wk8qARgKJDn8nEcOYiqL1Z3Symu4ceMVqnaYjrQVF9YTY9AKvYGNzR7tLiXLdbtlSHBUBrNrEUgJ1q8vbGG7NGAqUghtESaNq66+rzoCrw0XkffxQ/HI05ZXmEP1ym1wbdhSv2+Pz77LsBkCtB2j7zPA8ODNtr0TLYp1gKhONnn4rgHLBnQdK3AN6pqUTLp7pmhglZ2YndXfU35PDYRL0RI9V5gX9MDESmoxU5boQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OdIo2eEJYq7IVAL00FxWtG0TaCCcuRoRi1LWzK6kt4=;
 b=GPjIZakFm4QTX/gaYjBU8J/vbsD1el+aqeLuZL8tBEf6QUUMeZGsHEpNzRzcRZY4OQjE8S9QH8Y30esDPuN+c6yyq95w7HWVpT6D/Nnm3EBLs3hKtBnrvS3oH0bgBL9Ya7F/0JCV9r8qqYU8Wi1xiJxuJjXFFKgmreOtCa9AJiuNK1l/999YZBT9D6y5WvaPzeiOm+4caxcmR7HAAn0rnqgfV9lsdwWRbkeIQNi0nyX/unTB5OEEP5LWx7KXX7RbSA7eW8Io+604R+ovJWBVj46CZkbO5suyzhXSiwFAncVq4x4q4AyrjQ6Rqyjjfw7+MNVu4Dn2yZNXmIf+XQ9HRg==
Received: from VI1PR0401MB2671.eurprd04.prod.outlook.com
 (2603:10a6:800:55::10) by DB7PR04MB4828.eurprd04.prod.outlook.com
 (2603:10a6:10:23::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 16 Jun
 2022 04:37:31 +0000
Received: from VI1PR0401MB2671.eurprd04.prod.outlook.com
 ([fe80::282e:5a0b:aa1c:dd86]) by VI1PR0401MB2671.eurprd04.prod.outlook.com
 ([fe80::282e:5a0b:aa1c:dd86%3]) with mapi id 15.20.5353.013; Thu, 16 Jun 2022
 04:37:30 +0000
From:   Long An <lan@suse.com>
To:     "zlang@redhat.com" <zlang@redhat.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH 1/2] common/rc: add _parse_size_from_string
Thread-Topic: [PATCH 1/2] common/rc: add _parse_size_from_string
Thread-Index: AQHYf6zWrc4WclwuKE6FKnH6dQ4hYK1P/HgAgAF5wIA=
Date:   Thu, 16 Jun 2022 04:37:30 +0000
Message-ID: <84135a6e5aad2bc0f0da7085df78099e3ae6514f.camel@suse.com>
References: <20220614050843.11802-1-lan@suse.com>
         <20220615060528.svv63plztw3rjm3m@zlang-mailbox>
In-Reply-To: <20220615060528.svv63plztw3rjm3m@zlang-mailbox>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96b8f8ad-2cf0-4629-4582-08da4f51ecc2
x-ms-traffictypediagnostic: DB7PR04MB4828:EE_
x-microsoft-antispam-prvs: <DB7PR04MB4828ACC5A41222E967A2E997C6AC9@DB7PR04MB4828.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oqYypHJAqwpJvIuGH2+LJC8PqhEXMXpZGBdfV1qWEN9PAghN7fGEIG9qmIEMJzwe3hjaLnQ10tLNVoxtojHdtOgIug/TAUveOldirwL1WjfgQChkw5RuaQtmsqinvRdyQlC6J6C8Z0j5N9Ck1Xs1kgrUT7EyKN2CDyNSqM1Uf/F3cZpP2V/IP0uvPR1ZB3NSUCXOxRFRQ0SRNkboKKwP7CYqGDLw5ar360w2rm9rrSIdCsvVtJ2kFA9Oil9qRfAmr2FsEVZW/sCT6/oAOnkTLk24yp0QMprWqYa2fsxc7wjyldVd1sN1qbldvQBFG1BB8vLViq6HYQaInIZ/GDBDI8Vqh3SUKypdgD47E/YSkKkKfkSzi2pFneg3NyXLv6cMf+E0/I9C0RNNK1xr6MVKle17mMEjChmeDkkqXR9XZbWV5b1UIK8XV0+CHOFSuiO3gKuPdKsm/5Ymug8n7ztCCMAcCivh9o1r5jQeyZcNHbhQ5ZoxjDt93Id1acO98i28k7QG5uoTNvtHySIC7JZraYGMq3XeJFPNmlCfk8GSdDCvu5/X6wOd7X9IXMn/ryKKHnOh7mjcLjP5F0pmEPW4gXX51YsVe9VQCSS1Z1puYPL9jhIfcWWT7P7tZ6ZlzUuGJX9HBegoekU+t9LnJPKZ5tP0Jd81K1uyipvfSkpg/EYSJlSDVKsVjdib1EPjgSfs+RdkUIdyuVlHAgnwNVvuWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2671.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(186003)(38100700002)(83380400001)(86362001)(4326008)(36756003)(71200400001)(64756008)(66446008)(66556008)(66946007)(66476007)(76116006)(316002)(91956017)(8676002)(6916009)(2616005)(5660300002)(6486002)(38070700005)(6512007)(6506007)(122000001)(2906002)(8936002)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d21IS2duL0JLemdiVytXbWxlejQ1WFlMTUJ3STdmNDdIUEUrbG9qZ1dZYmwv?=
 =?utf-8?B?K2xIMldPWGcvMTgrKzI0SUtNblJ0ZmxiWDZvVEhGQ29LUnFsU0VjTCtEUmlG?=
 =?utf-8?B?dno0aVJTdTZYaHA5Q0d0Tm1zTFJqM25DcUVtY0lpWlh6bFpPUDVZM1hkWDV6?=
 =?utf-8?B?SHJPOFBqYTRnbUtxczNhNmZEUmgvN0xqcURab2dTMVBOS1NVOXV6c092K243?=
 =?utf-8?B?NmJ0OURxUzBxVVNpWG9TTS95ZTM1N1FHZWQ5QS9MUkVNY0FZSXMyUTVUM2g3?=
 =?utf-8?B?Ylc2WVFzY3lTS0VsZG5JQWZManJranM1bFZtSjBKMHF3cXVWSmRtb2lCb0or?=
 =?utf-8?B?UDhWR1gxVFQwa3VqcUZPV3NFeDViUVJBUnlnVDNMTHNhaEhXS2JZaGlRMHNB?=
 =?utf-8?B?RVBqVlNnWFgrczRoc2hEbDN0M3VxTlRzTW1LR2E3VkdFMUpyZFovaSs2MG5x?=
 =?utf-8?B?MCsxQzQyOFdqNUpjbkFQRjBlOEw0UkVQMmhJQXBxQjNFN0dTWDdjc0ZteHpa?=
 =?utf-8?B?TDEyS0w5SmNvWXJGSlZjRVBSdGgyR1lHbHBHT05UZmRLc3B3MFY3MFRPdFdD?=
 =?utf-8?B?Ump3SE55ZDIrVnZCRlgxS0VWVWNROGVQNDV5eU1mSnFFcE5hVG1tNlIyczNX?=
 =?utf-8?B?K3R6VHFkMzhrdnV2L0VpMjNhazRaSmUzSmFDT21EQm1YdTR3b2pOTEExM0p2?=
 =?utf-8?B?c2hjc0R2eWRrY2tYa0hPdjJjUWlWZStuYnpQWWVNZWhaeWJ1RkxuZWRVZlBn?=
 =?utf-8?B?bjdtQVM0eGwwL3VKWjM1em45andyZnVXY0JucDN5aGpYODdpV3RpVVhNZGxC?=
 =?utf-8?B?eUNiY3Yvd2NuTHRPMmtWQUh6WitiRm1VR28zaENyOStTT0t3TG1tTWxRVDI0?=
 =?utf-8?B?VUxRbnpNQUIrYkJSZVV2RUJCdys4RzdqQ1AyUE5kc0NHcW5Ta29Pd1RVYXFh?=
 =?utf-8?B?ZUx6eVhIb05hbG1xUDJiSUxDbmlhV3BYTTR4Y1lYTlNkWVJ3czVUN0NiUkI2?=
 =?utf-8?B?dDB5cXQvakVEa3IwcXd4ZHRyRjhWbllFR3IxcGU3cEtRN1I2U0ZTemwxTUQy?=
 =?utf-8?B?V0VNRTRONDB1VWdqcUZoRFV4MzZhQWxteGU2cHdOM1RrcVk4TXNoTTZtVC9V?=
 =?utf-8?B?UE5jMU4zR3EvWW04ZWdQSG9QUC9sT2pYSmhJVFdZeXhlNXhrcWNHQm1yTXBr?=
 =?utf-8?B?OHQ2OEppVmlZVlZpbTd1TXFndWtYZXV6aWk5eW5JWUdMRzhLanZGeHIwNnRv?=
 =?utf-8?B?dERnMXZkbmJBZmFDTFFOU3djZUxkUFBCbHVXQ0NOamxpalc1QU9xM29KQkNX?=
 =?utf-8?B?OFBVTHJaYUJzVXFCOG45anA5c1lwTURvQzdyZ3VQWktENmhoL29wUUcwbTk0?=
 =?utf-8?B?SVFFeVNXM0MvSkxSTGlGVFBjekEwOHY2elB6Qm9Ra1cwcDhyTU5EeE5rQW9v?=
 =?utf-8?B?Uno0SUVkaklySCtIMjdIYW1aWnoyUVZFSUZDQitHdisyOGRZdWNoalVJTC9U?=
 =?utf-8?B?eDJ6aU1VYjhkTjJTNXlIeU5lTENCNUVjL01BSFVJR092VUp1Q3VZQ0hzY1VZ?=
 =?utf-8?B?RGxiQ2Uxd0lUOHQ1UzVqcWQ3Rk9yT0p5SnlqRmZiZncwbU02NGNNcURrZmRU?=
 =?utf-8?B?VXh1dkZVVVFtL0gwblpnQ1l0b1M5bVJNZ3JlZ1pJSDJ1WEhCV0luSDdCbjZO?=
 =?utf-8?B?enRzNnBBS1N0WnArTWJIbzh3NnJCa09HWEZKTEROMlIwTkd6elRzYXRBNzFR?=
 =?utf-8?B?Mjl0OERFNGRueFRpMWNBeFNDWFpCaW5QZjdidm5PWVVSVHFsWkxNcVQ1M1JU?=
 =?utf-8?B?OEExdGRNaGJFNE13eGpoRHoweHRiMmVqWEZ4VUVNQjJGdlN5SW4xblB1RjlU?=
 =?utf-8?B?akc3UWtyNG1aWWZFKysvdE92TmRxYjY5SDd5TEJuZ3A4NlQ3d0FlY0QwSmJn?=
 =?utf-8?B?VE1pTFlld2RKZU9NRTFwQ0RVSWZLZllwdFJWZ1EzbDJGZmNQMFJzOVYrSStD?=
 =?utf-8?B?L1FKeDhORnZWeUdOY0dCQ1EvMVNvS1U5RkU1MkcxZm0vNXpPZk43eGN4VHJK?=
 =?utf-8?B?T05DVVdNTWNnRkpSakZOdlNDZFUzVndpaVUraEhYOGdkM2FkUm5lWHJOM2hS?=
 =?utf-8?B?RVJMQ3BZZEplTGpQUHhVQjZMOXQ5K1pEN1lWSzQ3S29TNGhMZ3RLbHFsU05o?=
 =?utf-8?B?Z2d6N3dDclI3bGNVa0d6OEdTc0tNK3BCWFhvWW1aZzNyMzZ3S1NyblR3S0Rn?=
 =?utf-8?B?ZzJ3eG1sL1F4MkllZ1NNNHNjYllWRzcrL1FqK1ZtbVluRFR5dGY2MjRBNHRx?=
 =?utf-8?B?OHJqSm5zdWtCQ2c3TlNYZGZVR1hXL0NoUHlyQ2RGUGVKLzEvSjd0bWRMRCtI?=
 =?utf-8?Q?W9wi2WRZ/95n9U1N60NXNqH/qT7PDfD8XSMAC5W1q1C4F?=
x-ms-exchange-antispam-messagedata-1: pSDsUe7BKVzH+Q==
Content-Type: text/plain; charset="utf-8"
Content-ID: <A09F86703F440048B0B5F920A10ABAE2@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2671.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b8f8ad-2cf0-4629-4582-08da4f51ecc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 04:37:30.8821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v0W8twvh4WzB23qpK/B9ZLSAMn2X4kHXd5PjPnm9mzEnndK9qjBm1pZj5pgT02k8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4828
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

T24gV2VkLCAyMDIyLTA2LTE1IGF0IDE0OjA1ICswODAwLCBab3JybyBMYW5nIHdyb3RlOg0KPiBP
biBUdWUsIEp1biAxNCwgMjAyMiBhdCAwMTowODo0MlBNICswODAwLCBBbiBMb25nIHdyb3RlOg0K
PiA+IEFkZCBhIGhlbHBlciB0byBjb252ZXJ0IHNpemUgdmFsdWUgdG8gYnl0ZXMuIFRoaXMgaXMg
dXNlZCB0byBoYW5kbGUNCj4gPiB2YWx1ZSBhcyBieXRlcywgc3VjaCBhcyA0ayB0byA0MDk2Lg0K
PiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuIExvbmcgPGxhbkBzdXNlLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgY29tbW9uL3JjIHwgNDggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0OCBpbnNlcnRpb25zKCspDQo+ID4g
DQo+ID4gZGlmZiAtLWdpdCBhL2NvbW1vbi9yYyBiL2NvbW1vbi9yYw0KPiA+IGluZGV4IDNjMDcy
YzE2Li4yMjA1MGJjMiAxMDA2NDQNCj4gPiAtLS0gYS9jb21tb24vcmMNCj4gPiArKysgYi9jb21t
b24vcmMNCj4gPiBAQCAtMTAyOCw2ICsxMDI4LDU0IEBAIF9jaGVja19taW5pbWFsX2ZzX3NpemUo
KQ0KPiA+ICAJZmkNCj4gPiAgfQ0KPiA+ICANCj4gPiArIyBDb252ZXJ0IHNpemUgdmFsdWUgdG8g
Ynl0ZXMNCj4gPiArIyBfcGFyc2Vfc2l6ZV9mcm9tX3N0cmluZyA8c2l6ZT4NCj4gPiArX3BhcnNl
X3NpemVfZnJvbV9zdHJpbmcoKQ0KPiANCj4gSSB0aGluayB0aGlzIG5hbWUgaXMgYmV0dGVyIHRv
IGJlIHNob3J0ZXIsIGFzIGl0IG1pZ2h0IGJlIGEgbG93ZXINCj4gbGV2ZWwgY29tbW9uDQo+IGZ1
bmN0aW9uLiBIb3cgYWJvdXQgX2NvbnZlcnRfbnVtKCkgb3IgX2N2dG51bSgpPw0KPiANCg0KUmVu
YW1lIF9wYXJzZV9zaXplX2Zyb21fc3RyaW5nKCkgdG8gX3BhcnNlX3NpemVfdHJpbmcoKS4gU28g
dGhhdCBhcw0KbXVjaCBhcyBwb3NzaWJsZSB0byBrZWVwIGZ1bmN0aW9uIG1lYW5pbmcuDQoNCj4g
PiArew0KPiA+ICsgICAgICAgIGxvY2FsIHN0cj0kMQ0KPiA+ICsgICAgICAgIGxvY2FsIG11bHQ9
MQ0KPiA+ICsgICAgICAgIGxvY2FsIHNpemUNCj4gPiArICAgICAgICBsb2NhbCBlbmRjaGFyDQo+
ID4gKw0KPiA+ICsgICAgICAgIGlmIFtbICRzdHIgPX4gXlswLTldK1thLXpBLVpdJCBdXSA7IHRo
ZW4NCj4gPiArICAgICAgICAgICAgICAgIHNpemU9JHtzdHI6OiAtMX0NCj4gPiArICAgICAgICAg
ICAgICAgIGVuZGNoYXI9JHtzdHI6IC0xfQ0KPiA+ICsgICAgICAgICAgICAgICAgY2FzZSAkZW5k
Y2hhciBpbg0KPiA+ICsgICAgICAgICAgICAgICAgZXxFKQ0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIG11bHQ9JCgoJG11bHQgKiAxMDI0KSkNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICA7Jg0KPiA+ICsgICAgICAgICAgICAgICAgcHxQKQ0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG11bHQ9JCgoJG11bHQgKiAxMDI0KSkNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA7Jg0KPiA+ICsgICAgICAgICAgICAg
ICAgdHxUKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG11bHQ9JCgoJG11
bHQgKiAxMDI0KSkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA7Jg0KPiA+
ICsgICAgICAgICAgICAgICAgZ3xHKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIG11bHQ9JCgoJG11bHQgKiAxMDI0KSkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICA7Jg0KPiA+ICsgICAgICAgICAgICAgICAgbXxNKQ0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIG11bHQ9JCgoJG11bHQgKiAxMDI0KSkNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICA7Jg0KPiA+ICsgICAgICAgICAgICAgICAga3xLKQ0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG11bHQ9JCgoJG11bHQgKiAxMDI0KSkN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA7Jg0KPiA+ICsgICAgICAgICAg
ICAgICAgYnxCKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDs7DQo+ID4g
KyAgICAgICAgICAgICAgICAqKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGVjaG8gInVua25vd24gc2l6ZSBkZXNjcmlwdG9yDQo+ID4gJGVuZGNoYXIiDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgZXhpdCAxDQo+ID4gKyAgICAgICAgICAgICAgICBl
c2FjDQo+ID4gKyAgICAgICAgZWxpZiBbWyAkc3RyID1+IF5bMC05XSskIF1dIDsgdGhlbg0KPiA+
ICsgICAgICAgICAgICAgICAgc2l6ZT0kc3RyDQo+ID4gKyAgICAgICAgZWxzZQ0KPiA+ICsgICAg
ICAgICAgICAgICAgZWNobyAic2l6ZSB2YWx1ZSAkc3RyIGlzIGludmFsaWQiDQo+ID4gKyAgICAg
ICAgICAgICAgICBleGl0IDENCj4gPiArICAgICAgICBmaQ0KPiA+ICsNCj4gPiArICAgICAgICBz
aXplPSQoKCRzaXplICogJG11bHQpKQ0KPiAgICAgICAgICAgICAgICAgICAgXiAgICAgICBeDQo+
IEkgdGhpbmsgYWJvdmUgdHdvICckJyBpc24ndCBuZWNlc3NhcnksIGFsdGhvdWdoIGl0IGRvZXNu
J3QgbWFrZQ0KPiBzb21ldGhpbmcNCj4gd3JvbmcgaWYga2VlcCBpdC4gU2FtZSBhcyBhbGwgYWJv
dmUgKCgkbXVsdCAqIDEwMjQpKSAuDQo+IA0KPiBUaGFua3MsDQo+IFpvcnJvDQo+IA0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4NCj4gDQpSZW1vdmVkLg0KDQo+ID4g
KyAgICAgICAgZWNobyAkc2l6ZQ0KPiA+ICt9DQo+ID4gKw0KPiA+ICAjIENyZWF0ZSBmcyBvZiBj
ZXJ0YWluIHNpemUgb24gc2NyYXRjaCBkZXZpY2UNCj4gPiAgIyBfc2NyYXRjaF9ta2ZzX3NpemVk
IDxzaXplIGluIGJ5dGVzPiBbb3B0aW9uYWwgYmxvY2tzaXplXQ0KPiA+ICBfc2NyYXRjaF9ta2Zz
X3NpemVkKCkNCj4gPiAtLSANCj4gPiAyLjM1LjMNCj4gPiANCi0tIA0KQW4gTG9uZyA8bGFuQHN1
c2UuY29tPg0KU1VTRSBRRSBMU0csIFFFIDIsIEJlaWppbmcNCg==

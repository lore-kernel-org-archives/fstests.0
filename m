Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A463C43334
	for <linux-fstests@archiver.kernel.org>; Fri, 17 Jun 2022 07:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiFQHDi (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 17 Jun 2022 03:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380095AbiFQHDf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 17 Jun 2022 03:03:35 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE545F8F9
        for <fstests@vger.kernel.org>; Fri, 17 Jun 2022 00:03:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVFXhc23fG03V6TBuctzxrmrP4NvWgyG0cINGTcL7H/v6wKnz999Iq8KXpfY7K+xzuyqYJrkZN3EKGE/M4VJ5sG7kEtvkweJDD6PN8dAiogXKk8lzhYL01aHCzFq58bZnJIRBFnkIb2wVcbIxqsC6wVzunqgiQHT20ppSDyHCOg9l4qa4U6XwS0gxZ7whasZQaUXkonj0og1CYaizZRLj9sG9Y/wuCyJ1gncQQxy5UvAhBH3puYfix1SlGJmANiUV2qG+mnaQxcPJXNZNMgrfjmDItLgqJtKFg7z4E6AlqvV2yRdBP3+c/8VFWV2eWOBxDe2P1PHvsbtL8pCkKP17w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3e5QfNpd4wvq1p+BYgwj9mXOjFcBjqlnxAOu7Td38s=;
 b=Q0vx78LemTO4vyFBzL/uPDiCd+vQmWjLvk7CaDxk464va+h+nwrPoLP6ZqBx7+/SR7XW2Ksae4qXeGygGxmyafEfAyCP1LRQwvAqJGriGGcU/Xasp01wY+SBsUrUrlYCZJ9iw4z49/li8Wtbh1aJ5O9vUoVD+3QO6ZffTHUau9cyANJbn1PirlwWG44Ha71nC0Ro7TiYQ7BomCac1FGLcSW58tFQDblT6Aef7S+Uw4O5Eag0H7PU52XgWoKOjlms0iggXlGgqkaGYZnPzcRFsKGeqOZczZD4pFKjp9OXtIcihNGhn7lMlJSdlAXSA5EnOU1hRnkwo+rc/eEaDY3xbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3e5QfNpd4wvq1p+BYgwj9mXOjFcBjqlnxAOu7Td38s=;
 b=tdw9Z+7mBps9HvQ3a886qzGm4cecNpsPrn9wEr2WD3ThHo/ppOrO90czD7D6gxWxWNUeNPvO/DqXOOhR3jsofbZxXW/dginUJR91x2Iy/Q/4V/ucA4tHFa2+t6hA1MVkycQyJoUpF0IiFAW5MW/Ch+1vNIVsDtj7ITQVzqmOYXxHe2JMgUOfoqQ1mx2iQ7CP5ePFv+RjQGRJ4Oxc35B7zSk+32PCPqBzxlmg+hymniVItvLHfVkQCsTof9In+HK//jyFIiie/vUvL4tGN0c0fS4Z8iy4XmluM1/HxR4vHAXZhguWd4qZyVxRKCcjxbJDrcPvcWoEvtjeHqYd1Up6RA==
Received: from VI1PR0401MB2671.eurprd04.prod.outlook.com
 (2603:10a6:800:55::10) by AM0PR0402MB3747.eurprd04.prod.outlook.com
 (2603:10a6:208:6::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Fri, 17 Jun
 2022 07:03:30 +0000
Received: from VI1PR0401MB2671.eurprd04.prod.outlook.com
 ([fe80::282e:5a0b:aa1c:dd86]) by VI1PR0401MB2671.eurprd04.prod.outlook.com
 ([fe80::282e:5a0b:aa1c:dd86%3]) with mapi id 15.20.5353.016; Fri, 17 Jun 2022
 07:03:30 +0000
From:   Long An <lan@suse.com>
To:     "david@fromorbit.com" <david@fromorbit.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] Fix input value to _scratch_mkfs_sized
Thread-Topic: [PATCH v2 0/2] Fix input value to _scratch_mkfs_sized
Thread-Index: AQHYgTr7+IKLyBvGpEGivq+yqE4Pc61S+pMAgAAzqIA=
Date:   Fri, 17 Jun 2022 07:03:30 +0000
Message-ID: <72edec0cedf5090a39bc80670129c42730b0dfab.camel@suse.com>
References: <20220616043845.14320-1-lan@suse.com>
         <20220617035836.GZ1098723@dread.disaster.area>
In-Reply-To: <20220617035836.GZ1098723@dread.disaster.area>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 217edaa4-b180-48f8-198d-08da502f7c35
x-ms-traffictypediagnostic: AM0PR0402MB3747:EE_
x-microsoft-antispam-prvs: <AM0PR0402MB3747EB1594DC39D0156977B6C6AF9@AM0PR0402MB3747.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ivv9Or9u8kTzkooSY+rfz+Rqec+gg7lWcEPjIwnEYGmuYwicapm3A85pba/mmqe3mriL5hll5orhtOQR5L/TKER0d2MOYL20Wn2FkD8883VyENfTGJRgHdCkfUE4n51OB7KLONlMuO1RETH6KiKYHjOsn9hnSj9xP/FZ6tmJpNZtZBYydFREVYUFLwB4D2+UfiwReF+2bC8etP+6X57wHrpc8MZuA2NDjdJMy+MrCxT2p0g+AvwNwUHgVEtGnpBfj5ZiejYXdkZB3G9Nv68jFYRLYquRfC4aoY1l3Bw2P42lfl7MAEQL/YZ5b4aJUsACU1DYEJc+DM9Hur5COC45GC6TNlOWuFxAyn3CgkkWD0AcxVYe0cHWPVtmbOZklcysbpcyhHlxUPQ322lVTtaxsgUmlu6HiRacNhphmiKKjd5NZldQSitI7VN7LF3bf71UIaEru7IuPy5hnQMSJidFJabnwysIzPRb3IckKcHNL8Eahvf89BfpLwpTew8AYWp1MjlzaS6MQ8Vk/7mrB42xkJBdY53UeK8gYQfKW/6x9RLLXwgQQWdjIedTjg+s4T1w9Kl9VirJemCVneq+IAcHYH9YiDVMWE7vlryyAab9DHjhkGEp6rkyUQvn8u6KMDRCKxK5scWUlW4h60g8ijDVbG1FGdE3HXvAQqBG1yRasIutJceW+4y4KUOHtX+xwhXwVtPbbv+fnN9Hf3rdESiJYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2671.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(5660300002)(6916009)(36756003)(122000001)(4744005)(83380400001)(2906002)(186003)(2616005)(6512007)(91956017)(4326008)(64756008)(6506007)(316002)(498600001)(76116006)(8936002)(66556008)(66946007)(8676002)(38070700005)(71200400001)(86362001)(38100700002)(6486002)(66476007)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUtJdUFITFY3bzREUGR5c1dkdDgxU0psWVJ0VVN3Q0lDRER2bnc1S09PU3BJ?=
 =?utf-8?B?eUNnKzhnRFZMek1JM0RaL3Z6TFRQb0EwSUhseVZQU05McnlKalNVRkExNUZ0?=
 =?utf-8?B?Y3RQUUM1YUx4cndhcDNHcWR3VVRSR3AyVVo2V3NvdkRNSGJwcE1SaFpkK0JL?=
 =?utf-8?B?UXFVVEtOUU9taHRHNXR3SmdRNmwzaUE3Ly9IQjBjRHptMkxVS1c3d01PdjVl?=
 =?utf-8?B?MG9nZytzdnVYQ0IzMkhhdDVMcVpZMWJONzhJVmpUNWxSa0xVcklFY2JnRXla?=
 =?utf-8?B?L1EybmlIaXdmNUY1STNBYkVFNk8rcGpISXI5OVdyalZIdzQ3TmhQNTR3VTYz?=
 =?utf-8?B?NjI2ZktrU0ErdDd1ZmFUTW1uMU1rR2FGdHAwNkI0UGE4YkFuQ1pwYlJlRDNJ?=
 =?utf-8?B?MEQwdkRhUklRVzF5ajdGVnFtK1lLSm9OeUJOSWFYa05NUERYWnlsQ0hPdkJk?=
 =?utf-8?B?Q0Fjbk56QUJ1RVVmd2F2eU45OWZyY0VqQnBBRm5Nd0NtSERFNTNhSFhMeVpY?=
 =?utf-8?B?UGtIUUEraFV2aXRvQkxkSG8vNy9hekxXd2ZwcXNhUnBzVVV1bHd5YUFDWlJy?=
 =?utf-8?B?TGxGVU9XMVpLenZwMW4yUW1taW1YK0dpRk1tTWszbjhQelloN1d4eHNJamc2?=
 =?utf-8?B?VlRuY3pBNklTVjZvODE0YVF6MWJBNHJFMnRpSUJoU0grM2Vnb2lCNlNCdzlC?=
 =?utf-8?B?RmdlQjFWSGhhRWE3ZnVMM3F0YmRWN05RY2VXd29IV2oyMzFXT3FYNXZGVTVT?=
 =?utf-8?B?RkE3SWg5V1FpNlIvamp1K0tkZ2NLRjRwSXozMzgwK2NCMEdNKzhwa0drUEFp?=
 =?utf-8?B?SVJPblFyQkJqRW5vOEtOR1F3cHZTVmkwczQvWHlIZ083d3Z6RS9pLzVkZVFk?=
 =?utf-8?B?V1dGYTd1dWdiTlRhRkdnR0hGbkJDaFRLVGwvbS94N1RjZ3EvVnZ1N0Mza2pU?=
 =?utf-8?B?N3ozS2RaRlllTlNwVUw4ekxxVGpaNStZWG9VdkJWRFBlZlBCOFRNL0lJUEFH?=
 =?utf-8?B?RDk2S2lGSDFGVzBqa21rQURCeEY0WWNJU3E3YU50eVBnc3pRcU9iTGdiakVi?=
 =?utf-8?B?RDJ0bm1hL2ErNm5LaVQ1RjlGQld4V0RzRHVlaFRYbWNoYVpObFVpSnVvTS9D?=
 =?utf-8?B?cTdTVEc5NVhUQ3VYb1FpNnQwVFo0Qk1MVzd2R2hIK3A3UnlrcnVRWTZqNGhG?=
 =?utf-8?B?QWszeE5sWmREeUxoM2JWeUlEZDVza0M2Z2l4K240bnFUS2F4ZHpiRWUvUWh2?=
 =?utf-8?B?YnRzdDdKMDhYK2Vyd3NVb2xWMkswYWxNRGRBOHk4SXVYVmVPSW5iZFNtRTJO?=
 =?utf-8?B?akRwZGRYOHg5K3VYdHlyY1lvNENuK1hwam1GMkVSUUl0ZUFjbnlPUDRuazU5?=
 =?utf-8?B?QkhtTEh3dU83Nm9sNmdmWXg2THVJTjVzdWNqVDMyRnZmblY4TEV0T2R3RVp2?=
 =?utf-8?B?WDB3K0JiQWxyRVFXNFdLNHJQaWZmRzI5Um1iMG5TcUZwTUE1VW1Tc0hadFFD?=
 =?utf-8?B?NC9vejVvRXpCcTRpUjFCT2F0WlZRYWtzbnpUZzAycU9Gd0hpRFFCRURNWUJj?=
 =?utf-8?B?bFhLT3BkSnIzckRIVDBSN2FzNHlTeHZkbFNqR0tWWW5WeGJ4ZTdwTXBKSkNY?=
 =?utf-8?B?UlVQbjFFcWhjOW5XU1BlUUJkcTVvZEJabUdlWXlBWUU5M3FPenlhL3FYblVp?=
 =?utf-8?B?VitXc0dUeGdSWTVrUGFhWXZWWVo3TXFHVlgzT0Q3bGFHQWY5MGM0Mk5xb0oy?=
 =?utf-8?B?eW01WkRVUzhLMmtTUHRRMzdSS2xUcUl5YmVNNHV3dlVCZVhDWkpGcXZtM2pu?=
 =?utf-8?B?WFRJWlNzekNKbHh2bm1KOFhTdCt1VFhrSWV5UzU0UDRPQ0NwK3J2bG9YejU0?=
 =?utf-8?B?dm5CT3NmbXVKYmlsZnNuOStKUnhMVUdoME5YbmRucEQzbXBEdU55Vks4UW9X?=
 =?utf-8?B?ckRrTGJkY1BNMW9kR3NQYk1haUFmaVpNMXI0UDhuUXBtTnFnOEVFOWRGL0JD?=
 =?utf-8?B?K3FTZi9RS3dPekptVDBTU3lqRmFJMkd3cVRzdi9GK3hzdWhCdGFtMlVwZmh2?=
 =?utf-8?B?WFNQNGV5akE0R2UvSDFCcXFaZ3ZPUnJoRFppdFNQWVU3QUtvcmN3L2FNenVM?=
 =?utf-8?B?emlFdEIvNFVMQ2FpREZsME01MUJWVFhXYVdoMmJiejJSZG5GcXVMYWxBMVlR?=
 =?utf-8?B?ZUZwcFlQM0lGUFJVOGhiaUNneXlGMWd2OVFKeGlXV2dLQkMyaHY0cE4vR1BH?=
 =?utf-8?B?YmtxTHNTUFdzR3Yya09BSTVack0ybUtORTF1UVUxNlBrNEo2ZG9ReEV4QVFi?=
 =?utf-8?B?cjBrMnVqaHpiRkpxWUxpeVlnL0RIajVlRk1LS3hjZUMvYXArb3ZXbFF0VGtO?=
 =?utf-8?Q?V3xonmb9P0nyggq9ZNzOc/GuRNUf3t7GE8TovYGNJiq3o?=
x-ms-exchange-antispam-messagedata-1: dDblruHDFWdReQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <F31239A43209DF46B48317D401FB95E0@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2671.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 217edaa4-b180-48f8-198d-08da502f7c35
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2022 07:03:30.3417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uEC9m9SyWy8Yx7LAVJlU2xWqHBqiJ8025Z687M8ZtGUl9KGBLDkOjBHgZVaz6Flx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3747
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

T24gRnJpLCAyMDIyLTA2LTE3IGF0IDEzOjU4ICsxMDAwLCBEYXZlIENoaW5uZXIgd3JvdGU6DQo+
IE9uIFRodSwgSnVuIDE2LCAyMDIyIGF0IDEyOjM4OjQzUE0gKzA4MDAsIEFuIExvbmcgd3JvdGU6
DQo+ID4gRnVuY3Rpb24gX3NjcmF0Y2hfbWtmc19zaXplZCBjYW5ub3QgcmVjb2duaXplIHRoZSBz
aXplIGRlc2NyaXB0b3IuDQo+ID4gDQo+ID4gRm9yIGV4YW1wbGUsIHdlIHNldCBNS0ZTX09QVElP
TlM9Ii1iIDRrIiBhbmQgdGhlbiBydW4gZ2VuZXJpYy80MTYNCj4gPiBvbg0KPiA+IGV4dDQsIHdp
bGwgZmFpbCB3aXRoICJta2ZzLmV4dDQ6IGludmFsaWQgYmxvY2sgc2l6ZSAtIDQiLg0KPiANCj4g
U28gaXNuJ3QgdGhlIGNvcnJlY3QgZml4IGZvciB0aGlzIHRvIHVzZSB0aGUgY29ycmVjdCBmb3Jt
YXQgaW4NCj4gTUtGU19PUFRJT05TPyBpZS4gIi1iIDQwOTYiPw0KPiANCk1LRlNfT1BUSU9OUz0i
LWIgNDA5NiIgd2lsbCBnZXQgdGhlIGNvcnJlY3QgcmVzdWx0IDQwOTYuDQoNCj4gaS5lLiB3aHkg
ZG8gd2UgbmVlZCBpdG8gYWRkIGNvZGUgdG8gZml4IHNvbWV0aGluZyB0aGF0IHRoZSB1c2VyIG11
c3QNCj4gc3BlY2lmeSB0aGVtc2VsdmVzIGFuZCBjb3VsZCBlYXNpbHkganVzdCB1c2UgYW4gaW50
ZWdlciB0byBiZWdpbg0KPiB3aXRoPw0KPiANClRoaXMgZnVuY3Rpb24gbXVzdCBpbnB1dCBhbiBp
bnRlZ2VyIGZvciBub3cuIEJ1dCB0aGlzIGZ1bmN0aW9uIGFsc28NCm92ZXJ3cml0ZXMgdXNlciBp
bnB1dCB3aXRoIE1LRlNfT1BUSU9OUyBmb3IgY29tcGF0aWJpbGl0eS4gQW5kIGZvciB0aGUNCnNh
bWUgcmVhc29uIE1LRlNfT1BUSU9OUyBuZWVkcyB0byByZWNlaXZlIHN1Y2ggcGFyYW1ldGVycyBh
cyA0ay4NCg0KPiBDaGVlcnMsDQo+IA0KPiBEYXZlLg0KDQo=

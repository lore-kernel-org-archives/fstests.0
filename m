Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C129AC43334
	for <linux-fstests@archiver.kernel.org>; Fri, 17 Jun 2022 06:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380215AbiFQGpL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 17 Jun 2022 02:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379507AbiFQGpK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 17 Jun 2022 02:45:10 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10078.outbound.protection.outlook.com [40.107.1.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1785924962
        for <fstests@vger.kernel.org>; Thu, 16 Jun 2022 23:45:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/RbWTkNW+zn280YmQAGPaIXNq5mEamAwOpXjRnJmvC9TuQ4Izl2/DZ8u5B9AyJ9vlxJQ2r4YHzV4/MH8jET++hMU3IoTBcssTiRjqnFUS2IGxLblQBTwu0npYEyA3SB4LKSm0RDx/m6+1UR5dqfrSKaVmS4Xy2EXJROtrU0Ti2aq1YgnHRXrhjTC8JRZlHgKumopNqBnwxUxv/xRPHmnPgE4a0FiXT0Vpu5BugskDb6fIkdGyx1XdjUUrnB+VFw6piLVadML46kAHHz2MRaRSiYb4vY2kceuEFeVlDV5cu2Knkhz0jmZQIj8aw5p616gQT5tq8X+D0UVR92qGRaVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4opwBaL1mvUe3R38ncLPPhF2YC6bniE0XxHxIq/wXg=;
 b=VQl67GToB4UQ6iZcBr8KHlcFD8rIGhrGA0zJvtELdDXKWwRr4pcxBYb1suTxeH1BgNxWvOEtdDIfLHKtXwP75scYYgMOgy8jySVCi5FpTD8bVSwO5oNJmBZQ4I80y0DDxX85rv2HEqzZGIuSXz2H4I4qJRnqxV97CuP26mV2k8Tu+sNp1rT34PMWvOE/8uZtHUnQxp0vCdSA1VX9aB5BE/LV71kFPEvTQ4dc317i8hcTpQgBe+I73KmZ9LRZ+ULAPHfHoHpSQDRzdjFdpS6V+UAGtb5+iG+C0n2PNj1jq0z2zykiklS/jbxAh4G6CnmZUJpic4EGQvce4QZrfvFHmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4opwBaL1mvUe3R38ncLPPhF2YC6bniE0XxHxIq/wXg=;
 b=LFi9tQf1dTpAL4x1rLVA4gmq06Qw2YKjBFhMfSsHeNtAnLuTfQ+4sV2kz2DkSGCT8HTNg+cnGW9GcaSC6ZjgtQu6hVzaaizC4fEGuexe847w2J3Ttm5o6Fc0loDY1xH+f4/LtFcEjj9japHxMfWBoDaJGiUk7X+lUjumWzjTr//XXSUUxb003DQUnc8FDf+e3fm4XHi2zpzW6PSSDhTediP78OVk9r8k2Xlixc4FraqYr3+UgPFNjgloI+T/pAsIZZiTDiTqh8TMeDeHdDo4HY2aB3LTl/8m+bmPduNAlDVPBDRTjbjIEq3jxRmpDHGsKWdSLsxT7A44XJZjSw5I5g==
Received: from VI1PR0401MB2671.eurprd04.prod.outlook.com
 (2603:10a6:800:55::10) by DB3PR0402MB3897.eurprd04.prod.outlook.com
 (2603:10a6:8:12::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Fri, 17 Jun
 2022 06:45:05 +0000
Received: from VI1PR0401MB2671.eurprd04.prod.outlook.com
 ([fe80::282e:5a0b:aa1c:dd86]) by VI1PR0401MB2671.eurprd04.prod.outlook.com
 ([fe80::282e:5a0b:aa1c:dd86%3]) with mapi id 15.20.5353.016; Fri, 17 Jun 2022
 06:45:05 +0000
From:   Long An <lan@suse.com>
To:     "krisman@collabora.com" <krisman@collabora.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] common/rc: add _parse_size_string
Thread-Topic: [PATCH v2 1/2] common/rc: add _parse_size_string
Thread-Index: AQHYgTr/N0l5T/F4O0K2twPqDBLG1q1SKBmKgAEA/QA=
Date:   Fri, 17 Jun 2022 06:45:05 +0000
Message-ID: <7fd0397ba90e7b54f0ca86692cd0b085e63c7707.camel@suse.com>
References: <20220616043845.14320-1-lan@suse.com>
         <20220616043845.14320-2-lan@suse.com> <874k0ky6ju.fsf@collabora.com>
In-Reply-To: <874k0ky6ju.fsf@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3df5434b-ebf5-42df-5957-08da502ce969
x-ms-traffictypediagnostic: DB3PR0402MB3897:EE_
x-microsoft-antispam-prvs: <DB3PR0402MB389781A1A3C535C402ABA382C6AF9@DB3PR0402MB3897.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2OBH70xbLlJ2odk6X2AaWq+d0ROUwH3SI1xsvwU1vhySMHTcZzxISyQuI0zEceBze0RzRHNtMDu8H8YwXMWNvimcwOMMUuwRHhUWi+Tv/9lWOKo9qgMX3k6Z9om+bZpWZSUNess97vNeP6qor46mas5cW19Li6DbiFONKqn6hPzLVXBaDp+zaYpibJaQN+8TERkF+v2ALsXDRcRpu0AMGC+O7Sr8IEAiR+lnYUUdCDfkNhSRYnyuu/FxeDs4Qo0FC+TDKw9Fw+PDVBplH4Jxl3d3p76YVMHz33Cb+ApQPUbIcaLheGm9Z8fSlnQI93YWET44W841/rXwHxg9mvfQD1e/QwwSqHUisicw/V+fDajd6pFsu+IitpYOLEhLSY4jsq+kurHtCFCTL4ctqAE3vblgIzgtCLGT8N3iUR8SaTeJyb2JmOniuAE4vvnnFxjjJr6KgEBV9zDB9hwzrxwrzx5K1vzZ8JUuuahnDkDxQVN4YIaP77nljsweT4mkKivejkrk2pUpisLZ0UfuMgXd9fSMy/aCYj8Uw8VFUnfZ4XbuKLnIM9SVbHO6fClFLSl6N9XAYtY+zLvpnQ7UM7mbr+vaRw11WR4odbvfHruQwX+ksVlCF469MS0ODvv13a2LmHS4fQbAeQJmI6KGZjnG2M1dfR/zb/1TRb6EEl4URtmXykk6y9OqHh4spP350HyT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2671.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(122000001)(83380400001)(5660300002)(38100700002)(2906002)(86362001)(6512007)(6506007)(76116006)(71200400001)(66556008)(64756008)(6486002)(6916009)(38070700005)(186003)(2616005)(66946007)(498600001)(66476007)(66446008)(8676002)(4326008)(8936002)(316002)(36756003)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VC9JLzBOb29yMTBSNkFuQWQ3RW01K2wvaUxFdDNoNEpZNlMyOG1vczcxdnlV?=
 =?utf-8?B?TWtFTzk0a1JtZlBlZlhWL1BmSTE4bndrd0hzMldvbm45bDVNRllJUmZZZHpF?=
 =?utf-8?B?dTNvVVFWd3VwbTZLemNQNGJZYnJoQlBQOE9qZ3FOM1FFbVc1SmNLa3plb3kv?=
 =?utf-8?B?NGFNMnZ4UXVPRmVZNzduOTRZbTVKK05RdGk3a1BmT2o5NFdJVzhjemFUOUZs?=
 =?utf-8?B?bEk4THZXWm9sdW1EM0FvZzZtbFNmWkJhSTl2ay9hdDkzWEg2R3RacDIrVE1D?=
 =?utf-8?B?WVZRZExmMHR1Vm1BbkVnQlpwRnFLNDZsSXIzRzIyZHJtMUE0QTNLL0pqQU1F?=
 =?utf-8?B?L0s2RnBNNS9rbmloaWJUYjJUVkh1TXJDY3JDVWIwbWdzb3pwQmJkQmNtcnNr?=
 =?utf-8?B?VHE4d2hEOVNhQVFZSWhhMmdQOEI0UzVEMVNlU3cvUHlXZENUTzJJUGsxelQr?=
 =?utf-8?B?NTdTTzM2bG9EaUpFZVB6ZkNkdzZ2VEprd1dXNXZsWVRmOVFycmVEUC9wUG5M?=
 =?utf-8?B?WG1jV01vakZhb1pGME9FVzlYemJIRWRxbTI2YU5DVE1QdFBLdHMyQjRJSGl2?=
 =?utf-8?B?NkgwdXF5cnA0QmExSkdVL3Z5NCt6TnRiYmZQeDdDTkl0TngzRURXR1BLMy80?=
 =?utf-8?B?MUt6eHB3TUhXdXNvd01KaFhxWHlnQUVHKzgxYzRiVUg4Z1ZOZjkrcTNqMG1t?=
 =?utf-8?B?THBJeWNpUVJpbC85NVRJMjJNK2YrWDZQRGN2ZDNtNDQ2N21uNXlMUzYxNHUz?=
 =?utf-8?B?Z2pkWDVZbTMyajNKMCtZNk5yV3pLUUtZZUNyNloxamJtY25wR3NtYmZPc0lu?=
 =?utf-8?B?SjRkZ3RtSzR0SmFxZldlMFU3N0lvZEc2WU42Uk03Ukkra29jMkxBMkpRZDR3?=
 =?utf-8?B?U2loajAzVU9LM0FpT0F3amlDV1pVTnhOVUdIS1FMOGdBaTNhemJpVjVJZFQw?=
 =?utf-8?B?aG5aUmJTa1piS1pZMmlhUWtGRktMbkpMcE5yelpHSitOYXR6WW5RcjVhUGFu?=
 =?utf-8?B?NDhNNnZuRzJWSnlXMnRoQ3VXckZpUzFGbmpUM05od3M4TndIclI5LzhiNFpw?=
 =?utf-8?B?VzdyUmp1dnRVZEFUWTNVQzlVQjMvdnM1cENlcW85TGpKQjh6c2VzdDAyNkI1?=
 =?utf-8?B?cm9wMVVoVE1MMGsyWHdUNVpRekZoRTg3c1JEODkxWlB3b3BRL1BScXRmQm9C?=
 =?utf-8?B?VTZXRzF5WTRhNUU0SXg4UGJ1NTRQbllMQUhhM3hFNXFIQnNOdzk3R1d4clo2?=
 =?utf-8?B?ZCtkWmMvL3NZYlZaNnFoTXFTYU9wUUE4YTNDVDlPZzU3d3FWTzV0bXk5bTY0?=
 =?utf-8?B?bU1ueDJSaWpLZGxvaDNKZXlSdVgwNmZKWWdWL2ZhdytVcWQvWGJMdzNLUUpR?=
 =?utf-8?B?MUc0WStNTE1zMkRvcDFpajJkZmY0akJVTlJtdnJ2WWxOT0piTXdtY3l2Vlcr?=
 =?utf-8?B?TCtGRkNZWWxwOWRFMFl3VHRDckNsWUJtYnNQVkptQnRhRCtTUitkYjVVbkJ5?=
 =?utf-8?B?MzJpaXZKZVN6VjVubnAxU1Nkd0ZZY2RFdEhDT1p5VkRseHQ5NlJRa3liNTRY?=
 =?utf-8?B?cDNrYXpCNzJSdjNjbGxLcnZVSzMwdStTZEU5RU9YT2I1S3ZhZWh0R2lOcHpi?=
 =?utf-8?B?eTJDbUNrQnV2MjU4TmI0N24vdFo3TWdnUzlkR21kNWtaVlJFa3lqb01CTVpo?=
 =?utf-8?B?bTMxVjVKVzlkUHRLWWs4STIzaVVzbklQTVA1ekFNU1MwY0VSQ0w3RXRLYzZS?=
 =?utf-8?B?TFhrN1BTbkJKdkpPNFRWUFNWOHZwTVB0WDZVVi9Ea200ai9EOU1NemxtN0Zz?=
 =?utf-8?B?dDVvYW4xN1hLclZkNHVQblpqR1VScXY2L0tNQmdpWWJ1bDQxdjdYSW10WmR4?=
 =?utf-8?B?TkJyVllMZHlkV1hieUFMeGVGOE1tem9qalJlaWlkV2VhZENpMVN5QWU2NXAr?=
 =?utf-8?B?RndZY1pSczM5bU5Yb0wwUFp0cHhySWplT1d3QmVJOXppc2tmc0M0RSsyUGI1?=
 =?utf-8?B?YjgweExrR29WbWl1U3JwNnM3a205QW84Z2poRUMzSjZCRVhXNFR0RTBkR0NM?=
 =?utf-8?B?dWswYWlRN00rVWFac2VodTlHYXpQR280NEJSMmk1bG85cE9QRW5NOFBNK0dD?=
 =?utf-8?B?YlMvZlF2eXJVNU5GeWl5bDZUSEpjcExSNHoxU0x5WTA0ajlQc0dleVQ3TGRS?=
 =?utf-8?B?RFBQYzVPVENPdEYxclNHWW1Vak4zZTVlZG45UFNVWFhRcWthU1Z3TCt1dW00?=
 =?utf-8?B?Rlo2QzdjRmVReEVORHlvbXdVOXpqQ0ViOEt2TEV6SlJwWXBzeTRXbCtUcWVR?=
 =?utf-8?B?cWNRM3g3bzRXNTVPdlJGM1R5T0NDMDhCdHVWWXRKb1VoUEI0VTZjSWVXWk1M?=
 =?utf-8?Q?skewnywbWINsCQSThnRUPJ1h38UP6l6BUDDXaTsGRuXWJ?=
x-ms-exchange-antispam-messagedata-1: DqqQldhL+I+HEQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <4AE3CDCB584C314985B45BEB5D51BCFB@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2671.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df5434b-ebf5-42df-5957-08da502ce969
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2022 06:45:05.0968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1CGwYx+CaIrA6WICaD/MY52syzu8gyIU99K7RrkS9pfmfa/VewiceFSpMQMAUNE/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3897
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

T24gVGh1LCAyMDIyLTA2LTE2IGF0IDExOjI1IC0wNDAwLCBHYWJyaWVsIEtyaXNtYW4gQmVydGF6
aSB3cm90ZToNCj4gQW4gTG9uZyA8bGFuQHN1c2UuY29tPiB3cml0ZXM6DQo+IA0KPiA+ICsgICAg
ICAgIGlmIFtbICRzdHIgPX4gXlswLTldK1thLXpBLVpdJCBdXSA7IHRoZW4NCj4gPiArICAgICAg
ICAgICAgICAgIHNpemU9JHtzdHI6OiAtMX0NCj4gPiArICAgICAgICAgICAgICAgIGVuZGNoYXI9
JHtzdHI6IC0xfQ0KPiA+ICsgICAgICAgICAgICAgICAgY2FzZSAkZW5kY2hhciBpbg0KPiA+ICsg
ICAgICAgICAgICAgICAgZXxFKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IG11bHQ9JCgobXVsdCAqIDEwMjQpKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDsmDQo+ID4gKyAgICAgICAgICAgICAgICBwfFApDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgbXVsdD0kKChtdWx0ICogMTAyNCkpDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgOyYNCj4gPiArICAgICAgICAgICAgICAgIHR8VCkNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtdWx0PSQoKG11bHQgKiAxMDI0KSkNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA7Jg0KPiA+ICsgICAgICAgICAgICAgICAg
Z3xHKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG11bHQ9JCgobXVsdCAq
IDEwMjQpKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDsmDQo+ID4gKyAg
ICAgICAgICAgICAgICBtfE0pDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
bXVsdD0kKChtdWx0ICogMTAyNCkpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgOyYNCj4gPiArICAgICAgICAgICAgICAgIGt8SykNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBtdWx0PSQoKG11bHQgKiAxMDI0KSkNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICA7Jg0KPiA+ICsgICAgICAgICAgICAgICAgYnxCKQ0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIDs7DQo+ID4gKyAgICAgICAgICAgICAgICAqKQ0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVjaG8gInVua25vd24gc2l6ZSBk
ZXNjcmlwdG9yDQo+ID4gJGVuZGNoYXIiDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgZXhpdCAxDQo+ID4gKyAgICAgICAgICAgICAgICBlc2FjDQo+ID4gKyAgICAgICAgZWxp
ZiBbWyAkc3RyID1+IF5bMC05XSskIF1dIDsgdGhlbg0KPiA+ICsgICAgICAgICAgICAgICAgc2l6
ZT0kc3RyDQo+ID4gKyAgICAgICAgZWxzZQ0KPiA+ICsgICAgICAgICAgICAgICAgZWNobyAic2l6
ZSB2YWx1ZSAkc3RyIGlzIGludmFsaWQiDQo+ID4gKyAgICAgICAgICAgICAgICBleGl0IDENCj4g
PiArICAgICAgICBmaQ0KPiA+ICsNCj4gPiArICAgICAgICBzaXplPSQoKHNpemUgKiBtdWx0KSkN
Cj4gPiArICAgICAgICBlY2hvICRzaXplDQo+ID4gK30NCj4gDQo+IEhpIEFuLA0KPiANCj4gQ29y
ZXV0aWxzIGhhcyBudW1mbXQoMSkgdG8gZG8gdGhpcyBraW5kIG9mIGNvbnZlcnNpb24uICBJIHdv
bmRlciBpZg0KPiB3ZQ0KPiBjb3VsZCB1c2UgaXQgaGVyZSwgdW5sZXNzIGl0IGlzIG5vdCBhdmFp
bGFibGUgYWxsIHRoZSBwbGF0Zm9ybXMgdGhhdA0KPiBtYXR0ZXJzIGZvciB4ZnN0ZXN0cywgdGhv
dWdoOg0KPiANCj4gJCBlY2hvIDFLIHwgbnVtZm10IC0tZnJvbT1pZWMNCj4gMTAyNA0KPiANCg0K
SGkgR2FicmllbCwNCg0KVXNpbmcgbnVtZm10IHNob3VsZCByZWR1Y2UgdGhlIGNvZGUuIEJ1dCBp
dCBicmluZ3MgbmV3IHByb2JsZW1z77yaDQoNCjEpIG51bWZtdCBkb2Vzbid0IHN1cHBvcnQgbG93
ZXJjYXNlDQplY2hvIDRrIHwgbnVtZm10IC0tZnJvbT1pZWMNCm51bWZtdDogaW52YWxpZCBzdWZm
aXggaW4gaW5wdXQ6ICc0aycNCg0KMikgVGhpcyBjYW5ub3QgY2xlYXJseSBwb2ludCBvdXQgdGhl
IGVycm9yDQoNCjMpIFZhbHVlIHJhbmdlIGlzIGxpbWl0ZWQNCmVjaG8gMTZFIHwgbnVtZm10IC0t
ZnJvbT1pZWMNCm51bWZtdDogdmFsdWUgdG9vIGxhcmdlIHRvIGJlIHByaW50ZWQ6ICcxLjg0NDY3
ZSsxOScgKGNvbnNpZGVyIHVzaW5nIC0tDQp0bykNCg0KNCkgQWRkZWQgc3lzdGVtIGRlcGVuZGVu
Y2llcw0KDQpNb3JlIGNvZGUgaXMgcmVxdWlyZWQgdG8gc29sdmUgYWJvdmUgcHJvYmxlbXMsIGFu
ZCBub3QgZWxlZ2FudC4NCg0KPiA+ICsNCj4gPiAgIyBDcmVhdGUgZnMgb2YgY2VydGFpbiBzaXpl
IG9uIHNjcmF0Y2ggZGV2aWNlDQo+ID4gICMgX3NjcmF0Y2hfbWtmc19zaXplZCA8c2l6ZSBpbiBi
eXRlcz4gW29wdGlvbmFsIGJsb2Nrc2l6ZV0NCj4gPiAgX3NjcmF0Y2hfbWtmc19zaXplZCgpDQot
LSANCkFuIExvbmcgPGxhbkBzdXNlLmNvbT4NClNVU0UgUUUgTFNHLCBRRSAyLCBCZWlqaW5nDQo=

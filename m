Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235B4C19F28
	for <linux-fstests@archiver.kernel.org>; Wed,  3 Aug 2022 06:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiHCGsz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 3 Aug 2022 02:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbiHCGsy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 3 Aug 2022 02:48:54 -0400
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9A114D2C
        for <fstests@vger.kernel.org>; Tue,  2 Aug 2022 23:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1659509333; x=1691045333;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OZNTJeL2jnUrqWgQlEeiZ2B35wd91mYOQ9N7b77j72o=;
  b=p/nizWiy0kGaiRVWZjvRGMM3sZVu2AJw/rXtkMNkPkuixbcNkEMuPHwi
   xc/CVZSZ5AWC3Z7BC4uPFWPZju74T/Ukm/E5ghgkwYdn5uXjqF8X3JPR1
   wpPAvU1rDnZnYHQ08mjx9E+5fcXFoRMTCcNYMk8ObE22ByZPuhbEQGYpr
   gCLrDbt/wZWlTbeTp3fAM248ltCa3759im7E2sSFP6LQVPZd6Sbxp264s
   d4lp1DMyeULEB7Ye29WhkOhU+bxTHcbE5BvCPWaZnDFwI5M7Ba08zL2uc
   sOXBCbo9SsKmTomdWR0/x1zXEjRxrKNqeRkXqX1nDwWXG6Jedu0svicrU
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="70222552"
X-IronPort-AV: E=Sophos;i="5.93,213,1654527600"; 
   d="scan'208";a="70222552"
Received: from mail-tycjpn01lp2172.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.172])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 15:48:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbqsrKdzuRYftuoef/karNOCZki8StxzdxFYSAsFxD/dTwuJtiT4Qhklsc+Ox+/SqDEs+ssIlKCcdEdlO7KHGOTSIZ1Ipo2gV4RcFYLBMegZBSv3lOLbToO00jrYZmRqTKH+PEpkt2hApe0UVWbVpvb1H9B5m663w8kh5LDWT/TbDY+sOv3/nlKovRqDoeRUmQ5paofxB6F6inM4+9CQkfdfGSxkOH4C+UIdkqV+fx0eny5DSfmnqfBcl0pyEhAgFICL3KM7hX3n+GT08YVzVsBjQyLeVaQ+7y07JfBnWtVfbfJv2cOBIY2h9PYaSB1wY0GiBrqqN6vY4cUaeaTbBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZNTJeL2jnUrqWgQlEeiZ2B35wd91mYOQ9N7b77j72o=;
 b=aftZr2TJAGhfqKdO5Y+O02tc2IK31eWv6sSnsC+kRK+1IiER9U+3hTAjQYLn536uAmWEm0HYkaMdAuDMsUdxQFguMcgGPV8ymURpwsKXYumr509+IPZQdlRuMglaUWItfKWX6y2ZRjbwiohe8/e0qHKHpGnM1C7LQmB1pCqIFwI1Z56smoMU57kI3JZtYb1B0mJvkXfe2R1HwAJvfhPQnh1glpZeQI8Hp3F/91chMue9Jby60rsJOaoIfT7Wib9U4qZH67+BOog6g2tgHA1etFUuYerQ1m2UGgKpJJ5f4kilJxD2JgHSmYuRk8YcDnouqrXA8RdI7WPZjOI4cMZaOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB6481.jpnprd01.prod.outlook.com (2603:1096:604:107::13)
 by OS3PR01MB7825.jpnprd01.prod.outlook.com (2603:1096:604:178::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Wed, 3 Aug
 2022 06:48:47 +0000
Received: from OS0PR01MB6481.jpnprd01.prod.outlook.com
 ([fe80::ccd:ccc6:1a42:94cd]) by OS0PR01MB6481.jpnprd01.prod.outlook.com
 ([fe80::ccd:ccc6:1a42:94cd%9]) with mapi id 15.20.5482.016; Wed, 3 Aug 2022
 06:48:47 +0000
From:   "liuyd.fnst@fujitsu.com" <liuyd.fnst@fujitsu.com>
To:     Zorro Lang <zlang@kernel.org>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "djwong@kernel.org" <djwong@kernel.org>
Subject: Re: [PATCH] generic/688: Skip test if fs doesn't support security
Thread-Topic: [PATCH] generic/688: Skip test if fs doesn't support security
Thread-Index: AQHYpkTjL44pREWUQEOnjgSDKcleL62bVLMAgAFpAwA=
Date:   Wed, 3 Aug 2022 06:48:47 +0000
Message-ID: <4e39344d-bc71-1b6b-f23e-07627c76a983@fujitsu.com>
References: <1659426760-2-1-git-send-email-liuyd.fnst@fujitsu.com>
 <20220802091700.d2e3u7defue7kwbd@zlang-mailbox>
In-Reply-To: <20220802091700.d2e3u7defue7kwbd@zlang-mailbox>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b4d2b57-766d-409d-451a-08da751c3791
x-ms-traffictypediagnostic: OS3PR01MB7825:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6lvHjPYSAHAschRZolpbGYKd4188ueoNy7cZMsKZX6507cMXB1Ijcrf9aQNYzsRRN+Pv5Kpe6dOaXr/2ehFoJsDWhv7AI7jxu8CMw9FLihaQgSZwtj8gZimL8z6SzV3FmTxCK5IG1b76mcEcGY0RgO7bZk1WpTfNNOqnfiMMgo7h9ORC0DO56adZmAdQ3XkgV8syBVLr/endLWD0AXO1pdcMCW8YqrHTH24ztFdlMC/0Ad2hk2aN/UnGmSjRI/msnSPl4n8z1D1unwSzRCvlQEngbRl5VGuLTkB2n8AaolX6YWLN8jtdvC5pMOI9K2bbQH/sSxteaKwvzTpEkTrFZYV7kDHexvTpwyYCr4CcprC5qUSFHwNAOmTU5eFGpU5+MrBOepUJoqal1GntLMu9dwjtnVwUyTuOX8iRoC7B1jWRehc2QjG13m9mhp5d1/mW7cd//LpJ1NOQ/2ort8jKZCQEumyUrh0srAIp8lgBtYmwDvFkxSUYH05cGDpixecFewB997K8LKsEt4fEuKYU1LzE9Zb8uO80buhidiq+gmPB8oi0bXY1KhZH/ZTpaHxfLIW1yfAvRPEQHLU4O/fDrLD9N3OXXPH3souPwquBBfpHgPAv5mE4Ha7xXUSUp8Z416L4So4aIinwtmg/nV9JqIGy/5RLMZpGgyi5i2dI4rmE0YUcD7d6wLFluXNLcUD40JDA5SMWJeHMr19vmK6ky7lLmjHL0rPhX8IQNFfh6ySYzvT23+Rf9+raWmj8YDKGLzJZDieIXvzUalopQPqC31hGzq6GYQuZ6lZl1czwg6UWHa0BgjDIxwKMQ3x8BSEIeu45YzA957klcLQFdcS5YmFFNyckPfgZFYHNZbHYuHTNoKLcEpW/zCeIAgIxNDUHoyTEO05FOM7mIaInY97w0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6481.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(478600001)(41300700001)(82960400001)(6916009)(15650500001)(54906003)(2906002)(8936002)(122000001)(6486002)(966005)(5660300002)(316002)(38070700005)(6506007)(38100700002)(2616005)(31696002)(66476007)(91956017)(71200400001)(66556008)(64756008)(66946007)(86362001)(53546011)(85182001)(186003)(76116006)(36756003)(31686004)(4326008)(26005)(6512007)(8676002)(83380400001)(66446008)(41533002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkxsREVxM2NDSjlBSmkvbnN1cHJlMUhIeklxSzlMN0ZPTjBrUWlaaXZxSlFD?=
 =?utf-8?B?WVQ4ZDdOQXFnak9Ccmo3ZCtGOEFveFZMWVJOSXcxRFpZL3FkVzNzTmxlalps?=
 =?utf-8?B?ZHRtYThKTkJCam5OOGI2V3NxVHNEV2tzWlE0UkpJNGx4UE9DYjZoeGZQdWhC?=
 =?utf-8?B?MzM5VCs2bTlyZ1M3Z25oaW5XZEQxcEZJWXJYNkR0ZUE4REUxV3lSRnkwUURI?=
 =?utf-8?B?dmFrenMrQTFXbyswTE5scWRoTTNjaUJwN1BwMGE2eFRDTnhqUWJsVi9jc3pz?=
 =?utf-8?B?amxCOGphTVVtRzBnaTNmRURNS1NZYTV0eVhzL2JtakM2OW84VTM5S2RYQmhW?=
 =?utf-8?B?UVZIeHNCbmZFakVRMmpaMm5RVXVRb3NybGdERGpieUJWN0dRMWdRTDBvbTF4?=
 =?utf-8?B?RFJ1a0RlRHltRTVseHZieXhTOG5xay9xcVByMmdFZjdGNnNDUHhOUU1ZdzM5?=
 =?utf-8?B?SXBJSUcrRDR1YTQrWmNsWHJBT01HaVA5MnNJQXM1RFhhbU5YYjRsVlJybFcv?=
 =?utf-8?B?bGJOdE5QZmNqa0Z3KzVTeWlUYXhvcFJEeDUyTk5HWXlGaWYyNTFVRmpya01I?=
 =?utf-8?B?VmtjQ3c5ajFBM1ozWEtGcGxyV0V0YXdGR1hjaXd6enY5R0hkV3BzVU9obzJN?=
 =?utf-8?B?bFV6QkFDK1IyS2Z6SUxPa2dzTUxRVXFBNHJ5TGkrNWNyMWZSdEs1a01rMHBN?=
 =?utf-8?B?UktaWkc3NUg1cEU3TTNDSlRyWUUxMjB4WW1UMkV6K3NvSDQxWFkyQ2pxbWF2?=
 =?utf-8?B?Tks3bUM2N1lKaGEyK0JYOGMvcjgwT2c1cVhMUWVWQlg1VzZiMzNrei9uSXRj?=
 =?utf-8?B?YVJUVElGVHNxMUZLVy9HUXBvdXNmaittN2VKT0ZCc0VYRU9OWVBkcFh0SnBx?=
 =?utf-8?B?WnlONWNsczVlalVkVTNUNlp1dE1oNFgwN1JGdVRRMjRlUCt6eml5U29rUExI?=
 =?utf-8?B?bzczaURzRXcySStaR2V4cUwxMU1SLy9oRng3d0tZb0hUN0lRWmZqcW94Lzhj?=
 =?utf-8?B?V0lLNWFvbWxLMEVBem5xQVhIOHp2eG83WFl6cWQ3MU5SMk4xM2RnaFk5UENC?=
 =?utf-8?B?UmVEcFE2dWlFSlVTMXdKVGI2RHc0Tk5qNVdEb0FIbStzNjZGNDMxaGVRalJT?=
 =?utf-8?B?RDBQejU5clBwbFozNktXeFB0OWhJK1oyakdtd1NWcnl5K0EyQTJyVW5ENWVO?=
 =?utf-8?B?dnR0Z0oxY2hVVUdHbkF4V21NNUUzVGtkck5VbWFTSFhqS2ZOYVVBSC8xbTkr?=
 =?utf-8?B?ampwOHE2L3FGOHZaVDhvTnhDUlVlckVGdG1zT2x6K3gxbyttcVVtYlg3alVK?=
 =?utf-8?B?K0hvbCtHRjFDdldKaW9YOWkwZTVYc09WS1RGcjBmVVpESVVSTGhzdEFqQTh2?=
 =?utf-8?B?VVY4eERmSWV2RmJrOTdxcnM2VGgxRnV1M0UxTlVCM0dyRC8yODF1YWZ3aGk4?=
 =?utf-8?B?ZE9rL2hsYk1QcWtFRnE2ZVhhUGl0Q3lnbllSSEhadTRmQWtNTFZuaW9TOUVw?=
 =?utf-8?B?YWtJdVZKZFlxWThOcDRuWG9Qa1Y3SGMybTh5eGZsUFJOR2Z5bjZkTkQyU1pY?=
 =?utf-8?B?LzhEQ0p4UlBXd3dSNC9kTkVIRS9KblRHcWtGeVB6by9iR0kvalRmSUIvRjRE?=
 =?utf-8?B?OVpLQ1gzd2JDSkFWOUtrOWxJRnFHVndTVnU0K1hKVjBtYWhqN2xYb2ZaTmJt?=
 =?utf-8?B?dzBJRUM2eW1xMktRWG9WQ3ZwQzdtSTZEVGt5L1JtSXhEbldDeWR4S29QSDZD?=
 =?utf-8?B?OVNCMS9xdnBkeEUvME81blMzazhZT3pQU0dxNWJ1T2NGVU1FZUp1djhZTTZO?=
 =?utf-8?B?WHFvMEZ2NVliaUFqcnc1WDM2Y3JVeWg4Myt4c01FbHlDRVFVcjhYMEJIaUVO?=
 =?utf-8?B?MG1OajIwU25pdVpGMVFKalJVZXBEdkx0aGZaTFIvdnFWdGlQRW1HdyttUFN1?=
 =?utf-8?B?MytCNFBsbjZCYmpGbGt1NFExUUNhQXp3cWRBdmI4bjJpTzNIVDA0cEtoNFgw?=
 =?utf-8?B?L0REUFE1eUhwQ0NlajNrSHFhUnJVaGl0ZG0zWUU4bWpSRkRmSWlWUU9VRjlo?=
 =?utf-8?B?MDJRKyswZ0JKbFZDNU5xV2hLbk45YVFnaEUyNG5UOS8xQXpZYTRhTW9aNGNX?=
 =?utf-8?B?dFhjUEJuZEpOVFNIa1VuTm1MNnNiMjF6M0VDT0IwT1htQ0RsN0JjeEo3R05N?=
 =?utf-8?B?OEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <177C4F8725532145B950857A657CE234@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6481.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4d2b57-766d-409d-451a-08da751c3791
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2022 06:48:47.7835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ft9+Ww5BMHXgX4/dmD3dhA/QgNls2KGn1WI+N/cpxIb+mcJYthUqGa0V0ZKncLV4+tIMLyq4qlZA0e/cTU5EVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7825
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

SGkgWm9ycm8NCg0KT24gOC8yLzIyIDE3OjE3LCBab3JybyBMYW5nIHdyb3RlOg0KPiBPbiBUdWUs
IEF1ZyAwMiwgMjAyMiBhdCAwNzo1Mjo0MEFNICswMDAwLCBMaXUgWWlkaW5nIHdyb3RlOg0KPj4g
VGhpcyB0ZXN0IHJlcXVpcmUgc2VjdXJpdHkgYXR0ci4gU2tpcCB0ZXN0IGlmIGZzIGRvZXNuJ3Qg
c3VwcG9ydA0KPj4gc2VjdXJpdHkgYXR0ci4gRS5nLiB2aXJ0aW9mcw0KPj4NCj4+IFNpZ25lZC1v
ZmYtYnk6IExpdSBZaWRpbmcgPGxpdXlkLmZuc3RAZnVqaXRzdS5jb20+DQo+PiAtLS0NCj4gDQo+
IEhtbS4uLiBsb29rcyBsaWtlIHdlIGNhbiByZS1zdGFydCB0aGlzIGRpc2N1c3Npb24gbG9uZyB0
aW1lIGFnbzoNCj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2ZzdGVzdHMvMjAyMjAzMjMw
MjM4NDUuc2FqNWVuNzRrbTdhaWJkeEB6bGFuZy1tYWlsYm94Lw0KPiANCj4gQWJvdXQgaG93IGNh
biB3ZSBkZWFsIHdpdGggdGhvc2UgZnMgZG9lc24ndCBzdXBwb3J0IGNhcGFiaWxpdGllcywgZS5n
LiBuZnMsIHZpcnRpb2ZzPz8NCg0KQWhoLCBzbyBJIGRvbid0IG5lZWQgdG8gc2VuZCBhIHYyIHBh
dGNoIHVudGlsIHlvdSBmaW5pc2ggYWJvdmUgZGlzY3Vzc2lvbi4NCg0KPiANCj4gVGhhbmtzLA0K
PiBab3Jybw0KPiANCj4+ICAgdGVzdHMvZ2VuZXJpYy82ODggfCAyICsrDQo+PiAgIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvdGVzdHMvZ2VuZXJp
Yy82ODggYi90ZXN0cy9nZW5lcmljLzY4OA0KPj4gaW5kZXggNDI2Mjg2YjYuLmQxMWI0YzIxIDEw
MDc1NQ0KPj4gLS0tIGEvdGVzdHMvZ2VuZXJpYy82ODgNCj4+ICsrKyBiL3Rlc3RzL2dlbmVyaWMv
Njg4DQo+PiBAQCAtNyw2ICs3LDcgQEANCj4+ICAgIyBGdW5jdGlvbmFsIHRlc3QgZm9yIGRyb3Bw
aW5nIGNhcGFiaWxpdHkgYml0cyBhcyBwYXJ0IG9mIGFuIGZhbGxvY2F0ZS4NCj4+ICAgIw0KPj4g
ICAuIC4vY29tbW9uL3ByZWFtYmxlDQo+PiArLiAuL2NvbW1vbi9hdHRyDQo+PiAgIF9iZWdpbl9m
c3Rlc3QgYXV0byBwcmVhbGxvYyBxdWljaw0KPj4gICANCj4+ICAgIyBPdmVycmlkZSB0aGUgZGVm
YXVsdCBjbGVhbnVwIGZ1bmN0aW9uLg0KPj4gQEAgLTI4LDYgKzI5LDcgQEAgX3JlcXVpcmVfY29t
bWFuZCAiJEdFVENBUF9QUk9HIiBnZXRjYXANCj4+ICAgX3JlcXVpcmVfY29tbWFuZCAiJFNFVENB
UF9QUk9HIiBzZXRjYXANCj4+ICAgX3JlcXVpcmVfeGZzX2lvX2NvbW1hbmQgZmFsbG9jDQo+PiAg
IF9yZXF1aXJlX3Rlc3QNCj4+ICtfcmVxdWlyZV9hdHRycyBzZWN1cml0eQ0KPj4gICBfcmVxdWly
ZV9jb25ncnVlbnRfZmlsZV9vcGxlbiAkVEVTVF9ESVIgNjU1MzYNCj4+ICAgDQo+PiAgIGp1bmtf
ZGlyPSRURVNUX0RJUi8kc2VxDQo+PiAtLSANCj4+IDIuMzQuMQ0KPj4=

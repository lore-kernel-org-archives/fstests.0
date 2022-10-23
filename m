Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94B2C3A59D
	for <linux-fstests@archiver.kernel.org>; Sun, 23 Oct 2022 06:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiJWGmj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 23 Oct 2022 02:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJWGmi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 23 Oct 2022 02:42:38 -0400
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FEC74CE1
        for <fstests@vger.kernel.org>; Sat, 22 Oct 2022 23:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1666507357; x=1698043357;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lw3O4wWJMXbEro0dHn8kS4hpLQn18vgOAeGG3+QP+W8=;
  b=EqNZX9VHVgnAJFpYoGs+vgJPagmfFutSzNamCBNKTBIE5WYduVp+FzU4
   lpCC03ZekopxUhJKmIA7he8PtH6Njb6+fk5nPaYxOlvUKI02/6UGpoX13
   wQljM083MCDS7FWltoR0RMZCLYZ5/W+0nPDXqn5kKrijBTDB4C7af/BnH
   GC6WK0bxSZ2+YgtVob447WNQ5MZP1yP1lpLpzbaeeVD/WDg5bYNKglCdo
   CQ9l/wuSS82ngxA6jZhkQYpRjeKjV7oFe6cPlEnu/9KFLtkjPvJk6c/Ye
   9Qc/kS+8XszSnBHVsh22qQUp32THpbn6WcdlJV/kj/0qrx965XCxaqHCP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="68289484"
X-IronPort-AV: E=Sophos;i="5.95,206,1661785200"; 
   d="scan'208";a="68289484"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 15:41:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brPQMCyTEV3W2yavIHwkX9+/aq9U8Pky9CH5PU2KypoS312mxt7oE7NQwgz5K+1jcB4IfIDe4l+l3PR+HMeTB4I8LnJuF2hfkNX0p369PzYHYnd3AewjAJIrSrFbYQP9iBKwZPN9LIffOG2On8xmn75Su72IqNpiOdhkwqDnk878+RI4pqUUN1ckjsJLnju2Xc33NbOjSjoE4TQV6cewF8hZhtYTdNM61ZJ2UKZZck5huCXZckFruIv5xP055dVM7UKutlMqjZU/kEK4ErbOYjE8o4EY24ZmXpmaC9xGNqv9xP4yapY8F8M0AqgnaJXPMFeWw/VmKW3r5O2ham3Brg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lw3O4wWJMXbEro0dHn8kS4hpLQn18vgOAeGG3+QP+W8=;
 b=hh4JO2oyoW6UvRiRkHkvFSezLcisZZHlQEAM8O3OWl0br1W1curCmIncseEovmTljItBC3rokthjcwLGOCabg5Vbp3oxy9QabEh0/MabuHFHtmIK4zusDHiel+58Taz6Jh6tQZhzwSSeG0RHDmRKc2N7GDrTPTVqbpyJIYJl485OFHY2BS3RvPWV9v9iUTUe3BLHAWt4YQVo/H12dl8h7tLSGE6apem9J0Qm3OGeuPOonVb28Lt9nKT/w+BnIhlgAezELg5RQm9nk8RVsiket+4iA2M4jZ/9nITkzeU4RigZ710n/o1MOvWhrOINdIGlB8SuMmBRDraoPCcJeSMFWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by OS3PR01MB10026.jpnprd01.prod.outlook.com (2603:1096:604:1e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Sun, 23 Oct
 2022 06:41:26 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::339e:88a3:a24c:5f68]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::339e:88a3:a24c:5f68%9]) with mapi id 15.20.5746.021; Sun, 23 Oct 2022
 06:41:26 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     "djwong@kernel.org" <djwong@kernel.org>,
        "zlang@redhat.com" <zlang@redhat.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "bfoster@redhat.com" <bfoster@redhat.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Subject: [PATCH 2/3] generic/470: Replace thin volume with blkdiscard -z
Thread-Topic: [PATCH 2/3] generic/470: Replace thin volume with blkdiscard -z
Thread-Index: AQHY5qp5+nA2dI8SXUuLzIktkmfelg==
Date:   Sun, 23 Oct 2022 06:41:26 +0000
Message-ID: <20221023064122.846926-2-yangx.jy@fujitsu.com>
References: <20221023064122.846926-1-yangx.jy@fujitsu.com>
In-Reply-To: <20221023064122.846926-1-yangx.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9499:EE_|OS3PR01MB10026:EE_
x-ms-office365-filtering-correlation-id: 62e9c9ca-8ecb-4f76-e33b-08dab4c19c10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: luk27MJJhil8xSroC/Tlbd2w0Xj/Th+S/SJ9ciOcXuUgJgLFtwv3zoqVNGNtyB53Bm+r9FpaJy6jkuw5lidUluhiLgc2Xlu785tuCcYifH57mXGWubJRgniftoV22G9JbtfYFHaIqCu7tMKXFR2r0z9WQOjeISMbDrkfJ12YvJPJn1EzTI4+wFSYau32x4XoFESWFqZOofSgeyD/dy5ptOYjsVTMkYjJkrdHMTQJiEHMGlyj5Tgsn2iuIceh57OaHbFsba9Uj003/XlyITG27i2U5i9FUg4e3P5Xc9VfzpSoaBuEpic479kTYTAD/uphONzba+RMNDs9f9h7IyWDl0EwdcMXaJrn1ceY7pzsToDY9MRns9TQwriMD06f0eEb5KvKynpbGfWvrDzdS/4fwfkjrmhED7YKwrgzbfkZSJnageR+jLJy+m0nxU+fO8KVcLltk/sfoT9ynZe3sXk6qb48V2eGRtrgdJE53dUjG1EimGfuEVPz256ULL2FEilZPCl2uGR9JXzUkzPJ4OOPa8yjxDQXRcHBAShIhDWkuugnWYJYOB98WkyNbNK0AFFzIi9QVU1zkLo0N0cd9ZC4rZ2QqzVEAvUYOTARAmII83PTGn1zLmVKIuocwoCYD54Wc6EXIHsbb+4QfMIepIc/vkQ8aXSlU4owwR5yIDyl0Hkyw1X44VHr+9PuuB8rBwrzRjPJiwnbGL2Z4a1BRPuRX1BoI3gjoVLH/h8x5Nx6hkcORs/M94gXoKEqkz574NBN1G+AbEO+82uU79+4YLZaANUrnXrIkmcpF1xYrNk3u+W1/vfASeUftNz4zYLhzgF5nTmjLRaSq4b1fte+WTect7AT29Q7GlWsRqxxcb+Lwu5eaQsebB9qLRlF+bo+taadxmCUqzHkIaUrB3Us0pwrlQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199015)(1590799012)(478600001)(122000001)(38070700005)(6486002)(966005)(1580799009)(71200400001)(54906003)(110136005)(316002)(26005)(8936002)(66556008)(8676002)(5660300002)(64756008)(76116006)(66476007)(66946007)(66446008)(91956017)(6506007)(4326008)(85182001)(36756003)(41300700001)(6512007)(2906002)(38100700002)(83380400001)(2616005)(107886003)(82960400001)(186003)(1076003)(86362001)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?NUhFNmthVG1TTkVrSDlMZTgwc1JFYURVMDU0MGQveU9oU1pIU1c1QWJOaThs?=
 =?gb2312?B?YVBLMnJuMVBzcFJhN0RrWkdLYk1zT0RYZ3JKYkE4TUdzUjdsY0NHcHdmV05M?=
 =?gb2312?B?b2U3ZW9mdXFyVzlDbU50ZkU5QWV1UitPNFI4WmNvZXZNN09CSkpOdndyZnBh?=
 =?gb2312?B?d0wwa09pSjRGUTRVQitRUW1UdEtqVzlORVVMUFRhdFNVYldhZk8vcjRuTlRJ?=
 =?gb2312?B?RnJVOVpkNDRydlQyK2Y0NzVsSFhNOVliajhMV0ZqNVpRb0haM2dHcE96YVJT?=
 =?gb2312?B?QVhPc2wvM2ozVTZldFl3N21VSWFsM2RlUU1DWnNKajhyYzVUQ1grM0NBenVa?=
 =?gb2312?B?bHBjdFpwWEVROFFIRzk5cUx5Z0U5UlVXZG5sS0FzTUE2ZTIvZnVXOUd5aTFN?=
 =?gb2312?B?VnJyakVLVTZ4TnYrNFRLcGZVQndMa1BHdHVjYmhCbFRFRkNISjBZQUNwR1By?=
 =?gb2312?B?ZllHdU43SCttNGtZQ2x6RFhsTllxSitzT0sxazR5aVkxQkZPSlk2MDFzbmRX?=
 =?gb2312?B?cVp1QVBlRE5jUWpmaU1tdFZjL2Y1eEFUUGw1MHgvbWM0c29YMFJjQ2V4VUJJ?=
 =?gb2312?B?VmtTWjEvdFFTOUVtaUc5cEw2UnZlaTBxQ0JTSlJRVm5tTkgwd0NvYzhxWGtm?=
 =?gb2312?B?YVZ4S2lnWkRHSkVxK3R1cUtVdllSemJIMnV2cmZxK21LeUUxNFpsdDRNeU83?=
 =?gb2312?B?anlGRjhpUnpiamYyS1MzUm1lUGY0MERCcGpGUGkycGxucmhZTElSa1NOcElF?=
 =?gb2312?B?UE5ucUwvNnJVOWhHR2VCM0crOHBTSkpOUEFTWU50aVRYWGhtUWYyMHZSMlpQ?=
 =?gb2312?B?N3ZLN1J1QjVEc1ZCUXVWYk9HSUY1emJ6bzBJT2o3KzdmdzhpOHBsTTVZa3Zo?=
 =?gb2312?B?QWIzMFNYQWlRR2s5YWZFR3phOVpMSS9SQTBNb0Fzd25SQ2VtRWZYdnRBRUJG?=
 =?gb2312?B?Y2c2OGMyVFlPQUxGSHlycnhwcGlobjljVCtCMEFXTDF0cERJN1ZYdlpQSmxn?=
 =?gb2312?B?Y00vNFlVUWdRWlRXZGhiOHBrZEpXTVJPRGxOTVNORFUydjJhOGg0NHAzb05T?=
 =?gb2312?B?VlNheWUzRjNoQjN3c3NIdzh1eVNQUU55eExYL1VqQVMzWlFEbFdoRFhvT1NE?=
 =?gb2312?B?UjF2L3BlbEZzYTRSeFBDVnBFeDZkc0lkaGt5RkZpbHorK0drTDEyRlZYbktk?=
 =?gb2312?B?K0tkRlRPbnY3K2t0dGxIUytSa2ZnN05hRGw2QjlqMDJKWC9DTlNOUjZtRXcx?=
 =?gb2312?B?RklhL0VUbENLZGxuck95UlZweWZxZzdBRUI2Yk4wUmVVWCt0K3ZOV29JTjBx?=
 =?gb2312?B?cmgyeDFsRHZWeEY4NnViYldmK2Q4ZGJWT2ZHL05tU3MzaTRxU2dDdWlXTFhG?=
 =?gb2312?B?Vno5U0xkck9qMW1jZ0MwbnNyckF6Y2RNVk95bjBKbDNJTE50cXNxQndlMC9y?=
 =?gb2312?B?ZTNpTFhmekg1ejFhYjNFdjdaa28wL3UwLzd5UjZEallSQXZ0c1hVYy9NSlRV?=
 =?gb2312?B?Z0p5RHpkaTZjLzFKdlJobUhHVDlWejBIclQyUzRCYjRvbEJSeFJISGIvdC9o?=
 =?gb2312?B?OGJSdktDalQ5b2ZQajl1Skk5VDI1MW10M2FrcGp5Mkw3eWVHczhFUERyTVg4?=
 =?gb2312?B?VVV5VDQrWXJLUjlOQU9oRytWU01oc3I5NmZyRTUvVTlsaFh6c2JBdG5YVVBt?=
 =?gb2312?B?akJZSWVWUkkzV0xna0I4V2F4b1V3bm9qVWMyTythelptd0tGNTZxOWZqcFNi?=
 =?gb2312?B?QUF2THZ2MkhqS3JsZUJPV2dxM20rZ3pBMnlySU5ObUdGOUdaN0RxWHMvaVRz?=
 =?gb2312?B?MGZ5NzVsano1bWh2Z0xYT2w5OXE3R1UzekhVeVRXKzBub09NYTI3R09wVGFV?=
 =?gb2312?B?WUIwQVR2cmgyY0RFT2Rld2FGdEN4VVRWVkkwUjVmYWJWeDN6Y1hBYlFFTm1H?=
 =?gb2312?B?QlNyQlZ3MkkwYjlZT1ZFOStYNVpKSUNMYW8yUU5jUE5DZFAwaW9Iejd5Vjdp?=
 =?gb2312?B?ajZab3BRMUl5a0hOS2NqeE95VFVXOEtaL0ROT2FRV3ZaRUFDWEN2MWxyT1U4?=
 =?gb2312?B?b1dsZUdIUHdIMUFOaFdXUHgyaG8zMFNpMUJvMmE5cWk0K0NKVEwzMEZmbTdu?=
 =?gb2312?B?UkhWR3QxWjVLaUEwNW4zaEVlS3F4MWZWUlRvNm9WWDlnejk4dHRsYUsxdW4r?=
 =?gb2312?B?b1E9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e9c9ca-8ecb-4f76-e33b-08dab4c19c10
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2022 06:41:26.4980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VfhuXrXzO9tSnTV71ZGYtVTxGqNqql5uEwEBYtD9WLan2oFcGNR00oF90k78Cfe4WMIfjoJwQJ0hbqhKJJ+hUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10026
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Z2VuZXJpYy80NzAgd2FzIG9yaWdpbmFsIGRlc2lnbmVkIHRvIHZlcmlmeSBtbWFwKE1BUF9TWU5D
KSB3aGljaA0KaXMgb25seSB2YWlsZCB0byB0aGUgREFYIGNhcGFibGUgZGV2aWNlKGUuZy4gUE1F
TSkuIFRoaW4gdm9sdW1lWzFdIHdhcw0KaW50cm9kdWNlZCB0byBmaXggdGhlIGluY29uc2lzdGVu
dCBmaWxlc3lzdGVtIGlzc3VlWzJdIGJ1dCBpdCBtYWtlDQp0aGUgdGVzdCBiZWNvbWUgbm90IHJ1
biBiZWNhdXNlIGl0IGRvZXNuJ3Qgc3VwcG9ydCBEQVguIEFzIERhcnJpY2sNCm1lbnRpb25lZFsz
XSwgZGlzY2FyZGluZyB0aGUgZW50aXJlIG1hcHBlZCByYW5nZSBvZiBzY2FydGNoIGRldmljZQ0K
Y2FuIGZpeCB0aGUgaXNzdWUgYXMgd2VsbCwgc28gSSB0cnkgdG8gdXNlIGJsa2Rpc2NhcmQgLXog
aW5zdGVhZC4NCg0KWzFdOiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vZnMveGZzL3hm
c3Rlc3RzLWRldi5naXQvY29tbWl0Lz9pZD1mYzU4NzBkYTQ4NWFlYzBmOTE5NmEwZjJiZWQzMmY3
M2Y2YjJjNjY0DQpbMl06IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2ZzdGVzdHMvMjAxOTAyMjcw
NjE1MjkuR0YxNjQzNkBkYXN0YXJkLw0KWzNdOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51
eC14ZnMvWTFOUk50VG9RVGpzMERiZEBtYWdub2xpYS9ULyNtZTBlNzdjYjBlY2Q4MGJmNGI1MTA5
ZTQ0MzNjYjQ4NjNhZTZlNjcyNw0KDQpTaWduZWQtb2ZmLWJ5OiBYaWFvIFlhbmcgPHlhbmd4Lmp5
QGZ1aml0c3UuY29tPg0KLS0tDQogdGVzdHMvZ2VuZXJpYy80NzAgfCAzMSArKysrKysrKysrKyst
LS0tLS0tLS0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDE5
IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvdGVzdHMvZ2VuZXJpYy80NzAgYi90ZXN0cy9n
ZW5lcmljLzQ3MA0KaW5kZXggZjM0MDc1MTEuLmQyODQ2YTM4IDEwMDc1NQ0KLS0tIGEvdGVzdHMv
Z2VuZXJpYy80NzANCisrKyBiL3Rlc3RzL2dlbmVyaWMvNDcwDQpAQCAtMTUsMzggKzE1LDI5IEBA
IF9jbGVhbnVwKCkNCiB7DQogCWNkIC8NCiAJX2xvZ193cml0ZXNfY2xlYW51cA0KLQlfZG10aGlu
X2NsZWFudXANCiAJcm0gLWYgJHRtcC4qDQogfQ0KIA0KICMgSW1wb3J0IGNvbW1vbiBmdW5jdGlv
bnMuDQogLiAuL2NvbW1vbi9maWx0ZXINCi0uIC4vY29tbW9uL2RtdGhpbg0KIC4gLi9jb21tb24v
ZG1sb2d3cml0ZXMNCiANCiAjIHJlYWwgUUEgdGVzdCBzdGFydHMgaGVyZQ0KIF9zdXBwb3J0ZWRf
ZnMgZ2VuZXJpYw0KLV9yZXF1aXJlX3NjcmF0Y2hfbm9jaGVjaw0KK19yZXF1aXJlX3NjcmF0Y2gN
CiBfcmVxdWlyZV9ub19sb2dkZXYNCiBfcmVxdWlyZV9sb2dfd3JpdGVzX2RheF9tb3VudG9wdCAi
ZGF4Ig0KLV9yZXF1aXJlX2RtX3RhcmdldCB0aGluLXBvb2wNCiBfcmVxdWlyZV94ZnNfaW9fY29t
bWFuZCAibW1hcCIgIi1TIg0KIF9yZXF1aXJlX3hmc19pb19jb21tYW5kICJsb2dfd3JpdGVzIg0K
K19yZXF1aXJlX2NvbW1hbmQgIiRCTEtESVNDQVJEX1BST0ciIGJsa2Rpc2NhcmQNCiANCi1kZXZz
aXplPSQoKDEwMjQqMTAyNCoyMDAgLyA1MTIpKSAgICAgICAgIyAyMDBtIHBoeXMvdmlydCBzaXpl
DQotY3NpemU9JCgoMTAyNCo2NCAvIDUxMikpICAgICAgICAgICAgICAgICMgNjRrIGNsdXN0ZXIg
c2l6ZQ0KLWxvd3NwYWNlPSQoKDEwMjQqMTAyNCAvIDUxMikpICAgICAgICAgICAjIDFtIGxvdyBz
cGFjZSB0aHJlc2hvbGQNCi0NCi0jIFVzZSBhIHRoaW4gZGV2aWNlIHRvIHByb3ZpZGUgZGV0ZXJt
aW5pc3RpYyBkaXNjYXJkIGJlaGF2aW9yLiBEaXNjYXJkcyBhcmUgdXNlZA0KLSMgYnkgdGhlIGxv
ZyByZXBsYXkgdG9vbCBmb3IgZmFzdCB6ZXJvaW5nIHRvIHByZXZlbnQgb3V0LW9mLW9yZGVyIHJl
cGxheSBpc3N1ZXMuDQotX2RtdGhpbl9pbml0ICRkZXZzaXplICRkZXZzaXplICRjc2l6ZSAkbG93
c3BhY2UNCitSQU5HRT0kKCg1MTIgKiAxMDI0ICogMTAyNCkpICMgNTEyIE1pQg0KK0xFTj0kKCgx
MDI0ICogMTAyNCkpICMgMSBNaUINCiANCi1fbG9nX3dyaXRlc19pbml0ICRETVRISU5fVk9MX0RF
Vg0KK19sb2dfd3JpdGVzX2luaXQgJFNDUkFUQ0hfREVWICRSQU5HRQ0KIF9sb2dfd3JpdGVzX21r
ZnMgPj4gJHNlcXJlcy5mdWxsIDI+JjENCiBfbG9nX3dyaXRlc19tb3VudCAtbyBkYXgNCiANCi1M
RU49JCgoMTAyNCAqIDEwMjQpKSAjIDEgTWlCDQotDQogJFhGU19JT19QUk9HIC10IC1jICJ0cnVu
Y2F0ZSAkTEVOIiAtYyAibW1hcCAtUyAwICRMRU4iIC1jICJtd3JpdGUgMCAkTEVOIiBcDQogCS1j
ICJsb2dfd3JpdGVzIC1kICRMT0dXUklURVNfTkFNRSAtbSBwcmV1bm1hcCIgXA0KIAktZiAkU0NS
QVRDSF9NTlQvdGVzdA0KQEAgLTU0LDE0ICs0NSwxNiBAQCAkWEZTX0lPX1BST0cgLXQgLWMgInRy
dW5jYXRlICRMRU4iIC1jICJtbWFwIC1TIDAgJExFTiIgLWMgIm13cml0ZSAwICRMRU4iIFwNCiAj
IFVubW91bnQgdGhlIHNjcmF0Y2ggZGlyIGFuZCB0ZWFyIGRvd24gdGhlIGxvZyB3cml0ZXMgdGFy
Z2V0DQogX2xvZ193cml0ZXNfdW5tb3VudA0KIF9sb2dfd3JpdGVzX3JlbW92ZQ0KLV9kbXRoaW5f
Y2hlY2tfZnMNCitfY2hlY2tfc2NyYXRjaF9mcw0KIA0KLSMgZGVzdHJveSBwcmV2aW91cyBmaWxl
c3lzdGVtIHNvIHdlIGNhbiBiZSBzdXJlIG91ciByZWJ1aWxkIHdvcmtzDQotX21rZnNfZGV2ICRE
TVRISU5fVk9MX0RFViA+PiAkc2VxcmVzLmZ1bGwgMj4mMQ0KKyMgRGlzY2FyZCB0aGUgbWFwcGVk
IHJhbmdlIG9mIHNjcmF0Y2ggZGV2aWNlIGFuZCBkZXN0cm95IHByZXZpb3VzIGZpbGVzeXN0ZW0N
CisjIHNvIHdlIGNhbiBiZSBzdXJlIG91ciByZWJ1aWxkIHdvcmtzDQorJEJMS0RJU0NBUkRfUFJP
RyAtZnpsICRSQU5HRSAkU0NSQVRDSF9ERVYgPj4gJHNlcXJlcy5mdWxsIDI+JjENCitfc2NyYXRj
aF9ta2ZzID4+ICRzZXFyZXMuZnVsbCAyPiYxDQogDQogIyBjaGVjayBwcmUtdW5tYXAgc3RhdGUN
Ci1fbG9nX3dyaXRlc19yZXBsYXlfbG9nIHByZXVubWFwICRETVRISU5fVk9MX0RFVg0KLV9kbXRo
aW5fbW91bnQNCitfbG9nX3dyaXRlc19yZXBsYXlfbG9nIHByZXVubWFwICRTQ1JBVENIX0RFVg0K
K19zY3JhdGNoX21vdW50DQogDQogIyBXZSBzaG91bGQgc2VlICRTQ1JBVENIX01OVC90ZXN0IGFz
IGhhdmluZyAxIE1pQiBpbiBibG9jayBhbGxvY2F0aW9ucw0KIGR1IC1zaCAkU0NSQVRDSF9NTlQv
dGVzdCB8IF9maWx0ZXJfc2NyYXRjaCB8IF9maWx0ZXJfc3BhY2VzDQotLSANCjIuMzQuMQ0K

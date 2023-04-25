Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225EEC7618E
	for <linux-fstests@archiver.kernel.org>; Tue, 25 Apr 2023 02:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbjDYCIA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 24 Apr 2023 22:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbjDYCH6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Apr 2023 22:07:58 -0400
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C6B903E
        for <fstests@vger.kernel.org>; Mon, 24 Apr 2023 19:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1682388476; x=1713924476;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=grwjut+JNEO1z7dq2v30SQkQEV68KNGprXGp5G/IlhU=;
  b=m9aPApmPtI1TLlmYAYRoWkzwqnJelL8QXOz16oabFZLoZPr7SmWCKiA9
   HW2YNVIsLTuYktkYkMctdrQyIhNpXXt8dFdMJj5xrJMID3/kGzKmzoQkO
   Nxipkp+zWvuaOMdVbS5krU11mE9j3RV00qm9LrQA7iTErN/E7Vr0Hnt4e
   Y2K5otUv756DiLgZt2jcZCbQR0Ey6kPOtBZ8PFxaW8ChBVL/J6CK2J2/r
   ttlZJkXvM4RkgyPblvSZsyjra4XkII03MmGHu9D5gJ+yuML2L7MQJJ5Zx
   TZf7ZIh2uEJUUqDuuI+k0OtHHUe8nlNxRTMyBcyRL2j7A0E9t8PeJ7CPR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="91128329"
X-IronPort-AV: E=Sophos;i="5.99,224,1677510000"; 
   d="scan'208";a="91128329"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 11:07:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WC/cJsxV3TkmPL/lLynT78bl1dyaz1lNiVvijATZRD16FYtP63SVar3BylMFHudaDemVJld7dCVP0Hp5OZXvDfX4ahHytcaSBEPja1kRyFZHrNfhCT/sd/JulMnLg/xD4mYIko4DMuqxu7qrHxzxUpI5wgWeVVAbm0BTNbZBuvTFFs/jANQWM7lHgNlKx1bgGpEZDUl/6TRa+5l1ynxDkQvpRCYLSMPGEbqAHQFmLAHZ0yPZMxOkzPevv1SYP8GSKlEtk/rs8gaHQoNmzV5HKGZZNfmhJ9wECNfIIv7v0j6fDB14feQrB9CvnFToqX7QHh1UdONaFrrwVN927dNZ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grwjut+JNEO1z7dq2v30SQkQEV68KNGprXGp5G/IlhU=;
 b=WBe9q+7qTgyAvgW3h4MEbqQQXmAi0QWhkc+REKCOJZOtPZ45XXSL8ZN+ZRECzBrITgzoigUq2iIG+SiA1Z1ShEUEMnG6FWN3d9VpjNtHA68Gvi+WuZCFt83vmKY+m4vUyR7GkFm6IObbfpXmBSP2eGAs2WHQVRYfY8B6A+m8a4ULnRkDdyt1mo+QDpg8BC1fqdgPIs6rPdrqXqZ2fFrTcn7fQZR7c3mED5GgAAKuEHFw6ICjR9W6H6MAJBoGhZXVmYeEBVhCwYugwgqrcyTmgClOI0sy/NEzZ226a1zvWzobNZjgcoVOtmq+ZGN8ISyMip1WbNDegHxkHjFjd2B0AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com (2603:1096:400:2a5::7)
 by TY3PR01MB10386.jpnprd01.prod.outlook.com (2603:1096:400:252::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32; Tue, 25 Apr
 2023 02:07:47 +0000
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1]) by TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1%6]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 02:07:47 +0000
From:   "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>,
        Zorro Lang <zlang@redhat.com>
CC:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2] src: fix detached_mounts_propagation compile errors
Thread-Topic: [PATCH v2] src: fix detached_mounts_propagation compile errors
Thread-Index: AQHZcy1nbMbAxZ51DUazNavjV3qiQK83XYyAgALoKoCAALVMAIAASSyAgAAIhgCAAAJjAA==
Date:   Tue, 25 Apr 2023 02:07:46 +0000
Message-ID: <580596e9-6bc0-99e9-41e6-5996af1d39a3@fujitsu.com>
References: <20230419032955.114278-1-hsiangkao@linux.alibaba.com>
 <20230420021106.41970-1-hsiangkao@linux.alibaba.com>
 <20230422135427.vbrnj6vh46omo34e@zlang-mailbox>
 <7243f364-e822-ce43-7e46-783c317d0a67@linux.alibaba.com>
 <20230424210648.53l3k2xmuj53nusa@zlang-mailbox>
 <5cd6f60e-b725-6aa0-733b-ce92434694c8@fujitsu.com>
 <20b80d9e-9ef1-0811-152d-0f0f0eff7615@linux.alibaba.com>
In-Reply-To: <20b80d9e-9ef1-0811-152d-0f0f0eff7615@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10725:EE_|TY3PR01MB10386:EE_
x-ms-office365-filtering-correlation-id: 92947e5b-d85b-4b4b-d573-08db4531dd38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yNEAsM8lQE96XeUBJUp5+eQzigp25xtsH1bnYw3tTZ3ATji+PN2hyuodj2LXI0UcsaiWm2ERREDzL64D/oUiG0yRqmki5zrhf/7smDUi4nmv8nAczaqvxUjMfK8tqLZ9PhFrt4lTKna8O1YZixcmRCI4zcRpoWSwPtc3F8Q8o10VOAhzSZ7dHv2/b6peOJ0Z8DZX04Ksq8dYipEoq0VJtV6MvI4oei0SkAGBvaY7aC2PM7rw0+inlA4q5HzfTnPu77V7SzkTQWB39pNBlf7vZvqci/1cLIcY5lGtbJfYI7+Idm2vN9Ie+ULBFPCKPVhXWvkJ+jZDER0Jvsu9+FyFVMlV7jnwop5ViF8cwW07Kj5+v+IRH0N/lXnJZwwGraP/c+kzAX3xYc76GqGUeuTMzwljlXHC3XJoO6/WhCo1MQDIwMlcxUMtRjOXX1ihOgo9g82tB6bM+W3j7LexHvsXb0cdZ2PNgT95+irGE1aUWs2BoEJNRxQwYM/829ZjZ3AUJJmuyj8A7aEds5DOo3+c9mqVHqzlr7eEI5lT4kAjx1OCIcfxt2Xm3ap6wKr7MlgfXMrMe4oe/2qToECGq/YdwdrL8jhvQEhpFV5Ye6y1/xZPtZxk5aaaFHuZDWr8cGVkVDcTJMe+1a5pD5z30WzawDh6Ps03lM7paK/2oJTKYk0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB10725.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(1590799018)(451199021)(478600001)(1580799015)(31696002)(86362001)(110136005)(54906003)(85182001)(36756003)(186003)(53546011)(6486002)(26005)(6512007)(6506007)(71200400001)(4326008)(66446008)(66556008)(64756008)(316002)(82960400001)(66476007)(83380400001)(66946007)(91956017)(76116006)(2906002)(38100700002)(8676002)(8936002)(122000001)(41300700001)(31686004)(38070700005)(5660300002)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1kySVNSci9DOG55OHllTEVrSjFrc1FaNXIvTW43TEdreFhZY1l5NXFtQ0FF?=
 =?utf-8?B?YXNoMy9rK0pWNDNENHNzTlZpd0F3S3Q5U2VQMTRURXBCdzJtVzgrOVFoTGJ2?=
 =?utf-8?B?ajhzci90QnFzTmN0KzlERndEY1FCaVovQ2JhSWhwNlIyNFdZNHZXbFBzaEd4?=
 =?utf-8?B?aVhLYWFnNnJtU3Nnb2tNdVlMQnJuVWlzMTRLS0hhcmtZK2dvNU51K1VPOStU?=
 =?utf-8?B?OVNSMWNraFpwOVRsbm96MmR4SWFRaTMxMHBSbWJDYkJYN3dDKzA0UHdabFZV?=
 =?utf-8?B?RGc4TDdjZzBnUENKc0NzRFBheU96QVRrWEtxei9YRUQzSWJuV2FOMmdrTWF5?=
 =?utf-8?B?aEVHQWc1REVvV0ZwcVVnNXgrQ09OQ3RPakV1UVIxcHV4RlBPaEdFZWtjWXJZ?=
 =?utf-8?B?emVkSXdEeCtKelVVQ0dsekVORUF6QnFqcFJqZGJSZ1lwWTVFWm1Rak1ielly?=
 =?utf-8?B?amwvcW1HU3BjclhsbXNZRGwwaGxuMWVoRDRiRFpIc3VzWTNXYnpsTVhMeSt6?=
 =?utf-8?B?blpQQndDZEdNS1o5UXphYlZZRXE5VUJ5eVAzbXMwaFVMUUdOY2xMcGpuUE1G?=
 =?utf-8?B?OFBDTzYyR1Z2QWI5RnJzWlRRUzMyUS96RGNoK3ZXSENoWGlTTHhzU283dXIr?=
 =?utf-8?B?QXYvVE16Lys2TStjZEZDSXpSaXE5c1NCdmwxbUMwUW85c3MzN2l1NWt5L1Aw?=
 =?utf-8?B?YnNMd1lpMEJoREF5bFA0aS9GSEJjTGlxN0FnV2c2RzdkbU94QUZoQ0hvZGNi?=
 =?utf-8?B?TlRydHp3cjZtQ01taUl0M2pYVGVKZlhEZ3JkSmM2V3ZHZHorK3hKdVcwekFS?=
 =?utf-8?B?QWNjdUpubHBlS2FlcE9xNkVDc3ZPTnNsQzRFNVJOU3p6Q2NFQTc4cVB0TmJ1?=
 =?utf-8?B?SmI0SGxIK00vN0o0cnRHUGI2eU4zaHhXTDFOOFE0RXdZOU4wODB4dmwvSnhH?=
 =?utf-8?B?VDBQaXZ4VytMSEZBd2ZLMkpTZ3NZeGhJVG42UU1tQ0szYVcxYXRRZzZORkVv?=
 =?utf-8?B?emV4NWI1Y1hSMTUrNlZsL092bkQ5ekNNNngvSGJNWkdoVG51N001ZHNFOTZm?=
 =?utf-8?B?Vm53ekZtaDNyeWE0cklETnBFRzU4aTZ1WE1KeWdmQzk2ZGo3eUVtYjlOL2gy?=
 =?utf-8?B?cFRISEplaXJiQll5THJmZXRGZ0hXb0hFbGlEcnFCNGhaSXJkZld5ZnhkY2xU?=
 =?utf-8?B?VWhHV3J2VGgyVjMzMEYxbUc4ZGUxVFJ3bDhGUjFDcktPTTlVUG9BcmREa1kz?=
 =?utf-8?B?NFIxOTBpalE4RU1xQlJ1bjd4TUUydkVHcS8zQy82VUdkV3NQc0JKenN3SkM1?=
 =?utf-8?B?dDNjK2E5dDVha3JWUHU1SytwR3BuVHBtdTNpai9xYW5TQmg4R0tDRUxCUDNE?=
 =?utf-8?B?WEVyTkV6b3ZDVlZ0R0VGajNJOHBubzg4aFY4L1hBVG81SEdUb0ZEdHBWWUNX?=
 =?utf-8?B?ZHoyZzVuNkVkN1Y2c29yWi9vVHdkSEtEU3ZKZUU1aU50aUIvWWxyUC9Eamsx?=
 =?utf-8?B?LzFYZFZaUldpRkNLQTN1elUraEt0UzhGS0tHbnYyc3g4SjNaeUxsMVhqdCtL?=
 =?utf-8?B?WWFRYVU0ODN1MzNXTWdMSzE1L2JHZTBVNGdDMmxjcTJFTUFZanNwbU1jYUtX?=
 =?utf-8?B?Ym9mKytCVXphSEdxM1F5NnJ4UFhmVkJ0Zkh3UmlXejRmckc0YzlMSmxXaUtM?=
 =?utf-8?B?c2h5c0QwN0tSSWg3N2dCSVNpc1JZWGMydTd0V1hNRXE0WXVpS2xrcTlMdFpo?=
 =?utf-8?B?Z0Q0dkc0TWhlQkQycmRFbTk3b1Q1U0dGZ3E3aFZoK0xMRXM3Q3BkeTYva0Nx?=
 =?utf-8?B?T2pXTnQrVUlkYVJRNjU5S2lWRnJkenNkRFJaQk9HdTA5MStEMFY0Z2NHWlhV?=
 =?utf-8?B?WjJBN1BtaSswSXZvYWlrc2FnYXVMS2xIY3Z0V3crVHFJKzhZcGFVbHluREpS?=
 =?utf-8?B?U0RyNVhZK0t0bnFLK3kxb0thQzZxSzdmQmovZWFqcFhvaWs2UXFzTDF1OHE3?=
 =?utf-8?B?S2pZeDBTajFtNmZGOGllWS9Sem9HdVpkbGhYL2psSSs2Q1MzbGtpVHVVRWla?=
 =?utf-8?B?eElaMXdWNXk5UGNzWXBkYW1PYWQvdlhvaHRIM3RBL1lzT2ZNUE5vd3FBK2ZE?=
 =?utf-8?B?YjIwRDhuMWFaUmZHQ3h4RE5ZU1piRlFmUjhRaEphUXdaOXVocE53b0JhWHR6?=
 =?utf-8?B?ckE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC1FF3BCB25ABC488290023F2CABF158@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: e6q2dBteQG7pv2Ty+PwPolWM+FauER4WTfGkBaqrV9NQRKMPyu8xiyZ5rlzf99tAxRGr4y8GPn/6yM4ClZ07ROQqvPvjsLxfhVlrN6a/e58hw/pxda0iR74gZxhKCPlyEs10zgIi6lROdtzCQTiVzRU/V2YTHzpo887EpLQ+VjP19H9rAKfpU7D3IrIe4dUUevxlValM2N7V90213ab1qJeo99pd8rndKSdmMkv2EHWYxVTZBjK992H2gfJ9XUgcvuQwCjayCQraXsEuB4gIQUv26jOc9JVqM3TJ4FCi7/7mzHh6z9kHk2+hkNOG5d1LuXunqaknd31doGadWFIgl/1EtEuAOwQRAoYsVC5/hy2nOopUJODzVvAAngMAaYesS+j51+NePkODpP/MItiBvAip5NVi4Sfa9FMQ4v0lSKK2x8Hz7iL96pnNXWEcDxGhgaUbmP2vDVNoJmNAHE9/l/JGBSxt933lUifF47LUcGzhsTPqrLqZ4N/JwFJsZfz4i0PHpDftqWiCrxR4FCfPRvTvEm98+BIHobYr5JbnlePCtMg/ydvFQJ1/M5IvZtX2wA6fPakCZGBA4m+LJPDo1ANXQ9Ww5Lzv2gQqGQiCSlnnd5xd5q91QDGhXWSuIYxAB6GxgQj1wPQXzXRbSrFSewvj0s6+chw5R1q+MWuiETMZ94jvicPIx+qlwPnJ+nwwisDtA4wN+7zaoxIEAp4Ps+eaNBw94YQME7wHmF20NJD+ZfatIxDkt9j4ZEawaLKZbP2fabof5UOxMJJ4K5gkr6EuXQ3ndQbIHeYCNzHAeWEDjbV+QE1/6KdZyK7Mi63FiPR16l7yoUsxVaq/D/ywM1P8OAulxtigY4lUx3v6Th4crQAuNPj7W5bHcdNwt6rB
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10725.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92947e5b-d85b-4b4b-d573-08db4531dd38
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2023 02:07:47.0212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 77y9U7LY000cuA9SJdXoCRLy4Vtbkv8joyI8K9Q6NFNZ8G4ZpfXK6fBAUj1j1JBeAjhTdruua6gFFBs3pVC9DML+OB3xCMC0qdHy2J1uZmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10386
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

DQoNCm9uIDIwMjMvMDQvMjUgOTo1OSwgWml5YW5nIFpoYW5nIHdyb3RlOg0KPiBPbiAyMDIzLzQv
MjUgMDk6MjgsIFlhbmcgWHUgKEZ1aml0c3UpIHdyb3RlOg0KPj4NCj4gDQo+IFsuLi5dDQo+IA0K
Pj4+DQo+Pj4gTG9va3MgbGlrZSBub3QgaGVscCBbMV0uIFRoZSBzcmMvZmVhdHVyZS5jIHRocm91
Z2ggZ2xvYmFsLmggLT4geGZzL3hmcy5oDQo+Pj4gLT4geGZzL2xpbnV4LmggLT4gbGludXgvZnMu
aCB0byBpbmNsdWRlIGxpbnV4L21vdW50LmgsIHRoZW4gaXQgaW5jbHVkZQ0KPj4+ICJ2ZnMvbWlz
c2luZy5oIiBtYW51YWxseS4gQXMgeW91IGFkZCAiPHN5cy9tb3VudC5oPiIgdG8gdmZzL21pc3Np
bmcuaCwNCj4+PiBzbyB0aGVyZSdzIGEgY29uZmxpY3QuDQo+Pg0KPj4gWWVzLCBoZXJlIGlzIGEg
Y29tcGxleCBwcm9ibGVtIHRoYW4gbHRwIGJlY2F1c2UgZ2xvYmFsLmggaW5jbHVkZXMNCj4+IDxs
aW51eC9tb3VudC5oPi4gV2UgZG9uJ3QgaW5jbHVkZSA8c3lzL21vdW50Lmg+IG9yIDxsaW51eC9t
b3VudC5oPg0KPj4gdG9nZXRoZXIgb24gb2xkZXIgZ2xpYmMoZ2xpYmMgMi4zNi42KS4gIE5ld2Vy
IGdsaWJjKGdsaWJjLTIuMzctMSlbMV0NCj4+IHNlZW1zIGhhcyBzbG92ZWQgdGhpcyBwcm9ibGVt
Lg0KPj4NCj4+IFsxXWh0dHBzOi8vc291cmNld2FyZS5vcmcvZ2l0Lz9wPWdsaWJjLmdpdDthPWNv
bW1pdDtoPTc3NDA1OGQ3Mjk0MjI0OWY3MWQ3NGU3ZjJiNjM5Zjc3MTg0MTYwYTYNCj4+DQo+PiBJ
IGd1ZXNzIHdlIGNhbiBub3QgdXNlIDxzeXMvbW91bnQuaD4gaGVhZGVyLA0KPj4gdGhlbiBjb21w
aWxlIGluZm8gYXMgYmVsb3c6DQo+PiBkZXRhY2hlZF9tb3VudHNfcHJvcGFnYXRpb24uYzogSW4g
ZnVuY3Rpb24gJ21haW4nOg0KPj4gZGV0YWNoZWRfbW91bnRzX3Byb3BhZ2F0aW9uLmM6MTI5OjE1
OiB3YXJuaW5nOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZg0KPj4gZnVuY3Rpb24gJ21vdW50JyBb
LVdpbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0NCj4+ICAgICAxMjkgfCAgICAgICAgIHJl
dCA9IG1vdW50KE5VTEwsIGJhc2VfZGlyLCBOVUxMLCBNU19SRUMgfCBNU19TSEFSRUQsDQo+PiBO
VUxMKTsNCj4+ICAgICAgICAgfCAgICAgICAgICAgICAgIF5+fn5+DQo+PiBkZXRhY2hlZF9tb3Vu
dHNfcHJvcGFnYXRpb24uYzoxNzY6MjM6IHdhcm5pbmc6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9m
DQo+PiBmdW5jdGlvbiAndW1vdW50Mic7IGRpZCB5b3UgbWVhbiAnc3lzX3Vtb3VudDInPw0KPj4g
Wy1XaW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dDQo+PiAgICAgMTc2IHwgICAgICAgICAg
ICAgICAgIHJldCA9IHVtb3VudDIodGFyZ2V0LCBNTlRfREVUQUNIKTsNCj4+ICAgICAgICAgfCAg
ICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fg0KPj4gICAgICAgICB8ICAgICAgICAgICAgICAg
ICAgICAgICBzeXNfdW1vdW50Mg0KPj4NCj4+DQo+PiB0aGVuIHdlIGNhbiB1c2Ugc3lzY2FsbCB3
cmFwcGVyIGRpcmVjdGx5IGluc3RlYWQgb2YgZ2xpYmMgd3JhcHBlcg0KPj4gLS0tIGEvc3JjL2Rl
dGFjaGVkX21vdW50c19wcm9wYWdhdGlvbi5jDQo+PiArKysgYi9zcmMvZGV0YWNoZWRfbW91bnRz
X3Byb3BhZ2F0aW9uLmMNCj4+IEBAIC0yMCw3ICsyMCw2IEBADQo+PiAgICAjaW5jbHVkZSA8c3Rk
aW8uaD4NCj4+ICAgICNpbmNsdWRlIDxzdGRsaWIuaD4NCj4+ICAgICNpbmNsdWRlIDxzdHJpbmcu
aD4NCj4+IC0jaW5jbHVkZSA8c3lzL21vdW50Lmg+DQo+PiAgICAjaW5jbHVkZSA8c3lzL3N0YXQu
aD4NCj4+ICAgICNpbmNsdWRlIDxzeXMvc3lzY2FsbC5oPg0KPj4gICAgI2luY2x1ZGUgPHN5cy90
eXBlcy5oPg0KPj4gQEAgLTEyNyw3ICsxMjYsNyBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAq
YXJndltdKQ0KPj4gICAgICAgICAgIGlmIChyZXQgPCAwKQ0KPj4gICAgICAgICAgICAgICAgICAg
ZXhpdF9sb2coIiVtIC0gRmFpbGVkIHRvIGNyZWF0ZSBuZXcgbW91bnQgbmFtZXNwYWNlIik7DQo+
Pg0KPj4gLSAgICAgICByZXQgPSBtb3VudChOVUxMLCBiYXNlX2RpciwgTlVMTCwgTVNfUkVDIHwg
TVNfU0hBUkVELCBOVUxMKTsNCj4+ICsgICAgICAgcmV0ID0gc3lzX21vdW50KE5VTEwsIGJhc2Vf
ZGlyLCBOVUxMLCBNU19SRUMgfCBNU19TSEFSRUQsIE5VTEwpOw0KPj4gICAgICAgICAgIGlmIChy
ZXQgPCAwKQ0KPj4gICAgICAgICAgICAgICAgICAgZXhpdF9sb2coIiVtIC0gRmFpbGVkIHRvIG1h
a2UgYmFzZV9kaXIgc2hhcmVkIG1vdW50cG9pbnQiKTsNCj4+DQo+PiBAQCAtMTc0LDcgKzE3Myw3
IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pDQo+PiAgICAgICAgICAgICAgICAg
ICB9DQo+PiAgICAgICAgICAgICAgICAgICBjbG9zZShmZF90cmVlKTsNCj4+DQo+PiAtICAgICAg
ICAgICAgICAgcmV0ID0gdW1vdW50Mih0YXJnZXQsIE1OVF9ERVRBQ0gpOw0KPj4gKyAgICAgICAg
ICAgICAgIHJldCA9IHN5c191bW91bnQyKHRhcmdldCwgTU5UX0RFVEFDSCk7DQo+PiAgICAgICAg
ICAgICAgICAgICBpZiAocmV0IDwgMCkgew0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICBm
cHJpbnRmKHN0ZGVyciwgIiVtIC0gRmFpbGVkIHRvIHVubW91bnQgJXMiLA0KPj4gdGFyZ2V0KTsN
Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgZXhpdF9jb2RlID0gRVhJVF9GQUlMVVJFOw0K
Pj4NCj4+DQo+PiBCZXN0IFJlZ2FyZHMNCj4+IFlhbmcgWHUNCj4+DQo+IA0KPiBIaSBZYW5nLA0K
PiANCj4gWW91IHBhdGNoIHdvcmtzIGZvciBtZShrZXJuZWw6IDUuMTAuMTM0LCBnbGliYzoyLjM2
KS4gSSB0aGluayB3ZSBjb3VsZCBqdXN0DQo+IG1vZGlmeSBkZXRhY2hlZF9tb3VudHNfcHJvcGFn
YXRpb24uYyB0byBzb2x2ZSB0aGlzIHByb2JsZW0uDQoNCk9LLCBAR2FvIEBaaXlhbmcsIHNvIHNo
b3VsZCBJIHNlbmQgYSBwYXRjaCBvciB5b3Ugc2VuZCBpdD8NCg0KQmVzdCBSZWdhcmRzDQpZYW5n
IFh1DQo+IA0KPiBSZWdhcmRzLA0KPiBaaGFuZw==

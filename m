Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C06C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 29 Mar 2022 10:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiC2KB5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 29 Mar 2022 06:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbiC2KB4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 29 Mar 2022 06:01:56 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Mar 2022 03:00:12 PDT
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAEB4CD75
        for <fstests@vger.kernel.org>; Tue, 29 Mar 2022 03:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1648548013; x=1680084013;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=9uKD5t9/YjrQR/Y/uhuWSVt+1zNt+PApwR9Ds53RCGQ=;
  b=yS5fYeSTmtqKxG+lIRFJTVp/nCTSZY/46MkdKxAXYLic3J2mKFiG/7Jd
   22NVUjY6Exs0l1KtgsGwZ4W9fE3KFjarc4b65XmY2A8dYtQXG3bpZ94Zr
   xDRFILYGpDi/S6MQxo6WA4WRJ+NF1+mktWQ2MwBi8oS47TKUDnMdYPZXw
   Svhbt3RCaWQi6YyV7uVJjo4LoNYHYNjrpvN+WTKvERiM/dSEkrk3SxzmU
   ZVvfoTJ7UpM0FK3o2m7ik04N1SFyR21ylwTyzGEdcUF7ybcqCXcYW9kER
   id3677q0O5I9Jg1m8FBF6X71OmSrQPGhYRn11z9SsaONs8fPMAmcKYKT8
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="52774803"
X-IronPort-AV: E=Sophos;i="5.90,220,1643641200"; 
   d="scan'208";a="52774803"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 18:59:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7iBUrXxnKTO8V8RFyqinZP5B+QO+9gKSJoHM6CsnUZVAboediCZkQqIyRXhG5+rMLL2R8tbzgDlkrFm1Tt+kSNOY9Y22v+wn8pFM1bospCei3RNFss+gCrs2ftlmvDxzM2f3HaDCq+iIA6CMCmN9+xUZ9KSW6L+qYqQBPLKDOvBXvLorN4JCHHJ74XQiCzv7Sn/0lJF0qaasgG4NbpfZEqvy4bw93YpgW82butEzb7+WRmwil0H+cJlV/RCY0vlaQX6Vz7BAzUS0vsyjnHuX8/FRaJaCGfrT6qnCHkrxzvkhAP+U/TW+NOp6+VkXV2lYQIOTvySmtVSqLGKVSuCkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9uKD5t9/YjrQR/Y/uhuWSVt+1zNt+PApwR9Ds53RCGQ=;
 b=idSErxRZU1iVcvIkmgZssktXrsGI+4npsOYLX060dl5RcD2KoU0Fqaqo9W/j2iE2TOe7TgpafcjSxsybPpIzBhWU7b4Jv12Egd4n/OTO3NeJQbfCk4n0gMNhoM6+ATE2ZaCbCsvbUFwqyqXX+lejMnwDJwCy7UVi1Hxj8J0v85GVoRQexnIKT60ik/7wKcnvZqElQLVH6JhYdRN0bE1JxUJjfAwlAspZhtLGBjuy+2ac2tiXnmsh9DWu1mQXqTeTuLGXVIDtu58uj3urZmTToxCblBs5xY10qBDK1IIly/R3nNNgksl05jIsbK17GcLL/5yxcoH74cxzel64YWuYQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9uKD5t9/YjrQR/Y/uhuWSVt+1zNt+PApwR9Ds53RCGQ=;
 b=RIMhvS+VnVyLfVo4FeO1asA5ypeZYsg12BfycDQHuwQDaJALT2ybHRZlR0v3UUgTFVvpq+5MlgiUNgtugYzDEnRXOKg/HUDx2rDXEUgMU4KKRNQeaF93WMKxPJwfh0ZxNp0zVws+WjF3iRjLNdFbp8tN4OjtYrdpASZBn5VisSo=
Received: from OS0PR01MB6481.jpnprd01.prod.outlook.com (2603:1096:604:107::13)
 by TY2PR01MB4220.jpnprd01.prod.outlook.com (2603:1096:404:d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.21; Tue, 29 Mar
 2022 09:59:02 +0000
Received: from OS0PR01MB6481.jpnprd01.prod.outlook.com
 ([fe80::b017:ab3b:5c5c:b720]) by OS0PR01MB6481.jpnprd01.prod.outlook.com
 ([fe80::b017:ab3b:5c5c:b720%3]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 09:59:02 +0000
From:   "liuyd.fnst@fujitsu.com" <liuyd.fnst@fujitsu.com>
To:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>
CC:     "xiagao@redhat.com" <xiagao@redhat.com>
Subject: [Question] About allocsp_calls not implemented
Thread-Topic: [Question] About allocsp_calls not implemented
Thread-Index: AQHYQ1Oejm4Asee/NkuLZ4Hstv2PYg==
Date:   Tue, 29 Mar 2022 09:59:02 +0000
Message-ID: <1b0b8627-0d30-018b-4a98-b69f5a8033f1@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b4d9cab-3c27-4036-68b7-08da116ac0ce
x-ms-traffictypediagnostic: TY2PR01MB4220:EE_
x-microsoft-antispam-prvs: <TY2PR01MB4220D3AD2F1F4C0990180EAD9B1E9@TY2PR01MB4220.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 27/QKMLXo9spMXgNqhgd+A8PFl6kgxXY/5wipRf0Ncuw/YVo4lcgh30NdEOL4QDnGp6HvmMQbvsXNShkMkcCgtyFSXZht9ZDCJ1cYzQEoWPk4qSc7HBmZPGAG7rS8og52mV/wcZPt3ODHUx/3ikRpu1hAImOeIGY+yY30T5uRzEaSvypbzQOQNoSXMhPLhqFATbavm0ntL0Up/qFGNLHtgBAHM0Ff9yBQRti6KzbJfjpBOPEsby4yrSKZN9LXinosccfABW91YmM2Td10jH3cySOnitCL+7t1rkheH7R00JDGhNog7X99xpMVQDrpEXbBT3KyBZTtrgLuPh6QhpS4dmJRNMgF3VEiH+4ISrX/IxfPv9QuTv3jd3Ul5+ES/S/hdDvceO6/f4YXCpK8p134//1ImkCwBaX3qStG3df89nApoHwZFZIVYgs0IJvgDX2VJCIkrRAb7VCqsD/cK6o0HOqR4TTTC7leTEohpkZIO2h7oRu7vL+iTqMCudyqQfcyDPDRl/wMUHQkcX/SyHMo0QJEE7A6LWJdk313cQOp5uxBpPhN62aD1uinJZvpZBXDh9or5JCUBtWH4GawokdIBsEbN+Y8GxdvJtRkoFgZzibSiRAHRS2NOSnDZyFwKiuY8GRd48hCYFmgCyiJj8F/k4ehC8S4rx9AhT7yzzoKS2Hey6EziU76Pes6MyRMNZvhr2LgSiMqBbkfLgGHmq21ql2mBjfyzsd5eflms0C4tE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6481.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(85182001)(31696002)(8676002)(66556008)(66946007)(82960400001)(66476007)(4326008)(64756008)(66446008)(71200400001)(26005)(76116006)(122000001)(91956017)(86362001)(6512007)(38100700002)(6506007)(508600001)(83380400001)(6486002)(316002)(36756003)(6916009)(31686004)(5660300002)(4744005)(186003)(2906002)(38070700005)(2616005)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmFLWlVzcWxBbFFJdXVkNmh5L2VyVHc4UXBqV3JTekt2S3B1bDBobE5ncG1s?=
 =?utf-8?B?ZDM5L01ZL0JyZStDVXB2OU9rL2JncU1reWNORGo5Slg5STdZUDFPUEt0aThZ?=
 =?utf-8?B?RkZxK0xjbCtadjh3dUloREdMRlZFd1pXLzArcy9LdFBwTFVzNmlnOG9sb2xn?=
 =?utf-8?B?MkZwRC8wK3lOczNnd1lhQjh3Y21BczZJbll6aUVwV0Z1ZS94VEd6RmQ4SDVx?=
 =?utf-8?B?cThsS0lEdUZXemZSbWRmb3cwVE5OUFhZRm8reXQrejFXeTdKdEhrUXpYTDc1?=
 =?utf-8?B?TmlkSFV1TSt5OTA1MEtUbGNZTG1vTEFLT0FTaklBVFNjZFFXUlRCbnhjNGZP?=
 =?utf-8?B?WXRRR21ob3JTbWJzWlZYYmEzNHNSNXNMdTZYK0ZTbzlnMEs3Um5POTNmU2p6?=
 =?utf-8?B?Ty8zR1gveUVTU3JvUWhneVRBb0xkTk53Zmo0amJ3cHFJUW5idEN6QXBKdWM4?=
 =?utf-8?B?b2R5VWZVenlvVEJ6OEo2a3I3VU0wME5RcGc4ekI4SzB5ampoYi9rckNsN21w?=
 =?utf-8?B?REJrdFg5MGdZZmZJZE1hT2w0S1l0OUR1Uk5YWlVBeGpDRDgwajlHTW0xcDNh?=
 =?utf-8?B?dENFTS8yRWMrZk9Yc2NGaWRZSnc5bzk1RVJNa0JkdE91Mk0rL2h4UTA3ajl6?=
 =?utf-8?B?M2hYTDRiY2tFZ29SUkRlK2diR3VkQU1KTjczMHNyR0RmMHRsZXhHOS83Ukxw?=
 =?utf-8?B?aEFtY0J1Q0ZmTmZ6dFNKQWdIRWhYK3NrSHpXY01wbFNubkRVdUl1ek0rT2tj?=
 =?utf-8?B?TVFNOXZ5SnloUW5sQm5sdU85ZzFxZjVWVlJnWGpkZ050ZURubjBBaHJRb2hx?=
 =?utf-8?B?aFB2UDhVUm05bHhkb0cwL1EyREc5dUtzQ3lhdFhXL1ZwL1laYnc2R0dNWXJl?=
 =?utf-8?B?VFRsamJXVUpNcktaVUwvZmNEUldFOHlYNGlpR0JXeDYwaUJ4ZmMyQ2h5MktT?=
 =?utf-8?B?T1JPQWh0Z3BOUXZQeVBQNW4rem1jQ1F1cW9QNmg4eG4zWHJ3S3NMTXJrcm93?=
 =?utf-8?B?VEZJVG5YWU5zOExkanNVV0RreDNOcHBmSXFhNGhNVHFYOVpCbmhUejVndkJS?=
 =?utf-8?B?VEMrMlpoMDFhT0d4QWlMNDdEWkNpRVJrQjlKbUZHb2EyWDF1NTJHeDJKOXdO?=
 =?utf-8?B?QWlWYVhndEVHb2V2blJzRlQza2swTEtQa3RqbXlTVWpzU1MyYU9pd0hWalE5?=
 =?utf-8?B?d2lodkFBM1hYV3g3akZiRXZTNjgzVlBLbnNuTU9xQVAxbWJKSmNIdzBRQ3Za?=
 =?utf-8?B?SzluNmVaSkdRS1hhbzRCQUVXdlUxOWR4bys4MC9laCs5OFkzS1J0dUxkUG1z?=
 =?utf-8?B?MlVobHVDRktiOG8zVTZLVEF5T051MDBYK1huVVgyRVpoZkRXd21LZnBJb3VK?=
 =?utf-8?B?enZnOHhoTUpXVEIrc1dLdmtLQ21RT2pXVkl6VmdKNXdVcW04MXVqUVo1alk4?=
 =?utf-8?B?RmdVR0ttNk4zYm8yTDFQYkZwL0JYN0Q5L3ZRUk9KVTBSQm1JMGxVb1o2RTBj?=
 =?utf-8?B?bXcza3ZkckxSV0VMN3NqL0x6WE9UL21SZ0RJUXVzSytIa3FwdkRBL2NmbW1D?=
 =?utf-8?B?Yk5Bbzh0UUUyRndiOEY5REtSQVpYVTdIQ0pjZC9BcW5jOGFLM3pRQlN6enFG?=
 =?utf-8?B?bkZIYnVpSGwrUW5iUkR1cFJQdFUyYWF3QVJZUWRDNFA1dkoxNmFjdk9KSGtF?=
 =?utf-8?B?NEpFRXc5ZVdXWUNRVUhzNnIzcUtONWlJL2dUbDNHbHowV09Xb1NOeVJkSG5n?=
 =?utf-8?B?dmF1MDEyWE92d3JjemtHLzl5cmIyZWhRSjNaekdlcTIrUEFoWFB1bDhWaFM0?=
 =?utf-8?B?VEw5QU0rR2E0YThPZmRrakJiV2NyeTd1Ylg1SVc0TGhkdnhmLzFCNUxOcXJR?=
 =?utf-8?B?RGVJbVE1UHY0bGlVMlVGQ01XOFNXcVJWM3dmemw1ZjlzdUNJNW5HcUxJaDgy?=
 =?utf-8?B?UWN4QWhtK3ZXOG1odE9DbTZNQ0xsWXVRSmQ5eVdoSHNycHZ0UHV2TXFsOHBr?=
 =?utf-8?B?MC8yVklxeTJmTGhUSk5RcU9tNng5ODArNlpPTzd3NzNtOW9qT1IxZmpvOUNN?=
 =?utf-8?B?aHVyNnNHbGVUYXQxYjBZclVpRXBpQ3lrUDZSS1lGRHRWd29aVHF3UlNrSVJE?=
 =?utf-8?B?N3FkSGNhZVBBL1dMNkszaW1jZUx6MEFLUmZHTzdQQ1JUOHplYkFoWGRaVWJB?=
 =?utf-8?B?bnh3MnlhdVNxdmkzZTZIaTdzNjUrTFlQUGQ4NWI0QWc3VkdLYlBKTWRoeEp2?=
 =?utf-8?B?Z0l2Ukc2dUZKZHF5UmJhYmxIUmZ5MGlyaSt2YnpodlFWOVJRQnRDdmJ3Mk0x?=
 =?utf-8?B?UHRJR2dwSkNNVFkvYUVjVGsvdkFINXhOZ1I1TUlBYUc2dFJtNys2V3dCc2dm?=
 =?utf-8?Q?dTzEtHkNL7CsHc9g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F14D1F2B3F43B9409A3C0DC8016C3042@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6481.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4d9cab-3c27-4036-68b7-08da116ac0ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2022 09:59:02.4836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CQyjfIN4Yax4jQc5u31wUqI0pMwNb3g5xBR/RN8NBukrCzcdrPWf3Y2sySzbc7JmJHIO31pU/peWjOCRG59xfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4220
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

SGksIGFsbC4NCg0KV2Ugbm90aWNlZCBiZWxvdyB0ZXN0cyBmYWlsZWQgZHVlIHRvIGZzeCBpc3N1
ZSBpbnRyb2R1Y2VkIGJ5IGEzMmZiMWJiIA0KZnN4OiBhZGQgc3VwcG9ydCBmb3IgWEZTX0lPQ19B
TExPQ1NQLg0KDQpnZW5lcmljLzA3NcKgIGdlbmVyaWMvMDkxwqAgZ2VuZXJpYy8xMTLCoCBnZW5l
cmljLzEyN8KgIGdlbmVyaWMvMjYzDQoNClRoZSBsb2cgc2hvd3MgImRvX2FsbG9jc3A6IGFsbG9j
c3A6IEZ1bmN0aW9uIG5vdCBpbXBsZW1lbnRlZCIuDQoNCg0KVGhlIGVycm9yIGhhcyBiZWVuIGFy
b3VuZCBmb3IgYSB3aGlsZSBzbyBJIHdhbnQgdG8ga25vdyB3aGV0aGVyIHVwc3RyZWFtIA0KaGFz
IGdvdCB0aGlzIGluZm8uIEFzIG9mIG5vdywgd2UgcmV2ZXJ0IGNkOTlhNDk5IGFuZCBhMzJmYjFi
YiB0byB0ZXN0Lg0KDQotLSANCkJlc3QgUmVnYXJkcy4NCllpZGluZyBMaXUNCg==

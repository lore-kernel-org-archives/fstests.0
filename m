Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65671C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 10 May 2022 01:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbiEJBaU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 9 May 2022 21:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234178AbiEJBaM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 9 May 2022 21:30:12 -0400
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com [216.71.158.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295CE5FB8
        for <fstests@vger.kernel.org>; Mon,  9 May 2022 18:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1652145976; x=1683681976;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=23pCivF9T36jpFQg5iJnnCj8cV8mj62Q+fYio7v4iJI=;
  b=Sgcx6eLQeQa31dRh4UvQLsYteIMwPT2zKpjTIzF3Y5/TO8f7ukIPsg6z
   Aj9dJOdxTSCbF1Nw/yvWQKUC7U42RCewgvApS79R1eKTTHmxzvYsiK042
   pYyC0cZzaVLDi4gebz4BbqubHil76ZMfQGQ7J9pz6V7HD0C7HRlGx7hXU
   n3qJ9pjjsiAtGLXOBcmOj+IPWzoc2ZpTBm34HNW4DTlZAo7fd6MDkYCRz
   hgG81eJPfqdYtCVq5oOZETXGsM0h08K5WK2t/pf28B8QTV1nUNa9PqRw4
   oUBD5mUxb00YTRvAHEBEjBwUPMqSyW4KDHSac2zIQl4aoI8DtemzsELQM
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="55107961"
X-IronPort-AV: E=Sophos;i="5.91,213,1647270000"; 
   d="scan'208";a="55107961"
Received: from mail-tycjpn01lp2177.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.177])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 10:26:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIQ7bgxANCOGI9Y4x754U9upSDJWCpqfHsBAuzlkRIcKPbeMVxcZLIK7wSf5vnZHLbmJWW277PraO74yTKsAMU2LgTZK9nihL6pVI3IdeD1WXr3XQR+hbGP9WfqPpTlPTiIfxQcXiy+O4+0R4JtE75MSnlHstlYvlUH2TSHNTAHKaBEWRQkArNd60qZSBaHBCZrUUY8i9sHscCQ+qIwc5OdHB/yLTJSugVm5g27vJdcEYavcMETD9srzm02qIIoRIDvLALx1r4TDO+bnJjMOFUUPAJgu8EVYptZzKByulpFoQ1YAolxYUkwYgs8K9lohi29dE8tcPf/M21KLfmPB4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23pCivF9T36jpFQg5iJnnCj8cV8mj62Q+fYio7v4iJI=;
 b=U18akdhbrbJuOr/KcJcPxhK/5ngIIwo+uj9ALZXtvhT+1025c5hvN17GuhQ8q9/l/XghnbvZmFV5NyqBAie/gRUxQjGsz9v6dpv4MHO+q2vjML7lcKhtXeO3ZAmE43OsN4zz+F5OAEWi1N3VswJsjbVQEGR/qzeMJUpfyDfE91oEDpEYgQmzDZWOSY/ioEy0ltJ3PRUsUUfW7O1gCjkcaLvAmhsZA6MCJ9hnbCMcwYFNAVHfELUqDQXjP+Sw8vUT2GdIdCe1Zb1uqZJVdqjA+c/tGj6dnd9VEIIw12KYpGaoaMXv5Ehvm+LadDDuecotQiLwWB06UNcP7Y8rkuZakw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23pCivF9T36jpFQg5iJnnCj8cV8mj62Q+fYio7v4iJI=;
 b=YXYryVwVw9O3DhBXamTv7zYC3/fOp+uq+psqEZhoSy6Zas0KTX/ju4UEKf2vzyYyTtKuc3KlqpqbpWDrAMBRtQaWsiQWys0gsO2ug8phwE6uiqRlklwPk88gNZ8ZMm4scILaJmUSuHb/Fv99gAgzKtOqY6UbWvnyKJXoVUTj80E=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSAPR01MB4770.jpnprd01.prod.outlook.com (2603:1096:604:6b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Tue, 10 May
 2022 01:26:08 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::64bc:6d15:6404:2ff5]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::64bc:6d15:6404:2ff5%7]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 01:26:08 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Zorro Lang <zlang@redhat.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] xfs/298: Add 100ms sleep before scratch_umount
Thread-Topic: [PATCH] xfs/298: Add 100ms sleep before scratch_umount
Thread-Index: AQHYY2mFplTGGpABi0u5nHWGTkNSTK0WjnuAgADVhQA=
Date:   Tue, 10 May 2022 01:26:08 +0000
Message-ID: <6279CD6E.2090405@fujitsu.com>
References: <1652079417-2255-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220509134241.2jfkh2rkmcaxnhc3@zlang-mailbox>
In-Reply-To: <20220509134241.2jfkh2rkmcaxnhc3@zlang-mailbox>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de770637-4918-466e-4e9f-08da32240f47
x-ms-traffictypediagnostic: OSAPR01MB4770:EE_
x-microsoft-antispam-prvs: <OSAPR01MB47704D5A5073545D5D026E2EFDC99@OSAPR01MB4770.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nNyvAKN6S9J31tiapquVADw+Yh9Kb4gE0+ticatewC8ZbCtnNnz6qSmGsECO/8cXwSU6r24qsyEi1sbppZEzdzQ97JMfP4QWNjcad+W6VZ/DPdd3BO3WFpbpTAePQGcosfuZPohaC3AoIXmbI9eQX2f+C8CaBXtXo8W9iaDaJ5E82mYuKO30+Lp8MRWmFI/z+OGDbdhOnCNtkRF5uF8zJHtFDgkShtzU4EV1MP5SqGH3bRrMnOF+GSUlwBoKtJIXOKVP2Y1QPFrbQD7GtHq1NCe53aCG0Ddlf7VsR4nc7zpwxg+NaM8oxQw3Zad3ArrYTo9ush8TiOOUSbgugKKNaEBnt+iXF7dLis1LgE2N7or4XQcNg5hmOGw7TfNM9AGwSJr/G0yx1qmbibbdk77qw9rYPyQUPDh8V6Y+y2djCRnWXhU/iNjxn+FfHQpsmXVP6V6ilTcS4jleBLY5lSvdMNcnt8OMmZR4UTaSv3FZ5KOgI1dg5Ao92B84TsU0tl0HkZGjGSCUZPol7uK28cn9d5TH6E8fOll07DWCS63Z4b8ksEIz6Tmj1wVo7CEjvyYwdpOyIVEfhxZPfyN12cgg6NDnhJjvQ3Saxxk6ryi9wptou2m74JmoM/6ECeVZVGfpgP2cWmphpV6qfB9ZNbExNJv+iSNPth9wB7apbrUl2fg6lQMh6pKVjoNAsqqZeFTfrqEtWxkm0s1ACqVxL8hkqzp4vMDhS3XNkpgPffBFKceqk42JHaTQQc4I0rCeMmvWG9LvZgCoJg+ObTZeZN7ivE5+HSLOG1TUNmebbwvAbjY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(87266011)(6916009)(38070700005)(6506007)(6512007)(5660300002)(82960400001)(38100700002)(8936002)(36756003)(85182001)(186003)(2906002)(33656002)(6486002)(508600001)(71200400001)(86362001)(4326008)(76116006)(91956017)(316002)(2616005)(8676002)(122000001)(66556008)(66476007)(66946007)(66446008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?NFJqaEYzSWh1R1dVYzFMNHQxYWkwaGJJOGx0Z0FCVzVxRnhOeWt2ZTkvWElI?=
 =?gb2312?B?aFJnMUpBcFpDTEcxTytON0Vud0c0bUNtWVFRcGZRMVRIZlE3Z25CK3FmTy84?=
 =?gb2312?B?djFaQjRwYkF3dGZxS2NOMjQxSExpbjIzeFY2V0pGVXhJYnVqS2hXUjZqSDF0?=
 =?gb2312?B?OVF6K1RNWDRtQXhGZDhIZXMyV1UyZ1pNSjVqU0VabGJuOCthRy9RYVQ4aU9W?=
 =?gb2312?B?SXZYR2xWWkpXSFZOMTBCbTZ5MWpwSkloemJvZ1JZZGhQN3lsdHdKL0N6UlNM?=
 =?gb2312?B?UlhaT1IveHltbEhMWTMxanZOemh5dmw1WGxPQ1VLWG9BbmNmRHd0MGZZV3Yz?=
 =?gb2312?B?OThpRkQwYTV5bzRFUFZKMTVxd1ljWG9OVFgvc1dGY1cyV2pzQitFNnU1ZEVu?=
 =?gb2312?B?T0ZMUUhQalBGWFR4VGNOZytuUVJpYnk2SmlEZWpwYTU0MnZHZ05xS0M5QW16?=
 =?gb2312?B?MkcyS2pmaTg5Z0QyMkgvbWtGKzYzNkJSR3ZSQ0VnUUpHcTgxZVVnNGRIdzNO?=
 =?gb2312?B?bDVUVXNMS1V4djBCQ0VzL1JQTk5kUDY1NGVmQmZCNGZ1dWVBaTNJWEl0Zll4?=
 =?gb2312?B?OEtWWnkrRWxPTDQwaGIxNzVOa0VoNEYwZ0IwU3dvcnBkdUZTT0lmZzdUSDRF?=
 =?gb2312?B?TlM2b0VRVmdXVnFCN1gwSXc1cHVZRmFpMnRyVWJxU0pPZmdpd09Jd0ZnQXNp?=
 =?gb2312?B?TjNvT3Mxb2IzT0tsLzBESG1HWkNvelNQd083Vmp2a3ZOOWR4ajFPZFltWHdI?=
 =?gb2312?B?WnIvUmRaNEgxNTBTZ25wbmh5TFpRNk10bUttWFJtQ0g0VlRmOVk3L2N6b0Z5?=
 =?gb2312?B?WjRqVlVMTE5EZy80cW1manJnSWxwV3hGWE5kV0hQTXk5Ujc0VGtWYmRjcjI1?=
 =?gb2312?B?YzRjOTk3VzgyQ25HRHBzb3YrMUp0OE1SMmZsKzFSWnp0eDNZV1dlRXBjTmtF?=
 =?gb2312?B?ZVQvVjBGQlNmRVluVXJVY1RabmlUOTByWjlYc1RGMGQ5M0JqMWRkR2VxeWtM?=
 =?gb2312?B?aTkzM0EwMmRxU3ZXYi80VndrZFgxa21BVElXemxmeEFoK3pxdC8vS2Vxdnhl?=
 =?gb2312?B?UjI0RTRFcHhRWTVJZEEwNmwvbnB5VkZza3B0cm01cXJHQ3dRREZKcTNWL0ZR?=
 =?gb2312?B?ZjY5cDNTbXBDTUlwOHBlQm4wREhLYWx1T3MrNUVwZHFHK29FVWxWTmVwN0VI?=
 =?gb2312?B?Wi9sU0RYNkprbGFJMXRIbEoyc2dXMEJITlhQSWFBcm1mU3MydXZub2ZBRkVN?=
 =?gb2312?B?OHR1b3pJZVB1K3dmS2dubk9IaHdaYzIyWmVPa1RuTno2SThkMzFjOUU1ZWtt?=
 =?gb2312?B?WDBOUmtzSXA1c3BwZnhlM2tLVWplS1FkRVoyVklKT1RBdzA1VWdQd09Pa2hJ?=
 =?gb2312?B?ME55WkRYWUVqOVgvMXI5WE5VdDR2V0FmV2xwUFIrR3pSV1hOdUo1dTkyTHRB?=
 =?gb2312?B?dUdWTytyU2RmcyszVGJ5ZGRURXNaa1ZWRHBLcDcxSWJMazBzSjNGZUV1RGt4?=
 =?gb2312?B?MnF6Q2JGOU80QW1aSDNpZzJqNEMwTm1TM2UwT3d5ZFd0a1NSY2hmdWJ6Tm1E?=
 =?gb2312?B?NTlVdEF0R1htV29GTk81YmNTK2tYYmdNTEJxOCtvSDdSV1A5NHoxeXk5VVp6?=
 =?gb2312?B?S0RSNG9oeGZ5RGJHYmQ5cS9sbjRxNmlBTU1reW5qT3ZHcjQya2Z0ZHRKOGNm?=
 =?gb2312?B?c0VtdzFEZ1l0OXRyZDRTZUl1VTFlSHJFekw4UUpnWmVYa2lVY1g0VEg2T1U1?=
 =?gb2312?B?RG5pS3hYclNaSEgyb1FIOUV2c2VMOG9PcGNsNUh0ZE1ZVEVKRStQdXZQdk5r?=
 =?gb2312?B?NTlQQkF1R243L1pCVVdyMUlSSWtMVnJyNEI3b0gwbGdIK2V1WFFpMzdLN3Rp?=
 =?gb2312?B?ZmtGeHV1ZWVkdmVteU5haXNKQ1g4YkRzUXpqSkFUdmdFVyt1MU85Umk5c1dv?=
 =?gb2312?B?YXhrV3BRWVQvWDFGU1dlR1BCOCswdUJvWkxIaG5xaFR1UzlDZjdxaTFuditU?=
 =?gb2312?B?S3hVM1pUblJXWm1FY3hOdnRWNlpzY1pjejBUeG5NMFFERFVFeXUvWFBZUnhZ?=
 =?gb2312?B?dnlYb1pRcmFESEd5WHdzWE80enRkVVFGTnRMZHdtT3owSm4vSzJqdFMySFFl?=
 =?gb2312?B?M0tLNFlPZzU3cURWVzlyMEhxS1Q3ekFZeUpxeC9zTmFMaml2M2ZaKzVxR2Ux?=
 =?gb2312?B?ZlhtOWM1OHNpL09WTHF1eThuTHRISEdzTURKMEZUTVVZb3hHTWh6azNyUy91?=
 =?gb2312?B?Smw3bUlCMHFHL2xwTlVmWW5LdzlYWm4xQ2R5RzdjTGZsY2dtVDhGdkwzKzJO?=
 =?gb2312?B?QUZMcFlpaEgrQnVzeGtocGkvaVM1OEtGbTluN09tczlkSGc2Yk1TT2NpYUcw?=
 =?gb2312?Q?ZBlGULSXM8DGQmkXWhwGyec9e5EmtZZ+9MpS4?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <053D589CAF0E114FB2A91611A07E9FBF@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de770637-4918-466e-4e9f-08da32240f47
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 01:26:08.2420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X8DbxPOaPIXPAkJlimr/XYQnf78OpHsKdY72NhonVM9EAw6k/TpLQDaLh6xqXukSlzq6fDfR3mylL1tYt5gQv0oVKlpHdq89XUL9sIjR42w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4770
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

b24gMjAyMi81LzkgMjE6NDIsIFpvcnJvIExhbmcgd3JvdGU6DQo+IE9uIE1vbiwgTWF5IDA5LCAy
MDIyIGF0IDAyOjU2OjU3UE0gKzA4MDAsIFlhbmcgWHUgd3JvdGU6DQo+PiBXaGVuIHRlc3Rpbmcg
dGhpcyBjYXNlIG9uIG15IG1hY2hpbmUsIGl0IHJlcG9ydHMgdGhlIGZvbGxvd2luZyBlcnJvcjoN
Cj4+IHVtb3VudDogL21udC94ZnN0ZXN0cy9zY3JhdGNoOiB0YXJnZXQgaXMgYnVzeS4NCj4+IHhm
c19kYjogL2Rldi9zZGExMSBjb250YWlucyBhIG1vdW50ZWQgZmlsZXN5c3RlbQ0KPj4NCj4+IHNj
cmF0Y2hfdW5tb3VudCBmYWlsZWQsIHNvICBfc2NyYXRjaF94ZnNfZGIgcmVwb3J0cyBzY3JhdGNo
X2RldiBpcyBhDQo+PiBtb3VudGVkIGZpbGVzeXN0ZW0uIEl0IHNlZW1zIGZpbGVzeXN0ZW0gaGFz
IHNvbWV0aGluZyB0byBiZSBkb2luZy4NCj4+DQo+PiBUbyBhdm9pZCB0aGlzLCBqdXN0IGFkZCBh
IDEwMG1zIHNsZWVwIGJlZm9yZSBzY3JhdGNoX3Vtb3VudC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBZYW5nIFh1PHh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20+DQo+PiAtLS0NCj4+ICAgdGVzdHMv
eGZzLzI5OCB8IDEgKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4+DQo+
PiBkaWZmIC0tZ2l0IGEvdGVzdHMveGZzLzI5OCBiL3Rlc3RzL3hmcy8yOTgNCj4+IGluZGV4IGIw
MTUzZWJmLi4xNzUxMDM3OSAxMDA3NTUNCj4+IC0tLSBhL3Rlc3RzL3hmcy8yOTgNCj4+ICsrKyBi
L3Rlc3RzL3hmcy8yOTgNCj4+IEBAIC01MSw2ICs1MSw3IEBAIHdoaWxlIFsgJFNJWkUgLWx0IDEw
MjQgXTtkbw0KPj4gICAJcm0gJFNZTUxJTktfRklMRQ0KPj4gICAjIHVtb3VudCBhbmQgY2hlY2sg
dGhlIG51bWJlciBvZiBleHRlbnRzIG9uIHRoZSBpbm9kZS4gU2hvdWxkIGJlIDAuDQo+PiAgIAlj
ZCAvDQo+PiArCXNsZWVwIDAuMQ0KPg0KPiBIaQ0KPg0KPiBBY3R1YWxseSBJIHdhcyB3b25kZXJp
bmcgaWYgd2UgY2FuIGFkZCBhIHdoaWxlIGxvb3AgdHJ5aW5nIGluIF9zY3JhdGNoX3VubW91bnQs
DQo+IHRvIGF2b2lkIHNvbWUgcmFuZG9tICJkZXZpY2UgYnVzeSIgcHJvYmxlbSwgbGlrZXM6DQo+
DQo+IENoYW5nZSBfc2NyYXRjaF91bm1vdW50IHRvIF9fc2NyYXRjaF91bm1vdW50LCB0aGVuOg0K
Pg0KPiBfc2NyYXRjaF91bm1vdW50KCkNCj4gew0KPiAJbG9jYWwgbg0KPiAJbG9jYWwgaXNfdW5t
b3VudGVkPTENCj4NCj4gCV9fc2NyYXRjaF91bm1vdW50PiAgJHRtcC5zY3JhdGNoX3VubW91bnQu
ZXJyIDI+JjENCj4gCWlmIFsgJD8gLW5lIDAgLWEgIiRNVUxUSV9TQ1JBVENIX1VOTU9VTlQiID0g
InllcyIgXTt0aGVuDQo+IAkJZm9yICgobj0wOyBuPDU7IG4rKykpO2RvDQo+IAkJCXNsZWVwIDAu
MQ0KPiAJCQlfX3NjcmF0Y2hfdW5tb3VudD4+ICAkdG1wLnNjcmF0Y2hfdW5tb3VudC5lcnIgMj4m
MQ0KPiAJCQlpZiBbICQ/IC1lcSAwIF07dGhlbg0KPiAJCQkJaXNfdW5tb3VudGVkPTANCj4gCQkJ
CWJyZWFrDQo+IAkJCWZpDQo+IAkJZG9uZQ0KPiAJZWxzZQ0KPiAJCWlzX3VubW91bnRlZD0wDQo+
IAlmaQ0KPiAJaWYgWyAkaXNfdW5tb3VudGVkIC1uZSAwIF07dGhlbg0KPiAJCWNhdCAkdG1wLnNj
cmF0Y2hfdW5tb3VudC5lcnINCj4gCWZpDQo+IAlybSAtZiAkdG1wLnNjcmF0Y2hfdW5tb3VudC5l
cnINCj4gCXJldHVybiAkaXNfdW5tb3VudGVkDQo+IH0NCj4NCj4gVGhpcydzIGp1c3QgYW4gaWRl
YSBvdXQgb2YgbXkgaGVhZCwgaG9wZSB0byBoZWFyIG1vcmUgc3VnZ2VzdGlvbnMgZnJvbSBvdGhl
cg0KPiBmb3Jrcy4NCg0KSSB0aGluayB0aGlzIHN1Z2dlc3Rpb24gaXMgbWVhbmluZ2Z1bCBhbmQg
bHRwIGFsc28gaGFzIGEgc2ltaWxhciBDIGFwaVsxXS4NCg0KQnV0IHdlIGRvbid0IHVzZSB0aGlz
IGFwaSBpbiBldmVyeXdoZXJlIGluIGx0cC4gU28gSSBkb24ndCB1c2UgdGhpcyBhcGkgDQppbiBl
dmVyeXdoZXJlIGluIHhmc3Rlc3RzIGFuZCBqdXN0IGNyZWF0ZSBhIG5ldyBmdW5jdGlvbiBuYW1l
IHRvIHVzZSBpdCANCmluIHNpdHVhdGlvbiB0aGF0IHVzZSBtYW55IHRpbWVzIG1vdW50L3Vtb3Vu
dC4NCg0KQWxzbywgeGZzdGVzdHMgc29tZSBjYXNlcyBuZWVkIHRvIGZpbHRlciB0aGUgc3RkZXJy
IGllIHhmcy80NDQuDQoNClNvIEkgdGhpbmsgd2UgY2FuIGNyZWF0ZSBhIGFwaSB0aGF0IHRyeSB0
byB1bW91bnQgbWFueSB0aW1lcyg1IG9yMTApIGFuZA0KcGVvcGxlIGNhbiB1c2UgdGhpcyBhcGkg
aWYgdGhleSBtZWV0IHRoZSByYW5kb20gZWJ1c3kgcHJvYmxlbSBpbnN0ZWFkIG9mIA0KYnJlYWtp
bmcgdGhlIG5vdyBfc2NyYXRjaF91bm1vdW50IGFwaS4NCg0KV2hhdCBkbyB5b3UgdGhpbmsgYWJv
dXQgaXQ/DQoNClsxXWh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL2Js
b2IvbWFzdGVyL2xpYi90c3RfZGV2aWNlLmMjTDM4Mg0KDQpCZXN0IFJlZ2FyZHMNCllhbmcgWHUN
Cj4NCj4gVGhhbmtzLA0KPiBab3Jybw0KPg0KPj4gICAJX3NjcmF0Y2hfdW5tb3VudD4vZGV2L251
bGwgMj4mMQ0KPj4gICAJX3NjcmF0Y2hfeGZzX2RiICAtYyAiaW5vZGUgJGlub2RlIiAtYyAicCBj
b3JlLm5leHRlbnRzIg0KPj4NCj4+IC0tDQo+PiAyLjIzLjANCj4+DQo=

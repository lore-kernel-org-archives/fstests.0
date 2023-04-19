Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EADC6FD18
	for <linux-fstests@archiver.kernel.org>; Wed, 19 Apr 2023 09:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbjDSJJv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 19 Apr 2023 05:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbjDSJJs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 19 Apr 2023 05:09:48 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Apr 2023 02:09:45 PDT
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10A92135
        for <fstests@vger.kernel.org>; Wed, 19 Apr 2023 02:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1681895386; x=1713431386;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=soC/VAiJzSWAashNwN2TfVr/fR/wSzB86V1y1HUzi58=;
  b=kMMxYCNhoNKHuz2WnP/jbWvA79WRY/E0EpyhLa8GZ8npnGKlJOsgPKOX
   1ctwzWBAgHQXzNqE0eiY/ggdrQmxvzt0WdvwmlM2H1NY+fzW+DmNbbcjv
   PJXgC1GBBF5n13P3qELxiWvGLxKBr2d0QlYEfSP4iBmIV53KE75XeL0FU
   +klJKUK+HMULDdAWEQvegyA9NwgX7rpxJbd2JrTd4Aecu25k4nGLu8yl2
   T9FegOlP2vF2w/7OiN2NjXPBgNwHbj5ozn2CZpARirAZ5pyXYE9cXzdDQ
   IG/IMuXkywJUNEoW3roecmFfCh/IIsReUBywiZ2p2Ek5JUPGEfcenWUdp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="90651439"
X-IronPort-AV: E=Sophos;i="5.99,208,1677510000"; 
   d="scan'208";a="90651439"
Received: from mail-tycjpn01lp2173.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.173])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 18:08:40 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mibvxrvWUzF4qlN4O/W3umERmbCaSuPt2+ZJKJFOjuu6KmxS9cEVtMEui9QCKDKx6pSfMwyAwFbIkRP1z8YiVawrxvZ5CDa20++TObgT/FoVSVnAyUqngyP4T3pMvUpfI+02W3fUccsw09Xh44tYtFH+UYxtOJBjQ+KQbcJ/V8+2R2k0LvCxoxUCS66l1D1s6hOGD01APcFsfmROkU1baBH/ckSR0q0+cd4KCAxLVn+6UTyOO5QRKCs11Hzba6DISkZcBPYYaLwmhGs1rDfG+uKzrmo6oEvDQA/Ea72rWZoSIG43K5JJ92i0Y5J44LXbQoa+F2Bxf4QDaFh/8DqooA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=soC/VAiJzSWAashNwN2TfVr/fR/wSzB86V1y1HUzi58=;
 b=WAiHBwWGUmBEPKPB+8iPqx87ivHTEFjCJaBVva/vwAIBiZ5As7uBBeAqwrKCcUyX4j8Dz7Pt4HRXPnOwOoMCnrttUUBebAQoEvZOloWWV3y3wDEPI/lUGFJhPxlKgDEAaLedMiucnMHHLDzQLOF/uGEgsbDMpYie6PJUCvKWL60zaFLq0r/e7AXQfV8t7ISmZGWi/M0y9Xu9++JYfhbbjQUJ1CqMUw/p3g1+alFu2tg2RmNaX80m90oVG6NLRTYDC0mTpnGMG8fSOJtgTW40hFvIh/O9YFmK5IAecpUohUeKbIKV08aScZ1h9p4TPBMkUKkUR7Worzk9UGW6IPYAsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com (2603:1096:400:2a5::7)
 by OSRPR01MB11423.jpnprd01.prod.outlook.com (2603:1096:604:22c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Wed, 19 Apr
 2023 09:08:36 +0000
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1]) by TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1%6]) with mapi id 15.20.6319.021; Wed, 19 Apr 2023
 09:08:36 +0000
From:   "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To:     Christian Brauner <brauner@kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] src: fix detached_mounts_propagation compile errors
Thread-Topic: [PATCH] src: fix detached_mounts_propagation compile errors
Thread-Index: AQHZcm9FWfJVR5Gk90K8w/48aWdR1K8yUc2AgAAGXQA=
Date:   Wed, 19 Apr 2023 09:08:36 +0000
Message-ID: <ed0bb9f0-c255-10d7-d711-36a464cd6512@fujitsu.com>
References: <20230419032955.114278-1-hsiangkao@linux.alibaba.com>
 <20230419-fahnden-sonderlich-b2968abdec77@brauner>
In-Reply-To: <20230419-fahnden-sonderlich-b2968abdec77@brauner>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10725:EE_|OSRPR01MB11423:EE_
x-ms-office365-filtering-correlation-id: fc48dac5-0a9c-406a-7c5d-08db40b5a85e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yNR/h/qX+E3FZPwSDC1dzoyMy187MbnpsfT8WxRYNcq8uUBFmv+3jIyS6A/TVjLcv6kIvGetnqJ6+KybBFvd0OmJFJkhtJQOsi4OYghnR+dAJxg6GoXhLsyF7tWhXwJjbwWOadNBz2DJ7wwZdQq6UkHnsxAJfOg4TXGF4bJnp2IzyUWJBkgMdD8KLP3PExg9i/kCiQSYp7207AQMglpMVPXhzmLiHM+QTL9/PH80na2Po5Ij6umaZAL1p7BterLjOKjWgB+YFap1X/8CdFoQ+XWgGXR1zSajb6eao11//Ka2urBJ7tL3jjAh7EUKrNxjFjDWZgB9+75G3NTKSmiOZCJagca2CozB8mSfjkFw2xgTPWgw5HwT90It63eGs9TZm7Fk7NUtrvVr28JHVzJjvu5oRD2kw+z1f5eLVwy/mWAlmZFhZKrdPTlurYb7oaKnlUTueFTgQvZTklgF7WBwOa9UL8Cc2FatGFGmOQhcUGgPYVZbyZDGXileCy3nyb975LSK4w61wnwxYvseuyAAywfU3Q+Xr7WyPIVLohq4WLU5mHLEC5qNcEZo2ofjpr8Cbh8FmgX4qNOlC8ZQ7hTizyAbch3UU4Iygy/Smtv8dsU0qNgVeYWrHYEZp88v8ULlaY2yOYe9d0myZ+Pb9B5wulhHOBSLPbLdcur8Y331lnM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB10725.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(451199021)(1590799018)(6486002)(966005)(478600001)(31696002)(110136005)(86362001)(71200400001)(36756003)(2616005)(83380400001)(85182001)(6512007)(186003)(6506007)(82960400001)(26005)(38100700002)(38070700005)(122000001)(64756008)(316002)(66446008)(76116006)(66946007)(66476007)(66556008)(2906002)(91956017)(8676002)(5660300002)(8936002)(31686004)(41300700001)(4326008)(1580799015)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZE9rNU1CeHRXMDFJVGdMTGpvMFBFTTZGWjEva3Y5Mndob0huUlBTRU5xWlNC?=
 =?utf-8?B?Sks5R2RqUHpodG5DZHgwaDFEUUxNbzhJd280b3dlM3o4RjE4RUpOK0tIb2o1?=
 =?utf-8?B?WWJBRWc1dklKdklCb3ROcGpFNlZpd2swb1NuUVk2eExSaklLcEVybUdzbnNa?=
 =?utf-8?B?QzBpTERTTTB6U3VQRys4THVldUl6S0xGTVlLeEJTWlM5VnpYUS9FVUxOQXh6?=
 =?utf-8?B?QXdXWGxTZU83L0RaMnU5RkhKQ0h5ZFZaeS9lT3U5TEZaQ3huTEt0a2Rid3ps?=
 =?utf-8?B?alQ2dXlwTDVmcTdsQStwREQ3cDJBbDl6TGFwN2h0ekNjU25KWHF0M1BvRzNC?=
 =?utf-8?B?c2daem5QTklNN1hMUjFUTXZlYnMvazFSV2N2TEQyM05qVjJGUTJjeXJDUjEw?=
 =?utf-8?B?eFhub1k0aUVoQ3BhTmR5N21TdmtUc1N1N3RaUzkwVUttSU9FTHpqY1BEMnNB?=
 =?utf-8?B?TUVDNkVZQ1hYMHRyMFpRT25Tb2c3djJQcXJKaXowTVdZdXlBYlBrWGo5VWxh?=
 =?utf-8?B?N1pLdWtuS2twMEhtUXNPS3JTZUxJNldFcm4xYnJnRFVuQVdOR3ZPUXJhVnl5?=
 =?utf-8?B?MDRtcWNFN1dtK01yRmpLZHZxVTFzMHlUdmZENncxZlh5WStXR1lRcUtqa2l5?=
 =?utf-8?B?RmdGakJrazBqS3JqUitpdFNIQldydWpJK3B0TkFsdVhGNFliSWc0MXZ1Umo0?=
 =?utf-8?B?ZTNsd212SFh5TExCOGhqbEZuVlltWWMvOVNzelI4WHRHWTB6Zi9hblBJYnEv?=
 =?utf-8?B?dW1IVzVFN1BPN3E2Z0paODRTZk9UK3B2SmhpeGJ4dkg4UlE2aTZhQ3lWaEVX?=
 =?utf-8?B?aXNqUEdFQzFHSHE2SHJFM1A1b2o4UlkzTW9nRnRodmlpRzJ6MjV3RmRGcjF0?=
 =?utf-8?B?N05kY1VHelU5aFVPYW9WYXkvS2N2V3JnYTIwTjZVWFFjUmVGY3JGd2VXSkNB?=
 =?utf-8?B?SitJbWY2OGtGZEZ6WlJ4bTY5TGdQdE1YdE0yeXlra0lqbnZFeTYxYmRiWkpr?=
 =?utf-8?B?bi9mNFdjbjU0NVNmbElMRG53VDRPN2hIVEI4U0lrazJBekM3NzdKdFJrRzRM?=
 =?utf-8?B?Ylp4REwxK3J4ZytSc2pGdE9uZHhDdTREbS81bDVQUkZvRFlhenBPT1RiTW1t?=
 =?utf-8?B?U0U0V0JjeVZYazZzajVLcC9wMnNNUjI2Umo4NmRaMU55Y1h6dXpGQzI0Z2tJ?=
 =?utf-8?B?eU04dWVTcklwVWVQN1JkdkVOSjVPYVpKNmJTSTkxakVBSHpidDlPeitnNVRV?=
 =?utf-8?B?TGI2OE9iYy9iNlpZdG5oYjRPQXZMWWxEVXBqVG0xeDFsZDdUMnA0QTl5NGZh?=
 =?utf-8?B?bEdqdjBmeGxaUVRIUVJWd3ZzMlB2cWtEMGx0cFVrR0RZQW9VSE1MdVBoUWVX?=
 =?utf-8?B?THJ5dE5CRW82QUg2T2llaGNLK1YvMFo1QlIyK3A3Wk5vZnFrQ2tNUVF4am4w?=
 =?utf-8?B?c05zN3dUUkNHeG5lcU5BTU8xZWxYdGJPSXRVR1pMRk9Ld1dHajdXTHN1SXMz?=
 =?utf-8?B?Ti9qYU9lUG9Lbm9aaUhDUmQ4ZVNKYU1uZ1RZVFNwaGxUNXN0d251ZERnYTB5?=
 =?utf-8?B?RUh3R2FTSXIwREtnL0MwMWxrcTBXQ0FPK2FxTjdXd2pvV3B1Z1FiMldzV2FU?=
 =?utf-8?B?anZoa0ZFc3IrRmxFOERPQlhOTlZoTGQzcjFndWs5M3lEaXdqMU44K1Mvcis1?=
 =?utf-8?B?ZTRKNFcwdmE5TkFQVlNyNlFYemYwbVFVelFUQkZ2OXQ2K3JSUXczc3JBb3RP?=
 =?utf-8?B?d1drWUt5RytVY2lzUFVvR2R3MFM2b0xDdDZOaGxkL3hLNXE2bTAvT2owRUgy?=
 =?utf-8?B?UEw0ai9QSko4Z0FnVEYrMHJwa3pTQ095Z0FLdlpxbUxUalF1MXZlTkdWU2ly?=
 =?utf-8?B?Z0hsU2t5OW9kVWdiWmRLT1J1R2RZb2czVkNQa1BMZjFidThCQ25IemFpU3g5?=
 =?utf-8?B?TjBCeE8wUmI3Y3QvUWlyeWY0cmVDckhTY3lBTGhtYXpGQllEcFFqUTU0Tmxt?=
 =?utf-8?B?OUg0UGNsRU82YUVoT2I3cHc4M2pGRWJ1Si9Vd2Y2SHAvSDVCQXRzYWJJejdD?=
 =?utf-8?B?QjhleVVSQ0J0cmRIaXVkOE5lNjlkeHNnNXBiSEx0SVdmQU5NYXhweFdsemk3?=
 =?utf-8?B?OWVyWUVQNkdPQnhzSmZQd295ZWVCWFZzL2pZQ3NqSjd3dDUwWktCcGxZb0Vz?=
 =?utf-8?B?VWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74FF863B7A4AAB40886C467D63DCEF52@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6fVQk/RKIGCXlAurpqRS0y1UYSRq08T8SV/QnAA2ABU6BuhKS8BGJcGWIg4O0L2dpOrpedZ3ddYtRg/6lFp+BMmtc8nY47SUyeyJ6K0oicLXuvrAI7Uqny6cfgo3+Mk58CKNz278JQPaOcc8S8pksR64Q+RyTnGz42bYNMibKoo0GcYQl/l0Mg+/z3oxq8Ftyeqhu+b3XVS5qAzSow1WviuSpirGbH7TM9FtOcWmhUprJ/qL1rTDIs6ClvaYjLd4Uu7ksmbiZj8lmlQN8FhFUpexg5mBMal920vBuNHzuqGHeus6gyhnSlhFYlkNKA5CgoP8zUAXJvc0HV89tFGvFd9WiWGPJs2Ijqu/5uTFhyelw1+t9DVPwig8auxGFZuoNQ4SgqGZoqyrWCkuPB+1V/BATU6GPpBlyygz2WJnyDLhmwWHVo4YOMtQqikygPNJUrxIRiGLQ3VO9OF3l2kgRSuh/OJNvaS8H0YbcnG8F3e3BXeZV3xRHhDF2+rAYa8bBpI3OK0JXiQxaF30mpSX1QnEVaJBTUm77L4Z/Xzh0ngfKN0edihLdaApX2/k5C+UK5ui6bPwy7tuUxQXHnIaOcWqbCSpYNRl/rEfxMWYG3B8uOnJknScJqtD5t7r8cgt9AbU0x4I4USUF2VAuprygMSKQZl84eW7Fml3fx5uSQTd0XgKpLkt5gFLTdJo2qeD1VpxO00teohrvLddjUm1QfjpqjSuOiEe6kcjTja1HT4MFwnEgGlg0j43rdrRRvdCI+7o72CvYRqQZnCQpiTBqvMQVtIEfrkbf0dlFwbHRZTb2c2WPi8sTKaI7g9N5RzInQIcIxc367c3rUOMjdkvs8YKb2ntfO5ely31Tl3W53c=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10725.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc48dac5-0a9c-406a-7c5d-08db40b5a85e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2023 09:08:36.0602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6dEubWSa9YK/d20c3G9vr8h0Y+lhlbgZ88IyR1pKHw7FgPYEaCtR5b86VBfgzQDn2w86ltHyz/yeIsWJ+tYYRKRtXu6KihkyXzyG2KrZnSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11423
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

DQpvbiAyMDIzLzA0LzE5IDE2OjQ1LCBDaHJpc3RpYW4gQnJhdW5lciB3cm90ZToNCg0KPiBPbiBX
ZWQsIEFwciAxOSwgMjAyMyBhdCAxMToyOTo1NUFNICswODAwLCBHYW8gWGlhbmcgd3JvdGU6DQo+
PiBOZXdlciBnbGliYyBzdWNoIGFzIGdsaWJjIDIuMzYgYWxzbyBkZWZpbmVzICdzdHJ1Y3QgbW91
bnRfYXR0cicNCj4+IGluIGFkZGl0aW9uIHRvIDxsaW51eC9tb3VudC5oPi4gIEl0IHdpbGwgcmVw
b3J0IGFzIGJlbG93IHdoZW4NCj4+IGNvbXBpbGluZyB3aXRoIG9sZCBsaW51eCBrZXJuZWwgaGVh
ZGVycyAod2l0aG91dCBpZG1hcHBlZCBtb3VudHMsDQo+PiBzdWNoIGFzIGtlcm5lbC1oZWFkZXJz
IDUuMTAuMTM0KSBidXQgd2l0aCBuZXdlciBnbGliYyAoaGVyZSBjaGVja2VkDQo+PiB3aXRoIGds
aWJjIDIuMzYuNik6DQo+Pg0KPj4gICAgICBbQ0NdICAgIGRldGFjaGVkX21vdW50c19wcm9wYWdh
dGlvbg0KPj4gSW4gZmlsZSBpbmNsdWRlZCBmcm9tIGRldGFjaGVkX21vdW50c19wcm9wYWdhdGlv
bi5jOjI5Og0KPj4gdmZzL21pc3NpbmcuaDoxMTU6ODogZXJyb3I6IHJlZGVmaW5pdGlvbiBvZiAn
c3RydWN0IG1vdW50X2F0dHInDQo+PiAgICAxMTUgfCBzdHJ1Y3QgbW91bnRfYXR0ciB7DQo+PiAg
ICAgICAgfCAgICAgICAgXn5+fn5+fn5+fg0KPj4gSW4gZmlsZSBpbmNsdWRlZCBmcm9tIGRldGFj
aGVkX21vdW50c19wcm9wYWdhdGlvbi5jOjIzOg0KPj4gL3Vzci9pbmNsdWRlL3N5cy9tb3VudC5o
OjIxMDo4OiBub3RlOiBvcmlnaW5hbGx5IGRlZmluZWQgaGVyZQ0KPj4gICAgMjEwIHwgc3RydWN0
IG1vdW50X2F0dHINCj4+ICAgICAgICB8ICAgICAgICBefn5+fn5+fn5+DQo+PiBnbWFrZVszXTog
KioqIFtNYWtlZmlsZToxMDI6IGRldGFjaGVkX21vdW50c19wcm9wYWdhdGlvbl0gRXJyb3IgMQ0K
Pj4gZ21ha2VbMl06ICoqKiBbaW5jbHVkZS9idWlsZHJ1bGVzOjMxOiBzcmNdIEVycm9yIDINCj4+
IG1ha2VbMV06ICoqKiBbTWFrZWZpbGU6NTE6IGRlZmF1bHRdIEVycm9yIDINCj4+IG1ha2U6ICoq
KiBbTWFrZWZpbGU6NDk6IGRlZmF1bHRdIEVycm9yIDINCj4+DQo+PiBDYzogQ2hyaXN0aWFuIEJy
YXVuZXIgPGJyYXVuZXJAa2VybmVsLm9yZz4NCj4+IFNpZ25lZC1vZmYtYnk6IEdhbyBYaWFuZyA8
aHNpYW5na2FvQGxpbnV4LmFsaWJhYmEuY29tPg0KPj4gLS0tDQo+IA0KPiBUaGlzIGhlYWRlciBt
b3VudC5oIG1lc3MgaXMgYSBuZXZlcmVuZGluZyBuaWdodG1hcmUuLi4NCj4gDQo+Pg0KPj4gTm90
IHF1aXRlIGxvb2sgaW50byB0aGF0LCBidXQgYXQgYSBxdWljayBnbGFuY2Ugb2YgdGVzdGVyIHJl
cG9ydHMNCj4+IGl0IHNlZW1zIHRoZSBjYXNlcy4NCj4+DQo+PiAgIGNvbmZpZ3VyZS5hYyAgICAg
ICAgICAgICAgICAgICAgICB8IDUgKysrKy0NCj4+ICAgc3JjL2RldGFjaGVkX21vdW50c19wcm9w
YWdhdGlvbi5jIHwgMSAtDQo+PiAgIHNyYy92ZnMvbWlzc2luZy5oICAgICAgICAgICAgICAgICB8
IDEgKw0KPj4gICAzIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvY29uZmlndXJlLmFjIGIvY29uZmlndXJlLmFjDQo+PiBp
bmRleCA0Njg3ZDhhMy4uNTE3YjRjMTggMTAwNjQ0DQo+PiAtLS0gYS9jb25maWd1cmUuYWMNCj4+
ICsrKyBiL2NvbmZpZ3VyZS5hYw0KPj4gQEAgLTc0LDcgKzc0LDEwIEBAIEFDX0hBVkVfRklFWENI
QU5HRQ0KPj4gICANCj4+ICAgQUNfQ0hFQ0tfRlVOQ1MoW3JlbmFtZWF0Ml0pDQo+PiAgIEFDX0NI
RUNLX0ZVTkNTKFtyZWFsbG9jYXJyYXldKQ0KPj4gLUFDX0NIRUNLX1RZUEVTKFtzdHJ1Y3QgbW91
bnRfYXR0cl0sIFtdLCBbXSwgW1sjaW5jbHVkZSA8bGludXgvbW91bnQuaD5dXSkNCj4+ICtBQ19D
SEVDS19UWVBFUyhbc3RydWN0IG1vdW50X2F0dHJdLCBbXSwgW10sIFtbDQo+PiArI2luY2x1ZGUg
PGxpbnV4L21vdW50Lmg+DQo+PiArI2luY2x1ZGUgPHN5cy9tb3VudC5oPg0KPiANCj4gSSB0aGlu
ayB3ZSBzaG91bGQgb25seSByZWx5IG9uIHN5cy9tb3VudC5oLiBsaW51eC9tb3VudC5oIGFuZA0K
PiBzeXMvbW91bnQuaCBhcmUgaW5jb21wYXRpYmxlIGJlY2F1c2UgbGludXgvbW91bnQuaCBtaWdo
dCBoYXZlIGEgI2RlZmluZQ0KPiB3aGVyZSBzeXMvbW91bnQuaCBoYXMgYW4gZW51bS4NCg0KSW4g
ZmFjdCwgbHRwIGFsc28gaGFzIHRoaXMgcHJvYmxlbSwgYnV0IGx0cCBoYXMgZml4ZWQgdGhpcw0K
DQpXZSBjaGVjayB3aGV0aGVyIG1vdW50X3NldGF0dHIoKSBzdXBwb3J0ZWQsIGlmIHN1cHBvcnQs
IHRoZW4gdXNlIA0KPHN5cy9tb3VudC5oPixvdGhlcndpc2UsIHVzZSA8bGludXgvbW91bnQuaD4N
Cg0KQUNfQ0hFQ0tfVFlQRVMoW3N0cnVjdCBtb3VudF9hdHRyXSwsLFsNCiNpZmRlZiBIQVZFX01P
VU5UX1NFVEFUVFINCiMgaW5jbHVkZSA8c3lzL21vdW50Lmg+DQojZWxpZiBIQVZFX0xJTlVYX01P
VU5UX0gNCiMgaW5jbHVkZSA8bGludXgvbW91bnQuaD4NCiNlbmRpZg0KDQpzZWUgDQpodHRwczov
L2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0cC9jb21taXQvMzAzNTNhMWViM2VlODk0
MGYzOGQ2YTBlOGY1ZjM5MzUyZmQ4YTE3OS4NCg0KQmVzdCBSZWdhcmRzDQpZYW5nIFh1

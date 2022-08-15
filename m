Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2600AC00140
	for <linux-fstests@archiver.kernel.org>; Mon, 15 Aug 2022 10:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbiHOKIK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 15 Aug 2022 06:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiHOKIJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 15 Aug 2022 06:08:09 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 15 Aug 2022 03:08:08 PDT
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com [68.232.156.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D14A1409A
        for <fstests@vger.kernel.org>; Mon, 15 Aug 2022 03:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1660558088; x=1692094088;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0CwNHOt2OQnX8sviEqRIHdHNJhZJwi1covkNxdAv6wA=;
  b=zNOTrhsaoXBESSshoOemuX/1ZdZxDOOrDb5q/DSZGttqdR9QfxGXHtD+
   mogNBbyxr/WEz4t3kCtBrG3vsBNuHRPP6F0CPfZZ0FSxaQj1tzL7n8FCw
   cM4D26qigD5GeyAhpF+j5sDP7+B+POrNukd7YHehRbBPmwZiRcpIRZV+y
   9//q+CAP9yndjHbDSnagfJgBLumMrpvWIL6N8nEGpGv4dpWqC/boWxUnt
   RY1GbcD9vhdyEw7CQ+WGw9tWscZu80cQx2S3ex9yCTlFIS2jQnwb6uPl1
   O9F3TRvQLkTA8NujVx0fI7vnP3YS2BqhpceUYh1JVVykFe7Yl22BGecCt
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="62721818"
X-IronPort-AV: E=Sophos;i="5.93,238,1654527600"; 
   d="scan'208";a="62721818"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 19:07:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+boPPuE/+op74fv5TbXSpuU4/e16oks2P8pQfE/B1Wh7UkE0PWKwo4kfX1s04ZUrlyWsC39u8BRFh0EJPHQOGOmZbIUgCMr0XO9MBgoZYNayc3TmoZ/pgQUOtSfpL+qjDxfdkX14e2w/AC1v46NZu6Va4+6w/34NwS19pRDcnak2u7k4CvXyuiu35bND3AxglU6IcmLBf2gTuFLsxk7XN+IfGxfgqZnrVmiLB4nHpRuQjukfhlMldPquL4gOFB2qudHwirKDCnVPvBRWqtUp1Lw/Q7fy2GWVEv00N9euUG4vKd29sxBj81m44eEx8q2QQvCyOCPWS/P4DqlJps1Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CwNHOt2OQnX8sviEqRIHdHNJhZJwi1covkNxdAv6wA=;
 b=f31eUdb2T0X1s2alwMS8h7Uk9l+r5VEpTLdt5U+n77KHDCAETJ8oaw8ldM1MrM5L/1JtgW9WR2BrX5iofQdIUPCau1SEse1eLm5+gh+gwXXVdMUa0Z14Sh48qxnpp+DC6t7r+9QzwQYIj/XA6Ymh25EHPxpTLJdhOP3jvRykcd3g0Kwb9dVRyJyAGTML/raLhLy9yuP8JxvAlB/B80VbEVd1FqxqNg5pScYfRY8QPYW2de5lBD61izFVPOBMkmNQW7UToF9/8VGr9mK4xQHo8FIZTzQrx8lL0reRZDjd/udTYs71+x8kAbix5UIUSnDBEwSfv1aHnqBqK/c95deEHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSZPR01MB8011.jpnprd01.prod.outlook.com (2603:1096:604:1bb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Mon, 15 Aug
 2022 10:07:00 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48%2]) with mapi id 15.20.5504.027; Mon, 15 Aug 2022
 10:07:00 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] src/t_ofd_locks.c: Reset errno to zero
Thread-Topic: [PATCH] src/t_ofd_locks.c: Reset errno to zero
Thread-Index: AQHYp8GbW3gE4gYDBkKLA8PO8kGmfK2gaKeAgA92VAA=
Date:   Mon, 15 Aug 2022 10:06:59 +0000
Message-ID: <585a8c5d-81c5-c40a-b7c2-b50f36d6fb0c@fujitsu.com>
References: <1659593932-4158-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <Yu0whQTezx3Mja5a@magnolia>
In-Reply-To: <Yu0whQTezx3Mja5a@magnolia>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 373abd88-6efb-458d-60b2-08da7ea5e4c9
x-ms-traffictypediagnostic: OSZPR01MB8011:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LMqqAro1kfb4xhlI08jJnt2ivfHDlFKyifr9y2Qm00lp42tGwmfRTQUHVpoaQvin0GdE4us8mCTUsWNmXK3jP8kKEzSEXW/yofC676OWxhBslFKmPc3FL9fOc6Da6ywh/N0VB/L6vPym76siz7VneJj/TaT3RphMjF1vkpD3J9ZBWCxi1D6cosIsIOs2e8vRD5epccwLDunFzNt3oYZW5SRMOCDhKvwxlQcmB4fVl9GyOpO7EkwQ8Y7dfVUsQ1k/QqY3Bwj0Kkp52FQvL5lbfhPU2iX717MJqS0a3MOheKBm86XKCOV7pdn/gIsSbFB57i/m+lnPRJHfQCI7LvvhckGFEut+GP8aOkMcd/YUa0jLCWzRus9/uYd0Y7cg9P3jEzYlzvu7wtlAvP4M3IE4KB5EIOuWqxUC8wfh1CdrV8T65lk4BKNcig92K/DJpZQN81PKWNkrdYZL6MQp2+WRo7Q4xwIja0raEuibw5u+ZhxY4mjI8mCYtbqJmJAZfImkjhR03ocorJhRqxUlTbJN+RcHc1BR2HfJe8dZJj+Onlh0/sDBNI84ox+JY7TIrmJxfvtixO0RdXic6T2eoSNleVfgMrQGYF1K7UmaTuRbkOaGFqpzzxPHBTqsfvbcFMbr4GxOB/Rl+5bipNepv16ST2XIyksDSRHOOVoXMmPPyDfvY8O3qV29czza2ZoJqBIZeDlaPny0R2SV+FT5v2YkSy48k35jwBrTky261j1SQyn1vaZ6WV4JQS2RSuVSuCMKLSYElGnelTKJd+KUlWlZ8PUjlkqqo7Dg8OYF/Ri9XFa0lrfozLIu/V0CWtAUPIAlsGv8AeZ1hXKKjFZSqClNaobRJ0QiOKrqZ6QBS4zKxxE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(8936002)(5660300002)(31696002)(2906002)(26005)(86362001)(41300700001)(66476007)(71200400001)(38070700005)(186003)(122000001)(2616005)(6506007)(6512007)(85182001)(82960400001)(1580799003)(83380400001)(478600001)(38100700002)(66556008)(4326008)(8676002)(64756008)(316002)(6916009)(76116006)(6486002)(91956017)(66446008)(36756003)(66946007)(31686004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVpMTnVHbEhPa2czb0NaZ2dQbXNaZFJWMnd2VzkxSjY5T2swRFczeTlwOW5i?=
 =?utf-8?B?UmlVcEYvQjA5bFNHYUpDNjIzQkxobmhuQUVDd0FJZFhrTWpFRlRWci9lL3Iv?=
 =?utf-8?B?WVRlWkl3VmdZYkhqUFFvdjZOdUlmTm0ybUFKbkxCckJFVVNpUUpva015ZUkr?=
 =?utf-8?B?QmpiRkFERWU4aEdzOGYvR25qSFhuaDNVck92WlZBc21UeWtwMllPMExqTTIw?=
 =?utf-8?B?MkZPMUdsQUtUVDdySS9MUGx0Z3VkN0Z3aVM5a1pvcDd5QnRTY1dpc01tQ2Nm?=
 =?utf-8?B?TE9acHpadllsZlZhbFcxTVpNNGNReFRjSlNQRE9HSExDbCt4MGM5N0VvT1Ri?=
 =?utf-8?B?cEZnUVlHaGpMS3JjeENuenFaNVowUGh0UnNHWk5Wa2ZTTEY0SFdKOXFmN0d0?=
 =?utf-8?B?Znh0NUE5ZmRJbXpiQ0pXMlF6Nml4TWFzUUJWc0FkR2hkY2pyQm1sUG5mVHZn?=
 =?utf-8?B?T3ZOTlFQQ0tDRGFLcjltNE5maDhCKzMwS3RTYU96MUtka3dkcVh5Nno5Nnhv?=
 =?utf-8?B?THVhNDFoSHdoSEdXZjZXNmwxcVFSWGhUR0hHVVAxZkJkOWxBVmw2d0xnbXN6?=
 =?utf-8?B?Zkczcmc5OUk3RThUOGRyTkpNT2x6OVhPM1pMaFFWNjdPckRxcE9ZTDhwbkRz?=
 =?utf-8?B?Ykhjdm55c2ZrK3Z6eFlKeU10cTNPUENrTkpwUy81VE11UVdIQVAxcG44Tk85?=
 =?utf-8?B?KzA2dHZkNFBVcm1NdWJCU3NHVUJGYTBIa0l1MGdmdnA1YzlaTnJYSWlqRWlV?=
 =?utf-8?B?R0VmRVhhYlgyVWJtQkx2eVVKcm95aEwwWDFDM3o2SXRVaVFDcVNPaUVQV0U2?=
 =?utf-8?B?T1ZabDZxVjZ3eThNdjFSTnlpSWN5eWtNK0xSclBDU01SOWxNdlRMVFc2c2Jw?=
 =?utf-8?B?YmdySGdXOSs3NkgwZS94N0o2bHpOekcyMDR1UVZCSXVYSG9oM1piaStOdkV4?=
 =?utf-8?B?ZXZsYkZnS29BZjlwZUVodW5UYVI5SVNGU3B4dWhWTDB1TVdGQzdQWDVFb2s2?=
 =?utf-8?B?ZzJEVEUxREliL1FFUk11cUR5MzJPRUJLSWxValdueTNKUWw4bUNZZDJuVElw?=
 =?utf-8?B?M1VGN2oxYTNON2NBMmV2em1qMHkzWUhkTnZrVjFvcXQ4UkpTaFIvTUxuc0VI?=
 =?utf-8?B?Mm14dDFXTDdCSERWRDMwaWVtUlloYkxmWVMwakpibm5YVVpGdXVELzFSK0dv?=
 =?utf-8?B?cWNjcDRaOCttUlMzbWEzdS9qTEYrV0d4amtkU1BSTmJjV3RPY0NEcFJHWTdr?=
 =?utf-8?B?azVsTHNwWURGdkIvTFJCUEJRKzBWRDN0M0V2Y2RUWmNKVlZvMGpiWjFhdGF2?=
 =?utf-8?B?MVNDS01GYXZQQlh4cmhwNUJxa3VOdmhWTk9lZGk0L2tBa1BPMEVDVWhudjVV?=
 =?utf-8?B?M0kwVlNURUxha3JVLzI1aWRDWUpsMmtVMWVjaVBMcE9lN1pDOG1WUzdTNkNx?=
 =?utf-8?B?SFVTYlB3YmE5alFCd0xCKzZMSE92cjdKMHVqei9ldU9TUU02Zkoxd0hpd1Fu?=
 =?utf-8?B?Zjl2QmVCeURzZDQwWHlQZnlYREZ1b2tTSlhXWDZnbStycTVHc3Z1WjBlRGdI?=
 =?utf-8?B?Mm9UUkkvZXl4UXVndUp6andHcm80aVE2eFZ3Uy85dm1ZZkIrdFJma0FDUFVz?=
 =?utf-8?B?ajREc2x4Ry9zQ1haRXp4bmVlY3ZhMCtDbjlBU0N5RUdWSDBaMGFKK2c0a2pN?=
 =?utf-8?B?Ny8xekE2N2FzejZVd2hmbTFxamFLM1dOT2JPTDhWOFFpbCtNbXRKRmJxWXYr?=
 =?utf-8?B?RVViRUhJQy9LNTlYak0rMDc1OWUyM05FcjgxUzdxMG1SbGRaZWJpbU00TUVo?=
 =?utf-8?B?cEU0bUIyYVhuVEUxWFJPMEZJQUl3eEtGaWJHaWd4bnZmMzMzZkhuUWZxazc2?=
 =?utf-8?B?QTN6RFNvU0dOc3VIa24rdDZxT1E5bVVmbEN3UHlEUXB6MzVUa2RJU0NRRzVP?=
 =?utf-8?B?UDhaMmtxRG13RmhjSmxJTEUzSlZPd0NZV3QrdSt5TXFYRUF0c0dhR0ZQYzNM?=
 =?utf-8?B?YkxhQjdOejdRSjgxaDJZR28vTGVpYjk3dGdIalB4THFDWVBRcmdOelNwWWxK?=
 =?utf-8?B?QmVsWklOZnZQWkp4enVra085ZUlEbHNORHpwaDhTQm9xWEI5THYyZjJ0WmlH?=
 =?utf-8?B?UGJvQ3ZDbCtjZktnQXAzZEtNVzYwemhqeUlvV0ZNQ2pNakM4M2Y3RVZyOFdm?=
 =?utf-8?B?S1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA17E1BF5ACE9D459B1EDECC89118858@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: If5lMxYOVfq2LNM+fRa1EXU0rQC7t6Btsv1LJ2S2aPoyUEzaTXMPrxt5Ioqmv/3lpMtQrA2zIA8ol9MMtgKQzh6gMPOB6LOOmVQp6SQUvZxwYppcfbFbbyCd52ciwFZW+2jm8J99OippHN0o+xhlxjdiNO+5cujx+f6362K7pCQ9KRRcCdvIlqWOciWAqEW3igCm/lpXxmO9YSD1MTEheXpXqDZc7JTm4lf/LKcwwuGHJqGGhBdwt/viqmKAuAt147SWU+c4zb5BrkGlhZTTIwOMXGd37F+sl9m6t5bXey1wRAmKJ2vktVWqZUHNQMNuLFYzQBeOKebr9s5gAySHRhsoGk9BTmes8laju9Q4sGnMVt9aGukWennWoxW1cJ+QnpZctmVtPX5HOYtqC8qiD9X4bx+7w5QQvzZL9kTe5qqtjpZgjsjOE4GHJJh/M6e/n2JqCrrbz75fBLtws2aRPUdwrolYgMeBshTQ5xdAy1tnDmFNwEY2rBvRBnoTlgf+Tsbm8OHvKvwC97cDomRkz4GefZS8mq3ZfKoCp7KyV9HYyCtdcyLJfSbVGaWfx6d81x8hwX5/5Kr2XysrGSTVAObuSpF+TtbTHxgDIr14Ul7644A56TU5u9D5iz/IproWjRdehzzzdO4xfTvVn130TtUITBqTSE5r6xp/P0ow+AetXS4DuB1iZCy5d0mrkz0TdHHlYthVNZhg5h8fsUW21O5BP8IFFZhgPW+UHN0VWFKU1X7lndnXry/lhO2LcBT51G93mZqeEn4DhikaPYpBVw==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 373abd88-6efb-458d-60b2-08da7ea5e4c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 10:06:59.8827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qF9EpUZrOOr7+qSNXdMfh/OfEAEqYPD3fb4jFxZoriRf1FOK+j/Lbwm2dESrLfqCy4Yb39jfJHzzV93DUro5ZrqZnUiOxw4qP8NLKXXtiC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8011
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

DQoNCm9uIDIwMjIvMDgvMDUgMjM6MDAsIERhcnJpY2sgSi4gV29uZyB3cm90ZToNCj4gT24gVGh1
LCBBdWcgMDQsIDIwMjIgYXQgMDI6MTg6NTJQTSArMDgwMCwgWWFuZyBYdSB3cm90ZToNCj4+IEl0
IHNlZW1zIEkgbWV0IGxpYmNhcCBlcnJubyBidWcgYWdhaW4gd2hlbiB1c2luZyBsaWJjYXAtMi40
OC00LmVsOC54ODZfNjQuDQo+PiBCdXQgdGhpcyB0aW1lLCBlcnJubyBpcyBFSU5WQUwgaWYgYyBw
cm9ncmFtIGxpbmsgd2l0aCBsY2FwLg0KPj4gTGFzdGVzdCB1cHN0cmVhbSBsaWJjYXAgZG9lc24n
dCBoYXZlIGJ1ZyBhbmQgaXQgc2hvdWxkIGJlIGJhY2twb3J0IGJ1Zy4NCj4+DQo+PiBnZW5lcmlj
LzQ3OCB3aWxsIGJlY29tZSBub3QgcnVuIGJlY2F1c2Ugb2YgdGhpcy4gVG8gZml4IHRoaXMgdGhh
dCBvbmx5DQo+PiBleGlzdHMgb24gc29tZSBkaXN0cmlidXRpb25zLCByZXNldCBlcnJubyB0byB6
ZXJvLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFlhbmcgWHUgPHh1eWFuZzIwMTguanlAZnVqaXRz
dS5jb20+DQo+PiAtLS0NCj4+ICAgc3JjL3Rfb2ZkX2xvY2tzLmMgfCAyICsrDQo+PiAgIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvc3JjL3Rfb2Zk
X2xvY2tzLmMgYi9zcmMvdF9vZmRfbG9ja3MuYw0KPj4gaW5kZXggZTNiMTVkZGMuLmU3N2YyNjU5
IDEwMDY0NA0KPj4gLS0tIGEvc3JjL3Rfb2ZkX2xvY2tzLmMNCj4+ICsrKyBiL3NyYy90X29mZF9s
b2Nrcy5jDQo+PiBAQCAtMTg3LDYgKzE4Nyw4IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICoq
YXJndikNCj4+ICAgCXN0cnVjdCBzZW1idWYgc29wOw0KPj4gICAJaW50IG9wdCwgcmV0LCByZXRy
eTsNCj4+ICAgDQo+PiArCS8vYXZvaWQgbGliY2FwIGVycm5vIGJ1Zw0KPj4gKwllcnJubyA9IDA7
DQo+IA0KPiBXaGF0IHNldHMgZXJybm8gdG8gRUlOVkFMIGhlcmU/ICBBbmQgd2hhdCBhY3R1YWxs
eSBjYXVzZXMgdGhlIHByb2dyYW0gdG8NCj4gZXhpdCB3aXRoIGNvZGUgMjI/DQo+IA0KPiBUaGVy
ZSBhcmVuJ3QgYW55IGxpYnJhcnkgY2FsbHMgcHJpb3IgdG8gdGhpcyBwb2ludCwgcmlnaHQ/ICBP
ciBpcyB0aGlzDQo+IC4uLiBsaWJwY2FwIGhhcyBzb21lIGluaXRjYWxsIHRoYXQgcnVucyBxdWll
dGx5IGluIHRoZSBiYWNrZ3JvdW5kIGJlZm9yZQ0KPiBtYWluIHN0YXJ0cywgc28gd2UgZW50ZXIg
bWFpbiB3aXRoIGVycm5vPT1FSU5WQUwsIHdoaWNoIHRoZW4gY2F1c2VzIC4uLg0KPiBzb21ldGhp
bmcgZWxzZSB0byBicmVhaz8NClllcywNCg0KI2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8
ZXJybm8uaD4NCmludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikNCnsNCiAgICAgICAgIHBy
aW50ZigiZXJybm8gJWRcbiIsIGVycm5vKTsNCiAgICAgICAgIHJldHVybiAwOw0KfQ0KDQpnY2Mg
dGVzdC5jIC1sY2FwIC1vIHRlc3QNCg0KdGhlbiBydW4gdGVzdCwgZXJybm8gaXMgRUlOVkFMLg0K
DQpCdXQgdXBzdHJlYW0gbGliY2FwIGlzIG9rIGFuZCBpdCBzaG91bGQgYmUgYSBiYWNrcG9ydCBi
dWcgb24gbGliY2FwIA0KZGlzdHJpYnV0aW9uIHZlcnNpb24uDQoNCkJlc3QgUmVnYXJkcw0KWWFu
ZyBYdQ0KPiANCj4gLS1EDQo+IA0KPj4gICAJd2hpbGUoKG9wdCA9IGdldG9wdChhcmdjLCBhcmd2
LCAic2dyd286bDpQUld0RmQiKSkgIT0gLTEpIHsNCj4+ICAgCQlzd2l0Y2gob3B0KSB7DQo+PiAg
IAkJY2FzZSAncyc6DQo+PiAtLSANCj4+IDIuMjcuMA0KPj4=

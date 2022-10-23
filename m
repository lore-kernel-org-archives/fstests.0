Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5795C433FE
	for <linux-fstests@archiver.kernel.org>; Sun, 23 Oct 2022 06:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiJWGsW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 23 Oct 2022 02:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiJWGsV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 23 Oct 2022 02:48:21 -0400
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com [216.71.158.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5D16DAD2
        for <fstests@vger.kernel.org>; Sat, 22 Oct 2022 23:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1666507701; x=1698043701;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lw3O4wWJMXbEro0dHn8kS4hpLQn18vgOAeGG3+QP+W8=;
  b=n7TGo6yPRSbxLwunxfVjaTJff1Q8bYtEire/LNKrqeGBrJ8SyN/mXGo+
   fL3ugh/11/Sy0T6CNgXSncEwUuX0WuJ9JII2KV9ZQJadarnY7tNytF090
   9P5L4+7lRJ4+Aa8b/YNlb9Y8ZeHBRFsjoMxBoVVY3y9CNYoeSoGuijnQW
   toRvN3oo6Pg9owWykVxvGCsg0ww0wnDdSpMlfLHQuNJMMLLj6a3JiBLzH
   Qxqa6u65CdnD9D8IpzGhEysdXtD92GMVmZtCZOyZkQX1de+UxlNrNDGEA
   KkKjIMYSiXzpsSz9tEf9D08FgzgsNOgRw4zzsbG4ZXdmDTJELkkBOGyc8
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="67780748"
X-IronPort-AV: E=Sophos;i="5.95,206,1661785200"; 
   d="scan'208";a="67780748"
Received: from mail-os0jpn01lp2107.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.107])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 15:48:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/qQt1boqeZMO6xI9DL4h5om3/7a67b8/4W3qINYLG6qmfcULvMpEOLtRF8iyC1pHR93N30kAEXRmxzy5NoRWr2y4Ysx8PFhXribcgDSWpgvmsTc3BMI7eSiNQg5bfTbOirdgkXCWep5jqWBj5tozkgV+yx2/M56pqOCqNYk3nQRv6QJX9iN0VGp+kd+EiVx6Vdm91tvw/we2L1Kq0JHIHGiIzt1qCanBqye6lEzSGAQyc3gznyei2UCbD/ppGicIIrwVuHDb5x92Fl96PTFP/8EuRqfHp/GY15ITAzf7d4y7xhj6PVPXiZP+4PI/7LBGWVTD8BaAMcTIHDj6mv/cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lw3O4wWJMXbEro0dHn8kS4hpLQn18vgOAeGG3+QP+W8=;
 b=MkWOQv0pBvJoQIOd2JHBrzBq40nThP3MDFN5iqhhAB7LCUwwAIDk2/d+29yEhPFopR6o0HilH4c7+oTQuZdoboGaqtTteJAO4e2VHm8EgjNTBqsfD95EbH6sGvRBmm2QPEBxZxrIhe2ajdAjUe+aaJ9aA/jrj2bftrSfKHyNc7YMxxUQHuPiwP1Z8dc5/sEp0Tmj3IExMn3Yx2bWwWCsYWqg6EYqFG9gbrVpBMRMBs0U3saAzgRWxbFg6slDBlJiDjN3fCIAs2LKkMxRK/VTgWNakbJUeoj+SgfmY+4Nc3FkhVzJ0P2qb/eQ4NKU1EQfBc95TqdX+8ZvWbJyJ8FXNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by OS3PR01MB5574.jpnprd01.prod.outlook.com (2603:1096:604:c5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Sun, 23 Oct
 2022 06:48:13 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::339e:88a3:a24c:5f68]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::339e:88a3:a24c:5f68%9]) with mapi id 15.20.5746.021; Sun, 23 Oct 2022
 06:48:13 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     "djwong@kernel.org" <djwong@kernel.org>,
        "zlang@redhat.com" <zlang@redhat.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "bfoster@redhat.com" <bfoster@redhat.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Subject: [PATCH RESEND 2/2] generic/470: Replace thin volume with blkdiscard
 -z
Thread-Topic: [PATCH RESEND 2/2] generic/470: Replace thin volume with
 blkdiscard -z
Thread-Index: AQHY5qts2N5bRvRZeESyJzp2ZHepcQ==
Date:   Sun, 23 Oct 2022 06:48:13 +0000
Message-ID: <20221023064810.847110-2-yangx.jy@fujitsu.com>
References: <20221023064810.847110-1-yangx.jy@fujitsu.com>
In-Reply-To: <20221023064810.847110-1-yangx.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9499:EE_|OS3PR01MB5574:EE_
x-ms-office365-filtering-correlation-id: 8ac4103f-0be4-4d70-4abb-08dab4c28ec3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QktUVTAB6X254T1d0hLDVixPvnxx2ecDNoLvBa+uFWtrGfntEx7dpJazx/Noq441VlI93ETt6iQdzyvu93zslwvYdzhLz2zX0nyE29zov4CWW1RvVgclrd/9vKQPfFQOM+Mc5HXOANKI5cGNTUG0zWm6teInl6uUzHFyQVEpHqcCHaV3ErIJvd2f4JvcaXWz6x6ueC/GXRdKSJhB1eAO1YsawqhwNwBuBEibZP+Hu5KzRL6S8EIeb/x4UV2K7cOJ0ia16Vv+q354sXx8UUzIPNGk3opS4oT42jMqFndD2LVR5SXUvBTuYlp5BzdesImRdDrNxhlukyl1DnI8F+hfltz6UUrKFjoNNlGbC+nLWDyKKCwDmOQS57Iv7cH91+gWd1idyeRQSdVl8kvrbsguhFN+/d5dq0MENDQhC7DN0EElyJfiwUKshCUX39jzc5sDuO4S5FwfJ+sv+7VFZEB5YFZRrZQ5G5E93SFsKYZ75uVEMQVZWphJ9j3noKiekFeYSiUxqsvmXekF7DIYMUO+qK2bMWNkZUCz65uhf4dPeFLMqQSjlOYX7E0MAFqxl5Q8qczsefwsRvoYRT7KUJwG0dIHxjyBypLozkUojIEZXN7qMa4ylxID4FJc9XzHzOWC+SQRWsKB/BhQi8QDYccQPTJZYq4M9B0kbcOJwjAuocGyxfLxoKlvuENkOIQq23o1/dJkE5XeGPLHVQcB2gP6+C+reIm4KaPFRzj7lwVRt+Dd21b3wLo9HQ/Xdl0I7plYfMrBpJaCmht+jUPMMuEf4J208ItjHdZFJGrjfpb5N1ZYt7whDrE2CIBOVbZ2GK5S6zo4A6LWoP8woIK5rcsoFoyH9dr9FoaMxjeo3TbqyayP0nPuySov8g5JXBqQ9CRUp7yzMbm1teCPraHvZUmadw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(1590799012)(451199015)(83380400001)(122000001)(71200400001)(38100700002)(82960400001)(6486002)(38070700005)(966005)(1580799009)(36756003)(66476007)(64756008)(6506007)(76116006)(4326008)(8676002)(66946007)(66446008)(66556008)(5660300002)(478600001)(186003)(2616005)(2906002)(1076003)(91956017)(41300700001)(26005)(54906003)(107886003)(6512007)(85182001)(316002)(110136005)(86362001)(8936002)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?R0tnVFNyaEdreW9ReForTW84LzJEeGdzU3AzUTBYM3ErMkttU3k3YTB5SDBt?=
 =?gb2312?B?aGZiZ0I3ZGtEbXpNSVd1bmdXbThoamVOUkdTSUdQdmxZemJnNXBrU2dlbStz?=
 =?gb2312?B?dDZ6T082TGJ2aE5aTm4xWnFhaHRNcGhPV0NxZUh4R3lqbnZtYTNYcElKSGNP?=
 =?gb2312?B?YloxSmVEeEhFRGkrNEE5d0JnR054WkxHRFZiRXRYL3RaWHJzd2gvTHplNWJN?=
 =?gb2312?B?YzBKdVFWbExUWlNiYnNqYjhDdm5vUGhmY05tSERoZStvdyt6bUhiNzBVNEFn?=
 =?gb2312?B?RVc5eW41OWFtbEROTVd6YTF6M3llRDVUM3g3ZnN3NVZ3bGNnUUdTS2lzMk9G?=
 =?gb2312?B?aVlZQzBJMnZiODF1bHQydVBFUVFqSHZJcTREYzhDazdqV2ZwUDlmcWZ6bjZK?=
 =?gb2312?B?REpCZE9CR212MWdXYWNUTTkvQlE4cTZ0LzBpM3VGNVpGZ1lrNithTzgyVktE?=
 =?gb2312?B?NTNSZUxCRHB4NHVkRHIxbW5VK21nSUlyaE9RNFlhWTRlSGJpVW95YlU2Mzgy?=
 =?gb2312?B?Q1dEejg3bzBJcFJKUHFrYmRpMnZRMDgvREpacGVTTTh6ck1LM3FuQWFrNWJT?=
 =?gb2312?B?ZEhYSEswbFg2bEtKSG1JUW1lbXhTYXV4RDRhR1ZMblpPTjNkcFdkRXZMeDRz?=
 =?gb2312?B?UlZhMzdwTG5MWUI2UlVEWmo5eHBkdHNlMnpIVmZSbVE4Tnc3NDdaclNjUU5R?=
 =?gb2312?B?S3RhcVJpQXNsUGVyc3p2anBPTXJTVVRqZkIwdjYzR1dhUk90dVVtS3MraW90?=
 =?gb2312?B?WnYrcnBMSWl2c3N5dmY5V05jTnRZRWpKVWxQdmFBdjg4UnZ2ZVRWNTJLSEFS?=
 =?gb2312?B?cTlRYUNYRm4vcW1rNmk3YUVqZnJ0aVlMRFlFdkxhb096aytRZVE1VTZqS2Z2?=
 =?gb2312?B?aTRUVkVJRnNEalI5TVV5OEw5ZnNLY3F3dVVWUzIwRWRzMDBiYVQwd2pkbTdt?=
 =?gb2312?B?SW50bDNwOGVuQUF6T1FMekF1RVhXT2VzVTF0ZXFTZG1wN0UxK2tZNVYvK2pl?=
 =?gb2312?B?RlJMWUFOUExzN0k1SVV3aUlCeXNxRk9JQ2gvbEh1Z3VvVStvcnNkZnhLTThS?=
 =?gb2312?B?WVNxNklEdnU3RlhQL2JHN0Y1RThqQTJKUmVWWTAwM3hrMmxFOUliMjZmSmcw?=
 =?gb2312?B?c0Y4YmVIUjJIV0t3VnFlWVdYbVdsdHBENFdmQlJlekRnMlBlVUtzWTJLTFJE?=
 =?gb2312?B?cUlFcEt4K0YxM2lFSjFSdjg5WXRQelZvMEFFTFEra1NRVVFrU1hsMWlsclZr?=
 =?gb2312?B?NEc4S0V5ejg2OWErc2dYVzQweTRsWHRNVzhlWWw0WWcvRFlEZHpMNG41UytO?=
 =?gb2312?B?aVc1alhoSitoNEdmRWtDV2xDT1NKM1FPRWJJSWZvQXJBRkp2Z2VwSUZQOUNQ?=
 =?gb2312?B?OVRtZjBiR0EyYTRKZHAzcjFqYjg2TWMvK2hKRWlWQ0xwamczcUFGeE1zUkFk?=
 =?gb2312?B?N2Fib0IvRnkyeXNmV1lLMld3S2R6clN0NHFZUFBoanZvYnl4c002Q01JSzRa?=
 =?gb2312?B?MERLaTJ5NjFKbGlQQ09HWkRCUDBKM3JEd0IzUFBheFhYSjVjMGlnSjB6Q012?=
 =?gb2312?B?YjhKb0N3cWs3UUllNVlzMjVkamRZWkJnWi9qeFV3NXJ5MEZTTDZSWGVCQVBY?=
 =?gb2312?B?Y2RDVityWnhsdHpCdTBDV2lnZ3hZcnBlc2ZXMTBaOGpkdFJRYjdXdVNxWGpF?=
 =?gb2312?B?YXdsSks1aGU3KzdsenVGSlRXREllSFFaYUxMbjFmZzRuVzdiekhLQmxGWlVS?=
 =?gb2312?B?bkhvTkZ6ckZIMjd1TlFjRkFESHFxRWZoVm5KSit0RW5XSVB3VHI1V2hEcVhl?=
 =?gb2312?B?RmVETCttT1EyQzJqbTBTOVNBNUtBcDlCRXVadi9PUWJoRWM2NnRPbjZNNUFn?=
 =?gb2312?B?aW1yalJYWVRNYnpFSm5iS3NkMjBpWnZCQ3F1NUprOXdJOW9VdmdEUm9icTkx?=
 =?gb2312?B?TXBxYUZVQ3BUZjNSRjdoRkF4VmE5YStGUnNiV1lRNGl6cWwwNDBDZGZSMlF2?=
 =?gb2312?B?SkNpdHJhZUxmZ1RmNTZyOG0vOG83bU5jYkZqbGFLN3RqUGVhTHpkeURHeS8x?=
 =?gb2312?B?cS9Gb2VZZWtTNjk1aUUzRVRxV0JLUnRCMFZ1TGY5L28rOUI0ZWlOVUc0Q2pr?=
 =?gb2312?B?czNBc3B3M2RRblRyWHp3WWRNaEo3NDBDbjUwcCtxOURMUDdWY0IxNnRoL3d6?=
 =?gb2312?B?NHc9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac4103f-0be4-4d70-4abb-08dab4c28ec3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2022 06:48:13.7696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hgDkFfxem+3hqNfMwr7TI6kkPkvQwGNg8q7nT1GFUhpFYwy+h31hMMwDQUx1ux5EBKGqv6gvGUzU6WTjqHA1+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5574
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

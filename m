Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45474C433F5
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Sep 2021 09:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F44F610F8
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Sep 2021 09:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhIGJ3x (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 7 Sep 2021 05:29:53 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:26216 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhIGJ3w (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Sep 2021 05:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631006926; x=1662542926;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XXJiuh2a7y6yFiAlehmwJlkMPqSjkD6xxOCj4PUdZxw=;
  b=pBPTP78V5txZXf5tzzwBJkIYNBkIZzl6hgc73Y59Jv7oiu1YShfftl1q
   RzB4qxLhjQDo4We6e+XUbnZEwcKCilTIRVzwFqgnwWJ8SgrhvBwTXn0Dc
   EdV1xDKCCk49XdLm8StyYkeWHf/LEb0k+mBptKTpx3MbXnP7Wj7Cyf5Dg
   lu46EnYYVc5FMvejcKGQRebeiGl8+5qeJ6ZfNN7aOsi3ttuyRDqyUckmq
   1UpkErBPMU49QRiI5Qse+ggAmUqo7hsJlLM8hTNWrW+cXZVKBmP077dux
   OxUJuG3EKUKMylS2bBqln3h9yOxlAE01672ePOlGNXrj2E4lDeWcCmD+9
   w==;
X-IronPort-AV: E=Sophos;i="5.85,274,1624291200"; 
   d="scan'208";a="178458036"
Received: from mail-bn8nam11lp2174.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.174])
  by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2021 17:28:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Az2mNyE/3efOAJcwjdqO2M7RXUihs33RS3WQwLqu98oPP/MeBnLtfFaFHpx3Qi3GHywC2cXVAFHdgtE2/v8hyc9brJxIh/n46wEpU0KBXCtCjG5+UQN62X40RetnUqTZxpTXZ1wo6Kp2UWrxXpt7pPhjn4L4TJrB39Xx18M7oDzaEWukkGqLNdL2xTAxjm+xVfYIQapKZ0qbp1klYivEq1DsrvjzVhizp18UImzgD5EN4DDtoSSHhtieFppS1HvvkMLQsHI7mLToWbUxSKxOfkjLXtcDGOkdx2wQRlnscf24zKYqsmzdDvEOx3rSz4txjoJ9PTv6RckX9May3Ef0Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=XXJiuh2a7y6yFiAlehmwJlkMPqSjkD6xxOCj4PUdZxw=;
 b=DnbCMKLYX3qMWUIPZaukUMNEiGuVAVJOf91JFvym37lhp5blAbRf7wIsYMcKBRuHeiGgUdDB5KB+zhOcmCSCqItst8C8E+uC+pQ3aBvSbRk6yiSaa+c87aU1Cwu4hSHVhwe8Qw7LpMu8Ye1g1hY/U5GmCsC81boKUrQWudMWFUzz15oRLuqmhDm3XhR1P/BPj9svOoy+kfEED0NUfSl+uRIiU1iRJPzuV+LTBJnTyOz9NmemeRrKifoycN6wpviy0VJikY0hf4bhC/qAvtKLSwr47e43od56NoarNTB3/S8fYaFQIxMgeJqbUsUqaEvQLhgaECW8ut7LLNe4ovLKOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXJiuh2a7y6yFiAlehmwJlkMPqSjkD6xxOCj4PUdZxw=;
 b=iW6+Sg2hv1QtxnXibW+3meojdLZMy9S5ALM5/EUGl7BPQrWgvU6U6oe5LjMwtaWJG0bdoDM54/HdT3rTRl2Z/mDsAK004jg6zur7JmXpv28QBZYlWmtDL5NH8F+JdKwno2gsQAItx8DJlN16yaCqVaYPjUHAitAEovMvQSjB30o=
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com (2603:10b6:a03:291::7)
 by BYAPR04MB5573.namprd04.prod.outlook.com (2603:10b6:a03:e2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Tue, 7 Sep
 2021 09:28:44 +0000
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::30f6:c28:984d:bd79]) by SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::30f6:c28:984d:bd79%5]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 09:28:44 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] common/rc: Check SCRATCH_DEV in _require_dm_target()
Thread-Topic: [PATCH] common/rc: Check SCRATCH_DEV in _require_dm_target()
Thread-Index: AQHXo7u/9P+R31361keyNuMAxjN//6uYObIAgAAUVoA=
Date:   Tue, 7 Sep 2021 09:28:44 +0000
Message-ID: <20210907092843.ludgrxfo34xud3ue@shindev>
References: <20210907074116.1799114-1-shinichiro.kawasaki@wdc.com>
 <20210907081556.GE1756565@dread.disaster.area>
In-Reply-To: <20210907081556.GE1756565@dread.disaster.area>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fromorbit.com; dkim=none (message not signed)
 header.d=none;fromorbit.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db50216a-b6f7-41a1-fe58-08d971e1e36f
x-ms-traffictypediagnostic: BYAPR04MB5573:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB55737F4DBD7093B5ED2C0CEDEDD39@BYAPR04MB5573.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QEFpZMLKshcD7AQETCX/+y+uP5ShK7oSthYjRI7pH/KR8M54ZCtfUHIlQN7iL5xEWWn6/ecomq/TgdltAq+dmvv8RveALSPJBx2bRZ7+XNuLL6qGx0VHUD/3n43pt78dWCJ3cMN8J03u3DMFIuMB6MHNnAfLeNYnL9QU6hiLDvd0I5IPx/1Zl1G9KD64g98ADd7BY+M7m+vUWx83X46p17uI9zhHFrGp+74P54tdsA+SeFJseRA7tZ7g3G5q0iMEApEaPUJTWCqH27Qsg7IN8NNN1rvMEReFlYfJuPQ1q+PBrdJ3Z0uIOABfDsvdIA6loM/qxtiWelI56D+2KKQCfg3gSpr7uvzzsl011JfQvx+FyF8jV/YziTRLBo/VCvL/jBtKXztP3X9aYuqs3/JSe5hTWewYXDd13eK2t4v+1HkoeMpf2O9EmGjk2y4tjmSo8+9rqNySzvA7c00ArL4vud7E8Jgna9vlpp5I6XpXihIEe9To5iqxu6kWGFaXjYC6L89+yg4QnK2cdg5Ddi2RUqEa7nR/llLlshWwrrdnRhyAuGbT69oAgy1R7ano1sGzLM9+5N1Ne7gMQa21Gq8nTyr3RrF4wxSk7cAQfHh+aqidAaAKsKgJ/IOnx+I7WDnT8k5RqxGFmgvwg383zQZoUYpUBVsksICbe3P2oYgnIhbEiCaVGNaKivHkh+4DsMHfBKlspqn64iQuWI7znjzhPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7184.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(38070700005)(316002)(44832011)(54906003)(186003)(6486002)(8676002)(6506007)(76116006)(64756008)(91956017)(86362001)(66946007)(5660300002)(66446008)(71200400001)(8936002)(66476007)(66556008)(2906002)(6916009)(1076003)(4744005)(9686003)(38100700002)(83380400001)(122000001)(26005)(4326008)(33716001)(6512007)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?41ZqHgRRqu/xQtE1x8eJX5nxVQEhnkhfp9/0mCGRggJQXg2TpzJ7HpE9aK3o?=
 =?us-ascii?Q?svKBdGMusZK4uMUPJuSSGiNiCCWegW82UWtwf7Julm6JwN+5KGReTNg3eU/l?=
 =?us-ascii?Q?4DwEmdOt26pTt6HcWShI3TjqO9eXlwO0LKm+pC2hIOKc5expI4cuV305CJXD?=
 =?us-ascii?Q?tyu4Ts1rgIC5PuqwjUhAcmGC0v8P46IboBb0VbU5oTFEFShaLAhqF8TAEFh9?=
 =?us-ascii?Q?aIt1Aa8vrK39o+TLrkA30ycfi3glWoR2ZueaAE2fw4tvMoCxBEhxDR0lHgm3?=
 =?us-ascii?Q?d741bLMF4he1WcO1ZZdzQ75l//NmFVsGzqxroah4K9VaWqK4c51ZAZSBO1no?=
 =?us-ascii?Q?CfemmmXLPtK0snYfIz1oUtWfWwtmMWw2JMsCQNPC94OtFa7Js2HLNkIPfNTY?=
 =?us-ascii?Q?1WwkL7HnvLFyjAVmlolZLywWBCv0as8QuuODeZli/ZI1b5PmrRno3YCw0XMz?=
 =?us-ascii?Q?3oTyw35ahjA/cPhISt1i7Fz4sTz8+w0dtYbPH0zNARwm/SC7wqr8eBqJwVhL?=
 =?us-ascii?Q?WbIc/uSrglq/cfh8NQ9SfEBmo8xK2da2xNZ40BG5lnR3BXSUr46N88QwBdfO?=
 =?us-ascii?Q?CyRBnUAfL2uiiJqOPiWD6FhLUJ0Y8vNvwZvJsrAyy9kgGojnqiiywB5pgqwM?=
 =?us-ascii?Q?/z/VPqLOzunADUOy8w3MZhQHgHjWhiwt+2iHmVbDlZhSl5iuLW5DxU9oawVj?=
 =?us-ascii?Q?kXsLzF5JZzk0L2qn9bdqSdKPGGJR52WFct88+2Z7NhNy4T2UGKb21CsmrSf4?=
 =?us-ascii?Q?NLeFsCpOv2CAup5FiYopk+LO7zi1axepwMxYTpWTbBiPXgImcy9saHZ/ROml?=
 =?us-ascii?Q?Tmo54YR2wZ8cxTOw/Dgb3cQU6oUZSlPZZMrGHx9x7z0iiEAPFluwiaKAbG9y?=
 =?us-ascii?Q?krs9ABWr/pv1t2E7eyqIXCXtr++4xlf1yFSTFBO+VW6/Cz/pW0VR03kibesA?=
 =?us-ascii?Q?GW7Qad9u/NVxPHFdZzANNdK/MhS9u9I/WE2J7cfZU+MIxNJqc4eUDAT2dMQL?=
 =?us-ascii?Q?443DuYZ72W9ElpvEHJp2tDhNuriQb/BtBgWR/ab20YhaxOCrWPBSjvvltqJ+?=
 =?us-ascii?Q?CIWT74oQXs/wLI6+EYU+8CINoR6YpMbeccagw9CP7OtnluJTe9i7An2wCZm3?=
 =?us-ascii?Q?tV9JEQS7Aekz7AFglR2yOnSNfRQTen5Uu7Op/WUfJJLdDBwcNAC5ST1Lor4s?=
 =?us-ascii?Q?GnCd8zWnCFuNM4Voo36oUgT7zi5mm5hSSTAMxQaIwo1Jo+3bCCIDTckO4ut8?=
 =?us-ascii?Q?KBrPIqISTaFtg+zguiAdAQONz9f5JyN63RSn/8ughQKzzFuWPXmgWUwB00Mc?=
 =?us-ascii?Q?zg5MiqRh2dLNXZW0jygwAL7OpuRRtGpJbRFtleFmyJmsyA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AB6C5EC2B561D74BB33D1C23AA99FBB8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7184.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db50216a-b6f7-41a1-fe58-08d971e1e36f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2021 09:28:44.4892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0tSh3G7nZB0KbH9gfdkWyNka/XXPdPz8YTWduGiipVMG6Ee8AdqNjK4WNG1VfU23FOD5nmaaGInW7+1bA7O/62CNiIlzeLwpn23p1hd6mAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5573
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sep 07, 2021 / 18:15, Dave Chinner wrote:
> On Tue, Sep 07, 2021 at 04:41:16PM +0900, Shin'ichiro Kawasaki wrote:
> > When SCRATCH_DEV is not set and the test case does not call
> > _require_scratch*() before _require_dm_target(), _require_block_device(=
)
>=20
> That is the bug that needs fixing.

Thanks for the comment. Do you mean the test cases (generic/628 and generic=
/629)
need fix to call _require_scratch*() before _require_dm_target()? I think t=
hat
fix approach will leave the possibility that the newly added test cases in =
the
future may have the same failure. IMO, the patch posted will be more effect=
ive
to prevent the failures.

--=20
Best Regards,
Shin'ichiro Kawasaki=

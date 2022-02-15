Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B7EC433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 15 Feb 2022 15:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiBOPwp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 15 Feb 2022 10:52:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiBOPwo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 15 Feb 2022 10:52:44 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A829E540
        for <fstests@vger.kernel.org>; Tue, 15 Feb 2022 07:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644940354; x=1676476354;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=cKoQnO/tiKq5tBY+b8rX+DElqY7dvWWgMUWxKfvb0NZvBomDYXkunfQa
   3I/MNv5Y/YHp9Rx/YwLyD6sBNRtTgQduRiU9FP/kdgi7OQi8/tZTYnImx
   X5hCK/QMhISQdbVnGCv2kgqdYpRdoYYyXXoGslSQBqOMwFlgOVd4zJj4R
   5wlqBoUv1LY3qFSfFoH0SrKYVulN6+pcpK+jRPo5UPnvcnPTGU0cJoxCA
   FKTGcj2TVTykH9yPoYJYfFVlzRMSqiDSHa2G0HMne/3g6B/PSBHc7T+uo
   VK2qf8SM8AYSqiUNcoCNJXqp5fkHaB5uCbxmK9K2zjDHdq/5LgKU0oxMY
   g==;
X-IronPort-AV: E=Sophos;i="5.88,371,1635177600"; 
   d="scan'208";a="297122702"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2022 23:52:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TdaSwpPo57UXOCxvyQXDFon8lX2WrbqQg3F5Bef75m02WQ5p881QpfqPqwBVez43R0+k5/AhVuXHaz3ISExPUo5uRXYH3zaAN551JulP8g6Yaxq9XGS6XTtQSs6cvgzkvKT6Jz6qMM7kHkTchoolVBmqUEJYDa7EIXxEIBInnrx5/y2s16+6kutbQu5vBWhaTbtajKFtV/lnm/p0Fmol9KvVa90ipPO7lsIjv9OX3ud2qE31jBmxqCDBruOSeCoVIppE4bFcPPuKNxl06da+0HxIIJXFuCuDXSSFcP+kB1cOrjBz+pcWptikMvFKH0yA/qzP2B7KFw7qQAvenvlYng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=hmE7z7vhedfU+M/XSy/nDXmse6dV3YuXTufxxr71nZnGHfbCsWfLaMcUWPPF0NtTYd3zji55Lr6FyGLPfl7zVB4j5RpvHDIAHGvcaTOTRZWdxQsv95c32NC3fHYimAWGnw8TaSzeEYlw81EeiNONyvq3nzGHetcaXiWjf6bsF+Ta/MbZerdAGcqkFc2j0Qj74L+HQ3eyZq45yG//jnqrnqmBQM6bIfUscRaBFH+01in1sk3piIYhOa0VT7b58drkSfGAgLHFJ1i0KnUWvfz+pxIZtKw/d6CPeK42SkibaFUgXzqPfvGO2mtx3zAlRl/rbMqo3f7iLrTRdZ8l5V61pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=OPbjeE0hbfZNCW+dNt7Ou1FrKMKLfc1ALvCMp0MLSugGAeMLzE8th1ZKy3yOK5+5ChGgq4duhv8RPh4wIYbPwrsA0M7rW/DKA5s5dD60CpX6NqrQbovxV6Z1zTRGSdQwKmNAfGFfnWKJuxkmJANx91CLyjt+0wzc0NB1rQqbdFk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CY4PR04MB1254.namprd04.prod.outlook.com (2603:10b6:910:5b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 15 Feb
 2022 15:52:31 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f%5]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 15:52:31 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
CC:     "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        "p.raghav@samsung.com" <p.raghav@samsung.com>
Subject: Re: [PATCH v2 3/3] tests/btrfs: use $AWK_PROG instead of awk
Thread-Topic: [PATCH v2 3/3] tests/btrfs: use $AWK_PROG instead of awk
Thread-Index: AQHYIg4vey9eOWiB0ES8seT7OvmUeA==
Date:   Tue, 15 Feb 2022 15:52:31 +0000
Message-ID: <PH0PR04MB7416519AAD0D9752389808019B349@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220215014845.4164719-1-mcgrof@kernel.org>
 <20220215014845.4164719-4-mcgrof@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb7204a2-5329-4209-e3df-08d9f09b2d2c
x-ms-traffictypediagnostic: CY4PR04MB1254:EE_
x-microsoft-antispam-prvs: <CY4PR04MB1254640847AE14F74DCEDA609B349@CY4PR04MB1254.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AVI6jSB5NDZiSHa8u5HbgX7QaXoJke6zKStW8BR+H06ObNhqSvkA31eYEpR8cSil8aX81jN5rcjlem97jjYbfiv+trg32iMxztEQpBpMjJlreBAcdft891DfnkVJZ9sa/YU1Ho4LDGxQx86ZmJdfHj/umlado7Upk/Yaq+9sSD6V3wscrsDTKQ5cDDyNSEdu1BsgCZyI+nwshJfxbKa2Y6rfwrGq4P3wxSKTLmnzHrEHxeb32J3OksOj5wLJGxPvZsZy3Gsd3Skl3h843N+4np+xGcNM3C34UWkWIWOXX61Id1wd0KRL94dFRWLl1FKaukE4t70vesbQ57oW4MYhx1/nbKnofKXZI7tWXQ5LfkSwz+eI+Soq/hygok00XH/ycdsdo9efR4RegHBL1oWXPAWbYAjPlcHIGwl4O+whoyOk28kdTLhg67K+ni8fNOV+LxP1nkwr0u+3KSSsSrlLJ8F9vs67xQciGHb5oakaq/U+gki6PVdWHJ5Dwq2QYdcyKnkJSCQdWwqDNiBNMAriwsRuQU1szdSQ7U8hJ93f0AZZShgiDO7tsSDnpgNC5Ej1L+iuKcTJZ3gPdwmwZYvIiPf54upLObO/qMuQTk+BHogYfhgyubbXaVKpStiEsk/gNk59m7tFJ1ziCFTYysqetxX5o2gENYpAQGn9G04vm7gwH6rMd5BYitcVuRkp82dUdrk4kHtGcECe94ZoU4UV4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(52536014)(7696005)(71200400001)(9686003)(6506007)(4270600006)(33656002)(19618925003)(26005)(8936002)(2906002)(558084003)(5660300002)(8676002)(66556008)(64756008)(55016003)(4326008)(66446008)(110136005)(54906003)(316002)(82960400001)(508600001)(66476007)(38100700002)(86362001)(66946007)(91956017)(38070700005)(122000001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pe4y5oj3+vzjfVHFL8NKet/UcPkr8SFpeB3R72XbcP7iiMG1DG8TDuQJnfQI?=
 =?us-ascii?Q?8mkA5+p6CiibEIw618nRsGSDJx72zKH2MeY9wuAYuNmOT04gNkP0PP44+xnx?=
 =?us-ascii?Q?IPNzVVVgyEllQFWX2MzIxabZBJyObv/SVn69SLLNnZP6oynOakjhtAbPGylt?=
 =?us-ascii?Q?/Cf6kScSpOW5q+8UDe5iWv3XC4VPAD7E+aN4T3q6EzpgwQVmNcLmEzqdNe0r?=
 =?us-ascii?Q?lSKKZtHmoKTHRugw21sQv4N+pPwHRJ3het/tWmT0LhfdhVyOI5+pvUs0msKU?=
 =?us-ascii?Q?G5UiXVVkNGZ3964ot+/MHLlpHQj7tCRtBlO9m0TLmeVIINGyuRGaTL8E8vWR?=
 =?us-ascii?Q?cc3iHaC/xnbDuIL+vxDblm5zP7aiM1jHA5Zx6gCKNfmPBCLmxyLl67XoDccQ?=
 =?us-ascii?Q?38YUsh+8I4KxBsBML/zknFNIXRe6+qJ8BJtbRC9q4aUjptThGZyuOCd8AIEy?=
 =?us-ascii?Q?2NiXY6fhE6wYU7abE4+afOPXWznDsPxfdoji6N2lnprSBmbz2IVGaf56sVq7?=
 =?us-ascii?Q?WV+IAEAZJIiqis6TZuDbvfM5xfaRaUc14erHaqGb6eRSSgoZ/fH6qDE/5+rZ?=
 =?us-ascii?Q?O2t13apm6o9s3685/+CcLtllW+fha2tJCGD6RFjsp4Ci71SqvAtFpDE2Va0C?=
 =?us-ascii?Q?JhtW9zBSm41plmn4HIIvhlEeZquut+2YlhD2mP7Ly42gQ7jlKhJVA9CCktIf?=
 =?us-ascii?Q?cs5gEfghC6rkOfvCYOBYdOt3nbHWZF/6yRMSssqyK4OBbCIbgWt/HLaVMYOy?=
 =?us-ascii?Q?H2adcZDlIEZOms3GaVHuorVjSXDqEKE+oGSgEqmOxKb9ST2S7zQvC+gBaDWp?=
 =?us-ascii?Q?et2FOcsXNCo0ordg0T0M1qOBPNIio8SC1/kLVRpgdgB0YbUchLlCIOJe34j/?=
 =?us-ascii?Q?zRsq0c4DSUObVebnjm8XFo8Fe2m6I4y0yF5RhYRI2hAI8DCIsnBngC//Z+7U?=
 =?us-ascii?Q?wO0kMqHLPr0qQVyZztAB+CHt9rmsHPikRXdMF5RzPb6G93piRsX3ifnyc68g?=
 =?us-ascii?Q?tTB5YmardTv1ZD/dAR7x4Z/YpLT1r3Cw/NgqtCru3yqOd1fpMZMdyZ0CAKio?=
 =?us-ascii?Q?Wdp9ywAHfytFcbnN0Qp/dlgu5eOIVN0547ZnW6O5w+qX3Zi2L2nR9EGUqAHg?=
 =?us-ascii?Q?NVOXBg/lx06dizqxTDVhD3k8A1pX/47pCYUunOEzEMvHXq3Q6AjircPghygN?=
 =?us-ascii?Q?2nDqnIHey/sHzmBuTfSWc+9OQ7yyUinxwKe3eKfzAY/X99o9SZSLViw2YruE?=
 =?us-ascii?Q?z+4l5ab+AaVpXxu0l9Kcc8kIacL4Yn3zCj5F1gqPTYUxSBnV9KYt47erEq3S?=
 =?us-ascii?Q?cPQ+1+vdgqPfCp5A5JKwCi6wuFkk3cEiBxhGmqUM9ggE7uEG8N6WvxFmyKjQ?=
 =?us-ascii?Q?OB8YLy6luZOzoi1IEteq3YhKCBiMwGxoWqUYdgQuATc5adp3pcXD0uHIrr6I?=
 =?us-ascii?Q?gHDF/V7zyy5nsZOW9gkoOePEFp7rK7rH2qZ2xS1qR/vAZLVt4sxzAAMjvSrj?=
 =?us-ascii?Q?N8Qruv9aJv4BilIhQ7Ii7AkR97OGdiVowQp5vTSY1sAmxA9BaC2rZN81QMpJ?=
 =?us-ascii?Q?Wz/es/n61u1vdPHoWzBvMfUbI1LzWws7tPWTeIP1QDzZ96vVPS4jbg8oiPjD?=
 =?us-ascii?Q?mVhrDTS0sRZMd5BMpZJd5Aej/3jKG7ROjtnS8z7WuPIwj5xWWp1qjiYcUjI1?=
 =?us-ascii?Q?/kZoLcwBlT5OKKbEOBhoN109EVE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb7204a2-5329-4209-e3df-08d9f09b2d2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 15:52:31.6899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jQDaTzhThP4svqUNquBMdhCPH3rn7SYRdSjnv0l1uuUi7Jd80MD7JQENjfAWIK5dE+yOpVwsLT4y7iDrDIndah9LVYy49XHekVJH7ZoeXE8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1254
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

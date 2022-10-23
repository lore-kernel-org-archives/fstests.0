Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECE7ECAAA1
	for <linux-fstests@archiver.kernel.org>; Sun, 23 Oct 2022 06:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiJWGpV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 23 Oct 2022 02:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiJWGpU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 23 Oct 2022 02:45:20 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 22 Oct 2022 23:45:18 PDT
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A917A41986
        for <fstests@vger.kernel.org>; Sat, 22 Oct 2022 23:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1666507519; x=1698043519;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GU6MuaWwicpHV17vWq9j+58+yfXojd1E/ak/2qW4VkQ=;
  b=RtoVTkAughs644WtS+dLzzJbN4de5RLcCGtt3XuLfl509acyIYnJewlz
   dZJe4iqXH8TNkcyZsPX2sGJMikNFXA9tC43tBTt1BJXqp1kSV5DM6rCGd
   4gSFxl3Cfillc7jtV0DX/OEfiV0GHW8gz75cR5Oh2+fzjudspQqsdkyr4
   Ik6h/upot4QMhktZ5hWwVDf4a8z0dOF9diNYMfeMh8zmWc2XrGPyg54bq
   ZT7TqnjLItewBm+gqqtwtCRjhOHX8ehi0TzLf4sgdRVbF/WjipDjCZwZt
   d/ktZIbP3uuet7spSDXdN5p9z+2fWlJSIQWFZYNwOAGfTI6wX9yXmuDzm
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="68094130"
X-IronPort-AV: E=Sophos;i="5.95,206,1661785200"; 
   d="scan'208";a="68094130"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 15:44:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIYlReV4DlKG92od3E3E5zh6bF0qaOQaT+/HLXOaKPzC2O1mVx0xPgjOfgdmBGeJkOU5KFhooU2aO77FzrnsI1iPOjU+91EGyEsK8CQxfA5PtL44itx3fB6k/fpEXK4UfW8NftDLqKQvviiEOCC/Gx90/YlKb+QYMaODnQ2snNN1NKyludoSrybzrg82BxvooqNLknbN+2JAgipTZTZWx6VbWuyW5S/rZ9g9yE4I0dZh4+0kPFzwBIjrFOlrhaY2clIOlR1cP44zdQOF1bIhxF6pt+vyMSk/41bezSQjcIvq/SDwZklPQPVGC//FB+/HjQYYT1pY0Z7DdmaoekAo4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GU6MuaWwicpHV17vWq9j+58+yfXojd1E/ak/2qW4VkQ=;
 b=RHl7ZlD04UQN0qaoTsucncgF5tqBOlzD+n+IKx/YzwzWphnb8y0JKrZ7JTlbkVAuTLIUm3o0Nea6ZY+//oj67ktjf12AiUUrfg+wxSMyZiO/9nzuZCKnzzYR5WqhJVr41vNMd2itxYHYukhhOws2Y9Zk6m7+VJzPt9fuj9Ulf41/Ia/2jzFQL1uXBKTawlb6coebMXzFai8eNkbH8loH6hHWlMHQrU7yQctZPKLs/jBhQ/6HWg7bhDJBd9MWisJiUhOF7kAvnkg1972GP8k/vFciASk8fmS5hwAlMdw3JkJ8MDytQ1nMYsUIdHW+RMlVMEkUIt/sNBxW6sApwVSgMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by OS3PR01MB10026.jpnprd01.prod.outlook.com (2603:1096:604:1e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Sun, 23 Oct
 2022 06:44:09 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::339e:88a3:a24c:5f68]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::339e:88a3:a24c:5f68%9]) with mapi id 15.20.5746.021; Sun, 23 Oct 2022
 06:44:08 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     "djwong@kernel.org" <djwong@kernel.org>,
        "zlang@redhat.com" <zlang@redhat.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "bfoster@redhat.com" <bfoster@redhat.com>
Subject: RE: [PATCH 2/3] generic/470: Replace thin volume with blkdiscard -z
Thread-Topic: [PATCH 2/3] generic/470: Replace thin volume with blkdiscard -z
Thread-Index: AQHY5qp5+nA2dI8SXUuLzIktkmfelq4bh8ww
Date:   Sun, 23 Oct 2022 06:44:08 +0000
Message-ID: <OS3PR01MB9499838F4ED131668CB02144832F9@OS3PR01MB9499.jpnprd01.prod.outlook.com>
References: <20221023064122.846926-1-yangx.jy@fujitsu.com>
 <20221023064122.846926-2-yangx.jy@fujitsu.com>
In-Reply-To: <20221023064122.846926-2-yangx.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?gb2312?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?gb2312?B?NTBfQWN0aW9uSWQ9M2QyNDZjN2QtYWZhNy00YWYxLTk5MmEtZWM3MWE0MTQ5?=
 =?gb2312?B?MjRlO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?gb2312?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?gb2312?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?gb2312?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?gb2312?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?gb2312?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRKlWPz87TVNJ?=
 =?gb2312?B?UF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBf?=
 =?gb2312?B?U2V0RGF0ZT0yMDIyLTEwLTIzVDA2OjQyOjA1WjtNU0lQX0xhYmVsX2E3Mjk1?=
 =?gb2312?B?Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEy?=
 =?gb2312?Q?1d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9499:EE_|OS3PR01MB10026:EE_
x-ms-office365-filtering-correlation-id: e2f27a14-bcda-4352-482e-08dab4c1fcc5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MvEqDUp14rFd74Bm8ZFEGEeBJLvnjpL3yfPDhUQwe4KLLQu32pY3iMMXNc2l2ScPz2G+ILlyfjUEYGe5s2ETqJdJLsZus8prFPOfZ9s4bUqzRPj5aC4xQKUQkcK34XkhLJRcyM7w0bxIkWBvUdWk1X8jsP+JNnurg0kNPAZDC4UWafMwv46cTbDAdOGAk9/qeGeN5d+0ZqUWUqPZS/6IfZkY33Pq1mivvl4lRbomXesWc2g6NvBLtqdMc/6AXGcXErPUGUw8w+9js0jM3Nt75yiwfakiS/ieiOH/w3ZYx90vkdvB2moaUdHG+o/hRxHciOwlBIyOsuDh1fEGbIY6D1A6FaFLoNOKNxLlLfV53BzxGeUpA7jDJl28npnfSd6h5DW0puYjmvN8TTM8a1LhsQ5sorOPAzjiiEDs25f++Stej+ZSPrt5DXzUJZv2ThmINzsn1P0OiVzRnxENFGyFhwDmwhn8QoFsER7MFbNu+spKeNt/nw9KUocJowPQU14Ke5zkJ/B69cmx1we+KGr7tv0km/gVPiVd59aPpIA9ER2JU/XXYds9axXQRzq0P5uqkzDE2lo0LOXavbsNw9JCcs/O10iHHbB21m1V2jmFPC3jVWzuM2/RbIVrns7amzmAwHP0DZYkfDPZ9kMIstwqEoFyWWKDzn3V0JlpoeZ95CjeWQLC79l9gVjeJhyKsydL9cWDowF3cNzlXYCqTf/HJ/dIQ5B/nWAlkGoc3nstlsNPt2BFFvuYiPF/lc1CQ59GG4HAaUDYArR1cr5oDdZccVbZ6qBdaFKyrXF0Afx9mNUYppBKHpea+F/PEm93FBv+X9HSDlZCsEMADuDbG2dlL/gqURfhaqgg9yCfvuvoLnqrjKDdaGt//Y4sZPaMxYz1IMBP/wd8RPtB35YclkUW3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199015)(1590799012)(478600001)(122000001)(38070700005)(966005)(1580799009)(71200400001)(54906003)(110136005)(316002)(26005)(8936002)(66556008)(8676002)(5660300002)(64756008)(76116006)(66476007)(66946007)(66446008)(6506007)(4326008)(85182001)(7696005)(53546011)(52536014)(41300700001)(9686003)(2906002)(38100700002)(83380400001)(33656002)(82960400001)(186003)(55016003)(86362001)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Q0s2b09rWUd6dFBUZ1JVeW1ZVlp2KzFaNnV5SUJBOFZDZ3JqTHFjakFXcmI3?=
 =?gb2312?B?c1dReGllb0EycExKd1IvQzNKWFliQXYxb2JoSi9KSVdyd2h4UHhTUDJrU3FI?=
 =?gb2312?B?UFAyZ093ejl5Mldsd3F6b1FDTTVSbkhpb3MyUjhHTkRYOE54ejJoNGh3NkRa?=
 =?gb2312?B?eEl1S05NMmZ4MFk3M050aXlLUExWSldWWk9WdC9WYVFRY2kvY3hvQ3BiTEVL?=
 =?gb2312?B?MkRac1FyQm96d1ZHNy9zTERqc3VQRld1cTBCT1JPdXV6U0tqcnB3RUQ1bmhl?=
 =?gb2312?B?NHdhUG1BOHNRdTU1STZaNGVqOEtDSWlJdXdsTTgzY2syUHYveFJVektjKytX?=
 =?gb2312?B?T2gzKzRNQjZZNFVjUXMvK3FXQVd3b09JejZDSEdoMlRXNFBpWDFFenNTcmZr?=
 =?gb2312?B?S0ZYeHAyLzRmeEhncWdEWHJwVEM5eVovMXJmbnFJd29UNDBRZmlTQmowTWps?=
 =?gb2312?B?eTRid1JCNEZ5c3BNKzlhUXFDdDN1MFpvdFAyYmpSTDI0V2ZiN1FZV2F6S0Jx?=
 =?gb2312?B?QlU4RTNWUC9rTGpMWEczRDBkWDcyaXFGelBNK0F4UCtjRnl0ekRBQ01Rakg3?=
 =?gb2312?B?L0NDQVpQMUd2ekEycFRPTlZCdGQxYSt3bHhnaHEzeWJ2cDlBWGRLUm9FL29V?=
 =?gb2312?B?QTB5MnE2enN2MFdQK1F1eUx3RUNyZll3Vll0MEhVZGRkVkVRSUFuejJPREZQ?=
 =?gb2312?B?bTM3WmU0Y0NzK1dFcWVQWFlsd2ROSU1Ubk80WjlaWXlSdUNpRlVRZllIR0ZZ?=
 =?gb2312?B?TDVUT0UxVFYyckQzSGN4eC83M0F3VEtkYlRCS0dPT3Zjd1dxTmFySmFReTgx?=
 =?gb2312?B?Ti95aUtWYXFOREdFYW5QYnN2elBFRVZhbGJoMkJUaFJVdVpIK0FUMHd5UEgy?=
 =?gb2312?B?Wkk1Z3ZQcVFCdVZ4Z0NIS3FTa3EwMGlzVkJIcVZsZDI2UEljcng4SDJUSXdP?=
 =?gb2312?B?eTlDczBvNHNyU28yL045dGlxUU5Nd2xBVUQxLzFJU1ZZdlEyVmlaUU5tNFpD?=
 =?gb2312?B?dUhPUVlZWXBtWVg2U3pvdWtRNTJxRy9CeEFrZWlzSmVqRUk3dUp1ZGlsSm1i?=
 =?gb2312?B?VlFFVWJBNU1Wc1JSa2ZxSWpySXVwc1hoUndCOVYweTFpTytaQ3h1THdKN05B?=
 =?gb2312?B?TUJSWlFqSEx3ME9wenIwVi9IVCtvMUQ4d0dtSStZSUU1U3ZWR2dGVHV6RXhq?=
 =?gb2312?B?N0FVZUMwcldVZEY4TDd4YklsWHJVOU9iM0FwUXpHdUl2WHN6Ri9zWVN1bnpl?=
 =?gb2312?B?OWpSOEQ5UG5PdTZ3eXd3bFlJYVJyRFFRZWo2ek5tRm9aSldyajQ0aDljYmJz?=
 =?gb2312?B?eDF2ZDdBbkVRU2RsSWJvYUl1RWpCL3NqOVZENmNMcG5YN2EvelE3SUFYOGdC?=
 =?gb2312?B?czdoT0VtNll3MENKRUNUTGErRUcvMW5majZRV0U0ODIrb3pYZmhyT2lBaHhj?=
 =?gb2312?B?cDB2d3NEVnFMb1dNVVBKSmlzR3RlZzdOazhFRTQ1Mng0ZWpHdVcrNmFCazZl?=
 =?gb2312?B?NDNuelB3eDV2R3RCR2p2SEJmcm04aktNbWlWQU90SFl0MHAvcTMvSFVKZjFE?=
 =?gb2312?B?bkltV0tuVUo5Q2ovQVV2WFBMeWZrOUxYbHdrNzZWMFM5aCtqSiswbk1WVHU0?=
 =?gb2312?B?d2F3dFJwNUUxcSszeTlmYVpBZzFEcDl1aGJMMGVGVVQwQkc2WTc2QlhWb3dx?=
 =?gb2312?B?MFNvb1JhaStYNTRyMjJXbWhVOVlNOHZ4dm5wQy9od21XaC81RG9PckwwbFha?=
 =?gb2312?B?OTlxenY4a0s3T0JVYzhVV3lUNEZ0bTg1N1cwVmFtenZFM3VGaUhndU9TZWpW?=
 =?gb2312?B?U3lLeElqVGxZNGRNa1dYM01zU2VTVUpXUFZxT2o5RDYrTGZFaDUwbEtNNEFO?=
 =?gb2312?B?QmFhUUpBR1d2QnVKMmlpblJCWGRVNURaWExla1NabzFOcS9vQ2RNUlZMY0w5?=
 =?gb2312?B?MGlaWU82YXpweFcybit5UnFjaitJQmowRHRXY1ZMM0lFaE04ZjFsby91QnhO?=
 =?gb2312?B?M1ZZWVYvV2ZmMCtkMjhxazIvWmtPK0FnUG95SzU4NzNKTTFzc1hUb0J0WFd4?=
 =?gb2312?B?aTN1VjZ0NUhydjVxNUZxcWloU1YyVFNjKzBhTk81TDNRY1lxMmdEeGVTdG11?=
 =?gb2312?Q?up9kRE29wR5F8yg26kxr+ig9l?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f27a14-bcda-4352-482e-08dab4c1fcc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2022 06:44:08.8196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PBNSYIhA6c82t8TbWKUq/1nqp6CNRblx6yMXn4oP0RRb/mejTw9R+kto7N+V19vt5SF22XImoE1YWPmvM4zjkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10026
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

SGksDQoNClBsZWFzZSBpZ25vcmUgdGhlIHBhdGNoIHNldCBkdWUgdG8gdGhlIHdyb25nIHNlcmlh
bCBudW1iZXIuDQpTb3JyeSwgSSB3aWxsIHJlc2VuZCBpdCBzb29uLg0KDQpCZXN0IFJlZ2FyZHMs
DQpYaWFvIFlhbmcNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFlhbmcsIFhp
YW8v0e4gz/4gPHlhbmd4Lmp5QGZ1aml0c3UuY29tPiANClNlbnQ6IDIwMjLE6jEw1MIyM8jVIDE0
OjQxDQpUbzogZGp3b25nQGtlcm5lbC5vcmc7IHpsYW5nQHJlZGhhdC5jb20NCkNjOiBmc3Rlc3Rz
QHZnZXIua2VybmVsLm9yZzsgYmZvc3RlckByZWRoYXQuY29tOyBZYW5nLCBYaWFvL9HuIM/+IDx5
YW5neC5qeUBmdWppdHN1LmNvbT4NClN1YmplY3Q6IFtQQVRDSCAyLzNdIGdlbmVyaWMvNDcwOiBS
ZXBsYWNlIHRoaW4gdm9sdW1lIHdpdGggYmxrZGlzY2FyZCAteg0KDQpnZW5lcmljLzQ3MCB3YXMg
b3JpZ2luYWwgZGVzaWduZWQgdG8gdmVyaWZ5IG1tYXAoTUFQX1NZTkMpIHdoaWNoIGlzIG9ubHkg
dmFpbGQgdG8gdGhlIERBWCBjYXBhYmxlIGRldmljZShlLmcuIFBNRU0pLiBUaGluIHZvbHVtZVsx
XSB3YXMgaW50cm9kdWNlZCB0byBmaXggdGhlIGluY29uc2lzdGVudCBmaWxlc3lzdGVtIGlzc3Vl
WzJdIGJ1dCBpdCBtYWtlIHRoZSB0ZXN0IGJlY29tZSBub3QgcnVuIGJlY2F1c2UgaXQgZG9lc24n
dCBzdXBwb3J0IERBWC4gQXMgRGFycmljayBtZW50aW9uZWRbM10sIGRpc2NhcmRpbmcgdGhlIGVu
dGlyZSBtYXBwZWQgcmFuZ2Ugb2Ygc2NhcnRjaCBkZXZpY2UgY2FuIGZpeCB0aGUgaXNzdWUgYXMg
d2VsbCwgc28gSSB0cnkgdG8gdXNlIGJsa2Rpc2NhcmQgLXogaW5zdGVhZC4NCg0KWzFdOiBodHRw
czovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vZnMveGZzL3hmc3Rlc3RzLWRldi5naXQvY29tbWl0
Lz9pZD1mYzU4NzBkYTQ4NWFlYzBmOTE5NmEwZjJiZWQzMmY3M2Y2YjJjNjY0DQpbMl06IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2ZzdGVzdHMvMjAxOTAyMjcwNjE1MjkuR0YxNjQzNkBkYXN0YXJk
Lw0KWzNdOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC14ZnMvWTFOUk50VG9RVGpzMERi
ZEBtYWdub2xpYS9ULyNtZTBlNzdjYjBlY2Q4MGJmNGI1MTA5ZTQ0MzNjYjQ4NjNhZTZlNjcyNw0K
DQpTaWduZWQtb2ZmLWJ5OiBYaWFvIFlhbmcgPHlhbmd4Lmp5QGZ1aml0c3UuY29tPg0KLS0tDQog
dGVzdHMvZ2VuZXJpYy80NzAgfCAzMSArKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tDQog
MSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQ0KDQpkaWZm
IC0tZ2l0IGEvdGVzdHMvZ2VuZXJpYy80NzAgYi90ZXN0cy9nZW5lcmljLzQ3MCBpbmRleCBmMzQw
NzUxMS4uZDI4NDZhMzggMTAwNzU1DQotLS0gYS90ZXN0cy9nZW5lcmljLzQ3MA0KKysrIGIvdGVz
dHMvZ2VuZXJpYy80NzANCkBAIC0xNSwzOCArMTUsMjkgQEAgX2NsZWFudXAoKQ0KIHsNCiAJY2Qg
Lw0KIAlfbG9nX3dyaXRlc19jbGVhbnVwDQotCV9kbXRoaW5fY2xlYW51cA0KIAlybSAtZiAkdG1w
LioNCiB9DQogDQogIyBJbXBvcnQgY29tbW9uIGZ1bmN0aW9ucy4NCiAuIC4vY29tbW9uL2ZpbHRl
cg0KLS4gLi9jb21tb24vZG10aGluDQogLiAuL2NvbW1vbi9kbWxvZ3dyaXRlcw0KIA0KICMgcmVh
bCBRQSB0ZXN0IHN0YXJ0cyBoZXJlDQogX3N1cHBvcnRlZF9mcyBnZW5lcmljDQotX3JlcXVpcmVf
c2NyYXRjaF9ub2NoZWNrDQorX3JlcXVpcmVfc2NyYXRjaA0KIF9yZXF1aXJlX25vX2xvZ2Rldg0K
IF9yZXF1aXJlX2xvZ193cml0ZXNfZGF4X21vdW50b3B0ICJkYXgiDQotX3JlcXVpcmVfZG1fdGFy
Z2V0IHRoaW4tcG9vbA0KIF9yZXF1aXJlX3hmc19pb19jb21tYW5kICJtbWFwIiAiLVMiDQogX3Jl
cXVpcmVfeGZzX2lvX2NvbW1hbmQgImxvZ193cml0ZXMiDQorX3JlcXVpcmVfY29tbWFuZCAiJEJM
S0RJU0NBUkRfUFJPRyIgYmxrZGlzY2FyZA0KIA0KLWRldnNpemU9JCgoMTAyNCoxMDI0KjIwMCAv
IDUxMikpICAgICAgICAjIDIwMG0gcGh5cy92aXJ0IHNpemUNCi1jc2l6ZT0kKCgxMDI0KjY0IC8g
NTEyKSkgICAgICAgICAgICAgICAgIyA2NGsgY2x1c3RlciBzaXplDQotbG93c3BhY2U9JCgoMTAy
NCoxMDI0IC8gNTEyKSkgICAgICAgICAgICMgMW0gbG93IHNwYWNlIHRocmVzaG9sZA0KLQ0KLSMg
VXNlIGEgdGhpbiBkZXZpY2UgdG8gcHJvdmlkZSBkZXRlcm1pbmlzdGljIGRpc2NhcmQgYmVoYXZp
b3IuIERpc2NhcmRzIGFyZSB1c2VkIC0jIGJ5IHRoZSBsb2cgcmVwbGF5IHRvb2wgZm9yIGZhc3Qg
emVyb2luZyB0byBwcmV2ZW50IG91dC1vZi1vcmRlciByZXBsYXkgaXNzdWVzLg0KLV9kbXRoaW5f
aW5pdCAkZGV2c2l6ZSAkZGV2c2l6ZSAkY3NpemUgJGxvd3NwYWNlDQorUkFOR0U9JCgoNTEyICog
MTAyNCAqIDEwMjQpKSAjIDUxMiBNaUINCitMRU49JCgoMTAyNCAqIDEwMjQpKSAjIDEgTWlCDQog
DQotX2xvZ193cml0ZXNfaW5pdCAkRE1USElOX1ZPTF9ERVYNCitfbG9nX3dyaXRlc19pbml0ICRT
Q1JBVENIX0RFViAkUkFOR0UNCiBfbG9nX3dyaXRlc19ta2ZzID4+ICRzZXFyZXMuZnVsbCAyPiYx
DQogX2xvZ193cml0ZXNfbW91bnQgLW8gZGF4DQogDQotTEVOPSQoKDEwMjQgKiAxMDI0KSkgIyAx
IE1pQg0KLQ0KICRYRlNfSU9fUFJPRyAtdCAtYyAidHJ1bmNhdGUgJExFTiIgLWMgIm1tYXAgLVMg
MCAkTEVOIiAtYyAibXdyaXRlIDAgJExFTiIgXA0KIAktYyAibG9nX3dyaXRlcyAtZCAkTE9HV1JJ
VEVTX05BTUUgLW0gcHJldW5tYXAiIFwNCiAJLWYgJFNDUkFUQ0hfTU5UL3Rlc3QNCkBAIC01NCwx
NCArNDUsMTYgQEAgJFhGU19JT19QUk9HIC10IC1jICJ0cnVuY2F0ZSAkTEVOIiAtYyAibW1hcCAt
UyAwICRMRU4iIC1jICJtd3JpdGUgMCAkTEVOIiBcICAjIFVubW91bnQgdGhlIHNjcmF0Y2ggZGly
IGFuZCB0ZWFyIGRvd24gdGhlIGxvZyB3cml0ZXMgdGFyZ2V0ICBfbG9nX3dyaXRlc191bm1vdW50
ICBfbG9nX3dyaXRlc19yZW1vdmUgLV9kbXRoaW5fY2hlY2tfZnMNCitfY2hlY2tfc2NyYXRjaF9m
cw0KIA0KLSMgZGVzdHJveSBwcmV2aW91cyBmaWxlc3lzdGVtIHNvIHdlIGNhbiBiZSBzdXJlIG91
ciByZWJ1aWxkIHdvcmtzIC1fbWtmc19kZXYgJERNVEhJTl9WT0xfREVWID4+ICRzZXFyZXMuZnVs
bCAyPiYxDQorIyBEaXNjYXJkIHRoZSBtYXBwZWQgcmFuZ2Ugb2Ygc2NyYXRjaCBkZXZpY2UgYW5k
IGRlc3Ryb3kgcHJldmlvdXMgDQorZmlsZXN5c3RlbSAjIHNvIHdlIGNhbiBiZSBzdXJlIG91ciBy
ZWJ1aWxkIHdvcmtzICRCTEtESVNDQVJEX1BST0cgLWZ6bCANCiskUkFOR0UgJFNDUkFUQ0hfREVW
ID4+ICRzZXFyZXMuZnVsbCAyPiYxIF9zY3JhdGNoX21rZnMgPj4gJHNlcXJlcy5mdWxsIA0KKzI+
JjENCiANCiAjIGNoZWNrIHByZS11bm1hcCBzdGF0ZQ0KLV9sb2dfd3JpdGVzX3JlcGxheV9sb2cg
cHJldW5tYXAgJERNVEhJTl9WT0xfREVWIC1fZG10aGluX21vdW50DQorX2xvZ193cml0ZXNfcmVw
bGF5X2xvZyBwcmV1bm1hcCAkU0NSQVRDSF9ERVYgX3NjcmF0Y2hfbW91bnQNCiANCiAjIFdlIHNo
b3VsZCBzZWUgJFNDUkFUQ0hfTU5UL3Rlc3QgYXMgaGF2aW5nIDEgTWlCIGluIGJsb2NrIGFsbG9j
YXRpb25zICBkdSAtc2ggJFNDUkFUQ0hfTU5UL3Rlc3QgfCBfZmlsdGVyX3NjcmF0Y2ggfCBfZmls
dGVyX3NwYWNlcw0KLS0NCjIuMzQuMQ0K

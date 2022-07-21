Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B301CC43334
	for <linux-fstests@archiver.kernel.org>; Thu, 21 Jul 2022 15:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiGUPOr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 21 Jul 2022 11:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiGUPOq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 21 Jul 2022 11:14:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B205C7D7BC
        for <fstests@vger.kernel.org>; Thu, 21 Jul 2022 08:14:45 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LEEhmw001723;
        Thu, 21 Jul 2022 15:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=aa7wmHv3MGV33hxF8DbHtGsxGpjou/xhb+BmmKciXtY=;
 b=TbgjdO6eRG1n3CGuvO+YZoIUdMdB/BVkBBIWwLQ2+CATNcAjZ6sVabP8o4ed/G2pBXNI
 z88Yn9N6SFs+hiF8+YOIaNKJhulArZsb6nKiJVMSLQ0KXQVHFmvoRMVLeDyrQAGvhyup
 hDy1Gi2oZCYq0CO7RVn4OVwiglU0tmE3830JsRZbhBxCNoI7RP4mrtGqES78allJ++yS
 YYbfwhp8jEjRrW5OpDd40NLPRt8KTgOGJwBgb25Geqk3kP0y/uEUv5tBkQSC8Q/8/MSr
 8JYVH9T51MB2ZIZ63nAcK6hPn4bsHb/yuOZv4JXe19MdJbyhJT9LZ2vIm+3HbMeSyrgN 3Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkrccgs0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 15:14:33 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26LF1Bau002810;
        Thu, 21 Jul 2022 15:14:32 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1md5qnk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 15:14:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFSzQWdQQN3lDrL17e81HRLheJA+WQcI0WrqjMgIfHqAJMkonLE9uaAyizcitfy86BEyX7uVCEl912cwkvN29l+79pt0nA+AZilkA1r5R8xDJP5aEwZ643SbGregwSzTu5kBZ0TFuIi+BKIA18S4zKUOx0FGqEPOTXer3w1VPzBYDfHcJTHu7LwrdKPZRbGXEJA+mFyP/fe5Wo+gjnrtA2GnEz4IG6ZdY2203/xmi9bccuFSsaeoP24E2F0L1n/MlpR6dKMgUTuIIRgmNxEPhNUsw0ydgHi1UQBURHEu+PABTqQWpGuN+uo3q46Z6rFq+weqRqm+/EFP0o49JaS1fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aa7wmHv3MGV33hxF8DbHtGsxGpjou/xhb+BmmKciXtY=;
 b=GfBYAmicuW7CXWN85cwRHs2+G4X6x5POKcP8kYHLT6bxAfAhSdHB/zI3YRw8mD1+8HSGW1x0uz2IcktGgeRSSMQ5fMErcccf4+jSVm821fo4I1BLGyNmEJeJ67OSuMW8HbmOwEPAnNCT5d2SQMjAoQtZxh6boPdZ9+Tx48SXUXq9up9qEXbyQeA/pw68vfXItbaWZkGrNlyFv4UMMRBf2bMqxvxja+w3xnSxnio2VyL2kpSp6aTE6vB3Bt428/HVBWpixAidfACc3zCd3MSdkfdqGW/dIvTIbw/E/SpTESa4E0OM6fTld2MqfOL5Hl1N7BRxeLjsB8IxUvyjQ4w7qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aa7wmHv3MGV33hxF8DbHtGsxGpjou/xhb+BmmKciXtY=;
 b=TDy4hE+kV/i7r1Al/2hcV47Wayf29Y3/8ZX5/mRBskcIo42kiyFbNERPz+YookbccVxkqIscz5cdDY6w72BsDJnOaB6t7thSowWumRtbnep0R5UwN+siZjaUy7VtANTYX7rpie0VkzmvD/z7ENieKXDsD+ZLaidCi10U+Rz017A=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4070.namprd10.prod.outlook.com (2603:10b6:610:11::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Thu, 21 Jul
 2022 15:14:30 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%8]) with mapi id 15.20.5458.019; Thu, 21 Jul 2022
 15:14:30 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Theodore Ts'o <tytso@mit.edu>
CC:     Boyang Xue <bxue@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH v1] generic/476: requires 27GB scratch size
Thread-Topic: [PATCH v1] generic/476: requires 27GB scratch size
Thread-Index: AQHYnKnap4azL2QFlUaB+D1uchrXbK2IPrmAgAAuOYCAAEe5gIAAJ2OAgAATLgCAAACVgA==
Date:   Thu, 21 Jul 2022 15:14:30 +0000
Message-ID: <6C27EF62-B619-4451-9CBC-B21CEC72F66D@oracle.com>
References: <20220721022959.4189726-1-bxue@redhat.com>
 <YtjYxyhVmSPzzFoH@magnolia>
 <CAHLe9YaAVyBmmM8T27dudvoeAxbJ_JMQmkz7tdM1ZLnpeQW4UQ@mail.gmail.com>
 <Ytk7t0am8H4x2BbS@mit.edu> <YtlcwZ/66pJhpdiS@mit.edu>
 <E5C39D1E-3DB4-467A-8C6D-6630A2ADE97E@oracle.com>
In-Reply-To: <E5C39D1E-3DB4-467A-8C6D-6630A2ADE97E@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f5b5839-1c2d-40a3-0956-08da6b2bb5ce
x-ms-traffictypediagnostic: CH2PR10MB4070:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GMNr7FwNWAzrNqW4iWCRCtHXUnEIIzOAlTDV1VH3+gtKEaFFtaRTQCTSWDtrkxJzz4yTg3ABoMRjRWQ4Q4A3jZkQoLpaW34/5n7E+XAeBPjjHWy5/vNdQZatfH7Vairo/DRVp66SmUZcZQRij0j+NrUhiKNOz+bQEA1DqfK60m3hEm7ii7U3w587yDOOJ6JNGgxlSs9SKXiCQ50smhdyEMkFMKyhXbqULoG4yQvZ834zUnQo08ZF6QUkTp5bXzXmaZuxd9knEG+2pboR182r3vqHcM4RKZNbudXvAzj0DkCjmE4PmE6gPel3IuLGQIkXMkswgAEPVeQmQ8P/j9epcfmjZPEfYw+OeWadvX1iY10FfPRGJpQIz+VaBDeJa1CPBtsiUgwb0ItRT3Pa2xK4btXjp59afjSm1nEJkm7aD54jVGvw2NQX+Fe/n3xdSsn9PqMu+XnvrN35yQDfsnqD0U0HNHeVhMeYX8mxtpfuXL3XMepO45BnPc5Xw5lXLbGuZXoi8eRnrDOPEPmOf2wFPrgqeBhiO8H3t6ue2elcyVfM4tvVaz+9I2kdcucRVkeCy8dBNhHDFgfxgKjqY7FPHBNsdJKP/Dk68uncRnA22siN+6VmwtG8sHu+PF60iM2qVKCxb/VGeWQnzGPLHOo63p6vipinVnFIp//2fN3A3Cz6DkNeeMKEx3gCbR7X4yTaXLc7yVSlaN2y22ptv9LEcYYUJUzutDNNxUGiscMkRrgyH2Yv0/6eYuP+yLQQ89WO+BL7lWd0vYD7XsFWnkKxogqmdmBeypEHxQdFdEQRT0iFOiewcZzzLVBHlvScmzy1wHYc4KO6Fk7DP2FOXGS96y4r4VPm6jHcxnAVp8bLgS0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(346002)(396003)(39860400002)(376002)(6486002)(6512007)(316002)(38070700005)(76116006)(478600001)(66446008)(2616005)(122000001)(86362001)(41300700001)(26005)(71200400001)(6916009)(91956017)(54906003)(83380400001)(53546011)(186003)(36756003)(6506007)(4326008)(5660300002)(8936002)(66946007)(8676002)(64756008)(33656002)(38100700002)(66476007)(66556008)(2906002)(41533002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NJga3evZb/fEsVM1FlM8+p2F2kFzddYew1ia9T+ulOzi982t2eOoyBOJzbSX?=
 =?us-ascii?Q?Lm2ctz9GnzpZdW7Fc9U+EDYFYEZW+Vy7u/lTYvhhpYZMNul+8P9KeS13mOZk?=
 =?us-ascii?Q?2TmnQJRZ2A6k7sKcheGGGhQmi1rBcE48sG9R/n8z0qi6E7fEQ/t6JK7Ll6xW?=
 =?us-ascii?Q?vmLiP4TqIZFSfHCkkxXLvloxEAJkh/oq7oaYEobgvQiQcbZuEN2RqH71raxv?=
 =?us-ascii?Q?B68NLUii8/B/lt7bhK18XA1junoRedkuBbnnt41GfT2A6r4KdJiVzaP5Cm8q?=
 =?us-ascii?Q?gUOp0R4PyETdmWsdGfI4QFHWintgt6s6VRWPT5nCTjpPBcRcuxfynUdWtXdf?=
 =?us-ascii?Q?acjk1yNY3+mquyXyZVB6p75WPOmRSyg5SZQK/clKGhkjwzHPxrS1p9o7RJyp?=
 =?us-ascii?Q?a7KyegEGQYnuBFOQVYWrOBw/OJcYL2sCguI/r8ZkvuLbZRiGDkgQnS9LngXQ?=
 =?us-ascii?Q?uZ8ZFB0NHBQgReNSNVvusPuNCjoH+CO0hFzD4J0Pn/hEMYctDb4BsZPQJ9j/?=
 =?us-ascii?Q?Nsxk6lxh0sfEt4KZ909wwCvDXePUBi4Vrz59PC55jxcumfsXiT+c8DSyJjaW?=
 =?us-ascii?Q?j/p9mIX5Pw0wQ7ISbMaXuG3FnHwelVcsotgjsTUy/kjVmVtUCGCSR4fNNSSU?=
 =?us-ascii?Q?Yv146O6vi2ko2Zov1QD3rbptyQtLJ6I7YAo956LzO3lD7rXN+rhvWpChOGEF?=
 =?us-ascii?Q?UuBqpGlvsMFko1ocEEkg9tJdvdKgGqBe7XrFTCMLj/FCRijM/wSuImGqqggO?=
 =?us-ascii?Q?hpz7hv6lL5Hszg85deNiDHhS5H+cUG73+TzB1fwLAhHQpyH22rGhgnhpWVcm?=
 =?us-ascii?Q?wh+0ulysSJd+AQXroqlV5oUXKfmBPYNSicTPzhsdLnVrBjYyHXGPU6cDyZJa?=
 =?us-ascii?Q?fMtnskLObfQTJpKGvNbMqAP+coSPJca8zDeMF/7kKsQfvYQan3kRnTaxK1De?=
 =?us-ascii?Q?nemuEWYwspC3QoaF3NVCY8CijEDGswtcADVyriV95WX1utXWg+184lT2arAW?=
 =?us-ascii?Q?SxJ3LKVsTbxvWLDBQy+zORt549oMU9nPSmjOLbe8Mw28zLfYOx6cU7ZgZAq9?=
 =?us-ascii?Q?NynU2UfJNFZ7Dhr3a5S1LYhwSgXDhtM8dmJmzkHFBl5HoY2Cr5ICYT/bntHR?=
 =?us-ascii?Q?BR0jQ0aWCEwYRRzx6V44Y8tQQ5+9nLKF5ycJo8Yk9ANevqhsflyOAXJ05GNK?=
 =?us-ascii?Q?25HpsBWhdjQFaBb07/UJp09jmDH8abJrCR31e88XvoyHoqV6UuANu/Y6xQpr?=
 =?us-ascii?Q?IlrliJ+aGst85puf4sRvvyl1aQME4fM+sFodWDCbvsaJ+PoRUshcKw2MU7Ug?=
 =?us-ascii?Q?HTs1+FaDNakSB8pDB0YXMKXW8t2mJ7O8ZNQRJ8PA8m/g3qImKBDCu6Rr3FIS?=
 =?us-ascii?Q?h22jcjTP1ij+o8tqc9pxcrksn041ixMMXE/8wIjxhYFhNkDNelbX1PFf2V33?=
 =?us-ascii?Q?C4xLWQe8LYIY9HAV121btRu7DicKwsdyuUp0B8vfJ9A7oLz+gRd6N8bEURSB?=
 =?us-ascii?Q?myLptwSeVu+k2G+pGJy85VMT8r9i36AX9k3GmOKSe4VVEZpFh4f5rvIZXglr?=
 =?us-ascii?Q?OX6QWh9QXFXnmT7Xk6Nj8RMvCieZVBf9bG1R2XDmLDVl/gYsLvc5YZeYy18D?=
 =?us-ascii?Q?aQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5BFEE8AA9F65DC448EB46967255F80FA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f5b5839-1c2d-40a3-0956-08da6b2bb5ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 15:14:30.3822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uU25/mQ3nJH+QCTstrANkmukYvu5TGuxHUWk5Od4o7WsUzRhvY2o2gyS/fue1Iic1PIRCk/WD7XmN7p8txo/uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4070
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_18,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207210061
X-Proofpoint-GUID: 6K_1Oa_ygFa3RdAoWe-TyQXnbpxmv5_n
X-Proofpoint-ORIG-GUID: 6K_1Oa_ygFa3RdAoWe-TyQXnbpxmv5_n
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



> On Jul 21, 2022, at 11:12 AM, Chuck Lever III <chuck.lever@oracle.com> wr=
ote:
>=20
>=20
>=20
>> On Jul 21, 2022, at 10:03 AM, Theodore Ts'o <tytso@mit.edu> wrote:
>>=20
>> Following up, using NFS loopback with a 5GB scratch device on a Google
>> Compute Engine VM, generic/476 passes using a 4.14 LTS, 4.19 LTS, and
>> 5.4 LTS kernel.  So this looks like it's a regression which is in 5.10
>> LTS and newer kernels, and so instead of patching it out of the test,
>> I think the right thing to do is to add it to a kernel
>> version-specific exclude file and then filing a bug with the NFS
>> folks.
>=20
> Quite apart from the question of whether to exclude that test
> rather than troubleshoot, I would like to state that testing NFS
> in loopback, while possibly convenient for Q/A, is pretty fraught.
>=20
> - Loopback means the client and server are part of the direct
> reclaim path on the same system, which makes livelock or deadlock
> much more likely. Given that these test systems are typically
> small, that pushes the stack even further into this territory.
>=20
> - Loopback means there's often no way to know which part of
> the stack (client or server) is the problem.

And by the way, it's even worse if that single system acts as
both the NFS server scratch device and the server under test.


> Any NFS test needs to have no less than two test systems,
> otherwise what you're really testing is how the system handles
> memory exhaustion. An important test, no doubt, but it doesn't
> paint a full picture.
>=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20

--
Chuck Lever




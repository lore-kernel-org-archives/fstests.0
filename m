Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06189C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 21 Jul 2022 15:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiGUPeA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 21 Jul 2022 11:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbiGUPdp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 21 Jul 2022 11:33:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573478876F
        for <fstests@vger.kernel.org>; Thu, 21 Jul 2022 08:32:55 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LDjAHm028363;
        Thu, 21 Jul 2022 15:32:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=hJ6fuFkl0hE4Pkgeg7ubjRPuI/mKbzzS1aAFZu/iFg4=;
 b=c52Xoe1nSED3luqfjzsAOrcnGV+AscD1ibvksCX5GbIky+1jUEMeV4PyM2eVL3VOdN2a
 78Sc9M1uRtZt3VbUA78cZpmU2At7JzuBOgxLzIGvkxkptRjLJTZ6YKv1aAIQsRvgtwW/
 MpIhNl/S5S4qgDBeymHVKspS3cwEfXP2UZIXoW5mUBrHNDNR3SML1U1Dz01/NmUlkXQI
 Z11GoyE3JDf+XQt1TdnR8mwEIiycnoCuABLLK4WON0ON1Fx4LgkfsR/8KwWJKJY53+9W
 5pvPZvKbcnZfuKS1KPCsq2jSilC9U+HkBFhDZNiIgn7I0feDakAIA1Ef2ilBFxkm9b1g 5g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbm42mx1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 15:32:52 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26LEjk6Y010046;
        Thu, 21 Jul 2022 15:32:51 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1gjhhkr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 15:32:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hicjBa0DflPQ3DAfK+i2ilcqHkG2v9AX4VQi/JBcVa7sEZ4GPAPrrZ2SLCDMRT/UXZpm9F+JkmBqf/WM4lsUpvaU35LsrWv/1KqXRY6EcVtjTg/xWbEz9liWswAPabdiSm1d7BTIiuaPx5V4Jt2cjQReZBTq96DMfAlGv9jRS0W+ELHOnLqa0lWGApwGpMf3OuugXz1Xnhi3Li5epXCcY0cgI+5kNPjnn7I5ssyc8L4lLklAz6W/OlAfH2nimeoZtCAIXyxbM5SWXx9cTqYeFEHAAmOLlDbHzbIo1EP664bOx1ucLJuoxIgBkbUP4rEtO0cP1hID/Xr57TRjyhiR7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJ6fuFkl0hE4Pkgeg7ubjRPuI/mKbzzS1aAFZu/iFg4=;
 b=EcRH7OzsXvudB2ZKaHdZ7b0kvul3AvdSI0AZUGfTOjFU9mVKI5JDS138REGQ5t5rKUCnM2/1eMz0LN6q5u70BHJJkW9CwBCB8FFLDeuM1uO5eZuPJKkA+XFnvD6StCz+MHRzIm2SXVxu9uN7K5hC7BU0Dr+tNq+gPGEciZ/ovmBgEOF+yqkehm6o8ZbsLGSSz/8Keny0pMI0kIpKv90Q/pyZ0MCIl1nWWGJL2YUfuoIZ1HOVDrQaw6lk1IJsc4WmHQd8jDyywagtm1pcxL9iRSRYw0nlj6XOAl3I7UOEAEv9BN4Yw7XeTkIhNUp3KqnzHlWxk7qLQD4admWm703w8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJ6fuFkl0hE4Pkgeg7ubjRPuI/mKbzzS1aAFZu/iFg4=;
 b=mmSn0y9JZ9rzknb5w4oQdZut2kfedJkBNhSiKFF1UsBjcPYbIaGEssJDpLVe7pxavYAoJIjQfoFYr6qsILXwAzjeTTAyibAJJDJmVaPC1nJi4GkIaXUb3OlhFU/qiLttSMqpj9HYyM6N8tcgusSAN2E5EayFiTl3BzT2xtXBL1o=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6060.namprd10.prod.outlook.com (2603:10b6:510:1fc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Thu, 21 Jul
 2022 15:32:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%8]) with mapi id 15.20.5458.019; Thu, 21 Jul 2022
 15:32:49 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Zorro Lang <zlang@redhat.com>, Boyang Xue <bxue@redhat.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH v1] generic/476: requires 27GB scratch size
Thread-Topic: [PATCH v1] generic/476: requires 27GB scratch size
Thread-Index: AQHYnKnap4azL2QFlUaB+D1uchrXbK2I8+qAgAABBQA=
Date:   Thu, 21 Jul 2022 15:32:49 +0000
Message-ID: <C3EC5E8E-C230-4720-BFCF-6497E088EF01@oracle.com>
References: <20220721022959.4189726-1-bxue@redhat.com>
 <20220721152909.otn3spgou5inzhoo@zlang-mailbox>
In-Reply-To: <20220721152909.otn3spgou5inzhoo@zlang-mailbox>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9a990c5-99d9-4aac-7762-08da6b2e44e8
x-ms-traffictypediagnostic: PH7PR10MB6060:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bn20OQQg59nw09Uw/B57Xws/QhO+4uKsreIoae8MxqCkbzLRit0GQX6SIh8EXOASavLf32yJgkzw/Vw0LEYIxfycHRtrQPdts0e4JoS+RdNZWWKwXTAKwOzIu52taBFYTKL12ayOfJm79/tka4uJeS/mKx0aNcnIYSPikKibo3h99W05PFr9siDPnIfMZw2M49MulG3kt5JwMO+o+RmFFZ9+4qOnKDTa9IOayp3yhAgdwWn+x5N752MWfvmNYhZbdHE/Rt8QGuA5JKYtKoH2CZbU8f76/7gNLulpAeglrlOkbdS0/TKiMq6YCcHO/uIivzUrvUeV56JIzI4PZfPffEzrn78YMUBOwmszdEKFGlmvlPmBkWdRvWwWQfItp/ij/siS/ca/ZEK8nOol5H7fMXLie8lL/+2XSyqsDdp0XiB5FPnUkchwbpKl5wnf+TiOO4gItn+JY9e9bOZGCyuETDjPWJH1HPXKXU70yztaXi1vKMJ+9/O6E4B3ZgpRCRpiI6Sp/GtQ70UclRKyZIQ969FQSt9zpeVyCOQI2EV2AiqMQNrGSduV7d1DNeD5TZjsqgiWM9GJvd8TPSJUMZcTIa08DNPlpAwDHj2WYlJHD72/FTg/JCpdCDCxBC5HXaaMNGBViBbI8bQ1WZLSExniyYl5GmcjE9JLo05a3ZE3vjAV9Hp/fHpZi2YR4syX6FeJKRg9L16AOZybSbX8QNFSpuHL5b/1ITS7g/RtoapxYIiP3DcjcMf8DuW/QRPphwoIfjZiQWERPEU+ZhzA9dZwxsZORfKW9jIetGtIOOPQKPuDQxZO0Ef97bBL9yI1X+w4lA11iYbWKpMmybXcJg0YWQbXDrroHL4TPYpu+LgAZYM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(366004)(376002)(136003)(346002)(76116006)(53546011)(26005)(66556008)(186003)(2616005)(66946007)(33656002)(6512007)(66476007)(4326008)(91956017)(66446008)(64756008)(6506007)(478600001)(8676002)(6486002)(71200400001)(110136005)(38070700005)(38100700002)(2906002)(316002)(41300700001)(8936002)(122000001)(86362001)(36756003)(5660300002)(41533002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8bIp+9gotnr6/QqMuLSKkiAw3wkcdzJpJF+BLNntdfgtS/r4bz+nxKcMhgE/?=
 =?us-ascii?Q?/busCTBXEVpBWCuLUDSMgfbnlK+u1O1qxBJZeFgdu0j79RFASwaW+ajy4lu0?=
 =?us-ascii?Q?DkxyNULwXjzgUvKfVtUvthOFnoca5wb24ke7ORd9QKq4Q8fEKyIQ8D4axKU/?=
 =?us-ascii?Q?VbiEc0i7Lr/G6YN6yeAi3cDfAZ5DFadXbZ7uWD6cZ+ixKGEc1knJdiFjweZT?=
 =?us-ascii?Q?pRjMmHGL6EeSSQieKmgZI8LTQaMDI9CxSaiF5GNsn75bYoS36Hif/pxS5oWV?=
 =?us-ascii?Q?40/vIV02E9ACBvmBM+Zhf0V5yW0xrKeGqSEK7WCMrHPSrzVYfV9bnktlhTcB?=
 =?us-ascii?Q?9bfsXz878MTf1y+hXa7ZVywZbvJzzF6FQkHLCntuBRc/Aj80OFQmNBk3WUbw?=
 =?us-ascii?Q?YrWk8qr46kqHb3o2Lsndf9ai0hEyJExdtOkPml2KgfnNDJ58fHN/9aAhhvNC?=
 =?us-ascii?Q?XYXFoum5fvHYeTiQrQa/Sj4hTgVibgpgmwNWbx2hWZiR13A/KrbBywle4piy?=
 =?us-ascii?Q?BpoIr/9YlIq9Dd4ZVDRZ7a43CD64iLneeeozJTV4ZW97CgZIrZCufl1I2hWq?=
 =?us-ascii?Q?vryCn17dKbVuLTQjWeVmK92bUVdOFuRwNp+7m6kyLXJAZkTHj5EvKYpxzWX6?=
 =?us-ascii?Q?hyKlo78XS+egHK8mHwPTFkm0gtzz8HUUi/+6z28Y810mEbTd8MsaZFB5zWgr?=
 =?us-ascii?Q?ejGRNT6BiVwaSuOWN5nFvuobSEbfLEZgbIOoH2hMxV328KCm0vnqBWDkl6rj?=
 =?us-ascii?Q?A6O0OJfEGHg2yzbAxn4soVaPC+W6MCdhRvrNtjVD7swBL+lfXie5sRn86CS0?=
 =?us-ascii?Q?79t6r6rEcYsB1zHH+THLjj78A096rnAegTXT9XiLjGD9Gyfp2wfwQkmWv/Ug?=
 =?us-ascii?Q?ja50dV+D+gz9LiB3BQjogxSi5wZzzX4KktvVWV6rAxdA0QyjWd6NNx9gfmdr?=
 =?us-ascii?Q?yGaRf4MmW2ZK+/hlwPjKzphHMZ3sDcHNHzQ6PMa6VOs3iYLix7vmTuCagwSg?=
 =?us-ascii?Q?dCFDQLpq2KaJ1an0Z2ciKMnoT/j0oibRrl/ozyLC16YETka3MOPZyGK72iW4?=
 =?us-ascii?Q?gZvzTfqxocxhkS3p0SlZVRIYgDZLFqpN18acsbnzNUY9vikMJmmL8qXRJ6En?=
 =?us-ascii?Q?qDRurfJgnqd2MnfK/YQ3TySbYjveCuea/1wtZ0q+SNY2VEj+NOF2ksXkTc6w?=
 =?us-ascii?Q?rJfKFpKU3+qmEe0Je/pDghbFTD9xTweNEqBmt0bXjk2+eMdY1EHCKawPp0ZQ?=
 =?us-ascii?Q?EhKj3HMERdy7BiX6Eoen+WdQOQ8ieIrKhgrTlQCn42E7evON+jPsdLwVYuCI?=
 =?us-ascii?Q?g/BRi3uGCme3LzkLJ5WwYBIhkHRtByqm5iL9pidlUaLe7uDfv3FCOpDaG//T?=
 =?us-ascii?Q?o7UKWksvN/YkxCJuTcxFokgx+qrRrIVS9wHVrbaw2/IkkW0LNwJxmVVudVbM?=
 =?us-ascii?Q?wl7ENmXy28MHBPJvzLSX1+9Q7ahWmy1Wwjdis5NSMnGbQyZGoOAxlte1VuJ4?=
 =?us-ascii?Q?nClfGtBYZ8MtpvtAUhOB58fY6p5xcOCf6SF35bCuEF6X6miHnJnLAoLBvlnQ?=
 =?us-ascii?Q?SFtxPoJrn3q2rd8hqXOtIxAZexb2qwFria/JN9KhPPeG3ll5y6Iv/7HHAxsY?=
 =?us-ascii?Q?ZQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1111487E542CB54B86FCF2D977743C7F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a990c5-99d9-4aac-7762-08da6b2e44e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 15:32:49.4631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: htI2qpkNctHVVPyPzVQ+6qZ49EfLcLfsEZYMZbqa0Bi1ZrPvjWozoPr8qDBCSz4lRyPwvPOP4ER3yY+6cqq8JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6060
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_18,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207210061
X-Proofpoint-ORIG-GUID: yxQGsYpTTI_imJW0WXECgUKBML8ssqet
X-Proofpoint-GUID: yxQGsYpTTI_imJW0WXECgUKBML8ssqet
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



> On Jul 21, 2022, at 11:29 AM, Zorro Lang <zlang@redhat.com> wrote:
>=20
> On Thu, Jul 21, 2022 at 10:29:59AM +0800, bxue@redhat.com wrote:
>> From: Boyang Xue <bxue@redhat.com>
>>=20
>> The test requires larger scratch dev size when running on top of NFS oth=
er
>> than ext4 and xfs. It requires at least 27GB in my test. Without this
>> requirement, the test run never finishes on NFS, leaving 100% scratch di=
sk
>> space use.
>>=20
>> Signed-off-by: Boyang Xue <bxue@redhat.com>
>> ---
>> Hi,
>>=20
>> I find generic/476 easily goes into an infinite run on top of NFS. When =
it
>> happens, the common pattern is 100% disk space use of SCRATCH_MNT, and
>> `nfsiostat` shows 50% write error on SCRATCH_MNT. When I run it with a l=
arge
>> enough SCRATCH_MNT, the problem disappears. So I post this patch to add =
the size
>> requirement.
>>=20
>> Please help review this patch. Thanks!
>>=20
>> -Boyang
>>=20
>> tests/generic/476 | 1 +
>> 1 file changed, 1 insertion(+)
>>=20
>> diff --git a/tests/generic/476 b/tests/generic/476
>> index 212373d1..dcc7c3da 100755
>> --- a/tests/generic/476
>> +++ b/tests/generic/476
>> @@ -24,6 +24,7 @@ _cleanup()
>> _supported_fs generic
>>=20
>> _require_scratch
>> +_require_scratch_size $((27 * 1024 * 1024)) # 27GB
>=20
> At first, most of other filesystems don't need this requirement, that wil=
l
> reduce test coverage of other fs suddently. Second, there's not a clear
> reason to prove NFS (or others) need a 27+GB device to run this test. Due=
 to
> the generic/476 does nothing special, except random I/Os, even running wi=
th
> ENOSPC...
>=20
> So one difference of running with small device or large enough device is =
the
> chance to run with ENOSPC. I think the device size isn't the root cause o=
f
> nfs hang you hit, I doubt if it's a NFS bug with ENOSPC, or something els=
e
> bug which is triggered by someone random I/O operation.
>=20
> We'd better not to skip a known generic test (from upstream fstests direc=
tly)
> if without a clear reason. That might cause we miss bugs or test coverage=
,
> better to make sure if it's a real bug at first. Then think about if we n=
eed
> to improve the case or fix a bug.

+1

I can help troubleshoot the NFS-related aspects of this further, if needed.


> Thanks,
> Zorro
>=20
>> _require_command "$KILLALL_PROG" "killall"
>>=20
>> echo "Silence is golden."
>> --=20
>> 2.27.0
>>=20
>=20

--
Chuck Lever




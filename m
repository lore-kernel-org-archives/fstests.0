Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811F2C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 23 Jun 2022 14:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiFWONk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 23 Jun 2022 10:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiFWONk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 23 Jun 2022 10:13:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B815114E
        for <fstests@vger.kernel.org>; Thu, 23 Jun 2022 07:13:35 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25NBCqS7027237;
        Thu, 23 Jun 2022 14:13:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=hzXTli3Ptlzra4aUQOa9WnMwBhCYsoJxnen6JmI2FSc=;
 b=gtL6d0wKIH2RhuJwTUNXyDhHWDnYpxaDkvHqd4oPkamfVc/6FvquQHM18acSng0gpmJg
 Ll8GZkLVU/K/wWyxMlcn2gvSAuUV/g8HhASVTkZUwUH+tgrrruk6IjwKyyWumRui1ui6
 KvuJTpqNZqlgIx9qVWQmZASftVOMN2fwVReHRzhHyKRax+cztzqGA44RGTM7vRfEfxf4
 E0COhG7m+E7Ni3YhFJQhY4oeQceVjv/u6bVax9JLU75yVQ2y80WZLXVes/OuXMgwyQ4w
 luDrq+/A6CBj6fQKRz4A/vccN4f9Oy9WiO4Kg6nTrT6V3+KeeDZzUW+ELCGK4XG88Gyz uw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6kfb284-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jun 2022 14:13:30 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25NE6GIZ008668;
        Thu, 23 Jun 2022 14:13:29 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtkfwp7tq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jun 2022 14:13:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WycGGBBbW2nvIgxWuDzIOOLx+KL6WdhvPYseIfcV+RzKcnBjkeQgUstyyIjS88OwjYPYuyHjKbS4zwB4C6Z7jzr02WqWF8JZCnAc8Ccb63S2vLTh6K87idWkHV63aLMXzjSyc82rLTPRCLCAHMO6KHm2cNpWcuZn2m1bJS2VObEUHK9j/yHlC43uUi84S1l0W15HykSUIFF34wAdJGA27I0TZqKZwwcJIdwe++MpFxnWDoHcXMYvD4GvV8O4MVjBhY6Xtw4E+Ip6/1G8VVVMRUEhLG/WuI1/AJs9c9PivId50Ri+BfmzciaSUhXl/gz/9Oog5p0S8taIlp5/NxP4Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzXTli3Ptlzra4aUQOa9WnMwBhCYsoJxnen6JmI2FSc=;
 b=TgOmXLXmskJk/LR3djXPlZcUOyrfU0C0FhPiL6ScQYgAYJQaToQBoxPzy0xhvsRsZACFGg0O4oOiYCYntqHMZ4AZ1dbgCB9+sSAwjUYmqKeg1t+Yw9PqJPNq1g2I1bgbIfk7WJ2qd/EL6TxLtQeMiXCXFIL4oZXT4YlQnQ3hBN+nfRiGPGBzgtoIxgZAmbZ85XkzgUlbTgyg8uzKeXvers2d4njz2Op48XrDxV60vqJk2ACTADeoBjtyaqq+B9N7KzYCZqY5nPcN8xDuiMe4BQVu2MDZwL3c4U5Ng9b71N+kAvuOgtG2WS/xuGcHjXKstUhm4pG2qIGZ2WjNVMjUUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzXTli3Ptlzra4aUQOa9WnMwBhCYsoJxnen6JmI2FSc=;
 b=OOCytzIWO1oTOCzqHRZxvBKA3JGyLdtccPB1if1aSAaKFSGSPpR7Na6Z5aNGQ9aDknMRYLWADDaUTedNffsalgaZ2T5iR+wxHrqpYeHaoxZ+9hPB7Syksm4Vhy+tF5cSUeh7ZLbEUeMlSVHjkT6iIKrNrwyNit49iFPH/kvBZNk=
Received: from SA2PR10MB4587.namprd10.prod.outlook.com (2603:10b6:806:114::12)
 by DS7PR10MB5928.namprd10.prod.outlook.com (2603:10b6:8:84::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Thu, 23 Jun
 2022 14:13:26 +0000
Received: from SA2PR10MB4587.namprd10.prod.outlook.com
 ([fe80::40f8:b9ca:accb:8970]) by SA2PR10MB4587.namprd10.prod.outlook.com
 ([fe80::40f8:b9ca:accb:8970%2]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 14:13:26 +0000
References: <20220611111037.433134-1-chandan.babu@oracle.com>
 <YrNLGKchdYqshW4o@magnolia>
 <20220623002319.64pqbbpf6ejumcoe@zlang-mailbox>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Chandan Babu R <chandan.babu@oracle.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH V3 0/4] Large extent counters tests
Date:   Thu, 23 Jun 2022 19:42:15 +0530
In-reply-to: <20220623002319.64pqbbpf6ejumcoe@zlang-mailbox>
Message-ID: <874k0b1n9e.fsf@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0113.apcprd02.prod.outlook.com
 (2603:1096:4:92::29) To SA2PR10MB4587.namprd10.prod.outlook.com
 (2603:10b6:806:114::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13e3712f-3434-4bd4-3efd-08da55228a48
X-MS-TrafficTypeDiagnostic: DS7PR10MB5928:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB5928A823E1C1C59BACE2B30BF6B59@DS7PR10MB5928.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BVfS0tQ7sPYYeuxQw+TEB3SHS5MNtQzmYVVyXdbd+RPlBfkhXTnFG3boOc8JRrjii2W/QbYbHGFtstw7NmB/qV5xgwxNklpvurS5fY02NmQ3AlaBC2ziVfw5V/hDM2yxJm1KYF1CSMtz7OwtabvwQX9mcPswhDTb6P4pE9NLUz3ZMyi9Ano4kEccXu/6TZDKUbhpyQ8i39dICp24gBaHUhXrEd/9cayvsS3VTPWr00M2AAlpPwGqxRV9jmZOaHY+tTxC4m008hCJBlsfFOfbXBMLiT9FM3GeBaU0ce7OzTdoEG7Mrsl9thY5FMcVyaSvSNvAo1Y3wqfFQ3Jic35ayGpOnV0ba1zb9Elf+gwaR8eUipNLdgMWMWqVbNuXVQfHFC5vuNMcE/5zQ68wWoMAKmZ/qB07Dg7f/pJj3ERXAwdkVpKU54kO2DcCESExshr8MvvNSigLI/10shRSDhd2tNmPopFF2Ktk0znV9kb11IfgIc5V+EDAocTJJgnXlSAUMRKrJgrfuYor9D2A4CtI4aVjle/i33Ww8INeCArfjGRwoPIBci8BUQM8s5/YHlbBRcTAWEmUzF/8bsyRLk4Gt7Fq7P8JGd95vj9W3kyekr9WC4qJeMzO2RElulDP3QlQhfHLbQWhDzsG9Ta9ckPI0KalQJRLDIlqra9MR9qw4AvS9WuIYnq3kIGKfJRMT9kbhbHrFz9lJwZgsGMmWCgha7pbx8/lTdk16oee2nQZK8dGP/iy5ZR45tFVnAF5dMuE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4587.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(136003)(39860400002)(366004)(376002)(346002)(4326008)(8936002)(6916009)(38350700002)(41300700001)(6512007)(4744005)(26005)(2906002)(86362001)(66556008)(52116002)(38100700002)(6486002)(316002)(5660300002)(66946007)(53546011)(6666004)(186003)(83380400001)(66476007)(8676002)(33716001)(6506007)(9686003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JptWhRJjt0dqUI0y895a/fqdaV5DruS0CsWO6aQ50DtvV7VZ5PGVl/1Ociin?=
 =?us-ascii?Q?hvK1gEt4xEL0EQjJizHsOOuLX0+ZlVYfqsdBBma7Y5Rlr4oddiwDx2zODTUj?=
 =?us-ascii?Q?pFMVYbTZnb5eXtQ+S55ewGUqCpCIDhxJ7cZ2Zqntq/e5gYNFZ1a6ekiKXxSj?=
 =?us-ascii?Q?Yv4PVK9xNE3KdIRnl9Amk2RktpudR3wHIyioCnDB6S+9Vuubu8WEvj/CcvA6?=
 =?us-ascii?Q?/atSFwsbqycEgRnfkYLra+94VNj/TrdeZ1kPmbF7ZEFxHpzmQvFIsJVRgjPu?=
 =?us-ascii?Q?tJ+fRxHqGL3VVFcWrpm6Kun0p1J74I+SFOgtYbni3dPDussFrEUMl0PG0K13?=
 =?us-ascii?Q?LZQO4LNCop+bdTgtWuMQffRy8zsP240cFS/Qrc4XYUJZQ0Tc3K/ow3drOu8P?=
 =?us-ascii?Q?MhoCi3bRvP/o/RETq/9f+7K+ujslz/U5Clj66KFLQV4DHMeCKDMrS+Z7sQC0?=
 =?us-ascii?Q?n2vdbHSyQ4SwSk8Pu1y4zl5H5LOPbypUTZ7gDpINNpQSz1Nl5rbzuR7tRIwP?=
 =?us-ascii?Q?NoiFeBUOvMW7scbavs+B9W/06Nbtiz8UCcsvkJ8sv+qvofzWB1/VDJQtA2lm?=
 =?us-ascii?Q?4oni2qZgrjw2GMxnkMmLBYVo942Tu1Ofrr7lEFdMEPU5aN5iXSvTTWoNA/iV?=
 =?us-ascii?Q?H+jxS9RsB6UmnOcgkD7aXRIQ8nzZzMEHeLlbEpZ6ADXS2hdW6d/VaJgDVL1V?=
 =?us-ascii?Q?UK8ZEoNzxIfqKoIUWQN7wtfSuoL13M6gKWbFw4Y/+P+TWdFJG7GvbiZUtADE?=
 =?us-ascii?Q?WVWv50ypJH3/0qIzO8sRQ7kaid0oUf4jtEZLDa/BLuD8le1n3oQ+QAxZ1TxT?=
 =?us-ascii?Q?F2aJ95Mb2LjGbKSm7mhu5JqxBcMN7WS07IxUBvIEEUN62ZLer5RFmAkmCUaV?=
 =?us-ascii?Q?MkVFBsaHcOFnFavcmcbEROLXNxWq3a+BOxmCXEnSxVDSvuVJblOKWh1vw9It?=
 =?us-ascii?Q?j0cB5Cgg1WLUQEQP/D4OvJyLBYbr/FEyPfhVbvkVTO27fEMj3hxGhCUAZDEi?=
 =?us-ascii?Q?hbQjxhpAyNRGR/HaRovDF14TGxMdzNv+i84u4rfkxNPoeIIk/UYIZRNK5a/0?=
 =?us-ascii?Q?f55O7nKfw9RHCb3k5/KK9E/ZDGM/+Tkc+6Xu6mIRzCa1suN174yqQ76dAx8s?=
 =?us-ascii?Q?r3VRezOesgSvLpOXqrXViuY2qVnLC/Ps2X5Sh9cWk7sBD679hPrw7BgUb2sU?=
 =?us-ascii?Q?7VGxEd34idfQLrRlAS5SU0OlSqV46Zb7XJrkpIcx/t1MeLrN7ULgGW3SrSFF?=
 =?us-ascii?Q?bTMOMmgeYdPFbfrHLwF6rlIlL6dZAN/p/Dg16GMonplOdyeLL0jxyAKv9sl+?=
 =?us-ascii?Q?bR53i0mKWuaTz7VGRh5SP7AhXfGrxz3dALdTJ+XnPPtBjhkmqIGh1Tv0zTEi?=
 =?us-ascii?Q?llLbK9Y6HKv2MvcfwYqGLhj9FgcJxQwGYaUIJmlKS9kET+64mnnBcQo9u1jR?=
 =?us-ascii?Q?Sl+UV0JBD1cSrUXArTQvw/B6MHRfe+8gMZdE4KKN0Uvx12+E2LyoB1VtTtxb?=
 =?us-ascii?Q?9LPd28966s3F2KihvP18KmbSFW8LxwvhQ4PeA3sMFTeQjlzkC565Ge+yq+Kr?=
 =?us-ascii?Q?jDWBYf/dFZUU4xDSQmpMvmc4o6Gp7G6IIx/PAy5msJ4O6upPXBLSudf9096P?=
 =?us-ascii?Q?pOdsH/wOCBu822xPtwsvvL074l5Y/aSfJy+fxeMpQalauQNltRu6tL/8EhwH?=
 =?us-ascii?Q?cQjWl0lp1Z0UOI6uYeGimdsK99wR9dWXJc/HMNJguJg6SMaK6j/BqfIWKXUS?=
 =?us-ascii?Q?Y7/t8t/Zuu53w2GnUxpdJVvE/e1KLLU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e3712f-3434-4bd4-3efd-08da55228a48
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4587.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 14:13:26.7022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lDFhgcFZBWuzOpc5D8Drg7N02lYF9Rsy1sEWRs+IaqoeoT+srhFIhEMqSMMIfZHLnchHw9FuC89epcWMGY2GWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5928
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-23_06:2022-06-23,2022-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206230058
X-Proofpoint-ORIG-GUID: EmWmzlfCi1-j5o7tOV92XXHPvLlnJsx_
X-Proofpoint-GUID: EmWmzlfCi1-j5o7tOV92XXHPvLlnJsx_
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jun 23, 2022 at 08:23:19 AM +0800, Zorro Lang wrote:
> On Wed, Jun 22, 2022 at 10:02:16AM -0700, Darrick J. Wong wrote:
>> On Sat, Jun 11, 2022 at 04:40:33PM +0530, Chandan Babu R wrote:
>> > Hi all,
>> > 
>> > This patchset adds two tests for verifying the behaviour of Large
>> > extent counters feature. It also fixes xfs/270 test failure when
>> > executed on a filesystem with Large extent counters enabled.
>> > 
>> > Changelog:
>> > V2 -> V3:
>> >    1. xfs/270: Fix regular expresssion used in inline awk script to
>> >       match hex number.
>> 
>> Why did all the patches lose their RVB tags?
>

Sorry about that. I am not sure as to how that happened.

> Hi Darrick,
>
> Yes, the V3 lost RVB tags, but I saw your RVB on last version, and this V3
> only improved a string, so I reviewed it and added your RVB back. I've merged
> this patchset. Thanks for your review again :)
>

Zorro, Thanks for fixing that up.

-- 
chandan

Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A51C83F2C
	for <linux-fstests@archiver.kernel.org>; Mon,  4 Sep 2023 06:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343510AbjIDGJF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 4 Sep 2023 02:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbjIDGJF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 4 Sep 2023 02:09:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05606E1
        for <fstests@vger.kernel.org>; Sun,  3 Sep 2023 23:09:01 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 383JpGBW008168;
        Mon, 4 Sep 2023 06:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=XFS3dj5CAB1R964xlMfnN7wmQAIsbmSGXg6wudVc/Pw=;
 b=XGm7McWH8eetc0tY0fCAQcGEl4EtXsuX+rIEzPEUa/h49l0tuPdbuStcKGPWSbcnF+HI
 0iJyKtna+rq/slWeLRXuhkkqYT5+f4PgJvhEMZ+i52Dj2AFG8/Z2/iNGJl39J5SRl+0o
 Np6gsfJF4+dDPkWj/FZlpSbG6rghNSnw81Uzae+kmQK+vvE5FeVfjbjWeFtCsP17Jk2X
 57+9C1zesnoSHbk1Y16JgRYGQMOkUOpIXD5CpS0PECOgn4emZwYRlqCO9m5kXMbTNKGx
 IvJiFNVyLkEmRbKGxZ9bTlVGk/09exRnqvs3jm4OdTAyci3fFkX/vxu6afA+agCkujI/ jQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3suw3ctfah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Sep 2023 06:08:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3843tMBU004302;
        Mon, 4 Sep 2023 06:08:54 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suug9h7hh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Sep 2023 06:08:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbT/M8biM60aDU5mz7cblCZ8skGfhC9g6AIT1DdzxMHrx3OAS3IvFBXOcTSvYBcYLJwQQLgYP6q4K1tfM3AW36bHfbw0cviSAQ+D6Xtvfh696piMYtGBISkGkhLn7xeoT0BgsYYXN/7o2UXsS7utMVARy6+KVaGr2LWQr7Mz+/MXsZi96uGm5CvDL5tIhDLQ1HtL+6hrNbyTG/PWx5jCsnoG+MoNAlkmidUSNDjviG0v7hV9oUrJfru0ND+Ypsk9ZB/bc+dZrBvkSXmSkZjd4R87m8waFZ5v4luBYqrxDbwuk2p7hyafSp2Ws1GvgTXIYCTTcdwlwMdFI0LM8VOGaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFS3dj5CAB1R964xlMfnN7wmQAIsbmSGXg6wudVc/Pw=;
 b=FqlbK/iyvgjn7PiWwMDYkh1ghzl6fw0dF1DHUa3zGn7f1TUA5qSv+o43Kb+91+YQfnC6gLOi0W9nxUCII0/9ocBuZSvGhD6/77GjEcKtkfv5OJ4NgA+JPNxwPeZKc8I2RGp8uOtIY8EIwG/ur+wOsNJKgrhYWZ2wHo1PJhK99JblTJ1ccjeoZq6aebrHpZ3QQwGi/Sjv5drkLc/90Mt7HivBAESX7X5XJxdL0S9yhSfr5bXDHLzmIe3GEUJOxX4LnCcVcxvLqSxLpcMB5iBd9pItkCneJkYpE+Kun2bmpqYVyPJoQI4QkLpJLEeWWExKB8+EVtssfeSNKcoSj/xQ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFS3dj5CAB1R964xlMfnN7wmQAIsbmSGXg6wudVc/Pw=;
 b=xn/4nmNjejENQHq9aePQWerS1ciVnFzXvMTpr2yHjLwMtVr36okSR2Hx7EXBtxRi1aPJhOcAd2Vhm5kI8wkdj7EkTUeVxwsZ/nZvyjjBlcBS0ZwGHtAQETQsfmDCwBt4e97MBrTIYSdG3DBPmFQpve6ffN5+1mX/oec09zNH7Io=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB6783.namprd10.prod.outlook.com (2603:10b6:208:429::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Mon, 4 Sep
 2023 06:08:52 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 06:08:51 +0000
Message-ID: <6b45a808-491b-a6ad-a5b1-5776dd307462@oracle.com>
Date:   Mon, 4 Sep 2023 14:08:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: Question about multiple scratch mount points
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        fstests@vger.kernel.org
References: <5ac92006-6f06-196b-1acc-7380d8ca4a86@igalia.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <5ac92006-6f06-196b-1acc-7380d8ca4a86@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0185.apcprd06.prod.outlook.com (2603:1096:4:1::17)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: 87027f33-7948-4ddc-0bb8-08dbad0d694e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QFYHkyhfzkG0pTEUUfgvVzKXHSxN5Iu5ozQqBGK/kFPd1cNjWiBKJOPLfrVaZesgRRCLWW8nI8w1VEiASoTY6RDwu9L7zCMlbat5y1xm+qHj03i9jUoBmhDPVyntjlFqDBCfyLe5LU8g5LEjm51c1nKrUj41SJTcHmzvaw6bbrDT2GgFCXePGkorI6yKAHYQ8VjPRNIlRsZzVXiCZe6NNCU4MgZJbqZy1cktOiqaS5isDSPnuhCsyFWs7kz85eWf3o1Y+Ho+KnUOPmJyxYASksaegm8b+IiQAfw/jW3+sZK2t0IQckU+rq0CjSFgfqF+vGajC7nk38W7GAnD5oTY6c+/xgBCAmElY0oYHavnA4DdiOq4n8kleYlEDbH4qGBwCtEB3OrZNHp+UTDKZaC3+G1GncGPEf2dvEbIucglrVbVe6Q1d39eB/2/wpKIRrtc05t6WMuWLwbr8qFXLTWftfubMHPC/xNg2w9MKYz+ujmuL8+r4pNI1PHf2lHW8QGKKqpdRO5DIak/XgxGq86QLQHxSUGxHPZHXIMq0bX2k+/nrQH6/MAFEQDu8FXaETlhFB2xNC0X/6D/D4+HZxY/hbl4/HvmClB2Yp+JQ0PzdQ7UR2TKdH+w9XwtwKuSb9a/y18xOLRwfvc/b2P8JVL7iQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199024)(186009)(1800799009)(53546011)(6506007)(6512007)(6666004)(31686004)(6486002)(8936002)(8676002)(316002)(66556008)(66476007)(66946007)(478600001)(41300700001)(5660300002)(36756003)(31696002)(86362001)(38100700002)(44832011)(26005)(4744005)(2906002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2hqQjdIR3JCM0pXV083Vi9xL0pyUXNrUGFWclN1ckFqdmRyM3NwbFU4dXA1?=
 =?utf-8?B?cThJT3NvT3k5aXhOemhZd2RaUHRuL3JrWkoxZVdGMWpnSEMxVHpYeWhpL1VS?=
 =?utf-8?B?YWxFRzgxQklScElhWTlUYitqdzhocGJTeU9HdFRxbGVTSlpmSE1wSVJXbkZN?=
 =?utf-8?B?UDEvMy9kVGJrZ29OczhPSFF3ZXp5S2tSUmlnZEdVUHZoYWFsM0UwSDBuS2pq?=
 =?utf-8?B?MWh1a1FwNzNQYTNId3E5MGxId0tmdEh3SlFNWncxd3Nvek9rQWRWd1AyTGlM?=
 =?utf-8?B?dW1vTmlTYk0xcm4yVUhqY0dDV0d6TjlRN1dQdXpkN084RzJIL3VTMzVjYmFa?=
 =?utf-8?B?YlZlZ1pNUkVwK21JcTEveld2cjZaR01HSUYrV1E0VTBSaDY4cFVpK1hLUGVP?=
 =?utf-8?B?RlZOZWd0RnlWZ2JBaVNEaGhjY3pRT1ROcCtVSDUwYW9mZ3BrbjJZckRaZzQy?=
 =?utf-8?B?REZJSWw3eU1YY3hpc2pwVkV4OThHZ0tMR1VnMytBM3JDdTV0cjlpemtPSlE0?=
 =?utf-8?B?azRoQ3NIMWZOQUJtUTZqUjFjR2RXUDVsYkZqZ1ZMUk5NRUhRSk9JN3BDckVB?=
 =?utf-8?B?WWVDRGtaanJYR1lNb2p4SDFmbkV3SHJXaVQzQ2RrWk9YM0ZRdU55Qm9vbW5K?=
 =?utf-8?B?eGpIbmFEcW5tTmVJb0x3VVJWc25IK3lHbncyV0hlWTF3RFpYSm5ubkRpOHZ2?=
 =?utf-8?B?Rk52MEpzWEcxRWVpeWtlM0NIVENBZW9vbXdQcHRTOTNCYVpmN3BUMXhxc2lk?=
 =?utf-8?B?ZWNOQ2lQVTBINE4reUtZNkFMeHJFeE8xUFpaSWc4OFJGakRnY1o0eDhaOXY2?=
 =?utf-8?B?amJSbXI2M3ZZQko3OG9RanZSVFdRQnJIRlFZeVo0bTFhUEtVUW83RWltQnJP?=
 =?utf-8?B?b1UxNUttQmdNV3FQS2k4UFRoSy8rQ2E0UzQ4bFhwZmRCT0RCbk9IdlhkN09y?=
 =?utf-8?B?dFpENFNkY2IraEMxcFFyNGJrZHRNZ0VIbkZYREE5QU9rbGdnOUhYSDVrRlRl?=
 =?utf-8?B?Zk1tSHF2aWFPZ0tkekpXdDNvNjRCSm5BU0xBN1ZQMFhWSlNUOUlhZFI2RFFs?=
 =?utf-8?B?YTNqRTcwQVQ3UlpVMzJUUjBjckhJemcvS1lkc0VWYnZJTEV6SmpvRUcyakRz?=
 =?utf-8?B?NzJTdmJDRS9lY1ZVd2FSYmQrZ3lkZnI2UzlIZEZSZ2pqZXhYWVFZQVZ6NFlr?=
 =?utf-8?B?QjVCcEFPS05oVDhEY2JFcHI3QmZUd09PQW10dFh5NVRZZ2RRQVhSdzd3Um5R?=
 =?utf-8?B?cUx0eGJYSVVUZ3VoZ2I4cWxjMi9QaE53SjF4SHdHM3lzL09takQrTHZLZllO?=
 =?utf-8?B?NjFiT3BZdVlTdU1ZWTU4dnFZeDNRQ0tIRmx3ems1bnVBV08wTERUNDBaVFFu?=
 =?utf-8?B?MTY5QUhuRmhteTRGUEQ3eTlYam11TkhwTWRSVGZ2enljZU9kd3Zjdmdobytl?=
 =?utf-8?B?Y2NUWnB1MmFZNUl6V3RranlFMFhlRWpMdWVhZ3BPRE1OZjdhdG5jSVRMM3ZY?=
 =?utf-8?B?U0g2aWE0b2xTWVRmZ1hKVDFldzVqM3Zya2RKSFVSYW90TmZqVXJ1bzFZK2xH?=
 =?utf-8?B?WVZPZk9JL3JKMnY5ZTRvRHkwUkk4bk5nbzV0UkVSa1NlUVZvaGUwWlZlRjYr?=
 =?utf-8?B?OGJlWFNtS1hyUGdrRjJhdGlyUmx4em4wTWhqTWlXSjV5VVBrdG9GMFc3YkM3?=
 =?utf-8?B?OGpJb09BVkI0WkJacUplWUc3aFJhTGtZUHVBaEZLZ3FUMGd5RDZneDNzdjdP?=
 =?utf-8?B?QSsvLzk0R1BFT2JIM0o2bEY5cU9kZVVvcUdpOGNSMjdpTHpTZFR6akFiSTdQ?=
 =?utf-8?B?cXVHcjcxT2JUcEEvTmFJS0Rvdlg0aGV3SmZXbFVibXZhcDhHd2VxNWFkUEEx?=
 =?utf-8?B?NmdVVWdyV0o3ZG1xVXg0RW5YSE9wWVprQjNZR0lvTVVwMHM2NmgwVkYzNUR4?=
 =?utf-8?B?emppeFRtbC9QQ1BGV1lwd2dWNU9UTkhNT1QrRVJxNXFGTXJDSFRncXZaeWVt?=
 =?utf-8?B?ZlQ5M2pHZHVqYnl1dmcxdGErVXVQeFlBb3M2R3I5cFhNL0lmaWl1NU95V3Vm?=
 =?utf-8?B?NHlUc2VvdkVCZkdYWENRSDlqMDRycWdBZ0x6K0xnTllERFdIVDNpaU5ka2lE?=
 =?utf-8?Q?1AtVWBtOtNC3CYdyWtxVg4uyT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: R3KnJl/9Vr/LYrmun5e9k8tNIScODAlIMreL6ociyYl9r3FlHUY92pI0uYGJTw1jUIMBi8+r5j9dTHssWboH9z6r6yJwLhHKb5TKrCrUNWSCnnNWpJRwy4TMg7ftflUSEkorrVBdnc8GUh/tnLTh+zN1kBb1HXOlmCpRjdHhxj0th1gF71aJ1OPDZq09C2rBbbH9qm3nODOFXt1GV1D2TU6AyGvRXpjuAaW7lFO5mX61HsAGa3mE2l0T+O3BDc593+Px14qUfP9j+RI14jqkSFzAZvcNTqZGHhlR12ZLy7L7IhhU6MQnJEpiI6c2Dfbukcj/lf++bChrv9c/eQgfqjkMcYSw/nIsaDGt1g2g3dLc9uy68zLEkwOqUDdE8VAFeM91AF9dYayD7UX7yObkqmyJFbkRAjIMQBhGcqwpUiGXQqkA1NxXIkMERjv7zKSCbPigKqqacrVG6NSBmdYfbgG7oPri6laL5cX/FiCfUVEJ8T167jlqs0JfrqZ+x7pvRkJSjFgyrLcHimxHykAvw9zImM5Mtwt/KCwKBHjJkftjHGay70R7NbFXktm2fMZgLlX3GtGtm9xT05TU4P7mLOe1rFIsyBF/cgzbtz6ux1/1rTFcpGHyAstTHVgC8VJH8tnvLFyJX3AotyPD/mrz3nK31I0A7jgbx+XAiRkF7K+zXi5UahTVtvMguh5ESEwJWSwkw8RY4TJQgomyw6J5faEuOujT/i7WMn+KJqihoVKhfWgsVQpqsuNgsNQuQ5Sh1MBBk+vIbBRq/+nqa6GW7Uv8mONHDuenRZqea0D+ogs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87027f33-7948-4ddc-0bb8-08dbad0d694e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 06:08:51.8800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u6MG3Ir0ag8R8Tf4ENtAUksqIjnTN7l9Uly4Y2E9lIouyPQnOvPqynRTBJwlD6KS7aTfZP1odf32g+091tsgIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6783
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_03,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309040055
X-Proofpoint-GUID: xt-PtNjfIFwEd-Iwn2lb-uuuTaeyuLLI
X-Proofpoint-ORIG-GUID: xt-PtNjfIFwEd-Iwn2lb-uuuTaeyuLLI
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 8/30/23 21:18, Guilherme G. Piccoli wrote:
> Hi folks, I am new at fstests development so I have a question
> that...might be silly, apologies in advance!
> 
> How should I require to have 2 scratch mnt points for some test? I'm not
> sure if necessary: what I'd like to accomplish is to mount the same
> filesystem (present in the scratch device) twice, in different mount
> points. One idea would be to just mkdir 2 folders under $SCRATCH_MNT/,
> but I'm not sure if it's guaranteed to be writable before any mounts happen.

We can use $SCRATCH_MNT and $TEST_MNT/$seq/mnt_copy as showen in the 
proposed test case.

HTH
-Anand

> Suggestions are appreciated! Also, sent here since I don't really know
> other forms of seeking help, tried IRC before without success.
> Thanks in advance,
> 
> 
> Guilherme


Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00172C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 21 Jul 2022 15:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiGUPMg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 21 Jul 2022 11:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiGUPMf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 21 Jul 2022 11:12:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8D478DD3
        for <fstests@vger.kernel.org>; Thu, 21 Jul 2022 08:12:33 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LDteV2002272;
        Thu, 21 Jul 2022 15:12:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=7yy8MQ2W5+ht9dNI7up1zj1VGLl5JXX9C1kmGLeaXXM=;
 b=Gw8WLKGPRZEuHFBoLeboqB9smF4krdlgy30d84/DDaIcABgCVncZKU75fIJR+izOmN95
 7wNK2dgcPEj+oCjvoVDt6VCkpgNGdo1qjjt4IP6hYs0v8gqbOMQEeGjhx7ACXuu7rTfA
 hq2pcTfXCwlFYNT51v3qRF30UcTl3pKeh69Sky+NQEE8tt5sLbQQ6UXspBSG7eAsxLLf
 TXtBH++LNp8nu7tuSJqijAv/j5mQbXcoS6Lh7u4xW5op8/VknTD1xjoP0/HxfilIw5f0
 5MLXhLIoO5kgfGphmTLi72V/6WJz2t9unalQLtGL8J3bC3qXwV2LHyk1JDL/aX/YAiLa Dg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxscsku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 15:12:27 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26LErK56022135;
        Thu, 21 Jul 2022 15:12:27 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1htxd1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 15:12:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PREyQ4CnU5jGR71vrf5CERpi7D4XXP0NLjk/n1NdASLeyN2bDcGGNywGROvkRAuIGOY3jLhZhmTuys6h49A9r9c7CQVyRpQ8CRhc8NC5kZdGL8eJURr2Y44gyE4b8T6Ds79cif67RyiVWSKLK3g0Thy5QOWluDWRAw3gDZEEoHtfak3dhYnE+pBANwSXn4yVz35uBI4nvbUnYI/75YgWzRnULEfZ9A2WFXHmvZVHOYwXIeY4m2CZ8PE0Wlup1hgbHfTaXALcrhm4vf+hShdYU+RYhKmuUVYE4KVs5zl0N+2neJ799AI8r18mvkQJ9qOTDDkhRrGZ6Iwn3i94kTZfdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yy8MQ2W5+ht9dNI7up1zj1VGLl5JXX9C1kmGLeaXXM=;
 b=j23awVMJ8zJBXPafY0hfYtAGZ+Eyx/lsmvjGXrS08hMVb+3Rl9ieG0QNcLMMH75qLo770veCYTAphcPbGxo66m0MR8sZRCL45ZCfprpHtvAcjbtWxoZTDmdnCNw4ja1JQLyRW7R/7qnzLDoZelGyLpMKja/0KvC+ACLazPUNO4kF9XLxJyq3b/R1Z69O/ojkg3tc4j7qOh44iGmbFEFkDNRQ+SMuHKSw+4CwVL0LnH/ZBZQ7g++3jF0LXjYVzXEvweAXwHaAwtLRTNYCSNc5gM9fehNAjyB7NIIADTAqtl5yV3zTcz/2hh1RKrtxvwqWzL49W8OfG8nZNuESm3nWmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yy8MQ2W5+ht9dNI7up1zj1VGLl5JXX9C1kmGLeaXXM=;
 b=ajdmfbKnMyqSU9WXfaVshSeSy4iU72Vh/GTTqF5QeJ2urURbHH4btdmqT4sropEtyp2lUYKF+ln18Jt5wcTIPBPRQT1uiUmzfNLZrQD348GuE+hpXOmApmWS82735ZLAVAmpIO3QpkMC1lj4iEpqZ7PUqdZdOhOTZY3UnExp0Wk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5179.namprd10.prod.outlook.com (2603:10b6:610:c7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Thu, 21 Jul
 2022 15:12:24 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%8]) with mapi id 15.20.5458.019; Thu, 21 Jul 2022
 15:12:24 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Theodore Ts'o <tytso@mit.edu>
CC:     Boyang Xue <bxue@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH v1] generic/476: requires 27GB scratch size
Thread-Topic: [PATCH v1] generic/476: requires 27GB scratch size
Thread-Index: AQHYnKnap4azL2QFlUaB+D1uchrXbK2IPrmAgAAuOYCAAEe5gIAAJ2OAgAATLgA=
Date:   Thu, 21 Jul 2022 15:12:24 +0000
Message-ID: <E5C39D1E-3DB4-467A-8C6D-6630A2ADE97E@oracle.com>
References: <20220721022959.4189726-1-bxue@redhat.com>
 <YtjYxyhVmSPzzFoH@magnolia>
 <CAHLe9YaAVyBmmM8T27dudvoeAxbJ_JMQmkz7tdM1ZLnpeQW4UQ@mail.gmail.com>
 <Ytk7t0am8H4x2BbS@mit.edu> <YtlcwZ/66pJhpdiS@mit.edu>
In-Reply-To: <YtlcwZ/66pJhpdiS@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37c049ac-bce6-4ed7-cfcd-08da6b2b6acb
x-ms-traffictypediagnostic: CH0PR10MB5179:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kGSVt6xD0BWBPzd7xdl4xBa8CaLTZXtka/eg9m6xajMTaPujm7s/tBrbnv1XBjmsA7248o673ameFX8Xe/+cBvbQ/0WFMEjWYO+ZMUxDrH9T08NfVj+0uLbujQcjl3+srt5xI+5oZ35/cYgIWEo0VcJm9EJIihKXh7yUAdcktnQLH6vhV/ymwvzzjM7i4HpyhtNunbLiMQm39l45Hcndp5VDL0HxtXDBs6dtV85f815bAyq8qarRFpDQ79moJSodCSkDs3+yDg3gK67pjGghl9SyjMQM/ahti2AEpMqx1ADTO2Sw10HtZMh1RUzFkOGqj/S0qWGh9idgdwiaL8sjF9f2E05zPRbmMwYLZ+f5V6UAfy1d/uvGVndkKJ5Y6sM3ZjglmPjBP8NPDVBT/ARptjDFmCIhtK7q0NUEGR4FQZJTn5eeaH4tp2ocjP7g70u0Xk+0gEXbC0qETiJS3QiJFCBOfrg9nn/WYfv6s6PSUO1+dSiqM9QkBP6toeggODcqI7Wjod7bbeSZCbiAE1wJMweFgje2DHqHbbDFXzAsgPUAWWDy2IPIP77CXJqpIsgjGjK0AwxLronWfM2o2urI6ch+ijgxJviAoDVMqR2WaOS+DF14gNHHMNnu3JlCL8mcgRTgTJqrw9ruTQ9CYAxmIzaAdojYpQh3NBpBrfzglrQz7j54tCBclLycswaVYtjrhND42wExzz6fpuK5rP26cltQSxbLp5eqCxoocBzep7WdMADSiIjqbvEYs0FPf0ShKiwnTyBNLWJCAfqMNTSeLNV5XgCYsLCO8chgqVpG4fqA4vRpn4DZp0Y9K5cJzyhAY6fYDiM1r2yAktTGZ/VbJ3rGvTo/jh/jN6qtWZyMhPM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(39860400002)(376002)(346002)(396003)(6506007)(86362001)(6512007)(54906003)(6486002)(316002)(2616005)(2906002)(71200400001)(122000001)(33656002)(41300700001)(6916009)(36756003)(26005)(91956017)(8676002)(38100700002)(66946007)(5660300002)(76116006)(66476007)(64756008)(4326008)(83380400001)(66556008)(53546011)(186003)(38070700005)(8936002)(478600001)(66446008)(41533002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XKsbCM3ElcMsJsARwFdtGGtiLms6f7pwkpzIRXxGGcKoDROIgdnT27pwVyc1?=
 =?us-ascii?Q?5JW0Z41T52BqBLd8cjdN1bly7F78WwcxJNqzabjSDZmHogSzVQr7HjcM+ejH?=
 =?us-ascii?Q?BpLFdE+kNmKD6XgNQaB9Jzw48PCX6d5wkdAmYxSIWDPfMYQouQjPT1+c3KLf?=
 =?us-ascii?Q?UIXOWZu4ArhdynkzRsPC2E+LH7WHXn1RwigaJbMRzjS/5zk30trseGyXl8H8?=
 =?us-ascii?Q?X9CqN9+kYth3Tg7oncNYQXUlAZ1ODf3Z2q9daaL7q9cdLlOtTLYEOXTCLbml?=
 =?us-ascii?Q?iZ6f7j19pZuXI3RgA6CXnZpBdn+zx+4HJWCweUo5QPMc443gNceFpW6/dkkn?=
 =?us-ascii?Q?KptUCv8z1ptfRklJINH0UlN57eRdHUL6NRB9hVMYhPs5tUaQW14b5mU4h1hd?=
 =?us-ascii?Q?nwsHGYZjtSBQJwdr6XMmv1gT7+0RhC8LhnvE5JAGnZNUjDD5q9sMFqLvrux3?=
 =?us-ascii?Q?RwD+Napg3eojpddBRnEEdqoxOkL/ywH82rDQMcBBfsK1iYq5gRwIY/Xlkx/n?=
 =?us-ascii?Q?tm01mbq8raH8pGiVgivgseQZkv9ntryoieLAUByunNXQYbgNOfxY4V4xHE2s?=
 =?us-ascii?Q?IESDyG901AoaXSyNId6jh3qOnkCotBldizEs/DRWJbIuYnOQDvxIN+Nc5Wic?=
 =?us-ascii?Q?Psr2ZhG04kcnRseix+Jan4t2kM9YKFFBt9/lVSmAT5syD1QdjNBcT9hk4B1x?=
 =?us-ascii?Q?irCFHs9t7+6JL3qG4n8Ibg3CYSmjWGI62LL0mw0xyQi//dy/4ySkUhLvMaT4?=
 =?us-ascii?Q?3awMtYHs1Js40F+EqFp01ckqiXvbSuuf/qQziLW5XDQX31MGVTvkz3XYorB4?=
 =?us-ascii?Q?CPQi3+9ene5K/lgsqggc4lPbA/E06/rfe7ldGxY13NSWDQ6VKVu+r3pzKaB6?=
 =?us-ascii?Q?p3NkHVB1cUWb21cWi8nmjDm12fCBbCmcqQ+7qGYWuEcrkT4Q/bh1pf3CcECS?=
 =?us-ascii?Q?fvs9x0WvPtgspQOtrK+gUC27/AqAPD421xnSRTLKKDbcbeBzc7xgqv1pVtT0?=
 =?us-ascii?Q?CpopV6rOC1BGRGQT3/voIg/EHH8zZ8Z0t8c1ZGzhQfkDVn1ouA0Gve/skzu9?=
 =?us-ascii?Q?PLnD2c2qs8SsI78r6y65ini/K8QbUYXLAZQwico0nwRK4xFKfMfufAhOmVMf?=
 =?us-ascii?Q?99ccmDUuqA7ZPRQpBHGy6Hpq3k1M2HMSrNKpjS2+7xGgL7lBRwZ2Jvxbxnvo?=
 =?us-ascii?Q?l+G79fDOG04HmZ/s5SnIWvHfDsjO/WGIiBkgRD6+tvg3HldgYxjzsDOQiAM5?=
 =?us-ascii?Q?m4mJ1gvxLhH9nzYp7iWhr1lQKFRL9YFXvs0dz837+4MD93LEOTTGG9VJgnXZ?=
 =?us-ascii?Q?bQ6wxc72I/AJwKuYfjkRyn15gBm2zaVPGsMW1EQicEO4+KHvuglMtu1PeV+N?=
 =?us-ascii?Q?WUJaZ+V6ECNENVNAmEf9nm4SXZDPzy6W5Yex7z6Ex+JygNHYIJvqQR0vYQrM?=
 =?us-ascii?Q?/c2eC8OmNVi49RgNTcVqrvouOR0NCWzJhN0fYCtap/8vRs0KyN7/8SNtyMeK?=
 =?us-ascii?Q?dUugEEeY++7eplr3VulMAhbdzZw55vQ1j7v6K0dm5E266dnEQAnkpHMg7cu+?=
 =?us-ascii?Q?uyETWQqpf4UF/yc2v+kqxFN9sHrMGj7M5pF85saXzsFlb7yEqJSE2YAEZa0a?=
 =?us-ascii?Q?Bw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5590D2824DCDEB43B430C3C90222086A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c049ac-bce6-4ed7-cfcd-08da6b2b6acb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 15:12:24.5229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DaRY2RflWUh+fy0x377cstrVAcqWi3fNdDHqnJU0jEb6Sa9YlWG8yXZjpt0qlr+6HGR79ZrFdY4JAd5DBvKEsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5179
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_18,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207210061
X-Proofpoint-GUID: efSFu5O8Uz2e47p8mCkkFnnYbt8hTSNP
X-Proofpoint-ORIG-GUID: efSFu5O8Uz2e47p8mCkkFnnYbt8hTSNP
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



> On Jul 21, 2022, at 10:03 AM, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> Following up, using NFS loopback with a 5GB scratch device on a Google
> Compute Engine VM, generic/476 passes using a 4.14 LTS, 4.19 LTS, and
> 5.4 LTS kernel.  So this looks like it's a regression which is in 5.10
> LTS and newer kernels, and so instead of patching it out of the test,
> I think the right thing to do is to add it to a kernel
> version-specific exclude file and then filing a bug with the NFS
> folks.

Quite apart from the question of whether to exclude that test
rather than troubleshoot, I would like to state that testing NFS
in loopback, while possibly convenient for Q/A, is pretty fraught.

- Loopback means the client and server are part of the direct
reclaim path on the same system, which makes livelock or deadlock
much more likely. Given that these test systems are typically
small, that pushes the stack even further into this territory.

- Loopback means there's often no way to know which part of
the stack (client or server) is the problem.

Any NFS test needs to have no less than two test systems,
otherwise what you're really testing is how the system handles
memory exhaustion. An important test, no doubt, but it doesn't
paint a full picture.


--
Chuck Lever




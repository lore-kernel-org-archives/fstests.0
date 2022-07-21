Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0452EC43334
	for <linux-fstests@archiver.kernel.org>; Thu, 21 Jul 2022 18:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiGUSOF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 21 Jul 2022 14:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiGUSOD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 21 Jul 2022 14:14:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFA88C17A
        for <fstests@vger.kernel.org>; Thu, 21 Jul 2022 11:14:00 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LI7iH2015765;
        Thu, 21 Jul 2022 18:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=OLdznefPIyd/isCpsTCaX4jWb49sYHGb3J0uPU2a1wA=;
 b=AAdjF2pNUXAXUzPrc4+cjOnCUYZZRzGY8wPFoOw0rAMAcLGpf7FnmugftqICSPzdVLnK
 Buz/tMglZu8ojGBDBUV8aqIvchwEORcykbwNobGsIjGvHSsmFpOyFFnZE3y4cQnJdD34
 z4EBpUAtr0WCU+l4egB7TKZSt/KbnYNE0P+df2Y7G3BIX01bKMYEpUkRZvLVd/2BIdl0
 bwONi+OVSowRaJYK1APTvgatNNd+0zZ5n/0q6/41OXe6MECy02Nht8lLJVHTuU7pIHge
 khBGHYiBmnjCNNIm+ujdSC1usLGtX4Hl3+cGIkn/kG1UaOOB0kqiNAl2yvRaS8U+RnMp yQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvtndnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 18:13:51 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26LG9XBN039169;
        Thu, 21 Jul 2022 18:13:50 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k70r94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 18:13:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYVgIwwA25Y4S6k74DY3ornsFXFQgVLqrpXig4y1EdXtVr1hY5t2TAENdMlA4oGiyvdp3oEulaNZnFcN9hsnW8zyM1BzgHGZsg9BjfmCRN00P9t5C96Cs+Mg0w3KYrEJ+5IMVYj8h1CsxrSibhvuQuPOoCHSy1qJpUS2hU6qkoqZWCKVpf7yqidv/Ubm4uuuvt2LFbVflpFQa6Xc8i3/WyJi0dXDZNh7QLMxKX1iEu3YfoUVo2tVLxEnMPfQ1h9UM1KbmrciOjd+Y1YpkGjNaKFpdVUAZh3FScBse5Q1tI7wEWlynOoU6f5HFSYkJXcuKS9qAvArUX+Sa5uyT4ZgSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLdznefPIyd/isCpsTCaX4jWb49sYHGb3J0uPU2a1wA=;
 b=dQ7cwHACifPbSblyA6kOFDPrJCUcBjvVAP9u0fAbdVT1WzxUD1Er+NU45iwx5qX0MShTGeNd1eHJ03PLQ5ZAJUfEgasBqYx4KBSwuLRAblIJt5bO1MVtbaNkDbwl8/mDCb2cnl2b20tg6Fa5uDHcK2m44N5PrFP2g1V99cvwYGP7HH/obczHwuB/UHSoC3xWrmuMuzk1RPeLhXrbc/Cxnt0K+Cjt7HfbeiVk4PKOHEHFPMyolRWUlY9j6Hkc+QM52bNGCIJkNDg3Ilw+59XLEXP0cdCGS9QBBwo6HgXspDkBofiIRXmhyp2jINyX82l9IQiQxvHpwNIZd4kQeE2xcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLdznefPIyd/isCpsTCaX4jWb49sYHGb3J0uPU2a1wA=;
 b=Yw0yoRRkqn47tNafXMNzBDbZ6uohcBUp6Z0hq4Ya1wloYtLFoMaw8SNvYOQynT+yRvqt+YfpPHJPteJG13BLblO0zge7I8aAMG0ekX5GA7qX5bOtgNw9/vgagvsnp8A26mYk/ufiYRdvH2DpcUU+goNoTobc0l1RuhQqO5Q0ZI4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB3536.namprd10.prod.outlook.com (2603:10b6:208:11e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19; Thu, 21 Jul
 2022 18:13:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%8]) with mapi id 15.20.5458.019; Thu, 21 Jul 2022
 18:13:48 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Theodore Ts'o <tytso@mit.edu>
CC:     Boyang Xue <bxue@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH v1] generic/476: requires 27GB scratch size
Thread-Topic: [PATCH v1] generic/476: requires 27GB scratch size
Thread-Index: AQHYnKnap4azL2QFlUaB+D1uchrXbK2IPrmAgAAuOYCAAEe5gIAAJ2OAgAATLgCAAACVgIAAL26AgAACrAA=
Date:   Thu, 21 Jul 2022 18:13:48 +0000
Message-ID: <75AAE413-4142-45F2-BE8A-7A7867CC0DA4@oracle.com>
References: <20220721022959.4189726-1-bxue@redhat.com>
 <YtjYxyhVmSPzzFoH@magnolia>
 <CAHLe9YaAVyBmmM8T27dudvoeAxbJ_JMQmkz7tdM1ZLnpeQW4UQ@mail.gmail.com>
 <Ytk7t0am8H4x2BbS@mit.edu> <YtlcwZ/66pJhpdiS@mit.edu>
 <E5C39D1E-3DB4-467A-8C6D-6630A2ADE97E@oracle.com>
 <6C27EF62-B619-4451-9CBC-B21CEC72F66D@oracle.com> <YtmVH8HNHHxVUyoM@mit.edu>
In-Reply-To: <YtmVH8HNHHxVUyoM@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bcdd2127-077a-47c8-ff35-08da6b44c253
x-ms-traffictypediagnostic: MN2PR10MB3536:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p5LfODyHTUz69nXGJfcXrD8EsHnASq+RdMgPk68VKhTasNIqW5j9l4gVD91Fm/j325H6L6LzM0uyZHUKYOL0tqqg+CoaEhZYBS1lq/gnSeqF5a4uJyGnWhZWPSY9RI8yxpqstk45ON04uApL2e4Nxy57wwnMHNvOSz2JzJt8/9gopIgLEZr2BCu7EXT9r5+7Eb942j8a/Uyh4R4Apev1n013Shx+xh4ng04fC2lvKdoIsTGl7nLk9QCQRTiJWXfOB2rKWR6Z40MJKzcDKHADdHn5p5VEICwEqWPwMz1k3MwBBc6jtQp82xY3Mq7Wzw8i608B7v+AKYSZYUunIp9uOB8E2qhXk29Iyuez0EzqCNit9zWHuSWFEl9Lsl/+ttanao9HQPYP/qTAgloN+36f5FQHKKVQlT0VPIylB2pfVwO0PRADvrKD18OHNESx9KRcBA2CQ2fgBxPJPesb03RW/emVm1Bo6fWH0xcjK2qmYoYJR9UvZGNqgXZBjBIO3V38feRJXV0ngf+HT5ZB6nKO+K93goyxwlBNbfKNzuUfuWCmZUn6ym1Nl+7RuKgCMuUT+YyPnCvhKXnV9+bns1jZTjn3Y0XyYpLcSc/gUINDpGCMYgeB/7Q9Uhy4aAbyx03ZIjasnKlUFQAeXFGy+bTHOOk2tI+ibPT9VgpFkwSfA5BpVZSubPBOxbfluWi6qoJgx05xSoFTzbdsPa6KK0VGvMQ/LaV1lUCEaQLP3tyK3xLtzRwWpFh3Jyxg1JVDDIyeTJoVX7WBh995g/VGDInuX3R0Ke2Ig6+Hm04aYl4QE2A7mJpRT6I5sgXt3TzsKQBsigZj4ATq/vSbgcl8X+DFnQ0OvoQD1Fv8l4S+/NV8JyYm/r4YZY5Gt465ya/YJOGL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(366004)(346002)(136003)(376002)(186003)(86362001)(38100700002)(33656002)(4326008)(8936002)(36756003)(478600001)(2616005)(54906003)(66446008)(8676002)(6916009)(66556008)(41300700001)(66946007)(6512007)(76116006)(966005)(91956017)(122000001)(6506007)(64756008)(66476007)(38070700005)(71200400001)(2906002)(5660300002)(26005)(53546011)(316002)(6486002)(83380400001)(41533002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Jv0nKRxqsCIB5RFG8yVcrPKgCBnLWqgC20g7oF3znfgV8VqHLzOTS8qXjYgV?=
 =?us-ascii?Q?UOtH8CBhVDNENRgtffjQwXcIUKybXJMc6pPloGntZZLV6iWLc72Hmu2QgCF5?=
 =?us-ascii?Q?1HEAJI39Pkt0uFZKVZUynRhNHPxIl0+Is3cTfvOm0htkuRBa5V8Z6voZ/bKY?=
 =?us-ascii?Q?inmHYY60SjQqnL7Z+4rQqnQ0KIyfiNkdw0V6F8//nibkD/kel/4lLuqOEm2S?=
 =?us-ascii?Q?T/FFbgFtbYRyFXhfwpzt4kF2hpbAOItP4/W3Z3mgVxH/2QfRBGbQJieHEfgT?=
 =?us-ascii?Q?fVKm3ZtdJaIhGtfZ9chHgIBjjxQqk/JZgSdlMYtarEFgPZoQRXy8FB/5V2Vt?=
 =?us-ascii?Q?vaxHSTcn0Qvf8i7POyRQs697jUyqFIbRNAlC7cnk0lRA5RfNWcj6RaUyydav?=
 =?us-ascii?Q?4jFeU6OCZ1doMaqlcq8qUxa7uUysmZBJW9fbcTKLLZd9TrDX+6ZPf3lbu56D?=
 =?us-ascii?Q?xo215UcrGkXZMiJYG21kNQbLAADEbPzbxwsDVg5up5hJsYMqcVw2Xig7MgoV?=
 =?us-ascii?Q?vEy4BxPhGRzv1f9HlLlKFbfEep8omPk6pjonbFSIXuovG46qQz2/6+cvnUA4?=
 =?us-ascii?Q?CrFI1JBk/EqTk09d/Q2oZHNgsKydpuEsguMa7mijOKYA4b1e5cIcJzjrIYF+?=
 =?us-ascii?Q?vLE0PPbbZG50g8TCgpst65DuM4KzrOStGYk24cZ2m691fgrtuVS/MpZrth08?=
 =?us-ascii?Q?FCCpX/HQ9qHdFKKiMi9lfHnPsg5yjzehxZjyDsWnikmZCt6Kz/nUpxBAfvRl?=
 =?us-ascii?Q?87Scf8qpatCg1ErA8cTEerhQjendS3PbcHbCdupASTbJNOv6uQbsUNc0OUjo?=
 =?us-ascii?Q?0/h1c+lYwVAX3S5NhtrdxSrwIIK1D8AAg9nDbsoijrKNa8E5G24YcQLCl1/H?=
 =?us-ascii?Q?UWgi4YCAqbCpWTVdkkSIqP8PFGnGMg2Lj91/sJwM5dw3kPSfU46cFIMrERqo?=
 =?us-ascii?Q?ZfY7h568FhxeXaNJLATUlREzrjj1kpjb5rUdvEk9zjxTzcIVy+gktAN3bAPG?=
 =?us-ascii?Q?Q/w3P6RZndP5Ektp2CDe3gQJWC6ndmXSI21M6WmxcncdQThASaAqslIgUSU9?=
 =?us-ascii?Q?CBHIkUSyk+cnkTwTY9hJGFJanCwIV3IP534oE259Yzg4y2N8NVkkwfIUA5Wa?=
 =?us-ascii?Q?G25R2cabPcwdPU8QgcqokzVf3r4dAjIJX69MoSOJIWp9mR4HAnhOVMCJsyUn?=
 =?us-ascii?Q?KmmD3c3faEK4fpOFWajwM/R2Zrl8RMEez18SSDXojRuVWopRoZTiSq+sJN21?=
 =?us-ascii?Q?52LOeT59bE+NXpUUzEaWbrE8cA4Si7u62ZtrOkzEUku3o0ZrxMoQMsw06/nf?=
 =?us-ascii?Q?xFn+wYKLyS0aUcIxAg0vz6B4uSb85S5CKw+2TF/hWs1/eiwNEPnFEAWvAizX?=
 =?us-ascii?Q?7ljI0ees3bydjRDwr9rkPXAd/g/Yn7G7vaIZiXoS7ubpB8IgMT2QPY6taM7M?=
 =?us-ascii?Q?9jOqPdJVv+vlqZapT/6wyru/+9qeP5V9+KQxdLSUoRQqRNhX9YrukxUKfTUK?=
 =?us-ascii?Q?JErn9pWWRBCTDA8nbIsgYxMeU+koyspRMA6hf6CK8XSFqlg2tmPHowYROQG3?=
 =?us-ascii?Q?w1SWXNdCL3uudIkppN5EMHGy5/wcFKFIdNSHdlKovUUoaJsqGTyhyo96I5Gk?=
 =?us-ascii?Q?eA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DCDCE1FA527C104187B88D0E725243EB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcdd2127-077a-47c8-ff35-08da6b44c253
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 18:13:48.8110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FkBY1EraDVH9UB5xWqpXKsYCd4Y6WK6yzGrbyIdjfYOCsvLSKXmTSdBvRL63r3T3JE0SU03KmAFTrTPtDgct8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3536
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_25,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207210073
X-Proofpoint-GUID: bYEeO2EfmBPGfYENedO1Oue1VTVobVic
X-Proofpoint-ORIG-GUID: bYEeO2EfmBPGfYENedO1Oue1VTVobVic
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


> On Jul 21, 2022, at 2:04 PM, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> On Thu, Jul 21, 2022 at 03:14:30PM +0000, Chuck Lever III wrote:
>>> - Loopback means there's often no way to know which part of
>>> the stack (client or server) is the problem.
>>=20
>> And by the way, it's even worse if that single system acts as
>> both the NFS server scratch device and the server under test.
>>=20
>=20
> I believe Boyang has stated that this has been seen both in loopback
> and in an externally mounted configuration.
>=20
> Boyang, in your external exported configuration, was the lockup
> happening on the client or server system?
>=20
> 					- Ted
>=20
> P.S.  I just don't have the capability of testing NFS on separate VM's
> for the client and server using gce-xfstests.  It's on my list of
> things to implement someday, but I just don't have time at the moment.
> Maybe a GSOC project someday...  Or if someone has time, patches or
> pull requests to https://github.com/tytso/xfstests-bld are gratefully
> accepted.  :-)

I agree that Q/A and dev testing needs are distinct, so a dev might
have a simpler series of tests to run and fewer resources to run them
in.

That said, I've had it on my to-do list for some time to find an easy
way to run automated multi-host tests, and I've been told it should be
straight-forward, but I've been swamped lately.

Many of us in the NFS community actually don't run the tests that
require a scratch dev, because many of them don't seem relevant to
NFS, or they take a long time to run. Someday we should sort through
all that :-)

For the particular issue with generic/476, I would like to see if
there's a reason that test takes a long time and fails with a small
scratch dev before agreeing that excluding it is the proper response.


--
Chuck Lever




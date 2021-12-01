Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36754C433EF
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Dec 2021 05:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhLAF6c (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 1 Dec 2021 00:58:32 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:29160 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229561AbhLAF6a (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 1 Dec 2021 00:58:30 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B10XZ7X019077;
        Tue, 30 Nov 2021 21:55:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=aZD84onpFGMe1H9wG+xksCE1oR7U641aLa9OLJ16d28=;
 b=lyXGsz84TYJ7PvlV1BQDUEATJLtgqX2hwqXZA52ssX65ufE/Ja+nivP+Zm9856Y1O/9e
 bokf+VChzeN0SI5XaHYwFMnsJ+ele6ueqDOVuMj031rc6aM/ckgDzTj/WQirmFhsVaNU
 +b/V6tIg4+5+S5vU8vnEtcqgI9wfdeZgo8c= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cnd5uruex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 30 Nov 2021 21:55:09 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 30 Nov 2021 21:55:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbklrHeVcNEe5h8kObM/Z0hpci9QU/LeV5GI16n6UhzKYyske+AtH9261dlDJgkKIiLqazaR3K9EnIu6c+afCR+EUXRkTzUGWB/V+XenHJ/34Hv45/Z2+i1WA/Xm+M5r0RxxbEWO+DAkIYklJ+zBmgAsb0UWIOZz5BsCBWOXB92vK9nXtxF2nQ/9SzER7MmiTI2OOJ9UoJFIJTf5IOwOXreqCyH3QDXfab0uxTetlU4L6By56/XcJeRQ5ckOiEGCY/bHEbO8xDBt/6UdY3MXCTqyF/m5e4Gq/MvIBPyoF/EYH0q5jLVmQTbxNzQGGN3ScAfKtL9bwtqFUQ//chJ1fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZD84onpFGMe1H9wG+xksCE1oR7U641aLa9OLJ16d28=;
 b=T8v+8ZVTzo/avGWHq5EQzdV4HNDXMieAnPmFeOBkgeASswkA+E5WK0GmaiWEGVrdZ3SkBWYrEetXJYZtfNWvVYHaZYeMOYfh4NIERZj9Ewa+gvpAzQfV4wYLYR6UJN7GeTSGJUyT2wdIF32cZYrEv48hVAUJdomHZE3V68pltPuqRIyThCNObP/rXKrnITViLyqF4ZVPsniszs/6/BffLilykPuPCUhTQySqtsE/Zr38g7+1MvA94uXHisfoXikUBoToCrFEuWBqfusFbmhnlIoezj3tbThGJeUdoTaJS4GJEsRhE61eaMl2Cf3bGlDLdvIKlW919uP/B+ZUIwaS4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4410.namprd15.prod.outlook.com (2603:10b6:303:bf::10)
 by MWHPR15MB1485.namprd15.prod.outlook.com (2603:10b6:300:bd::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 05:55:02 +0000
Received: from MW4PR15MB4410.namprd15.prod.outlook.com
 ([fe80::f8de:1089:be1d:7bf]) by MW4PR15MB4410.namprd15.prod.outlook.com
 ([fe80::f8de:1089:be1d:7bf%8]) with mapi id 15.20.4713.025; Wed, 1 Dec 2021
 05:55:02 +0000
Message-ID: <5e81c9a6-ed29-c678-d149-b9f4008aa737@fb.com>
Date:   Tue, 30 Nov 2021 21:54:59 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v1 1/2] fstress: add suport for using liburing setxattr
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>
CC:     <fstests@vger.kernel.org>, <kernel-team@fb.com>
References: <20211129221542.2549306-1-shr@fb.com>
 <20211129221542.2549306-2-shr@fb.com>
 <20211130203344.GC3447530@dread.disaster.area>
From:   Stefan Roesch <shr@fb.com>
In-Reply-To: <20211130203344.GC3447530@dread.disaster.area>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR21CA0026.namprd21.prod.outlook.com
 (2603:10b6:300:129::12) To MW4PR15MB4410.namprd15.prod.outlook.com
 (2603:10b6:303:bf::10)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21c8::14c4] (2620:10d:c090:400::5:8065) by MWHPR21CA0026.namprd21.prod.outlook.com (2603:10b6:300:129::12) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Wed, 1 Dec 2021 05:55:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9360cf3e-aa27-4f3c-715c-08d9b48f1d7c
X-MS-TrafficTypeDiagnostic: MWHPR15MB1485:
X-Microsoft-Antispam-PRVS: <MWHPR15MB1485F38E7EDD4B506F99DEC4D8689@MWHPR15MB1485.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sGYbEihB/x9dIA0ooDQSYfWCEy4Knlmc6bvi+yiPXqRzgXNIHFCrNANZCwIWjFD1Lkirk2Bcn3caEucY3T32CDW++faK8ZE25+hwUtbysj8/9HeRygrCX/KnVjOOFAGZQtHTS3+8zw0Pl2FFEXZI4x83jURjw98DoQbeeC3kRlNa496h/sgW4VHhQb6nhf0B6oUUBgR3AIYeMQ7BozNQtqZJDNii4YBc8xSn02ISHQNb/s0Ma1mr/1Ss54P7U3StHWbrGF7GiMAu5/yk44Ntm4lxNC1C2FVEz2ssfacbcaLcdyCiXMbL2J4CaBQn6khC3Kx49ufbV9D912guvKhhRaNWezPWS7XE8BRBXIb/OEKIVhFVlmEGehX3N9ekz1SM2zy3KLNcz60tfOJOdhQOD2/Q5qMuA+8dKHBJS6N7DnFbfbp3Sx8k+ircfG6ioTMrg3QeyQSayPf8NnJCTa1Gm+doGkT2xEd6F+R8KRFe9QHhk7hxOija/stRRUxNOqO2A7iHbnKA+9Ci0SgXvwvC71ltX7cQeaH0cNtFQMG0ldGwKcZd5CUeb5h/jM/KjhulDXZTRiVLJ4XmQ049reqswb8U7+QlW/XXu2L6RIUIlefCv9PNZ8SpUOsG+CyHXUz5yJh/j2cv4BZiraH4s9v99DweW3dlKa2rxgH0ssMogHRTBuH8nfD8UpXfmsdxp7MKJrdB1o8Vs/Kx2AFdF5v3A/yphzpR/DbEqwehcgFY/5U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4410.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(53546011)(31696002)(2616005)(316002)(6916009)(508600001)(83380400001)(5660300002)(66946007)(66476007)(36756003)(66556008)(4326008)(8936002)(8676002)(186003)(86362001)(2906002)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTdNdW1hYk1vVUNjSm5pSDl4NEhEdkVJdjBBdzk2bnQ1RUlaSThFNVJoc3hM?=
 =?utf-8?B?ZCticGhTMlI2WDhPZFNXSE9KTCtLRlJhL0dtUFBaazM0V0JseW0vbWJiVW5w?=
 =?utf-8?B?azlYTDBNaTJaUk5jZnZ4NEp6ZmE3Ym8yUTdwTmV2ZXNNY29pSDFTT3BRY05C?=
 =?utf-8?B?aXRXbm5ZKzlTS083Sjd6YWZRMEhYZnRLNTFZeGxOSm42cmNIb0FxbzhreDdM?=
 =?utf-8?B?b29kbVp5MSswZTQzaWlqL0tYaGRZUjFJVEdlbm5pN2drOE1GaFFzVU5GYVl6?=
 =?utf-8?B?bDQ5emNLSkVhMnhnS1VZNStCTk1YanFkZkFnOUt3VzVtTjRLZWFEZjZDUkhB?=
 =?utf-8?B?SnlmazVldHFhTDRaZTl5N2o0dkliTU1rdEpkTDhRdGRnYVlEMHh0RG5NZVpJ?=
 =?utf-8?B?M0JMYnpPUEFJR0V2dDU3NjhQcnYrT3d5WXRVOWRsY0U5dTVzM2RPNnRXcUhz?=
 =?utf-8?B?NUtmQUFzVUY0UVFNTnRGZlZnWW1UTllNSk56eUJVamNocjcrME8yejNWb3I3?=
 =?utf-8?B?NzJqbFZzUnV6M3lOdStCaFh5ekNJSlhQcXJZOWgzT2Jvb08zb3oxVHRrVU9M?=
 =?utf-8?B?TEpidDZURXdGVmdzNmljMmM2TCtmdThqRGxjajNRbHhhMmxad1NUK25oL0M4?=
 =?utf-8?B?MG5PdU9yRktHNzE2YWhoOG9mS28rdnpHZXJjOGhxcDVabUw5MzFWekc2eG1o?=
 =?utf-8?B?Y1dBcTN2UzZsUnNhS1dDRjV0OUp5N0NzZjcvd0lINml3U2I3STFnSkx6cHlm?=
 =?utf-8?B?OWJqR2JUTjlsdmFiMHBYZUFNTjJXNm5DY2t1WVZpdzloTlYydWRYRDdzSEdM?=
 =?utf-8?B?OU5uU0FwL014Ynh2RDl5TVljVVY3Z1BjTDdKR29EdmlpSVRxRFo3RTFXT0I3?=
 =?utf-8?B?UFlEcU1rOVZGOWhkaDQ3SndNK1l0anVIaWNtdE5zODRpdkF2Nzk0N0xMbU1z?=
 =?utf-8?B?NlJTV3gzTzhhZUxHb3hZSDZ6eEJKNEFrVlZ1Y3A1bi9lc0FiWm95WmZTT3lX?=
 =?utf-8?B?ekZMdys2MG80d0Y2WlZxWGpJc1RYZFdmU3pweFdHd004ZWtxbFBEUGxtTWtO?=
 =?utf-8?B?Qk83QkRuRUZnK3ROQ0s1ZTFTbHV2eFpTNE9DVktsQmpyazZ4ejVFWklNaHNF?=
 =?utf-8?B?UFpWT1YwN1JCQ095Q3JsblRxY0Z0djY2TTFHaVIydzFZaHZjczd3UTZ5RFph?=
 =?utf-8?B?NGl3OWNtRDRrelJ0QWNRd1RCUEkrSmFFN29NbnFsNis1VkxZZ3lyaWd6S0p4?=
 =?utf-8?B?VXBqUEtPMmZOZThUVU5kdTFNSTBVZ0FaV2tiRUFoMTNyUlhhTHl1WmJRK1d5?=
 =?utf-8?B?RkRGRVdOWkQvQnNIcTZVUUM5a2lVY1FTU0V1eHN5a01KVGtYbHZrSEppNzhH?=
 =?utf-8?B?dHhIVkFZMFJkNmZuMm5NNyt2WlRHUTFZVE5rVWU0cDV3Y0VGMmQyc0NVbnlh?=
 =?utf-8?B?bDZFVTdOOE43YnAwUGxabldsQ3FwNlVud1FkMVdPTGdDbFYvQWQ0WDMvWEdk?=
 =?utf-8?B?K1JPOWNHazN0M1IxMlhXU2grZ3RSM3pHR3RnZzdyNlJIZ1FMak5OYWtRWmt6?=
 =?utf-8?B?VW1Ba2pVQWpMVEJVamFWVGNnWEREUkNNdG02L2N5WkRZNnRyaUhJN1lRTW5C?=
 =?utf-8?B?c3JPS0d0Rkpub1R4MFFvdXdhQVVPN1NRS3Z6QmphSHBwMGpPL3YyMmVtVWkz?=
 =?utf-8?B?UGhtMkJzQ201bW5kcDVIbTkrbWQyK3VGNVA2NmJmQjIyK2J6MzJMQ2J5bFVi?=
 =?utf-8?B?cXBBRi8yTkFqc1dTczFiOVZaOXAvMHRWcG5ubDEyeW1QK0RWY1VaNVZWNFRG?=
 =?utf-8?B?d0xxbmdxVDhJNmhPTkdPaUlCdnJUOHVEbXU5VGVEMGhXODRZQ3phZWVKUzQ5?=
 =?utf-8?B?OERLSi91VjJwOWcvcWM2RmNXaVppRVZOVnp6OEpVU1oyaXo3Q3JpNDQvZXhi?=
 =?utf-8?B?bnhRUmdqM1FpTnRuN1J5Ymg4U0dQdzFWWHlLaEVzME04cE9uT2ozN3c5S1Bm?=
 =?utf-8?B?TzViaXNib1JnTXRCcnlkSVZZQUxud2VMc0oybTBxbkZJb0l6N0pLaDhGMzVV?=
 =?utf-8?B?SzJuamNmMSt0WEhGZWVUQzRvajlhbTE0Z0pkQmRZYUsrbXBmaWJ2VnRZVWk0?=
 =?utf-8?Q?6xLamevD1ld57agE5L8wfA3QC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9360cf3e-aa27-4f3c-715c-08d9b48f1d7c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4410.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 05:55:02.2432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DC/R+LByI6KEe3Cwks/sdaArRzwItRskkb9Fp/Ohu4dDMEG+EyzY7W/ndbO0Keer
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1485
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: fdUm1yQxL6Yt7xBQftlyCySt-4hicIf1
X-Proofpoint-ORIG-GUID: fdUm1yQxL6Yt7xBQftlyCySt-4hicIf1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_10,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 clxscore=1011
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112010033
X-FB-Internal: deliver
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On 11/30/21 12:33 PM, Dave Chinner wrote:
> On Mon, Nov 29, 2021 at 02:15:41PM -0800, Stefan Roesch wrote:
>> Summary:
>>
>> Liburing added support for setxattr. This change adds
>> support for this this in fsstress when fsstress is built
>> with liburing support.
>>
>> Signed-off-by: Stefan Roesch <shr@fb.com>
>> ---
>>  ltp/fsstress.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 42 insertions(+), 1 deletion(-)
>>
>> diff --git a/ltp/fsstress.c b/ltp/fsstress.c
>> index 003e0e49..4a5c4afe 100644
>> --- a/ltp/fsstress.c
>> +++ b/ltp/fsstress.c
>> @@ -4779,6 +4779,43 @@ setattr_f(opnum_t opno, long r)
>>  	close(fd);
>>  }
>>  
>> +static int
>> +io_uring_setxattr(const char *path, const char *name, const void *value, size_t size,
>> +	  	  int flags)
>> +{
>> +	struct io_uring_sqe *sqe;
>> +	struct io_uring_cqe *cqe;
>> +	int ret;
>> +
>> +	sqe = io_uring_get_sqe(&ring);
>> +	if (!sqe) {
>> +		printf("io_uring_get_sqe failed\n");
>> +		ret = -1;
>> +		goto out;
>> +	}
>> +
>> +	io_uring_prep_setxattr(sqe, name, value, path, flags, size);
>> +
>> +	ret = io_uring_submit_and_wait(&ring, 1);
>> +	if (ret != 1) {
>> +		printf("io_uring_submit_and_wait failed, ret=%d\n", ret);
>> +		ret = -1;
>> +		goto out;
>> +    	}
>> +
>> +	ret = io_uring_wait_cqe(&ring, &cqe);
>> +	if (ret < 0) {
>> +		printf("io_uring_wait_cqe failed, ret=%d\n", ret);
>> +		goto out;
>> +	}
>> +
>> +	ret = cqe->res;
>> +	io_uring_cqe_seen(&ring, cqe);
>> +
>> +out:
>> +	return ret;
>> +}
>> +
>>  void
>>  setfattr_f(opnum_t opno, long r)
>>  {
>> @@ -4842,7 +4879,11 @@ setfattr_f(opnum_t opno, long r)
>>  		goto out;
>>  	}
>>  
>> -	e = setxattr(f.path, name, value, value_len, flag) < 0 ? errno : 0;
>> +	if (have_io_uring)
>> +		e = io_uring_setxattr(f.path, name, value, value_len, flag);
>> +	else
>> +		e = setxattr(f.path, name, value, value_len, flag) < 0 ? errno : 0;
> 
> While this is technically correct, it is architecturally wrong.
> This replaces testing of the existing setxattr() syscall path on
> systems that have io_uring enabled (which is most modern, upstream
> test instances). That's a significant regression in test coverage,
> especially given that most applications using xattrs do not use
> io_uring...
> 
> The io_uring functionality should be added in the same way that
> OP_URING_READ/OP_URING_WRITE were added. That is, new
> operations were added in addition to the existing syscall based
> OP_READ/OP_WRITE, OP_READV/OP_WRITEV and the AIO based versions
> OP_AREAD/OP_AWRITE.
> 
> This way fsstress adds the io_uring mechanisms in addition to all
> the normal syscall methods it already uses rather than replacing
> them. This also allow io_uring operations to race with existing
> syscall operations running the same operations on the same files
> concurrently...
> 

Dave, thanks for the review. I sent out an updated version (v2) of the patch series
that implements the changes as dedicated operations where the user can select what
type of operation is preferred.

> Cheers,
> 
> Dave.
> 

Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AA3C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 16 Dec 2021 17:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbhLPR25 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 16 Dec 2021 12:28:57 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:4262 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235619AbhLPR25 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 Dec 2021 12:28:57 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BGHMRLO021007
        for <fstests@vger.kernel.org>; Thu, 16 Dec 2021 09:28:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=+cJesv9gGy6oE9FOQ93byT1Pth8Ff2mtrh64s7GL67Y=;
 b=fsrmvGi5MFTu7CR+d5d+qWaD43N6cABRp8hSfqkwkDemgHhp/Lxewssow2MPFjgACigR
 09H+M+mqT15tX4QOxj6QnAaUl2+ynrkBCtHG+XU31pm0ocDWJexWVkhLn/b3TmXw5Exv
 8rBH0XnYH9EZdL1it2kFzP58BxOHSdF5VY4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3d09t2g1ma-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <fstests@vger.kernel.org>; Thu, 16 Dec 2021 09:28:56 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 09:28:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajax3T2IxR82wPJUAVw1GP+lIwIf5Y2eNYXyqSQTfVACZIPwvflvpZu6MsW0vlN/tC3TBaDjjxsZrhUp/xIPYX8jz8aDDOTHcjpty3F9IjesBI5tltmcNCZUeaId/hOJ4bjlUQ1gHf1JdtbVcqGyi4hhm9i8lGF/kGNPsWe2QObsxB+qzin/LuzFnq+8r9lFDYDIMo/AyQL5YE5EZ4NEnO4sHGiLEyBH1brQWVTcGpHSG8KkHsZM55FVuhfeviuHCrwA59oHtauzOpvmz3fp2kaLX8WPkSDWu//Il/w7kctIOTUvkrK8vo1ZiCEoK+y7jFXiCTiJPCUi4yip8ORZyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cJesv9gGy6oE9FOQ93byT1Pth8Ff2mtrh64s7GL67Y=;
 b=fvS8bWPmzKHHj8R6/nNQG4HgXpQuQpCbqZMHzi6xKgb15KNc1lFLaFxKXqVsm3i26aVtNW1sU9h+sOxSj8AmomaGeyvpd8dDcVu3B8A9ZXjay3eNwp9ZpQ8rKZkqpFrIW7LvEcszjhfUGCDg8OLMn6GvQ0ozSX8ombygPwbrAYgwnK0drmlY3iZaT7v0P3fZbp3USDzgqmMCG0Pzw90AQyPbnwbZPAmdefG48QA+T0VJdSpoEWGtMT0kG/SL78w2r09LsWTQ9216kgyAlZ4ql9qONQlWkMCu6ZPNxRiAhVQ2lcGwl0Thh0EGsHkENqY0Zur85rVtSlPcZJryBE8zIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4410.namprd15.prod.outlook.com (2603:10b6:303:bf::10)
 by MWHPR15MB1295.namprd15.prod.outlook.com (2603:10b6:320:23::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Thu, 16 Dec
 2021 17:28:22 +0000
Received: from MW4PR15MB4410.namprd15.prod.outlook.com
 ([fe80::989e:71eb:eac8:1f72]) by MW4PR15MB4410.namprd15.prod.outlook.com
 ([fe80::989e:71eb:eac8:1f72%5]) with mapi id 15.20.4778.019; Thu, 16 Dec 2021
 17:28:21 +0000
Message-ID: <038c03ef-7562-c0b4-d85b-cabef774ed9e@fb.com>
Date:   Thu, 16 Dec 2021 09:28:19 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v2 1/2] fstress: add suport for using liburing setxattr
Content-Language: en-US
To:     <fstests@vger.kernel.org>, <kernel-team@fb.com>
References: <20211201055202.3142034-1-shr@fb.com>
 <20211201055202.3142034-2-shr@fb.com>
 <20211216073029.lix3tj5awocvrw6l@zlang-mailbox>
From:   Stefan Roesch <shr@fb.com>
In-Reply-To: <20211216073029.lix3tj5awocvrw6l@zlang-mailbox>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR18CA0053.namprd18.prod.outlook.com
 (2603:10b6:104:2::21) To MW4PR15MB4410.namprd15.prod.outlook.com
 (2603:10b6:303:bf::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c8db163-6f31-48b2-e5fb-08d9c0b97539
X-MS-TrafficTypeDiagnostic: MWHPR15MB1295:EE_
X-Microsoft-Antispam-PRVS: <MWHPR15MB1295969B8E2E08241D852682D8779@MWHPR15MB1295.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XYpbP7lL+w2t+B6MwWSJluUQkoZS9aTaoQX+1wL2H5dsMlrxy1U72AM9vo6ijYd+Ih2P4qj5/GaEJ1C27zt+wrI5FC+SbIsvzebLCqLOxhaPHGMx2wkN43xpjjIJadFBkciFTldtbPlJ8geTINun3IldI3g6VsMh8sKZdUJiqP0lhUEEBzLnDYmWTrloiLlKoRHzB0VQLj4i0+F441/Eeo+8Vs0bca92Mygetr4dJ3vQkhbqVvVI2Eicv6UU4sxui5h0pvr8t8bflGA6A83g9J6SncJ71MvGtVTUqr712NdlVjuYOnWXsOQR+hYH+pBSrWjyJKdN17xFIvlLSV1ihQUZzUCf/LP+wzazZO08TLdvQb8VsK3K607jTzURaCgM1GflezP+mhxodEJ+5wcsEbC+9CZim9w9yGFIh/cL6d1iMAbGojVEfYEHxKI9fdpAeDJmX3/l2UsgjYPCGWGoA2dLkoSWNg+v4DrhcGtLv2UHaK/roCAzUj3GBuXyALq0gRpblcLSiTLHDpSQhCnlX2B96ILcnGQpjY02OBW8SGAUvZggEsOEZBmHbsdDvjh/Ei/DOv1bkpVXBaMtIUYOMpUYLpx99Nq7BaxkDxdyGWpF5H5c7KTBTEXz3fcnLGCWNrajPyoYVjWmAa4ILovfgYN9L4dBVLZWIrbHu0XeGjSH4cvscKW8S4rDLBLapt3tLkDFYvz1LRD/xlYd1ku6MvPpRg+9YsipMhMOUjGk6Pw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4410.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(8936002)(5660300002)(66476007)(66556008)(6636002)(83380400001)(186003)(2906002)(53546011)(6506007)(31696002)(66946007)(8676002)(86362001)(316002)(6486002)(36756003)(38100700002)(2616005)(508600001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUtHZXFPeitBZXdzQVJ4bVZCVmhwcXZsZ0hUMnc0bERIQlV5Qk9IWVZKRDZI?=
 =?utf-8?B?L2RhaFliU3JwYjMwU3MyTXJwSFN2RkhWWU9IcFo1OFZaMC9zbWFHa25oWTNF?=
 =?utf-8?B?d2ZuTjZENFZrM2s0NjRxSHRKeWZVYXprZmhDUmtkRzR6dUtGKzNKV3hmMWRJ?=
 =?utf-8?B?aUJJZjk2a1NHR3BQMjZQd0k2OWZiRHh6eEorOEJkMUNPSEFyaDJUTlVpVnBD?=
 =?utf-8?B?WGh5QkkzMVhHeEFkWW0xQjJyclY3cFVRZWt1cGNteUpCTE9OdVgrZG8wU1lW?=
 =?utf-8?B?dW1GNEhJWnJYT1h3aDhiZEQvMGFUNDVybjdQazNDd1ZlVGMzZjVRVmsxRVQx?=
 =?utf-8?B?Q3pQY1hBdVpFcmtXbGRqUU9iQ0tCMUQ4NkxQdTVOWlQvOE5QMjE2QUtzdzQ0?=
 =?utf-8?B?NEJwbnkxNWJhc2N1eVpQaXprZXhRc09aM2VSeGl6Vk5yTzZYc0RjYkxFRXBT?=
 =?utf-8?B?VTlhdHdSZlVnNEQySVd5Z2tEY2pORXhuL3IwUGFBY3QyZkZSKzlGa3p1RjNt?=
 =?utf-8?B?QVNvbTlCS3BvZmp6eVNPdnRvUnhOSWorL0dOUVhNTGFvdWlmNjZWbFZlN0Ev?=
 =?utf-8?B?a0M1Yk94d2VjTG1EZVV2Z1VhY0IvRHRsUklLclhVanRHOTVBdm1ZS0ZQaHpV?=
 =?utf-8?B?N1J1dGpvVm5tbHdmbEJ2Z09LS0w0RTFvaWcvUmdvenBKYlk2MytaYXBndmJY?=
 =?utf-8?B?cnVZWlhROEZPS0xzR2REb1g1THJMZ0wvblljeGdJYlVmdTFka1hsaTZrWFgw?=
 =?utf-8?B?QndjaEg0MHY2cGI1VEwwVGZwUzVTeWoyMEpqVGVFRG1yK1p5dDdsWkd6VFJU?=
 =?utf-8?B?eDFoSTVRNll1VUFMQkNxb3NiV2J3K3pJRjdab00vQTZZbDV6SkhpTnFNcjNM?=
 =?utf-8?B?MGhjdC9VVlVDZEpPZHViZCsweGdkeG45ck91cFBnNEVaeFhxRXMzdFdvdnVr?=
 =?utf-8?B?NElWekljaFFUemc2SWlDOGZmRmZ5SG0yRFpzdWxIaHJCVWRWY1dVSm9uYkxG?=
 =?utf-8?B?ZXBXSk5DT1BUMnpXM3loeGVzRG55aVppdENqYUVmYk11UTY4V00vNmZQZ251?=
 =?utf-8?B?U1E2b1IvcnpRUlQvUkxITThLSVRMTWVobU5xYmRoemh5VmJpUUJFYUJzeUsw?=
 =?utf-8?B?Z1FOWHNkZm5vakQ2bDFjdXhRWkhuYXRrVVNIZy90bW1CQ2QxcnB5Z21WdWRm?=
 =?utf-8?B?NlNlSWp5bzZPME5HcDA4VHdjSDVzY3ZYK3RPUW53Z1ZqQ2V3MlJKbm9ycnp6?=
 =?utf-8?B?NkNrV3Y4am5jVDZQdDZmR1UxWVVMeVplSFRSaUl5ZGJMWjdIUVdNRUdocktQ?=
 =?utf-8?B?dDJGTmx1UEozSGNOZmZUMHoxaDBFVWhRbmdUS3RXZzRuSnVHb3QxcHlzemtH?=
 =?utf-8?B?cmhoMWRrd3hISWt2SWFFbExSNVVXYUd5TXFJTEtkb2h1eUlrRVhhOVkzb09w?=
 =?utf-8?B?Y0tlYWxmZjEwRkYrMUlFcm5NcnVxZ2ZLT1ZJRWhhdlpJUUpVYUN4VlZWOU5X?=
 =?utf-8?B?ZWUwNkJ3Q3llcUlLTFRxWFdUR1dJK1V4YmFwRlpHaWwvMmprWjJiV3pZTktw?=
 =?utf-8?B?ZnRwZS9hekI0bStOdVBHakFtKzJUeVh5d0cwbW1hZEh3NzB2bzhxbWRJVXI1?=
 =?utf-8?B?cWtpeDc1WjFobVoyOHQ2WkYrMk9GQVViT2JKcE5FZEF5MXQ5VTMralppREgw?=
 =?utf-8?B?b1BmY0RMYzk5ZnNjR05Xa1dicVFWMVZYZENPaWhHTjVaSDkwUXViMmthSmsy?=
 =?utf-8?B?S2kxMGdXRzhQcS90K2E4SVlFckRMMUhWTHlZVkFhaFV4dEJjYnRKSk9YRy9q?=
 =?utf-8?B?RUY5ZUlraWppR0FnY08vRk5tRlJLbmxzQlVoeWJTS25KZ216bUUrVkoraUg4?=
 =?utf-8?B?eTAwQ1FjVTVBSUc2VTc0dGs2Q1g0M2FNTjNxNk5aUFlZMW82THI1Yk1UUVRU?=
 =?utf-8?B?LzJadWEzdkd2WktzOTBXZzVkNFAvd2RFaG8vYjFuTHBqWTRocjB1cmE3eS9P?=
 =?utf-8?B?SzRFVUVtMGZFWURhSExSL3N4czJjdG5Gc3J1UGRaNGhtWXlMOHNlcTl0OEYr?=
 =?utf-8?B?K09lYWVBVWYzMCtXSjBrK1U1T2ZhWUNsUkZVSDZuK242MlVoQ1krVHFyVTJj?=
 =?utf-8?Q?66F7m8ZkmGU20a+oO1JskDY6b?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c8db163-6f31-48b2-e5fb-08d9c0b97539
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4410.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 17:28:21.9097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k1eB/LCP66US20cVWmCS0p6B4wv4UpFeQnNTul01it+Ku1Gygo/6Xa94r8fDJ2fj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1295
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: ttb3i5K7gPehJmGeo3acrb7ZotQ83PL7
X-Proofpoint-GUID: ttb3i5K7gPehJmGeo3acrb7ZotQ83PL7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-16_05,2021-12-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112160098
X-FB-Internal: deliver
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On 12/15/21 11:30 PM, Zorro Lang wrote:
> On Tue, Nov 30, 2021 at 09:52:01PM -0800, Stefan Roesch wrote:
>> Summary:
>>
>> Liburing added support for setxattr. This change adds
>> support for this this in fsstress when fsstress is built
>> with liburing support.
>>
>> Signed-off-by: Stefan Roesch <shr@fb.com>
>> ---
>>  ltp/fsstress.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 57 insertions(+), 2 deletions(-)
>>
>> diff --git a/ltp/fsstress.c b/ltp/fsstress.c
>> index 003e0e49..aba7c6f7 100644
>> --- a/ltp/fsstress.c
>> +++ b/ltp/fsstress.c
>> @@ -145,12 +145,14 @@ typedef enum {
>>  	OP_URING_WRITE,
>>  	OP_WRITE,
>>  	OP_WRITEV,
>> +	OP_URING_SETXATTR,
>>  	OP_LAST
>>  } opty_t;
>>  
>>  typedef long long opnum_t;
>>  
>>  typedef void (*opfnc_t)(opnum_t, long);
>> +typedef int (*setxattr_cbk)(const char *, const char *, const void *, size_t, int);
>>  
>>  typedef struct opdesc {
>>  	opty_t	op;
>> @@ -277,6 +279,7 @@ void	uring_read_f(opnum_t, long);
>>  void	uring_write_f(opnum_t, long);
>>  void	write_f(opnum_t, long);
>>  void	writev_f(opnum_t, long);
>> +void	uring_setxattr_f(opnum_t, long);
>>  char	*xattr_flag_to_string(int);
>>  
>>  opdesc_t	ops[] = {
>> @@ -347,6 +350,7 @@ opdesc_t	ops[] = {
>>  	{ OP_URING_WRITE, "uring_write", uring_write_f, 1, 1 },
>>  	{ OP_WRITE, "write", write_f, 4, 1 },
>>  	{ OP_WRITEV, "writev", writev_f, 4, 1 },
>> +	{ OP_URING_SETXATTR, "uring_setxattr", uring_setxattr_f, 1, 1 },
> 
> Due to 160a3b4b4477 "(fsstress: consistently index the ops array by OP_ type)" has been
> merged, so this patchset might need to rebase on that.
> 
> Thanks,
> Zorro
> 

Zorro, thanks for notifying me. I rebased and sent out a new patch version.

>>  }, *ops_end;
>>  
>>  flist_t	flist[FT_nft] = {
>> @@ -4779,8 +4783,45 @@ setattr_f(opnum_t opno, long r)
>>  	close(fd);
>>  }
>>  
>> +static int
>> +io_uring_setxattr(const char *path, const char *name, const void *value, size_t size,
>> +	  	 int flags)
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
>> -setfattr_f(opnum_t opno, long r)
>> +setfattr_f_cbk(opnum_t opno, long r, setxattr_cbk cbk)
>>  {
>>  	int		e;
>>  	pathname_t	f;
>> @@ -4842,7 +4883,7 @@ setfattr_f(opnum_t opno, long r)
>>  		goto out;
>>  	}
>>  
>> -	e = setxattr(f.path, name, value, value_len, flag) < 0 ? errno : 0;
>> +	e = cbk(f.path, name, value, value_len, flag) < 0 ? errno : 0;
>>  	if (e == 0)
>>  		fep->xattr_counter++;
>>  	if (v)
>> @@ -4854,6 +4895,20 @@ out:
>>  	free_pathname(&f);
>>  }
>>  
>> +void
>> +uring_setxattr_f(opnum_t opno, long r)
>> +{
>> +#ifdef URING
>> +	setfattr_f_cbk(opno, r, io_uring_setxattr);
>> +#endif
>> +}
>> +
>> +void
>> +setfattr_f(opnum_t opno, long r)
>> +{
>> +	setfattr_f_cbk(opno, r, setxattr);
>> +}
>> +
>>  void
>>  snapshot_f(opnum_t opno, long r)
>>  {
>> -- 
>> 2.30.2
>>
> 

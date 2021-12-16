Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABBEC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 16 Dec 2021 18:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbhLPSoD (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 16 Dec 2021 13:44:03 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48828 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233118AbhLPSoC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 Dec 2021 13:44:02 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BGGgP6x022163;
        Thu, 16 Dec 2021 10:44:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=vqiVo88y6kc6NygsAnMGQpYTITcdKVzQdcSQVbqDDhc=;
 b=OIjqwadOHcyu5Es9gMjoHj+r0t+Ra+9rGkvk63/8saJ17UZ+8r7ePOpo5RmV9G493VPX
 vLt/N5oyb/CgNOiTva3DTQ2aAJqF1bHsQtPC60UEDMLUjHVRlRu3LWw185eRGNgEYPhu
 SGQe6oUMWTjfs1lCor8tWVz+/IuGKfamY0A= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3cyuqsx2ha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 16 Dec 2021 10:44:00 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 10:44:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eecG4KZ19OqOWzWGh7L8wmzG+IYkK3Siukb2hNnXXLOOTjp+e+iA+Tx8APm4hIvO820TYoN3wacz4w1qHQIdeAUzHjwnCkTC/ngzOFRwUTWZg3dE5dl4xnDEvJSdDeVyXraZT2rt/K96y7R4T/mYmxzQL2RGlvsIDhsANyHbw+YSZmU4g2NgrcydVRCNrWeu22Z9z7x2hKv6fwdI9c3QJ/4682rlvNJUNJHqORDz9eS7CtQDZ2GtcbZvzuxAWmVE9kwXNSzF0JgUCiLfWXmqzroRAEHPKTUw7Jj71lP9DyQW9j6e4QmOeHuQnfd/XSQvs0DWN1jPQZkl7iSHPXGa+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqiVo88y6kc6NygsAnMGQpYTITcdKVzQdcSQVbqDDhc=;
 b=HQCp5SdbtJUPWdMVU8xbqKZFDIm7NeJOoP6QHY7F4RqETnoVEeb7PYJmzHuMBqNIYSLXVD5nID4BoA6UUbEEnvFUVuxM9u6pYmhEzn04WSZ2OVc+FX42vELIOqb9hmO9IQug7D6ZVGJiPEhO+Y6G4fmrZ4s+fCYHkR2tZGF8GD29MCsvGYHHXMxLRt5Sdjny6YdfnsAPj2HH/09Ap12Ot2zzGRwdPOW1RFfyCDIYwda0EGwJ5scISzTLL3cq0gV/R8Y/u0dU2mUOVy6HrdCAQKupaPCPaA+pNCzkuBlUAeRsnRVg+mwxIk9p+dUTfXlDdAgbBokyeNP3hFtL1MRxkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4410.namprd15.prod.outlook.com (2603:10b6:303:bf::10)
 by MWHPR15MB1679.namprd15.prod.outlook.com (2603:10b6:300:127::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Thu, 16 Dec
 2021 18:43:59 +0000
Received: from MW4PR15MB4410.namprd15.prod.outlook.com
 ([fe80::989e:71eb:eac8:1f72]) by MW4PR15MB4410.namprd15.prod.outlook.com
 ([fe80::989e:71eb:eac8:1f72%5]) with mapi id 15.20.4778.019; Thu, 16 Dec 2021
 18:43:58 +0000
Message-ID: <77314344-5f7d-082f-1746-e97726d8259b@fb.com>
Date:   Thu, 16 Dec 2021 10:43:56 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v2 2/2] fstress: add suport for using liburing getxattr
Content-Language: en-US
To:     Eryu Guan <guaneryu@gmail.com>
CC:     <fstests@vger.kernel.org>, <kernel-team@fb.com>
References: <20211201055202.3142034-1-shr@fb.com>
 <20211201055202.3142034-3-shr@fb.com> <YbYQzuCotSQNkLK9@desktop>
From:   Stefan Roesch <shr@fb.com>
In-Reply-To: <YbYQzuCotSQNkLK9@desktop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR15CA0031.namprd15.prod.outlook.com
 (2603:10b6:300:ad::17) To MW4PR15MB4410.namprd15.prod.outlook.com
 (2603:10b6:303:bf::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91f1233d-2d4c-46d0-8565-08d9c0c4057e
X-MS-TrafficTypeDiagnostic: MWHPR15MB1679:EE_
X-Microsoft-Antispam-PRVS: <MWHPR15MB16790B1F32DC22C435E754C7D8779@MWHPR15MB1679.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:192;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l2WxEF4CnRZKpJj6V4P707PaJtCIW2Y9KDMro3gRv45W7vqJ8AOH0vGEqnBD2xC6+JMW2nWRv1GBSqpwB2Ulz5p+lRMTI6Ke1g5Z/P3zqywaGHYGAr6TQb9RrblRFiQA7Jo7Cnh0HT9KBG9rdwCa4IKGED0kTVYPz8D0rdrFQPBb313PppLZ2IVR4XrZqI/xZVlkZLB+5CLV8Mf/8QLyYLhsK3L68Xd7Kh6eN6FD13uDwcYcvQh6hrr/bJVfF8SbWHkSopTW1WkwhLcX5A2xQrpgqO+2l4mdFP+kXw7jK6Ae1bxsQ8u3ADw3isRNpjF/JzUVU3N7+VeQHjAvCpQsJ899SdFDNXeK3RoTW3PlwcCTuulSYA3kMz9ZaVOe/w9F/vI5WedqfwIMTEj1WN1xpv4chudZuRMEltzEz+lJNug/MOJA01GcZhZ8Aw7lmyf7cFOAUMKDWhwVclstJmhhdhkP4wF5TsFU3o+a1Dw0h/NvwmpxyvpjuOz1N1645zZr9zcacKs8ayJEArEMTUpOIFFIiqvrByQUiprzvKgrzqdc2GiL+FbtDRrX5qB4LH+j37FwO1bWGQWMFFj66HllxRbLdYqYgtXr0JYY+GuMqpyXNvLHX75spFGr29+ft8hDqODOEze3LILm+ILOU6tVxAveKZAUXB59bUZ8n5diaPWVLI/iLRPp2y+u3yCaFess1GHNhoW7EfhmuLYAB893U+95CkPpJB3n8/cckeFQ2IVB+A1zDx1Y9ZNLbR/uAUxo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4410.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(66946007)(6916009)(2616005)(66476007)(66556008)(5660300002)(508600001)(6486002)(6512007)(31686004)(2906002)(86362001)(4326008)(8936002)(8676002)(36756003)(186003)(53546011)(83380400001)(6506007)(31696002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVdYQTlwNHpjRXRxRU1aQnhCNmgyWXdSNGhDUmFCN2V5N3hncCtzY1FIRWxW?=
 =?utf-8?B?akVITTFXbGVjY1VaRkRZaEkyZEUzaVVPOVYzVVhFNWhFbitmUnNNbGNGL21Y?=
 =?utf-8?B?MWxhdllRa0FEdUMvUnBXVE8vNDc0WWRoMnlLQndmcmNWL1ltcndqRTdLbHpa?=
 =?utf-8?B?RUhiUFZwK0hHa0VWZTlVVVNkYmFjZVh1VlFxRWV3MEFaT1publBNOVlCOEgr?=
 =?utf-8?B?UThlVVNrY3d3c282dTJjMUVzNWRRZjVLbkRYMDZWYU81dkRnMUxiajJORXVz?=
 =?utf-8?B?K29GUlhzL0xLcWw4MXE0SHk3YkhoY3RNVFM4UUdMcmJvejJXaEdJY0RNdDVz?=
 =?utf-8?B?d3dpRlZGSDRyVDIvOW4zK2xnQ01QRE5WV1lRaXdKSUNxanB1TmFnQ0hQbE9M?=
 =?utf-8?B?eXZ2K1BLcVhOT3d2RitqTW9uaXV4Szc0cEc0TytmUVRWNHFoY0ZMTTBZMXZS?=
 =?utf-8?B?WmpaN0UzWlNYVmwzdDQzSTRub01OSytXWURQcGZUWEJIcVhOeW5qMnFPNWxY?=
 =?utf-8?B?bzVPd2xSNHRJdlFIajBhK1FKYW1iS1dUTHZ3SHR3T0h0TFo4VTNXVHE4R21P?=
 =?utf-8?B?N1JDRnU2NlZyK09TVWRuWnJORWd0cFlUVStSZnRSdFJINzdNMHlqQ1luSlc2?=
 =?utf-8?B?aWtJaE91cjJmSUh4TDhHZTFadHZyS1NMSzlYWFR6UitoVGlBdlVMU0xMUzhu?=
 =?utf-8?B?YUlTR2pDWUlPdVY3QmlmTDR6d09yZUg5TVIra2tWWDFDM1RsMFNQVmUvZlpZ?=
 =?utf-8?B?MSs3NGdsN1RTeWJ5Z3BJUjg0OFcxazVKQnNEVWhBV2Z2dWpHWUFUSlgwbmpY?=
 =?utf-8?B?N3VEUTE4UGo3ZjJYeC9pR084ZzNWZ0pGcko3N0lDelhCTUFXMExOdjVjL2d4?=
 =?utf-8?B?QjVScjZoQlJYeUlyS0VReWVZUFNCYXpUVnhubTkwMC96cG1uSlJpUWJJZWt6?=
 =?utf-8?B?Zi9FcjBuc2xmUWRBc29JeHVUekdJM2p2eG5iZ1BHUHM5QThVNFg1MzNCeVUv?=
 =?utf-8?B?Y2FiekR2Sjk3S1FWV2dxQk9UWEFaR1ZLM1k5K0lTV3JBVDV4M0ExRUZ1aXBY?=
 =?utf-8?B?OHdjZnZDalFFSGxSQTMyVllqQlpGblErRTZYVFhwaDIyT1RhQ2t2d01qQ3RQ?=
 =?utf-8?B?Y2xWSXppenM3RERzMXhCaS90WjZKUXNOSGcreGl4OXk0Q3FWRW54YXVoeWRQ?=
 =?utf-8?B?bmpDUHAyRWdLUktWS0twaTljT2svV0FZZFpiTGYwSlk2MmEvR1E1elRMZ1lq?=
 =?utf-8?B?UkxYRk1Zb2w2aWpLbXg0ZmV3UVV3N2ZqZ0ZUQXBoSEhhMUVsNlYyUE1MV3h5?=
 =?utf-8?B?d0pNZStUZHd1Zlk2WS9OdWJzcmF4ZFdPM2RLcCtJNFJUM05LRUxVWDUrR1hK?=
 =?utf-8?B?R0piSmtwQ0xmb0xWaktmb0dKMjhjWlN0RWhuTm9vQzZmMmhDWkJ1VEt0V0s0?=
 =?utf-8?B?MFN5YjY0Njk4YjFGNEhTU1hIUjJxM1ozb1RSNkh3MjUzeDJjVDAxU1BXcVdW?=
 =?utf-8?B?MTBxSFhBcXl2WkZuQnhsL3hSSzNWMUhNNy9pWWI4OE5zQXB2Nk5WbEtiSGds?=
 =?utf-8?B?YTJsUkN5bEEwbkdLSTlXU0xXcHFuVTAycksybUZUYlh0cDVTdXpuaGlJWkcy?=
 =?utf-8?B?N20xRzJzQWpOdHRkZWZXQVUrdnkrd2xZcVdGZGdVdklackhrME41YTBmclI3?=
 =?utf-8?B?RkpWaGp2TUdTSU5UNGVVa2Z6NVY1Z2VaMEFKNmo0OS9KeERkRk51dzNTTWd4?=
 =?utf-8?B?L0ZYeFBueklSYWRTTnRlTnFybitiTXJsWWl2S1VDbXpRUTBvb0oyU1N3TThQ?=
 =?utf-8?B?VXAzckFuNFIxYVJwWWFoOFNvRHJNRDVvTnpURzk3OFYvOFM5MEJFZ0RrU2lM?=
 =?utf-8?B?QUF6V1E2d3dON0QzdFRzRkphdkdEaHRoU0g2YTUxbGxVNldpWFZZRCsybVFX?=
 =?utf-8?B?M2dqbDk2Z0hSck1ENnlIU25hMEJvWS9uV0ticlhBUkhrV3c2SjVDbXhVWGw2?=
 =?utf-8?B?MUhCOW15YnU5Wm5PWngzSFhlMVdiWnp1aG5TT1pBN21FcDNHQzIrQ1hPc1di?=
 =?utf-8?B?VXo4MnJZVllpdm9tM2FJSDU2ZWk5NGN2Sk92UDZ4VitnZ0h4aVlXWkVlU1l4?=
 =?utf-8?B?LzY3NVF4KzduZG1rM1BGdmpWR2hrZE5XdmlnVXhJRWREc0xSNWs2alhlb3ov?=
 =?utf-8?B?TWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f1233d-2d4c-46d0-8565-08d9c0c4057e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4410.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 18:43:58.8873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OOF96IlZSv3XKFP3PGyXHmTnXtC/qCb7vecEq66yJpxXAKnQtpORbnCorDuyG+Am
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1679
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: _6TEykdiyFBjKUxVUaRlNFIWhdF_8790
X-Proofpoint-ORIG-GUID: _6TEykdiyFBjKUxVUaRlNFIWhdF_8790
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-16_06,2021-12-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 spamscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160104
X-FB-Internal: deliver
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On 12/12/21 7:10 AM, Eryu Guan wrote:
> On Tue, Nov 30, 2021 at 09:52:02PM -0800, Stefan Roesch wrote:
>> Liburing added support for getxattr. This change adds
>> support for this this in fsstress when fsstress is built
>> with liburing support.
>>
>> Signed-off-by: Stefan Roesch <shr@fb.com>
>> ---
>>  ltp/fsstress.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 59 insertions(+), 4 deletions(-)
>>
>> diff --git a/ltp/fsstress.c b/ltp/fsstress.c
>> index aba7c6f7..5a18701a 100644
>> --- a/ltp/fsstress.c
>> +++ b/ltp/fsstress.c
>> @@ -145,6 +145,7 @@ typedef enum {
>>  	OP_URING_WRITE,
>>  	OP_WRITE,
>>  	OP_WRITEV,
>> +	OP_URING_GETXATTR,
>>  	OP_URING_SETXATTR,
>>  	OP_LAST
>>  } opty_t;
>> @@ -152,6 +153,7 @@ typedef enum {
>>  typedef long long opnum_t;
>>  
>>  typedef void (*opfnc_t)(opnum_t, long);
>> +typedef ssize_t (*getxattr_cbk)(const char *, const char *, void *, size_t);
>>  typedef int (*setxattr_cbk)(const char *, const char *, const void *, size_t, int);
>>  
>>  typedef struct opdesc {
>> @@ -279,6 +281,7 @@ void	uring_read_f(opnum_t, long);
>>  void	uring_write_f(opnum_t, long);
>>  void	write_f(opnum_t, long);
>>  void	writev_f(opnum_t, long);
>> +void	uring_getxattr_f(opnum_t, long);
>>  void	uring_setxattr_f(opnum_t, long);
>>  char	*xattr_flag_to_string(int);
>>  
>> @@ -350,6 +353,7 @@ opdesc_t	ops[] = {
>>  	{ OP_URING_WRITE, "uring_write", uring_write_f, 1, 1 },
>>  	{ OP_WRITE, "write", write_f, 4, 1 },
>>  	{ OP_WRITEV, "writev", writev_f, 4, 1 },
>> +	{ OP_URING_GETXATTR, "uring_getxattr", uring_getxattr_f, 1, 0 },
>>  	{ OP_URING_SETXATTR, "uring_setxattr", uring_setxattr_f, 1, 1 },
>>  }, *ops_end;
>>  
>> @@ -3899,8 +3903,44 @@ getdents_f(opnum_t opno, long r)
>>  	closedir(dir);
>>  }
>>  
>> -void
>> -getfattr_f(opnum_t opno, long r)
>> +static ssize_t
>> +io_uring_getxattr(const char *path, const char *name, void *value, size_t size)
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
>> +	io_uring_prep_getxattr(sqe, name, value, path, size);
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
>> +static void
>> +getfattr_f_cbk(opnum_t opno, long r, getxattr_cbk cbk)
>>  {
>>  	fent_t	        *fep;
>>  	int		e;
>> @@ -3936,7 +3976,7 @@ getfattr_f(opnum_t opno, long r)
>>  		goto out;
>>  	}
>>  
>> -	value_len = getxattr(f.path, name, NULL, 0);
>> +        value_len = cbk(f.path, name, NULL, 0);
> 
> Use tab for indention here.
> 
> Thanks,
> Eryu
> 

Fixed with v4.

>>  	if (value_len < 0) {
>>  		if (v)
>>  			printf("%d/%lld: getfattr file %s name %s failed %d\n",
>> @@ -3958,7 +3998,8 @@ getfattr_f(opnum_t opno, long r)
>>  		goto out;
>>  	}
>>  
>> -	e = getxattr(f.path, name, value, value_len) < 0 ? errno : 0;
>> +	e = cbk(f.path, name, value, value_len) < 0 ? errno : 0;
>> +
>>  out_log:
>>  	if (v)
>>  		printf("%d/%lld: getfattr file %s name %s value length %d %d\n",
>> @@ -3968,6 +4009,20 @@ out:
>>  	free_pathname(&f);
>>  }
>>  
>> +void
>> +uring_getxattr_f(opnum_t opno, long r)
>> +{
>> +#ifdef URING
>> +	getfattr_f_cbk(opno, r, io_uring_getxattr);
>> +#endif
>> +}
>> +
>> +void
>> +getfattr_f(opnum_t opno, long r)
>> +{
>> +	getfattr_f_cbk(opno, r, getxattr);
>> +}
>> +
>>  void
>>  link_f(opnum_t opno, long r)
>>  {
>> -- 
>> 2.30.2

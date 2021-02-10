Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AED0C433E9
	for <linux-fstests@archiver.kernel.org>; Wed, 10 Feb 2021 09:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22C4C64E40
	for <linux-fstests@archiver.kernel.org>; Wed, 10 Feb 2021 09:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhBJJyx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 10 Feb 2021 04:54:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24836 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230173AbhBJJws (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 10 Feb 2021 04:52:48 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11A9XpGV190106;
        Wed, 10 Feb 2021 04:52:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=6bXW2xMu83BL0NojNhlD2saWr7KSBhLhUnD/rHD/0Qs=;
 b=XtBRAwUfY01dM1qanp+hW+89piXZuj4wVsM/NAle6ER9U15dg0IWm65vPfhyTWIZl3GO
 EGiyz8XOVcKbZs+W9o7xzbHNTVH4rr4Qca3zVdvlxtB+mUfsm7DtXAgeZxsqHtcmr4fl
 gVH3nUazMpUuDcaiUMuV0YHVK6E7t6lsF+Dz68x845iPoz97gG6BkvPOGym+mBWOZjFB
 HlcRtwN8mPt19i3pUptdPubru64fsDCBjA58Hgg0dq9CgPvDj9Q6XcsGZCVnFmZATE8O
 8nfsUwfcuY7F+LsNZHhXnrmC8UX4hhBy7+ntLPosYPRkg5lKW1CIYayT3dugWFySq3z6 zg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36mbtkaeup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 04:52:03 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11A9hIgL003420;
        Wed, 10 Feb 2021 09:52:02 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 36j94wku72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 09:52:01 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11A9pnaV34537924
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 09:51:49 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFF67A405B;
        Wed, 10 Feb 2021 09:51:59 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 357DBA4053;
        Wed, 10 Feb 2021 09:51:59 +0000 (GMT)
Received: from [9.199.35.2] (unknown [9.199.35.2])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 10 Feb 2021 09:51:59 +0000 (GMT)
Subject: Re: [PATCH ] check: add CLI option to repeat and stop tests in case
 of failure
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org, anju@linux.vnet.ibm.com
References: <56a687e167af434fa54429558164ff7fee32c67d.1611823132.git.riteshh@linux.ibm.com>
 <20210131150311.GE2350@desktop>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Message-ID: <0566b9ab-6e5d-80b5-070e-33a6de6dca3d@linux.ibm.com>
Date:   Wed, 10 Feb 2021 15:21:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210131150311.GE2350@desktop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-10_02:2021-02-09,2021-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 mlxlogscore=999 clxscore=1011 priorityscore=1501 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100093
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On 1/31/21 8:33 PM, Eryu Guan wrote:
> On Thu, Jan 28, 2021 at 02:19:41PM +0530, Ritesh Harjani wrote:
>> Currently with -i <n> option the test can run for many iterations,
>> but in case if we want to stop the iteration in case of a failure,
>> it is much easier to have such an option which could check the failed
>> status and stop the test from further proceeding.
>>
>> This patch adds such an option thereby extending the -i <n> option
>> functionality.
>>
>> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
>> ---
>>   check | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/check b/check
>> index c6ad1d6c0733..6f3a5d47e212 100755
>> --- a/check
>> +++ b/check
>> @@ -15,6 +15,7 @@ sum_bad=0
>>   bad=""
>>   n_notrun=0
>>   notrun=""
>> +tc_status=""
>>   interrupt=true
>>   diff="diff -u"
>>   showme=false
>> @@ -27,6 +28,7 @@ brief_test_summary=false
>>   do_report=false
>>   DUMP_OUTPUT=false
>>   iterations=1
>> +istop=false
>>
>>   # This is a global variable used to pass test failure text to reporting gunk
>>   _err_msg=""
>> @@ -68,6 +70,7 @@ check options
>>       -T			output timestamps
>>       -r			randomize test order
>>       -i <n>		iterate the test list <n> times
>> +    -istop <n>		iterate the test list <n> times, but stops iterating further in case of any test failure
> 
> Perhaps '-I' is a better option?

Sure, will change it.

> 
>>       -d			dump test output to stdout
>>       -b			brief test summary
>>       -R fmt[,fmt]	generate report in formats specified. Supported format: [xunit]
>> @@ -300,6 +303,7 @@ while [ $# -gt 0 ]; do
>>   	-n)	showme=true ;;
>>           -r)	randomize=true ;;
>>   	-i)	iterations=$2; shift ;;
>> +	-istop) iterations=$2; istop=true; shift ;;
> 
> Same here.

yes.

> 
>>   	-T)	timestamp=true ;;
>>   	-d)	DUMP_OUTPUT=true ;;
>>   	-b)	brief_test_summary=true;;
>> @@ -926,6 +930,11 @@ function run_section()
>>   for ((iters = 0; iters < $iterations; iters++)) do
>>   	for section in $HOST_OPTIONS_SECTIONS; do
>>   		run_section $section
>> +		if [ "$tc_status" = "fail" ] && [ "$istop" = true ]; then
> 
> $tc_status only records the status of last test in the test list, and if
> the last test passed, the iteration continues. e.g. I tested
> generic/00[12], and generic/001 fails while generic/002 passes
> 
>    ./check -i 2 generic/001 generic/002
> 
> check still run 2 iterations as "tc_status" of generic/002 is not
> "fail".
> 
> I think we could check $sum_bad is 0 or not.

Yes, right. Thanks for pointing it out.

I will address these comments and spin a v2.

-ritesh

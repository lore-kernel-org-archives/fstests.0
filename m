Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DF84D109
	for <fstests@vger.kernel.org>; Tue, 26 Dec 2023 08:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hNviSpW8"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BQ81Asq028617;
	Tue, 26 Dec 2023 08:44:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=UnilGA91H2OJVlilqtPYcajFXVcgOimilaxJp+3xzz4=;
 b=hNviSpW8T+f42Bq4cBpwemLKbpg9Q/HF65aKpyAUbbZyfEq2RNaWeU5GGXDXMz8+9udf
 GmILTI1Fug/2Ok+1h98TOefspdf99pi3RHfhDqU/4gDl4QjV4OfW6h4zbV2qv4HZuQY5
 6vYWpJLwDopvZCwvWC9Hyjd5yEBhVyPz9sSOxGaw5NOJC4RDBjaBfE/n7aeGC/pV+qbp
 W+u6EUz0melNAyL+LhFlBEFy4KT66C0YYoAGP2HPS7aaGhFPOEEV+ID/XcRyyM6jR8wZ
 SHQZmdJb5oeagfFJVVFZknpi61ZZEcJ1QW87PLwZm7CqlzhDJa8ABTWj0KtRWYrjkVh+ IQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v6rpfnur9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Dec 2023 08:44:44 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BQ8duWK014333;
	Tue, 26 Dec 2023 08:44:44 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v6rpfnur1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Dec 2023 08:44:44 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BQ6oRlq008395;
	Tue, 26 Dec 2023 08:44:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3v69vskw68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Dec 2023 08:44:43 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BQ8ifFJ15598162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Dec 2023 08:44:41 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8583D20043;
	Tue, 26 Dec 2023 08:44:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56B0520040;
	Tue, 26 Dec 2023 08:44:40 +0000 (GMT)
Received: from [9.43.26.249] (unknown [9.43.26.249])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 Dec 2023 08:44:40 +0000 (GMT)
Message-ID: <6aff22ec-f072-48f5-997f-9ef6a951a0e0@linux.ibm.com>
Date: Tue, 26 Dec 2023 14:14:38 +0530
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xfstests: replace custom __u64 definition with uint64_t
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, ojaswin@linux.ibm.com, ritesh.list@gmail.com
References: <20231221061231.44347-1-disgoel@linux.ibm.com>
 <20231221171247.GB108281@frogsfrogsfrogs>
Content-Language: en-GB
From: Disha Goel <disgoel@linux.ibm.com>
In-Reply-To: <20231221171247.GB108281@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: L1om_8Kscqkd98dlF-D9FTGvpjJMha19
X-Proofpoint-ORIG-GUID: -OLZdpGkIt_Nshhk-GePEWHPhKNeqlez
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-26_04,2023-12-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 clxscore=1011 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312260063

On 21/12/23 10:42 pm, Darrick J. Wong wrote:

> On Thu, Dec 21, 2023 at 11:42:31AM +0530, Disha Goel wrote:
>> In some distributions, __u64 is already defined in system header files,
>> causing compilation errors when building xfstest.
>>
>> 	# make
>> 	    [CC]    ext4_resize
>> 	ext4_resize.c:17:28: error: conflicting types for '__u64'
>> 	 typedef unsigned long long __u64;
>> 	                            ^~~~~
>> 	In file included from /usr/include/asm/types.h:26:0,
>> 	                 from /usr/include/linux/types.h:5,
>> 	                 from /usr/include/linux/mount.h:4,
>> 	                 from /usr/include/sys/mount.h:32,
>> 	                 from ext4_resize.c:15:
>> 	/usr/include/asm-generic/int-l64.h:30:23: note: previous declaration of '__u64' was here
>> 	 typedef unsigned long __u64;
>>                         ^~~~~
>>
>> To address this issue, replace the custom definition of __u64 with the
>> standard uint64_t type from <stdint.h>. uint64_t is part of the C99
>> standard, offering a standardised approach for representing unsigned
>> 64-bit integers. This modification enhances code consistency and
>> ensures compatibility with standard types.
> ...but isn't consistent with the definition in the kernel uapi headers.
> ioctls explicitly use __u64, not uint64_t, and there are a few arches
> (apparently) where __u64 ends up an unsigned long long but uint64_t ends
> up an unsigned long, and the reverse.

Thanks for reviewing the patch. I will take care of this and address in v2.

>> Tested on various distributions on Power architecture, by successfully
>> compiling xfstest. Additionally, verified the compatibility by running
>> ext4/033 and ext4/056 tests, both of which use ext4_resize and
>> observed successful test execution.
>>
>>          # make
>>              [CC]    detached_mounts_propagation
>>              [CC]    ext4_resize
>>              [CC]    t_readdir_3
>>
>> Signed-off-by: Disha Goel <disgoel@linux.ibm.com>
>> ---
>>   src/ext4_resize.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/src/ext4_resize.c b/src/ext4_resize.c
>> index 78b66432..6e60ee5b 100644
>> --- a/src/ext4_resize.c
>> +++ b/src/ext4_resize.c
>> @@ -14,10 +14,8 @@
>>   #include <sys/ioctl.h>
>>   #include <sys/mount.h>
> Why not #include <linux/ext4.h>, which gets you both the __u64 typedef
> and EXT4_IOC_RESIZE_FS?
>
> --D
>
The #include <linux/ext4.h> got added in kernel 6.4 and distros which
I'm testing does not have <linux/ext4.h> present in kernel headers.
We can add #include <linux/types.h> which also gets the __u64 typedef.

Let me know your thoughts.

>>   
>> -typedef unsigned long long __u64;
>> -
>>   #ifndef EXT4_IOC_RESIZE_FS
>> -#define EXT4_IOC_RESIZE_FS		_IOW('f', 16, __u64)
>> +#define EXT4_IOC_RESIZE_FS		_IOW('f', 16, uint64_t)
>>   #endif
>>   
>>   #define pr_error(fmt, ...) do { \
>> @@ -31,7 +29,7 @@ static void usage(void)
>>   
>>   int main(int argc, char **argv)
>>   {
>> -	__u64	new_size;
>> +	uint64_t	new_size;
>>   	int	error, fd;
>>   	char	*mnt_dir = NULL, *tmp = NULL;
>>   
>> -- 
>> 2.39.1
>>
>>

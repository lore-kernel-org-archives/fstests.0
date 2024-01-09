Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AB8360AE
	for <fstests@vger.kernel.org>; Tue,  9 Jan 2024 11:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VFJBIpwe"
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 409BCBxf027804;
	Tue, 9 Jan 2024 11:15:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=4ysfPamaRyLCFCtMqA7Mecaq4lZoIhOMNC7bSaVu4/o=;
 b=VFJBIpwelERJ0+YcunUAiIODgvySyrLCY2ySmR3Ss29tK5Sjl+ZPUq91hOU2aAoFnZ8r
 OLKxRzUDSLDPXTKSLMJwrxmlEVkJsYrZh4lmmCbGfTlzp7kWBM7MItvyO25maOyeBxbE
 xmIL9F4UHxzMrAOYOTmt4uzCUG/AafeGhi1TP+Y5cWKZxCvW0xVG+l1Ik3yIisieJO2K
 2ShoBv50gPbbnh4V6M9FT6lG3CaVOXkiPXJXcEkP4exYTYP13gYxHOdgzAZ3jEETHQpU
 NgzbowV2nmdQMv8WoMWzzcSYXVQ0Hy7DUhSMMPI33yqdaeVHz3C+hto8nZN8LpvJShxv PQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vh52b03y8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 11:15:58 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 409BCZoN028935;
	Tue, 9 Jan 2024 11:15:57 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vh52b03xt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 11:15:57 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 409BAJ5x004388;
	Tue, 9 Jan 2024 11:15:56 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vfjpkp2k9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 11:15:56 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 409BFsgN590498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jan 2024 11:15:54 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16FF620040;
	Tue,  9 Jan 2024 11:15:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9963620043;
	Tue,  9 Jan 2024 11:15:52 +0000 (GMT)
Received: from [9.43.53.108] (unknown [9.43.53.108])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jan 2024 11:15:52 +0000 (GMT)
Message-ID: <8d5d57da-0140-41a1-b708-0275124096e0@linux.ibm.com>
Date: Tue, 9 Jan 2024 16:45:51 +0530
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xfstest: add detection for ext4.h presence in
 configure.ac
Content-Language: en-GB
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, ojaswin@linux.ibm.com, ritesh.list@gmail.com
References: <20240103184208.80772-1-disgoel@linux.ibm.com>
 <20240104181213.GE241128@frogsfrogsfrogs>
From: Disha Goel <disgoel@linux.ibm.com>
In-Reply-To: <20240104181213.GE241128@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WESczbpLtNsqi_H_ORTlHmsMilLzxhRP
X-Proofpoint-GUID: JrG604XyrxE-MkKtGYh1jrKadhYTtcDC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-09_04,2024-01-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=671
 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 priorityscore=1501 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401090091

On 04/01/24 11:42 pm, Darrick J. Wong wrote:

>>   configure.ac      | 8 ++++++++
>>   src/ext4_resize.c | 6 +++++-
>>   2 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/configure.ac b/configure.ac
>> index b22fc52b..76378e6d 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -35,6 +35,14 @@ AC_CHECK_HEADERS([	assert.h		\
>>   			sys/mman.h		\
>>   ])
>>   
>> +AC_COMPILE_IFELSE([
>> +    AC_LANG_PROGRAM([#include <linux/ext4.h>], [])
>> +], [
>> +    AC_DEFINE([HAVE_LINUX_EXT4_H], [1], [Define if ext4.h is present])
>> +], [
>> +    AC_MSG_WARN([ext4.h not found or not compilable.])
>> +])
> AC_CHECK_HEADERS does this.
>
>> +
>>   AC_CHECK_HEADERS([xfs/xfs_log_format.h],,,[
>>   #define _GNU_SOURCE
>>   #include <xfs/libxfs.h>])
>> diff --git a/src/ext4_resize.c b/src/ext4_resize.c
>> index 78b66432..51bd8d78 100644
>> --- a/src/ext4_resize.c
>> +++ b/src/ext4_resize.c
>> @@ -14,7 +14,11 @@
>>   #include <sys/ioctl.h>
>>   #include <sys/mount.h>
>>   
>> -typedef unsigned long long __u64;
>> +#ifdef HAVE_LINUX_EXT4_H
>> +#include <linux/ext4.h>
>> +#else
>> +#include <linux/types.h>
> You might as well include this unconditionally; there's no penalty
> for including it multiple times.
>
> --D

Thanks for reviewing the patch. I have addressed this in v3.

Thanks

>> +#endif
>>   
>>   #ifndef EXT4_IOC_RESIZE_FS
>>   #define EXT4_IOC_RESIZE_FS		_IOW('f', 16, __u64)
>> -- 
>> 2.39.1
>>

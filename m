Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4F019447
	for <fstests@vger.kernel.org>; Wed,  3 Jan 2024 12:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iJg5u7jG"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 403AKv26029337;
	Wed, 3 Jan 2024 12:20:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=FWfOdmctbJj7/7cBrcA/ApeWr5vjLOxSFxH6lvpyiM0=;
 b=iJg5u7jGopwKmjc64UiPIG0wmuTadRNnYgspNLFIu47u/l+90dnuM5X1MxlwcxZX7Z6L
 I99E/fRcDVOhyTG2Yql9PrLeaR+jUo3NOCddEjuMSxRwyIF3Q+I+FlvQ4uZxFbBNbahs
 yqdUWfpxLIG08Pnx22kc3qVU7RbI1iy/wko902cyOjkq2IEysu5P1OtaoohbF19BF5ZL
 Gx7tN8ugGQm4zJPIA1hqRvafb4GH47872E0cQgf1eblaQPL9HfPI8Xqpraise2bbdkkb
 iTaliYneOMxeInOYAPb7BrAA2XsFFLECpTdD2iRHqF076BQKi5jVbxn0IT4q8QQMHyvD YA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vd3jp26e6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 12:20:20 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 403CJXtL029260;
	Wed, 3 Jan 2024 12:20:20 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vd3jp26dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 12:20:20 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 403AZnsn017834;
	Wed, 3 Jan 2024 12:20:18 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vawwytwhr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 12:20:18 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 403CKG2518285204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jan 2024 12:20:16 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE91B20040;
	Wed,  3 Jan 2024 12:20:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25C2F20043;
	Wed,  3 Jan 2024 12:20:15 +0000 (GMT)
Received: from [9.43.60.197] (unknown [9.43.60.197])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jan 2024 12:20:14 +0000 (GMT)
Message-ID: <b85e2842-1a59-4760-881b-5468b2cfe212@linux.ibm.com>
Date: Wed, 3 Jan 2024 17:50:13 +0530
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xfstests: replace custom __u64 definition with uint64_t
Content-Language: en-GB
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, ojaswin@linux.ibm.com, ritesh.list@gmail.com
References: <20231221061231.44347-1-disgoel@linux.ibm.com>
 <20231221171247.GB108281@frogsfrogsfrogs>
 <6aff22ec-f072-48f5-997f-9ef6a951a0e0@linux.ibm.com>
 <20231226175233.GC108281@frogsfrogsfrogs>
From: Disha Goel <disgoel@linux.ibm.com>
In-Reply-To: <20231226175233.GC108281@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KbPYDDUTKInJOkksQXqVVnIswCsj7mx_
X-Proofpoint-ORIG-GUID: hI_vD5jTm869mK1bTQV8gX_Jd2Qp3J1W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_06,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=316 spamscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401030102

On 26/12/23 11:22 pm, Darrick J. Wong wrote:

> Ah, linux/ext4.h didn't exist until 6.4.  Heh.  Well, in the long run
> fstests really ought to pull in kernel ioctl definitions whenever
> possible.  So:
>
> I suppose this program should #include <linux/types.h> to get the __u64
> definition, after which this can go away:
>
>>>> -typedef unsigned long long __u64;
> And then you'd need to add some m4/autoconf AC_CHECK_HEADERS magic for
> configure to detect when #include <linux/ext4.h> actually results in a
> compilable program; and set some make variable accordingly.
>
> Then this program can grow a:
>
> #ifdef HAVE_LINUX_EXT4_H
> # include <linux/ext4.h>
> #endif
>
> After which this existing bit of cpp magic:
>
> #ifndef EXT4_IOC_RESIZE_FS
> # define EXT4_IOC_RESIZE_FS			_IOW('f', 16, __u64)
> #endif
>
> should work for everyone.
>
> --D

Sure, will address the changes in v2.

Thanks


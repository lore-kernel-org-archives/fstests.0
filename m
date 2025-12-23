Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490392E8B74
	for <fstests@vger.kernel.org>; Tue, 23 Dec 2025 08:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766479786; cv=none; b=ODU6ehvqSlrbN1mMNAN8fN4WXflUBbHKebeqXdb7EWrPQXp1Dm6Dnxo2n7bCV+Inf4wghzIfxwwL78b7dp2p1OT6MAIM9uUWXx4kKG2MqjR4WTWA5sytQaFECmFeX6Jinq0jtBMavR4j754h41HzEo6a9rYlL90Cn25bedIbG5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766479786; c=relaxed/simple;
	bh=bw63hmm4WBfVd813kPWKauftYM2k1+OdQg3giWMQ05Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DhaTLqQRyQOZedL9pViOJZ/VGfVtxlDzUdKnrXqxZwOlk+97OQsVIKrVuCVTrtfhH/bMH7Vz8Tqbi6ulHWxo9SI5YOyXyF6e7MuweNSF85jiy4WgKzwBgSM80j6C87SNaFDpl5amkyjI4w4fE/hZRbclpn8yfvNzSfwP5Y5dYTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Uvx9Zwab; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Uvx9Zwab"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BN8EAjj016646;
	Tue, 23 Dec 2025 08:49:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HLSm1D
	6v1MQHc9hlREZh1AwUoTbW1xcpBdU2ZsGtbzU=; b=Uvx9ZwabCjWnKRtiEDMEmo
	eU6OfpLWcKvDmcjpbpQFRCkJUnGNqOY46WMGez4x3ISR1PyZNCUevo/NWgz80nKf
	DUs5yOFWuleRNCSYeaGpdydJv6jQRlntAL7PXGnYbmsOXwLAXbuoqUCPMcSOFpz8
	9Pe6aoJNARCX82XYq7e6f565at8ToMjBdGrHsxDIWAKld/yOnzU8Acgn91Wh/DJL
	QCIFXnTdLp6m9Z7FM9Fkvk5IqEpId1zXn5jmXoomxYrTNk/RGZtt29misFVwhu8E
	2Y7Dqm6hra1anEfsayMjEa6DmeHFB+hher0EVI1sbpjqBwLvWea9biQXXpQ8dlqw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5ketufv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Dec 2025 08:49:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BN5RUYJ004192;
	Tue, 23 Dec 2025 08:49:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b674mtbqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Dec 2025 08:49:35 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BN8nV4a58917250
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Dec 2025 08:49:31 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54A6320043;
	Tue, 23 Dec 2025 08:49:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF0DB20040;
	Tue, 23 Dec 2025 08:49:30 +0000 (GMT)
Received: from [9.39.24.113] (unknown [9.39.24.113])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Dec 2025 08:49:30 +0000 (GMT)
Message-ID: <1d4c911a-fce6-4b84-a2d4-0729a038393b@linux.ibm.com>
Date: Tue, 23 Dec 2025 14:19:29 +0530
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] generic/108: fix test hand upon failure to create LV
Content-Language: en-GB
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org
References: <79202ac8855a232c678bb9bddabda8c1866bc400.1766387606.git.ojaswin@linux.ibm.com>
 <aUl43EdYJK-Tb2Y0@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
From: Disha Goel <disgoel@linux.ibm.com>
In-Reply-To: <aUl43EdYJK-Tb2Y0@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XxSAuwxMLIxEmzgcVUYl9lI21PsdNORH
X-Authority-Analysis: v=2.4 cv=Qdxrf8bv c=1 sm=1 tr=0 ts=694a57a0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=YfDc65UHFS09e2AHyuYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: XxSAuwxMLIxEmzgcVUYl9lI21PsdNORH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDA3MiBTYWx0ZWRfX9y4htJDnub+j
 fCTYGS5kobseJuuSGcoKVgxC6/4c1hIMflr03+gz80s8Ol6ZcKlORs8o2U4FzMXJq1VhOXFcFEP
 1RHu57UT7RmYT86adDdrQjR88eNnKyNUNBgLs1RlFACUdtw1fxzGbR8FHt28U28lsfI/bJSDfwJ
 DJE+zpZktHmUVgN/1WN+AAr7GCmf0EAjT55+nUIJfw6xQh7zpHr5wOZxL5YX1x2oBfL1I/yPWHj
 rNSWYyY3AZe4PzqoTQ3SJEfhT53Th57ZLF5GezuX/5C9oMtJvbn/KAlHIxT2YEXCmhoiWAafxS+
 LapevW5pJNtqDeow039JAevxbPtQomUoPxmWkij+Qk5sCVrbU6T5ucocXEyabNg3UnFZyCF4h1/
 n07xfLZiH/mtR0APy1fS6Bs1fVG4VjeN9wLL0IRAC0m7MoTPyt+3A8WGar/O3RU9+1vgjflYkH4
 2pI/deLZ275Qhih2Xtw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_02,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1011
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2512230072

On 22/12/25 10:29 pm, Ojaswin Mujoo wrote:
> On Mon, Dec 22, 2025 at 12:44:09PM +0530, Ojaswin Mujoo wrote:
>> In case the lvcreate operation fails, we don't catch the error and
>> proceed as usual. The test then tries to wait for the LV to come up
>> but it never does, causing a hang.
>>
>> Fix this by catching any errors while creating the LV.
>>
>> Context for completeness:
>>
>> This was noticed when we accidentally used CONFIG_SCSI_DEBUG=y instead
>> of =m, causing it to create an 8MB SCSI debug device. This led to the
>> lvcreate operation to fail with:
>>
>>    Insufficient suitable allocatable extents for logical volume lv_108: 68 more required
>>
>> However the test never caught this resulting in a hang.
>>
>> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Patch looks good to me.

Tested-by & Reviewed-by: Disha Goel <disgoel@linux.ibm.com>

> 
> Missed to add (hope this gets auto picked up during merge :) ):
> 
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> 
> Regards,
> ojaswin
> 
>> ---
>>   tests/generic/108 | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/generic/108 b/tests/generic/108
>> index 4f86ec94..308afe20 100755
>> --- a/tests/generic/108
>> +++ b/tests/generic/108
>> @@ -60,7 +60,7 @@ $LVM_PROG vgcreate -f $vgname $SCSI_DEBUG_DEV $SCRATCH_DEV >>$seqres.full 2>&1
>>   # We use yes pipe instead of 'lvcreate --yes' because old version of lvm
>>   # (like 2.02.95 in RHEL6) don't support --yes option
>>   yes | $LVM_PROG lvcreate -i 2 -I 4m -L ${lvsize}m -n $lvname $vgname \
>> -	>>$seqres.full 2>&1
>> +	>>$seqres.full 2>&1 || _notrun "Failed to create LVM lv"
>>   _udev_wait /dev/mapper/$vgname-$lvname
>>   
>>   # _mkfs_dev exits the test on failure, this makes sure test lv is created by
>> -- 
>> 2.51.0
>>
> 


Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB822BE7D6
	for <fstests@vger.kernel.org>; Tue, 13 Jan 2026 11:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768302661; cv=none; b=oaBahWsxYGCw4rGwAYby3ZL8ukcFwnB8L93lLvZzgCP5kv4kaXtJpBkdda8jeoCWx3CNJtrKtDO1rzgsmCYwb1uWGD7hbgKCZpSJnRovz/aqm6pE256LeQZwhGAh2m4RuQPqe6ZmKPJ75G13J0/HEORzU3RKXSmN6ebASEojQ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768302661; c=relaxed/simple;
	bh=Ht9mPiTq7K1d2TuwVPJkkN0u9evoSTBmHHtYoYbv+yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=E0v++wpRjdlRIiB74wLuPbZUHMjxGZoalHHysi+lpdBp9joCXuNBSsS7f0XWXhtS2qNHf5LmQYFAVKhaMirpCcnijy583AASKAfNOztJLAUIB3GXZS9AterRsItnJ4IEJkuSy9DaczSTUlZ+eUYwuhLETxDaMge+sVZ5ROng/KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C+E3xRmN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C+E3xRmN"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60D1WnfP002417;
	Tue, 13 Jan 2026 11:10:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Cfrsrt
	nu3kF8zxToRzKqHQzZfXifqnflJhAbDDvhCU0=; b=C+E3xRmN1Nfz9id6zwEx/g
	Lz0v9pH05zkV+F51EZuShS//0uQB0kq75FchWz/RwOd+NBEiRoFMwvCtPjm7U4I/
	6fCFg43ngZ+TMTvOTSAQWjjj1kGgGWfyRFdqIIIvOkah0aT5BNyG+YC5UpmZeY3R
	AhQRlSUb5Ubbs8RH2jzMu0opjSfvXLnjJ5R21qJQZovCPP1FeN53PI4skUxve/qy
	k1G99BKXYTDKdwR4wDew3Oq2he3y0VtpWE31QyiDj31nElJ7K7QAMczxBHFOP/Xk
	ve0NG/BGTJl2qkSxQVvGZQw/4Z3n47P3afRau+SVufoootKSfR7dD8vZ8J6QIRzA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkeepv1yc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 11:10:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60DB9eJo031273;
	Tue, 13 Jan 2026 11:10:56 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bm3t1kbsm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 11:10:56 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60DBArBl43581782
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 11:10:53 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 156102004B;
	Tue, 13 Jan 2026 11:10:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B20220040;
	Tue, 13 Jan 2026 11:10:52 +0000 (GMT)
Received: from [9.39.19.17] (unknown [9.39.19.17])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Jan 2026 11:10:52 +0000 (GMT)
Message-ID: <670b5716-126e-4e7a-8034-6160a2e67d86@linux.ibm.com>
Date: Tue, 13 Jan 2026 16:40:51 +0530
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] generic/108: fix test hand upon failure to create LV
Content-Language: en-GB
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org
References: <98f8ef5ff92632a0be336a563ebda36cfe898348.1767782181.git.ojaswin@linux.ibm.com>
From: Disha Goel <disgoel@linux.ibm.com>
In-Reply-To: <98f8ef5ff92632a0be336a563ebda36cfe898348.1767782181.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=DI6CIiNb c=1 sm=1 tr=0 ts=69662841 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=gdfrYlAiTUxu6vfEW4IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: kQN7XRF6DGWbuqfxJV7J8E8QSmmf6d8C
X-Proofpoint-ORIG-GUID: kQN7XRF6DGWbuqfxJV7J8E8QSmmf6d8C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA5MSBTYWx0ZWRfX7YNA+kVsQQgK
 N8xAJqcAErEFj416C2tYNxBMfsIbsShrt1/+lJ5Dt4JSylOSKq/33on3U3aIOHpmzhLdb6ZQ4FK
 mrG7+vVyjX6L3MPFtvkcojbZrYHkVheKWTLTgVqhZBCvnYARO01b4AMPN50qOeADRhZajr4OGCi
 mktD9ZMQ8Y9Nv0r7UT9bQMzKhCYVxVrZvQUOSfpnWJnQyia4Kw856scIElR3203J+2EVzL6e8rE
 HAQHTLgCXeMrMuCpeJCAJ0uChycda3y7fjqrm6cXLP1lWIXEXtAnIgRGTA8wqXTaL6VEMcvIQt5
 32maAtB2y7k9afO/HRutyyaq1K3hYnBByZOc7YKlO11huBymFfqQyfPLBwHH085bqbygqha4fsA
 nBLoCQZ/rttrmYyx7RMFdn5h7hcAtIT05vtuFP0qXb9gEE/RLWWuw/ja8DuZ+eQgpZKqsKiPHR5
 PcDMWL1RlNym3/7Qisg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601130091

On 07/01/26 4:07 pm, Ojaswin Mujoo wrote:
> In case the lvcreate operation fails, we don't catch the error and
> proceed as usual. The test then tries to wait for the LV to come up
> but it never does, causing a hang.
> 
> To fix this:
> 1. Add a check to ensure SCSI_DEBUG dev is of required size
> 2. Additionally, fail if there are errors while creating the LV.
> 
> Context for completeness:
> 
> This was noticed when we accidentally used CONFIG_SCSI_DEBUG=y instead
> of =m, causing it to create an 8MB SCSI debug device. This led to the
> lvcreate operation to fail with:
> 
>    Insufficient suitable allocatable extents for logical volume lv_108: 68 more required
> 
> However the test never caught this resulting in a hang.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Reported-by: Disha Goel <disgoel@linux.ibm.com>

Looks good to me. The changes correctly handle the lvcreate failure 
scenario and add a proper size check for the SCSI debug device, 
preventing the hang we observed earlier. Tested successfully on my setup.

Tested-by & Reviewed-by: Disha Goel <disgoel@linux.ibm.com>

> ---
>   tests/generic/108 | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/generic/108 b/tests/generic/108
> index 4f86ec94..05d743a9 100755
> --- a/tests/generic/108
> +++ b/tests/generic/108
> @@ -50,6 +50,11 @@ SCSI_DEBUG_DEV=`_get_scsi_debug_dev ${physical:-512} ${logical:-512} 0 $size`
>   test -b "$SCSI_DEBUG_DEV" || _notrun "Failed to initialize scsi debug device"
>   echo "SCSI debug device $SCSI_DEBUG_DEV" >>$seqres.full
>   
> +got_size_kb=$(_get_device_size $SCSI_DEBUG_DEV)
> +
> +[[ $got_size_kb -lt $((size * 1024)) ]] &&
> +	_notrun "Need SCSI debug device of size $(( size * 1024 )) KB. Got $got_size_kb KB"
> +
>   # create striped volume with 4MB stripe size
>   #
>   # lvm has a hardcoded list of valid devices and fails with
> @@ -60,7 +65,7 @@ $LVM_PROG vgcreate -f $vgname $SCSI_DEBUG_DEV $SCRATCH_DEV >>$seqres.full 2>&1
>   # We use yes pipe instead of 'lvcreate --yes' because old version of lvm
>   # (like 2.02.95 in RHEL6) don't support --yes option
>   yes | $LVM_PROG lvcreate -i 2 -I 4m -L ${lvsize}m -n $lvname $vgname \
> -	>>$seqres.full 2>&1
> +	>>$seqres.full 2>&1 || _fail "Failed to create LVM lv"
>   _udev_wait /dev/mapper/$vgname-$lvname
>   
>   # _mkfs_dev exits the test on failure, this makes sure test lv is created by


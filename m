Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FB03A5E85
	for <fstests@vger.kernel.org>; Mon, 23 Mar 2026 12:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774269545; cv=none; b=Vn7eK5N9LAFrMw3vf0LoqEqWkA5ujdjLo1n73uojOjnmxBerBRPm/gj4PAeKw75I/O8Ppv7hSbrNzZVFbBv7CTjeKcbW0qbF1F+Un23l8jx2TeauSCMZhcGItECaHqpox0r50aYsALgQ0LV8yyR6Hb2+qQrWDqElU5DKxbjI31E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774269545; c=relaxed/simple;
	bh=rHbV1L9N6uiNU0nl093QUp1Ucx3n6FkbSalajvXUu/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mlqYfCImhinpl9ix8o2uemIGgE+0bGFFHY2Bo1o3K+5dgVDxis91AM4qGR95yC2nFazLghJr/gy4nXXrrnQq0Upm4tNqoBIg6POJRBNKlbZndnonuVKFN2vR/paCJrhL9Qsopmjjadf1wLiPOGkdm/nLmfqM7oUUa2k1wqCAZng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hkdBpEVU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hkdBpEVU"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NBJMQv4104871;
	Mon, 23 Mar 2026 12:38:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=L9jLA6
	MRMl2SLyvoZq6Bw0ywiHQdpkq293/a4OgjZKE=; b=hkdBpEVU6iEXKUoTtjwzw8
	cndcyr2b8DaAAuMWtArEAkVSwRTxqYmbXu+Z6ByAmo8h3EKhsd3tQIX0MgKAR6oE
	rZgBecTVjWtaK2YD844wfsXHK/SpyD7tLTR030hTx+o/m4xKkaWaPyF3QMhkvlJm
	PBKf7l/eB76NkCCifthHaECQIJQaud4T64CnfxIsrxwLpJMNim8afjzpxo60C8Y4
	/vuqzMjx6cMX6ckiH7h5/zduPQDtXUcttXaIpQ3YEPWB8oVnojLYqAN7l3g79yB6
	vwNmDPNxK+YK8Qq2qE20kYzzocNSMAjRfWAq/DPorn3j+QfIMVhggaHiIXUAfpng
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxq6tax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 12:38:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62N8F7Xb012213;
	Mon, 23 Mar 2026 12:38:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vjw57x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 12:38:51 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62NCcnRx52101382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 12:38:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A95D2005A;
	Mon, 23 Mar 2026 12:38:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0AB62004F;
	Mon, 23 Mar 2026 12:38:48 +0000 (GMT)
Received: from [9.124.219.186] (unknown [9.124.219.186])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Mar 2026 12:38:48 +0000 (GMT)
Message-ID: <dd9ee458-8184-4143-9b27-011be9c093b6@linux.ibm.com>
Date: Mon, 23 Mar 2026 18:08:47 +0530
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] generic/730: skip on ext4 when dax is enabled
Content-Language: en-GB
To: Christoph Hellwig <hch@infradead.org>, Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org
References: <20260318081812.47870-1-disgoel@linux.ibm.com>
 <20260320155644.yy4qz2ulujpppaj2@doltdoltdolt>
 <acDYh-Q4gQcR2xRg@infradead.org>
From: Disha Goel <disgoel@linux.ibm.com>
In-Reply-To: <acDYh-Q4gQcR2xRg@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Wehr3L-bLQ6UminFxGGttaDpdRjL4W5q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA5NSBTYWx0ZWRfXzZv3LUJvJyRL
 KNtIlooacyiGgs9aDrjQSsXxmRlGMd+8h43M6e59k/Xdclff0Ri07yonPJVs+gxrrdDSbJhJ3MX
 qNFh1WLlr0an3icgRtIpcHzBxTH0fXAPQg+1thfAU5jek9IkC0/Gn3DZKAKcRFeTWDPfeFnjdcP
 jvizClSJu0bvTvdXtDN6Fr2hJgZl0BVD33rah15TISQYds2uOfkXwsFmHp7ywyh8FQ1/TXiBZE/
 YaOdpHrG19iILVokXzigUPoAk1j9rx8I8n+XBoihqBx9laJZWzfO6Q5wAXkLihk22MZzawfnZge
 NhR11+Ma1ppsVMcDMVXP3cUWYKKqUpBzNOaTWrW2kcys6DAiC8cCmtuaf0vFc7xWtl6wDw2YGMp
 G1iMSuESFb++bMq1o6/eX/TrdtpFrR5jVioK0l6CjWRPJuw3MCAOCDStEo5qT+10JH89h/4n5sF
 8udL4Tpk3mN3QD5uixg==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c1345c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=eABGrEe7kRF3yShvrAIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Wehr3L-bLQ6UminFxGGttaDpdRjL4W5q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230095

On 23/03/26 11:37 am, Christoph Hellwig wrote:
> On Fri, Mar 20, 2026 at 11:56:44PM +0800, Zorro Lang wrote:
>> I think this case isn't a DAX related test case, even give it "-o dax=always",
>> it won't test scsi_debug with that either. So why don't we simply skip the test
>> if dax is detected in MOUNT_OPTIONS?
>>
>>    _exclude_scratch_mount_option dax
>>
>> Any thoughts on this?
> 
> Agreed to all of the above.
> 
Thanks for the review. That makes sense.

I will send a v2 using _exclude_scratch_mount_option dax.

-- 
Regards,
Disha


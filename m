Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36BF24E4C3
	for <fstests@vger.kernel.org>; Fri, 13 Jun 2025 05:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749793081; cv=none; b=IBJ9H+k1KCX4N6Z0JSFRrC1+cBy1Lcv7TSwiJ6Ks+6W9SQp55SnbDsj9ydyEPTJYD8S42n0YqGQ9mqzRwV1EewRJYT8M4/dLhcAUeHdb7o8Ctv0s8BIRfMIq+BLDC4KLcTE+zQf475SYRydJR/7oOGJpz0wWQHMZzRVy6OlSTsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749793081; c=relaxed/simple;
	bh=zwdiMsOO26zRjKZcBrLE5vGs6e9dWWjWzPcYyn/qEwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7TCJGWUO8sLwb3gI/qG7fnVnQ7OyZsArZo451+V+N6q7ntxfBpkKH0Tc2P1hrFowSR/STn9c4w95kN/qaXdxc+dbqOty7dw49q/WfwE12WooPFn9BGBTU23cbv78Rk3p5z8HCZjsy44I0vegJbQ4MoEiXLCPyZyq+sHZRNzMDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YflycQaK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YflycQaK"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55D5IWl3002671;
	Fri, 13 Jun 2025 05:37:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=1JVyf9AyViusQjaxv1bdWCz+11N3Pw
	U03kCYRvXRyZc=; b=YflycQaKhuwiCsl8bxeAzGUbVJLEbBNYRrkqM2BIdfqw/w
	hc504sRWNHxn78zLT1iMuRXMw9JI2yTb1fBHv4qqZvAvlkpCmyrrDZDF/nJQ2Ibg
	ZDnmHuJI38PfWlxOAfZKOE6lMHT/d2TpQG4A20lvEieTjYQ3yD/h+4p+exLsC2Bg
	8JHZ11pJJahWokQbKONS63NCiTegVGKTTKJOa07fKua7kbStx0sB+o01EUabtUBc
	OIvLSGiQyJc8PLVZmfo79o193eRcX6qrYxOmE+ofdQ9Dlq87RTwYe4P25+lptsFl
	g5OCK/NJAWP7jC7tzVVhceIBRTeY5QFjVi/QB0dw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 477vyw536x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Jun 2025 05:37:54 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55D5brul029923;
	Fri, 13 Jun 2025 05:37:53 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 477vyw536w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Jun 2025 05:37:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55D1sHcw015006;
	Fri, 13 Jun 2025 05:37:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4750rpgj09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Jun 2025 05:37:53 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55D5bpgw11862414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2025 05:37:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3796F20043;
	Fri, 13 Jun 2025 05:37:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 584EE20040;
	Fri, 13 Jun 2025 05:37:49 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.30.54])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 13 Jun 2025 05:37:49 +0000 (GMT)
Date: Fri, 13 Jun 2025 11:07:45 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        djwong@kernel.org
Subject: Re: [RFC 10/12] ext4/062: Atomic writes test for bigalloc using fio
 crc verifier on multiple files
Message-ID: <aEu5KcCAkOrjiLDb@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <9b0512d4063c2dc421e3e72e8c899460dd0c2644.1749629233.git.ojaswin@linux.ibm.com>
 <05005921-517b-4286-be24-eeef625e488f@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05005921-517b-4286-be24-eeef625e488f@oracle.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=F5RXdrhN c=1 sm=1 tr=0 ts=684bb932 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=nJamc2wOpQf-qe4AQPkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 5vHVymqprWIZ6ohwWStKBKaI1gAjKDK5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDAyOSBTYWx0ZWRfX+7q0W4pz+97r t5BMHWhraaKSEo40odMy1zxp0HA8s1BOK0ghnGZAAvUj13h2Dgd8vFcv4OoPHvxs2/2OIPX8urM SO79195Er7x3kNDZx4RYEGJVscvUxhrp4kgbpCwCddLfhwv8BHu2KA8JX0CrsiaKr8fxAR0qn6u
 mVdiYXbFVSkihGHT1M+Zlfv6/4LD9ihhgg9RhoqdEDTZ3pB88yw0xqxogmKqpPf/dAuGt2JfRSE QnnqTty0IUK2lZdL72czRpM00QV2LcYcjxbmHgdJmBeXypaYYRlX1e2lRECwJvWLulqzzJTfVj8 tty4Hg9WxkDCESLMu/xTfmKfILTm1B/JQTQlb0EqxYaLlzrK3kTN1L4U3+F5y5n6hGJi1mBzO9e
 zjrEoTsglhaIvujDrcyawXZe0M37HUaUvNe5dXUnkoWU0/v5eQMKgAY4ES6rux+xVWE5xTyw
X-Proofpoint-ORIG-GUID: qj1QZNTwbjt7IWV6zs0qdNSjgidA_JaF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_10,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 clxscore=1015 adultscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 spamscore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=890
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506130029

On Thu, Jun 12, 2025 at 11:26:17AM +0100, John Garry wrote:
> On 11/06/2025 10:34, Ojaswin Mujoo wrote:
> > From: "Ritesh Harjani (IBM)"<ritesh.list@gmail.com>
> > 
> > Brute force all possible blocksize clustersize combination on a bigalloc
> > filesystem for stressing atomic write using fio data crc verifier. We run
> > multiple threads in parallel with each job writing to its own file. The
> > parallel jobs running on a constrained filesystem size ensure that we stress
> > the ext4 allocator to allocate contiguous extents.
> > 
> > Signed-off-by: Ritesh Harjani (IBM)<ritesh.list@gmail.com>
> > Signed-off-by: Ojaswin Mujoo<ojaswin@linux.ibm.com>
> 
> RWF_ATOMIC does not guarantee that racing atomic writes and reads are
> serialised. That is what you are testing here, right?
> 
> NVMe and SCSI do guarantee this (serialisation). However, reads in the block
> layer may be split into multiple requests, even though unlikely.

Hey John,

We are not really testing the serialization here
(verify_write_sequence=0) but rather that multiple threads atomically
writing to the same file should never tear the write. 

In the test, for each job, multiple threads are doing the write on the
same file with the same iosize so they should always overwrite each
other completely.  The verifier then ensures that the whole iosize chunk
written matches the checksum, which will only happen if the write is not
torn. That way we are able to ensure that even with multiple threads
writing the same ranges, we don't break the writes (the sequence doesn't
matter as long as it is not breaking)

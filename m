Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4372253E0
	for <fstests@vger.kernel.org>; Fri, 20 Jun 2025 07:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750403228; cv=none; b=p4v7+dLZzuk4sQdlIRLGcluSNuT0vGQjGiPr/oJrjGSHtqhH0yzeaFy2hd9L+xKBLls6/OjsVSo52s3eXV0nLkA+KFSlenY4JgRSgN4MuNAIQ3IQ3unQOxsy/Xg4aeMpAQcp/1m4Mpxalk85e5lsJvAmvoeDYc0GJs6Wl6Gahv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750403228; c=relaxed/simple;
	bh=jPUf3a7xPbsAz3ywYhW2SG3C+vdwsV/VyVZIsgGXhyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5rOu7JJI23XQN07td+YtJpGYGzocs3rXtotoRFp8VUJq/BaU29XF73FM8IGJVEcXlfpTBJv05EEsv62orTdT1HHJVMJiFa3qqtEV2hw56b/ulq//MuCJtDcbG/ses/ZnFVT6OzoZyNx+aaGAdhKL2iUnrrSxLXsefVqtLcA51o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=swAp35m0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="swAp35m0"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55JL3IxV003039;
	Fri, 20 Jun 2025 07:07:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=vj2G3TvP0cO3rkDL0O5+FbqWlfoOTa
	ZzVGASwFikjZI=; b=swAp35m0xqleqYmXiNGv0IClR5ka8+TOW8nzvCrikbLHu3
	fW2dJBMAKBPtZunHkW5bdxu5eOczc+9HG+JpmTKvXOFIMC1H4GG8y336F/fMDFWc
	3fFgVGi3qN7ORrDbv2BspJyTDGqxf/XVOGe8dfHLK3bXTGU48tsCBJDE+0vTc7eR
	Bx8fMDHR2odvxFY8QSrpQ1nAPrS4YeuojA2hEcKjkkfsbnNDbBRtKy6RfX5x8iNV
	zLaKbD99DSHa/EE+jv7Cgu0GlHqzOU5dLS6OH3hqwnihCuqEEx2rA3HiLPl9ty/x
	SbeUtlKliY9FdD5vBHDZVqpWqtTVfLm39g4l6y4g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47beet7mc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 07:07:00 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55K6wgEG029648;
	Fri, 20 Jun 2025 07:06:59 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47beet7mc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 07:06:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55K36PKx014247;
	Fri, 20 Jun 2025 07:06:58 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 479p42sj56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 07:06:58 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55K76vcM54657336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Jun 2025 07:06:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D91620043;
	Fri, 20 Jun 2025 07:06:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8E2B20040;
	Fri, 20 Jun 2025 07:06:55 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.221.59])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 20 Jun 2025 07:06:55 +0000 (GMT)
Date: Fri, 20 Jun 2025 12:36:53 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        djwong@kernel.org, john.g.garry@oracle.com
Subject: Re: [RFC 04/12] generic/767: Add atomic write test using fio crc
 check verifier
Message-ID: <aFUIjS24EIMuomgS@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <9cb914eacd9d7825f2903410948d2a1d4a1a8800.1749629233.git.ojaswin@linux.ibm.com>
 <20250618193434.yhi2gjgusgula5bj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618193434.yhi2gjgusgula5bj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eEagQytY20wDJ92ehT7j2YBPuGbIckrZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDA0OSBTYWx0ZWRfXxm8zHdg6N2sW m62evj1+dug+jdkyh5T1qhU1GY2THaTYbMuCPHPaMWcYFEyrs226HBueKl6+XXttk4O5pApU+e9 d0KGLuexDYJT9yJBKn/EJ9/pzy+c3kAVsHMHQTdNll7Py0c6QGUQmNOr6ZLSUAP1uBFyLqiV9y1
 m4gbIJ/iZUgkNHhG3eHtj55nAePIp71VZifUMeKl5k9ZWlDg1kK0obgSI+g/m0I4+YnydZoqygl WNo8iN5tjhhpHKiKAAxOxZL8tp9zZVVOeE2TWF4SSz1cGPe1ftFMUqT51EO8gQJeR1r0sZ59Uax 52AsRuXgDam5p37Zo2kjkw3IcxP+5dlZY/Ah5N9y4sWQDgGNVPkrbgrgqjphSLgvDi3y1y4PP6X
 B8H10+Z5kAZdSAhdleErhXOUbQOnheikCVJ9GBURGbmXi+T+sE0XJxGM/UjeN3mqeX/mIFTN
X-Authority-Analysis: v=2.4 cv=PrSTbxM3 c=1 sm=1 tr=0 ts=68550894 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=VnUEQl4I_nf_blNo6SYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: MdvZrYAYjuPHQqeiYK-EMbyqr2uO0MvP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_02,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=764
 bulkscore=0 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506200049

On Thu, Jun 19, 2025 at 03:34:34AM +0800, Zorro Lang wrote:
> On Wed, Jun 11, 2025 at 03:04:47PM +0530, Ojaswin Mujoo wrote:
> > From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> > 
> > This adds atomic write test using fio based on it's crc check verifier.
> > fio adds a crc for each data block. If the underlying device supports atomic
> > write then it is guaranteed that we will never have a mix data from two
> > threads writing on the same physical block.
> > 
> > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >  tests/generic/767     | 84 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/767.out |  2 ++
> 
> I'd like to recommend using a bigger case number for this RFC test case (and others
> in this patchset), to help you to rebase on later fstests easily :)

Sure Zorro, I'll make this change in v2. I think g/1226 should be okay
as the other atomic writes patchset [1] ends at 1225.

Thanks,
Ojaswin

Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE555383
	for <fstests@vger.kernel.org>; Fri, 11 Jul 2025 18:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752257823; cv=none; b=du/msQvVJIdj1Q2YiKjzC6bJ7m+uPbLug858HYGdYH6RzvKdBG+R6fEogrJSAjhGw+DP6L/pDXQCPWCAGeT65CtGsnJtb9c6K65fjvRagRP2MiX/iouIDiwJ2Qxa8Tssq2GncAru4lBZEcnQZnBW1pWd+MyHWigvtY0ZFSeFOoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752257823; c=relaxed/simple;
	bh=PV/rINgEjiK6E6eeFDS3/uVUejq22w6H2mg8Jk2oq70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrOhQuJ6sbx0JvLcH32S47JY1MxTdLo1ClO6L/h0wU+0R4k9suJLa+WMsY6XJTOzOf9toh9UxNZEbreB1DY86cAfyjkN5aXnEGylBymipjQpLeaQYBLp/rNOSjwMZT8Ht8KbyjXxxZtCoghgILB1QUj2k81+JykT0H6jWLZsgbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CTOXNyxR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CTOXNyxR"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BGCtJ2031888;
	Fri, 11 Jul 2025 18:16:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=OZlVzT7h0UvLDMd/Gfx9E7M9JUGvC0
	HDxS4V0B0ZILk=; b=CTOXNyxRK3xIYms3KhOFgej0aJcUIsjn0ebLZb7Jj80IvT
	mjTt6CWsu7ywGw1GNLXSWte80RMkA2IpkJDZ4Q0qJUF34JJl5hBJw0b21DwF6hD4
	R4ih5etOhqwrxkU1y6V2SZIXlijsqYusZlUuBeLw7XdWR4uu/J6n6MdALM+oHQHv
	o5E+YGLqs6I6ksNdmKX8uWuQWHEOHSTE9w2/QoR7MlVi43jCerDM+hxZo2T5O/vo
	J758dapnlLVCn6VC80DAsgTW91BfFIklBjBnqYt46xBw4fk2xMHKL2Wq6dBBeWBO
	1WopS7snilmtr84JXzYAqMqH2ghEa6JByolboHWw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47u5x80j0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 18:16:49 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56BI97qE003798;
	Fri, 11 Jul 2025 18:16:49 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47u5x80j06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 18:16:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56BF2LB9025586;
	Fri, 11 Jul 2025 18:16:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfcpkxr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 18:16:47 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56BIGjvd53543408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 18:16:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB3742004B;
	Fri, 11 Jul 2025 18:16:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71F8220043;
	Fri, 11 Jul 2025 18:16:44 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.216.137])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 11 Jul 2025 18:16:44 +0000 (GMT)
Date: Fri, 11 Jul 2025 23:46:42 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu
Subject: Re: [PATCH v2 05/13] generic/1226: Add atomic write test using fio
 crc check verifier
Message-ID: <aHFVCnWwgWOY_8_Q@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <a0d241f9-0070-488a-b330-5b93339fbb03@oracle.com>
 <aGfmUrj9HDrnwOyX@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <aGfx6d-lSnhwnKsq@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <e1896e36-3291-4b54-ab66-5568e4086fa7@oracle.com>
 <aGy_xT5powRmYzjY@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <7b79cd75-317c-4b64-b98d-2f35a014deb8@oracle.com>
 <aG0IsTJ88ia4TWmn@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <2678a0c0-e075-41dc-aad5-3191703c7359@oracle.com>
 <aHDaoiuxxTuI_9uS@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <fe11712b-fff7-4d3e-af37-7f5f2a96cb40@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe11712b-fff7-4d3e-af37-7f5f2a96cb40@oracle.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=LfI86ifi c=1 sm=1 tr=0 ts=68715511 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=fblwnv-F5c5gi2M34KUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 4BglZDqKplsf4AU78PSTgEcKhxRTc-ro
X-Proofpoint-ORIG-GUID: CYQnpXxsQR_n6KiuxXezyITRZziBTMk9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDEzNSBTYWx0ZWRfXxBdLWSOvkTt7 nMBYLh2dLqiPJ5c1QHIixO3oET6besj4I/VUzU4vlH9j836zSPkOk9zgWDwtJUF5Rc1MD64YxkP BsCPDCf2doNgi3IKQCu77T5iDHmbjorP/i5+8et4QcA+Jp4iyYX74U6izEQZruipBThsIwBcRVw
 ipbHRwA8joIuqkfkjpwPg6PXuamuw0XLSfgLPq1JpYDmWfTkUjcC4tdJQEkiz2HNoKDFEm5kq9N c20xLawG9WscTPmVfVTO68lw+O14n4uVUjGncj3emsRaMclIq7pttyIKVHRFZCZv0S/cHaajNKB 3DAQh16Wcp7obvhQdVl+XW+kJZaOTCn6ImxPxn0/CU4ZVZ1KaojhydNlDZJfISMwsZYuwS7Uo/x
 npEAipV4wf030115Bs7YErOh73a6KGdYQk6pmf2TlzpsdCSUGSf7N+rNiIAETgJidcd7miNf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110135

On Fri, Jul 11, 2025 at 11:51:22AM +0100, John Garry wrote:
> On 11/07/2025 11:39, Ojaswin Mujoo wrote:
> > > I don't think that fio supports such a mode. Or does it?
> > Yes we can achieve it via combination of write job with verify=crc,do_verify=0 followed by
> > verify job with verify=crc,verify_only=1.
> 
> So does verify=crc,do_verify=0 really omit the verify and only do write? If
> so, seems good.

Yep, it does the write with verify headers but doesn't do the actual
verification. We can later use a verify_only=1 job to verify it. 

I tested this on a setup where i was able to hit crc issues with
max_sectors_kb=4 reliably in 20 iterations with the original approach.
With the above approach we are no longer hitting crc issues.
> 
> > I'm testing this right now to
> > see if it can survive max_sectors_kb = 4 (which i think it should since
> > there are no races now). If everything is fine I'll use this approach
> > for the fio tests in the next revision.
> 
> understood
> 
> > > > Yes, it is a bit less effective but
> > > > then having a data integrity test that can theoretically return false
> > > > positives is not good, it'll always keep me guessing about any failure.
> > > > Having verify at end will not have false failures for sure. Even though
> > > > it comes at a cost of less coverage.
> > > > 
> > > > Maybe we can also get some other prespectives on this.
> > > > @Zorro, @Darrick, can you please give your thoughts on this?
> > > > 
> > > > As a sidenote, with this issue of fio's verify read splitting, it seems
> > > > like the parallel verify feature in fio itself is flawed for non-atomic
> > > > writes as well since the read can always split and race with the writes.
> > > fio does warn that multiple read and writers in verify mode is unsafe.
> > Right.
> > 
> > > > Not sure what the solution is here, maybe time for non splittable atomic
> > > > writes (:p)
> > > I just think that fio in verify mode for ext4 is ok, as long as
> > > max_sectors_kb is large.
> > Yes but i'd rather have the write followed by verify version to avoid
> > false positives in case the read bio does end up splitting for whatever
> > reason.
> > 
> > Thanks for catching this issue in the test!
> 
> So, if you want to test this way then you need to omit xfs or ensure that
> the bs <= awu max opt for xfs and hope for no problems.

Hmm having parallel verifies would have been surely useful but then 
the possibility of false failures would make me lose confidence 
in the test. Even with ext4 hardware support, something someday might end 
up splitting the read bio. I feel having a write followed by verify
approach is most suitable here.

Regards,
ojaswin

> 
> Thanks,
> John
> 

Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7A52882A4
	for <fstests@vger.kernel.org>; Fri, 20 Jun 2025 15:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750433083; cv=none; b=ZSGYvH7hlqlqA/tTceUI3tkkzh8+25Llc3rPtGEmnNNaVVJeU04QL64oPhUHhvK1gbjr4Ej3dqeieMb3I7H8TFU2RBGXhEoFEnYIyFmB3t+88H0riX1BIyOWl9z/EIr5GBtTfvQMwbQIdVMrZq0kxEcuK+Du2qZYXtpX0hqDhBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750433083; c=relaxed/simple;
	bh=wtQtmoi8fJ7QcMBLg8KVXrFzHy4OhosKhY6wq2zK2ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMBjfeHCRT2x1mxgXn+KVIbx8EgAYk/uJhYkGfOkpfwUOfFj+nWjBY2XpeJ61H99i0cM7NO83yVZWvdiut/sMLtkUsmRCHJgRTsdG0fFC4+gvzme2O7XIZT41Fog09WwP+FTLE8sYDOOh3o2pmB5pxRinxzidx1RqbpkJHQnCm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ux1lh5jP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ux1lh5jP"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55K9cVqQ029535;
	Fri, 20 Jun 2025 15:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=SuFnUTpO7cHKFSTVXm4wnhPap1Doe6
	rEepxOzKBAn4Q=; b=Ux1lh5jPCHmcvNo8472ScrFmg8j3ULqSi8nnDi2UIONxZZ
	tFBc9jv9nG+wELirauj/v4GUUG+8nQ5DEwP+sMCvIA3d6Uedq/VFDc28A70Mlga7
	ge0qIwlq2ikwk8XB+pI/oiOAlTsULLwf1wyHn4hInskHkhXy6G2fAuDydYSxlwLR
	jgAxF2jedXRcX5VmUVcA+cHU4/wyFd3Wu+I8yTkFgroEUaZt6LI5MV0x3mwkQyNf
	RqVyvdyU0dyculYtbKDP//v16TfSl3OsjDv+B4oNdNT4CkOt42acLdBVSrTEsr/b
	Yo/A+PWASHuRQdHpUf6kGo7ayYW/YIRf4ReyobeQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790ku4kp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 15:24:31 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55KFCvRP012130;
	Fri, 20 Jun 2025 15:24:31 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790ku4kp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 15:24:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55KEE1xf000863;
	Fri, 20 Jun 2025 15:24:30 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 479mdpkt1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 15:24:29 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55KFOSAu25952670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Jun 2025 15:24:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBAEA20040;
	Fri, 20 Jun 2025 15:24:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A32DD2004E;
	Fri, 20 Jun 2025 15:24:26 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.222.79])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 20 Jun 2025 15:24:26 +0000 (GMT)
Date: Fri, 20 Jun 2025 20:54:24 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        djwong@kernel.org
Subject: Re: [RFC 08/12] generic/772: Add sudden shutdown tests for multi
 block atomic writes
Message-ID: <aFV9KNZ59gm4RbMq@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <fe30e64171982a664579d11c1277b2a033b952ab.1749629233.git.ojaswin@linux.ibm.com>
 <170476dd-846e-4884-b185-f65ec46aa34c@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170476dd-846e-4884-b185-f65ec46aa34c@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2-UenyWjsZNYbSWMhUZzAbTeBhylAoSj
X-Proofpoint-ORIG-GUID: 25CTQov5zLTESOIOCLCESWGx6cSp5Z28
X-Authority-Analysis: v=2.4 cv=KaDSsRYD c=1 sm=1 tr=0 ts=68557d2f cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=WD-EaTcbP5DtfhDfka8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDEwOSBTYWx0ZWRfX/L62cSikG6FI T8z1GLelmO78AOYfrmT1Kftlgu47yJWh107RyPeQP6jZRTmccnM2u48HqTQ/JnycbKziWPUcqde iwPT+RN2PQjLypeYCmjzrq+RNVqlw2FGiAFyAVqIWIjY/PfqUIsr2jTfrR9TVQwbsbgHfXb0Zfl
 1RL+NLUTUxzJs1JK1llLmoQxWAQVtrAbd8TOLrKpoh8dvCJdTiTNK02t2r/8Ni42K1qkRAwBGS9 A9BhTuCtaRFoozN24rDQ3segfhNN6vBN/SR/VXDrXpEEAgZhRxKtJrCvJF30pggwiTaRVd0si01 6AWAWA1nR4/EYmFr3cnSO39yfLcaYoECsJgcQ2plzhm5iue6P6CXRGbPnzr5CS8QgOFQS7fugU4
 /gCLAa6bHTgiSja2IeLSucHQ3fhbKPE4C3ICL/1G4QIRlYM5qMfjrhcvuJBQl5k4t0eSLHQ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_06,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=886 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506200109

On Fri, Jun 20, 2025 at 03:05:42PM +0100, John Garry wrote:
> On 11/06/2025 10:34, Ojaswin Mujoo wrote:
> > This test is intended to ensure that multi blocks atomic writes
> > maintain atomic guarantees across sudden FS shutdowns.
> 
> This looks like an interesting test. Can you please consider writing a
> fuller commit message describing how it works?

Hey John, sure I'll add a more comprehensive commit message. Basically
what we do here is to create a mixed mapping and then do an atomic write
on it while shutting the FS down in parallel.

Then we note down the last offset n where write happened before shutdown
and check blocks from n - 5 to n + 5 to ensure they either have
completely old data or completely new data but not a mix of both.

We repeat this for non mixed mappings like fully written, hole etc but
the mixed one is the one most likely to get torn.

> 
> And do you verify that the test would fail for a non-atomic writes (before
> proving that it works for atomic writes)?


Yes we were reliably able to see torn data, every 20 iterations or so,
when we tried this test on a non atomic block device (after modifying
the test a bit eg not passing -A to pwrite). 

Infact even with an atomic device, we were also able to detect an issue
in ext4's early multiblock atomic write implementation where mishandling
of the transaction was resulting in torn data.

> 
> I've had a lot of difficulty testing atomic write behavior for system
> crash/unexpected shutdown, so it would be interesting to see how this works.
> 
> In the meantime, I'll try to understand the code...

Sure, one thing to note is that we use FS shutdown and focus mostly on
making sure the FS doesn't tear the write. 

We might need something similar for block layer as well at some point.
> 
> Thanks,
> John

Regards,
ojaswin

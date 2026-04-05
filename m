Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771D41A6822
	for <fstests@vger.kernel.org>; Sun,  5 Apr 2026 14:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775398040; cv=none; b=JBVDyB4WEMAZgmpBPh3LWXntPnwvDRJDKV9DPKWTc5xGD+QZfZTpOVi9IsePwKSorJB0Pwa8mekJX2oXTfD1KbwIdl/4QEyN3KP8pDVFwIbl9NAlbSPgWcvokRBui6DtGNFgdfJ5GJ8Frify8YTHkr62GuHI6vlwgQbOaPmOkY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775398040; c=relaxed/simple;
	bh=LnyNJh+q+I+QZJoMbzSPU8QoQwNy6U5akPsZsU6XdiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8etErBWwBAYJOSA7fEqM4PcyzzZrEcnM/oGTObUDxEi4OKr55Q2zn/xf2UNnI1e0WEGTNlbj32AB3E4BeYRamcOvjIQ7R1nUL9TMe2P/titKE/iPED87f7R1jqTncUk0ul8DDIaiDTLrbIh7TozQ0G4TdCqzaDGSgj2psh19Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qc1UMvMA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qc1UMvMA"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6359Ugji2566421;
	Sun, 5 Apr 2026 14:07:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=p+IRS3ARjo7w3OnnZiQGlryGFzgXR5
	oGr9VxYsoE5OU=; b=qc1UMvMA1d7Aj1DT2HWsP4C04wLHTtLmwD4gFaIl+6iBfu
	rMAm2VfOND48Pz7lhsN9FIcbtgcmmups0nu2wPQZ7kFVILo8M3wlLhwXkWvofsri
	5SePn6TsUf+MLTfCne3xkqaCO0+t7RzbziLR/SCGgN7QM+HADJ1IznsRWMXAAxiW
	GuhvKxQQhsSqAub6YJadb9zbLjGBDyL1+jyLLXZXki0ucsyGyWmZlDwqrotUaYoo
	WOxlrR86GJwKhYuGsfCWj9bfTI1CwFN/hQ7374COYN4EmTtbhbjdpQsoHn4hbfnZ
	NRFZLugBvry7/kMejP3xEbdjEc3o0onNl344MxvQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dat51umkt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 05 Apr 2026 14:07:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63594vHi020298;
	Sun, 5 Apr 2026 14:07:14 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dbdyn9h3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 05 Apr 2026 14:07:14 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 635E7C9g52756902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 5 Apr 2026 14:07:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5514E2004B;
	Sun,  5 Apr 2026 14:07:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BD9620040;
	Sun,  5 Apr 2026 14:07:11 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.211.21])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun,  5 Apr 2026 14:07:10 +0000 (GMT)
Date: Sun, 5 Apr 2026 19:37:08 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCH 4/4] generic/775: Fix an infinite loop due to variable
 name clash
Message-ID: <adJsjDpAxYGhyyrO@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <726e43008315a1bed018c1b43aae2458aebc03bc.1775039135.git.ojaswin@linux.ibm.com>
 <d1a7045002ded5d9e68347ff0fec41a86ff3877e.1775039135.git.ojaswin@linux.ibm.com>
 <20260401143218.GI6212@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401143218.GI6212@frogsfrogsfrogs>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J6anLQnS c=1 sm=1 tr=0 ts=69d26c93 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=E-QM0JYn8yBJKjH9NasA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: QQ_-WOZ-VZrra3h5R-nNFSLFaRz4x9kH
X-Proofpoint-ORIG-GUID: QQ_-WOZ-VZrra3h5R-nNFSLFaRz4x9kH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA1MDE0MyBTYWx0ZWRfX+F2mwQWrk1ZJ
 m7MYgkeEaKs6Qo3JEnObfVrEZnBwRhNgMu367qrh/juqXJFrPyrcUAtmL61dxW4wK4J162paHrS
 KBY33wBr4a/PNPHyq3RpgcvvQDHWe+/BPFjOD8kwPvlXCoQ4kVyWtrhEOd5VkIiKOrq9IrIh5L5
 6QrkSxVL572PkUxwwyBzyoQgfsokT1r7bhCLbwbMSE3PkUVQ3ekfh9j74Y9I0LwAkZTiCXDUwmE
 IZ6PKyk1CGKots6eiAUYUnqklnm/VVfE7KcyvZCnJOo1rjRI7xFxca7tEFDIssS3Z3ACiWOQUo6
 Z7qjQgul82NPLiug703y2Ra0Tt6Wh0gRRBqxHV+Ui2kEvMpCRv6avLLvIxaepcSt/HxcZHpNStV
 RrPwYDvr0RWmqEkfpGUjZNsx0wDVXJOKEVTCs1kQqnVYyz+2FXDPh20q1zWbDnpmjfXge92HRRV
 XrMvBI/8myTOep1Vl2g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-05_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 clxscore=1011
 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604050143

On Wed, Apr 01, 2026 at 07:32:18AM -0700, Darrick J. Wong wrote:
> On Wed, Apr 01, 2026 at 04:10:50PM +0530, Ojaswin Mujoo wrote:
> > We use i as the iteration variable in the main test loop as well as some
> > internal loops. Due to this clash, $i variable of main test loops was
> > getting modified by the following loop in prep_mixed_mapping().
> > 
> > 	for ((i=0; i<num_blocks; i++)); do
> > 
> > If num_blocks is less than 10 (example ext4 with blocksize 4k and
> > cluster size 8k) i would always be set as 3 and the main loop would
> > never exit. Take the simplest approach of just renaming the variable.
> > 
> > Reported-by: Disha Goel <disgoel@linux.ibm.com>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >  tests/generic/775 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tests/generic/775 b/tests/generic/775
> > index 2a4287bb..19ae95e2 100755
> > --- a/tests/generic/775
> > +++ b/tests/generic/775
> > @@ -41,7 +41,7 @@ prep_mixed_mapping() {
> >  
> >  	local operations=("W" "H" "U")
> >  	local num_blocks=$((awu_max / blksz))
> > -	for ((i=0; i<num_blocks; i++)); do
> > +	for ((j=0; j<num_blocks; j++)); do
> 
> You're right that the single-letter variables are a really bad idea in
> languages like bash/python/etc where functions can see variables in
> caller's scope if they're not explicitly marked local.
> 
> But a) why not use "local i" to prevent that; and (b) if you're going
> to rename it, why not "blkno"?

Hey Darrick thanks for the review.

Why not both a) and b) :).
I probably shouldve done that in the first place. I'll fix in v2

Thanks,
ojaswin

> 
> --D
> 
> >  		local index=$((RANDOM % ${#operations[@]}))
> >  		local map="${operations[$index]}"
> >  		local mapping="${mapping}${map}"
> > -- 
> > 2.53.0
> > 
> > 

Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FFC14A8B
	for <fstests@vger.kernel.org>; Thu, 12 Jun 2025 06:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749709152; cv=none; b=E9ICFyteNAbUVyJxvwOI1xWR2Ur3Wz29p+12bVNHOspHsm0vaMA0dZGreTVyRWqZRdjVP1VVCHkmO30IZzBgG6HpqN83Scme1rrWZP5NS5uCgfiaLuPjM8RT0qXScgw+zFGJe49lXrFTOKQJyX7gs1/hwsVB5u+HjzpRmS+E9JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749709152; c=relaxed/simple;
	bh=5VBgn9a511JMaMi9ofppz+o+oWpfVm1O1D7nw4Rc5Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWZGDEZ4C1m1aXmwDpXwfmO1IVnRzo4pY053CF1H9ulXHjK5h3umOxrADXZIuIVHyQZfV1cmWbr97iKeIEvbbmHBJNH44MEsPU3agi62ula6udRue8q00hJWzLFInoSRN4xY5ReeZugjKjNbn4/kfzOb2si0SIPUUZHsV1cT4Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H4CKhD+J; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H4CKhD+J"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BIuqod021803;
	Thu, 12 Jun 2025 06:19:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=QI0nvqPRKoZxGoARg6PITmVi2Emd5H
	vdFzkTBUQXh+w=; b=H4CKhD+JB3Qozy103jUMrAoOY87gu7qi15DbZQ6FONQ2EZ
	uVcSlz17opmovwjW647osP2d1UamLGPigvDh6CUNEomfjh2xDYByztFCG7A3ZxmM
	YzpccQh+OkO9BP5W3v4RDjOul0BPIyuM71GEG8zTo1Igv/GGtRkI1bYQWw35/HJn
	4VgkNg8EPs4aEUwvLMG0UG6ju+VNbDAv7o0uJLG7LhXVeo579n7O7wf+XL9rJqdn
	J2PnsUKILk4jtkzDCbVx/ZnEoQcDrpVXEU4O2y21rwyOn9AvJfjOUWSzRGG+QeVW
	y7DQUV2Cdp1J3HjAXq29gZR0momQBODt4C3RJGFw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474bup8tj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 06:19:06 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55C6GgYv027072;
	Thu, 12 Jun 2025 06:19:06 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474bup8tj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 06:19:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55C2UHtL028076;
	Thu, 12 Jun 2025 06:19:05 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47518mk8xw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 06:19:05 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55C6J3OS53281100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 06:19:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81FFA20043;
	Thu, 12 Jun 2025 06:19:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C36C20040;
	Thu, 12 Jun 2025 06:19:02 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.249])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 12 Jun 2025 06:19:02 +0000 (GMT)
Date: Thu, 12 Jun 2025 11:48:59 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        john.g.garry@oracle.com
Subject: Re: [RFC 03/12] ltp/fsx.c: Add atomic writes support to fsx
Message-ID: <aEpxU9Z16OMegHqu@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <07d5d00e4ebc24b4dd4c718b29dd14867fefdd70.1749629233.git.ojaswin@linux.ibm.com>
 <20250611143554.GH6143@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611143554.GH6143@frogsfrogsfrogs>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=H4Hbw/Yi c=1 sm=1 tr=0 ts=684a715a cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=R8aty10vCRL0z1Hu8dwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDA0NiBTYWx0ZWRfX6cL+bbbQsa/W Shf8xP+e7Dc2/r4r0spkTc1f7pUACm5me5MeyZoBxU9aVxgloJ7l11UxkEoxl8mOFMMP5OexXuI c+tx+Rhc9HFjqyxBKYfi9DMdJs14T1r09w3d7G8+dghKeN3q4YKzBP5fU6qfDSnWI13VDPN+AOJ
 C9LEiYuB3e4kLhEEpSCk4VYlRQS0JIrxPzohnhkC3VBZZVJt6T5zYrqvVTWoOXp093fb+XhcOQx 1R41JS7r1/RCuI2797Ssah1ewthyvWdRSL6hF7mPouTxgNnZ8gagHCbmbi1I6V7g3IwzOsMuvj5 bT5FSyczrlLHORayBgXwlytTweSnrXVEmMxZpip0gW14qh17IYP22HamHPs8FEO2WnoBkKLsgyR
 wEbnrX49E666GD5dDHDSiSCjuTVZZ4aGpONQPDig6mODnCQBiUQQIWOguu/sqmZGKtePvKil
X-Proofpoint-GUID: qv6-vALKu35rHZjIwgIzlhBAc_gI7kBh
X-Proofpoint-ORIG-GUID: xJ--z4RrVLs8WZASuXA_RKRVNIqdOow7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_03,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=621 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506120046

On Wed, Jun 11, 2025 at 07:35:54AM -0700, Darrick J. Wong wrote:
> On Wed, Jun 11, 2025 at 03:04:46PM +0530, Ojaswin Mujoo wrote:
> > Implement atomic write support to help fuzz atomic writes
> > with fsx.
> > 
> > Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---

<snip>

> > +
> >  #ifdef HAVE_COPY_FILE_RANGE
> >  int
> >  test_copy_range(void)
> > @@ -2385,6 +2466,14 @@ have_op:
> >  			dowrite(offset, size, 0);
> >  		break;
> >  
> > +	case OP_WRITE_ATOMIC:
> > +		TRIM_OFF_LEN(offset, size, maxfilelen);
> > +		if (do_atomic_writes)
> > +			dowrite(offset, size, RWF_ATOMIC);
> > +		else
> > +			dowrite(offset, size, 0);
> 
> Er.... shouldn't we skip OP_ATOMIC_WRITE if !do_atomic_writes?
> There's a whole switch statement further up in test() that does things
> like:
> 
> 	case OP_COPY_RANGE:
> 		if (!copy_range_calls) {
> 			log5(op, offset, size, offset2, FL_SKIPPED);
> 			goto out;
> 		}
> 		break;
> 
> to break out early.
> 
> --D

Got it, I'll make the change Darrick.

Thanks,
ojaswin


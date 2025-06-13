Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE2F25332E
	for <fstests@vger.kernel.org>; Fri, 13 Jun 2025 05:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749792700; cv=none; b=iXjSIkPXaW+k3IqSLtmIRFIa1j/fVcoVfIhqPSU60Yf9CT4jbgiQrxSGincDdI+h+z8OjAkVRM5hwaHi3IBdAm7p6EtaH/vejiScNFCeVN+5W8uk1RfwmrABn46wLXMOAoQkdLtsAkK34fI/ozL+ugrDtvJI2Z9nzfMd+VIxyBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749792700; c=relaxed/simple;
	bh=5xW79DSjgSHPKlsKNH8+6p0Ny7I5eoHJKn9L4LRg9e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YwO0XTuICR3/q1ycAWjQCBbSbv1w0MoyljKFIEaCnJ3x8kFZhn5huIq5Imx9280I15SWtU9WZy4f/VYQ/7wL809/vm32ACJYyQNpZsxEB+l0XPz8hPXxgfMHeCKVP58ctffdHOPlDsSnIhpJBsevSwsRiC7DJ/GVKqPSyfgxcyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ApHNo0V2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ApHNo0V2"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55CN1VR7027642;
	Fri, 13 Jun 2025 05:31:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=kxm+4T2i2ntXz3xB6O626MPgJ4Q3kM
	8R39BoBwJGa4Q=; b=ApHNo0V2lrb71L07Qx0pI7nD0tdM5ZObEf7nztgjAq9Xjc
	m90dFNHFDnWLS1Hku3J1tWPKyLhyWyPAwXYBRYEXa4WRoY5THvBkAhD+V9ZL+5A0
	mubgBhmrB6KHZIb+MvkbjQAl23kGYdiIg898JkBshyIJeVoMrqhLX0TQkONdK/Cc
	yxoLwDx1ipdJgeNVvk1n9Mpofg28IEqHDGUwOx3K0pZUooedS22BCE5LInV6H0VE
	zRyNrnWwnONECHMAURj8K7ArWVVvQf2taFugdwiTn7SATR8hru0MsV4/xZiBHMEz
	+uztGTFeYLXRGn1Y5NKGzmAUsRrUoe8UN8VHbSQQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474x4mm5aw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Jun 2025 05:31:32 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55D5VVXk007721;
	Fri, 13 Jun 2025 05:31:31 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474x4mm5aq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Jun 2025 05:31:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55D2niOD003347;
	Fri, 13 Jun 2025 05:31:30 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4751ym0a2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Jun 2025 05:31:30 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55D5VTLD28902054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2025 05:31:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 295422005A;
	Fri, 13 Jun 2025 05:31:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 199FC20040;
	Fri, 13 Jun 2025 05:31:28 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.30.54])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 13 Jun 2025 05:31:27 +0000 (GMT)
Date: Fri, 13 Jun 2025 11:01:25 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        john.g.garry@oracle.com, tytso@mit.edu
Subject: Re: [RFC 01/12] common/preamble: Fix fsx for ext4 with bigalloc
Message-ID: <aEu3rfhMPrE7414B@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <2568ed1e9d1c47d0fdb357f0e10c5ed341a72379.1749629233.git.ojaswin@linux.ibm.com>
 <20250611143005.GF6143@frogsfrogsfrogs>
 <aEpvhNjDHXvFXSIJ@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20250612143614.GR6143@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612143614.GR6143@frogsfrogsfrogs>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Y4X4sgeN c=1 sm=1 tr=0 ts=684bb7b4 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=mZIvosy9p5La-lg4n64A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: OG-zqLgVfG4c5IjSX6RLj5iRN-fpurdp
X-Proofpoint-ORIG-GUID: x3rYV2S2jZoT74m-YjREXaVaoIAfLsGz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDAzNyBTYWx0ZWRfX0uxQ8myWwDK+ VUI2WP3iPWrs08Hd3syBLUJm8u1BQrX5ss5XA+xbHTn3tqYwVeNp5f94un2tmHPZotLt1OTEm/n 7tzyMyy2+79W6NrzNVsFw6WO27kebbY+mfxP4w+mljGjlhoRi6ODRVM8/+oJTcfCxA8Sar6WJNm
 j3EK1W9iM27KNWoY/oHHr/htP9PUnuyg1bNrSU7dLCaugOIS0oUXyiTOfDk7+ZAN+CnRnSLoEuo V1+q5Uzr0LcRof9DzWwmcvfZ7bpbwJCJvpD9jteNBcsVciG/rr+nVmo5G7tE+8Guaocx0S1CVhy MphJdhJE3bDaerDRFolf0BH9pGUPiWaY4w6xmvubLCy7Rhd+bGZ+1ylEekF/cHUedUQbKVJ45dC
 JXPdbNdf/k7cVEby2U00/3HKaby15nu+nhPb3CPM2VP56uyxOoltfhmEBaQAFCQiMhfyPoKx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_10,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=813 spamscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506130037

On Thu, Jun 12, 2025 at 07:36:14AM -0700, Darrick J. Wong wrote:
> On Thu, Jun 12, 2025 at 11:41:16AM +0530, Ojaswin Mujoo wrote:
> > On Wed, Jun 11, 2025 at 07:30:05AM -0700, Darrick J. Wong wrote:
> > > On Wed, Jun 11, 2025 at 03:04:44PM +0530, Ojaswin Mujoo wrote:
> > > > From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> > > > 
> > > > Insert range and collapse range only works with bigalloc in case
> > > > the range is cluster size aligned, which fsx doesnt take care. To
> > > > work past this, disable insert range and collapse range on ext4, if
> > > > bigalloc is enabled.
> > > 
> > > Hmmm, insert/collapse-range have the same behavior on xfs realtime,
> > > maybe we should amend test() in fsx to round to the allocation unit
> > > size?
> > Hey Darrick,
> > 
> > Yes makes sense but as you mentioned, I'm not sure if there
> > is a way to programatically detect the bigalloc cluster size (or
> > allocation unit in general) like we do for xfs. 
> 
> I don't either, but maybe we should have a way reveal the allocation
> unit size for a given file?  Yet another statx field? :P
> 
> (It /would/ be useful for programs that use collapse/insert range)

Yes it would, at the very least, help with defining clear semantics for
collapse/insert range with bigalloc/rtvol because right now those
operations just EINVAL if the range is not aligned correctly, which is
confusing since it is not documented how to do it properly.

xfs does have an ioctl to get the geometry for rtvol. I think you are
suggesting a more generic statx field which can be used by other FSes as
well, right?


Regards,
ojaswin
> 
> --D
> 

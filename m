Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3632E28C005
	for <fstests@vger.kernel.org>; Tue, 17 Jun 2025 06:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750141337; cv=none; b=UEnEBZ+mNlMyy4P2ln5n5yd7OAGIzIf57WqgpXqAAVGaY2NJZj87L28Wt/8dYk/5Ulk+mJBQogG0oA3eO7s5uwpWAdi1MmXoksveBjbpY7Kxne1uKsmd0fuM+d90V/k8myrdFL0Zx6bJhleshONrTrLGcd/5Mb2YSPB3WJZLYOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750141337; c=relaxed/simple;
	bh=J68BM+egsuhML+3nYT07JiknwdAVnPn+jUy18DCVY+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkfgYVY1uVJqDUl+ocmCXwdAKrvmOuj87u2HJzk72iMPdHV1M4nyfkAII4GerSbtLTNMHMcKamUv6yeDOCOVIeYfbPHj5ajmHu9hbR9p4cvPuvUCBXnT1VLoETTW/K/QgHSvDZYpqAjqmOC/IhvPtxkHVvGjGUs4LPuhvASULLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r0A6KNNp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r0A6KNNp"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GJSmNV015493;
	Tue, 17 Jun 2025 06:22:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=2XO6jYaNdqh4jJBGwVvXClmrk1dAfQ
	IVBWZ0zKA6bks=; b=r0A6KNNpBzv2A74ovj1rRbsLkc0PpqWQlQqPiSMsBTykID
	Mtu+PJWyc9DZh3exnrTCLM+ED/VWR3MN9iKz/nllE2etTSV1Xlh1JnOxl0o29Zj3
	TPg4f/5Gim0C0p8tyqTmqRVM+OHetN8oaEzUxJLxKJpRbT1eLbHnT8Im3gs2jGKi
	8F7T8iD3S6L7HvE19SimQBjqJE1/E16aXX3GTmiC0onhq+hk6jiJhbg9ZkpcriTZ
	8TbQn584feVTOyRgmP/KGVTtjCGVH6C55xUvjGg2ffAnHuPA1IceZmlFG6uk9C9t
	KJeRd6RX2WILuF8b/58dJGK45cR02q9BMBeGFF0Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790tdxdws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 06:22:09 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55H6Hl9w026987;
	Tue, 17 Jun 2025 06:22:09 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790tdxdwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 06:22:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55H5kOxh025778;
	Tue, 17 Jun 2025 06:22:08 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 479xy5r32d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 06:22:08 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55H6M6x646137648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 06:22:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB38620043;
	Tue, 17 Jun 2025 06:22:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 802D820040;
	Tue, 17 Jun 2025 06:22:05 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.249])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 17 Jun 2025 06:22:05 +0000 (GMT)
Date: Tue, 17 Jun 2025 11:52:02 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        john.g.garry@oracle.com, tytso@mit.edu
Subject: Re: [RFC 01/12] common/preamble: Fix fsx for ext4 with bigalloc
Message-ID: <aFEJijH70NW-GAm_@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <2568ed1e9d1c47d0fdb357f0e10c5ed341a72379.1749629233.git.ojaswin@linux.ibm.com>
 <20250611143005.GF6143@frogsfrogsfrogs>
 <aEpvhNjDHXvFXSIJ@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20250612143614.GR6143@frogsfrogsfrogs>
 <aEu3rfhMPrE7414B@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20250613150446.GX6143@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613150446.GX6143@frogsfrogsfrogs>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qjygR6-uOMMYJ1BLgaQ5LppTJGwGMiSo
X-Proofpoint-GUID: PK7hSnn9avsC5EoNqqNHA1y8BaqG34r-
X-Authority-Analysis: v=2.4 cv=c92rQQ9l c=1 sm=1 tr=0 ts=68510991 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=6W_nNsTRPrMMSje2hOcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDA1MCBTYWx0ZWRfX97JUd7r4vzLN y+oqj7o074t/Umwz2IXQDSKX4lpVWwkXD0SnMufzrYG/dbirqIAjFnSU3aHTcxZN2/Hn9iO+bsB +l0eta1AuSA6aZkKCgsehPP0MSbe/t+taMZwbZaUiLzKPZZryP5iWZzAjUErT4lAeEvbdmnY6/7
 c+iIjyRcrtjY9+N/vQu+FF+KQJZctdQJE8voKBC9m85NsiYdbYoXG9bznnDCcVvgaqGYPH/YwYE YBTmie5xzrYjzrEqiLg1mDvMe+o6Vl1gFVQeXvzK7yT58NYV/9CHE67AJcageBBH/1KvjbY+a9C c+mkyOz6EgpIzXp2ipx1OMF4M3kYPbtfKwvho1xYqNrolTSAPO7nszJVf3ryx4zB8kbafMEFO2T
 zAjV22lObM9id6sXIXvyqy3kDsIHfMUqdQ6+2a0jFprqRUVlWUQtIx55fk6J9gRQTPj4CC/y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_02,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=913 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506170050

On Fri, Jun 13, 2025 at 08:04:46AM -0700, Darrick J. Wong wrote:
> On Fri, Jun 13, 2025 at 11:01:25AM +0530, Ojaswin Mujoo wrote:
> > On Thu, Jun 12, 2025 at 07:36:14AM -0700, Darrick J. Wong wrote:
> > > On Thu, Jun 12, 2025 at 11:41:16AM +0530, Ojaswin Mujoo wrote:
> > > > On Wed, Jun 11, 2025 at 07:30:05AM -0700, Darrick J. Wong wrote:
> > > > > On Wed, Jun 11, 2025 at 03:04:44PM +0530, Ojaswin Mujoo wrote:
> > > > > > From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> > > > > > 
> > > > > > Insert range and collapse range only works with bigalloc in case
> > > > > > the range is cluster size aligned, which fsx doesnt take care. To
> > > > > > work past this, disable insert range and collapse range on ext4, if
> > > > > > bigalloc is enabled.
> > > > > 
> > > > > Hmmm, insert/collapse-range have the same behavior on xfs realtime,
> > > > > maybe we should amend test() in fsx to round to the allocation unit
> > > > > size?
> > > > Hey Darrick,
> > > > 
> > > > Yes makes sense but as you mentioned, I'm not sure if there
> > > > is a way to programatically detect the bigalloc cluster size (or
> > > > allocation unit in general) like we do for xfs. 
> > > 
> > > I don't either, but maybe we should have a way reveal the allocation
> > > unit size for a given file?  Yet another statx field? :P
> > > 
> > > (It /would/ be useful for programs that use collapse/insert range)
> > 
> > Yes it would, at the very least, help with defining clear semantics for
> > collapse/insert range with bigalloc/rtvol because right now those
> > operations just EINVAL if the range is not aligned correctly, which is
> > confusing since it is not documented how to do it properly.
> > 
> > xfs does have an ioctl to get the geometry for rtvol. I think you are
> > suggesting a more generic statx field which can be used by other FSes as
> > well, right?
> 
> Right, since other filesystems (fat, ntfs, etc) also have allocation
> units larger than the fsblock size.  Most of the time the allocunit
> amplification simply doesn't matter to applications, but once in a while
> it does (collapse/insert range, cow) affect performance.
> 
> --D

Makes sense Darrick. I can look into it. 

For this patch, is it okay to keep the approach of disabling
collapse/insert range for bigalloc for now and we can change fsx later
if we add support for exposing alloc units.

Regards,
Ojaswin

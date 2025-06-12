Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B9F153598
	for <fstests@vger.kernel.org>; Thu, 12 Jun 2025 06:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749708692; cv=none; b=K4QILdZAxhBVppXm7H1PJIqhuZaB542KmQmxwL4rcLXqFGjFhAOTQwIHjRBIzC8elPmnbcn/idbeFdZIgtIO6ZrZy/yJxtpdQGeLOddzRIShCHy9j9Z0yP+iqh8eMtcUZbWdD7jmlv6DFsuo0yvBClqIlfyowd+wz+oFUlO37sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749708692; c=relaxed/simple;
	bh=GS9Tw4auN847hrAcHdoV432Fp7bH0EIHYrhJi3HwJzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSmJDOCgq8wZ/C0c1lBYIlVMab5ShxIJdhJhAqMu4S87lcRpLZM6byLAs1UZ4E4HEVgIQaQylkCgx9Ph4DRUhLunE1jmHFNlDK/bkGgiMsn/YSapiJn0lxgBIy4vUkOlocU99vBl2eAmYLSzycI1D3u0TPnrNKISxTxiPS6gsZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ERMCiEOX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ERMCiEOX"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BJrpmv004232;
	Thu, 12 Jun 2025 06:11:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=hL8m4i36SWKz8luWqrMzN4T3/vUbwN
	3oQq6lzNacGtM=; b=ERMCiEOXohbfo/CKMUxBGY7ZRUK8LniJi/vRy7MSvjkSSF
	TMg7l6EYegdq+8irYCMtsOkJqbfu4GXqfMJtGD4uYnk3C7XRMfkZq19fgoVCpNc5
	MAzrZD5w4I9Grzy7dzw2qljknmnL09Z4NZ/52wKKs828yBIXZ9BAtu6jhdA2tMKq
	+irAdhz2ETPIfKtCdhMBfSYx3zQpsZhtFrnl4uA/7G3PG51J17SoFhXDl2Pk4xPZ
	+NUz5II0dr5nYjHKDivyFvHtpgs7hg9rcS5FRaM3iU0MSUuGnG+c3u99ukAWL2z8
	6b0iFv5v2aH03vrcQ6qUHWkElW/eiDmppy32rmiA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474x4mdxad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 06:11:23 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55C6BMx4011251;
	Thu, 12 Jun 2025 06:11:22 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474x4mdxab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 06:11:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55C2nAlc003405;
	Thu, 12 Jun 2025 06:11:22 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4751yku4na-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 06:11:21 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55C6BKGv39059942
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 06:11:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34CC72005A;
	Thu, 12 Jun 2025 06:11:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E54E62006B;
	Thu, 12 Jun 2025 06:11:18 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.249])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 12 Jun 2025 06:11:18 +0000 (GMT)
Date: Thu, 12 Jun 2025 11:41:16 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        john.g.garry@oracle.com, tytso@mit.edu
Subject: Re: [RFC 01/12] common/preamble: Fix fsx for ext4 with bigalloc
Message-ID: <aEpvhNjDHXvFXSIJ@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <2568ed1e9d1c47d0fdb357f0e10c5ed341a72379.1749629233.git.ojaswin@linux.ibm.com>
 <20250611143005.GF6143@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611143005.GF6143@frogsfrogsfrogs>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Y4X4sgeN c=1 sm=1 tr=0 ts=684a6f8b cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=-IxGYVOlY_5RpkT4_woA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 2dbASFS2FAHSeXoPXcZRjh0b2SpSD_xZ
X-Proofpoint-ORIG-GUID: iqIentWzZAxsvkP0jmCYYKB-EsN1QphL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDA0MiBTYWx0ZWRfX1eYk8oBXxmLt 5iCp9dcldtPNHL9grJkzmLJLo9Hrb8vzQTxCuMCZAf5S1KxJRZrM+O2bP/KwUqftTV1XAMtotFN mYYUOukdshmdfXpiSnbGyfDzoLX0YxSskz1aZ45QNdmHhcp1/GR8QyRp4/MBxF3MhfiPt1sCyUF
 bkUgihwcHxyn8k48NHarZbrVvhOgVx9DxW0BbNfqvcFpJvYfl/tAYUMS2Of1vo1gLQ7TyceTUhl 5J3gkpXYk6MWz5vm0wGzlv+wu1y+tFho0fBIYo0sSrD2mm7TdvLGhE43GZF5W3gVIALShRaAJLu 2sfTjtV872odfOWzbCFQPjYhvHVVh+GiNnFwbM6Anr4/VncqvY8dTcS+XwLsnoAmycIW2PHzM6d
 i+DM/jzxx+kUNKz6QK8kangdEEQLzvV0iUifxcLZOdFUtT443IXnHSs6XL+Np3X7KY0g64Ny
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_03,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=960 spamscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506120042

On Wed, Jun 11, 2025 at 07:30:05AM -0700, Darrick J. Wong wrote:
> On Wed, Jun 11, 2025 at 03:04:44PM +0530, Ojaswin Mujoo wrote:
> > From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> > 
> > Insert range and collapse range only works with bigalloc in case
> > the range is cluster size aligned, which fsx doesnt take care. To
> > work past this, disable insert range and collapse range on ext4, if
> > bigalloc is enabled.
> 
> Hmmm, insert/collapse-range have the same behavior on xfs realtime,
> maybe we should amend test() in fsx to round to the allocation unit
> size?
Hey Darrick,

Yes makes sense but as you mentioned, I'm not sure if there
is a way to programatically detect the bigalloc cluster size (or
allocation unit in general) like we do for xfs. 

(Adding Ted to CC in case he has some idea)
> 
> Querying that programmatically might be ... interesting though.  Is
> there a good way to do that for ext4 bigalloc?
> 
> (See detect_xfs_alloc_unit in punch-alternating.c)
> 
> --D
> 
> > This is achieved by defining a new function _setup_fs_options
> > which can serve as a mechanism to apply FS-wide options to
> > the tests.
> > 
> > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >  common/preamble | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/common/preamble b/common/preamble
> > index ba029a34..2bccff74 100644
> > --- a/common/preamble
> > +++ b/common/preamble
> > @@ -24,6 +24,20 @@ _register_cleanup()
> >  	trap "${cleanup}exit \$status" EXIT HUP INT QUIT TERM $*
> >  }
> >  
> > +# setup FS options only to be available for each test run
> > +_setup_fs_options() {
> > +	case "$FSTYP" in
> > +	"ext4")
> > +		if [[ "$MKFS_OPTIONS" =~ bigalloc ]]; then
> > +			export FSX_AVOID="-I -C"
> > +		fi
> > +		;;
> > +	# Add other filesystem types here as needed
> > +	*)
> > +		;;
> > +	esac
> > +}
> > +
> >  # Prepare to run a fstest by initializing the required global variables to
> >  # their defaults, sourcing common functions, registering a cleanup function,
> >  # and removing the $seqres.full file.
> > @@ -55,4 +69,6 @@ _begin_fstest()
> >  	# remove previous $seqres.full before test
> >  	rm -f $seqres.full $seqres.hints
> >  
> > +	# setup filesystem options for a given test execution
> > +	_setup_fs_options
> >  }
> > -- 
> > 2.49.0
> > 
> > 

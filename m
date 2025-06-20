Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B313C30E837
	for <fstests@vger.kernel.org>; Fri, 20 Jun 2025 06:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750400481; cv=none; b=rVU/nA/xF8uOQCK1l/sessEFBhPxQV2vW561dpmzj/G96lK/QRKQN6DrL/jRMqXH2mTqCbwwBKuslm9Tw7M9iDlfL+GrJ2ubfHWbJFbzthjXDEB8FLbkgbAJi72VuMJcQ/JMxzgNzY6mHZ4Rmd0MlP9sYHiVHpY/h83u173CBJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750400481; c=relaxed/simple;
	bh=6MWkuLFkYTE68RbYd8OvYq1nyrg5goj7wMf6Oi8CG2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aF4QlRchgE6Uuu7ZGncDVTe5YambsZp+JLjMMfFNlc5FhB2KXpQ+8B3XI6WX3NCc07/5Q1RZpnMukFw44DZF2johffNN2xgMmfrTmtcyGTsmj8CG+33R42puEV4rq/HESKd2sUB1NMlXjLBtMnySo3gAS/DdHi48nlGWRas4IAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E2IgeE7G; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E2IgeE7G"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55K2jEpP004636;
	Fri, 20 Jun 2025 06:21:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=pYE8a1t9vfTznnwv369pFzgc2o26JI
	UFlk9hX9e/EWw=; b=E2IgeE7GS9MmpmWNpTDyciLzB6QPP65wPLW6wciPqn9P6P
	rs3wfr/5F83fTU3G/dY5CAbh14b5Qtts4Sdtlm6QVOZyVP6kmFd5VKnqQk03Wu7r
	XL7F/s3i/J3Qhb6IeRrGtqeDiD8fvVIXtSb63pm5ZkHNcjNRKVOGj1MgyH+EDt4C
	i3K/ZAhbTlE6FRLJUEZXwUfY7a4GtubBqZPGheTPeIZAl9ENfWXyktkFEFY37EhV
	8udCQ1nHKe4xPTEBiKD757ELUhlBwGWTX5yGkCR5aWaN5EStwp7aUpZfoVlB7cVT
	ks/Qq1ccr52T1Le4StwCCACZZTZrtcH5PyB3Gyuw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47cy4jruea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 06:21:13 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55K6IfVg019819;
	Fri, 20 Jun 2025 06:21:13 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47cy4jrue7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 06:21:13 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55K4kMLd011236;
	Fri, 20 Jun 2025 06:21:12 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 479kdtsytx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 06:21:12 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55K6LAgQ44499214
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Jun 2025 06:21:11 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAE882004B;
	Fri, 20 Jun 2025 06:21:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C30D120043;
	Fri, 20 Jun 2025 06:21:09 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.221.59])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 20 Jun 2025 06:21:09 +0000 (GMT)
Date: Fri, 20 Jun 2025 11:51:07 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        djwong@kernel.org, john.g.garry@oracle.com
Subject: Re: [RFC 01/12] common/preamble: Fix fsx for ext4 with bigalloc
Message-ID: <aFT9soHgXs1Yb5Jw@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <2568ed1e9d1c47d0fdb357f0e10c5ed341a72379.1749629233.git.ojaswin@linux.ibm.com>
 <20250618191324.fpwyi6acobodmyit@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618191324.fpwyi6acobodmyit@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8W6RkQSv4RszZqG9rH6knp5UX8QERLuT
X-Authority-Analysis: v=2.4 cv=a7ww9VSF c=1 sm=1 tr=0 ts=6854fdda cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=jbgOGFKfrzN9P5aBk4cA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDA0NiBTYWx0ZWRfXxibkQj0omBq6 tu23ull+WvYgjhTzCEeANK+aIeMiXoqN7jPJhNtTflR8Utz6nLQ6P5McyDIOzv0JjKJYv/IAzWs YzyVY+veUBClH4q782oR+aEln5GUPUXRWISocpviDvtmKKw4imbeEdjbU8a9b1cUwnDevLN+6+y
 VeEVt8uZb5CTP9exdeuOLuHHBUx7qz4M+rBYAgY1vgja73pSmRctLq6CkiL2yxgGRz5b+8tKXNd mv59HBln53i6MZhVEeNeJLHn/m9yS4ltoLar9gimLsMrDvja4PMTqwQFvWwhCJi2nq7HMcZEY/9 fwIswUgGxLkh2MtDvgy01UXIBVfrqD50XQmmEQfFybA42Uew2EyOWr1nH1iXl8EzYGAeQA7KKAY
 23kunkFmTzPj33iCLHZ/fF73QFbFWQC54BoCleMjPNq8Q2dnHfdvZdj2bsykxBw+aEIxzKiK
X-Proofpoint-ORIG-GUID: aCyIAKXozEThgR8zjon72pnR621rUMap
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_02,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 clxscore=1011 malwarescore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506200046

On Thu, Jun 19, 2025 at 03:13:24AM +0800, Zorro Lang wrote:
> On Wed, Jun 11, 2025 at 03:04:44PM +0530, Ojaswin Mujoo wrote:
> > From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> > 
> > Insert range and collapse range only works with bigalloc in case
> > the range is cluster size aligned, which fsx doesnt take care. To
> > work past this, disable insert range and collapse range on ext4, if
> > bigalloc is enabled.
> > 
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
> 
> If this's a function for fsx only, better to name it with "fsx", e.g.
> _setup_default_fsx_avoid (or some other names).
> 
> > +	case "$FSTYP" in
> > +	"ext4")
> > +		if [[ "$MKFS_OPTIONS" =~ bigalloc ]]; then
> > +			export FSX_AVOID="-I -C"
> 
> Hmm... I'm also wondering if this's an issue should be fixed in fstests. How about
> let the testers who tests ext4 with MKFS_OPTIONS="-O bigalloc" write local.config
> as below?
> 
> [ext4-bigalloc]
> ...
> MKFS_OPTIONS="-O bigalloc"
> FSX_AVOID="-I -C"
> 
> Thanks,
> Zorro

Hey Zorro, 

Basically the idea is that _setup_fs_options is a generic function that
can be used to do any fs specific modifications to the global options.

This way we can set options to avoid known issues with different FSes,
which can otherwise confuse the user if they are not aware of such
issues. 

Does that sound okay?

Regards,
ojaswin

> 
> 
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
> 

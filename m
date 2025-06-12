Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E855F14A8B
	for <fstests@vger.kernel.org>; Thu, 12 Jun 2025 06:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749709068; cv=none; b=fxPh6K4EYKRjne0H938p1uTuPI99tdmwzPi3+LSkN2r9jdd0juHaZpteIBd1VnagvIs7ejVLevY2bSJyFd0jmKSxPGK6XfvgxAGrmVN0SbtAgm0lwrg1ZrPQoszaSQHSUvTBubIsXTVVpKicggOn+V/fgCM63Of6bCw7Dpb7nMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749709068; c=relaxed/simple;
	bh=c0D7hVZ4RHkoe0ubFSseXnaUN5ycBtWvYW8tbPVXWqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6BNPg3AU1POQ1DS7DDKHiga3rPMOqhiAVaNxrDEFSr7Cl+ylbaSvHCTPzhnVdW8TufbQIALXOfu2pyTmwJoFy6Uyq3RXxImDob58ikurbe1T3hWT7fqENjMFPJQg6DtXuyv4SSXxALDrqtB1mcioaya4L2AWVFzN262sXNkR6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=spwEu09S; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="spwEu09S"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C6Gp5G001660;
	Thu, 12 Jun 2025 06:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=KzYdblPtWKEDrH/+aY2UP7wODZk0aM
	jaLSdk2RS7Qzc=; b=spwEu09SZKicf2Zn+6XMUuIvwvpmd+dNYUG/qRmFMXWXsI
	AEQf8qvCVH45JCZ2v/+XaCmJMae6YiERQugggmopyVXgvRrKmWglUbFKzIsEbzAf
	8PdMJG8p+Zls0ZC+O2RzchiTMGjaHSu1EshjtD5pbEDwSeddpThoM43q9+q1Jr7L
	WYwzSA7JEI79BWTxKj7nLtHmP5JCFUi6+chFgxQ1wLaMX12GPBPx3mn8SxiLVym4
	dN45arKGJC2Das02F1JRyJNyuGunZTfWWs5M++dzooWR1sChX7f1AjuPU3xkQYW7
	UuCy/FUQOqNZh1w3lvTsVsm/OIcdldskHise4MLg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4769wywk10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 06:17:41 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55C6EfQe019579;
	Thu, 12 Jun 2025 06:17:40 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4769wywk0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 06:17:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55C6G2gc015006;
	Thu, 12 Jun 2025 06:17:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4750rpbbvh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 06:17:39 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55C6HbSR59376054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 06:17:37 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E9802004F;
	Thu, 12 Jun 2025 06:17:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 460DE20040;
	Thu, 12 Jun 2025 06:17:36 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.249])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 12 Jun 2025 06:17:36 +0000 (GMT)
Date: Thu, 12 Jun 2025 11:47:33 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        john.g.garry@oracle.com
Subject: Re: [RFC 02/12] common/rc: Add a helper to run fsx on a given file
Message-ID: <aEpw_TTDNW8KnBLl@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <0a0604215a992f0aaa4d8d6821b8c8051a0f8d80.1749629233.git.ojaswin@linux.ibm.com>
 <20250611143138.GG6143@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611143138.GG6143@frogsfrogsfrogs>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kO4y16qw79Hc4GkddycATDFMFvyFczJN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDA0NiBTYWx0ZWRfX/3ZZWp8ONTd8 s/U1VjIcmCMydPOFJSnlH3zmAvxjjnhcBY3kYsbhGtRXQvQGYR6Tx7SsXVyZ1ObOETRYc+iaASM xLT1mBE1R10VCLUgZvCVeKnYKnOR5DFePeqDW9ocHaOPasQWq1rsD2dzPesNA+nSgs3V48l5Mfp
 7vFVmX01vEIFOmg8VyHIbAi6fBmQr8/K1X1FlmiPThIjpJ6VZHCjOivH7+5q7I9noihL/wPLDOq sINa+1s9uDg9Nasnc11eQq0xM0EeNf/54uPeoRjTSCTAJVzHpCOHoZErnPzJL73msAz4W1UbHeJ 12cgRThNCsnsO/XBnIfhXHQ3J3lSKkwb8UbtkqySO7MELw5KqWEQJXb6rB2ITyXnGZkI9suWaqm
 IBvWxEdQdQvcpVwggLf8ctjVxmCXMnE0U2MhzT8OtvL9rU4joRKmTFxvqXwiYvXMrQbuIgga
X-Authority-Analysis: v=2.4 cv=YKGfyQGx c=1 sm=1 tr=0 ts=684a7105 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=u_VYNAqGXo6OSSAA:21 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=R4xVnh7huf_bXrLfulYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: VgEG9Db1s2ySm_KkcMbgJWnUyqupBEg8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_03,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 mlxlogscore=940
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506120046

On Wed, Jun 11, 2025 at 07:31:38AM -0700, Darrick J. Wong wrote:
> On Wed, Jun 11, 2025 at 03:04:45PM +0530, Ojaswin Mujoo wrote:
> > Currently run_fsx is hardcoded to run on a file in $TEST_DIR.
> > Add a helper _run_fsx_on_file so that we can run fsx on any
> > given file including in $SCRATCH_MNT. Also, refactor _run_fsx
> > to use this helper.
> > 
> > No functional change is intended in this patch.
> > 
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >  common/rc | 21 ++++++++++++++++++---
> >  1 file changed, 18 insertions(+), 3 deletions(-)
> > 
> > diff --git a/common/rc b/common/rc
> > index cfbe2a5f..a5d811a1 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -5115,13 +5115,22 @@ _require_hugepage_fsx()
> >  		_notrun "fsx binary does not support MADV_COLLAPSE"
> >  }
> >  
> > -_run_fsx()
> > +_run_fsx_on_file()
> >  {
> > +	local testfile=$1
> > +	shift
> > +
> > +	if ! [ -f $testfile ]
> > +	then
> > +		echo "_run_fsx_on_file: $testfile doesn't exist. Creating" >> $seqres.full
> > +		touch $testfile
> > +	fi
> > +
> >  	echo "fsx $*"
> >  	local args=`echo $@ | sed -e "s/ BSIZE / $bsize /g" -e "s/ PSIZE / $psize /g"`
> > -	set -- $FSX_PROG $args $FSX_AVOID $TEST_DIR/junk
> > +	set -- $FSX_PROG $args $FSX_AVOID $testfile
> 
> 	local testfile="${1:-$TEST_DIR/junk}"
> 	...
> 	set -- $FSX_PROG $args $FSX_AVOID $testfile
> 
> Then you don't need the extra helper.
Hi Darrick,

I originally added the extra helper so that we won't need to change the
existing run_fsx calls. For example, with the change you suggested,
generic/263 would need to be changed from:

run_fsx -N 10000  -o 8192   -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z

to 

run_fsx $TEST_DIR/junk -N 10000  -o 8192   -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z

because otherwise, the $1 would actually be "-N" and run_fsx would get
confused. 

However, if you would prefer to drop the helper and rather modify
run_fsx and the call sites to pass a filename, that should be doable as
well. Please let me know your preference on this.


Regards,
ojaswin

> 
> --D
> 
> >  	echo "$@" >>$seqres.full
> > -	rm -f $TEST_DIR/junk
> > +	rm -f $testfile
> >  	"$@" 2>&1 | tee -a $seqres.full >$tmp.fsx
> >  	local res=${PIPESTATUS[0]}
> >  	if [ $res -ne 0 ]; then
> > @@ -5133,6 +5142,12 @@ _run_fsx()
> >  	return 0
> >  }
> >  
> > +_run_fsx()
> > +{
> > +	_run_fsx_on_file $TEST_DIR/junk $@
> > +	return $?
> > +}
> > +
> >  # Run fsx with -h(ugepage buffers).  If we can't set up a hugepage then skip
> >  # the test, but if any other error occurs then exit the test.
> >  _run_hugepage_fsx() {
> > -- 
> > 2.49.0
> > 
> > 

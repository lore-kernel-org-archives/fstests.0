Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48278280A3B
	for <fstests@vger.kernel.org>; Thu, 12 Feb 2026 08:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770886366; cv=none; b=af3w/9HV2GHyT2xCcsU2t4qUa9RoSEukqycxOOZB635XgwnWePjCwIkv+49coJPTPSMbaGEpQIIrrXPTT9KaNBLM+nVmxcAYIhvV1WWHu9lGTQLi6xYUqvFm14oQ9ibFQqnn2656eWn/QBC4mVs5ivyonlha2Mg7NgNKi27As3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770886366; c=relaxed/simple;
	bh=PTwPe8HOHqLqZystQ8/clVx/tydbYkfP/V97DrOr8fU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJPJg9cJz5MeoW9qf+eR0wHU5p/2CgxH9I65ArtfIZzVTTKQ9BAuqo5ZiEzhIacjTcWRI52BVXco2h4oCio+XNa8OiBnX0ZdF81Z+mg4D00AMzoQrAreyh93uuCvIdUckIU45sPhlenuGeKq5+036vJyTq3EJSw4u1iYPfXje5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nxkzKKzS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nxkzKKzS"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61BK4R5T3591169;
	Thu, 12 Feb 2026 08:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=xEGNZg+yqkIyC6bMUQ0XCUv+AQhIGw
	WaKn1aXZP3DoQ=; b=nxkzKKzS47OPP2aX0CN5HU6yPapH2qiQ/1Jlgavpl1kBm7
	Kjz57Q5q21ZUrQK5AuHjYHnismIXRmVMcVYR223WFsHl94y5oP5zGyOE/v23Li+j
	uo8QI3WNSOVuVWAioGMRwCqV92RqjgrTAq/2HzyxAT1v5J0PbmKA4TmDALdi8Q+e
	jyR1wq1tvrEWn1cAnwFPH7ZIWf69F58ysY0GkzAkR6BZb+h9LCDnT8v5FFLcdOAm
	oL6oQrd9oqD3hb2wIftg/piNPXjbClNhX7unyitV02YtlmVX9wN9HC2OXJwUh9ij
	YKCQseeGThFqp4bnK4a9hGMLm39YDAhjCq3pOwcQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696unb0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Feb 2026 08:52:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61C7ZMWI002548;
	Thu, 12 Feb 2026 08:52:41 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6fqsstdq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Feb 2026 08:52:41 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61C8qbXa41943330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Feb 2026 08:52:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE34B2004E;
	Thu, 12 Feb 2026 08:52:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BABA320043;
	Thu, 12 Feb 2026 08:52:36 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 12 Feb 2026 08:52:36 +0000 (GMT)
Date: Thu, 12 Feb 2026 14:22:33 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCH] ext4/307: Calculate donor size to avoid failures for 64k
 bs
Message-ID: <aY2U0YssqaFU_ns9@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20260202132730.589621-1-ojaswin@linux.ibm.com>
 <20260208175443.5h5uy65figlq2y6f@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260208175443.5h5uy65figlq2y6f@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KZnfcAYD c=1 sm=1 tr=0 ts=698d94da cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=x10YoON5D8sjeZZwlCkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDA2NCBTYWx0ZWRfX8AdKbnhWhYzx
 DqFvqbZDay8ww/YEr+ErG9gkoHlhekSYbHOGCAzKeAaB3coykxV8b8rlqLa6NqF2UB7kX3vVtr+
 8I8VS2luIVCJ9TWuxIbmgfLHSZEBPIjN6KgVMp/Yn06nCsJYglceur08CerimWcmY6U6e5+yTwq
 CZ7ElGXTq3CVttLbIq3Lz1IoCfiaDqaKD+Jhg+IvR8bdq9CTeRuQ38MOfxIlf1OkFCJdHGLl9H8
 NSUYsAlXkFk9qoThuFjud7d4NZ4i1iOWoYPxyK+Q815Jys/EdoyXg8RQZhBJE5tPDDaU7banDn3
 sYgQZJTuehHj9o5slkKbUxaMK17nIoTemDXk3Dfb8bykM7qJJ/cVFw3Dbxr98IelJYpHR7rjwC6
 oJZyGdSY3icfpI8CzyMXU+wg9rGA2A8Lv/VMMuT6kxYtsOqw9MsUR3qLByDems/+amw6rigfLD8
 xxL0llQNkN9tUDFHnyQ==
X-Proofpoint-ORIG-GUID: RLZJSArYzSnn8KzBU9iGnQm4LL5cWTax
X-Proofpoint-GUID: RLZJSArYzSnn8KzBU9iGnQm4LL5cWTax
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_02,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602120064

On Mon, Feb 09, 2026 at 01:54:43AM +0800, Zorro Lang wrote:
> On Mon, Feb 02, 2026 at 06:57:30PM +0530, Ojaswin Mujoo wrote:
> > Hard coding donor size to 250M causes the following failure in e4compat
> > 
> > e4compact.c:68: do_defrag_range: Assertion `donor->length >= len' failed.
> > ./common/rc: line 4616: 1583182 Aborted                 (core dumped)
> > 
> > The issue is that e4compat asserts that the stat.st_size of all files
> > combined shouldn't be more than that of the donor file. In case of 64k
> > blocksize, fsstress often creates sparse files which have >3G size even
> > though their disk utilization is <100M. Since donor file is not big
> > enough, this trips e4compat causing the failure.
> > 
> > Fix this by dynamically calculating the donor file size based on the
> > size of all files. Also, make some changes to avoid future ENOSPC like
> > reducing the -n passed to fsstress to keep the size around 2G and making
> > sure we use the whole SCRATCH disk instead of 500M.
> > 
> > While we are at it, add some new lines to make the code bit more
> > readable.
> > 
> > Reported-by: Disha Goel <disgoel@linux.ibm.com>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> 
> Hi,
> 
> Thanks for your patch, but this patch is conflict with v2026.01.27 :
> 	42c2ccaf ("ext4/307: allocate donor file size dynamically")
> 
> both of you were trying to fix the donor file size issue. Please confirm if
> that commit helps you. If you still need further change, please rebase your
> patch on v2026.01.27.

Hi Zorro, 

thanks for pointing this out. Weird that I didn't see this when I
rbeased on master.  I'll test the patch and get back to you.

Regards,
ojaswin
> 
> Thanks,
> Zorro
> 
> >  tests/ext4/307 | 41 +++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 37 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tests/ext4/307 b/tests/ext4/307
> > index 1f0e42ca..7e7fb9c8 100755
> > --- a/tests/ext4/307
> > +++ b/tests/ext4/307
> > @@ -12,24 +12,57 @@ _begin_fstest auto ioctl rw defrag prealloc
> >  # Import common functions.
> >  . ./common/filter
> >  . ./common/defrag
> > +
> > +# Get the total of stat.st_size of each file to determine the
> > +# size of donor file. We use st_size here instead of blocks used
> > +# because thats what e4compat.c checks against.
> > +get_bytes_used() {
> > +	local filelist="$1"
> > +	local total=0
> > +	local blksz=$(_get_block_size $SCRATCH_MNT)
> > +
> > +	while IFS= read -r f; do
> > +		echo -n "File: $f: " >> $seqres.full
> > +		[[ -z "$f" ]] && continue
> > +
> > +		if [[ -f "$f" ]]; then
> > +			local bytes
> > +			bytes=$(stat -c %s "$f")
> > +			total=$((total + bytes))
> > +			echo $bytes >> $seqres.full
> > +		fi
> > +	done < "$filelist"
> > +
> > +	echo "Total bytes: $total" >> $seqres.full
> > +	echo $total
> > +}
> > +
> >  # Disable all sync operations to get higher load
> >  FSSTRESS_AVOID="$FSSTRESS_AVOID -ffsync=0 -fsync=0 -ffdatasync=0"
> >  _workout()
> >  {
> > +	local blksz=$(_get_block_size $SCRATCH_MNT)
> > +
> >  	echo ""
> >  	echo "Run fsstress"
> >  	out=$SCRATCH_MNT/fsstress.$$
> > -	args=`_scale_fsstress_args -p4 -n999 -f setattr=1 -d $out`
> > +	args=`_scale_fsstress_args -p4 -n500 -f setattr=1 -d $out`
> >  	echo "fsstress $args" >> $seqres.full
> >  	_run_fsstress $args
> > +
> >  	find $out -type f > $out.list
> >  	cat $out.list | xargs  md5sum > $out.md5sum
> > -	usage=`du -sch $out | tail -n1 | gawk '{ print $1 }'`
> > +
> > +	bytes=`get_bytes_used $out.list`
> > +	echo "Total bytes used: $bytes" >> $seqres.full
> > +
> >  	echo "Allocate donor file"
> > -	$XFS_IO_PROG -c "falloc 0 250M" -f $SCRATCH_MNT/donor | _filter_xfs_io
> > +	$XFS_IO_PROG -c "falloc 0 $bytes" -f $SCRATCH_MNT/donor | _filter_xfs_io
> > +
> >  	echo "Perform compacting"
> >  	cat $out.list | run_check $here/src/e4compact \
> >  		-i -v -f $SCRATCH_MNT/donor  >> $seqres.full 2>&1
> > +
> >  	echo "Check data"
> >  	run_check md5sum -c $out.md5sum
> >  }
> > @@ -41,7 +74,7 @@ _require_scratch
> >  _require_defrag
> >  _require_xfs_io_command "falloc"
> >  
> > -_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
> > +_scratch_mkfs >> $seqres.full 2>&1
> >  _scratch_mount
> >  
> >  _workout
> > -- 
> > 2.52.0
> > 
> 

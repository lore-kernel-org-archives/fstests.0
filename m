Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E1E2D6E71
	for <fstests@vger.kernel.org>; Fri, 13 Feb 2026 09:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770974515; cv=none; b=QgiYnY1OqhyvbOrgNzzMo4M72k4mE8u2KWGT8zqLaKY8Fw2qXbcN7gMCVX4rBjWv3hE2Kc2TxKre7GUza8RFFz52yU6hE8ObeJmt5b3pCBmZl9PLzNqeHyb/WtOa5oQPDwdjvtsuyqQFj+ZVksEKB3HkhmKNsPdvELe9pWwr0Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770974515; c=relaxed/simple;
	bh=3uOeeq5PgaucRHhAKdR4DYEvUR1N3/LwZN3JYfz1WzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlxP7Yug6RoYhyClEMAcr7no+eWEZzesu4GbEa3DnM8TQSowOmxCoQfoC8GQiiwVZMUpxUCmKiFdnY2LfK7PX3Hk+kd0qvFVSulPEM58WEtL/A3/7v3s+EZl18nT0PxAk67r2UK6dZfWJIF7+xmvG6M8e/ZeDblNDPBB01zjY+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s60PsvcE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s60PsvcE"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CH3Wa1192099;
	Fri, 13 Feb 2026 09:21:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=DXuHXUz/+cRGclC9qCtmCRcH60RTtj
	j0MTtK1etlHxo=; b=s60PsvcEmZz46KEiO1d/ONg0OBVEZmdxmnhZD742mqvWKc
	u+rbr5/6Ej7g1iQjPs0UyXSvEPSx5oyg97N7guF8kFL/PwbkpDcEaEVQ/11QtVv0
	CNqzCGudxeOTl935NhvzBpsK/8yjMzNf7ndQHFtdUXtd7y9PrWixe8YHx0Q0ZXfM
	mr8S6i+cHDvVOquaoYNqtOxq/5Fq+dgYVcRnG2kFFvnezbxIYmaTJVBWWRGvLNnr
	/8ruRRIMdpsLCr7rUw7VJPVxR4L33d1+Yphgl5DuzEmDgXxBSux2daxrDcgbqAxJ
	U/DeCIKnhRko5GLRONmyOV9zmYXugJGA3LaIy3wA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696ut85d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Feb 2026 09:21:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61D7EMu0008883;
	Fri, 13 Feb 2026 09:21:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6g3ypab8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Feb 2026 09:21:50 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61D9Lkqx50856322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Feb 2026 09:21:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DC602004B;
	Fri, 13 Feb 2026 09:21:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 118112005A;
	Fri, 13 Feb 2026 09:21:45 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.23.148])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 13 Feb 2026 09:21:44 +0000 (GMT)
Date: Fri, 13 Feb 2026 14:51:42 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCH] ext4/307: Calculate donor size to avoid failures for 64k
 bs
Message-ID: <aY7tBJN2IozL4lk4@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20260202132730.589621-1-ojaswin@linux.ibm.com>
 <20260208175443.5h5uy65figlq2y6f@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aY2U0YssqaFU_ns9@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20260212185332.y7ndgibqix7tmibs@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212185332.y7ndgibqix7tmibs@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=YZiwJgRf c=1 sm=1 tr=0 ts=698eed2f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=4jk_VT3jfnzo7w-rDOgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: EzI4U5Ujgh_HL6IQCv1nf06Sj5FA3-Fw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA3MSBTYWx0ZWRfX0tIWS3cbcuuI
 knPCICoGfkYMrC45okQFjkvWhTB1ofMvjiOWd+tlL5X+Bxv+u1kS7zljKAcyYlbV0ASqSqoBYUV
 F02AFHBpSZPV6+K/PrKqDSjn6SNugF7GS0cc0eYLjoP7FUU/pBZfWb3sWI9ofjB/9rzs8bFULzH
 gLO2wHwP4DNYklraBASf/FqfZoLoqKycTU2HZqRMSCkhiEwtwUvUdina/NsmnZrdEZEFt+jnODl
 cXP29j1Q3l2ATNYDx/56AI8s6jtzkPNfMoC95e300010+K7qYFtKBBFZzUvktPuhok+Q9GNIo6G
 aMnrEHenQjLCdUunFiJ1fMDZaKwOly+Z7OwNl0hUQzzGmGXSyXfi8phtBuh5aqXUMRiomQJS7MM
 J5PQyMzzPnFWNYyTDD6RHZbHWek5yKBxTJs38qoEDJFxZ1S4ris7zZQRTqtWHEyYKZICKyMFO6s
 jVIaTyB8zNB/d8xKMyA==
X-Proofpoint-GUID: EzI4U5Ujgh_HL6IQCv1nf06Sj5FA3-Fw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130071

On Fri, Feb 13, 2026 at 02:53:32AM +0800, Zorro Lang wrote:
> On Thu, Feb 12, 2026 at 02:22:33PM +0530, Ojaswin Mujoo wrote:
> > On Mon, Feb 09, 2026 at 01:54:43AM +0800, Zorro Lang wrote:
> > > On Mon, Feb 02, 2026 at 06:57:30PM +0530, Ojaswin Mujoo wrote:
> > > > Hard coding donor size to 250M causes the following failure in e4compat
> > > > 
> > > > e4compact.c:68: do_defrag_range: Assertion `donor->length >= len' failed.
> > > > ./common/rc: line 4616: 1583182 Aborted                 (core dumped)
> > > > 
> > > > The issue is that e4compat asserts that the stat.st_size of all files
> > > > combined shouldn't be more than that of the donor file. In case of 64k
> > > > blocksize, fsstress often creates sparse files which have >3G size even
> > > > though their disk utilization is <100M. Since donor file is not big
> > > > enough, this trips e4compat causing the failure.
> > > > 
> > > > Fix this by dynamically calculating the donor file size based on the
> > > > size of all files. Also, make some changes to avoid future ENOSPC like
> > > > reducing the -n passed to fsstress to keep the size around 2G and making
> > > > sure we use the whole SCRATCH disk instead of 500M.
> > > > 
> > > > While we are at it, add some new lines to make the code bit more
> > > > readable.
> > > > 
> > > > Reported-by: Disha Goel <disgoel@linux.ibm.com>
> > > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > > ---
> > > 
> > > Hi,
> > > 
> > > Thanks for your patch, but this patch is conflict with v2026.01.27 :
> > > 	42c2ccaf ("ext4/307: allocate donor file size dynamically")
> > > 
> > > both of you were trying to fix the donor file size issue. Please confirm if
> > > that commit helps you. If you still need further change, please rebase your
> > > patch on v2026.01.27.
> > 
> > Hi Zorro, 
> > 
> > thanks for pointing this out. Weird that I didn't see this when I
> > rbeased on master.  I'll test the patch and get back to you.
> 
> You can always rebase to "for-next" branch to get latest version, or check
> "patches-in-queue" scratch branch. The master branch is lagging behind :)

Ahh got it, thanks :)

Regards,
ojaswin
> 
> > 
> > Regards,
> > ojaswin
> > > 
> > > Thanks,
> > > Zorro
> > > 
> > > >  tests/ext4/307 | 41 +++++++++++++++++++++++++++++++++++++----
> > > >  1 file changed, 37 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/tests/ext4/307 b/tests/ext4/307
> > > > index 1f0e42ca..7e7fb9c8 100755
> > > > --- a/tests/ext4/307
> > > > +++ b/tests/ext4/307
> > > > @@ -12,24 +12,57 @@ _begin_fstest auto ioctl rw defrag prealloc
> > > >  # Import common functions.
> > > >  . ./common/filter
> > > >  . ./common/defrag
> > > > +
> > > > +# Get the total of stat.st_size of each file to determine the
> > > > +# size of donor file. We use st_size here instead of blocks used
> > > > +# because thats what e4compat.c checks against.
> > > > +get_bytes_used() {
> > > > +	local filelist="$1"
> > > > +	local total=0
> > > > +	local blksz=$(_get_block_size $SCRATCH_MNT)
> > > > +
> > > > +	while IFS= read -r f; do
> > > > +		echo -n "File: $f: " >> $seqres.full
> > > > +		[[ -z "$f" ]] && continue
> > > > +
> > > > +		if [[ -f "$f" ]]; then
> > > > +			local bytes
> > > > +			bytes=$(stat -c %s "$f")
> > > > +			total=$((total + bytes))
> > > > +			echo $bytes >> $seqres.full
> > > > +		fi
> > > > +	done < "$filelist"
> > > > +
> > > > +	echo "Total bytes: $total" >> $seqres.full
> > > > +	echo $total
> > > > +}
> > > > +
> > > >  # Disable all sync operations to get higher load
> > > >  FSSTRESS_AVOID="$FSSTRESS_AVOID -ffsync=0 -fsync=0 -ffdatasync=0"
> > > >  _workout()
> > > >  {
> > > > +	local blksz=$(_get_block_size $SCRATCH_MNT)
> > > > +
> > > >  	echo ""
> > > >  	echo "Run fsstress"
> > > >  	out=$SCRATCH_MNT/fsstress.$$
> > > > -	args=`_scale_fsstress_args -p4 -n999 -f setattr=1 -d $out`
> > > > +	args=`_scale_fsstress_args -p4 -n500 -f setattr=1 -d $out`
> > > >  	echo "fsstress $args" >> $seqres.full
> > > >  	_run_fsstress $args
> > > > +
> > > >  	find $out -type f > $out.list
> > > >  	cat $out.list | xargs  md5sum > $out.md5sum
> > > > -	usage=`du -sch $out | tail -n1 | gawk '{ print $1 }'`
> > > > +
> > > > +	bytes=`get_bytes_used $out.list`
> > > > +	echo "Total bytes used: $bytes" >> $seqres.full
> > > > +
> > > >  	echo "Allocate donor file"
> > > > -	$XFS_IO_PROG -c "falloc 0 250M" -f $SCRATCH_MNT/donor | _filter_xfs_io
> > > > +	$XFS_IO_PROG -c "falloc 0 $bytes" -f $SCRATCH_MNT/donor | _filter_xfs_io
> > > > +
> > > >  	echo "Perform compacting"
> > > >  	cat $out.list | run_check $here/src/e4compact \
> > > >  		-i -v -f $SCRATCH_MNT/donor  >> $seqres.full 2>&1
> > > > +
> > > >  	echo "Check data"
> > > >  	run_check md5sum -c $out.md5sum
> > > >  }
> > > > @@ -41,7 +74,7 @@ _require_scratch
> > > >  _require_defrag
> > > >  _require_xfs_io_command "falloc"
> > > >  
> > > > -_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
> > > > +_scratch_mkfs >> $seqres.full 2>&1
> > > >  _scratch_mount
> > > >  
> > > >  _workout
> > > > -- 
> > > > 2.52.0
> > > > 
> > > 
> > 
> 

Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BECC36AB45
	for <fstests@vger.kernel.org>; Tue, 24 Feb 2026 09:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771926344; cv=none; b=T1V7IXz8CjhwqSm4s39Npa23KPoij0iElucdt7tKjF/p/yX7WXayb/es7coRHfkRnGjHxNJ+PQA2nUkELSEk7G6I06ZX3aCPOqWE8YpscFVY0qI3WMVRSLvEP2cl9uw4jqqqOGut0Lp/fQELfjMnyiDFtKu3S3bWonMDnwwNkFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771926344; c=relaxed/simple;
	bh=TnTPOG4BRwKm+XaC92LoWgfP2LM2LbIoKJYHsr0FxX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+J2d6m7K3b+MUY3aUQXkXAhRx2n3c/ALdrzgJKJmNOtTHdeRJvG9zAm1r4F4jGozbtJzmfYqYtQxE1jKasJA9ShN1TBruv3OgmFFJrW+6jqT8HCGWxL25raWlBBH+h9p3eJ+Is3/ikT6eztXdC8n/loAUIdXAprgz8rgUgz+hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lW6i4A/8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lW6i4A/8"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61O7AHE32722347;
	Tue, 24 Feb 2026 09:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=SyPGJGBTZ/cFzWR0fDTh2dKeYOmqkH
	bBfn4GY1/LnK8=; b=lW6i4A/8xMYn9EJIRT+BvHYrq8pDdagN3OMrs6zFYm+TXr
	yM0z0/WX6Mj5BBYHMiyqQ0oZKBvbNmxg5+JgdN/9oBaWDEDu6tlA7RP4YVhVldhM
	OlnMDiXdFuT46FazR6/YLeBlTQlZLEIyPxRFtCFIjM/nlyVMhFG5m9JkWZxC0duJ
	7PiBwnDpdURhp0iZUu3jecrWduvwFk8PrCT7KITgt8p9SU91hFB55AVsTp7uyTGB
	b59P93miVW1Mkk0AcqWD6ncHmVaWFsXXEDXSId5l2byeRSNvy775dNXSzkqGXbLm
	YMtPrL9k/dzEplfeLrs78iq7vhBlXWi1k9uAGjDQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf471tyg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 09:45:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61O8XJTa003382;
	Tue, 24 Feb 2026 09:45:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfs8jr5jb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 09:45:40 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61O9jaTI58720572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 09:45:36 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFE4720077;
	Tue, 24 Feb 2026 09:45:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F74920072;
	Tue, 24 Feb 2026 09:45:35 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 24 Feb 2026 09:45:34 +0000 (GMT)
Date: Tue, 24 Feb 2026 15:15:32 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCH] ext4/307: Calculate donor size to avoid failures for 64k
 bs
Message-ID: <aZ1zPIXNF_yzVzLi@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
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
X-Proofpoint-ORIG-GUID: OyNUi75y0wntHtXOP1TWx5FZcRi9jnOY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA4MSBTYWx0ZWRfX4N+8RKcucABT
 FNVWWeHg87jRL4hjbQvr6wUZq5XEwp8J8n2TFEITp58WNeOoqEZ3PKQhmj3en7OwZ1Q8wztfc5x
 RZNP4oKnK/Wco1mb9esuhbJwUeW5EINCeAaCk2vAC8RL1RvptFeL30XztIhVF2l+BRW+sZc59YT
 rSArI9RVKMdrruK+pRyE27UHqCm4ICJQyW8QxGpAa+RYutHuYPT0YyJm/rx7OocytBkFsXF/nw/
 lzhjQGRyg1tK5RP1Q3JK+UGezejO8VfFUhNvxpLeITmFbURtD+6JxsH1mblivqDn+KZXka0U218
 sIgfSXaRrYsIYFGxERj5Foea0oONcl36VE3v2+TpcKfANDLtk/KI3pf5+DGtnasUbUO7SfMI42u
 9mrMzz3mdu/5Mb8rJ3K96dXWSLprqtoOJJhS+/LDOSGBkwaF+TDbigwe1pmEfmCJTS5duScCV95
 cwHLWkfYmWT3L5fKlRg==
X-Authority-Analysis: v=2.4 cv=R7wO2NRX c=1 sm=1 tr=0 ts=699d7345 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=OdYjgmpOvPaEoS2GKVIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: OyNUi75y0wntHtXOP1TWx5FZcRi9jnOY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602240081

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
> 
> Thanks,
> Zorro

Hi Zorro,

Sorry for the delay but we tested this again with 64k bs ext4 but the
test still fails. The issue is that e4compat.c essentially asserts:

(sum of stat.st_size of all files) <= donor stat.st_size

But in the merged patch we are using du -sm which gives the blocks
used instead of the filesize.

Below are the numbers for 64k blocksize run:

du -sm <fsstress dir>:
132  // 132M

/* sum of stat.st_size of all files */
find <fsstress dir> -type f -printf '%s\n' | awk '{s+=$1} END {print s}'
5110092115  // ~4G

stat -c %s donor
138412032  // 132M 

Since donor is still smaller than the sum of sizes of all the files,
e4compat eventually hits an assert() causing the crash.

The patch shared in this thread takes care of this. However, it has also
got me wondering whether the right fix would be to instead fix e4compat
to compare blocks used instead of file sizes. I've not looked at the
code closely yet but I don't see a reason why we should rely on donor
being as big as the sum of sizes, when all we need is that the blocks
used by each file should fit in the donor size.

What do you think?

Regards,
ojaswin

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

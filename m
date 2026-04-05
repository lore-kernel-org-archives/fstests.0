Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5544DBA45
	for <fstests@vger.kernel.org>; Sun,  5 Apr 2026 15:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775401645; cv=none; b=ZTDq/EpyGPyVHxtj177EhERsl9hmcjosts1WxSjD5ZxjXJvA+yV03UDSXWGU1X8t7cebGMFupMsWpHfizIfLa56r7aIabZ28RXwsApX6TQMkQ0lHLdAMdQefiIzn1JBk1+iqwE3jtOd/4GD1EXmuOW1dN8ZfZISR8Ibh5Y7vHUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775401645; c=relaxed/simple;
	bh=7c9YWzZCH4B4YAuNt/zF5QNB4rNx2ZnkeI/j8rfBXlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnX8C4aRKCQSQy8kgqBXj3qeVlK4FkSq8xwS/aPnHxNbnymnuhWU2ogbPK/iJkffcQ74EvWqfxgg5HCfLrEqR/Ny4DGXdplROXi+sBd4Uh5jTfb/illbbvPX949h9O+HhFlkphp0mbl8nE5DkuUaw6yl8zomdg37ztNWMgVLy2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FwIn/mLV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FwIn/mLV"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6359G4v92165713;
	Sun, 5 Apr 2026 15:07:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=GmzUY0MBrmpqD7zpVjJXX9Wf4n8pcL
	WC9xIIVgt0ykE=; b=FwIn/mLVnyJv+mnoFI5DmqdWMS/WI/dkA+imd7lP9OZ/W3
	eGv5Sf8pmup3+VL1farfGzY3ApUXx7TkGgDobEAlsYW4PVLOnEU6p/8LHjjaEMuI
	qud2+EL7n+65rXbmkGDQWeu9nzO5yiLcdLnV7xU1Z74tE6Gbu4PTOxh4e/uswI2B
	EDxzaUZd6zNs8/htnbub16ZlzBE2m3YQYB2yDjVOynJpyIx5ae8QwjNeoMOAqhSs
	6ELqKZ/rWG/SGnPLBDD5/pviIGMpXqiB6npEtiswZo9wW1n5roLEZ8BV4/4ylbAK
	N/AhiPCFDO4Q5AVfMwdho0tGfHv3fVy6gagaCNMQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4das2buj0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 05 Apr 2026 15:07:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 635AdNHB006360;
	Sun, 5 Apr 2026 15:07:19 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dbfp1heae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 05 Apr 2026 15:07:18 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 635F7HVM50004224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 5 Apr 2026 15:07:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E2CB2004B;
	Sun,  5 Apr 2026 15:07:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C64B220040;
	Sun,  5 Apr 2026 15:07:15 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.211.21])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun,  5 Apr 2026 15:07:15 +0000 (GMT)
Date: Sun, 5 Apr 2026 20:37:12 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCH 2/4] generic/765: Fix sysfs path for nvme partitions
Message-ID: <adJ6oJrKl8BEDqHz@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <726e43008315a1bed018c1b43aae2458aebc03bc.1775039135.git.ojaswin@linux.ibm.com>
 <7fe6154353d38b2dc308db16d8125b83a8ed7daf.1775039135.git.ojaswin@linux.ibm.com>
 <20260401140829.GG6212@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401140829.GG6212@frogsfrogsfrogs>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yvn-BhWbTgmIcaR9TwTKTfGwFvJ2IRy6
X-Proofpoint-GUID: yvn-BhWbTgmIcaR9TwTKTfGwFvJ2IRy6
X-Authority-Analysis: v=2.4 cv=U9qfzOru c=1 sm=1 tr=0 ts=69d27aa7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=3gObefBNqpDEg7EijTIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA1MDE1NCBTYWx0ZWRfX2Fi0SIR7L5Jy
 SYZa0NFVv1c/eNoVMHINS02sr0/s4UdmMtK3LghRcwLCU57iri19jfn2nng80dFq95Oox+eggUl
 gxjhkggDWNc+4r0EFJH184Ve4NI1pr5m4ANVKdtlgeeIAY3BGLyDEw32WnSYUkYX8s3SX5CmpO1
 kLLlgzXEhuapWZgv5zTOfDmdNzKSGJ67VuDxYtqpkitShdo/5cXAtY/I48Z0/wquwUXW+vo+h43
 5Jnni6BVT4UzP/0GRNJJjTfUMTfbnopwbjiP6l5QBejMZlPb+aJHi1DgzLpV6+GhDayA5UPDnGi
 3RZUUqco05wTc7nQN6z99+OweCPf80ZMwzpfEfgOb3lSBT/47s9qHZ7/rC4s/o/R20Jb1XQA+pr
 4uBLoO8iS7PRTu0bXBQdK7wXiAF3LbzpH3DgHbAX3LCwGMErd27F99ExgOTFlR3IyFzEXucs0J4
 vxscb4Vff/pdhMkaxqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-05_05,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604050154

On Wed, Apr 01, 2026 at 07:08:29AM -0700, Darrick J. Wong wrote:
> On Wed, Apr 01, 2026 at 04:10:48PM +0530, Ojaswin Mujoo wrote:
> > This tests checks atomic write limits reported by statx() are same as
> > the ones reported by sysfs, however nvme partitions don't have the
> > /sys/block/nvme0n1p1 style entry and also use the namespace's queue
> > limits for atomic writes. This causes the test to fail because it
> > expects /sys/block/nvme0n*p* to be present.
> > 
> > Hence, in this case, just check against the parent namespace.
> > 
> > Reported-by: Disha Goel <disgoel@linux.ibm.com>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >  tests/generic/765 | 23 +++++++++++++++++++----
> >  1 file changed, 19 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tests/generic/765 b/tests/generic/765
> > index 8c4e0bd0..4c768783 100755
> > --- a/tests/generic/765
> > +++ b/tests/generic/765
> > @@ -94,16 +94,31 @@ test_atomic_writes()
> >      _scratch_unmount
> >  }
> >  
> > -sys_min_write=$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/queue/atomic_write_unit_min_bytes")
> > -sys_max_write=$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/queue/atomic_write_unit_max_bytes")
> 
> I see this show up in a few other places:
> 
> $ git grep /sys/block
> common/dmlogwrites:64:  local sysfs="/sys/block/$(_short_dev $1)"
> common/rc:2567: local sysfs="/sys/block/$(_short_dev $SCRATCH_DEV)"
> common/rc:2631: if [ -e /sys/block/${sdev}/queue/zoned ]; then
> common/rc:2632:         cat /sys/block/${sdev}/queue/zoned
> common/scsi_debug:67:   device=`grep -wl scsi_debug /sys/block/sd*/device/model | awk -F / '{print $4}'`
> tests/btrfs/076:31:     zone_append_max=$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/queue/zone_append_max_bytes")
> tests/btrfs/237:48:zone_size=$(($(cat /sys/block/${sdev}/queue/chunk_sectors) << 9))
> tests/btrfs/283:29:     zone_append_max=$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/queue/zone_append_max_bytes")
> vests/generic/108:20:   echo running > /sys/block/`_short_dev $SCSI_DEBUG_DEV`/device/state
> tests/generic/108:81:echo offline > /sys/block/`_short_dev $SCSI_DEBUG_DEV`/device/state
> tests/generic/730:56:echo 1 > /sys/block/$(_short_dev $SCSI_DEBUG_DEV)/device/delete
> tests/generic/731:49:echo 1 > /sys/block/`_short_dev $SCSI_DEBUG_DEV`/device/delete
> tests/generic/765:97:sys_min_write=$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/queue/atomic_write_unit_min_bytes")
> tests/generic/765:98:sys_max_write=$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/queue/atomic_write_unit_max_bytes")
> 
> So I wonder if the same problem exists there as well?

Okay so seems like there general rule in the kernel is:

File: block/partitions/core.c:336-339

dname = dev_name(ddev);
if (isdigit(dname[strlen(dname) - 1]))
    dev_set_name(pdev, "%sp%d", dname, partno);
else
    dev_set_name(pdev, "%s%d", dname, partno);

So any device where names end with numbers follow the name<%d>p<%d>
scheme for partitions. 

I was not completely sure if this is something only nvmes follow but
looking into the code a bit (from my limited understanding of the blkdev
code) seems like all  partiions just inherit parent's queues and sysfs
"queue" is only for the parent (struct gendisk) rather than partiions.

So I think a more generic way would be to check if dev is a partitions
and then get the correct path for it:

dev_is_partition() {
    local dev
    dev=$(_short_dev "$1")

    [[ -e /sys/class/block/$dev/partition ]]
}

dev_get_queue_path() {
    local dev parent
    dev=$(_short_dev "$1")

    if dev_is_partition "$dev"; then
        parent=$(basename "$(readlink -f /sys/class/block/$dev/..)")
    else
        parent="$dev"
    fi

    echo "/sys/block/$parent/queue"
}

Does that look okay?

Regards,
ojaswin

> 
> (Well, maybe not the scsi-debug users)
> 
> > +# Get the right sysfs dev for the atomic write device
> > +get_aw_dev() {
> > +    local dev
> > +    dev=$(_short_dev "$1")
> > +
> > +    # Special case: nvme partitions don't have the /sys/block/nvme0n1p1 style
> > +    # entry and also use the namespace's queue limits for atomic writes, hence
> > +    # just return the parent namespace.
> > +    if [[ $dev == nvme* ]]; then
> > +        echo "${dev%%p[0-9]*}"
> > +    else
> > +        echo "$dev"
> > +    fi
> > +}
> 
> Perhaps this ought to turn into a common helper to fix them all?
> 
> _sys_block_path() {
> 	local dev=$(_short_dev "$1")
> 
> 	# Special case: nvme partitions don't have the /sys/block/nvme0n1p1 style
> 	# entry and also use the namespace's queue limits for atomic writes, hence
> 	# just return the parent namespace.
> 	if [[ $dev == nvme* ]]; then
> 		echo "/sys/block/${dev%%p[0-9]*}"
> 	else
> 		echo "/sys/block/$dev"
> 	fi
> }
> 
> sys_min_write=$(_sys_block_path $SCRATCH_DEV)/queue/<whatever>)
> 
> Also, don't some of the other block devices follow this "partition has
> pXXX suffix" pattern as well?  Not that I have a clue why scsi doesn't
> follow that pattern or even which part of sd.c triggers the sdaX
> behavior. :/
> 
> --D
> 
> > +
> > +sys_min_write=$(cat "/sys/block/$(get_aw_dev $SCRATCH_DEV)/queue/atomic_write_unit_min_bytes")
> > +sys_max_write=$(cat "/sys/block/$(get_aw_dev $SCRATCH_DEV)/queue/atomic_write_unit_max_bytes")
> >  
> >  bdev_min_write=$(_get_atomic_write_unit_min $SCRATCH_DEV)
> >  bdev_max_write=$(_get_atomic_write_unit_max $SCRATCH_DEV)
> >  
> >  echo "sysfs awu_min $sys_min_write" >> $seqres.full
> > -echo "sysfs awu_min $sys_max_write" >> $seqres.full
> > +echo "sysfs awu_max $sys_max_write" >> $seqres.full
> >  echo "bdev awu_min $bdev_min_write" >> $seqres.full
> > -echo "bdev awu_min $bdev_max_write" >> $seqres.full
> > +echo "bdev awu_max $bdev_max_write" >> $seqres.full
> >  
> >  # Test that statx atomic values are the same as sysfs values
> >  if [ "$sys_min_write" -ne "$bdev_min_write" ]; then
> > -- 
> > 2.53.0
> > 
> > 

Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DF7327C00
	for <fstests@vger.kernel.org>; Tue,  7 Apr 2026 14:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573309; cv=none; b=A4zTjthVW1c1/IhpUc/7w6DpeesxNCfP4tqZL/IdaR1jAnZIgVTJzfcewspZ/gL0OWX5RoJeRu3xOfZXJOrDQxFvPzINa+MHkRTjxCQbJS0Q5JvHeXBjOVTmdErQ/3xmfGp675TqkyFdH1bhHf0NaFlTuGSLNMdNjFtXwVjPpVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573309; c=relaxed/simple;
	bh=eU6llCDkjkJxRC6vrd/tdaiUMzbAEFH1hM6f66e1Xb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCNWzFAu8U+kl0hwTbXm5AyuzC76/dmXPYtfVYez2RjoehFL08pibErlQo1UDjffyXcd6Ldv4VhUr0va1iaTndRTq589i4/pw/Ts89wXMTkusikp2LbWfj7fispLn+CMZ6VJaR21ljijhTgXJGBcALRxr42TyS1Mumy1gLX3kQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qTUz46Kd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qTUz46Kd"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637DjprJ2591197;
	Tue, 7 Apr 2026 14:48:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=xM0NjxO5q6UMVEf8jD9s036qHxSnlm
	sevRDelkqpwAQ=; b=qTUz46Kd0RVNUC6ePM6YCo1ZedalGzgFfCgWC0LZZMymHf
	CupcrDyJk3E/AM6qYW174ByvlFxJjvY5+MB/Iy8rmtGkZGqEfuTETuvXkkkuHlFR
	8PCAU8t7NFwYGtZYvVH4ehao+OoqYR7J8QMCywtKcTnhoSVgoOisu9aTR2X150r+
	D/+8OYPKeCg6YZoihJ3nKjHfP+159W1/kqmekNt/hVMfI9i30GVD1OhNp6ZY2HUP
	/6vTylT+V8ce7fwQW0QRLB3DdLZI8Rfkw4M9rh3CskHTsGP3NsXFJwAIADvImXe1
	i3XuNntziCwGbZ9jfI5E1A9oQez9Eh+hhysEJubg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2e3ka5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 14:48:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637ETT9n013855;
	Tue, 7 Apr 2026 14:48:14 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmf43kkt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 14:48:14 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637EmC3224969654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 14:48:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86A6120040;
	Tue,  7 Apr 2026 14:48:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 124C12004B;
	Tue,  7 Apr 2026 14:48:11 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.21.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  7 Apr 2026 14:48:10 +0000 (GMT)
Date: Tue, 7 Apr 2026 20:18:08 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCH 2/4] generic/765: Fix sysfs path for nvme partitions
Message-ID: <adUZKG8WGFh-jau-@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <726e43008315a1bed018c1b43aae2458aebc03bc.1775039135.git.ojaswin@linux.ibm.com>
 <7fe6154353d38b2dc308db16d8125b83a8ed7daf.1775039135.git.ojaswin@linux.ibm.com>
 <20260401140829.GG6212@frogsfrogsfrogs>
 <adJ6oJrKl8BEDqHz@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20260406154358.GN6212@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406154358.GN6212@frogsfrogsfrogs>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QDX9AqtJ3lsqemPVaAQHJ9QWWmPVW71d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEzMSBTYWx0ZWRfX050fhmEtbeuK
 S5WmxNxgdtMgjI90FkqoOLvLaJiWTlNeRu0QT1A2KFEiC0AvhmSWD0QaXFuFKiAj37V1Q8zQ70r
 D5IGy9xW3/JAZNewsvqHQPN2PGqyKMXQjnkDBX6K0XkUdnuiAFvooWNdWQYPxxWy9Vl0iC9CXVi
 /FTu/ZqSWLQxiD0gaAs94kFTQYlExqmpco8VPgOLypvs1f+iBhD4iIa1hH32v4UDSSMuau6XZLZ
 zGs2B4h7tVBcEjUPjVo4OLVjOombo7v6fuwZ+36hRjujGCbF+Hr9oFkgPtEtmgHgeGqUS9Yr+/g
 bXq8laQ89kOrFJzKSDcObRLqQIlQUEX+z1sHODoXuza2TGobEex6v+PqPYZ0AYUUGN539prCyrw
 AeD01jDEaz7H1d2Sd1C5+V+9WSa+00uVnfQ/GkY8Cd9JJ4JysdyPZ+uElvGU3AgMYB+7cKgsX9t
 Jjq9uG+BY62rPZt5i3Q==
X-Authority-Analysis: v=2.4 cv=Cfw4Irrl c=1 sm=1 tr=0 ts=69d5192f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=WuEUJKXqR88JhohmMXYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: QDX9AqtJ3lsqemPVaAQHJ9QWWmPVW71d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070131

On Mon, Apr 06, 2026 at 08:43:58AM -0700, Darrick J. Wong wrote:
> On Sun, Apr 05, 2026 at 08:37:12PM +0530, Ojaswin Mujoo wrote:
> > On Wed, Apr 01, 2026 at 07:08:29AM -0700, Darrick J. Wong wrote:
> > > On Wed, Apr 01, 2026 at 04:10:48PM +0530, Ojaswin Mujoo wrote:
> > > > This tests checks atomic write limits reported by statx() are same as
> > > > the ones reported by sysfs, however nvme partitions don't have the
> > > > /sys/block/nvme0n1p1 style entry and also use the namespace's queue
> > > > limits for atomic writes. This causes the test to fail because it
> > > > expects /sys/block/nvme0n*p* to be present.
> > > > 
> > > > Hence, in this case, just check against the parent namespace.
> > > > 
> > > > Reported-by: Disha Goel <disgoel@linux.ibm.com>
> > > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > > ---
> > > >  tests/generic/765 | 23 +++++++++++++++++++----
> > > >  1 file changed, 19 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/tests/generic/765 b/tests/generic/765
> > > > index 8c4e0bd0..4c768783 100755
> > > > --- a/tests/generic/765
> > > > +++ b/tests/generic/765
> > > > @@ -94,16 +94,31 @@ test_atomic_writes()
> > > >      _scratch_unmount
> > > >  }
> > > >  
> > > > -sys_min_write=$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/queue/atomic_write_unit_min_bytes")
> > > > -sys_max_write=$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/queue/atomic_write_unit_max_bytes")
> > > 
> > > I see this show up in a few other places:
> > > 
> > > $ git grep /sys/block
> > > common/dmlogwrites:64:  local sysfs="/sys/block/$(_short_dev $1)"
> > > common/rc:2567: local sysfs="/sys/block/$(_short_dev $SCRATCH_DEV)"
> > > common/rc:2631: if [ -e /sys/block/${sdev}/queue/zoned ]; then
> > > common/rc:2632:         cat /sys/block/${sdev}/queue/zoned
> > > common/scsi_debug:67:   device=`grep -wl scsi_debug /sys/block/sd*/device/model | awk -F / '{print $4}'`
> > > tests/btrfs/076:31:     zone_append_max=$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/queue/zone_append_max_bytes")
> > > tests/btrfs/237:48:zone_size=$(($(cat /sys/block/${sdev}/queue/chunk_sectors) << 9))
> > > tests/btrfs/283:29:     zone_append_max=$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/queue/zone_append_max_bytes")
> > > vests/generic/108:20:   echo running > /sys/block/`_short_dev $SCSI_DEBUG_DEV`/device/state
> > > tests/generic/108:81:echo offline > /sys/block/`_short_dev $SCSI_DEBUG_DEV`/device/state
> > > tests/generic/730:56:echo 1 > /sys/block/$(_short_dev $SCSI_DEBUG_DEV)/device/delete
> > > tests/generic/731:49:echo 1 > /sys/block/`_short_dev $SCSI_DEBUG_DEV`/device/delete
> > > tests/generic/765:97:sys_min_write=$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/queue/atomic_write_unit_min_bytes")
> > > tests/generic/765:98:sys_max_write=$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/queue/atomic_write_unit_max_bytes")
> > > 
> > > So I wonder if the same problem exists there as well?
> > 
> > Okay so seems like there general rule in the kernel is:
> > 
> > File: block/partitions/core.c:336-339
> > 
> > dname = dev_name(ddev);
> > if (isdigit(dname[strlen(dname) - 1]))
> >     dev_set_name(pdev, "%sp%d", dname, partno);
> > else
> >     dev_set_name(pdev, "%s%d", dname, partno);
> > 
> > So any device where names end with numbers follow the name<%d>p<%d>
> > scheme for partitions.
> 
> Eeeeeee thanks for digging that out :)
> 
> > I was not completely sure if this is something only nvmes follow but
> > looking into the code a bit (from my limited understanding of the blkdev
> > code) seems like all  partiions just inherit parent's queues and sysfs
> > "queue" is only for the parent (struct gendisk) rather than partiions.
> 
> Yes, partitions just reuse the parent bdev's queues.
> 
> > So I think a more generic way would be to check if dev is a partitions
> > and then get the correct path for it:
> > 
> > dev_is_partition() {
> >     local dev
> >     dev=$(_short_dev "$1")
> > 
> >     [[ -e /sys/class/block/$dev/partition ]]
> > }
> > 
> > dev_get_queue_path() {
> >     local dev parent
> >     dev=$(_short_dev "$1")
> > 
> >     if dev_is_partition "$dev"; then
> >         parent=$(basename "$(readlink -f /sys/class/block/$dev/..)")
> 
> Heh, that '..' is delectably subtle.

Yes that's true. I think I'll just break it into 2 steps so its more
clear to read.

> 
> >     else
> >         parent="$dev"
> >     fi
> > 
> >     echo "/sys/block/$parent/queue"
> 
> Might want to check that the path actually exists before printing it,
> but yes that looks ok.

Makes sense.

Thanks for the review!
ojaswin
> 
> --D
> 
> > }
> > 
> > Does that look okay?
> > 
> > Regards,
> > ojaswin
> > 
> > > 
> > > (Well, maybe not the scsi-debug users)
> > > 
> > > > +# Get the right sysfs dev for the atomic write device
> > > > +get_aw_dev() {
> > > > +    local dev
> > > > +    dev=$(_short_dev "$1")
> > > > +
> > > > +    # Special case: nvme partitions don't have the /sys/block/nvme0n1p1 style
> > > > +    # entry and also use the namespace's queue limits for atomic writes, hence
> > > > +    # just return the parent namespace.
> > > > +    if [[ $dev == nvme* ]]; then
> > > > +        echo "${dev%%p[0-9]*}"
> > > > +    else
> > > > +        echo "$dev"
> > > > +    fi
> > > > +}
> > > 
> > > Perhaps this ought to turn into a common helper to fix them all?
> > > 
> > > _sys_block_path() {
> > > 	local dev=$(_short_dev "$1")
> > > 
> > > 	# Special case: nvme partitions don't have the /sys/block/nvme0n1p1 style
> > > 	# entry and also use the namespace's queue limits for atomic writes, hence
> > > 	# just return the parent namespace.
> > > 	if [[ $dev == nvme* ]]; then
> > > 		echo "/sys/block/${dev%%p[0-9]*}"
> > > 	else
> > > 		echo "/sys/block/$dev"
> > > 	fi
> > > }
> > > 
> > > sys_min_write=$(_sys_block_path $SCRATCH_DEV)/queue/<whatever>)
> > > 
> > > Also, don't some of the other block devices follow this "partition has
> > > pXXX suffix" pattern as well?  Not that I have a clue why scsi doesn't
> > > follow that pattern or even which part of sd.c triggers the sdaX
> > > behavior. :/
> > > 
> > > --D
> > > 
> > > > +
> > > > +sys_min_write=$(cat "/sys/block/$(get_aw_dev $SCRATCH_DEV)/queue/atomic_write_unit_min_bytes")
> > > > +sys_max_write=$(cat "/sys/block/$(get_aw_dev $SCRATCH_DEV)/queue/atomic_write_unit_max_bytes")
> > > >  
> > > >  bdev_min_write=$(_get_atomic_write_unit_min $SCRATCH_DEV)
> > > >  bdev_max_write=$(_get_atomic_write_unit_max $SCRATCH_DEV)
> > > >  
> > > >  echo "sysfs awu_min $sys_min_write" >> $seqres.full
> > > > -echo "sysfs awu_min $sys_max_write" >> $seqres.full
> > > > +echo "sysfs awu_max $sys_max_write" >> $seqres.full
> > > >  echo "bdev awu_min $bdev_min_write" >> $seqres.full
> > > > -echo "bdev awu_min $bdev_max_write" >> $seqres.full
> > > > +echo "bdev awu_max $bdev_max_write" >> $seqres.full
> > > >  
> > > >  # Test that statx atomic values are the same as sysfs values
> > > >  if [ "$sys_min_write" -ne "$bdev_min_write" ]; then
> > > > -- 
> > > > 2.53.0
> > > > 
> > > > 
> > 

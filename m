Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CFB21FF31
	for <fstests@vger.kernel.org>; Fri, 20 Jun 2025 08:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750407633; cv=none; b=r85WDK4o/tJ2h7NIoaZnLDImfSDWOTcmLeuy5xWY2qEFBJvEr2nHcZg5shqNotYHYvW6xBBzPqV8UdiiCtnpEM1zUsDCNqlDP7Amj/VqwN25OZ9+/xf8uqK/0mb9BJhllw+p1HMUQc4odR87+VtQfOgli9NFEQ27qBL33yKqmt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750407633; c=relaxed/simple;
	bh=e5sjqfX41JPXSTKoPWzYmX7q1ExwR6g2mFWXsAoa7Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjLJ4q/mRy+e5hTc0LRxRSdydO4A2b7B4qV8YlZSI/QitzuOVaqqcD/x9md3VbpU4j5a5yTM0g3HlB67HDayKtzGpL2Yyzua0IzGERwn2bxSQR7erO2M2LdCob9SH7FDJD67q5s9G6fN+OImd/NI70BLzQujF70aKG3hhk0muuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DPqUVNDf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DPqUVNDf"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55K2jE2I004636;
	Fri, 20 Jun 2025 08:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=mm0gbmX4Stue+tkpVf7GA2c0313VPz
	QUMi+CrEdI1HE=; b=DPqUVNDfSxIRvTyvC83ZYeolL5oETJ0+kSMpKjr00ON258
	NIJUznixjX4AwaNRk4cCCFVRMTVODmp59HqyAri32o46jNo980vxtupZFCeZg2oE
	NZJOeXGi0rt6X/y/cEpzUdxE//xQahS2fjye7i5TYwKRfLCmtCtugmfBLR5Ksy6w
	LX7MM+uwG3W7T8vRXty4uy+aAUjXjuz3Z2dFbAiTgaIlqPcBunxzQNBYKvs83VS2
	fhEsz9Ac1rp2SPnVpXrDUeK0o+L0HCqGMVdCsdbt8WxhHigeFdDQ6wCzoRSvG/zO
	lJ/Lh8YtQ0VE5AvJDkMISRSk4FdleWzk/sx4Tf9Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47cy4jsd34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 08:20:25 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55K8BfCV022373;
	Fri, 20 Jun 2025 08:20:24 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47cy4jsd2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 08:20:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55K6FMBA000863;
	Fri, 20 Jun 2025 08:20:23 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 479mdpj5rv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 08:20:23 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55K8KLAR16843034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Jun 2025 08:20:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A3552004B;
	Fri, 20 Jun 2025 08:20:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 50A1E20043;
	Fri, 20 Jun 2025 08:20:20 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.221.59])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 20 Jun 2025 08:20:20 +0000 (GMT)
Date: Fri, 20 Jun 2025 13:50:18 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        djwong@kernel.org, john.g.garry@oracle.com
Subject: Re: [RFC 06/12] generic/770: Add atomic write multi-fsblock
 O_[D]SYNC tests
Message-ID: <aFUZwtzedj1EuqmF@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <5503061a800eaff9fc182e68c3030c1ef07410f3.1749629233.git.ojaswin@linux.ibm.com>
 <20250618201711.2d6xuv6pztoj4pbn@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618201711.2d6xuv6pztoj4pbn@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AtvOaFxZ5bUGFNQ6WXCxgyTzVxmUhSoJ
X-Authority-Analysis: v=2.4 cv=a7ww9VSF c=1 sm=1 tr=0 ts=685519c9 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=IBMv5OylU4estuxbR0wA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDA2MCBTYWx0ZWRfX4+oC71wy3wzQ WvEvUah93MJug76K1gSGMdwz1avREQuxkL1uxXLqVPEPCMDhvT7oVsCxatiRdukUrAULZMIP43N bBMrRuOqp8Wh+rUDFyxaiAjTIIBfyVgdb38g7i0mvNJiYmxbXvrK3U8ReCchpnnXc+YSKJMoNnp
 LK2BzvypcRr7fSZLuwt43pY+pbrod5tH+sTTDm4lsiaJWdP1rZDFLTvSSuKIUPVgj6pjtbDScdk 3iebKpwf90HZwzvuMlizKwaaPfOHa+cq4hY6iXY4vMgqMmeKBOy3XncWYIyLyb6dg/MDtO1Mmja gjwb95GO2hoKRDJRFTwliMYnhkYJSeTFeotAkEyB5BxYd4rP6km4znCDvf2Uu3zkRfiyi3f4Q1C
 /3UxGO1a2CDWyr8AjOLPC/nxWZMvm28tLJiRhUT1bqBnKQa247G/dlyehOE608mIoNwrB/Xg
X-Proofpoint-ORIG-GUID: 1IfNJ5i0XCTyqhuGr9bSsP46kR-1YSEL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_03,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506200060

On Thu, Jun 19, 2025 at 04:17:11AM +0800, Zorro Lang wrote:
> On Wed, Jun 11, 2025 at 03:04:49PM +0530, Ojaswin Mujoo wrote:
> > This adds various atomic write multi-fsblock stresst tests
> > with mixed mappings and O_SYNC, to ensure the data and metadata
> > is atomically persisted even if there is a shutdown.
> > 
> > Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >  tests/generic/770     | 161 ++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/770.out |   2 +
> >  2 files changed, 163 insertions(+)
> >  create mode 100755 tests/generic/770
> >  create mode 100644 tests/generic/770.out
> > 
> > diff --git a/tests/generic/770 b/tests/generic/770
> > new file mode 100755
> > index 00000000..2b98b3b3
> > --- /dev/null
> > +++ b/tests/generic/770
> > @@ -0,0 +1,161 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> > +#
> > +# FS QA Test 770
> > +#
> > +# Atomic write multi-fsblock data integrity tests with mixed mappings
> > +# and O_SYNC
> > +#
> > +. ./common/preamble
> > +. ./common/atomicwrites
> > +_begin_fstest auto quick rw atomicwrites
> > +
> > +_require_scratch_write_atomic_multi_fsblock
> > +_require_atomic_write_test_commands
> > +

<snip>

> > +			"U")
> > +				$XFS_IO_PROG -c "falloc $off $blksz" $testfile >> /dev/null
> 
> _require_xfs_io_command falloc
> 
> > +				;;
> > +		esac
> > +		off=$((off + blksz))
> > +	done
> > +
> > +	echo "Mixed mapping preparation complete. Full mapping pattern: $mapping" >> $seqres.full
> > +
> > +	sync $testfile
> > +
> > +	echo "Performing O_DSYNC atomic write over the entire $awu_max region" >> $seqres.full
> > +	bytes_written=$($XFS_IO_PROG -dc "pwrite -DA -V1 -b $awu_max 0 $awu_max" $testfile | \
> 
> _require_xfs_io_command pwrite -A

Hey Zorro,

pwrite -A and falloc command are already checked for in
_require_atomic_write_test_commands helper used on top.

> 
> 
> > +				  grep wrote | awk -F'[/ ]' '{print $2}')
> > +
> > +	test $bytes_written -eq $awu_max || echo "atomic write len=$awu_max failed"
> > +	check_data_integrity
> > +	echo "Iteration $iteration completed: OK" >> $seqres.full
> > +	echo >> $seqres.full
> > +done
> > +echo "# Test 1: Do O_SYNC atomic write on random mixed mapping (10 iterations): OK" >> $seqres.full
> > +
> > +echo >> $seqres.full
> > +echo "# Test 2: Do extending O_SYNC atomic writes: " >> $seqres.full
> > +bytes_written=$($XFS_IO_PROG -dstc "pwrite -A -V1 -b $awu_max 0 $awu_max" $testfile | \
> > +                grep wrote | awk -F'[/ ]' '{print $2}')
> > +test $bytes_written -eq $awu_max || echo "atomic write len=$awu_max failed"
> > +_scratch_shutdown -v >> $seqres.full
> 
> _require_scratch_shutdown

Thanks, i'll add it.

> 
> > +_scratch_cycle_mount >>$seqres.full 2>&1 || _fail "remount failed for Test-2"
> > +check_data_integrity
> > +echo "# Test 2: Do extending O_SYNC atomic writes: OK" >> $seqres.full
> > +
> > +echo >> $seqres.full
> > +echo "# Test 3: Do O_DSYNC atomic write on random mixed mapping with sudden fs shutdown (10 iterations):" >> $seqres.full
> > +num_blocks=$((awu_max / blksz))
> > +echo "Testing $num_blocks blocks of $blksz size within $awu_max region" >> $seqres.full
> > +
> > +operations=("W" "H" "U")
> > +
> > +for ((iteration=1; iteration<=10; iteration++)); do
> > +	echo "=== Mixed Mapping Shutdown Test Iteration $iteration ===" >> $seqres.full
> > +
> > +	$XFS_IO_PROG -c "truncate 0" $testfile >> $seqres.full
> > +
> > +	off=0
> > +	mapping=""
> > +
> > +	for ((i=0; i<num_blocks; i++)); do
> > +		index=$((RANDOM % ${#operations[@]}))
> > +		map="${operations[$index]}"
> > +		mapping="${mapping}${map}"
> > +
> > +		case "$map" in
> > +			"W")
> > +				$XFS_IO_PROG -dc "pwrite -S 0x61 -b $blksz $off $blksz" $testfile > /dev/null
> > +				;;
> > +			"H")
> > +				# No operation needed for hole
> > +				;;
> > +			"U")
> > +				$XFS_IO_PROG -c "falloc $off $blksz" $testfile > /dev/null
> > +				;;
> > +		esac
> > +		off=$((off + blksz))
> > +	done
> > +
> > +	echo "Mixed mapping preparation complete. Full mapping pattern: $mapping" >> $seqres.full
> > +
> > +	sync $testfile
> > +
> > +	echo "Performing O_DSYNC atomic write over the entire $awu_max region" >> $seqres.full
> > +	bytes_written=$($XFS_IO_PROG -dc "pwrite -DA -V1 -b $awu_max 0 $awu_max" $testfile | \
> > +				  grep wrote | awk -F'[/ ]' '{print $2}')
> > +
> > +	test $bytes_written -eq $awu_max || echo "atomic write len=$awu_max failed"
> > +
> > +	echo "Shutting down filesystem" >> $seqres.full
> > +	_scratch_shutdown -v >> $seqres.full
> > +	_scratch_cycle_mount >>$seqres.full 2>&1 || _fail "remount failed for Test-3"
> > +	check_data_integrity
> > +	echo "Iteration $iteration completed: OK" >> $seqres.full
> > +	echo >> $seqres.full
> > +done
> 
> Looks like there're two iterations (loop running codes), the code looks much similar, can we
> move them to one function then call it twice?

Sure, i'll refactor it in v2.

Thanks,
ojaswin
> 
> Thanks,
> Zorro
> 

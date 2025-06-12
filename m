Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B1B1DFE20
	for <fstests@vger.kernel.org>; Thu, 12 Jun 2025 06:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749709381; cv=none; b=Kyi8hqRtqkQUVvek9moajFnSRRKQePBtoXeoWjghcptdfu6w93T3e/hnJb3R2rl8ZN+sdtxd99DyFCF8+I8YB1PgUnEVeAK++a10e9/jZ6MvA9yMVo7l5iTqh/fVAu0cX5PlSzncxi8omna4bc4qAff8GlFyWkZ/adaLCnysJUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749709381; c=relaxed/simple;
	bh=NgsBWpNR04fbPDA3hhXNOYrf5eZsqOJDDU/QUj7XM5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XeUzpHA51UYdWr+srVIuh9Rbi2yej6vQI/Avr/FLjcRJoTgJNHonumOOe/cvdZBsbKBHpC+E2l1H7vzool9cjTsa8mTtDRr/d0VRFJ2ABM2fD7Ra6Z58b9BjN/cQKA3OveHgQQQDA52B40DC+7lQ512qIXrQOcC+7yEsmTIF5Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZAXd1OVT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZAXd1OVT"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C0gj5u003604;
	Thu, 12 Jun 2025 06:22:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=6Tajk8lp26GcP7IYqmQes6CLHiW7Hi
	5LRaWb/xL6u8g=; b=ZAXd1OVTCoh2J/+D3/fLAh/g6XErJX/nEaILnzGwu/UbJi
	PVHaw179T1Q/uBT8lM+nt+3aJIvlORQiCKQYxtjiDJVK0HIli2usLOWcCFjglSyN
	3+H/Y+ZH1YuMraSrmvdHmZaLss9FyTBPcZwEgq0MPx1QPhRvBmZ13GIDeU/xdstH
	NnRQiLu0vj7c00SYSeS6wyrrY19fLS/39wGmMZQcgTgeun4sJLPJG5AsgR0AhQHV
	mmRQw7rsIz5WputZUPNZ0JcNAydDWLVS5M18rxqnzPAJKhe8jbPIk/sNyvghZMB/
	Nv0oMki62B7OjPdPuGfaAHf1R0m0BW4uZDMFuTuw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474cxjh0yr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 06:22:55 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55C6MsQK022637;
	Thu, 12 Jun 2025 06:22:54 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474cxjh0yp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 06:22:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55C51FGJ015184;
	Thu, 12 Jun 2025 06:22:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 474yrtkm7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 06:22:53 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55C6MpZ648234922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 06:22:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8A5320043;
	Thu, 12 Jun 2025 06:22:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A454420040;
	Thu, 12 Jun 2025 06:22:50 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.249])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 12 Jun 2025 06:22:50 +0000 (GMT)
Date: Thu, 12 Jun 2025 11:52:48 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        john.g.garry@oracle.com
Subject: Re: [RFC 04/12] generic/767: Add atomic write test using fio crc
 check verifier
Message-ID: <aEpyOHL-K-ErQOrV@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <9cb914eacd9d7825f2903410948d2a1d4a1a8800.1749629233.git.ojaswin@linux.ibm.com>
 <20250611144225.GI6143@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611144225.GI6143@frogsfrogsfrogs>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pmjlHzVnZHm76su8tYE7syXeWXAztvbJ
X-Proofpoint-GUID: _5AeqKoScUi3akeswYC6vcmQaZP_mkJN
X-Authority-Analysis: v=2.4 cv=fZWty1QF c=1 sm=1 tr=0 ts=684a723f cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=JEkUU2Ld6VXCT6n7lSsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDA0NiBTYWx0ZWRfXzPx2yxXImO5K R2F+u4M6GDQSiKecDEYMqIfl0Vvsh+kkojKB0QDWD0JrkD+h1gsCqRkWzwjznYhH89yBBOF1kZ/ voJjc7AiUmz3yWCeDtLnFUybV7XF3068xDoJvjZ5U26r1eFrFnmEXTOe38EohCONdnFndWNURt/
 2X2nSuWhJmTvIFVP1OWmzC5N5TM+dmXKz0gugkcX3RFeYUivwsgSziteNijQdnfLQ44SZ3tpoOs TolxYpA4Md2iHFu1J6YCZTbpq9mfwckKzLjGa8TpL/UR7/cE61KqKX5mgXdod6tMdR0jOFOc8Xq quJbpM+isfmetsjdmP0lb39ePrcr6jQBxQVag17taBUlynN905iwVpxeQvndSd2oczJSIPlxCT/
 /OY8+aEC8c7fvWq4UclHpMUvo1sRPfffYHuANxoXQDa+mKVb1iRt+JXIK6KbBiTzlUvR95iB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_03,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506120046

On Wed, Jun 11, 2025 at 07:42:25AM -0700, Darrick J. Wong wrote:
> On Wed, Jun 11, 2025 at 03:04:47PM +0530, Ojaswin Mujoo wrote:
> > From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> > 
> > This adds atomic write test using fio based on it's crc check verifier.
> > fio adds a crc for each data block. If the underlying device supports atomic
> > write then it is guaranteed that we will never have a mix data from two
> > threads writing on the same physical block.
> > 
> > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >  tests/generic/767     | 84 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/767.out |  2 ++
> >  2 files changed, 86 insertions(+)
> >  create mode 100755 tests/generic/767
> >  create mode 100644 tests/generic/767.out
> > 
> > diff --git a/tests/generic/767 b/tests/generic/767
> > new file mode 100755
> > index 00000000..4f80e7b6
> > --- /dev/null
> > +++ b/tests/generic/767
> > @@ -0,0 +1,84 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> > +#
> > +# FS QA Test 767
> > +#
> > +# Validate FS atomic write using fio crc check verifier.
> > +#
> > +. ./common/preamble
> > +. ./common/atomicwrites
> > +
> > +_begin_fstest auto aio rw atomicwrites
> > +
> > +_require_scratch_write_atomic
> > +_require_odirect
> > +_require_aio
> > +
> > +function max()
> > +{
> > +	if (( $1 > $2 )); then
> > +		echo "$1"
> > +	else
> > +		echo "$2"
> > +	fi
> > +}
> > +
> > +function min()
> > +{
> > +	if (( $1 > $2 )); then
> > +		echo "$2"
> > +	else
> > +		echo "$1"
> > +	fi
> > +}
> 
> Should these be common/rc helpers?
> 
> Or, since bash is ... uh fun with arguments...
> 
> _min() {
> 	local ret
> 
> 	for arg in "$@"; do
> 		if [ -z "$ret" ] || (( $arg < $ret )); then
> 			ret="$arg"
> 		fi
> 	done
> 	echo $ret
> }
> 
> and then you can pass as many arguments as you like.  The only downside
> is that you can pass stringly typed crap "_min cow frog" and it still
> returns "cow".  As if.

Yes this makes sense (sans the cow vs frog part :p) . I'll make the change in v2.

> 
> > +_scratch_mkfs >> $seqres.full 2>&1
> > +_scratch_mount
> > +
> > +touch "$SCRATCH_MNT/f1"
> > +awu_min_write=$(_get_atomic_write_unit_min "$SCRATCH_MNT/f1")
> > +awu_max_write=$(_get_atomic_write_unit_max "$SCRATCH_MNT/f1")
> > +blocksize=$(max "$awu_min_write" "$((awu_max_write/2))")
> > +
> > +# XFS can have high awu_max_write due to software fallback. Cap it at 64k
> > +blocksize=$(min "$blocksize" "65536")
> > +
> > +fio_config=$tmp.fio
> > +fio_out=$tmp.fio.out
> > +
> > +FIO_LOAD=$(($(nproc) * 2 * LOAD_FACTOR))
> 
> What program is nproc?

It returns the number of CPUs so we can scale the load based on CPUs we
have. It comes from coreutils so I think the distros should have it.


Thanks,
ojaswin
> 
> --D
> 
> > +SIZE=$((100 * 1024 * 1024))
> > +
> > +cat >$fio_config <<EOF
> > +[aio-dio-aw-verify]
> > +direct=1
> > +ioengine=libaio
> > +rw=randwrite
> > +bs=$blocksize
> > +fallocate=native
> > +filename=$SCRATCH_MNT/test-file
> > +size=$SIZE
> > +iodepth=$FIO_LOAD
> > +numjobs=$FIO_LOAD
> > +group_reporting=1
> > +verify_state_save=0
> > +verify=crc32c
> > +verify_fatal=1
> > +verify_dump=0
> > +verify_backlog=1024
> > +verify_async=4
> > +verify_write_sequence=0
> > +atomic=1
> > +EOF
> > +
> > +_require_fio $fio_config
> > +
> > +cat $fio_config >> $seqres.full
> > +$FIO_PROG $fio_config --output=$fio_out
> > +cat $fio_out >> $seqres.full
> > +
> > +# success, all done
> > +echo Silence is golden
> > +status=0
> > +exit
> > diff --git a/tests/generic/767.out b/tests/generic/767.out
> > new file mode 100644
> > index 00000000..2bf7f989
> > --- /dev/null
> > +++ b/tests/generic/767.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 767
> > +Silence is golden
> > -- 
> > 2.49.0
> > 
> > 

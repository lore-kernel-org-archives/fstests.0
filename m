Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3331F4CBF
	for <fstests@vger.kernel.org>; Tue,  1 Jul 2025 16:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751386698; cv=none; b=iZ8s5HQ/+goPWVJxM4EX2q+RPvr6Z+awNt4LFzfaGfoIpAjekFNTdnVLhBFp3v0Y75tvoKgfDA/qQLff42lwao3RN2GfdRBos08ydKfDdHqkckWg188KPvttOnHEhyXeSNxHc40MGkcwlHDgl5ef6GbOcqDVnjRzTT0AXZY46JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751386698; c=relaxed/simple;
	bh=TqzzDicEbK4zYvloxnj7a3N0kjRaTXtgzihHmBCgAok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bL2xmWimIG3Z4FkhwPrxMGvJk+698QSR1aixS6nT+99+0OiNcUHjHz5zDfilVRxC2yKpXo9VWcxFY0TmH+5THN4wTAptr3DTtRLjyVxDj0OI9hcE8x671n0ERNcW1i+eBDEERHY1tVCJ16oJ0Y4S0oTkXkUmeJmZ8ghUSAk6Ie0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e33B87sA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e33B87sA"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561ElYGk002907;
	Tue, 1 Jul 2025 16:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=A4fnL4ZQ6KXFORKFPdFlwrVJP0Zmc8
	joMZxeiWhl/vE=; b=e33B87sAam9+Bvd7rJSr3B0Y6Btk1sjGgD/s8ugOE+BIJW
	/3yCbZ+LS+DyxVUBpK528OsGSBi0j9El5XWTabb00dlkJuAEaZz64khWzwycWlnS
	H5hy8DyNLxO/0ScCc7QYHClL+OahaDz2YIDNmX8jOVldb8aq/umXyWmjVKfHmQX6
	4M7Y4v+DuyPqKDetKqPf8D4Hr6nUZoLO2Yb8OPIL3HcNI5wJkDcjIYfK9MtJDr6W
	P3ezIHVr8Wn3NjddjP7pZ3AvTtQ0BLc1F0XAJCqOPZvLEi3G2JCDOyP7eyj5HAwz
	/hXtYlUK4wd+JlO8K7cQMKqUwgKpmN9h83Nltp8Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j84d8fxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 16:18:11 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 561GC216006728;
	Tue, 1 Jul 2025 16:18:10 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j84d8fxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 16:18:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 561DlopO021371;
	Tue, 1 Jul 2025 16:18:09 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jwe3b3nh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 16:18:09 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 561GI8cg41746924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Jul 2025 16:18:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04CBD20043;
	Tue,  1 Jul 2025 16:18:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FD0520040;
	Tue,  1 Jul 2025 16:18:06 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.213.100])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  1 Jul 2025 16:18:06 +0000 (GMT)
Date: Tue, 1 Jul 2025 21:48:03 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu
Subject: Re: [PATCH v2 05/13] generic/1226: Add atomic write test using fio
 crc check verifier
Message-ID: <aGQKO3E_kwZzSy_0@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1750924903.git.ojaswin@linux.ibm.com>
 <227ca6650cf5ef5a9a3383a06cd08c0c2b9f43c3.1750924903.git.ojaswin@linux.ibm.com>
 <0430bd73-e6c2-4ce9-af24-67b1e1fa9b5b@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0430bd73-e6c2-4ce9-af24-67b1e1fa9b5b@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1mRx4vqSiHHwadBgg_y_c0FBMEBKRsle
X-Proofpoint-GUID: K2VAgcJtaRMXzgRRdmC3dyEp1Er3Jhjy
X-Authority-Analysis: v=2.4 cv=Ib6HWXqa c=1 sm=1 tr=0 ts=68640a43 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=Hoszrk23Et-Q2lSgiigA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDExMCBTYWx0ZWRfXyobQvS493I/g 21sFC/0R6MyRkIV4lcvNm4qbsJlWdXSPsG99LLRt+TF2H+tku+qZx785aL8+8AL89hI12g+7UMq 63NvhAEtNHtoVuQQDCn85Ht+Z9s0NbtEuZjBL8P3VBzJ5ktPdoLHIQ508kqap4hKQu7luxW7pCH
 xNr967Fw5+4OCmUewezK7rzmWWL0ZHxBI7lW6R3042TP8EgjFrkvegRV/VW3Nf3rabPml3fm1Hl pGBlud7aWN/xmKpdHWPFBSQy+S+CynvADtMDm9rG5vL1E4FMXSNw5lDksMawyTgw5KynEHozf+R Ir6G3ewKEKwrOMPT+YzTW2L1pEftVomokiN9V86QxQFERMvgX9M3674KIzl2EUAankq8VBtFeC7
 s2XzpVi6iTrCvsfz5Vz9G2W4LXHIvqw/2zdouq5LpxnmIRLYTYVEAZgXptLwB9c72ACyauez
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010110

On Fri, Jun 27, 2025 at 03:09:09PM +0100, John Garry wrote:
> 
> > +touch "$SCRATCH_MNT/f1"
> > +awu_min_write=$(_get_atomic_write_unit_min "$SCRATCH_MNT/f1")
> > +awu_max_write=$(_get_atomic_write_unit_max "$SCRATCH_MNT/f1")
> > +blocksize=$(_max "$awu_min_write" "$((awu_max_write/2))")
> > +
> > +# XFS can have high awu_max_write due to software fallback. Cap it at 64k
> 
> This test fails on xfs due for this reason. software fallback -based atomic
> writes have no serialization against reads or other writes.

Okay so Im still not understanding why serialization is affecting
anything here? Lets assume the IO never breaks, from what I understand
in fio code, we do the write and then once it is complete we try to read
it back and verify it.

Why serialization matters here, because even if device reorders our read
before the atomic write, we still fetch an older $blocksize chunk which
should have the data and the header. The data crc should match the
header because it would have gone atomically. What am I missing?

(Or do you mean that max_sectors_kb is not big enough to support
reads after software atomic writes and thats the issue?)

> 
> Can you cap at atomic write unit max opt? That will mean that we get
> serialization from atomic write HW support.
> 
> BTW, to repeat what I said before, it can also fail for atomic write bios
> using HW support, as reads may be split.

This one I can understand, the fio's read is split causing a short read
and seems like fio is not requeing short read properly for the verify
step(?) so it tries to verify against short read itself.
> 
> See this sample output:
> 
> generic/1226 68s ... - output mismatch (see
> /home/opc/xfstests-dev/results//generic/1226.out.bad)
>     --- tests/generic/1226.out  2025-06-27 11:26:58.411121674 +0000
>     +++ /home/opc/xfstests-dev/results//generic/1226.out.bad 2025-06-27
> 14:03:08.933811064 +0000
>     @@ -1,2 +1,104 @@
>      QA output created by 1226
>     +crc32c: verify failed at file /home/opc/mnt/scratch/test-file offset
> 16457728, length 8192 (requested block: offset=16457728, length=8192,
> flags=84)
>     +       Expected CRC: 712de900
>     +       Received CRC: f872a18d
>     +crc32c: verify failed at file /home/opc/mnt/scratch/test-file offset
> 88104960, length 8192 (requested block: offset=88104960, length=8192,
> flags=84)
>     +       Expected CRC: 4aaaf009
>     +       Received CRC: 2a5770cf
>     ...
>     (Run 'diff -u /home/opc/xfstests-dev/tests/generic/1226.out
> /home/opc/xfstests-dev/results//generic/1226.out.bad'  to see the entire
> diff)
> Ran: generic/1226
> Failures: generic/1226
> Failed 1 of 1 tests
> 
> [root@jgarry-ol9new xfstests-dev]# cat /sys/block/sdi/queue/max_sectors_kb
> 4
> [root@jgarry-ol9new xfstests-dev]#
> 
> However, nobody should fiddle with max_sectors_kb, so the test still has
> value.
> 
> 
> > +blocksize=$(_min "$blocksize" "65536")
> > +
> > +fio_config=$tmp.fio
> > +fio_out=$tmp.fio.out
> > +

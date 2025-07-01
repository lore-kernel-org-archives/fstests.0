Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E301E19ABAC
	for <fstests@vger.kernel.org>; Tue,  1 Jul 2025 06:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751351707; cv=none; b=cGYEm7Fp+yLhl545+DoC/jqtoP9W+20ecZzXHpC9lkrmPe4DEDFsE/A8UJHOWIsZ17xrs0iQGH8CYcCFFHyZAza1kLXexCnWlhsT2YJODOhet/Ari+wyx3oSOp5ktmmj8uz99LOQ7DO635GMOOpjkVtBrSr7QUbMNGS3TC89mQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751351707; c=relaxed/simple;
	bh=1a8yQSoFlBKXhjbw9dMceT+6QZ5VJ6kAEcJIajafQO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIZvEaJ4d+fkHXKicTNfViMVMX8tOVDzHPxPBjwVsXnpGpsq4dR+y3SAuMPTX476NCnqzTvSDvmgywCwSDOjl6LaIm2icElBhKAeVjfnAUm5rdVJgo/jm+n1wj7jTB1uRJqGZqaYm6Vt74VZn1KgXAi5tf+RBUA4SIC/R7pdca4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CIn1EFv6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CIn1EFv6"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UHxCw0023436;
	Tue, 1 Jul 2025 06:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=lzc+4vglPIEW7+LJokJ+sIeeykXjJp
	VuOSexHCVXf6g=; b=CIn1EFv6JRPEfMjAb92t6AuXSuyhdf7CGjN4IPHhOxjOQt
	32iZxNK7uqm8HSw6I3CN1KHCzvtuMKo27TaoD/rldazZtmo9JBD60os7ONWosKOF
	mXJeViASa/hQiArncrnANTi0/SDofBqenNWe11jINIfwAPsQgDrd+20Bpikf9rXU
	1KLcZxTslLcnBrlmwCNOUNhBtqGsqimiIOGu7cMHBoVYqSF6N2XRuMlbrzrgOwdX
	wu4XIOVDo+TzyquljAD2ayfZH/vwlJnI/ArWY20TSs/DFIh5iHcUzoyYAF4p5pC9
	+WDPOJLqMnF6TX0acgOi+qUTiXSIam1aNWTtQMLQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j5tt5xe8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 06:34:57 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5616SnYP031466;
	Tue, 1 Jul 2025 06:34:57 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j5tt5xe6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 06:34:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5614w0Gm021407;
	Tue, 1 Jul 2025 06:34:56 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jwe393rt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 06:34:56 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5616Yst935127908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Jul 2025 06:34:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CB9D20043;
	Tue,  1 Jul 2025 06:34:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15BF820040;
	Tue,  1 Jul 2025 06:34:53 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.249])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  1 Jul 2025 06:34:52 +0000 (GMT)
Date: Tue, 1 Jul 2025 12:04:50 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu
Subject: Re: [PATCH v2 09/13] generic/1230: Add sudden shutdown tests for
 multi block atomic writes
Message-ID: <aGOBihJ6ulBNuKY1@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1750924903.git.ojaswin@linux.ibm.com>
 <eabfa4691ac822af276c900f0cc7502ad62ea768.1750924903.git.ojaswin@linux.ibm.com>
 <b8bd60eb-c926-44f4-a0ff-b5de75803d85@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8bd60eb-c926-44f4-a0ff-b5de75803d85@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dJEsN4rqBVmluPKyZwhusUY68nz4RF3l
X-Authority-Analysis: v=2.4 cv=UtNjN/wB c=1 sm=1 tr=0 ts=68638191 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=lRDsrOn6V1tbf2H5nIgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: Cz4sN7cAVFQExmpooa6iuA63N-EwNpay
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDAzMyBTYWx0ZWRfXyODXl43SO2t3 cxmL/xNn/Ha3G2lM3AXWs7ggSDoZKXIOL5qGy3asN2WjCKSj+COd9ibCTt99BjzfJWGbgG1lrjf c7HP3VWUPKEx5j6Pp4bk0L4nCWZmwdam3fPzKBmR0n5/s7duPie4nojoRUH6DVjcf2d0fqwR4Nk
 09SWYUQB78mhWppE5GKCY/Wgal/9RGDASVHF+/AiFT6cjhsIO0Kv2R2Cnz0uKG8Q/SCmwnvWdg/ aoSGLU+FT7c6hu9TaJzDxrZDDH3R+s0MtZEigzIiXK8YATyKzTKxUiKdFnIsy185H63QDKeIfKv CpJR79r3M25tom0IUGWBfUt2KdBqw4TJh2jWyqW1jRdEfHsvSeWUqCFlnQXoSt+25s99vrtq6wO
 kVToQCZLV37O3HYQ2bXTnIeeVZ+PuBr39ZsjerwLttiwj2fySNXVdoHU6t8++O/Ovliygeqw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010033

On Fri, Jun 27, 2025 at 05:11:12PM +0100, John Garry wrote:
> On 26/06/2025 12:59, Ojaswin Mujoo wrote:
> > This test is intended to ensure that multi blocks atomic writes
> > maintain atomic guarantees across sudden FS shutdowns.
> > 
> > The way we work is that we lay out a file with random mix of written,
> > unwritten and hole extents. Then we start performing atomic writes
> > sequentially on the file while we parallely shutdown the FS. Then we
> > note the last offset where the atomic write happened just before shut
> > down and then make sure blocks around it either have completely old
> > data or completely new data, ie the write was not torn during shutdown.
> > 
> > We repeat the same with completely written, completely unwritten and completely
> > empty file to ensure these cases are not torn either.  Finally, we have a
> > similar test for append atomic writes
> > 
> > Suggested-by: Ritesh Harjani (IBM)<ritesh.list@gmail.com>
> > Signed-off-by: Ojaswin Mujoo<ojaswin@linux.ibm.com>
> 
> this seems to work ok for xfs, as I get data verify errors when I remove the
> -A arg to xfs_io when doing the atomic writes.
> 
> But I see this (always):
> 
> @@ -1,2 +1,83 @@
>  QA output created by 1230
> +/home/opc/xfstests-dev/tests/generic/1230: line 13:
> _require_scratch_write_atomic_multi_fsblock: command not found
Hi John,

I missed mentioning that these patches are based on [1] which provides
this command.

[1] https://lore.kernel.org/fstests/20250626002735.22827-1-catherine.hoang@oracle.com/T/#t

> +/home/opc/xfstests-dev/tests/generic/1230: line 149: kill: (535173) - No
> such process

Hmm so we follow the flow like:

1. spawn a thread A that does mixed atomic writes in bg
2. sleep 0.2s
3. shutdown and kill A

Seems like in your case, the disk maybe fast enough to actually finish
the task within the 0.2s we sleep for. 

I'll try to tune this better or see if we can just remove the sleep. In
the meantime, if you can share the seqres.full and out.bad file for this run
I'll be able to confirm if my analysis is correct.

Regards,
ojaswin

> any idea (apart from _require_scratch_write_atomic_multi_fsblock)?

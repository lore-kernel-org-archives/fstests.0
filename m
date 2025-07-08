Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5620226D0F
	for <fstests@vger.kernel.org>; Tue,  8 Jul 2025 06:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751957463; cv=none; b=n3q8W5djfILWkpc2vNw8FkJf4jAbQufF5AHCYQVhUCQXfzAT7tdAYZOy+qf9sUOGlDGKJUb936GVE09v6wmRNKytg/ylwqd2IrNp1qdOwMuARCg5+/r+58BWEToIzEpjyI46VMQ4lRSiMGiTwQ9FP2lRhYtURZvlk06Dzo+jaPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751957463; c=relaxed/simple;
	bh=vLQ2zOgnjrAKDsoa6JXWP0ojVyU8V+F9EcUmjccjC70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NF7PjB7BRbQdFneoL1kRoY+NhDrdXi76DOpTrRXpHLQ1j2WsyNrebRsnaDWxaXThp5ucRmC4QjcyfkTrzMGYFjxgLozodjFRKJyFQOiBgsm+v+SxXc0oM+XgucILn/qGm1SqcQ6bZrkk0w2Nm2QvFji1w0qCcXXVd/WN2l9D6Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ksHPRrei; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ksHPRrei"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5685BZFb006198;
	Tue, 8 Jul 2025 06:50:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=plyf8xn73f8rtp9NWnNK7QjR3hjqdN
	HAjDLdiOFfySo=; b=ksHPRreigm7qlk1a+MucTwLFegG/93NwnzSHT1VGU/HNqv
	oL/doR4pYLq01IyzYYFplKWpPNKkftdQlMNQEymzTWF0V3uHZVvgFTMD+iCg02x7
	hf0cRkXkNZxhnUPKzFaUJiM1TZ6Buw6wcpAFKbyRDln88NjQkWbRj26vlhNBM1tT
	jaBIecTkTSgFUUNM/D33Z15CZZHa6ncEReYvLY9K9mS0OwSwC8GAYFK8v/b61Yim
	U0k+saJzeLaljqQ0S7WU8JoBb6iVcUKDd9WdDns50xLgpFqcBvVYlDgemppWZPo1
	5FTMRSAQ2q7Q9GKlMY0o52IQZqTtqIiDaS5B7t0w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puk3x6gn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Jul 2025 06:50:53 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5686hSZG015109;
	Tue, 8 Jul 2025 06:50:53 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puk3x6gk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Jul 2025 06:50:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5682QawK002865;
	Tue, 8 Jul 2025 06:50:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfvm9kyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Jul 2025 06:50:51 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5686oo8L32375414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Jul 2025 06:50:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05AEE2004B;
	Tue,  8 Jul 2025 06:50:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9240920043;
	Tue,  8 Jul 2025 06:50:48 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.249])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  8 Jul 2025 06:50:48 +0000 (GMT)
Date: Tue, 8 Jul 2025 12:20:45 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu
Subject: Re: [PATCH v2 05/13] generic/1226: Add atomic write test using fio
 crc check verifier
Message-ID: <aGy_xT5powRmYzjY@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1750924903.git.ojaswin@linux.ibm.com>
 <227ca6650cf5ef5a9a3383a06cd08c0c2b9f43c3.1750924903.git.ojaswin@linux.ibm.com>
 <0430bd73-e6c2-4ce9-af24-67b1e1fa9b5b@oracle.com>
 <aGQKO3E_kwZzSy_0@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <8effd5bb-9dcd-4150-8694-36bc493a3b59@oracle.com>
 <aGYmQtQN2GsVRQ31@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <a0d241f9-0070-488a-b330-5b93339fbb03@oracle.com>
 <aGfmUrj9HDrnwOyX@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <aGfx6d-lSnhwnKsq@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <e1896e36-3291-4b54-ab66-5568e4086fa7@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1896e36-3291-4b54-ab66-5568e4086fa7@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDA0OSBTYWx0ZWRfX6vyLIAfsbLag QAoQ3vBXTzVTm2q6Guhwbrm6/U8WUephROm2PMvYIjfk0qG0swqojV3NgS+uinRfI8wIpwARXjE vElrSYIdBup0dyjtFFzj/9rJsYD2w8QL8eIw7iQBuwlpVBnyQCaWGv93l3ZF8fEOC8EWZ82Wup1
 9cX15GLHZ5+q4URsFkfYvHFpIk+Y8QI0I8iq4wOpvwmERx8JMt1YSmBjLVnnHm1JKJxOh7uKATB Gjc8b5SEu5/Z6xNQD4oJHvyb504GgzvBFuKvIouEyBG2EsW5DF/amOLQKwofmdFYOwmLsr9XI6R Re5m4eSiYR4mPcv7OPbTC36uBtXe1kRJcdljiaxA1q5OIMzg7aIMLwKln2uAPKH6MYpp4+cQXkz
 V/zUf9GFVnE4l6MMWn4prYTTP0vvwQ7z2zh8J44eFJ2dznZfl+lxjqPNIkRQqZDhKx0yUq4c
X-Authority-Analysis: v=2.4 cv=XYeJzJ55 c=1 sm=1 tr=0 ts=686cbfcd cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=MvcmooJZj5Oy0QVXVwkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: DIomeSErV4wZ4cQIhQcNXvpPRY9zObCX
X-Proofpoint-GUID: dC9GdYm1flS4dBrRR6aJxLLrrg41THCl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_02,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080049

On Mon, Jul 07, 2025 at 09:18:04AM +0100, John Garry wrote:
> On 04/07/2025 16:23, Ojaswin Mujoo wrote:
> > > Hmm yep this makes sense but seems like we don't expose it yet in
> > > xfs_io. Will need to add that support as well.
> > Okay so thinking about it a bit more, Im not sure if capping to
> > awu_max_opt is the right thing to do.
> > 
> > There is no guarantee in kernel that awu_max_opt or even awu_max would
> > be smaller than lim->max_sectors so why to derive our io size based on
> > that.
> 
> Absolutely. There is no guarantee. But generally it would not be less than
> lim->max_sectors. But lim->max_sectors kernel default is 1280KB, which is
> quite large. However, there are other reasons why splits could be broken. I
> am just giving the simple example in lim->max_sectors, as that is
> configurable from userspace (so useful for experimenting).

Got it.
> 
> > Further, handling awu_max vs awu_max_opt and their different
> > interpretations for XFS vs EXT4 etc are adding uneccessary complexity.
> 
> You could assume awu max opt == awu max for ext4, as we no there are no
> software-based atomic writes. That could be simpler than my previous
> suggestion, which involves a kernel change.

I want to avoid adding something like 

iosize = FSTYP == "ext4" ? awu_max : awu_max_opt

in the test iteslf, because it is a bit difficult to remember changing
this in case things change in the kernel later, eg if ext4 gets a
fallback.

Im not sure if returning non-zero for ext4 is also correct as per the
documented behavior from 5d894321c49e613.

   When zero, it means that there is no such performance boundary.

Anyways, I think there might be a simpler solution...
> 
> > 
> > The simplest way seems to be to just limit the $blocksize to
> > something like $(_min 16KB awu_max) and hope that 16KB is small enough
> > to not be split during reads. We anyways have other tests like
> > generic/1230 that can be used to test larger atomic write sizes
> > 
> > Thoughts?
> 
> As I said at the start, we never had guarantees of serialization of reads
> and atomic writes.
> 
> However I still think that this is a useful test. It's just it is
> theoretically possible to give false positives.
> 
> You could get the test to read max_sectors_kb, and check whether it is
> greater than the bs. Again, more complexity.

I think this might work. So i can set the iosize as 16kb which is
already low enought. Incase the max_sectors is < than 16kb then we bail
out. (but then maybe there is a very small chance of read split still)

OR another approach is to do the verify at the very end when all threads
are done writing so the reads don't race. The tradeoff is that this
will reduce the effictiveness of the test though to some extent.

> 
> As an alternative, maybe it's better to maintain this test out-of-tree. I'm
> not sure.
That'll be a hassle for everyone :p Does any of the above 2 approaches
seem acceptable for upstreaming this test?

Thanks for the reviews,
ojaswin

P.S: I'm not seeing anything weird with the line endings, but thanks,
i'll try to look into it.
> 
> Thanks,
> John
> 

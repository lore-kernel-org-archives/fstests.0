Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918941F3D56
	for <fstests@vger.kernel.org>; Thu, 12 Jun 2025 06:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749709763; cv=none; b=sgALu1/e51+w7DRvlq+4m+WwYmGtnM3co7poHLMKWpfdtJFL9e6fXVD8xBXvcSt3nthDeA8G0fc/i2ST9f+PtLqIbBObm9zldL3P1JCEzwuKT8K10tJ9fO1NgHs2NGffx8f83fwk0zj9Tq1j2U56Yq4CPgcWk1lQinjTuW9sM2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749709763; c=relaxed/simple;
	bh=PH/9/qxKZiD3jch4P6as2MhG4e8ZX1os0G3uPxVDHQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TErjpk9BYyPi0aEJd+u6DwDNe/yK0/NstAYSmuZD7YxYwkwcf6VFrfLP3rLnqd6joRddXmKIF7zG2IqeRiudEB8CxqCpgHSqDMVxameeNz8nGhibi00p3IvS72ApDEBRWDQ+RvOu4taaxq9Q8YOK1vdbS/r0CZYGlL/5pgk+X+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cX93j4+t; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cX93j4+t"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BKfId1002510;
	Thu, 12 Jun 2025 06:28:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ehi1E0pmSBYDHW0MQBjIGMT+vIHmRP
	v4E9DwlnHlM7o=; b=cX93j4+tluygjeDfptOmvgIwh6mr7j6ShRUDx+N/GUYhJV
	L7Ao/TIl1NCf2PntxFaR1OFKXuQVHoBld7VGYqotly5r5ou2cpZ1K9nH238rh2Rb
	YXhwpMmX69IOEd7PGA5qOEqYyHCCvpMgobyVQjoZ8ePvrDW4QoRhd1Tlpt9XwT07
	1t1u3UCJHkI/msIcrFEm9MKJMvQA4JCj5nPjSqhgGZ5W9DbNLY71i43iN/hKmPAQ
	HuEwPDm77kog3hGD8CpXnVsYwnkLsQQejwMcnj6JYVaUFahxajOaGDCLCL1X/vCa
	+tkmd+DE89yjeQXiKj6bAGjE4GLeICzCmy+gGJIw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4769wywmec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 06:28:42 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55C6OqA1007210;
	Thu, 12 Jun 2025 06:28:42 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4769wywme7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 06:28:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55C5NNuP022352;
	Thu, 12 Jun 2025 06:28:41 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4750503gdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 06:28:41 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55C6SdSg26280382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 06:28:39 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 384562004F;
	Thu, 12 Jun 2025 06:28:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDC2F20040;
	Thu, 12 Jun 2025 06:28:37 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.249])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 12 Jun 2025 06:28:37 +0000 (GMT)
Date: Thu, 12 Jun 2025 11:58:35 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        john.g.garry@oracle.com
Subject: Re: [RFC 08/12] generic/772: Add sudden shutdown tests for multi
 block atomic writes
Message-ID: <aEpzk1gEnx6EAkgb@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <fe30e64171982a664579d11c1277b2a033b952ab.1749629233.git.ojaswin@linux.ibm.com>
 <20250611153822.GN6143@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611153822.GN6143@frogsfrogsfrogs>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UsiBqLIbdMFKC4BUuyMzc3zZYtuJXNd1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDA0NiBTYWx0ZWRfX5ugRLDDXwH3K lgc3wCiiAAwrd3T0eedDDXSbRv1CQHPkUufHiiNcBmOe49hj1HofYfqCBXSdWUiGnMjAaalKSTs h3jgAJpvbp5OEh1CqqJvyVbQwl1L3tZQs4YCRWVAEpAlhWyczZ6nZbiAMyc4b48AHzgDlTHN3mI
 zDSTGLghPryyj44mth3ieKpK7lop3TWrJDnITJYiWiqgoenjR0fAlhB1b99kSep8chFsDjAYCdk gSFZx19lAMqTOsp81YDK2hXWAoAScFHQ/BJ2eOaIVst8VdXQeJ3XSE5suqpQ6y3GQOfFNg0gU// DBfD417uuNaTiYvMJQYXPrBFrithZlPqoO5dcJVO0t/lYAbx/M7nhcRf8pQ7ySDKehy983VyW+9
 BTXR4Ea/qbpnoQL3T/0UNJqdmgNPAjPBJat6fV2rPmIX19rRk71KSZQbotTS+KcOYO987SRh
X-Authority-Analysis: v=2.4 cv=YKGfyQGx c=1 sm=1 tr=0 ts=684a739b cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=wEijfvtqJ0t_w2qvkwcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: EG3UyWlXHGRepsnYXgKUyZh62vRU0jOO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_03,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 mlxlogscore=796
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506120046

On Wed, Jun 11, 2025 at 08:38:22AM -0700, Darrick J. Wong wrote:
> On Wed, Jun 11, 2025 at 03:04:51PM +0530, Ojaswin Mujoo wrote:
> > This test is intended to ensure that multi blocks atomic writes
> > maintain atomic guarantees across sudden FS shutdowns.
> > 
> > Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >  tests/generic/772     | 360 ++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/772.out |   2 +
> >  2 files changed, 362 insertions(+)
> >  create mode 100755 tests/generic/772
> >  create mode 100644 tests/generic/772.out
> > 
> > diff --git a/tests/generic/772 b/tests/generic/772
> > new file mode 100755
> > index 00000000..6af7e74c
> > --- /dev/null
> > +++ b/tests/generic/772
> > @@ -0,0 +1,360 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> > +#
> > +# FS QA Test 0772
> > +#
> > +# Test multi block atomic writes with sudden FS shutdowns to ensure
> > +# the FS is not tearing the write operation
> > +. ./common/preamble
> > +. ./common/atomicwrites
> > +_begin_fstest auto atomicwrites
> > +
> > +_require_scratch_write_atomic_multi_fsblock
> > +_require_atomic_write_test_commands
> 
> _require_shutdown?
> 
> Otherwise seems fine to me...
> 
> --D

Will do, thanks for the reviews!

Regards,
ojaswin

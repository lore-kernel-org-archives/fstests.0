Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3F425CC70
	for <fstests@vger.kernel.org>; Tue,  1 Jul 2025 06:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751351183; cv=none; b=aFHRnrjlHIG0BKhQKIoK/lg/h2sRQ3SzTXiK4kwLTw/bJgcW9rqlOJaYt4wOiXT6t1Z8lIYmeLFT0Q85sYGPO2YpTq5EriuWJgxtTdPnaBan066+8e7ItHyzWVK3ulofnoIweQA7sccUnXJSkOtamnNHS2jjZy2OHMyMd/VD04Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751351183; c=relaxed/simple;
	bh=cizUHiRFlUjvU91K/Zr1R1pQ3kLtUpiMtHj4U2d1rUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQ3KYOYEAPU3PXS8aY7X2Yg/UZ2p+pDUvDRkORt3cdyM4HB2ma08y6quqBnA5wfo9hrgpKtiEvfva4H66RnIPuRnw4QkncFUac7oja6UCScRCgQBisFWDDYpFNtSjZy6TyzrmzexxhY9FIElTWSQDoHgfEfXH7JwyUs9X0bzNWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VDIvD1wQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VDIvD1wQ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UKxYEv019894;
	Tue, 1 Jul 2025 06:26:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=BWwe6T1Z5wwnhw+IgAm6oMYBPU4+nt
	01vHM+OAIqjAo=; b=VDIvD1wQGF7a9bXavQZM3sh5UDaTvV2irI8V6Rl7mal1/9
	dFZrfoP+MZTxSaGMSiZC1qjg6gOAgh5sOu+lH0E4eHBrmVJI7GTepBvQHyckCZEu
	jU4Bqn+c7fFazG3WGJvT7qkAs4Txfum7EVZ3sjqAx8jO4dVEi8sdwES5YUsVBEIa
	FpPgUjKCfjcoHkXaaw4I31670+OeuKD731kQGILBuxAAiStsbT3ep5waJjlthhqL
	8xR12lBkAjjEtnX3NKgJC2vgVriOastuWubb+eqeM04bT8yJPYrrqT6lIeRBJasT
	rlM9KW8cfZw/gqgzzSub9zxsHebkI5PDXG+rK0vg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j830nkdt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 06:26:13 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56160jN0009785;
	Tue, 1 Jul 2025 06:26:12 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j830nkdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 06:26:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5613QGvH012043;
	Tue, 1 Jul 2025 06:26:11 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47jv7ms98r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 06:26:11 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5616Q7eU56820036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Jul 2025 06:26:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9D5B2004B;
	Tue,  1 Jul 2025 06:26:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52F9020043;
	Tue,  1 Jul 2025 06:26:06 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.249])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  1 Jul 2025 06:26:06 +0000 (GMT)
Date: Tue, 1 Jul 2025 11:56:03 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        john.g.garry@oracle.com
Subject: Re: [PATCH v2 02/13] common/rc: Fix fsx for ext4 with bigalloc
Message-ID: <aGN_ezRRQFuydHmS@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1750924903.git.ojaswin@linux.ibm.com>
 <4f09b788f506223c9631479d0318be1e1ba5883c.1750924903.git.ojaswin@linux.ibm.com>
 <20250626133239.GA7524@mit.edu>
 <20250630152857.GC9995@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630152857.GC9995@frogsfrogsfrogs>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: doVpmlnenkrzZd1LOIyLYbWRa4Cqnl7s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDAzMyBTYWx0ZWRfX4E02ftwjxXgw BSETvNDVT4JmxsIDB0wQ+iu5CYIA4s+sHiPB2HQBZq6v2L/UqkncMFxu8lgLvbVqOGABLDTfrCG drwfb92IraIUANnVsz14TvO2/jem0B43la7MO/VdwOIrwnY09xhgCjKx3EDv/NzQFF4SZZ4Hu/p
 4ueerBMAtmjnuXkuGLLU/HIKR0ERs5zz6V0XvypLFavqzQo8+EFXmEfBj9usag6JjOm/DyIL2Hb r4wdcWrPCGGEuzRRNzb3B5PYEK8mXMZblNjs4eOunoDDlrF5zCjUFIolOt9ERYmWC0C9xrkj7y/ m+ptg+vKPITLiXCKLs4pHvJSYAGWDTQGtQ2+m0CBxWAWb/iqZLVbSnk/aevhXdDzPUM9cK6LUje
 jkXX6Tl6Im1QTLQ0+/UBIDoxHEmx2Un4WIYz0R2WzxMY+p8SPEAUSHvZCuAWFlvCajrbyqis
X-Authority-Analysis: v=2.4 cv=MOlgmNZl c=1 sm=1 tr=0 ts=68637f85 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=J6uELZbmjNXbFQD03rcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: OTv5jpjJJ9mAeuMYMldUE5mOhwsFnT6e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 mlxlogscore=943 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010033

On Mon, Jun 30, 2025 at 08:28:57AM -0700, Darrick J. Wong wrote:
> On Thu, Jun 26, 2025 at 09:32:39AM -0400, Theodore Ts'o wrote:
> > On Thu, Jun 26, 2025 at 05:28:53PM +0530, Ojaswin Mujoo wrote:
> > > This is achieved by defining a new function _set_default_fsx_avoid
> > > called via run_fsx helper. This can be used to selectively disable
> > > fsx options based on the configuration.
> > 
> > > +_set_default_fsx_avoid() {
> > > +       case "$FSTYP" in
> > > +       "ext4")
> > > +               if [[ "$MKFS_OPTIONS" =~ bigalloc ]]; then
> > > +                       export FSX_AVOID+=" -I -C"
> > > +               fi
> > > +               ;;
> > 
> > This assumes that MKFS_OPTIONS reflects the file system features
> > enabled on the file system.  That's true by definition for the scratch
> > fs, but it's not necessarily true for the test fs.  At least in
> > theory, someone could run fstests without a scrach device, and then
> > MKFS_OPTION?S might not be set.
> > 
> > I'm not sure that we care; is this something that we make assumptions
> > in other tests?
> 
> /me suspects it ought to be checking dumpe2fs -h output.
> 
> --D

Hey Ted, Darrick,

I agree that MKFS_OPTIONS is not ideal because it won't reflect the
TEST_DEV options. Most of the existing users of run_fsx helper actually
use the TEST_DEV instead so Darrick's suggestion of using dumpe2fs makes 
sense. 

I can use that approach in v3 if that sounds okay to everyone.

Regards,
ojaswin

> 
> > 
> > 					- Ted
> > 

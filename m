Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E69A395D9F
	for <fstests@vger.kernel.org>; Mon, 31 Aug 2026 08:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788164143; cv=none; b=iJbQaPNjFVLnt1ldG619CQaWBJolIiZHJAntATW653sppYyIBsa/F0DN76xNu0Ot9VIIzcw7WbdTWYuOS5dMUygUk9VXichzF4eG9CW6+N8+VVAlxnhIDYZDyKsC95SYjfp/JtYaSQ86U3OoMCGGHh/ByQZyuJo89HdO8nytP+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788164143; c=relaxed/simple;
	bh=hZOeBCAjgYWrXmtOE4W5ZQeqc8LvSbAuBq/T40SA3DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhTrGw40SZ6sa2BRX8oAxNJ9mNplJZcIu2i6aBOuguE13CFyvfaAe8U6h/XfMVjTzfPgo4ybht61fUAdan3I5CUbCWRD7AS+QYikWU1EO6bjBM3dc/qw/+huAyPeCYN4LQj3+8+WwUkvLnfypdArmfUGB623IX2qsmWB1to4GDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VIzWWhPn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VIzWWhPn"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V82PFo1640269;
	Mon, 31 Aug 2026 08:15:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Qfaq4cvDKDrqjkmYNo17yOrEXX+o72
	y40fNhRniA0gQ=; b=VIzWWhPnz+GetWzzGP/bXSfaKYhgzrwabJPXQI1O8Cklbd
	rSCOMGdptECnokJnrOjA594QPqncq2iab0E8fZhbSiDqEDK293W5AHBSlwGLXqlV
	6uY4SrIVge8rxLpVpZFR+jyCJ0fxQkAQGAvx4NX51DWskaIZ33tHMwidEkzZNA9O
	hrjXxMfO3Mwe0Mec99ertXZD+EJIxY3OA9zHXzF6GiEvEYw/Ue8wjLvpNcvg5Rve
	yGVwN23yp3Yu110Im6MXKr4slEWJenLSaxMmrDA03fM6Ss2LTDAveAS44X3P70mt
	DSyLOtDi3+QSViX+qppq14Oo06JxJTdeqHIlCIOA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq54g0hn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 08:15:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67V8Bdk6018677;
	Mon, 31 Aug 2026 08:15:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gccexvj9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 08:15:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67V8Fabb45482284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 08:15:36 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02AD520040;
	Mon, 31 Aug 2026 08:15:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02DEF20043;
	Mon, 31 Aug 2026 08:15:35 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.123.13.2])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 31 Aug 2026 08:15:34 +0000 (GMT)
Date: Mon, 31 Aug 2026 13:46:02 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH 1/4] check: refactor argument parsing with getopt
Message-ID: <apU4Qj-pmdY4ZQDr@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20260826102857.3224318-1-zlang@kernel.org>
 <20260826102857.3224318-2-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826102857.3224318-2-zlang@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA2OCBTYWx0ZWRfXxPPi7wBoxh/6
 KjQxpjwdP/1xGUiHjpsHYZK4HE4+WRCvxUNxi+jU8zwA0G3Cm7n22hZSKmG3AEKfQGHRO52lcN2
 SEJlYRyVIDzGHik6XMos+ZAIcDghDNsV1p/kM2HK8jlbTRlbRpWYudrNmA/9C9fL9WraqAHLhA5
 iU00LDiDtQtndXTqBtdaS3EjjnEGTZ0qci+dYKP3Y0MRowvqkQ0Eu8a9Achi6rjUD9uvrCZa8KL
 VDzE/35FOFGT8QkWrkZLBY2J47tUQ+z4EB8FqMPjjs4pF9WcVlYgMU2zRe2awWU/PcZlSwdXtaC
 eqFnzXK3PlA6aq+hhjUx2H4F960MAus3r6y4A4rOusFM/iw4nMRGgSM9lIsuZk+48YraPm6d680
 lu6lRxm92QY1ypKD3Ldm7sEgYaYcdOGTEL/gBJfvjcFXfmc/m6btTI03LbIbnfyMc7N6Vgs0Vy9
 SzupyJUjNVkCpOUHrSQ==
X-Proofpoint-ORIG-GUID: eZdJZmzYUOgkn7oIOMp7OCHk0aFfwsJv
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a95382a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=IG1fr5jiejmAYYErJMIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: eZdJZmzYUOgkn7oIOMp7OCHk0aFfwsJv
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA2OCBTYWx0ZWRfX/mSagLaPQ+1/
 OISk2yTxj8/hZ3O2g7h1RVfNEyBRDk//HDzGESLQdvI3FmeEhCcA4rDX1i8EFwNV/x+MP0xNvHO
 /n2ec6b3vaPfinCkMM1gu7cnew7u8AI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310068

On Wed, Aug 26, 2026 at 06:28:54PM +0800, Zorro Lang wrote:
> Replace the legacy, hand-written argument parsing loop with getopt.
> Also compatible with old-style options (e.g. -nfs, -afs, -glusterfs,
> -cifs, -9p, -fuse, -virtiofs, -pvfs2, -tmpfs, -ubifs, -overlay,
> -udiff), pre-process them into long options before giving to getopt.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  check | 180 +++++++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 127 insertions(+), 53 deletions(-)
> 
> diff --git a/check b/check
> index ad685edc..548b01b5 100755
> --- a/check
> +++ b/check
> @@ -272,48 +272,98 @@ _prepare_test_list()
>  	rm -f $tmp.list
>  }
>  
> -# Process command arguments first.
> +# Backward compatible with the old options mode. Translate word-style options
> +# that getopt would misinterpret into long options.
> +compat_old_option()
> +{
> +	check_args=()
> +	while [ $# -gt 0 ]; do
> +		case "$1" in
> +		-nfs)		check_args+=("--fs" "nfs") ;;
> +		-afs)		check_args+=("--fs" "afs") ;;
> +		-glusterfs)	check_args+=("--fs" "glusterfs") ;;
> +		-cifs)		check_args+=("--fs" "cifs") ;;
> +		-9p)		check_args+=("--fs" "9p") ;;
> +		-fuse)		check_args+=("--fs" "fuse") ;;
> +		-virtiofs)	check_args+=("--fs" "virtiofs") ;;
> +		-pvfs2)		check_args+=("--fs" "pvfs2") ;;
> +		-tmpfs)		check_args+=("--fs" "tmpfs") ;;
> +		-ubifs)		check_args+=("--fs" "ubifs") ;;
> +		-overlay)	check_args+=("--fs" "overlay") ;;
> +		-udiff)		check_args+=("--udiff") ;;
> +		-\?)		check_args+=("--help") ;;

Thanks for taking care of -?, looks good now.

Regards,
ojaswin


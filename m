Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9536827A462
	for <fstests@vger.kernel.org>; Wed,  1 Apr 2026 07:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775029105; cv=none; b=vDv6cS28niXTt+2YQ1vpSWz2x22i+1rrrCQD76p14t6Agdk6V9Lmjo2ChJS7El/MfGa4bK+tu4LSCRWx5TFogrktdeFZjp1/FjprNR78C7/ZFQZR7ap9OCdKuoV6HpyAEL7859P6VDqozbmUYAvx4eVuC+4Aev3hOE9yoc263+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775029105; c=relaxed/simple;
	bh=YEAALHdKJJvToiJnIbVagCsTEIKD5B6CftWwvfhDIEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDCqukN/p4i0F0nbyUTHD3yuRCqyoBNPU7Ini1ERr/KR31sfT7gLjld7q4M82s4MefofBXFO0Mg6WSJLKnqvfy66Dxq6hLgR1MNxpOaldtlIVvqJz5QcGGC6R8pUpa92Onc8JoLWGssZeaKudDfet4xvIvjaERtdUa8JguAk3dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=svDLgvAA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="svDLgvAA"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VHLmSN4036177;
	Wed, 1 Apr 2026 07:38:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=weZ71JnCdqEq8geEcjNE/j8u//HClu
	TLVOeiRBNqYF0=; b=svDLgvAAxuKhnOYI2jcZDOorikYZ0wIR4hYoMuZeAXkjPc
	h/jzzLGuWiHVVr0uycLhG/gLk1zOp9voNmPfeMiLxfllb2Ph2/82RCUkXo2UW7/h
	exKfywYjR8iYNqAS3afy3k4FUEXpyhfkWxPMhVaYTOqqQe5QKkwSZdALpknFMi9D
	B7inScJ9adNEpH1bJC37sjvs9kcGtrbQh78kV9pdE+cLfsYHTdM8463PYcVwled/
	LBQCiDuREG2xxDc3idLCYrH2/tb4UXCMtdbZZaQagoXulnf/ujRuRsvX+big327M
	1NAzkbAXeEV85GIGF/HrLIKvj4m5HhH8YnvWETAA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66ms6ay1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 07:38:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6316udMc013919;
	Wed, 1 Apr 2026 07:38:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttkmgm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 07:38:20 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6317cGKq29688100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 07:38:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BD2E20040;
	Wed,  1 Apr 2026 07:38:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70D7820043;
	Wed,  1 Apr 2026 07:38:15 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.209.181])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  1 Apr 2026 07:38:15 +0000 (GMT)
Date: Wed, 1 Apr 2026 13:08:12 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Disha Goel <disgoel@linux.ibm.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org
Subject: Re: [PATCH v2] generic/730: skip test if DAX mount option is enabled
Message-ID: <aczLZGFdP3XlSY9o@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20260323124006.85176-1-disgoel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323124006.85176-1-disgoel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69cccb6d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=rFCAN8fo0aqOatWEfCEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA2MyBTYWx0ZWRfX91pvIDJ++9hT
 s11xp3ilQtQRzqPzjtPJwPPUY2kvagzeMBBKsIvK/pmzZj0LiDfqLOvU/o///+mhvKk59h5AOxE
 Cwj4A3dNZLDKksGqHNE4BhsSaYSoY277zdw9Ny7A7OvXPMfnYfiT0VT1+afdHuNctongNJIWt8b
 ZpS+TdOGgX0E6chGw8XVf5tuY0UeIkrgjAhkr5RQH1lic1GQk5/5x62wsX7N2f1JKaAFVe6JVft
 0B4dsSdqkIgzlW8AvdHfdGjuGvkdvovmDw4imntNccLxfqDDpPESzjLNkRN7m5J1MSKyw+vFPDm
 0LTeOrIPMllSGpTGrZi3w8tOMfiOt5gF06EXmAZl0v5TPcNJoO4fVV3gUa8TG6HIrlP7xLW7mUX
 jZnYB/eelmDkBEAcEWYapG1fIs8L9XbxWnH5F4Vail5JTMdJKcZ77iIBgb11Oq5WXA8or7X2cza
 FQYK7KGiDeyGD4TxGtQ==
X-Proofpoint-GUID: hBCgyd6Bd6Mm-bOqRxfidLPLuagH855d
X-Proofpoint-ORIG-GUID: hBCgyd6Bd6Mm-bOqRxfidLPLuagH855d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010063

On Mon, Mar 23, 2026 at 06:10:05PM +0530, Disha Goel wrote:
> The generic/730 test utilizes the scsi_debug driver to create a
> synthetic SCSI block device. Since scsi_debug does not support
> DAX capabilities, attempting to mount it with "-o dax" results
> in failures (specifically on ext4).
> 
> Since this test is not DAX-related, exclude it when DAX is
> specified in MOUNT_OPTIONS to avoid compatibility issues with
> scsi_debug.
> 
> Signed-off-by: Disha Goel <disgoel@linux.ibm.com>
> ---
> Changelog v1 -> v2:
> Use _exclude_scratch_mount_option instead of an ext4-specific check.
> 
> Link to v1:
> https://lore.kernel.org/all/20260318081812.47870-1-disgoel@linux.ibm.com/
> ---
>  tests/generic/730 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/730 b/tests/generic/730
> index 6b5d3196..47073f42 100755
> --- a/tests/generic/730
> +++ b/tests/generic/730
> @@ -19,7 +19,7 @@ _cleanup()
>  
>  . ./common/filter
>  . ./common/scsi_debug
> -
> +_exclude_scratch_mount_option "dax"
>  
>  # We don't actually use the test device, but we need a block based fs
>  _require_test

Looks good Disha, feel free to add 
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
Ojaswin

> -- 
> 2.45.1
> 

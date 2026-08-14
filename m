Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09F8424D73
	for <fstests@vger.kernel.org>; Fri, 14 Aug 2026 10:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786702631; cv=none; b=pJt7KsQoDx2leV1ba8UJJuk5Rjo+get6yskeJHOgBTfC85vHqjy8BTE4EoOmS8WLCXiHXfgKUC5iwXdX3wtGO4npeaXxOT6TVSVBG1+EmtLqFf+xaHomkL7XqCWIpmp+UUVz+O4GyCbUaDx1MfzY2VZTv2z8dRceUxHjxkyn5g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786702631; c=relaxed/simple;
	bh=WvUZ/KZ3NxndcBoxm5+5Bo9eXPxaf+hhMo8duiVBY3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/1XJRFDlOyK+CFJg/BCwxDKRV1B/Bvo3eMS2CTbLTCz8fQOJjrIbSSDx9Y254ZGzAYjzGnjWJ6AGE/l4IumvJ2lB00NdKSG+0U0cR9AL3Umkrn5hdUKVxe1CTNL94iHI/g44S2/4TvVLDFNAqkG3o4QbbBI/lTcoDaX7NEcEz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LsOuIjX9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LsOuIjX9"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E81VtF585850;
	Fri, 14 Aug 2026 10:16:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=t42AOScW+hozW79bd2q2lv3jWxKr5M
	G433oBNJoYIRM=; b=LsOuIjX9sNTzeDZ1OBPIuuzUzh39CHSriizCh82Ju0xJkR
	9angr87y1leu2qVBWbIXOmlJalNSdzDTEWTYuldN/pZbrZ2vmdeaiNRKA4IM0vVy
	KLQgHiBn7F+PDH7isauKJQKQ9B/EwuP8vM2sYsgpio1KHDpuHBb36q6BJ0xiMHrd
	KZ6MlCd9x2wkbTqR9n2y7RZbtdCtFMoHBaDoKg+pnQe+GFndUQaxDsj0wc0uR7jM
	kVoNxZnXR2CyxMOa4G2Ux6KmnF5276Up123U00xiMZsCtzP+adu2rmxz8+Of60gy
	X44dyaLpsFVUv5Ci+TQYIny3TtiDXzVhHap6dCcw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvma4bwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 10:16:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67EABWsl014307;
	Fri, 14 Aug 2026 10:16:47 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gprxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 10:16:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67EAGjZq48955748
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 10:16:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B172A2006C;
	Fri, 14 Aug 2026 10:16:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9CB142006A;
	Fri, 14 Aug 2026 10:16:44 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.211.225])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 14 Aug 2026 10:16:44 +0000 (GMT)
Date: Fri, 14 Aug 2026 15:46:41 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [RFC PATCH 4/4] check: add deprecated options warning
Message-ID: <an7rCZASocVWu9Cd@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20260512132539.931482-1-zlang@kernel.org>
 <20260512132539.931482-5-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512132539.931482-5-zlang@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA3NiBTYWx0ZWRfX+Ukuf5O82+Ch
 OmuexU/nbbtqpLNC6i7BeQSkjb2rHOPUIcpCapaT9DpjKYHNTx+SeoFdv59aaDKEJBykTKzXLyU
 3awqOdgux5T0kBAxw4JEpZBA4CZFa5EyhhINfejz5gJA8aZcbzrK0Nz/ZXbGjAw7AzVzslxPLns
 nV5wIZXkIoOQbUXuVT8AGq6OTTkiyNu0YhARSoBmRK24mZASjd3FQ1+avVtN+m2XJ9sJGyBXCoX
 Ai8/zgF+KWJTfnQf7R1IaC5bbmDXligTIi+z3vL3vWkXb9RNvkQaSRQ4Nkqok0gs5eT9U0V6Wvz
 WdV6aUHkdHhrzU6/fpjpWsWbTOQnGYZmMLFRszak59wmQY47X0PstU/v1mVf6vPDq5bzBTy3A9v
 OkrztHE/s9V82rpupxv4ea3kbqFoMySKxfvfyZ6lcrgpJe7I7l9M7tu14vh9pSUDYDQrMrByHWA
 CYtvxT+wZ6AqG2V+GrQ==
X-Proofpoint-ORIG-GUID: Nk650_SU5vKRlv9nMq2IDXWfydwda0Ni
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA3NiBTYWx0ZWRfXwrswE/70r+WV
 GTAkRgsB/C3MJruvmQj6fv879lLkydVqLGAFJp0otvmhqnXM6620RPn+xmFX/dcPdZr4MIzCe4e
 43LkXqWInPPzf/n1ScbbW4O3OHGijFM=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7eeb10 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=M0rAz-6TjPG8b9AVIy0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: Nk650_SU5vKRlv9nMq2IDXWfydwda0Ni
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140076

On Tue, May 12, 2026 at 09:25:39PM +0800, Zorro Lang wrote:
> To notify xfstests users of deprecated options, add a warning which
> does not interfere with test results or golden output.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---

Looks good, feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin

>  check | 72 ++++++++++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 59 insertions(+), 13 deletions(-)
> 
> diff --git a/check b/check
> index d19498e6..012b566c 100755
> --- a/check
> +++ b/check
> @@ -275,6 +275,14 @@ _prepare_test_list()
>  	rm -f $tmp.list
>  }
>  
> +deprecated_opt_warn()
> +{
> +	local old=$1
> +	shift
> +
> +	echo "[WARN] $old is deprecated, replace it with $*"
> +}
> +
>  # Backward compatible with the old options mode. Translate word-style options
>  # that getopt would misinterpret into long options.
>  compat_old_option()
> @@ -282,19 +290,57 @@ compat_old_option()
>  	check_args=()
>  	while [ $# -gt 0 ]; do
>  		case "$1" in
> -		-nfs)		check_args+=("--fs" "nfs") ;;
> -		-afs)		check_args+=("--fs" "afs") ;;
> -		-glusterfs)	check_args+=("--fs" "glusterfs") ;;
> -		-cifs)		check_args+=("--fs" "cifs") ;;
> -		-9p)		check_args+=("--fs" "9p") ;;
> -		-fuse)		check_args+=("--fs" "fuse") ;;
> -		-virtiofs)	check_args+=("--fs" "virtiofs") ;;
> -		-pvfs2)		check_args+=("--fs" "pvfs2") ;;
> -		-tmpfs)		check_args+=("--fs" "tmpfs") ;;
> -		-ubifs)		check_args+=("--fs" "ubifs") ;;
> -		-overlay)	check_args+=("--fs" "overlay") ;;
> -		-udiff)		check_args+=("--udiff") ;;
> -		*)		check_args+=("$1") ;;
> +		-nfs)
> +			check_args+=("--fs" "nfs")
> +			deprecated_opt_warn "-nfs" "--fs nfs"
> +			;;
> +		-afs)
> +			check_args+=("--fs" "afs")
> +			deprecated_opt_warn "-afs" "--fs afs"
> +			;;
> +		-glusterfs)
> +			check_args+=("--fs" "glusterfs")
> +			deprecated_opt_warn "-glusterfs" "--fs glusterfs"
> +			;;
> +		-cifs)
> +			check_args+=("--fs" "cifs")
> +			deprecated_opt_warn "-cifs" "--fs cifs"
> +			;;
> +		-9p)
> +			check_args+=("--fs" "9p")
> +			deprecated_opt_warn "-9p" "--fs 9p"
> +			;;
> +		-fuse)
> +			check_args+=("--fs" "fuse")
> +			deprecated_opt_warn "-fuse" "--fs fuse"
> +			;;
> +		-virtiofs)
> +			check_args+=("--fs" "virtiofs")
> +			deprecated_opt_warn "-virtiofs" "--fs virtiofs"
> +			;;
> +		-pvfs2)
> +			check_args+=("--fs" "pvfs2")
> +			deprecated_opt_warn "-pvfs2" "--fs pvfs2"
> +			;;
> +		-tmpfs)
> +			check_args+=("--fs" "tmpfs")
> +			deprecated_opt_warn "-tmpfs" "--fs tmpfs"
> +			;;
> +		-ubifs)
> +			check_args+=("--fs" "ubifs")
> +			deprecated_opt_warn "-ubifs" "--fs ubifs"
> +			;;
> +		-overlay)
> +			check_args+=("--fs" "overlay")
> +			deprecated_opt_warn "-overlay" "--fs overlay"
> +			;;
> +		-udiff)
> +			check_args+=("--udiff")
> +			deprecated_opt_warn "-udiff" "--udiff"
> +			;;
> +		*)
> +			check_args+=("$1")
> +			;;
>  		esac
>  		shift
>  	done
> -- 
> 2.54.0
> 

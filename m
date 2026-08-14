Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E3242A16F
	for <fstests@vger.kernel.org>; Fri, 14 Aug 2026 08:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786695653; cv=none; b=WW1/9HSMNdzHdwqh8EUJEzynPmK1dRPOEV4y8Qz0aLpab5tCovLhrve7m/O38YRzAX1/aV7LrAZ+wXMDtjEsOVYx46UdGQLH+vA+lZ//u4b5EUtTO6u1vJOIG9n9AwUlmtNL3mWEGC68WeIT66BnevpVjkoBvbT4KoXhQGp92CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786695653; c=relaxed/simple;
	bh=nBiK0CMn0K0i6WP89mgZPmnb5kQrjlAs2QZPSsqBP9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWPTUEazbt3S0ZJySzRpCQlZNN232Mug3tL0cvsJfB2vyA3+fBh6fux3peXM08To3megckn7IZETo58j0JIrK2DNKEYEFgpMJz8F6ymwJex0/QCodmdVeyddz34K8mteQbY7RC1LwQ+bHrVjtMmMn9u7wrnWtEOwpnHgY9Vki/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=si1rGhrW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="si1rGhrW"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E822tI2902576;
	Fri, 14 Aug 2026 08:20:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=mS0xiE3vqWOpNEfI70bjzU5jz2RbxO
	HfT/HqxEX+l8Q=; b=si1rGhrWo1vIlzmHpn10h4rKtlPZBefBrWKCcadaV7gAZN
	NCaSJrHSxReLvvf8XDS22EW9iskoCe0Qj6xYpw4zLkRn7ow+BdTuflOCGYnbSvKf
	5+yYdHDPK4XfnesTo3ri4Hsku2AaP3eXvIYFlbSQN7LJ6M7URdp2Iq8NI6SMcjZ+
	MyY3/XncFdUuIh3w18C1lSAG6nF5UpWIJbEzX2S3DtcNpYW/3spDbSb1+CMz5yS7
	ndGR3+YGkh2GwZqHpRFJwy6Xb19ueNwhVq3o5qN5Mv2NwkrG20YYpG/UIMOQETDy
	NzZ2M8xHkevT6RbdggJXgj89rw2Ngze7wzoqSifg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvk0bvq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 08:20:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67E8BN8R006414;
	Fri, 14 Aug 2026 08:20:46 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5wemuh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 08:20:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67E8KiWM17760516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 08:20:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B118620040;
	Fri, 14 Aug 2026 08:20:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BBE12004B;
	Fri, 14 Aug 2026 08:20:43 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.211.225])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 14 Aug 2026 08:20:43 +0000 (GMT)
Date: Fri, 14 Aug 2026 13:50:40 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [RFC PATCH 1/4] check: refactor argument parsing with getopt
Message-ID: <an7P2CWzNnz6avGh@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20260512132539.931482-1-zlang@kernel.org>
 <20260512132539.931482-2-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512132539.931482-2-zlang@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA2MSBTYWx0ZWRfX1j+ijEi+ZYqe
 XO7/j45TxemWPWZJm0rE8gHYh1A/ElSUhNz4eU8sv6orQes8lkEMMvzEUMHo1sbwp/K2efEUg9e
 ixBbMs28344jrA9mU9ZOH/a7osCPiUUf87sL4OeVHBxrSK+mC0RQzk8KB9ZcK0KgnJ4fQQxnXwo
 o7Fx2BedDwVNnn0Vc2KXvbNu6Rw5Y4HrBfq9DhXK9yp8y/ikw67Igfhu8GZZ/nbBooxs6kUKbpi
 lblD+uGFanHpsE8q/GE5/6sgNIj+PEI6dflMbr787vYMoU+C1/ROGXXW6Gwlv03L2ypcMb0TYN+
 yuHeBpT2bsoUd/sa6lTZ0uyQ20uX3NADIV3saF3fVJ4ju/NMP3S0HAxD9B51odKwI4L8rqaZVbX
 q+K735VQlLL4ms+eefwHCvGredLVceHBvd47GlDL7kYOVgVCIHp6hUt867fNtBXo+auU917pTlx
 hCqDSZtO4a+pzAw3qdg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA2MSBTYWx0ZWRfX7cYjyE8VljVo
 /ehX/HhBj7g1azB/BfUXcYJV598BTy/QhVN7w5TBETEHPmNsVeooJOsMjgo3xf60pCzBRAgh6wK
 kDfgp+Q7/xKAOAYizDGXM5WUrBmom5E=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7ecfe0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=XMKPYZRyUV0L8jyWAnIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: qiMvhnT7scIE1giMd29GV4ZE9VtHMXCl
X-Proofpoint-ORIG-GUID: qiMvhnT7scIE1giMd29GV4ZE9VtHMXCl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140061

On Tue, May 12, 2026 at 09:25:36PM +0800, Zorro Lang wrote:
> Replace the legacy, hand-written argument parsing loop with getopt.
> Also compatible with old-style options (e.g. -nfs, -afs, -glusterfs,
> -cifs, -9p, -fuse, -virtiofs, -pvfs2, -tmpfs, -ubifs, -overlay,
> -udiff), pre-process them into long options before giving to getopt.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---
>  check | 179 +++++++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 126 insertions(+), 53 deletions(-)
> 
> diff --git a/check b/check
> index ad685edc..11bdf81b 100755
> --- a/check
> +++ b/check
> @@ -272,48 +272,97 @@ _prepare_test_list()
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
> +		*)		check_args+=("$1") ;;
> +		esac
> +		shift
> +	done
> +}
> +
> +short_opts="g:x:X:e:E:s:S:lnri:I:TdbR:L:h"
> +long_opts="fs:,exact-order,large-fs,extra-space:,udiff,help"
> +
> +compat_old_option "$@"
> +
> +# Note: The '+' prefix in getopt's option string preserves the existing
> +# behavior that option parsing stops at the first non-option test argument.
> +parsed_opts=$(getopt -n "check" -o +"${short_opts}" -l "$long_opts" -- "${check_args[@]}")
> +test $? -ne 0 && usage
> +
> +eval set -- "$parsed_opts"
> +
>  while [ $# -gt 0 ]; do
>  	case "$1" in
> -	-\? | -h | --help) usage ;;

Hi Zorro, mostly looks good but I think we slightly change the behavior
here. Earlier ./check -\? would print help but not:

   ./check -\?
  check: invalid option -- '?'
  Warning: need to define parameters for host <host>
         or set variables:
          TEST_DIR TEST_DEV

Maybe we should add this to compat_old_option ( although i really doubt
anyone would care about -\? :) )

Other than that, feel free to add:
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> -
> -	-nfs|-afs|-glusterfs|-cifs|-9p|-fuse|-virtiofs|-pvfs2|-tmpfs|-ubifs)
> -		FSTYP="${1:1}"
> +	--fs)
> +		if [ "$2" == "overlay" ];then
> +			[ "$FSTYP" == overlay ] || \
> +				export OVL_BASE_FSTYP="$FSTYP"
> +			FSTYP=overlay
> +			export OVERLAY=true
> +		else
> +			FSTYP="$2"
> +		fi
> +		shift
>  		;;
> -	-overlay)
> -		[ "$FSTYP" == overlay ] || export OVL_BASE_FSTYP="$FSTYP"
> -		FSTYP=overlay
> -		export OVERLAY=true
> +	--udiff)
> +		diff="$diff -u"
>  		;;
> -
> -	-g)	group=$2 ; shift ;
> -		GROUP_LIST="$GROUP_LIST ${group//,/ }"
> +	-g)
> +		GROUP_LIST="$GROUP_LIST ${2//,/ }"
> +		shift
>  		;;
> -
> -	-x)	xgroup=$2 ; shift ;
> -		XGROUP_LIST="$XGROUP_LIST ${xgroup//,/ }"
> +	-x)
> +		XGROUP_LIST="$XGROUP_LIST ${2//,/ }"
> +		shift
>  		;;
> -
> -	-X)	subdir_xfile=$2; shift ;
> +	-X)
> +		subdir_xfile="$2"
> +		shift
>  		;;
>  	-e)
> -		xfile=$2; shift ;
>  		readarray -t -O "${#exclude_tests[@]}" exclude_tests < \
> -			<(echo "$xfile" | tr ', ' '\n\n')
> +			<(echo "$2" | tr ', ' '\n\n')
> +		shift
>  		;;
> -
> -	-E)	xfile=$2; shift ;
> -		if [ -f $xfile ]; then
> +	-E)
> +		if [ -f "$2" ]; then
>  			readarray -t -O ${#exclude_tests[@]} exclude_tests < \
> -				<(sed "s/#.*$//" $xfile)
> +				<(sed "s/#.*$//" "$2")
>  		fi
> +		shift
> +		;;
> +	-s)
> +		RUN_SECTION="$RUN_SECTION $2"
> +		shift
> +		;;
> +	-S)
> +		EXCLUDE_SECTION="$EXCLUDE_SECTION $2"
> +		shift
> +		;;
> +	-l)
> +		diff="diff"
> +		;;
> +	-n)
> +		showme=true
>  		;;
> -	-s)	RUN_SECTION="$RUN_SECTION $2"; shift ;;
> -	-S)	EXCLUDE_SECTION="$EXCLUDE_SECTION $2"; shift ;;
> -	-l)	diff="diff" ;;
> -	-udiff)	diff="$diff -u" ;;
> -
> -	-n)	showme=true ;;
>  	-r)
>  		if $exact_order; then
>  			_fatal "Cannot specify -r and --exact-order."
> @@ -322,40 +371,64 @@ while [ $# -gt 0 ]; do
>  		;;
>  	--exact-order)
>  		if $randomize; then
> -			_fatal "Cannnot specify --exact-order and -r."
> +			_fatal "Cannot specify --exact-order and -r."
>  		fi
>  		exact_order=true
>  		;;
> -	-i)	iterations=$2; shift ;;
> -	-I) 	iterations=$2; istop=true; shift ;;
> -	-T)	timestamp=true ;;
> -	-d)	DUMP_OUTPUT=true ;;
> -	-b)	brief_test_summary=true;;
> -	-R)	report_fmt=$2 ; shift ;
> -		REPORT_LIST="$REPORT_LIST ${report_fmt//,/ }"
> +	-i)
> +		iterations=$2
> +		shift
> +		;;
> +	-I)
> +		iterations=$2
> +		istop=true
> +		shift
> +		;;
> +	-T)
> +		timestamp=true
> +		;;
> +	-d)
> +		DUMP_OUTPUT=true
> +		;;
> +	-b)
> +		brief_test_summary=true
> +		;;
> +	-R)
> +		REPORT_LIST="$REPORT_LIST ${2//,/ }"
>  		do_report=true
> +		shift
>  		;;
> -	--large-fs) export LARGE_SCRATCH_DEV=yes ;;
> -	--extra-space=*) export SCRATCH_DEV_EMPTY_SPACE=${r#*=} ;;
> -	-L)	[[ $2 =~ ^[0-9]+$ ]] || usage
> -		loop_on_fail=$2; shift
> +	--large-fs)
> +		export LARGE_SCRATCH_DEV=yes
> +		;;
> +	--extra-space)
> +		export SCRATCH_DEV_EMPTY_SPACE="$2"
> +		shift
> +		;;
> +	-L)
> +		[[ $2 =~ ^[0-9]+$ ]] || usage
> +		loop_on_fail=$2
> +		shift
> +		;;
> +	-h|--help)
> +		usage
> +		;;
> +	--)
> +		shift
> +		break
> +		;;
> +	*)
> +		usage
>  		;;
> -
> -	-*)	usage ;;
> -	*)	# not an argument, we've got tests now.
> -		have_test_arg=true ;;
>  	esac
> -
> -	# if we've found a test specification, the break out of the processing
> -	# loop before we shift the arguments so that this is the first argument
> -	# that we process in the test arg loop below.
> -	if $have_test_arg; then
> -		break;
> -	fi
> -
>  	shift
>  done
>  
> +# Remaining arguments
> +if [ $# -gt 0 ]; then
> +	have_test_arg=true
> +fi
> +
>  # we need common/rc, that also sources common/config. We need to source it
>  # after processing args, overlay needs FSTYP set before sourcing common/config
>  if ! . ./common/rc; then
> -- 
> 2.54.0
> 

Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6831D440A07
	for <fstests@vger.kernel.org>; Fri, 14 Aug 2026 10:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786702499; cv=none; b=SBpZiwVL0voPnjySLHmVQk8XXwb9fCS/lXqbN1wh+WsmMzYg6PH5qUa5hEFkyIC6kTQJQHuVIdrLDAwIQqWE8oy1bfON4uh+fjTJCDyIo+GgrjEvDSQjuPK/EcrqznqBzIIyUPWx4BAtLRsSL2wMqYfC92uaa5MUqF+RhDcktPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786702499; c=relaxed/simple;
	bh=BWayeoL0COBugTavy07QH5wYCkQ3vMofwBxD2v3zAOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFpTSKKpuE2iiYall82oZ0MZx9UNpmuqddMJY17x69J2j6U7jKPrx6YQqRkrpt6/o7cKJbEEYj7lqHe6LMHHG3CJp8NOliSqy9Nt4si35kidydNf0AbhpHaSywWrYdm0GZ03sMNkxRkVkFt+1nQyRak+7e2npeawR4lIPT+Oab8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NVF7fGat; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NVF7fGat"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E81X7T585878;
	Fri, 14 Aug 2026 10:14:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=/b+8YXsjD1Pv2U+IXUSMVUutZwNMcU
	Dx8QfNfD15L1M=; b=NVF7fGatMwz0U1mhD3ICaeDBAV1Jqoj9tlNTCPaJWXu3UO
	HWq3HKUQ7S4hBc+wPtnujcpSSZr0ZYEB7ld0TveGJXKlXJkhUhIRlkqfIJhxiz55
	uOwfKhF9II4vxYV09n4ebCUJGeQJLVBlKswcnJHI2qSEUQOdl/uRLy+/4FzSUEWs
	v2bv9AiVvHC2yAGOKds8haZNVe7ERdYev1b5MFBNcTaNpS3VXdFxLzSxp6LUwfwm
	58Bkpnm1EMxM2TxWL8/VPsevkuFpFC59LB0DWXLgX25OEfaaVkqs6oYkWP1nXCcZ
	9cO9jwGjkQN9Mhh4xS3E9+lCqKYAmRCaUekgMHqg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvma4bnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 10:14:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67EABJxd031630;
	Fri, 14 Aug 2026 10:14:44 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9hetdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 10:14:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67EAEfBb50790686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 10:14:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7FD82006B;
	Fri, 14 Aug 2026 10:14:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DC1C2006A;
	Fri, 14 Aug 2026 10:14:40 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.211.225])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 14 Aug 2026 10:14:40 +0000 (GMT)
Date: Fri, 14 Aug 2026 15:44:37 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [RFC PATCH 3/4] check: consolidate argument handling into
 function
Message-ID: <an7qjcdGnhA9_-Ln@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20260512132539.931482-1-zlang@kernel.org>
 <20260512132539.931482-4-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512132539.931482-4-zlang@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA3NiBTYWx0ZWRfX72vA21sTNseL
 q6JelT+NLlUnUdj+HnGMWkklzQ1xUvjmBxTv2aieSORqCCItzVA5IK6OkUZQaHs5JMa657wY+Qr
 L8ZjYTOX0Xf7JSKb2sEAl2EDjMv1ThbYQs59PQM5AXMVbDm/I6py4XKgSVLjScuatekGmwroGPn
 nai4NKLDaQemRRH9Aq9eecTOTpXHjsp7n588uUgVP4qagmxxH7HRi7M1ircHnqWzdAReeFFhO0Z
 Vnj6zp+QsT0Bzfw00HmD0WRWHOUYzU1RGoO7gi4J6ZK2BxXlOd4qqqk4k4z9gMH0J+qR/7Z/e0N
 zMbCX7I3EetaxzcqNNI/F+7tBdalnZBQAMs0Q4FxiuLx4B8lojVmDHWhyRNiaN9tAeMi8CcPrE9
 yMFK6FLYpslEG2fZmNuBqkAJVqh/VUbcNKPfnHHdGvsw0Wq1GpK1ZCMhOdgOZTyacGvaVcaZTda
 zdc0nXQ0NT8E1zLndPA==
X-Proofpoint-ORIG-GUID: VoH52kGnAOy-i_cNKSsBgazItiF-8t5W
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA3NiBTYWx0ZWRfX4ch1FCwzq/bd
 3Ye6NylmGvzmymHmpz0j5Z8WMgGfxm4KcrDfxqa8tyZCl6gdU1F+Mj65ty5hSyicUtdO1gkjWlD
 sPAsA1ObRTbaoB+5V/2Mpf74FjUoiSA=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7eea95 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=LxnwgpZwZeHTkVJR26EA:9 a=CjuIK1q_8ugA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: VoH52kGnAOy-i_cNKSsBgazItiF-8t5W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140076

On Tue, May 12, 2026 at 09:25:38PM +0800, Zorro Lang wrote:
> Consolidate the check script's options and any trailing arguments
> (e.g. test case list) into the parse_check_args() function (and
> sub-function of it), to clean up the scattered logic.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>

Looks good to me Zorro. 

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin

> ---
>  check | 333 ++++++++++++++++++++++++++++++----------------------------
>  1 file changed, 172 insertions(+), 161 deletions(-)
> 
> diff --git a/check b/check
> index 5fe35e8e..d19498e6 100755
> --- a/check
> +++ b/check
> @@ -15,7 +15,7 @@ notrun=()
>  interrupt=true
>  diff="diff -u"
>  showme=false
> -have_test_arg=false
> +remain_args=()
>  randomize=false
>  exact_order=false
>  export here=`pwd`
> @@ -228,7 +228,7 @@ _prepare_test_list()
>  	# Specified groups to include
>  	# Note that the CLI processing adds a leading space to the first group
>  	# parameter, so we have to catch that here checking for "all"
> -	if ! $have_test_arg && [ "$GROUP_LIST" == " all" ]; then
> +	if [ ${#remain_args[@]} -eq 0 ] && [ "$GROUP_LIST" == " all" ]; then
>  		# no test numbers, do everything
>  		get_all_tests
>  	else
> @@ -300,137 +300,182 @@ compat_old_option()
>  	done
>  }
>  
> -short_opts="g:x:X:e:E:s:S:lnri:I:TdbR:L:h"
> -long_opts="fs:,exact-order,large-fs,extra-space:,udiff,help"
> -
> -compat_old_option "$@"
> +# Process tests from command line now.
> +process_remain_tests()
> +{
> +	local list test_dir test_name group_file
>  
> -# Note: The '+' prefix in getopt's option string preserves the existing
> -# behavior that option parsing stops at the first non-option test argument.
> -parsed_opts=$(getopt -n "check" -o +"${short_opts}" -l "$long_opts" -- "${check_args[@]}")
> -test $? -ne 0 && usage
> +	while [ $# -gt 0 ]; do
> +		case "$1" in
> +		-*)
> +			_fatal "Arguments before tests, please!"
> +			;;
> +		*)
> +			# Expand test pattern (e.g. xfs/???, *fs/001)
> +			list=$(cd $SRC_DIR; echo $1)
> +			for t in $list; do
> +				t=${t#$SRC_DIR/}
> +				test_dir=${t%%/*}
> +				test_name=${t##*/}
> +				group_file=$SRC_DIR/$test_dir/group.list
>  
> -eval set -- "$parsed_opts"
> +				if grep -Eq "^$test_name" $group_file; then
> +					# in group file ... OK
> +					echo $SRC_DIR/$test_dir/$test_name \
> +						>>$tmp.arglist
> +				else
> +					# oops
> +					echo "$t - unknown test, ignored"
> +				fi
> +			done
> +			;;
> +		esac
>  
> -while [ $# -gt 0 ]; do
> -	case "$1" in
> -	--fs)
> -		if [ "$2" == "overlay" ];then
> -			[ "$FSTYP" == overlay ] || \
> -				export OVL_BASE_FSTYP="$FSTYP"
> -			FSTYP=overlay
> -			export OVERLAY=true
> -		else
> -			FSTYP="$2"
> -		fi
> -		shift
> -		;;
> -	--udiff)
> -		diff="$diff -u"
> -		;;
> -	-g)
> -		GROUP_LIST="$GROUP_LIST ${2//,/ }"
> -		shift
> -		;;
> -	-x)
> -		XGROUP_LIST="$XGROUP_LIST ${2//,/ }"
> -		shift
> -		;;
> -	-X)
> -		subdir_xfile="$2"
>  		shift
> -		;;
> -	-e)
> -		readarray -t -O "${#exclude_tests[@]}" exclude_tests < \
> -			<(echo "$2" | tr ', ' '\n\n')
> -		shift
> -		;;
> -	-E)
> -		if [ -f "$2" ]; then
> -			readarray -t -O ${#exclude_tests[@]} exclude_tests < \
> -				<(sed "s/#.*$//" "$2")
> -		fi
> -		shift
> -		;;
> -	-s)
> -		RUN_SECTION="$RUN_SECTION $2"
> -		shift
> -		;;
> -	-S)
> -		EXCLUDE_SECTION="$EXCLUDE_SECTION $2"
> -		shift
> -		;;
> -	-l)
> -		diff="diff"
> -		;;
> -	-n)
> -		showme=true
> -		;;
> -	-r)
> -		if $exact_order; then
> -			_fatal "Cannot specify -r and --exact-order."
> -		fi
> -		randomize=true
> -		;;
> -	--exact-order)
> -		if $randomize; then
> -			_fatal "Cannot specify --exact-order and -r."
> -		fi
> -		exact_order=true
> -		;;
> -	-i)
> -		iterations=$2
> -		shift
> -		;;
> -	-I)
> -		iterations=$2
> -		istop=true
> -		shift
> -		;;
> -	-T)
> -		timestamp=true
> -		;;
> -	-d)
> -		DUMP_OUTPUT=true
> -		;;
> -	-b)
> -		brief_test_summary=true
> -		;;
> -	-R)
> -		REPORT_LIST="$REPORT_LIST ${2//,/ }"
> -		do_report=true
> -		shift
> -		;;
> -	--large-fs)
> -		export LARGE_SCRATCH_DEV=yes
> -		;;
> -	--extra-space)
> -		export SCRATCH_DEV_EMPTY_SPACE="$2"
> -		shift
> -		;;
> -	-L)
> -		[[ $2 =~ ^[0-9]+$ ]] || usage
> -		loop_on_fail=$2
> -		shift
> -		;;
> -	-h|--help)
> -		usage
> -		;;
> -	--)
> +	done
> +}
> +
> +parse_check_args()
> +{
> +	local short_opts="g:x:X:e:E:s:S:lnri:I:TdbR:L:h"
> +	local long_opts="fs:,exact-order,large-fs,extra-space:,udiff,help"
> +
> +	compat_old_option "$@"
> +
> +	# Note: The '+' prefix in getopt's option string preserves the existing
> +	# behavior that option parsing stops at the first non-option test argument.
> +	local parsed_opts=$(getopt -n "check" -o +"${short_opts}" -l "$long_opts" -- "${check_args[@]}")
> +	test $? -ne 0 && usage
> +
> +	eval set -- "$parsed_opts"
> +
> +	while [ $# -gt 0 ]; do
> +		case "$1" in
> +		--fs)
> +			if [ "$2" == "overlay" ];then
> +				[ "$FSTYP" == overlay ] || \
> +					export OVL_BASE_FSTYP="$FSTYP"
> +				FSTYP=overlay
> +				export OVERLAY=true
> +			else
> +				FSTYP="$2"
> +			fi
> +			shift
> +			;;
> +		--udiff)
> +			diff="$diff -u"
> +			;;
> +		-g)
> +			GROUP_LIST="$GROUP_LIST ${2//,/ }"
> +			shift
> +			;;
> +		-x)
> +			XGROUP_LIST="$XGROUP_LIST ${2//,/ }"
> +			shift
> +			;;
> +		-X)
> +			subdir_xfile="$2"
> +			shift
> +			;;
> +		-e)
> +			readarray -t -O "${#exclude_tests[@]}" exclude_tests < \
> +				<(echo "$2" | tr ', ' '\n\n')
> +			shift
> +			;;
> +		-E)
> +			if [ -f "$2" ]; then
> +				readarray -t -O ${#exclude_tests[@]} exclude_tests < \
> +					<(sed "s/#.*$//" "$2")
> +			fi
> +			shift
> +			;;
> +		-s)
> +			RUN_SECTION="$RUN_SECTION $2"
> +			shift
> +			;;
> +		-S)
> +			EXCLUDE_SECTION="$EXCLUDE_SECTION $2"
> +			shift
> +			;;
> +		-l)
> +			diff="diff"
> +			;;
> +		-n)
> +			showme=true
> +			;;
> +		-r)
> +			if $exact_order; then
> +				_fatal "Cannot specify -r and --exact-order."
> +			fi
> +			randomize=true
> +			;;
> +		--exact-order)
> +			if $randomize; then
> +				_fatal "Cannot specify --exact-order and -r."
> +			fi
> +			exact_order=true
> +			;;
> +		-i)
> +			iterations=$2
> +			shift
> +			;;
> +		-I)
> +			iterations=$2
> +			istop=true
> +			shift
> +			;;
> +		-T)
> +			timestamp=true
> +			;;
> +		-d)
> +			DUMP_OUTPUT=true
> +			;;
> +		-b)
> +			brief_test_summary=true
> +			;;
> +		-R)
> +			REPORT_LIST="$REPORT_LIST ${2//,/ }"
> +			do_report=true
> +			shift
> +			;;
> +		--large-fs)
> +			export LARGE_SCRATCH_DEV=yes
> +			;;
> +		--extra-space)
> +			export SCRATCH_DEV_EMPTY_SPACE="$2"
> +			shift
> +			;;
> +		-L)
> +			[[ $2 =~ ^[0-9]+$ ]] || usage
> +			loop_on_fail=$2
> +			shift
> +			;;
> +		-h|--help)
> +			usage
> +			;;
> +		--)
> +			shift
> +			break
> +			;;
> +		*)
> +			usage
> +			;;
> +		esac
>  		shift
> -		break
> -		;;
> -	*)
> -		usage
> -		;;
> -	esac
> -	shift
> -done
> +	done
>  
> -# Remaining arguments
> -if [ $# -gt 0 ]; then
> -	have_test_arg=true
> -fi
> +	# Remaining arguments (tests list)
> +	if [ $# -gt 0 ]; then
> +		remain_args=("$@")
> +		process_remain_tests "${remain_args[@]}"
> +	elif [ -z "$GROUP_LIST" ]; then
> +		# default group list is the auto group. If any other group or
> +		# test is specified, we use that instead.
> +		GROUP_LIST="auto"
> +	fi
> +}
> +
> +parse_check_args "$@"
>  
>  # we need common/rc, that also sources common/config. We need to source it
>  # after processing args, overlay needs FSTYP set before sourcing common/config
> @@ -471,40 +516,6 @@ if [ -n "$subdir_xfile" ]; then
>  	done
>  fi
>  
> -# Process tests from command line now.
> -if $have_test_arg; then
> -	while [ $# -gt 0 ]; do
> -		case "$1" in
> -		-*)	_fatal "Arguments before tests, please!"
> -			;;
> -		*)	# Expand test pattern (e.g. xfs/???, *fs/001)
> -			list=$(cd $SRC_DIR; echo $1)
> -			for t in $list; do
> -				t=${t#$SRC_DIR/}
> -				test_dir=${t%%/*}
> -				test_name=${t##*/}
> -				group_file=$SRC_DIR/$test_dir/group.list
> -
> -				if grep -Eq "^$test_name" $group_file; then
> -					# in group file ... OK
> -					echo $SRC_DIR/$test_dir/$test_name \
> -						>>$tmp.arglist
> -				else
> -					# oops
> -					echo "$t - unknown test, ignored"
> -				fi
> -			done
> -			;;
> -		esac
> -
> -		shift
> -	done
> -elif [ -z "$GROUP_LIST" ]; then
> -	# default group list is the auto group. If any other group or test is
> -	# specified, we use that instead.
> -	GROUP_LIST="auto"
> -fi
> -
>  if [ `id -u` -ne 0 ]
>  then
>      _fatal "check: QA must be run as root"
> -- 
> 2.54.0
> 

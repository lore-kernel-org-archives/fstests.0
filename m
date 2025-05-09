Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06677290BBE
	for <fstests@vger.kernel.org>; Fri,  9 May 2025 13:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746796616; cv=none; b=YcrnHkqicDzn7KhmznLIyzDrdfPjDpZuAzcegw2Vr9yEQfqKzO/IUXpYCzBZ2o6OWD2GXI1Lq8gjhWxAV7wPbseSYkdw0ky0I9t8khtKnzFmgmbQWaRQEhddw0zK6VS+xBGrsYTJFFpaRPVCjs1Ber1iBevOeE8Cn+rPJ8LZ+CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746796616; c=relaxed/simple;
	bh=hVS5k5WqP3tRFP5rJvHI1zuheItERHdYmgGwylMLZRY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=UGA7y5Ohk08MWCICM1MyG/cyg1wHqxy8kuiOJLeQ8q8R5Kfe4QFuUtpqhDyfFwt0ZF0bgJwRDVXKP1rVJ8D0XfPEnZ5Ss38gqwHydD+OCq3GZM/xAvpmyLh8BBkp4CwJQpkHplEQ3f0YnqhAnwF0/wQvYO/NVEWw5ueYDP7vwLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pZwxlrl6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pZwxlrl6"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5494Bvf2031517;
	Fri, 9 May 2025 13:16:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YI0MUh
	mpGh9iOP0ihX9sKUBrajBSNYanc6ertczZ3Xg=; b=pZwxlrl6F4yFnznPZTLSoQ
	Br1Ne12qxrcILpv0S1n9N1660qKx3ZToivxTuL6VES+FcooRuVxcTYrcDLLnXVZ8
	vLyvjZBmLj3EgrSxIxJP6xchfQ/jD6HDunnrw7ZEdCpvAdVQ/uA07QLmYcNM0Sqb
	nNnM77WqhNOdKV4YB2TvxiJIqdGSblzDuEILD3wD/Td6X0vKa6mAyq0gmgC3Fs4Q
	Z2h7aAQTUZVQavUwcQrYY28EETGRKxrWNxjMXXQIeRxtR1/6Tr90zUlm3e5w2mtP
	7YBV5JYRRlotDHyJKwhwnRb1wF2BC9H7vApda3NwRw1yP/CVkLyWeDTNgMSGVUrA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46h4rwbuqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 13:16:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 549B6lFD001304;
	Fri, 9 May 2025 13:16:50 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46dwftumvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 13:16:49 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 549DGmo051773860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 May 2025 13:16:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4295120072;
	Fri,  9 May 2025 13:16:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53F0B20071;
	Fri,  9 May 2025 13:16:47 +0000 (GMT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com (unknown [9.39.25.103])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 May 2025 13:16:47 +0000 (GMT)
Message-ID: <e8cfb210bc518c1a4295de556283fc354fbfeea9.camel@linux.ibm.com>
Subject: Re: [PATCH 15/28] check-parallel: de-batch test execution
From: Nirjhar Roy <nirjhar@linux.ibm.com>
To: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Cc: zlang@kernel.org
Date: Fri, 09 May 2025 18:46:46 +0530
In-Reply-To: <20250417031208.1852171-16-david@fromorbit.com>
References: <20250417031208.1852171-1-david@fromorbit.com>
	 <20250417031208.1852171-16-david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QIxoRhLL c=1 sm=1 tr=0 ts=681e0042 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=T_4lWRM-uSXc7GhnJfIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: HJmFRZOo5h3XTo1T7BzjQKq3eZxYhC-d
X-Proofpoint-ORIG-GUID: HJmFRZOo5h3XTo1T7BzjQKq3eZxYhC-d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDEyOCBTYWx0ZWRfX0+4aWYog+d6q REWftT7CEST5DRr47n973UB1uzXzrqYLrdFeecid4zRz3bBzVEHVBAtWFENdK2PPSKmwOqCR1Ec SX8/a7bS2LXn0LUTrycYdXVMWneMPyrJnKcnTtDJdAmza8tVSmSWrfTiloUfTgv5fkJsY//SIlL
 GwxWGXi3yLB0qb4MNcnAWwlLfai4hKrcFIuXKRyXUXBceH0IG1FI0/Zj/usH6Q4o+AYIqBJBZ2m GVQrXtqMjYsNjWl0MBgSefwaKjoqIf0rwc96hCOtlhjdaD/ySCE/oQv2IshlbjckHCZN8QczXTi Nc44u0YZacsyGOy6RC167xEJEC7wYkqqxL+DkSHL3WxUdRJoP2oPbQ31Yf+3JTi+c3MAqOPIl/n
 jhDKnZQ8V8ace4oUn9mPwpeoS3BrT+qaKAjgM2NUg5sswKt7j2DVsfJzrHdv6Z5QT3IhZqqH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_05,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505090128

On Thu, 2025-04-17 at 13:00 +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> To improve how check-parallel runs tests, it needs to run tests
> directly from the runner threads. We currently batch them based on
> runtime before we execture any tests, but this results in runner 0
> always having a test list with runtime longer than the test list for
> runner N.
> 
> As a result, we can end up with higher numbered runners finishing
> all their tests before runner 0 has even finished the first test it
> was given to run. Hence we end up with check-parallel starting with
> maximum concurrency, but the test concurrency reduces as the run
> goes on.
> 
> To fix this, we need a dynamic test list such that each runner only
> needs to be scheduled to run a single test at a time. When they have
> finished the current test, they can pop the next test to run off the
> time ordered stack and execute that. Hence test runners won't stop
> running until there are no more tests to run, hence maximising
> concurrency across the entire test run.
> 
> To do this, we first need a test list mechanism that is safe for
> concurrent destacking from multiple test runners. We place the
> test list in a temporary file, then use file locks to serialise
> access to the temporary file.
> 
> We order the list in the test file from lowest runtime to
> highest. This means that running tests from longest to shortest
> runtime destacks from the end fo the file. This means that the next
> test to run is always the last line fo the file and we can simply
> use truncation based mechanisms to consume the test during
> destacking.
> 
> Running tests individually via check like this is inefficient as
> there is a lot of check setup and initialisation overhead.  However,
> by increasing the utilisation of the test runner threads, overall
> runtime of check-parallel does not increase with this change.
> Reduction of this repeated overhead will also be addressed in future
> patches.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  check-parallel | 75 +++++++++++++++++++++++++++++---------------------
>  1 file changed, 43 insertions(+), 32 deletions(-)
> 
> diff --git a/check-parallel b/check-parallel
> index 6fc86fb92..e2cf2c8d0 100755
> --- a/check-parallel
> +++ b/check-parallel
> @@ -18,6 +18,7 @@ run_section=""
>  iam="check-parallel"
>  
>  tmp=/tmp/check-parallel.$$
> +test_list="$tmp.test_list"
>  
>  . ./common/exit
>  . ./common/test_names
> @@ -150,9 +151,6 @@ if [ -d "$basedir/runner-0/" ]; then
>  	prev_results=`ls -tr $basedir/runner-0/ | grep results | tail -1`
>  fi
>  
> -_tl_prepare_test_list
> -_tl_strip_test_list
> -
>  # grab all previously run tests and order them from highest runtime to lowest
>  # We are going to try to run the longer tests first, hopefully so we can avoid
>  # massive thundering herds trying to run lots of really short tests in parallel
> @@ -198,22 +196,22 @@ if ! $_tl_randomise -a ! $_tl_exact_order; then
>  	fi
>  fi
>  
> -# split the list amongst N runners
> -split_runner_list()
> +# Grab the next test to be run from the tail of the file.
> +# Returns an empty string if there is no tests remaining to run.
> +# File operations are run under flock so concurrent gets are serialised against
> +# each other.
> +get_next_test()
>  {
> -	local ix
> -	local rx
> -	local -a _list=( $_tl_tests )
> -	for ((ix = 0; ix < ${#_list[*]}; ix++)); do
> -		seq="${_list[$ix]}"
> -		rx=$((ix % $runners))
> -		if ! _tl_expunge_test $seq; then
> -			runner_list[$rx]+="${_list[$ix]} "
> -		fi
> -		#echo $seq
> -	done
> +	local test=
> +
> +	flock 99
> +	test=$(tail -1 $test_list)
> +	sed -i "\,$test,d" $test_list
> +	flock -u 99
> +	echo $test
>  }
>  
> +
>  _create_loop_device()
>  {
>          local file=$1 dev
> @@ -240,6 +238,8 @@ _destroy_loop_device()
>  
>  runner_go()
>  {
> +	exec 99<>$tmp.test_list_lock
> +
>  	local id=$1
>  	local me=$basedir/runner-$id
>  	local _test=$me/test.img
> @@ -250,6 +250,7 @@ runner_go()
>  	local _scratch_log=$me/scratch-log.img
>  	local _logwrites=$me/logwrites.img
>  	local _results=$me/results-$2
> +	local test_to_run=$(get_next_test)
>  
>  	mkdir -p $me
>  
> @@ -291,7 +292,15 @@ runner_go()
>  	# Similarly, we need to run check in it's own PID namespace so that
>  	# operations like pkill only affect the runner instance, not globally
>  	# kill processes from other check instances.
> -	tools/run_privatens ./check $run_section -x unreliable_in_parallel --exact-order ${runner_list[$id]} >> $me/log 2>&1
> +	while [ -n "$test_to_run" ]; do
> +		echo "Runner $id: running test $test_to_run"
> +		unset FSTESTS_ISOL
> +		if ! _tl_expunge_test $test_to_run; then
> +			tools/run_privatens ./check $run_section $test_to_run >> $me/log 2>&1
> +		fi
> +
> +		test_to_run=$(get_next_test)
> +	done
>  
>  	wait
>  	sleep 1
> @@ -320,20 +329,32 @@ cleanup()
>  	umount -R $basedir/*/test 2> /dev/null
>  	umount -R $basedir/*/scratch 2> /dev/null
>  	losetup --detach-all
> +	rm -rf $tmp.*
>  }
>  
>  trap "cleanup; exit" HUP INT QUIT TERM
>  
>  _config_setup_parallel
>  
> -split_runner_list
> +_tl_setup_exclude_group "unreliable_in_parallel"
> +_tl_prepare_test_list
> +_tl_strip_test_list
> +
> +if ! $_tl_randomise -a ! $_tl_exact_order; then
> +	if [ -f $basedir/runner-0/$prev_results/check.time ]; then
> +		time_order_test_list
> +	fi
> +fi
> +
> +# reverse the order of tests so that the get_next_test() can pull from the file
> +# tail rather than the head.
> +echo $_tl_tests |sed -e 's/ /\n/g' | tac > $test_list
>  if [ -n "$show_test_list" ]; then
>  	echo Time ordered test list:
> -	echo $_tl_tests
> -	echo
> +	cat $test_list
> +	exit 0
_exit 0?

Looks good otherwise. I think this change will extract the maximum concurrency since we are kind of
uniformly distrubuting the long running tests instead of flooding runner-0 with the top n slow
running tests.
Reviewed-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
--NR
>  fi
>  
> -
>  # Each parallel test runner needs to only see it's own mount points. If we
>  # leave the basedir as shared, then all tests see all mounts and then we get
>  # mount propagation issues cropping up. For example, cloning a new mount
> @@ -349,20 +370,10 @@ mount --make-private $basedir
>  
>  now=`date +%Y-%m-%d-%H:%M:%S`
>  for ((i = 0; i < $runners; i++)); do
> -
> -	if [ -n "$show_test_list" ]; then
> -		echo "Runner $i: ${runner_list[$i]}"
> -	else
> -		runner_go $i $now &
> -	fi
> -
> +	runner_go $i $now &
>  done;
>  wait
>  
> -if [ -n "$show_test_list" ]; then
> -	exit 0
> -fi
> -
>  echo -n "Tests run: "
>  grep Ran $basedir/*/log | sed -e 's,^.*:,,' -e 's, ,\n,g' | sort | uniq | wc -l
>  


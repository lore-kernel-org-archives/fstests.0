Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF07225B69F
	for <fstests@vger.kernel.org>; Tue,  6 May 2025 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746547004; cv=none; b=dXyotu17RTsWs1lGUe7ry7qWBAIBdEo/4JhJ7XN19NIMHWvVhWiS35mitAU2it8RzBoEQYr0fRlYIq2maKuE66NV2DCdjtbGwl0laS4vx3c8N+G7CpZw7Bv2pFZXhhfHQOvuhGV/3HaGHUQuJlvcomgenBJiwZQfqea6Ux/wJAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746547004; c=relaxed/simple;
	bh=p5InYBlf0bio67z/TCBL312VcGDWK5TT1ptwE1KVK9Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=n5azCdLzBzSmHjHFewluiFsHnOsf/8M26InRIK5Ei0O+SsDpUny22n3GlKGZIqu3EdnIxqNvqeJaO7KW/EiRFPOxzCDFW2Dn2N49UrFLo8HC+YphYfSPkOOGWP7s0SzwYrtNMl684gLK78n85jiVcZaxjLz4hAHFkpGqedb7B/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTda+l72; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTda+l72"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-73972a54919so5373149b3a.3
        for <fstests@vger.kernel.org>; Tue, 06 May 2025 08:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746547002; x=1747151802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QrmudHhq43ypG81hwufXYtqKA9eKV853A36l81r1Sr4=;
        b=jTda+l724t4yNrvcInvpt1u/ScfsZBmV4yTdzPrNngwOBRBwbuRggyNBh1tZXgPJmh
         cYkTinR3dvLtpVNJuzOHW3N7gdk+OLp3NHl5kh77yFaxRHy7qRoLCu2v7wEdOhw0naNP
         lodv2GCTxds9eukhlqdVi950Dlobwx8QrgwCqU4Zfb3XjSqQ1bxOBIvizWQx3itNqc+Z
         ARIs2+w9gylP2mklASOrYFdiVIu65OD0TqY3oHYn/8v7jj+pP1UT0Mi+/ejrHP+xuAV7
         N/dDLwChSEXn7Xh3Zu1nWHjwVfs5DlKkNI+1OXnI0McgT8gv4UrEu5WolPcVdZZc9LXk
         SCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746547002; x=1747151802;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QrmudHhq43ypG81hwufXYtqKA9eKV853A36l81r1Sr4=;
        b=XXromqqtN0ikU+jqf9s+e2DlYjfVxsWqhTKAGc0sQeR8G57G5lTkeNHvU0NwI6Cgm2
         97xFTq+LGymSYBJb0/9W9aW7xHTeBGqphVfWIBcuM9SSIldSRonURBtz81hphgq0EIbQ
         uNc1PqLspnIJ3ghJAOXoXBZcjNNlfhqGk2xpNhUvBtMzHHXAirZuxMVzPmIwZjAo75Bl
         MuwUsN3j0sW/Rol+z2ze+Js+GbQ7VX+ZO7Pniv3PJPb50NuhAxUJt/96RpShthJ7c4+c
         wgxPlmSorYt4Uly1Om2PTw3iQOfAWIbXfZIjXYnGMuIvBRzGTmOJhqASgZVAquWcg52K
         6pFg==
X-Forwarded-Encrypted: i=1; AJvYcCXKygqwsbWFvZuxAsXBTEjHGj4yswyGKGyfNi3iZfl5VIoKg3J7IaBUHkXiBtcCLJdaPLfmANOm@vger.kernel.org
X-Gm-Message-State: AOJu0YzPJFUT1eYi7CH5GkvTtbMN/WHTZ7KAWBSzV9c3XuaorLZUm0za
	ckHBZTJm5UFA7HSYj6mnFdkUKHBNg3G/X5OZ9tKY2gvW7TbDCg4jXcxg+Q==
X-Gm-Gg: ASbGnctr71wJFRu8N0mxXRb9ENh+uuEBPUBvJbtNFcIQSj76+AQMpY/flsirYO0OqKp
	YlPahJe21JOMrs0o42D8WzqkP2vX/gwJcQj2Jj0Zo/PUJKTutSRGdNL4dOhAk/AjtTdIHITzVVq
	4XUg6nr2XYUpgPbBa6uYjA4L+izZLi6KQu1k7Oq++JlSSJfSEHk6DVDZpsh0KJ+Mu2gTUepZ4jR
	a92pKjA5eyOQKYhop3lF7UI+chNiYx4h6jzv+lUk690aNjIT7opalMuiWrwG6MllNK2xDLfdfC5
	huIqlHB4OqPVoNLv7ZJraWPAUUBac+UQoWDyFVgmKIkm46S5IJs/7AJz9565rg/YaTPH6AsRECl
	h+knY24fJfedLBW/4nw==
X-Google-Smtp-Source: AGHT+IGa/Sv/PrrhSchlijMn+cRYRjxOrVdgAlT97tzLN35w3rTk0DaaEfJFKec9461z9VwYFFp5lw==
X-Received: by 2002:a05:6a00:44c7:b0:736:3fa8:cf7b with SMTP id d2e1a72fcca58-7406f0df774mr15637371b3a.13.1746547001678;
        Tue, 06 May 2025 08:56:41 -0700 (PDT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74059020dd4sm9092960b3a.117.2025.05.06.08.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 08:56:41 -0700 (PDT)
Message-ID: <39c2355dea38ef102f7a6c930f14f0cd14e6bbdc.camel@gmail.com>
Subject: Re: [PATCH 06/28] check-parallel: use common group list parsing code
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Cc: zlang@kernel.org
Date: Tue, 06 May 2025 21:26:37 +0530
In-Reply-To: <20250417031208.1852171-7-david@fromorbit.com>
References: <20250417031208.1852171-1-david@fromorbit.com>
	 <20250417031208.1852171-7-david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2025-04-17 at 13:00 +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Build the test list directly from command line prompts, rather
> than hard coding the tests and using the check infrastructure to
> filter that list.
> 
> We still pass exact test lists to check to execute the tests that
> each runner needs to execute, but all other test list commands
> are no longer passed to check.
> 
> As a result of this change, check-parallel no longer passes unknown
> CLI parameters through to the internal check invocations. At this
> point, the only non test-list related option is config file section
> selection; more of the check options will be brought across as
> needed in future patches.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  check            |   6 +-
>  check-parallel   | 156 ++++++++++++++++++++++++++++++++++++++++-------
>  common/test_list |   7 +++
>  3 files changed, 143 insertions(+), 26 deletions(-)
> 
> diff --git a/check b/check
> index 900ea2ba4..0b489cb4b 100755
> --- a/check
> +++ b/check
> @@ -43,11 +43,9 @@ timestamp=${TIMESTAMP:=false}
>  
>  rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.report.* $tmp.arglist
>  
> -# We need to include the test list processing first as argument parsing
> -# requires test list parsing and setup.
> -. ./common/test_list
> -
>  . ./common/exit
> +. ./common/test_names
> +. ./common/test_list
>  
>  usage()
>  {
> diff --git a/check-parallel b/check-parallel
> index d68d76e55..cb5d6aedf 100755
> --- a/check-parallel
> +++ b/check-parallel
> @@ -9,18 +9,114 @@
>  # for them and runs the test in the background. When it completes, it tears down
>  # the loop devices.
>  
> -export SRC_DIR="tests"
> -basedir=$1
> -shift
> -check_args="$*"
> +basedir=""
>  runners=64
>  runner_list=()
>  runtimes=()
> +show_test_list=
> +run_section=""
>  
> +tmp=/tmp/check-parallel.$$
>  
> -# tests in auto group
> -test_list=$(awk '/^[0-9].*auto/ { print "generic/" $1 }' tests/generic/group.list)
> -test_list+=$(awk '/^[0-9].*auto/ { print "xfs/" $1 }' tests/xfs/group.list)
> +export FSTYP=xfs
> +
> +. ./common/exit
> +. ./common/test_names
> +. ./common/test_list
> +
> +usage()
> +{
> +    echo "Usage: $0 [options] [testlist]"'
> +
> +check options
> +    -D <dir>		Directory to run in
> +    -n			Output test list, do not run tests
> +    -r			randomize test order
> +    --exact-order	run tests in the exact order specified
> +    -s section		run only specified section from config file
> +
> +testlist options
> +    -g group[,group...]	include tests from these groups
> +    -x group[,group...]	exclude tests from these groups
> +    -X exclude_file	exclude individual tests
> +    -e testlist         exclude a specific list of tests
> +    -E external_file	exclude individual tests
> +    [testlist]		include tests matching names in testlist
> +
> +testlist argument is a list of tests in the form of <test dir>/<test name>.
> +
> +<test dir> is a directory under tests that contains a group file,
> +with a list of the names of the tests in that directory.
> +
> +<test name> may be either a specific test file name (e.g. xfs/001) or
> +a test file name match pattern (e.g. xfs/*).
> +
> +group argument is either a name of a tests group to collect from all
> +the test dirs (e.g. quick) or a name of a tests group to collect from
> +a specific tests dir in the form of <test dir>/<group name> (e.g. xfs/quick).
> +If you want to run all the tests in the test suite, use "-g all" to specify all
> +groups.
> +
> +exclude_file argument refers to a name of a file inside each test directory.
> +for every test dir where this file is found, the listed test names are
> +excluded from the list of tests to run from that test dir.
> +
> +external_file argument is a path to a single file containing a list of tests
> +to exclude in the form of <test dir>/<test name>.
> +
> +examples:
> + check-parallel -D /mnt xfs/001
> + check-parallel -D /mnt -g quick
> + check-parallel -D /mnt -g xfs/quick
> + check-parallel -D /mnt -x stress xfs/*
> + check-parallel -D /mnt -X .exclude -g auto
> + check-parallel -D /mnt -E ~/.xfstests.exclude
> +'
> +	    exit 1
_fatal ?
> +}
> +
> +# Process command arguments first.
> +while [ $# -gt 0 ]; do
> +	case "$1" in
> +	-\? | -h | --help) usage ;;
> +
> +	-D)	basedir=$2; shift ;;
> +	-g)	_tl_setup_group $2 ; shift ;;
> +	-e)	_tl_setup_exclude_tests $2 ; shift ;;
> +	-E)	_tl_setup_exclude_file $2 ; shift ;;
> +	-x)	_tl_setup_exclude_group $2; shift ;;
> +	-X)	_tl_setup_exclude_subdir $2; shift ;;
> +	-r)	_tl_setup_randomise ;;
> +	--exact-order) _tl_setup_ordered ;;
> +	-n)	show_test_list="yes" ;;
> +
> +	-s)	run_section="$run_section -s $2"; shift ;;
> +
> +	-*)	usage ;;
> +	*)	# not an argument, we've got tests now.
> +		_tl_setup_cli $*
> +	esac
> +
> +	# if we've found a test specification, the break out of the processing
> +	# loop before we shift the arguments so that this is the first argument
> +	# that we process in the test arg loop below.
> +	if $_tl_have_test_args; then
> +		break;
> +	fi
> +
> +	shift
> +done
> +
> +if [ ! -d "$basedir" ]; then
> +	echo "Invalid basedir specification"
> +	usage
> +fi
> +if [ -d "$basedir/runner-0/" ]; then
> +	prev_results=`ls -tr $basedir/runner-0/ | grep results | tail -1`
> +fi
> +
> +_tl_prepare_test_list
> +_tl_strip_test_list
>  
>  # grab all previously run tests and order them from highest runtime to lowest
>  # We are going to try to run the longer tests first, hopefully so we can avoid
> @@ -30,25 +126,23 @@ test_list+=$(awk '/^[0-9].*auto/ { print "xfs/" $1 }' tests/xfs/group.list)
>  #
>  # If we have tests in the test list that don't have runtimes recorded, then
>  # append them to be run last.
> -
> -build_runner_list()
> +time_order_test_list()
>  {
>  	local runtimes
>  	local run_list=()
> -	local prev_results=`ls -tr $basedir/runner-0/ | grep results | tail -1`
>  
>  	runtimes=$(cat $basedir/*/$prev_results/check.time | sort -k 2 -nr | cut -d " " -f 1)
>  
>  	# Iterate the timed list first. For every timed list entry that
>  	# is found in the test_list, add it to the local runner list.
>  	local -a _list=( $runtimes )
> -	local -a _tlist=( $test_list )
> +	local -a _tlist=( $_tl_tests )
>  	local rx=0
>  	local ix
>  	local jx
>  	#set -x
>  	for ((ix = 0; ix < ${#_list[*]}; ix++)); do
> -		echo $test_list | grep -q ${_list[$ix]}
> +		echo $_tl_tests | grep -q ${_list[$ix]}
>  		if [ $? == 0 ]; then
>  			# add the test to the new run list and remove
>  			# it from the remaining test list.
> @@ -60,24 +154,27 @@ build_runner_list()
>  
>  	# The final test list is all the time ordered tests followed by
>  	# all the tests we didn't find time records for.
> -	test_list="${run_list[*]} ${_tlist[*]}"
> +	_tl_tests="${run_list[*]} ${_tlist[*]}"
>  }
>  
> -if [ -f $basedir/runner-0/results/check.time ]; then
> -	build_runner_list
> +if ! $_tl_randomise -a ! $_tl_exact_order; then
> +	if [ -f $basedir/runner-0/$prev_results/check.time ]; then
> +		time_order_test_list
> +	fi
>  fi
>  
>  # split the list amongst N runners
> -
>  split_runner_list()
>  {
>  	local ix
>  	local rx
> -	local -a _list=( $test_list )
> +	local -a _list=( $_tl_tests )
>  	for ((ix = 0; ix < ${#_list[*]}; ix++)); do
>  		seq="${_list[$ix]}"
>  		rx=$((ix % $runners))
> -		runner_list[$rx]+="${_list[$ix]} "
> +		if ! _tl_expunge_test $seq; then
> +			runner_list[$rx]+="${_list[$ix]} "
> +		fi
>  		#echo $seq
>  	done
>  }
> @@ -137,7 +234,7 @@ runner_go()
>  
>  	# Run the tests in it's own mount namespace, as per the comment below
>  	# that precedes making the basedir a private mount.
> -	./src/nsexec -m ./check $check_args -x unreliable_in_parallel --exact-order ${runner_list[$id]} > $me/log 2>&1
> +	./src/nsexec -m ./check $run_section -x unreliable_in_parallel --exact-order ${runner_list[$id]} > $me/log 2>&1
>  
>  	wait
>  	sleep 1
> @@ -165,6 +262,13 @@ cleanup()
>  
>  trap "cleanup; exit" HUP INT QUIT TERM
>  
> +split_runner_list
> +if [ -n "$show_test_list" ]; then
> +	echo Time ordered test list:
> +	echo $_tl_tests
> +	echo
> +fi
> +
>  
>  # Each parallel test runner needs to only see it's own mount points. If we
>  # leave the basedir as shared, then all tests see all mounts and then we get
> @@ -178,15 +282,23 @@ trap "cleanup; exit" HUP INT QUIT TERM
>  # in it's own mount namespace so that they cannot see mounts that other tests
>  # are performing.
>  mount --make-private $basedir
> -split_runner_list
> +
>  now=`date +%Y-%m-%d-%H:%M:%S`
>  for ((i = 0; i < $runners; i++)); do
>  
> -	runner_go $i $now &
> +	if [ -n "$show_test_list" ]; then
> +		echo "Runner $i: ${runner_list[$i]}"
> +	else
> +		runner_go $i $now &
> +	fi
>  
>  done;
>  wait
>  
> +if [ -n "$show_test_list" ]; then
> +	exit 0
> +fi
> +
>  echo -n "Tests run: "
>  grep Ran $basedir/*/log | sed -e 's,^.*:,,' -e 's, ,\n,g' | sort | uniq | wc -l
>  
> @@ -198,7 +310,7 @@ grep Failures: $basedir/*/log | uniq | sed -e "s/^.*Failures://" -e "s,\([0-9]\)
>  echo
>  
>  echo Ten slowest tests - runtime in seconds:
> -cat $basedir/*/results/check.time | sort -k 2 -nr | head -10
> +cat $basedir/*/results-$now/check.time | sort -k 2 -nr | head -10
Maybe have this default to top 10 list but make it parameterized, just
like we do it for DIFF_LENGTH (# number of diff lines from a failed
test, 0 for whole output)? Do you think that would be useful?
>  
>  echo
>  echo Cleanup on Aisle 5?
> diff --git a/common/test_list b/common/test_list
> index 2432be6f7..2b3ae9fbf 100644
> --- a/common/test_list
> +++ b/common/test_list
> @@ -24,6 +24,7 @@ _tl_file="$tmp.test_list"
>  _tl_exclude_tests=()
>  _tl_tests=
>  
> +# strip 'tests\' prefix from the provided test name
>  _tl_strip_src_dir()
>  {
>  	local test="$1"
> @@ -31,6 +32,12 @@ _tl_strip_src_dir()
>  	echo ${test#$_tl_src_dir/}
>  }
>  
> +# strip 'tests\' prefix from all the tests in the test list
> +_tl_strip_test_list()
> +{
> +	_tl_tests=$(echo $_tl_tests | sed -e "s/$_tl_src_dir\///g")
> +}
> +
>  get_sub_group_list()
>  {
>  	local d=$1


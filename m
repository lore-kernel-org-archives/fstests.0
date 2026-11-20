Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795216775;
	b=KKobX8+CNiCLtnjoDCjtVqVz/tXOST+r34pFqxG+TYtqyf/5GTVUfGajF/IWZHEzRliT
	 xuGBevOSL9go7o7jjx5PaHcw7UU1MsqCXdnhNDUOP29c4rQoyM8ii6psKmnrkZpd26JXA
	 0TFZjrYK9410EP3nmNhObN+YKWckn19onKM3qP+phybRtcH3wDE4a5F+OmotQlnce/7H/
	 mVBb2hVxpN3EZsTVGzdp8TtSHWNft1o3WKqER5zKpd+cpRrX0XnWX8fCC1XxDOqvuLq27
	 JbhRCMUK+bIE/4dRbFlF+1LxOrGnOVhooj8dur7zmwRYXRSu5ra1BVQBByDnyG5v7Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795216775;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=D5jL0heMBuhUD6pjDjr9GLV3tSIn1Qkr/Jb1CEPd8wQ=;
	b=NYW1G99w4ajJ8J6xFBGniuEM7wQYWqlx6i5qSXqp1cqHSMtWPYGltg7IwbQiaBDTHMtH
	 kXPzU5AXCvnkcvPdviRa8Cj1/XoxUDbS2GO4zWgFLcxMO5PzpfdwOelPRdnrQPA47S9T+
	 9Hh7npEbTnYbQ6Nc/tJCF63hd80L2KnKJnGoRuLIY4B3lO9+IAp3/3uSUj+3/w/hlQD0n
	 qpNp0goHEkGit46SbjMXpG1jaxA/1qfUNvXrQ6WX0joBCpHS7eqjr1+jlZ8MNd4LgAV79
	 rCCXBzDXIuLWkOT04UFe4LzON84Q5PlgLsCGSgbltI1rgEtZjkfs1ZJd0uv6WkCh1Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mYNghEo5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A14606A695
	for <fstests@vger.kernel.org>; Fri, 20 Nov 2026 23:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mYNghEo5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D13E1F000C6;
	Fri, 20 Nov 2026 23:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795216774;
	bh=D5jL0heMBuhUD6pjDjr9GLV3tSIn1Qkr/Jb1CEPd8wQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mYNghEo5qO7hqAkzsQpStPaRhgDe4s1d5vjd+L0pCLvXrDQj/W7oqJ5Zaxzj8Pi3r
	 kKTltn18DWLfVAzqebs70SWk8mEOw19Z8ZHsWTa/OtUg9D33IoQfM/mPhCwNsQ09Bm
	 itnLRwWDJ7i3QKjpoWNpnEAyk6YogGXTAlL8hvRBsqWTY8SegBPz9/gwZyGqb2AW2A
	 dpomgRnyTYW5vpwnUXMMd8WcYFvMu0IUzNXC5BmD05MOpWSHNLUT47osVyRibT0ATR
	 trbSIB07tXmoHImGjuzFuYBa6tT5ru4UroId4nwtpMeQrkn3n88slI8yUaSWXdr7ul
	 0Lzvz+G6ne4Ew==
Date: Sat, 21 Nov 2026 07:19:26 +0800
From: Zorro Lang <zlang@kernel.org>
To: cem@kernel.org
Cc: fstests@vger.kernel.org, jencce2002@qq.com
Subject: Re: [PATCH v2] add tmt as a new output format
Message-ID: <awDMOOZxtQW8A4_v@zlang-mailbox>
Mail-Followup-To: cem@kernel.org, fstests@vger.kernel.org, 
	jencce2002@qq.com
References: <20261119123910.294544-1-cem@kernel.org>
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261119123910.294544-1-cem@kernel.org>

On Thu, Nov 19, 2026 at 01:38:55PM +0100, cem@kernel.org wrote:
> From: Carlos Maiolino <cmaiolino@redhat.com>
> 
> I've been trying to expand my testing matrix leveraging the testing-farm
> cloud (https://testing-farm.io/), which is a public testing cloud available
> for opensource testing.
> 
> Testing-farm uses tmt (https://github.com/teemtee) to orchestrate the
> tests within the provisioned VMs.
> tmt however expects each individual test to be, well, an individual
> test so by default it would put a whole xfstests run as a single test
> case with a looooong report.
> However we can use a tmt-report-result tool to report each test ran
> individually as a sub-test, so the report looks a bit more granular,
> easy to read and prevent my eyes from bleeding while looking at its
> testing reports.
> 
> I know tmt can also be used to orchestrate tests on a local machine.
> Although I have no use for that, it might be useful for someone else,
> reason why at the end of the run it will also print out the tmt report
> file location. This also makes the output consistent to what xunit
> format does.
> 
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> ---
> V2:
> 	- Add Murphy's suggestion to the log output if it fails
> 	  to add a test result to the final report

Hi Carlos,

Sorry for the late reply. I wanted to wait and see what others thought about
this first, though it seems there hasn't been much interest or feedback on
it so far :-D

Personally, I have some reservations about merging tmt reporting directly into
fstests. As you know, I worked at Red Hat for over a decade, from the early
days of rhts-report-result to the newer tmt-report-result, we have always
used external wrappers around xfstests to handle result reporting, rather
than pushing these framework-specific hooks into upstream fstests and turning
it into a vendor or harness-tailored tool.

While tmt is indeed an open-source project, there is a fundamental difference
between tmt and xunit (which fstests currently supports). xUnit is a
cross-language, cross-CI de facto industry standard, and fstests generates it
completely standalone using pure shell/text processing without relying on any
external binaries or runtime environment variables.

In contrast, tmt is a test execution framework primarily driven by the Fedora/
Red Hat ecosystem (and Testing Farm). Rather than generating a generic,
standalone structured report file, this patch directly invokes an external CLI
(tmt-report-result) at runtime and tightly couples with internal tmt environment
variables.

If we set this precedent, I worry it will open the door for other test harnesses
or internal CI frameworks, such as LAVA, kdevops, Beaker, etc. to ask for
their own -R ktest or -R beaker reporting CLIs. Over time, common/report would
turn into a glue layer for various CI adapters rather than remaining a pure,
self-contained report generator.

Of course, I completely understand your concern about a mid-run crash leaving no
report behind. In fact, that is the exact reason why our early wrappers used
·./check -n ` to fetch the test list and then invoked ./check one test at a time
while that adds a tiny bit of overhead, the overhead is negligible and it
gives the external wrapper a lot of flexibility to invoke Beaker or tmt
reporting immediately after each individual test finishes.

Later on, we also explored ways to optimize this. One approach was running a
background monitor in the wrapper to watch ./check's output stream (or check.log)
in real time and trigger result reporting per test as they complete.

More recently before I was laid off from Red Hat, I had been considering adding
a generic hook mechanism to fstests instead, if a user sets an environment
variable (e.g., REPORT_TESTCASE_HOOK="/path/to/my-script.sh"), fstests would
invoke that script at the end of each testcase with arguments like (sect_name,
test_seq, test_status, test_time, report_dir). That way, any CI system or test
harness could simply provide its own lightweight hook.sh to reuse this reporting
interface, without having to hardcode vendor or framework-specific tools into
common/report. Also I thought about adding a streaming format like JSON Lines,
where each completed test appends a self-contained, valid JSON record on the fly,
ensuring that whatever has been flushed to disk remains intact and parseable even
if the system crashes midway through a run.

Of course, I never had the time to polish those ideas and send them upstream
for discussion, so if Red Hat still needs something like this, feel free to
take them into consideration. And if anyone else has even better ideas, I'd
definitely welcome a broader discussion on how fstests can better support
various CI reporting needs in a clean, generic way :)

Thanks,
Zorro

> 
>  check         |   2 +-
>  common/report | 129 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 129 insertions(+), 2 deletions(-)
> 
> diff --git a/check b/check
> index afe855bcf0ed..420ac7d274df 100755
> --- a/check
> +++ b/check
> @@ -74,7 +74,7 @@ General options:
>      -S section              exclude the specified section from the config file
>      -T                      output timestamps
>      -R fmt[,fmt]            generate report in formats specified. Supported
> -                              formats: xunit, xunit-quiet
> +                              formats: xunit, xunit-quiet, tmt
>      --exact-order           run tests in the exact order specified
>      --extra-space <size>    require minimum free space on scratch device
>      --fs <type>             test the given FSTYP; valid types include:
> diff --git a/common/report b/common/report
> index 2fa15e62f1e7..0a4a39285ef4 100644
> --- a/common/report
> +++ b/common/report
> @@ -14,6 +14,8 @@ REPORT_ENV_LIST_OPT=("TAPE_DEV" "RMT_TAPE_DEV" "FSSTRESS_AVOID" "FSX_AVOID"
>  		     "KCONFIG_PATH" "PERF_CONFIGNAME" "MIN_FSSIZE"
>  		     "IDMAPPED_MOUNTS")
>  
> +TMT_REPORT_RESULT_PROG="${TMT_REPORT_RESULT_PROG:-tmt-report-result}"
> +
>  encode_xml()
>  {
>  	cat -v | \
> @@ -244,7 +246,122 @@ _xunit_make_testcase_report()
>  }
>  
>  
> -#
> +
> +_tmt_assert_env()
> +{
> +	if [ -z "$TMT_TEST_PIDFILE" ]; then
> +		_fatal "report format 'tmt' can only be used when xfstests is run as a tmt test"
> +	fi
> +	if ! command -v "$TMT_REPORT_RESULT_PROG" >/dev/null 2>&1; then
> +		_fatal "report format 'tmt' requires $TMT_REPORT_RESULT_PROG to be installed"
> +	fi
> +}
> +
> +# tmt subresult names have to be unique within a tmt test, so prefix each test
> +# name with its specific section.
> +_tmt_testcase_name()
> +{
> +	local sect_name="$1"
> +	local test_name="$2"
> +
> +	if [ $sect_name == '-no-sections-' ]; then
> +		echo "/$test_name"
> +	else
> +		echo "/$sect_name/$test_name"
> +	fi
> +}
> +
> +__tmt_log_append()
> +{
> +	local log="$1"
> +	local title="$2"
> +	local file="$3"
> +
> +	test -s "$file" || return 0
> +	echo "--- $title ---" >> "$log"
> +	cat "$file" | tr -dc '[:print:][:space:]' >> "$log"
> +	echo >> "$log"
> +}
> +
> +# tmt-report-result can attach a single log to a subresult and display that
> +# on its web interface. Gather whatever logs a specific test left behind
> +# so we can see it on the web interface instead of digging into the resulting
> +# artifacts. Do that only for failed / notrun tests as we don't need it if a test
> +# passed properly.
> +_tmt_make_testcase_log()
> +{
> +	local test_name="$1"
> +	local test_status="$2"
> +	local log="${REPORT_DIR}/${test_name}.tmt.log"
> +
> +	# $REPORT_DIR/<group> is created by check before the test is run
> +	rm -f "$log"
> +
> +	case $test_status in
> +	"notrun")
> +		__tmt_log_append "$log" "not run" "${REPORT_DIR}/${test_name}.notrun"
> +		;;
> +	"fail")
> +		local out_src="${SRC_DIR}/${test_name}.out"
> +		local outbad_file="${REPORT_DIR}/${test_name}.out.bad"
> +
> +		if [ -n "$_err_msg" ]; then
> +			echo "$_err_msg" >> "$log"
> +		fi
> +		if [ -s "$outbad_file" ]; then
> +			echo "--- output mismatch ---" >> "$log"
> +			$diff "$out_src" "$outbad_file" >> "$log"
> +		fi
> +		__tmt_log_append "$log" "hints" "${REPORT_DIR}/${test_name}.hints"
> +		__tmt_log_append "$log" "dmesg" "${REPORT_DIR}/${test_name}.dmesg"
> +		__tmt_log_append "$log" "mount failures" "${REPORT_DIR}/${test_name}.mountfail"
> +		__tmt_log_append "$log" "full output" "${REPORT_DIR}/${test_name}.full"
> +		;;
> +	esac
> +
> +	test -s "$log" && echo "$log"
> +	return 0
> +}
> +
> +_tmt_make_testcase_report()
> +{
> +	local sect_name="$1"
> +	local test_name="$2"
> +	local test_status="$3"
> +	local outcome
> +	local log
> +
> +	case $test_status in
> +	"pass")
> +		outcome="pass"
> +		;;
> +	"fail")
> +		outcome="fail"
> +		;;
> +	"notrun"|"list")
> +		outcome="skip"
> +		;;
> +	*)
> +		outcome="error"
> +		;;
> +	esac
> +
> +	log=`_tmt_make_testcase_log "$test_name" "$test_status"`
> +
> +	# tmt-report-result is chatty on stdout, which would interleave with
> +	# the test results printed by check.
> +	"$TMT_REPORT_RESULT_PROG" \
> +		"`_tmt_testcase_name "$sect_name" "$test_name"`" \
> +		"$outcome" ${log:+-o "$log"} >/dev/null ||
> +		echo "check: failed to report `_tmt_testcase_name "$sect_name" "$test_name"` to tmt"
> +}
> +
> +# Only useful if using tmt locally, but keeps consistent with xunit implementation
> +_tmt_make_section_report()
> +{
> +	echo "tmt report: $TMT_TEST_DATA/tmt-report-results.yaml"
> +}
> +
>  #  Common report generator entry points
>  _make_section_report()
>  {
> @@ -260,6 +377,9 @@ _make_section_report()
>  						   "$bad_count" "$notrun_count" \
>  						   "$sect_time"
>  			;;
> +		"tmt")
> +			_tmt_make_section_report
> +			;;
>  		*)
>  			_dump_err "format '$report' is not supported"
>  			;;
> @@ -279,6 +399,10 @@ _make_testcase_report()
>  			_xunit_make_testcase_report "$sect_name" "$test_seq" \
>  						    "$test_status" "$test_time" "$report"
>  			;;
> +		"tmt")
> +			_tmt_make_testcase_report "$sect_name" "$test_seq" \
> +						  "$test_status"
> +			;;
>  		*)
>  			_dump_err "report format '$report' is not supported"
>  			;;
> @@ -291,6 +415,9 @@ _assert_report_list() {
>  		case "$report" in
>  		"xunit"|"xunit-quiet")
>  			;;
> +		"tmt")
> +			_tmt_assert_env
> +			;;
>  		*)
>  			_fatal "report format '$report' is not supported"
>  			;;
> -- 
> 2.56.0
> 

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795255073;
	b=pvXcjhvwzLVVVOfDRphnPzJ/qquo3LlCGZCSEHdnDX/EUdi2MmYRCBneGwmgLQDRAbK7
	 vrafZ1em4FSNRNnAKpgYMVT2kjemk7c/G166npuSV2UGjsJRjZ8FNs6RY+F0vBNybSiYq
	 7/fiXfJR6CwZlZbeyrmeiVEIhH3GD5fk+6mHUnXMW5sFXPPVvHTGCwmnwBSpz53GM4Mu1
	 fYTq5Qo1+spTjDQmxyYlGzZ8nGyi0NcYIQ/C8FM91H2f333cfPW0nxW/TDxT2YviyeCxC
	 f4hDTmlcbExGRPh3gMurmzq37TzJjzDRh8knp0mWkXI8oe/EFouEE5GxyOZ1bYLSkXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795255073;
	h=Received:DKIM-Signature:Date:From:To:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=nP+95AZy2QwG9yJ69GTsC+Zri6bx0F9n+SqdtpLKSs4=;
	b=w92GD6+bbpRaYaw91f6TIk0/abLpZpihOXa94p/sGSUbcFIxbg4FNqiWyq8YhUmxFRez
	 k4RvqDRroDECcwxFgppcvW5loxRxak7Yjk7IgSu9tKNMVC+lDDJIsyaltJPhv0jsNfFp0
	 l6rWa8AHsL8RaJEeo0T7WJ0/A38TH3TA1117G6FHaMlfFj9FJ61qMD5yy+YB764Ma/O84
	 cWZSoj8UXSfr1sn2023K6MsyHp29AGhUssoXN+Xjn4b+iR+vX6DSwcC0hYhjURfculM4W
	 XIhNUr3n3Ui/lTexXYCbrTajI2hsZV/26Jl2tIDKlvmGaRLbMcwR6mvYlw+PU841WZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ozKq5VCe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5002A606A320
	for <fstests@vger.kernel.org>; Sat, 21 Nov 2026 09:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ozKq5VCe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427731F000C6;
	Sat, 21 Nov 2026 09:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795255073;
	bh=nP+95AZy2QwG9yJ69GTsC+Zri6bx0F9n+SqdtpLKSs4=;
	h=Date:From:To:Subject:References:In-Reply-To;
	b=ozKq5VCeqYqVH5kuPIe4JgZp9b4LY9+FQJP6oEvoSdzXS9s/yfD6ErDLD/QCzMOaf
	 sKwYlMfpRgM+s+649IWqXWR25sK/Bb4v02oAIjbyrUQ+J/XWsG2SJKxJfE8eNJk5uM
	 /NhgVjDGj1XeX69Jb7luCL/XCO3kXxgUTuXwozt3+km7F83VT3+PWLIUFjWKM85C8w
	 8uvLfe+HOVC1lNuqWp4ZAFXJKksSq1GMrxTkQDTETuiQwX7rC2/qFZnxLxCqmN6cB4
	 HiXM3ekxWdPccJ/oklfMGQurjmlLhUwQ6PTj42d3Wfn/S8EnHDWv3ALWejc49kHTHF
	 wdWoM8+1KHzOw==
Date: Sat, 21 Nov 2026 10:57:48 +0100
From: Carlos Maiolino <cem@kernel.org>
To: fstests@vger.kernel.org, jencce2002@qq.com
Subject: Re: [PATCH v2] add tmt as a new output format
Message-ID: <awFgw_iIynbW7IYa@cronus.toxiclabs.cc>
References: <20261119123910.294544-1-cem@kernel.org>
 <awDMOOZxtQW8A4_v@zlang-mailbox>
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
In-Reply-To: <awDMOOZxtQW8A4_v@zlang-mailbox>

On Sat, Nov 21, 2026 at 07:19:26AM +0800, Zorro Lang wrote:
> On Thu, Nov 19, 2026 at 01:38:55PM +0100, cem@kernel.org wrote:
> > From: Carlos Maiolino <cmaiolino@redhat.com>
> > 
> > I've been trying to expand my testing matrix leveraging the testing-farm
> > cloud (https://testing-farm.io/), which is a public testing cloud available
> > for opensource testing.
> > 
> > Testing-farm uses tmt (https://github.com/teemtee) to orchestrate the
> > tests within the provisioned VMs.
> > tmt however expects each individual test to be, well, an individual
> > test so by default it would put a whole xfstests run as a single test
> > case with a looooong report.
> > However we can use a tmt-report-result tool to report each test ran
> > individually as a sub-test, so the report looks a bit more granular,
> > easy to read and prevent my eyes from bleeding while looking at its
> > testing reports.
> > 
> > I know tmt can also be used to orchestrate tests on a local machine.
> > Although I have no use for that, it might be useful for someone else,
> > reason why at the end of the run it will also print out the tmt report
> > file location. This also makes the output consistent to what xunit
> > format does.
> > 
> > Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> > ---
> > V2:
> > 	- Add Murphy's suggestion to the log output if it fails
> > 	  to add a test result to the final report
> 
> Hi Carlos,
> 
> Sorry for the late reply. I wanted to wait and see what others thought about
> this first, though it seems there hasn't been much interest or feedback on
> it so far :-D
> 
> Personally, I have some reservations about merging tmt reporting directly into
> fstests. As you know, I worked at Red Hat for over a decade, from the early
> days of rhts-report-result to the newer tmt-report-result, we have always
> used external wrappers around xfstests to handle result reporting, rather
> than pushing these framework-specific hooks into upstream fstests and turning
> it into a vendor or harness-tailored tool.

Just because we never added support to specific frameworks, doesn't mean
we can't add them right?

> 
> While tmt is indeed an open-source project, there is a fundamental difference
> between tmt and xunit (which fstests currently supports). xUnit is a
> cross-language, cross-CI de facto industry standard, and fstests generates it
> completely standalone using pure shell/text processing without relying on any
> external binaries or runtime environment variables.

I don't think this is a case against it. Relying on external binaries is
not a big deal, we do that everywhere in xfstests. As long as it doesn't
break xfstests running stand-alone or in different

> 
> In contrast, tmt is a test execution framework primarily driven by the Fedora/
> Red Hat ecosystem (and Testing Farm). Rather than generating a generic,
> standalone structured report file, this patch directly invokes an external CLI
> (tmt-report-result) at runtime and tightly couples with internal tmt environment
> variables.

Yes, primary driven by Fedora/Red Hat, but publicly accessible, available to anyone
wanting to use it to run xfstests. It also only invokes an external cli when running
into a tmt environment.

> If we set this precedent, I worry it will open the door for other test harnesses
> or internal CI frameworks, such as LAVA, kdevops, Beaker, etc. to ask for
> their own -R ktest or -R beaker reporting CLIs. Over time, common/report would
> turn into a glue layer for various CI adapters rather than remaining a pure,
> self-contained report generator.

I think these are different cases. While tmt can be used stand-alone to drive
tests in a local machine, the patch's goal is to make xfstests easier to run on
testing-farm without needing to add a bloat of scripts wrapping it around.

The difference here is testing-farm is a public environment with available VMs
that anyone can take advantage from to run testing over it. None of the other
frameworks you mentioned AFAIK offer public cloud infrastructure for opensource
testing.

And to be honest I have nothing against adding support for other frameworks as
long as it offers any advantage for the opensource project and do not break
current functionality.

> Of course, I completely understand your concern about a mid-run crash leaving no
> report behind. In fact, that is the exact reason why our early wrappers used
> ·./check -n ` to fetch the test list and then invoked ./check one test at a time
> while that adds a tiny bit of overhead, the overhead is negligible and it
> gives the external wrapper a lot of flexibility to invoke Beaker or tmt
> reporting immediately after each individual test finishes.

It's not the point. What you are mention just adds a lot of unnecessary
maintenance overhead to my already overloaded todo list just to be able to use
testing-farm for testing upstream xfs.

> Later on, we also explored ways to optimize this. One approach was running a
> background monitor in the wrapper to watch ./check's output stream (or check.log)
> in real time and trigger result reporting per test as they complete.
> 
> More recently before I was laid off from Red Hat, I had been considering adding
> a generic hook mechanism to fstests instead, if a user sets an environment
> variable (e.g., REPORT_TESTCASE_HOOK="/path/to/my-script.sh"), fstests would
> invoke that script at the end of each testcase with arguments like (sect_name,
> test_seq, test_status, test_time, report_dir). That way, any CI system or test
> harness could simply provide its own lightweight hook.sh to reuse this reporting
> interface, without having to hardcode vendor or framework-specific tools into
> common/report. Also I thought about adding a streaming format like JSON Lines,
> where each completed test appends a self-contained, valid JSON record on the fly,
> ensuring that whatever has been flushed to disk remains intact and parseable even
> if the system crashes midway through a run.

I think the things you are describing are valid but from a QA point of view.  But
all of these suggestions adds to me a lot of more work than simply enabling
xfstests to communicate results back to tmt. Work that I simply have no time for.


> Of course, I never had the time to polish those ideas and send them upstream
> for discussion, so if Red Hat still needs something like this, feel free to
> take them into consideration. And if anyone else has even better ideas, I'd
> definitely welcome a broader discussion on how fstests can better support
> various CI reporting needs in a clean, generic way :)

Zorro, nothing about this patch has anything to do with Red Hat. I'm instead
leveraging public available infrastructure to scale upstream xfs QA.
After Darrick shut his QA farm down, I needed to scale my testing to the same
level. And that'snexactly what I'm using this patch for. I don't have time nor
interest in maintaining a huge and complex wrapper around xfstests to do the same
thing testing-farm can do and to a scale I have no hardware for.
Instead of maintaining a whole lot of code in a wrapper, I opted to leverage
testing-farm features to drive everything I need to setup the VMs to run xfstests
in there.

Cheers.

> 
> Thanks,
> Zorro
> 
> > 
> >  check         |   2 +-
> >  common/report | 129 +++++++++++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 129 insertions(+), 2 deletions(-)
> > 
> > diff --git a/check b/check
> > index afe855bcf0ed..420ac7d274df 100755
> > --- a/check
> > +++ b/check
> > @@ -74,7 +74,7 @@ General options:
> >      -S section              exclude the specified section from the config file
> >      -T                      output timestamps
> >      -R fmt[,fmt]            generate report in formats specified. Supported
> > -                              formats: xunit, xunit-quiet
> > +                              formats: xunit, xunit-quiet, tmt
> >      --exact-order           run tests in the exact order specified
> >      --extra-space <size>    require minimum free space on scratch device
> >      --fs <type>             test the given FSTYP; valid types include:
> > diff --git a/common/report b/common/report
> > index 2fa15e62f1e7..0a4a39285ef4 100644
> > --- a/common/report
> > +++ b/common/report
> > @@ -14,6 +14,8 @@ REPORT_ENV_LIST_OPT=("TAPE_DEV" "RMT_TAPE_DEV" "FSSTRESS_AVOID" "FSX_AVOID"
> >  		     "KCONFIG_PATH" "PERF_CONFIGNAME" "MIN_FSSIZE"
> >  		     "IDMAPPED_MOUNTS")
> >  
> > +TMT_REPORT_RESULT_PROG="${TMT_REPORT_RESULT_PROG:-tmt-report-result}"
> > +
> >  encode_xml()
> >  {
> >  	cat -v | \
> > @@ -244,7 +246,122 @@ _xunit_make_testcase_report()
> >  }
> >  
> >  
> > -#
> > +
> > +_tmt_assert_env()
> > +{
> > +	if [ -z "$TMT_TEST_PIDFILE" ]; then
> > +		_fatal "report format 'tmt' can only be used when xfstests is run as a tmt test"
> > +	fi
> > +	if ! command -v "$TMT_REPORT_RESULT_PROG" >/dev/null 2>&1; then
> > +		_fatal "report format 'tmt' requires $TMT_REPORT_RESULT_PROG to be installed"
> > +	fi
> > +}
> > +
> > +# tmt subresult names have to be unique within a tmt test, so prefix each test
> > +# name with its specific section.
> > +_tmt_testcase_name()
> > +{
> > +	local sect_name="$1"
> > +	local test_name="$2"
> > +
> > +	if [ $sect_name == '-no-sections-' ]; then
> > +		echo "/$test_name"
> > +	else
> > +		echo "/$sect_name/$test_name"
> > +	fi
> > +}
> > +
> > +__tmt_log_append()
> > +{
> > +	local log="$1"
> > +	local title="$2"
> > +	local file="$3"
> > +
> > +	test -s "$file" || return 0
> > +	echo "--- $title ---" >> "$log"
> > +	cat "$file" | tr -dc '[:print:][:space:]' >> "$log"
> > +	echo >> "$log"
> > +}
> > +
> > +# tmt-report-result can attach a single log to a subresult and display that
> > +# on its web interface. Gather whatever logs a specific test left behind
> > +# so we can see it on the web interface instead of digging into the resulting
> > +# artifacts. Do that only for failed / notrun tests as we don't need it if a test
> > +# passed properly.
> > +_tmt_make_testcase_log()
> > +{
> > +	local test_name="$1"
> > +	local test_status="$2"
> > +	local log="${REPORT_DIR}/${test_name}.tmt.log"
> > +
> > +	# $REPORT_DIR/<group> is created by check before the test is run
> > +	rm -f "$log"
> > +
> > +	case $test_status in
> > +	"notrun")
> > +		__tmt_log_append "$log" "not run" "${REPORT_DIR}/${test_name}.notrun"
> > +		;;
> > +	"fail")
> > +		local out_src="${SRC_DIR}/${test_name}.out"
> > +		local outbad_file="${REPORT_DIR}/${test_name}.out.bad"
> > +
> > +		if [ -n "$_err_msg" ]; then
> > +			echo "$_err_msg" >> "$log"
> > +		fi
> > +		if [ -s "$outbad_file" ]; then
> > +			echo "--- output mismatch ---" >> "$log"
> > +			$diff "$out_src" "$outbad_file" >> "$log"
> > +		fi
> > +		__tmt_log_append "$log" "hints" "${REPORT_DIR}/${test_name}.hints"
> > +		__tmt_log_append "$log" "dmesg" "${REPORT_DIR}/${test_name}.dmesg"
> > +		__tmt_log_append "$log" "mount failures" "${REPORT_DIR}/${test_name}.mountfail"
> > +		__tmt_log_append "$log" "full output" "${REPORT_DIR}/${test_name}.full"
> > +		;;
> > +	esac
> > +
> > +	test -s "$log" && echo "$log"
> > +	return 0
> > +}
> > +
> > +_tmt_make_testcase_report()
> > +{
> > +	local sect_name="$1"
> > +	local test_name="$2"
> > +	local test_status="$3"
> > +	local outcome
> > +	local log
> > +
> > +	case $test_status in
> > +	"pass")
> > +		outcome="pass"
> > +		;;
> > +	"fail")
> > +		outcome="fail"
> > +		;;
> > +	"notrun"|"list")
> > +		outcome="skip"
> > +		;;
> > +	*)
> > +		outcome="error"
> > +		;;
> > +	esac
> > +
> > +	log=`_tmt_make_testcase_log "$test_name" "$test_status"`
> > +
> > +	# tmt-report-result is chatty on stdout, which would interleave with
> > +	# the test results printed by check.
> > +	"$TMT_REPORT_RESULT_PROG" \
> > +		"`_tmt_testcase_name "$sect_name" "$test_name"`" \
> > +		"$outcome" ${log:+-o "$log"} >/dev/null ||
> > +		echo "check: failed to report `_tmt_testcase_name "$sect_name" "$test_name"` to tmt"
> > +}
> > +
> > +# Only useful if using tmt locally, but keeps consistent with xunit implementation
> > +_tmt_make_section_report()
> > +{
> > +	echo "tmt report: $TMT_TEST_DATA/tmt-report-results.yaml"
> > +}
> > +
> >  #  Common report generator entry points
> >  _make_section_report()
> >  {
> > @@ -260,6 +377,9 @@ _make_section_report()
> >  						   "$bad_count" "$notrun_count" \
> >  						   "$sect_time"
> >  			;;
> > +		"tmt")
> > +			_tmt_make_section_report
> > +			;;
> >  		*)
> >  			_dump_err "format '$report' is not supported"
> >  			;;
> > @@ -279,6 +399,10 @@ _make_testcase_report()
> >  			_xunit_make_testcase_report "$sect_name" "$test_seq" \
> >  						    "$test_status" "$test_time" "$report"
> >  			;;
> > +		"tmt")
> > +			_tmt_make_testcase_report "$sect_name" "$test_seq" \
> > +						  "$test_status"
> > +			;;
> >  		*)
> >  			_dump_err "report format '$report' is not supported"
> >  			;;
> > @@ -291,6 +415,9 @@ _assert_report_list() {
> >  		case "$report" in
> >  		"xunit"|"xunit-quiet")
> >  			;;
> > +		"tmt")
> > +			_tmt_assert_env
> > +			;;
> >  		*)
> >  			_fatal "report format '$report' is not supported"
> >  			;;
> > -- 
> > 2.56.0
> > 
> 

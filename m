Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794992285;
	b=Hz+LoN304iIHul2Xx+bfqyHFo+1Q0rPkcjAsA7/0RkjB+74c5hn2sfSObhG8c0sao3gL
	 SH1m/G9ErRve7EyBDNxEvmqRGhOl2QVWqFqQO8EX8MG5QyEZWKjj8a1bGE77mqEsNQVtt
	 CsN3PbFHelqeDoCtKc2mmVIPqJpLihn/5RrGxtyMUSLPFOyhB0w2E14MYWH2Dhe+Vghz3
	 qrbyR+RQuCkDvhJeQtm36Tn2PIIsfQ9KFh+AqvLE/I5l9gOdkQvGR2bFonjO9ClAHHXfN
	 krefAwz45HCZBSFKy57fQyffTYzKwNSiO2aW34WZT02MDw7j/R9XAFfQhA2JG7QUbDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794992285;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=thkySo6oGqBmMmWWa72v8iH9lA3RCONrLszntxanpcM=;
	b=LfboZIGkZvsrUSVBniTGdbTbQgc32Rf/XOAQURRQptF5IgTPM0Wm3/g4BZ60p5Jro85j
	 OZ5hVi8hJRHybMhKunBCcHoWmP5DOcqLt9g+5qxLT/cCIkBz7z1PWrMw7Q8roex3TPk/L
	 w8zbuVfDqbJ15ncGaLWmaaFlDRZdTBnkOvT9d6wyx81fUxfY7KQ52mzAy8KlsXtaFur+7
	 kHVXJuAnl5sc6HecP22kV13BEwbChK4B39E81g7HK2Sry1GNwn3TTCQAnmg9to5ECqGgV
	 YItompB/5YYBiRIBvxa2i/NQ9ZXjG6eOyjOkPXfo+UnzQn8Th2FpU+kZ2oiHJnwNN/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I4nqIJi8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7BD606A32F
	for <fstests@vger.kernel.org>; Wed, 18 Nov 2026 08:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I4nqIJi8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DD11F0092B;
	Wed, 18 Nov 2026 08:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794992285;
	bh=thkySo6oGqBmMmWWa72v8iH9lA3RCONrLszntxanpcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I4nqIJi8VZQYMQhoCNXHkDkOW/h3UclN3A8HLWgmZmNkSFvWucJfe0ptoEFXjkPMU
	 nzs8Mv6Lsn1k9FbbWLKOmQVQwK5QkG7reucEz+hNo5FmvWp1RIx8a0CUXS3OEUhyQZ
	 BUQXuhAC/8Nmvz6TbcUWiFgbdSK5/9a7niPibMST8/yeblI5jsXJQGuZ5fZMQqjeVy
	 WSz5dhlITDzBjG8XbWUVWdQbnWmN7g0VyW65MdleAw7k8a2O9gWO7/uE3QdNl6sh9E
	 6mo4M/bIRVSBtXK3x+o5c9y58KMcagUtAd94a7utQqAFUx4nftGeKtsRDED7wP5NqY
	 N8/a+Hi9jiB/g==
Date: Wed, 18 Nov 2026 09:58:00 +0100
From: Carlos Maiolino <cem@kernel.org>
To: Zhou Xiong <jencce2002@qq.com>
Cc: zlang@kernel.org, fstests@vger.kernel.org, hch@lst.de, 
	sandeen@sandeen.net, Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH] add tmt as a new output format
Message-ID: <av1lzyB0XAavWTvn@nidhogg.toxiclabs.cc>
References: <20261105160526.44266-1-cem@kernel.org>
 <tencent_87B50DCDE1A5161C60F2E950DD5D836C5F0A@qq.com>
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_87B50DCDE1A5161C60F2E950DD5D836C5F0A@qq.com>

On Wed, Nov 18, 2026 at 08:18:03AM +0800, Zhou Xiong wrote:
> Hi
> 
> > On Nov 6, 2026, at 00:05, cem@kernel.org wrote:
> > 
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
> This is useful when it is possible to run xfstests directly in TF 
> without a wrapper.

Yes, and that's exactly what I'm doing. Adding a wrapper around xfstests
so that I can test patches before sending them to Linus just adds more
overhead to me. All I care is to spawn lots of VMs running xfstests with
different configuration.

> If a wrapper is needed anyway, this part
> of work can be done easily in the wrapper. Tmt results can
> be customized somehow.
> https://tmt.readthedocs.io/en/stable/spec/results.html

Yup, I got your point. I just don't want to maintain a repository with
a wrapper to do it. My whole point is to leave to testing-farm
infrastructure all the VMs and environment setup, so all I need to
maintain are the specific testing plans I need to run.

> > 
> > 
> > I know tmt can also be used to orchestrate tests on a local machine.
> > Although I have no use for that, it might be useful for someone else,
> > reason why at the end of the run it will also print out the tmt report
> > file location. This also makes the output consistent to what xunit
> > format does.
> > 
> > Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> > ---
> > 
> > Here is an example report of a '-g quick' run with this patch against a
> > regular distro kernel (Fedora 44). I'm not adding it to the patch
> > description because honestly I have no clue how long those reports are
> > kept so it may very well get stale in a few months.
> > https://artifacts.dev.testing-farm.io/ccd9d09a-f8fc-4460-bdbb-005e1a18bad8/
> > 
> > check         |   2 +-
> > common/report | 129 +++++++++++++++++++++++++++++++++++++++++++++++++-
> > 2 files changed, 129 insertions(+), 2 deletions(-)
> > 
> > diff --git a/check b/check
> > index bca302151955..47a76ba04c59 100755
> > --- a/check
> > +++ b/check
> > @@ -74,7 +74,7 @@ General options:
> >     -S section              exclude the specified section from the config file
> >     -T                      output timestamps
> >     -R fmt[,fmt]            generate report in formats specified. Supported
> > -                              formats: xunit, xunit-quiet
> > +                              formats: xunit, xunit-quiet, tmt
> >     --exact-order           run tests in the exact order specified
> >     --extra-space <size>    require minimum free space on scratch device
> >     --fs <type>             test the given FSTYP; valid types include:
> > diff --git a/common/report b/common/report
> > index 2fa15e62f1e7..7d5e973a6e02 100644
> > --- a/common/report
> > +++ b/common/report
> > @@ -14,6 +14,8 @@ REPORT_ENV_LIST_OPT=("TAPE_DEV" "RMT_TAPE_DEV" "FSSTRESS_AVOID" "FSX_AVOID"
> >     "KCONFIG_PATH" "PERF_CONFIGNAME" "MIN_FSSIZE"
> >     "IDMAPPED_MOUNTS")
> > 
> > +TMT_REPORT_RESULT_PROG="${TMT_REPORT_RESULT_PROG:-tmt-report-result}"
> > +
> > encode_xml()
> > {
> > cat -v | \
> > @@ -244,7 +246,122 @@ _xunit_make_testcase_report()
> > }
> > 
> > 
> > -#
> > +
> > +_tmt_assert_env()
> > +{
> > + if [ -z "$TMT_TEST_PIDFILE" ]; then
> > + _fatal "report format 'tmt' can only be used when xfstests is run as a tmt test"
> > + fi
> > + if ! command -v "$TMT_REPORT_RESULT_PROG" >/dev/null 2>&1; then
> > + _fatal "report format 'tmt' requires $TMT_REPORT_RESULT_PROG to be installed"
> > + fi
> > +}
> > +
> > +# tmt subresult names have to be unique within a tmt test, so prefix each test
> > +# name with its specific section.
> > +_tmt_testcase_name()
> > +{
> > + local sect_name="$1"
> > + local test_name="$2"
> > +
> > + if [ $sect_name == '-no-sections-' ]; then
> > + echo "/$test_name"
> > + else
> > + echo "/$sect_name/$test_name"
> > + fi
> > +}
> > +
> > +__tmt_log_append()
> > +{
> > + local log="$1"
> > + local title="$2"
> > + local file="$3"
> > +
> > + test -s "$file" || return 0
> > + echo "--- $title ---" >> "$log"
> > + cat "$file" | tr -dc '[:print:][:space:]' >> "$log"
> > + echo >> "$log"
> > +}
> > +
> > +# tmt-report-result can attach a single log to a subresult and display that
> > +# on its web interface. Gather whatever logs a specific test left behind
> > +# so we can see it on the web interface instead of digging into the resulting
> > +# artifacts. Do that only for failed / notrun tests as we don't need it if a test
> > +# passed properly.
> > +_tmt_make_testcase_log()
> > +{
> > + local test_name="$1"
> > + local test_status="$2"
> > + local log="${REPORT_DIR}/${test_name}.tmt.log"
> > +
> > + # $REPORT_DIR/<group> is created by check before the test is run
> > + rm -f "$log"
> > +
> > + case $test_status in
> > + "notrun")
> > + __tmt_log_append "$log" "not run" "${REPORT_DIR}/${test_name}.notrun"
> > + ;;
> > + "fail")
> > + local out_src="${SRC_DIR}/${test_name}.out"
> > + local outbad_file="${REPORT_DIR}/${test_name}.out.bad"
> > +
> > + if [ -n "$_err_msg" ]; then
> > + echo "$_err_msg" >> "$log"
> > + fi
> > + if [ -s "$outbad_file" ]; then
> > + echo "--- output mismatch ---" >> "$log"
> > + $diff "$out_src" "$outbad_file" >> "$log"
> > + fi
> > + __tmt_log_append "$log" "hints" "${REPORT_DIR}/${test_name}.hints"
> > + __tmt_log_append "$log" "dmesg" "${REPORT_DIR}/${test_name}.dmesg"
> > + __tmt_log_append "$log" "mount failures" "${REPORT_DIR}/${test_name}.mountfail"
> > + __tmt_log_append "$log" "full output" "${REPORT_DIR}/${test_name}.full"
> > + ;;
> > + esac
> > +
> > + test -s "$log" && echo "$log"
> > + return 0
> > +}
> > +
> > +_tmt_make_testcase_report()
> > +{
> > + local sect_name="$1"
> > + local test_name="$2"
> > + local test_status="$3"
> > + local outcome
> > + local log
> > +
> > + case $test_status in
> > + "pass")
> > + outcome="pass"
> > + ;;
> > + "fail")
> > + outcome="fail"
> > + ;;
> > + "notrun"|"list")
> > + outcome="skip"
> > + ;;
> > + *)
> > + outcome="error"
> > + ;;
> > + esac
> > +
> > + log=`_tmt_make_testcase_log "$test_name" "$test_status"`
> > +
> > + # tmt-report-result is chatty on stdout, which would interleave with
> > + # the test results printed by check.
> > + "$TMT_REPORT_RESULT_PROG" \
> > + "`_tmt_testcase_name "$sect_name" "$test_name"`" \
> > + "$outcome" ${log:+-o "$log"} >/dev/null ||
> > + echo "check: failed to report $test_name to tmt”
>                                                    `_tmt_testcase_name "$sect_name" "$test_name”`
> 
> Others looks great.

Thanks Murphy. I'll update it and send a V2.

> 
> Thanks,
> Murphy
> > +}
> > +
> > +# Only useful if using tmt locally, but keeps consistent with xunit implementation
> > +_tmt_make_section_report()
> > +{
> > + echo "tmt report: $TMT_TEST_DATA/tmt-report-results.yaml"
> > +}
> > +
> > #  Common report generator entry points
> > _make_section_report()
> > {
> > @@ -260,6 +377,9 @@ _make_section_report()
> >   "$bad_count" "$notrun_count" \
> >   "$sect_time"
> > ;;
> > + "tmt")
> > + _tmt_make_section_report
> > + ;;
> > *)
> > _dump_err "format '$report' is not supported"
> > ;;
> > @@ -279,6 +399,10 @@ _make_testcase_report()
> > _xunit_make_testcase_report "$sect_name" "$test_seq" \
> >    "$test_status" "$test_time" "$report"
> > ;;
> > + "tmt")
> > + _tmt_make_testcase_report "$sect_name" "$test_seq" \
> > +  "$test_status"
> > + ;;
> > *)
> > _dump_err "report format '$report' is not supported"
> > ;;
> > @@ -291,6 +415,9 @@ _assert_report_list() {
> > case "$report" in
> > "xunit"|"xunit-quiet")
> > ;;
> > + "tmt")
> > + _tmt_assert_env
> > + ;;
> > *)
> > _fatal "report format '$report' is not supported"
> > ;;
> > -- 
> > 2.56.0
> > 
> > 
> 
> 

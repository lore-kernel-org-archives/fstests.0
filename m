Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794961106;
	b=GREBk5BruQTJ1G32PK/d0eH1IUvUfBsLGLrXkD+kqUqs3hw5E1meT6VDsXr/b87kfpn1
	 AqsXnXn3iBn9S4PWoTI7Zfj/iUqUa69383+A2Crs94+ko45KAC8kK5U0qozr9jNCPMqGk
	 /ikK9QIqhbvH7wcNmcBT0nNFrt1ZOHfptXGVYCuc3AKlo9HwdLDOVeOcx29ygpzhik+OS
	 svtEcS0UNRsia43DT0UySWOVeyAADagdozkfgW272fvZkMUHX1xs9ukxKmicBURdtg1F8
	 jrAitTPMQJGNnreDCLfr0UaZxgRCRiVVZn59KMAPqLmUqVO3dTcOoYxOvt/N8IjSqug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794961106;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:X-OQ-MSGID:References:
	 To:X-Mailer;
	bh=DOYBjijvCjTsO0gslgPIzNJROzjoMeaUNzsPFSv78Fs=;
	b=xoK+NV6R0d4OPtLxpT3ewpAkG+AgTtjks2w0EiaUgtqd3e5g3ucV7Y4feiBqhUtea3lq
	 NG/0wFZB8rsu0hLb3o0q8FGkNGJg29wDIreC5G+6FDm0mxK1slUQiGzGLq0nC+ScYahi4
	 k3yJIrkRAnjb2rK91NVHcGAsMHLTgD5dVWHVRC58dobCLaIlzfhvn9paBjQsc7SKUqF2W
	 Q2iq3gdYSok9D2sTzwfRU2mYiYCK0KUwlFqyKL6mJFLkzzn/WdqFHi5AamDfaGpZo0cc5
	 O+UKzy8Av1rhMM5LM0OHXPInVZy4/OpqQQwu7ZqRsqMMzGxrA/GHnLN7mgr2gdxxJYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b="zLsPr6/Q";
	arc=none smtp.remote-ip=203.205.221.155
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBD6606A31C
	for <fstests@vger.kernel.org>; Wed, 18 Nov 2026 00:18:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FBD6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=zLsPr6/Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794961096; bh=DOYBjijvCjTsO0gslgPIzNJROzjoMeaUNzsPFSv78Fs=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=zLsPr6/QjA3QEyY6XP0NsglsswGc8sge4MqnAN51E8CLBI984qW3vwKels9v+p3BV
	 234N7ZYhafCcFatB4YbPnsbbnJg50xPNZ1ZFxyK4FSjDNQPSilGHOGaeXL329YKley
	 PiK5uaqqpNxXfDCboz6vSO8DT3uxxbvO8iRV0f1k=
Received: from smtpclient.apple ([183.241.32.188])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 48D1EEF4; Wed, 18 Nov 2026 08:18:13 +0800
X-QQ-mid: xmsmtpt1794961093t230zfgow
Message-ID: <tencent_87B50DCDE1A5161C60F2E950DD5D836C5F0A@qq.com>
X-QQ-XMAILINFO: NT7uTz3cNku2wPCMvN1Fxx+v/JHMaGWtzZqRR1HEjujhq3AxBfpbVAAjK/bvMu
	 Xctko7B4vGjXoB2J0AyxRzLeaebivAbJRKSy7u7NEZrASmia9QwvDsgZDdMOzvFcpdUf3tiq+LkT
	 28byvfAxOh8Z7mkttg9cQ2SVbpbD7UZjRRNpS4sibTLPC1BnknrfCfIFImPVbpFwWgQAioy5Eq3e
	 fOQ4uDxA2lTkQwtw2bsjqaZ0WHHRcBRHZBnhQV4PaQ62O/7eDr8pwJZBFyTA0gNWz0o1ktV95dQv
	 oufh3iriIUipPwKufo6zdkca713XEeg6FjaazZhmDsfn7E/Ifrpe0WQOAugA8s9ueX/xluqWaEBz
	 UhZM9+pbH5DVxVQjjNwtCz+t8Ys8DRpUclBp32SZg0Y31E0QqzfR8Uxv5O4drspX9fwFOeezwlBt
	 MN1YRzcrreSCBmUiShZ0xGRSh4BcdgZkhy0cl6J+UA14OlaVHlmXkmBj5LRphupI9LoHPC4YPLJo
	 EWHpA3pQRBrnzVZ1NZi7Lgt+K4wkbfSbcumFFQpbEbvP8I5fPZe2yVUJ6wxtuW3q3c4znjxkVAFZ
	 AOCFBeQMAXJ0gVWaQMmfIiLMVQyzapP3m6y5SB07aofXP3r+pg0RDmpKQCieP99Q0Ipn32k2i2/1
	 QMa1e8uusEKp81OKXdpceCbtGQDsn6xQNm1qoDcvlSOtNBrs1z8fDVJyG+F+3rW8SV+9PvDQ/WFr
	 Mqt6Rgn8GThph9KkaAfv6n/qQyYOT8KVuSfz7nq+ai7jYJT/bi1+0h3T8Wq9SIJv4oA+HKn9INA0
	 52xtfpCvYDRqrPRaO0i4CpODCqq+GY4oUVDUHnstPYrcQuSLrVV9dKnsCG4IQ9qwhIg58Gq39YmR
	 aX33Mo8C5HT6ZophEIq7PKD1cUgDT1mmyx1jmCyY7tEbCtVD5uAYqENuK72hl+65yuAWEhDXKt5N
	 xLxIqB0QX/3mp0fb8bJ0rsPjmicPQRVf/UU0B4UNSMSC+/4We7uGZvBm3IELFIUANyOclkUKHgy3
	 VX0YoCnrKNkaQ3rphqQxSpgMq6y20DeNk8Vk1o4M3C6B8aUc1y
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
Content-Type: text/plain;
	charset=utf-8
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6.1.21\))
Subject: Re: [PATCH] add tmt as a new output format
From: Zhou Xiong <jencce2002@qq.com>
In-Reply-To: <20261105160526.44266-1-cem@kernel.org>
Date: Wed, 18 Nov 2026 08:18:03 +0800
Cc: zlang@kernel.org,
 fstests@vger.kernel.org,
 hch@lst.de,
 sandeen@sandeen.net,
 Carlos Maiolino <cmaiolino@redhat.com>
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <411E8EE1-9DC4-4383-959A-5EB87D66AEC2@qq.com>
References: <20261105160526.44266-1-cem@kernel.org>
To: cem@kernel.org
X-Mailer: Apple Mail (2.3731.700.6.1.21)

Hi

> On Nov 6, 2026, at 00:05, cem@kernel.org wrote:
>=20
> From: Carlos Maiolino <cmaiolino@redhat.com>
>=20
> I've been trying to expand my testing matrix leveraging the =
testing-farm
> cloud (https://testing-farm.io/), which is a public testing cloud =
available
> for opensource testing.
>=20
> Testing-farm uses tmt (https://github.com/teemtee) to orchestrate the
> tests within the provisioned VMs.
> tmt however expects each individual test to be, well, an individual
> test so by default it would put a whole xfstests run as a single test
> case with a looooong report.
> However we can use a tmt-report-result tool to report each test ran
> individually as a sub-test, so the report looks a bit more granular,
> easy to read and prevent my eyes from bleeding while looking at its
> testing reports.
This is useful when it is possible to run xfstests directly in TF=20
without a wrapper. If a wrapper is needed anyway, this part
of work can be done easily in the wrapper. Tmt results can
be customized somehow.
https://tmt.readthedocs.io/en/stable/spec/results.html
>=20
>=20
> I know tmt can also be used to orchestrate tests on a local machine.
> Although I have no use for that, it might be useful for someone else,
> reason why at the end of the run it will also print out the tmt report
> file location. This also makes the output consistent to what xunit
> format does.
>=20
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> ---
>=20
> Here is an example report of a '-g quick' run with this patch against =
a
> regular distro kernel (Fedora 44). I'm not adding it to the patch
> description because honestly I have no clue how long those reports are
> kept so it may very well get stale in a few months.
> =
https://artifacts.dev.testing-farm.io/ccd9d09a-f8fc-4460-bdbb-005e1a18bad8=
/
>=20
> check         |   2 +-
> common/report | 129 +++++++++++++++++++++++++++++++++++++++++++++++++-
> 2 files changed, 129 insertions(+), 2 deletions(-)
>=20
> diff --git a/check b/check
> index bca302151955..47a76ba04c59 100755
> --- a/check
> +++ b/check
> @@ -74,7 +74,7 @@ General options:
>     -S section              exclude the specified section from the =
config file
>     -T                      output timestamps
>     -R fmt[,fmt]            generate report in formats specified. =
Supported
> -                              formats: xunit, xunit-quiet
> +                              formats: xunit, xunit-quiet, tmt
>     --exact-order           run tests in the exact order specified
>     --extra-space <size>    require minimum free space on scratch =
device
>     --fs <type>             test the given FSTYP; valid types include:
> diff --git a/common/report b/common/report
> index 2fa15e62f1e7..7d5e973a6e02 100644
> --- a/common/report
> +++ b/common/report
> @@ -14,6 +14,8 @@ REPORT_ENV_LIST_OPT=3D("TAPE_DEV" "RMT_TAPE_DEV" =
"FSSTRESS_AVOID" "FSX_AVOID"
>     "KCONFIG_PATH" "PERF_CONFIGNAME" "MIN_FSSIZE"
>     "IDMAPPED_MOUNTS")
>=20
> +TMT_REPORT_RESULT_PROG=3D"${TMT_REPORT_RESULT_PROG:-tmt-report-result}"=

> +
> encode_xml()
> {
> cat -v | \
> @@ -244,7 +246,122 @@ _xunit_make_testcase_report()
> }
>=20
>=20
> -#
> +
> +_tmt_assert_env()
> +{
> + if [ -z "$TMT_TEST_PIDFILE" ]; then
> + _fatal "report format 'tmt' can only be used when xfstests is run as =
a tmt test"
> + fi
> + if ! command -v "$TMT_REPORT_RESULT_PROG" >/dev/null 2>&1; then
> + _fatal "report format 'tmt' requires $TMT_REPORT_RESULT_PROG to be =
installed"
> + fi
> +}
> +
> +# tmt subresult names have to be unique within a tmt test, so prefix =
each test
> +# name with its specific section.
> +_tmt_testcase_name()
> +{
> + local sect_name=3D"$1"
> + local test_name=3D"$2"
> +
> + if [ $sect_name =3D=3D '-no-sections-' ]; then
> + echo "/$test_name"
> + else
> + echo "/$sect_name/$test_name"
> + fi
> +}
> +
> +__tmt_log_append()
> +{
> + local log=3D"$1"
> + local title=3D"$2"
> + local file=3D"$3"
> +
> + test -s "$file" || return 0
> + echo "--- $title ---" >> "$log"
> + cat "$file" | tr -dc '[:print:][:space:]' >> "$log"
> + echo >> "$log"
> +}
> +
> +# tmt-report-result can attach a single log to a subresult and =
display that
> +# on its web interface. Gather whatever logs a specific test left =
behind
> +# so we can see it on the web interface instead of digging into the =
resulting
> +# artifacts. Do that only for failed / notrun tests as we don't need =
it if a test
> +# passed properly.
> +_tmt_make_testcase_log()
> +{
> + local test_name=3D"$1"
> + local test_status=3D"$2"
> + local log=3D"${REPORT_DIR}/${test_name}.tmt.log"
> +
> + # $REPORT_DIR/<group> is created by check before the test is run
> + rm -f "$log"
> +
> + case $test_status in
> + "notrun")
> + __tmt_log_append "$log" "not run" =
"${REPORT_DIR}/${test_name}.notrun"
> + ;;
> + "fail")
> + local out_src=3D"${SRC_DIR}/${test_name}.out"
> + local outbad_file=3D"${REPORT_DIR}/${test_name}.out.bad"
> +
> + if [ -n "$_err_msg" ]; then
> + echo "$_err_msg" >> "$log"
> + fi
> + if [ -s "$outbad_file" ]; then
> + echo "--- output mismatch ---" >> "$log"
> + $diff "$out_src" "$outbad_file" >> "$log"
> + fi
> + __tmt_log_append "$log" "hints" "${REPORT_DIR}/${test_name}.hints"
> + __tmt_log_append "$log" "dmesg" "${REPORT_DIR}/${test_name}.dmesg"
> + __tmt_log_append "$log" "mount failures" =
"${REPORT_DIR}/${test_name}.mountfail"
> + __tmt_log_append "$log" "full output" =
"${REPORT_DIR}/${test_name}.full"
> + ;;
> + esac
> +
> + test -s "$log" && echo "$log"
> + return 0
> +}
> +
> +_tmt_make_testcase_report()
> +{
> + local sect_name=3D"$1"
> + local test_name=3D"$2"
> + local test_status=3D"$3"
> + local outcome
> + local log
> +
> + case $test_status in
> + "pass")
> + outcome=3D"pass"
> + ;;
> + "fail")
> + outcome=3D"fail"
> + ;;
> + "notrun"|"list")
> + outcome=3D"skip"
> + ;;
> + *)
> + outcome=3D"error"
> + ;;
> + esac
> +
> + log=3D`_tmt_make_testcase_log "$test_name" "$test_status"`
> +
> + # tmt-report-result is chatty on stdout, which would interleave with
> + # the test results printed by check.
> + "$TMT_REPORT_RESULT_PROG" \
> + "`_tmt_testcase_name "$sect_name" "$test_name"`" \
> + "$outcome" ${log:+-o "$log"} >/dev/null ||
> + echo "check: failed to report $test_name to tmt=E2=80=9D
                                                   `_tmt_testcase_name =
"$sect_name" "$test_name=E2=80=9D`

Others looks great.

Thanks,
Murphy
> +}
> +
> +# Only useful if using tmt locally, but keeps consistent with xunit =
implementation
> +_tmt_make_section_report()
> +{
> + echo "tmt report: $TMT_TEST_DATA/tmt-report-results.yaml"
> +}
> +
> #  Common report generator entry points
> _make_section_report()
> {
> @@ -260,6 +377,9 @@ _make_section_report()
>   "$bad_count" "$notrun_count" \
>   "$sect_time"
> ;;
> + "tmt")
> + _tmt_make_section_report
> + ;;
> *)
> _dump_err "format '$report' is not supported"
> ;;
> @@ -279,6 +399,10 @@ _make_testcase_report()
> _xunit_make_testcase_report "$sect_name" "$test_seq" \
>    "$test_status" "$test_time" "$report"
> ;;
> + "tmt")
> + _tmt_make_testcase_report "$sect_name" "$test_seq" \
> +  "$test_status"
> + ;;
> *)
> _dump_err "report format '$report' is not supported"
> ;;
> @@ -291,6 +415,9 @@ _assert_report_list() {
> case "$report" in
> "xunit"|"xunit-quiet")
> ;;
> + "tmt")
> + _tmt_assert_env
> + ;;
> *)
> _fatal "report format '$report' is not supported"
> ;;
> --=20
> 2.56.0
>=20
>=20


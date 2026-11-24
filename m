Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.163.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795516873;
	b=eY9CZMkfAufDNQ/LqUGIPQWPDLHwVBhpM7GyMlxyh02gjc8nbh9CNMQA1QWxN1YVeZt8
	 Tg8KYPl0+l38DiHcsdNzZO3WWAYhtV2vK0lVFFRgQ3NvtQ2/jZhH8ejt9rOIBCtQKvTu6
	 E+xvmho57otY+mTiqe+IOq+2LnCOkUbmsY8ntxkHh8BSN+cclKpHcakyRWsBWUXIU1Bcl
	 dR00KteG4rncYcLow+Rxa6jo6LLhqyitfJAOTAK9AEkC/hhNDVNklrsEye1wT8kqS1tYw
	 Qo5xMIKoNU5F2PTin6YVzyOsQzspI9FuKNcdbb+XV5KHEA7Rgu4KEk345iAhjxPVrfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795516873;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:X-OQ-MSGID:References:
	 To:X-Mailer;
	bh=XMn5PdMAM5wI6BwP/Bv2bPJaJnnrqtXDQHKBtHSn/8E=;
	b=qlBqNQ7GyiaDz8NwcNEQ8zh99VRCdGWgRaODu+ZyRH4KrZ1bDxU1e2lxOLnGUn4sBMA0
	 7J33AQHUTqDsF5poY74OuEMysveBwLnL4y4H+NK297fZDo+H7sR+AHxeZb6AYeOdRtjY+
	 qwUga01YDELKFXcki9niD6MnMuhDMQCtw0pPnLRm6JNcKYeWW3h+0RhxlW+NRMCz0Ps2C
	 90BTjlef/ZpM5t4qjZD0oHrg84UtwpNSjG9RkOuL5QRZng2BpfyaJL41NmmeQ0BQG+UcN
	 xHbYHGzSdYefg750ZNTNJFiyNQuFFzTb9unPYIfJAJneotZgl6IHlUbZvl2I35O/vug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=FGuSNPfM;
	arc=none smtp.remote-ip=43.163.128.48
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.48])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3415A606A31E
	for <fstests@vger.kernel.org>; Tue, 24 Nov 2026 10:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3415A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=FGuSNPfM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795516862; bh=XMn5PdMAM5wI6BwP/Bv2bPJaJnnrqtXDQHKBtHSn/8E=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=FGuSNPfMBwJIKvYTkWdEwbzCz8uRM6sFA/yKsSqnuwiD0thBJw7xi7t7U/sbt8pf5
	 PFrNdJttoGUltbwZkwVdhP5sjRxNegFH0Nb5GnbGHpmXuZvpOloyD0aeIVkLyohrmm
	 Q5u0WODtgwYqNDB7Q6v2SV17PmqcnsUYgd7cEQec=
Received: from smtpclient.apple ([117.129.44.65])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id A408C6BB; Tue, 24 Nov 2026 18:41:00 +0800
X-QQ-mid: xmsmtpt1795516860tivimcu58
Message-ID: <tencent_63EB8DEDAF369B39B554CB0303BE592AD507@qq.com>
X-QQ-XMAILINFO: NR2AmdDOCZJoyFlF8tU+F9wqEeotux4AMNJz0fe6ZSB4baxzprMhrP1M2/RhMP
	 zZyt+gzIcn2v4xZvNEEgi5L4avkyxajS3H1zjQrDle4Oi84x6jk1ORVU9LzzRrHvTAIfy0nSMjx9
	 udndMVahlP52a8y7RloSgq6je70sI0qBZL9C965SDQmsfriglzQB+Mkl7+NS9uduSPRkVThfXKNO
	 2ObscrEz8mHb0BYn94amefhwNWeredctoexsIUsec242fXkeHdTUd7NJF30VyXez4h/zHqxuUjVH
	 dBxtFhdbHFNY9u4U+tOkn1/6NCW5LHerMvSgb9NGfkh+/u+0e41ObG2nj6HEcpbsE7Y+2rrz761d
	 96RyHFNcFCIQFjVzvs2t8nTDRhRLarNhx8YnLDAkfANEtlb74Jasybk9t9lik2WhwliwzR70iaUi
	 /5hu+mKKTG7KQ8Nsw6t91PWF2mFytWP3D9oG9pXy7gI0MRsRgtTep9QXg2JbSFSvmzk/NZ8ct7hg
	 n85/lYybUcMU+e/iYD/HfX0vpsnp5412AggK2BdGKnXDupI7/hb5d+aJ9yQlhxSz7hSL2UAYX8/b
	 ekg4SpxiPFzGDUdImAuU5WTiXORZApxVZcKdXPmcLE9mJ4BUOM7LMeY/8SjEWRUUU8XA8oGQkM5W
	 tBpKmtmIxrR9W+PHE/NcapoxgdhshAJU0Y/zVb6tNeYP2DErxncflGSiKWi+EPTmdnygXNkgNTNH
	 Arn2iroG6Ld/5tOo+HFCArdSVD9ShM6ymRhV/T8dkPxpRAi4t26aNuZ32cM5/oTtF6+OsSOlBCri
	 gswQ8EEHcxiu427E3ZN0kTkKdtkJ20/NC16mb7VRpzJAkH2SimmqKCfR/FoXW5qdFCljYEnSzhu+
	 X3ZdKGjkTzcTInQQE4M3DV1qppo6woZIVQrvRlLqa4EBVUDfQxaV6CsDFQbTnqmlvceQD1yA9kIp
	 dYBB7ueVf/qnF+nvd/gq0NxYo7wJXx5yl/eB+31wEkD2sJIRq0ANfo96iDMlXPzYwhv/TAw6k442
	 C1LSk7dEO5ggKPavD8EN1oXklKWPCm59thIcjmlrWdt4d+WZ62tT+5Ik5OzGuuYGiZBAHF4wcN6C
	 uLKbIxFxLsQkTexgw=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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
Subject: Re: [PATCH v2] add tmt as a new output format
From: Zhou Xiong <jencce2002@qq.com>
In-Reply-To: <awPtraf_Xrv0fGvc@cronus.toxiclabs.cc>
Date: Tue, 24 Nov 2026 18:40:38 +0800
Cc: =?utf-8?B?5aSp56m6?= <jencce2002@qq.com>,
 fstests@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <A087CC35-232F-476C-BEEF-D7531C907E25@qq.com>
References: <20261119123910.294544-1-cem@kernel.org>
 <awDMOOZxtQW8A4_v@zlang-mailbox> <awFgw_iIynbW7IYa@cronus.toxiclabs.cc>
 <tencent_77C1DC496ADB4131DF06D5ED75F5F66E9B06@qq.com>
 <awPtraf_Xrv0fGvc@cronus.toxiclabs.cc>
To: Carlos Maiolino <cem@kernel.org>
X-Mailer: Apple Mail (2.3731.700.6.1.21)



> On Nov 23, 2026, at 15:43, Carlos Maiolino <cem@kernel.org> wrote:
>=20
> On Mon, Nov 23, 2026 at 09:15:11AM +0800, Zhou Xiong wrote:
>> Hi,
>>=20
>>> On Nov 21, 2026, at 17:57, Carlos Maiolino <cem@kernel.org> wrote:
>>>=20
>>> On Sat, Nov 21, 2026 at 07:19:26AM +0800, Zorro Lang wrote:
>>>> On Thu, Nov 19, 2026 at 01:38:55PM +0100, cem@kernel.org wrote:
>>>>> From: Carlos Maiolino <cmaiolino@redhat.com>
>>>>>=20
>>>>> I've been trying to expand my testing matrix leveraging the =
testing-farm
>>>>> cloud (https://testing-farm.io/), which is a public testing cloud =
available
>>>>> for opensource testing.
>>>>>=20
>>>>> Testing-farm uses tmt (https://github.com/teemtee) to orchestrate =
the
>>>>> tests within the provisioned VMs.
>>>>> tmt however expects each individual test to be, well, an =
individual
>>>>> test so by default it would put a whole xfstests run as a single =
test
>>>>> case with a looooong report.
>>>>> However we can use a tmt-report-result tool to report each test =
ran
>>>>> individually as a sub-test, so the report looks a bit more =
granular,
>>>>> easy to read and prevent my eyes from bleeding while looking at =
its
>>>>> testing reports.
>>>>>=20
>>>>> I know tmt can also be used to orchestrate tests on a local =
machine.
>>>>> Although I have no use for that, it might be useful for someone =
else,
>>>>> reason why at the end of the run it will also print out the tmt =
report
>>>>> file location. This also makes the output consistent to what xunit
>>>>> format does.
>>>>>=20
>>>>> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
>>>>> ---
>>>>> V2:
>>>>> - Add Murphy's suggestion to the log output if it fails
>>>>>   to add a test result to the final report
>>>>=20
>>>> Hi Carlos,
>>>>=20
>>>> Sorry for the late reply. I wanted to wait and see what others =
thought about
>>>> this first, though it seems there hasn't been much interest or =
feedback on
>>>> it so far :-D
>>>>=20
>>>> Personally, I have some reservations about merging tmt reporting =
directly into
>>>> fstests. As you know, I worked at Red Hat for over a decade, from =
the early
>>>> days of rhts-report-result to the newer tmt-report-result, we have =
always
>>>> used external wrappers around xfstests to handle result reporting, =
rather
>>>> than pushing these framework-specific hooks into upstream fstests =
and turning
>>>> it into a vendor or harness-tailored tool.
>>>=20
>>> Just because we never added support to specific frameworks, doesn't =
mean
>>> we can't add them right?
>>>=20
>>>>=20
>>>> While tmt is indeed an open-source project, there is a fundamental =
difference
>>>> between tmt and xunit (which fstests currently supports). xUnit is =
a
>>>> cross-language, cross-CI de facto industry standard, and fstests =
generates it
>>>> completely standalone using pure shell/text processing without =
relying on any
>>>> external binaries or runtime environment variables.
>>>=20
>>> I don't think this is a case against it. Relying on external =
binaries is
>>> not a big deal, we do that everywhere in xfstests. As long as it =
doesn't
>>> break xfstests running stand-alone or in different
>>>=20
>>>>=20
>>>> In contrast, tmt is a test execution framework primarily driven by =
the Fedora/
>>>> Red Hat ecosystem (and Testing Farm). Rather than generating a =
generic,
>>>> standalone structured report file, this patch directly invokes an =
external CLI
>>>> (tmt-report-result) at runtime and tightly couples with internal =
tmt environment
>>>> variables.
>>>=20
>>> Yes, primary driven by Fedora/Red Hat, but publicly accessible, =
available to anyone
>>> wanting to use it to run xfstests. It also only invokes an external =
cli when running
>>> into a tmt environment.
>>>=20
>>>> If we set this precedent, I worry it will open the door for other =
test harnesses
>>>> or internal CI frameworks, such as LAVA, kdevops, Beaker, etc. to =
ask for
>>>> their own -R ktest or -R beaker reporting CLIs. Over time, =
common/report would
>>>> turn into a glue layer for various CI adapters rather than =
remaining a pure,
>>>> self-contained report generator.
>>>=20
>>> I think these are different cases. While tmt can be used stand-alone =
to drive
>>> tests in a local machine, the patch's goal is to make xfstests =
easier to run on
>>> testing-farm without needing to add a bloat of scripts wrapping it =
around.
>>>=20
>>> The difference here is testing-farm is a public environment with =
available VMs
>>> that anyone can take advantage from to run testing over it. None of =
the other
>>> frameworks you mentioned AFAIK offer public cloud infrastructure for =
opensource
>>> testing.
>> Last time checked, one can not access others' test results in TF, =
even read-only.
>> It would be more useful for sharing if this could be changed.
>=20
> Look the first patch I sent. I included a link from one of the test
> runs. Publicly available. I am not sure exactly what you mean, I only
> started dealing with testing farm after Darrick left, but afaik, test
> results are public.
>=20
Good to know!

Thanks,
>>>=20
>>> And to be honest I have nothing against adding support for other =
frameworks as
>>> long as it offers any advantage for the opensource project and do =
not break
>>> current functionality.
>>>=20
>>>> Of course, I completely understand your concern about a mid-run =
crash leaving no
>>>> report behind. In fact, that is the exact reason why our early =
wrappers used
>>>> =C2=B7./check -n ` to fetch the test list and then invoked ./check =
one test at a time
>>>> while that adds a tiny bit of overhead, the overhead is negligible =
and it
>>>> gives the external wrapper a lot of flexibility to invoke Beaker or =
tmt
>>>> reporting immediately after each individual test finishes.
>>>=20
>>> It's not the point. What you are mention just adds a lot of =
unnecessary
>>> maintenance overhead to my already overloaded todo list just to be =
able to use
>>> testing-farm for testing upstream xfs.
>>>=20
>>>> Later on, we also explored ways to optimize this. One approach was =
running a
>>>> background monitor in the wrapper to watch ./check's output stream =
(or check.log)
>>>> in real time and trigger result reporting per test as they =
complete.
>>>>=20
>>>> More recently before I was laid off from Red Hat, I had been =
considering adding
>>>> a generic hook mechanism to fstests instead, if a user sets an =
environment
>>>> variable (e.g., REPORT_TESTCASE_HOOK=3D"/path/to/my-script.sh"), =
fstests would
>>>> invoke that script at the end of each testcase with arguments like =
(sect_name,
>>>> test_seq, test_status, test_time, report_dir). That way, any CI =
system or test
>>>> harness could simply provide its own lightweight hook.sh to reuse =
this reporting
>>>> interface, without having to hardcode vendor or framework-specific =
tools into
>>>> common/report. Also I thought about adding a streaming format like =
JSON Lines,
>>>> where each completed test appends a self-contained, valid JSON =
record on the fly,
>>>> ensuring that whatever has been flushed to disk remains intact and =
parseable even
>>>> if the system crashes midway through a run.
>>>=20
>>> I think the things you are describing are valid but from a QA point =
of view.  But
>>> all of these suggestions adds to me a lot of more work than simply =
enabling
>>> xfstests to communicate results back to tmt. Work that I simply have =
no time for.
>>>=20
>>>=20
>>>> Of course, I never had the time to polish those ideas and send them =
upstream
>>>> for discussion, so if Red Hat still needs something like this, feel =
free to
>>>> take them into consideration. And if anyone else has even better =
ideas, I'd
>>>> definitely welcome a broader discussion on how fstests can better =
support
>>>> various CI reporting needs in a clean, generic way :)
>>>=20
>>> Zorro, nothing about this patch has anything to do with Red Hat. I'm =
instead
>>> leveraging public available infrastructure to scale upstream xfs QA.
>>> After Darrick shut his QA farm down, I needed to scale my testing to =
the same
>>> level. And that'snexactly what I'm using this patch for. I don't =
have time nor
>>> interest in maintaining a huge and complex wrapper around xfstests =
to do the same
>>> thing testing-farm can do and to a scale I have no hardware for.
>>> Instead of maintaining a whole lot of code in a wrapper, I opted to =
leverage
>>> testing-farm features to drive everything I need to setup the VMs to =
run xfstests
>>> in there.
>> No hardware.. So sad.
>>=20
>> Last time checked,  tmt/TF can not catch kernel panic or hang, which =
needs
>> out of band infrastructure.
>=20
> No clue yet as I'll cross that bridge when I get there. My goal now is
> to provide enough regression testing for xfs.
>=20
>>=20
>> Regards.
>>>=20
>>> Cheers.
>>>=20
>>>>=20
>>>> Thanks,
>>>> Zorro
>>>>=20
>>>>>=20
>>>>> check         |   2 +-
>>>>> common/report | 129 =
+++++++++++++++++++++++++++++++++++++++++++++++++-
>>>>> 2 files changed, 129 insertions(+), 2 deletions(-)
>>>>>=20
>>>>> diff --git a/check b/check
>>>>> index afe855bcf0ed..420ac7d274df 100755
>>>>> --- a/check
>>>>> +++ b/check
>>>>> @@ -74,7 +74,7 @@ General options:
>>>>>    -S section              exclude the specified section from the =
config file
>>>>>    -T                      output timestamps
>>>>>    -R fmt[,fmt]            generate report in formats specified. =
Supported
>>>>> -                              formats: xunit, xunit-quiet
>>>>> +                              formats: xunit, xunit-quiet, tmt
>>>>>    --exact-order           run tests in the exact order specified
>>>>>    --extra-space <size>    require minimum free space on scratch =
device
>>>>>    --fs <type>             test the given FSTYP; valid types =
include:
>>>>> diff --git a/common/report b/common/report
>>>>> index 2fa15e62f1e7..0a4a39285ef4 100644
>>>>> --- a/common/report
>>>>> +++ b/common/report
>>>>> @@ -14,6 +14,8 @@ REPORT_ENV_LIST_OPT=3D("TAPE_DEV" "RMT_TAPE_DEV" =
"FSSTRESS_AVOID" "FSX_AVOID"
>>>>>      "KCONFIG_PATH" "PERF_CONFIGNAME" "MIN_FSSIZE"
>>>>>      "IDMAPPED_MOUNTS")
>>>>>=20
>>>>> =
+TMT_REPORT_RESULT_PROG=3D"${TMT_REPORT_RESULT_PROG:-tmt-report-result}"
>>>>> +
>>>>> encode_xml()
>>>>> {
>>>>> cat -v | \
>>>>> @@ -244,7 +246,122 @@ _xunit_make_testcase_report()
>>>>> }
>>>>>=20
>>>>>=20
>>>>> -#
>>>>> +
>>>>> +_tmt_assert_env()
>>>>> +{
>>>>> + if [ -z "$TMT_TEST_PIDFILE" ]; then
>>>>> + _fatal "report format 'tmt' can only be used when xfstests is =
run as a tmt test"
>>>>> + fi
>>>>> + if ! command -v "$TMT_REPORT_RESULT_PROG" >/dev/null 2>&1; then
>>>>> + _fatal "report format 'tmt' requires $TMT_REPORT_RESULT_PROG to =
be installed"
>>>>> + fi
>>>>> +}
>>>>> +
>>>>> +# tmt subresult names have to be unique within a tmt test, so =
prefix each test
>>>>> +# name with its specific section.
>>>>> +_tmt_testcase_name()
>>>>> +{
>>>>> + local sect_name=3D"$1"
>>>>> + local test_name=3D"$2"
>>>>> +
>>>>> + if [ $sect_name =3D=3D '-no-sections-' ]; then
>>>>> + echo "/$test_name"
>>>>> + else
>>>>> + echo "/$sect_name/$test_name"
>>>>> + fi
>>>>> +}
>>>>> +
>>>>> +__tmt_log_append()
>>>>> +{
>>>>> + local log=3D"$1"
>>>>> + local title=3D"$2"
>>>>> + local file=3D"$3"
>>>>> +
>>>>> + test -s "$file" || return 0
>>>>> + echo "--- $title ---" >> "$log"
>>>>> + cat "$file" | tr -dc '[:print:][:space:]' >> "$log"
>>>>> + echo >> "$log"
>>>>> +}
>>>>> +
>>>>> +# tmt-report-result can attach a single log to a subresult and =
display that
>>>>> +# on its web interface. Gather whatever logs a specific test left =
behind
>>>>> +# so we can see it on the web interface instead of digging into =
the resulting
>>>>> +# artifacts. Do that only for failed / notrun tests as we don't =
need it if a test
>>>>> +# passed properly.
>>>>> +_tmt_make_testcase_log()
>>>>> +{
>>>>> + local test_name=3D"$1"
>>>>> + local test_status=3D"$2"
>>>>> + local log=3D"${REPORT_DIR}/${test_name}.tmt.log"
>>>>> +
>>>>> + # $REPORT_DIR/<group> is created by check before the test is run
>>>>> + rm -f "$log"
>>>>> +
>>>>> + case $test_status in
>>>>> + "notrun")
>>>>> + __tmt_log_append "$log" "not run" =
"${REPORT_DIR}/${test_name}.notrun"
>>>>> + ;;
>>>>> + "fail")
>>>>> + local out_src=3D"${SRC_DIR}/${test_name}.out"
>>>>> + local outbad_file=3D"${REPORT_DIR}/${test_name}.out.bad"
>>>>> +
>>>>> + if [ -n "$_err_msg" ]; then
>>>>> + echo "$_err_msg" >> "$log"
>>>>> + fi
>>>>> + if [ -s "$outbad_file" ]; then
>>>>> + echo "--- output mismatch ---" >> "$log"
>>>>> + $diff "$out_src" "$outbad_file" >> "$log"
>>>>> + fi
>>>>> + __tmt_log_append "$log" "hints" =
"${REPORT_DIR}/${test_name}.hints"
>>>>> + __tmt_log_append "$log" "dmesg" =
"${REPORT_DIR}/${test_name}.dmesg"
>>>>> + __tmt_log_append "$log" "mount failures" =
"${REPORT_DIR}/${test_name}.mountfail"
>>>>> + __tmt_log_append "$log" "full output" =
"${REPORT_DIR}/${test_name}.full"
>>>>> + ;;
>>>>> + esac
>>>>> +
>>>>> + test -s "$log" && echo "$log"
>>>>> + return 0
>>>>> +}
>>>>> +
>>>>> +_tmt_make_testcase_report()
>>>>> +{
>>>>> + local sect_name=3D"$1"
>>>>> + local test_name=3D"$2"
>>>>> + local test_status=3D"$3"
>>>>> + local outcome
>>>>> + local log
>>>>> +
>>>>> + case $test_status in
>>>>> + "pass")
>>>>> + outcome=3D"pass"
>>>>> + ;;
>>>>> + "fail")
>>>>> + outcome=3D"fail"
>>>>> + ;;
>>>>> + "notrun"|"list")
>>>>> + outcome=3D"skip"
>>>>> + ;;
>>>>> + *)
>>>>> + outcome=3D"error"
>>>>> + ;;
>>>>> + esac
>>>>> +
>>>>> + log=3D`_tmt_make_testcase_log "$test_name" "$test_status"`
>>>>> +
>>>>> + # tmt-report-result is chatty on stdout, which would interleave =
with
>>>>> + # the test results printed by check.
>>>>> + "$TMT_REPORT_RESULT_PROG" \
>>>>> + "`_tmt_testcase_name "$sect_name" "$test_name"`" \
>>>>> + "$outcome" ${log:+-o "$log"} >/dev/null ||
>>>>> + echo "check: failed to report `_tmt_testcase_name "$sect_name" =
"$test_name"` to tmt"
>>>>> +}
>>>>> +
>>>>> +# Only useful if using tmt locally, but keeps consistent with =
xunit implementation
>>>>> +_tmt_make_section_report()
>>>>> +{
>>>>> + echo "tmt report: $TMT_TEST_DATA/tmt-report-results.yaml"
>>>>> +}
>>>>> +
>>>>> #  Common report generator entry points
>>>>> _make_section_report()
>>>>> {
>>>>> @@ -260,6 +377,9 @@ _make_section_report()
>>>>>    "$bad_count" "$notrun_count" \
>>>>>    "$sect_time"
>>>>> ;;
>>>>> + "tmt")
>>>>> + _tmt_make_section_report
>>>>> + ;;
>>>>> *)
>>>>> _dump_err "format '$report' is not supported"
>>>>> ;;
>>>>> @@ -279,6 +399,10 @@ _make_testcase_report()
>>>>> _xunit_make_testcase_report "$sect_name" "$test_seq" \
>>>>>     "$test_status" "$test_time" "$report"
>>>>> ;;
>>>>> + "tmt")
>>>>> + _tmt_make_testcase_report "$sect_name" "$test_seq" \
>>>>> +   "$test_status"
>>>>> + ;;
>>>>> *)
>>>>> _dump_err "report format '$report' is not supported"
>>>>> ;;
>>>>> @@ -291,6 +415,9 @@ _assert_report_list() {
>>>>> case "$report" in
>>>>> "xunit"|"xunit-quiet")
>>>>> ;;
>>>>> + "tmt")
>>>>> + _tmt_assert_env
>>>>> + ;;
>>>>> *)
>>>>> _fatal "report format '$report' is not supported"
>>>>> ;;
>>>>> --=20
>>>>> 2.56.0



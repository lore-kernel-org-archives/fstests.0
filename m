Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E7C26A1A4
	for <fstests@vger.kernel.org>; Thu, 16 Apr 2026 17:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776362192; cv=none; b=jWiNDUDyM0hpggOdgITRC5D6utv1iL5b1THpw625mnF03334s2yWT1FESlhXl82rt+ReXJApcsKVD2SjBu98D9ejZdO4U31z4LRmGJi+2oOu0MYiG1uu6Sh8IKT0c3dVwuOk0l0MYnVEt0QdcnmauDpRl2+RZgjSeNgi1gJ/Jas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776362192; c=relaxed/simple;
	bh=eBcv5ok+vxywZG+revIMgIlj1DERPLZJeM0mtDXMhQk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMnHTMA/uJsvngRHHuJWm2BE+CnP71KPjwKyS+al9OZAywpRtPwtJcSCOnoTK81ynJbCh0BfRpFlPMvPXF0AxLsqODfS/0mCSTgXz6DH7rd8rhZFl1UGIYYTLeIk0XWz7JKnkmM61NxFJcLCDQOGRuZBc4m5j+Vr05dlIJi1oGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CICETylF; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CICETylF"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a9296b3926so47192385ad.1
        for <fstests@vger.kernel.org>; Thu, 16 Apr 2026 10:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776362191; x=1776966991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qaaqqRWo1uuBMz5XmXFPSox0kPraxb0RgfugrZuaiT8=;
        b=CICETylFQxOdl+qatNAI4wCMVSfRIquyRT+cKmJWoaYArGyhGU3DBENSIuqIX2t8yN
         p7V1xah5yYyV6Lc0IYE3zulGbRSySftdqToKSvyA9Wx24AXevLWaLUCJm/KKkko4LgCr
         JMw6e76dxCBq3C9Y8iJLKXh+MrynAL8KNxiFJek7bcwoMR6IuNPAXL3nNwT1wZDLZ1oa
         /Djcoc4J12pLuFc5FI8Xsj1iTkMpB5OT5+sV2JaLkfAf+/hDYnPm1bhcsXGLaZApPv6F
         UD5L+LgfcqODBuE5UzSIEVKiQu8bkOHOUYhWfrCb23vPqfiMXvcgkpn8K5Vx3QVO0ZFD
         996Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776362191; x=1776966991;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qaaqqRWo1uuBMz5XmXFPSox0kPraxb0RgfugrZuaiT8=;
        b=UgIyWJ091rJ2R2S+HVuv9JKuk6H8bbtDsYjQvmZMvB8nzzXvG7kKjI+d8r0Yv1ol9s
         Ep18LIzHBrSxjO3DKalL0ziOIHz71UEGVgVdDFVL6RQLVPtVOvoHUGKP1o1+C/dxLoiw
         YZPYN6n4Ny4Lo3Yz0cGWtFWOEMcnBxJN++bt4p8OD0xbJvPlDY2iBKExt1nx194GhPIg
         hBKsN6cWavYTHBo1D+Oxwy3yBfC3DtC/F9Avbq8sJHrS0vCDQqOxTV9AZTYuR3cU6NX5
         mAt0/iP40BPEUGzKyOE+2aRGQVXiKRjVBN1RPmlcFgqm35PqiI3liTV3BA+164nCdMwG
         g+Pw==
X-Forwarded-Encrypted: i=1; AFNElJ9fZUDWVa8GHAMaLyNvhgptHH5LFe29OGKovWLOU9D6M9cjjtPgnL8pdC/2NdXTqwCy6ivYRyHh@vger.kernel.org
X-Gm-Message-State: AOJu0YxBEjtsZNkf8LHchg5FYwMeTP8bcDNQ+MV7mrALYDJhQgtcbe+N
	FzN1XgnlnSH4hgml8Jo7O2yiTlCOIHwSyYSZBGuphKqIQa76Quxugc/8
X-Gm-Gg: AeBDieursJnzQzQkLWpohlzVr5Qt7oofVDbZHi94pjaz4O5RMwnHtuLlSH/n6Hb+rDA
	YbeFqXls0GKPGw2qNwQ4cC95bqdHlvNOhSDtQDC+CstdxIzNcWumh+b1UCO6DqR6hHL2shM5Lo3
	RhnFoLbiAjXcflcrIGuqN2MEo4wE5/cxwpoJdIV/Kcf99gJxRylP4dwnXsedzDsYKDTU9elMLpr
	MSarHlbY7ga1YwIZeDLCbWTN+yfpcfrPv7tAoC/SXMasZSlxBit6xjyAxP9o2rdyLwkD6zR/Mgo
	EpphspsAHehlS46U0UPrn3CfpDG8ZAh8PBfyr/JBWH6Jf6T5iGF/0YXAueD53VB0PbHqLirEssX
	hCeSkv5cfszr2BGjWF7qVmd+ATksv4RIG0tqqYPd+PfBJKtmLWguACNEPtyu9tRomCQZLlTpQ7l
	vwPDJXtEV0S09RJHG61lOSo5v75oUT9Po=
X-Received: by 2002:a17:902:ebc6:b0:2b4:59bf:5728 with SMTP id d9443c01a7336-2b459bf59camr199739615ad.25.1776362189709;
        Thu, 16 Apr 2026 10:56:29 -0700 (PDT)
Received: from zlang-mailbox ([64.176.226.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b47811a078sm60883675ad.28.2026.04.16.10.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 10:56:29 -0700 (PDT)
From: Zorro Lang <zorro.lang@gmail.com>
X-Google-Original-From: Zorro Lang <zlang@kernel.org>
Date: Fri, 17 Apr 2026 01:56:23 +0800
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] check: capture dmesg of mount failures if test fails
Message-ID: <aeEeHCuUuBwStWxJ@zlang-mailbox>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>, 
	linux-xfs@vger.kernel.org, fstests@vger.kernel.org
References: <177610262399.115381.16343458870133010450.stgit@frogsfrogsfrogs>
 <177610262444.115381.1847570200616394322.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177610262444.115381.1847570200616394322.stgit@frogsfrogsfrogs>

On Mon, Apr 13, 2026 at 10:51:25AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Capture the kernel output after a mount failure occurs.  If the test
> itself fails, then keep the logging output for further diagnosis.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  check                  |   22 +++++++++++++++++++++-
>  common/rc              |   26 +++++++++++++++++++++++++-
>  common/report          |    8 ++++++++
>  doc/xunit.xsd          |   12 +++++++++++-
>  tests/selftest/008     |   20 ++++++++++++++++++++
>  tests/selftest/008.out |    1 +
>  6 files changed, 86 insertions(+), 3 deletions(-)
>  create mode 100755 tests/selftest/008
>  create mode 100644 tests/selftest/008.out
> 
> 
> diff --git a/check b/check
> index cd7a79347eac28..c37921ea58e558 100755
> --- a/check
> +++ b/check
> @@ -608,7 +608,7 @@ _stash_fail_loop_files() {
>  	local seq_prefix="${REPORT_DIR}/${1}"
>  	local cp_suffix="$2"
>  
> -	for i in ".full" ".dmesg" ".out.bad" ".notrun" ".core" ".hints"; do
> +	for i in ".full" ".dmesg" ".out.bad" ".notrun" ".core" ".hints" ".mountfail"; do
>  		rm -f "${seq_prefix}${i}${cp_suffix}"
>  		if [ -f "${seq_prefix}${i}" ]; then
>  			cp "${seq_prefix}${i}" "${seq_prefix}${i}${cp_suffix}"
> @@ -982,6 +982,7 @@ function run_section()
>  				      echo -n "	$seqnum -- "
>  			cat $seqres.notrun
>  			tc_status="notrun"
> +			rm -f "$seqres.mountfail?"
>  			_stash_test_status "$seqnum" "$tc_status"
>  
>  			# Unmount the scratch fs so that we can wipe the scratch
> @@ -1045,6 +1046,7 @@ function run_section()
>  		if [ ! -f $seq.out ]; then
>  			_dump_err "no qualified output"
>  			tc_status="fail"
> +			rm -f "$seqres.mountfail?"
>  			_stash_test_status "$seqnum" "$tc_status"
>  			continue;
>  		fi
> @@ -1081,6 +1083,24 @@ function run_section()
>  				rm -f $seqres.hints
>  			fi
>  		fi
> +
> +		if [ -f "$seqres.mountfail?" ]; then
> +			if [ "$tc_status" = "fail" ]; then
> +				# Let the user know if there were mount
> +				# failures on a test that failed because that
> +				# could be interesting.
> +				mv "$seqres.mountfail?" "$seqres.mountfail"
> +				_dump_err "check: possible mount failures (see $seqres.mountfail)"
> +				test -f $seqres.mountfail && \
> +					maybe_compress_logfile $seqres.mountfail $MAX_MOUNTFAIL_SIZE
                                        ^^^^^^^^^^^^^^^^^^^^^^
What's the "maybe_compress_logfile" ?

> +			else
> +				# Don't retain mount failure logs for tests
> +				# that pass or were skipped because some tests
> +				# intentionally drive mount failures.
> +				rm -f "$seqres.mountfail?"
> +			fi
> +		fi
> +
>  		_stash_test_status "$seqnum" "$tc_status"
>  	done
>  
> diff --git a/common/rc b/common/rc
> index 5fe44e2158ffb3..18ceda1b32cd63 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -288,9 +288,33 @@ _get_hugepagesize()
>  	awk '/Hugepagesize/ {print $2 * 1024}' /proc/meminfo
>  }
>  
> +# Does dmesg have a --since flag?
> +_dmesg_detect_since()
> +{
> +	if [ -z "$DMESG_HAS_SINCE" ]; then
> +		test "$DMESG_HAS_SINCE" = "yes"
                       ^^^^^^^^^^^^^^^
I can't find you use this parameter anywhere. But you do:

  if _dmesg_detect_since; then
          dmesg --since '30s ago' >> "$seqres.mountfail?"
  else
          dmesg | tail -n 100 >> "$seqres.mountfail?"
  fi

do you want to treat this function as below?

  _has_dmesg_since_option()
  {
          if grep -q -- --since <(dmesg --help);then
                  return 0
          fi
          return 1
  }

> +		return
> +	elif dmesg --help | grep -q -- --since; then
> +		DMESG_HAS_SINCE=yes
> +	else
> +		DMESG_HAS_SINCE=no
> +	fi
> +}
> +
>  _mount()
>  {
> -    $MOUNT_PROG $*
> +	$MOUNT_PROG $*
> +	ret=$?
> +	if [ "$ret" -ne 0 ]; then
> +		echo "\"$MOUNT_PROG $*\" failed at $(date)" >> "$seqres.mountfail?"
> +		if _dmesg_detect_since; then
> +			dmesg --since '30s ago' >> "$seqres.mountfail?"
> +		else
> +			dmesg | tail -n 100 >> "$seqres.mountfail?"
> +		fi
> +	fi
> +
> +	return $ret
>  }
>  
>  # Call _mount to do mount operation but also save mountpoint to
> diff --git a/common/report b/common/report
> index 7128bbebac8b75..a41a58f790b784 100644
> --- a/common/report
> +++ b/common/report
> @@ -199,6 +199,7 @@ _xunit_make_testcase_report()
>  		local out_src="${SRC_DIR}/${test_name}.out"
>  		local full_file="${REPORT_DIR}/${test_name}.full"
>  		local dmesg_file="${REPORT_DIR}/${test_name}.dmesg"
> +		local mountfail_file="${REPORT_DIR}/${test_name}.mountfail"
>  		local outbad_file="${REPORT_DIR}/${test_name}.out.bad"
>  		if [ -z "$_err_msg" ]; then
>  			_err_msg="Test $test_name failed, reason unknown"
> @@ -225,6 +226,13 @@ _xunit_make_testcase_report()
>  			printf ']]>\n'	>>$report
>  			echo -e "\t\t</system-err>" >> $report
>  		fi
> +		if [ -z "$quiet" -a -f "$mountfail_file" ]; then
> +			echo -e "\t\t<mount-failure>" >> $report
> +			printf	'<![CDATA[\n' >>$report
> +			cat "$mountfail_file" | tr -dc '[:print:][:space:]' | encode_cdata >>$report
> +			printf ']]>\n'	>>$report
> +			echo -e "\t\t</mount-failure>" >> $report
> +		fi
>  		;;
>  	*)
>  		echo -e "\t\t<failure message=\"Unknown test_status=$test_status\" type=\"TestFail\"/>" >> $report
> diff --git a/doc/xunit.xsd b/doc/xunit.xsd
> index d287eaf5a25fb6..efe0badbb338b5 100644
> --- a/doc/xunit.xsd
> +++ b/doc/xunit.xsd
> @@ -131,7 +131,7 @@
>                                  </xs:complexType>
>                              </xs:element>
>                          </xs:choice>
> -                        <xs:choice minOccurs="0" maxOccurs="3">
> +                        <xs:choice minOccurs="0" maxOccurs="4">
>                              <xs:element name="system-out" minOccurs="0" maxOccurs="1">
>                                  <xs:annotation>
>                                      <xs:documentation xml:lang="en">Data that was written to the .full log file while the test was executed.</xs:documentation>
> @@ -162,6 +162,16 @@
>                                      </xs:restriction>
>                                  </xs:simpleType>
>                              </xs:element>
> +                            <xs:element name="mount-failure" minOccurs="0" maxOccurs="1">
> +                                <xs:annotation>
> +                                    <xs:documentation xml:lang="en">Kernel log recorded when mount failed.</xs:documentation>
> +                                </xs:annotation>
> +                                <xs:simpleType>
> +                                    <xs:restriction base="pre-string">
> +                                        <xs:whiteSpace value="preserve"/>
> +                                    </xs:restriction>
> +                                </xs:simpleType>
> +                            </xs:element>
>                          </xs:choice>
>                      </xs:sequence>
>                      <xs:attribute name="name" type="xs:token" use="required">
> diff --git a/tests/selftest/008 b/tests/selftest/008
> new file mode 100755
> index 00000000000000..bcd1f13ed27778
> --- /dev/null
> +++ b/tests/selftest/008
> @@ -0,0 +1,20 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024-2026 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 008
> +#
> +# Test mount failure capture.
> +#
> +. ./common/preamble
> +_begin_fstest selftest
> +
> +_require_command "$WIPEFS_PROG" wipefs
> +_require_scratch
> +
> +$WIPEFS_PROG -a $SCRATCH_DEV
> +_scratch_mount &>> $seqres.full
> +

echo "Silence is golden"

> +# success, all done
> +status=0
> +exit
> diff --git a/tests/selftest/008.out b/tests/selftest/008.out
> new file mode 100644
> index 00000000000000..aaff95f3f48372
> --- /dev/null
> +++ b/tests/selftest/008.out
> @@ -0,0 +1 @@
> +QA output created by 008

Silence is golden

> 

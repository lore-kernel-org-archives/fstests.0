Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0801235AC16
	for <fstests@vger.kernel.org>; Sat, 22 Aug 2026 07:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787384169; cv=none; b=IubOBOth6FkjVPsCw9Zc5gdTnWAMvgIy8IDCl55WUljuVwiB8ko/CUXkJQksYXlufUJ7VtcZkrtj89ZoFSM3WFjyH1CzUcPnTEj1YBKcMDMBWXE14q9w+3c+kaaf3+IpjNF2riTatUN/2cxvoIECXvnxNEt3qShac4si0rjnido=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787384169; c=relaxed/simple;
	bh=50rQ5MoEbwvgD9i97MThceSd/7nAlSqG+OLNb2dve58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzSncAlV6l/9TwPJRsj0RUmdICIi81Tl7q9kz0vdRyFuwhLj0mdvon7Mli0TDeCmF5NHgNa/1+IlaKJicp6/VMaN7xmH1t4p4ki1YySCAVIlFzgTOBiPb4hUpuhY1ywOgI3o12xwqSN6kpLRcYG/3H92DqmbMwWVgD+9/ik6dLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyWN4rtJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyWN4rtJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D101F000E9;
	Sat, 22 Aug 2026 07:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787384167;
	bh=VTYQcFXGZn/DYBASlgl0FOMRimCT++refZXScicg0Kw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HyWN4rtJ/unbB33/wlJWzWnLtAlCBp2ycU55LxpgNX8Xl6tvMh0lrq5qpLAVFiFci
	 RUwNIhGHs7lynCEZersFjvWgoetBry3dAQX8fM8rZS9ldIRDGGMpVqVPnaKqc2yr16
	 fUJ8Fjz2UN0ANEhOp6I4j3xYBmCZtYdvfmt5daR5DIs5zwVXxcIAbSc4QRSuzpIHry
	 NuP5XQ+SdDtpVuMPoifF8wWFTD3wd7n2l39vcEhhWxGgJRscdPVnMP6YqTTyNtTUdR
	 XnH6Q+hOc4A82nyDXzGqDd7xfFUbbKE24+CSVWpwN+9l0K91mspSBIzGgs4h/FTIb6
	 Ozvwd+bhIRHOA==
Date: Sat, 22 Aug 2026 15:36:03 +0800
From: Zorro Lang <zlang@kernel.org>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] generic/683: _require_chmod
Message-ID: <aolLssogdhI_LWf3@zlang-mailbox>
Mail-Followup-To: Eric Sandeen <sandeen@sandeen.net>, 
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>
References: <a6e9a97f-295b-4bba-aaef-60af17e9c70a@sandeen.net>
 <aocNwfDmKV4DB9M5@zlang-mailbox>
 <3801889e-b173-4971-bb84-11f5e3434705@sandeen.net>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3801889e-b173-4971-bb84-11f5e3434705@sandeen.net>

On Thu, Aug 20, 2026 at 09:57:56AM -0500, Eric Sandeen wrote:
> On 8/20/26 9:37 AM, Zorro Lang wrote:
> > On Wed, Aug 19, 2026 at 03:32:01PM -0500, Eric Sandeen wrote:
> >> generic/683 uses chmod but does not _require_chmod, so filesystems
> >> like exfat fail.
> >>
> >> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> >> ---
> > 
> > Hi Eric,
> > 
> > So great to see you ! This patch makes sense to me. Actually, g/683 belongs
> > to the same group/patchset of SUID test cases as g/684 through g/688, and all
> > of them use chmod. If we need to add _require_chmod to g/683, I would suggest
> > adding it to all of them.
> 
> Ok, fair enough - I should have looked more closely, and when running exfat
> all of those tests properly did a _notrun due to /other/ constraints, but
> we probably should explicitly mark each requirement even if they are
> stacked.

Maybe some of the other _require_ checks helped those tests to _notrun on exfat.

> 
> I wonder if some sort of checkpatch or linter for xfstests might be
> helpful, it's pretty simple to grep a test for chmod and ensure that
> it has _require_chmod for example.

Sure, I just tried this:

  #!/bin/bash

  TESTS_DIR="${1:-tests}"

  find "$TESTS_DIR" -type f -regex '.*/[0-9]+$' | sort | while read -r test_file; do
        if grep -qE '^[[:space:]]*_require_chmod\b' "$test_file"; then
                continue
        fi

        if grep -v '^[[:space:]]*#' "$test_file" | grep -qE '\b(chmod|\$CHMOD_PROG)\b'; then
                echo "[Miss _require_chmod] $test_file"
                grep -v '^[[:space:]]*#' "$test_file" | grep -nE '\b(chmod|\$CHMOD_PROG)\b' | sed 's/^/    Line /'
        fi
  done

Not sure if we should blindly add _require_chmod to every single case we found.

>
> ... or I wonder if it would be runtime-prohibitive to just build that
> into the check script; if the script contains "chmod," run _require_chmod
> automatically... similar for all the other trivial _require tests.
> 
> But maybe that's trying to be too clever. :)

xfstests contains thousands of test cases, so this approach would introduce
substantial redundant overhead and frustrate a lot of developers :)

Thanks,
Zorro

> 
> -Eric
> 
> > Thanks,
> > Zorro
> > 
> >>
> >> diff --git a/tests/generic/683 b/tests/generic/683
> >> index 883905da..226d2758 100755
> >> --- a/tests/generic/683
> >> +++ b/tests/generic/683
> >> @@ -24,6 +24,7 @@ _cleanup()
> >>  # Modify as appropriate.
> >>  _require_user
> >>  _require_test
> >> +_require_chmod
> >>  verb=falloc
> >>  _require_xfs_io_command $verb
> >>  _require_congruent_file_oplen $TEST_DIR 65536
> >>
> 
> 

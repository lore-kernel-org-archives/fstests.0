Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558C33803D2
	for <fstests@vger.kernel.org>; Wed, 17 Jun 2026 19:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781724480; cv=none; b=p3CmWKJE0fvigHWx5eZd/1hCzBgMJbx2jPNNsuCXUtsEWGp+TeV0PK6Hby+Ng6kvheELsFWKQPxY+7NOxnrIGYaEld834qmDFAj79nVOipHxkKcGKOvD3VO/VWrDiAVs5xd71HK8cqsJRhpjHcDhE7q6kRm/UCx03V5p5Gx5cek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781724480; c=relaxed/simple;
	bh=yTPsj76/iYO/rcfHnhaDQ1ZbrlPFxfIuYqmcbB5qhSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sf9dyuB+gvdOf6AlVj5EEDuFGsAfFCZDjcRY36Pv2IyKMEM4hgMqDZu52xb+J2Mxho37Xh9eM7vBJR4NMvFglfqDD/zeK0bbUg9zgpmVol4Gz82+VCpH0JdmycXSI1eSFZtJMnJ45mkq8rWGIOgAT9zj20Dg0/csRJouivpgbMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFkt03Cz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFkt03Cz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C74F1F000E9;
	Wed, 17 Jun 2026 19:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781724478;
	bh=WVwbnDzVh+G+3Gt9IMOUaqrIm5MC6A+ZLhoxInkXIhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RFkt03CzldmrMFfl9vtl7nYn2/8PuGZe5MP+geakQbbMRexmzUIwQyspw4L9YYEvr
	 ixDpwukTN8gDKVeyXqwEcI5w2149EDjcaXsypQhfOB96ac7AGTuTgqQHCiNhY+TcKg
	 734nG4ZW16xQZNnIVDgo7ZX2SR5oUyArxT6SURcWgDXK1SLc0/MxSh79ferslysxFa
	 1OKJLyV823nZWlX05SwfrTe0p8D2feRAiB1l9nBs2GoL6mlxyCy0hA6Vbz/u1AQAxB
	 906/iBRe+8nSVqr1E2xXCnkQFew+qsetLrEbxb/1K0CNf6lg6fYSWlsUTxhwKCMlAQ
	 iWz0dA8N647ug==
Date: Thu, 18 Jun 2026 03:27:54 +0800
From: Zorro Lang <zlang@kernel.org>
To: Joanne Chang <joannechien@google.com>
Cc: fstests@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH v1] generic/63{4,5}: Modify criteria for passing test
Message-ID: <ajLxLnEepPuVq7-Z@zlang-mailbox>
Mail-Followup-To: Joanne Chang <joannechien@google.com>, 
	fstests@vger.kernel.org, djwong@kernel.org
References: <20260602071911.3652151-1-joannechien@google.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602071911.3652151-1-joannechien@google.com>

On Tue, Jun 02, 2026 at 07:19:11AM +0000, Joanne Chang wrote:
> The two tests pass when a timestamp is not preserved after the remount,
> because "cmp -s" does not print to the output file, and status is set to
> 0 regardless of the return value of cmp. So, use "diff" instead to
> correctly fail the test and flag the error case in the output file.
> 
> Also, as the tests are focused on timestamps, don't print file contents
> so the tests can still pass if only the file contents differ.
> 
> Signed-off-by: Joanne Chang <joannechien@google.com>
> ---
>  tests/generic/634 | 4 ++--
>  tests/generic/635 | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/generic/634 b/tests/generic/634
> index 8a4210a3..d7dd9dd8 100755
> --- a/tests/generic/634
> +++ b/tests/generic/634
> @@ -52,7 +52,7 @@ touchme() {
>  report() {
>  	local files=($SCRATCH_MNT/t_*)
>  	for file in "${files[@]}"; do
> -		echo "${file}: $(cat "${file}")"
> +		echo "${file}:"
>  		TZ=UTC stat -c '%y %Y %n' "${file}"
>  		test $test_statx -gt 0 && \
>  			$XFS_IO_PROG -c 'statx -r' "${file}" | grep 'stat.mtime'
> @@ -98,7 +98,7 @@ report > $tmp.after_remount
>  cat $tmp.after_remount >> $seqres.full
>  
>  # Did they match?
> -cmp -s $tmp.before_remount $tmp.after_remount
> +diff $tmp.before_remount $tmp.after_remount

Haha, looks like Darrick accidentally added the -s option :)
It seems like simply dropping the -s option would fix this issue, though
switching to diff works as well. If Darrick has no further review points,
I'll go ahead and merge this patch.

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  
>  # success, all done
>  echo Silence is golden.
> diff --git a/tests/generic/635 b/tests/generic/635
> index 018b868c..f74d0cd7 100755
> --- a/tests/generic/635
> +++ b/tests/generic/635
> @@ -55,7 +55,7 @@ touchme() {
>  report() {
>  	local files=($SCRATCH_MNT/t_*)
>  	for file in "${files[@]}"; do
> -		echo "${file}: $(cat "${file}")"
> +		echo "${file}:"
>  		TZ=UTC stat -c '%y %Y %n' "${file}"
>  		test $test_statx -gt 0 && \
>  			$XFS_IO_PROG -c 'statx -r' "${file}" | grep 'stat.mtime'
> @@ -102,7 +102,7 @@ report > $tmp.after_crash
>  cat $tmp.after_crash >> $seqres.full
>  
>  # Did they match?
> -cmp -s $tmp.before_crash $tmp.after_crash
> +diff $tmp.before_crash $tmp.after_crash
>  
>  # success, all done
>  status=0
> -- 
> 2.54.0.929.g9b7fa37559-goog
> 

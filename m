Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C97342173
	for <fstests@vger.kernel.org>; Tue, 23 Jun 2026 08:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782204393; cv=none; b=HrmEP4lvOytduBzuacDrOH584AAIlpPRAMSHYd/tYAzeRqGRnsxknIQyHPhWNXNOYu6iUrTmK2aHxECUlNDXdOMcM3JBXoPMLqJ+HUrDnzIePd7LgfLvE/LKsbGqTc86FIyWyKCGIK/KcZTAK6BnpQsSKepBVk7gTnhrshsCvUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782204393; c=relaxed/simple;
	bh=qXcV60QbkQwGdfSWhvQOwLAAF/BMjU/sOQm6V/P48dY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=e32+Rgx2si51zJIpDZhImqWcSn+s7FefEZ3/ltczod9neyS+Z6ZB3YkUyQRDuf6yuVvkQ+MnCoNDlSynolzAdmjktR2qwWJuzT6QEcmM1FUTOV52vG8FgXs/8/+ul+oNuzOWEgKPvOjE4tnf0NEqTsJ+aPawD42l7+axeP5rqg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0ryzxmw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0ryzxmw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54AE51F000E9;
	Tue, 23 Jun 2026 08:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782204392;
	bh=adywUmALuyG/Z2us7XDrWI8UlRJTGwoFilVn9pM5SKs=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=V0ryzxmwF9C1X6LxvNYrcYwPCM+TpHcm/pwjjlg+RUtH97q5JkxeKhnAaFc2240KY
	 UdjqFGEhUsW8dOhSe2xDrf1d8P0+eSD/LizmY6iMOo4MVUe/uwonNPh0cCkHEzgwV4
	 Wtga5eJgQh7HnDGVHfzs2P6n0FcV2qy90pEsZkKLhKAAdUTm5OuwT1sUs1ytcuohg9
	 8LIVjA+5bCe30Op6FaUmAjQ+19HJnljzgAOC0dEOUAtxe4DjDYcQeMx70KZTJ9LdVk
	 /udP8iXBckeBfDpSuqcohO8Yzed/sXvMGVXw+wnFNYRxHxYYrQx3h8x4OsG75guq+C
	 KsN9r4Sq9RnBw==
Message-ID: <698bcb3a-38d8-479a-b0e0-13d23a08743d@kernel.org>
Date: Tue, 23 Jun 2026 16:46:29 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, jaegeuk@kernel.org, zlang@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] generic/064: allow 50 extents on F2FS after
 fcollapse
To: Jan Prusakowski <jprusakowski@google.com>, fstests@vger.kernel.org
References: <20260622070438.1542638-1-jprusakowski@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260622070438.1542638-1-jprusakowski@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/22/26 15:04, Jan Prusakowski via Linux-f2fs-devel wrote:
> On F2FS, generic/064 fails with "extents mismatched before = 1 after =
> 50" following multiple fcollapse (collapse range) operations.
> 
> To ensure crash consistency and checkpoint integrity, F2FS forbids
> in-place SSR (Summary Standalone Replacement) overwrites on valid
> checkpointed blocks. When collapse range shifts blocks, F2FS allocates
> new data pages in LFS mode (out-of-place log writes). As a result,
> sequential collapse range calls rewrite shifted blocks at new log
> locations, intentionally leaving the file with 50 extents.
> 
> Adjust the extent verification in generic/064 to expect exactly 50
> extents on F2FS, while preserving the strict 1-extent requirement for
> all other filesystems. Data integrity continues to be verified via byte
> comparison.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Jan Prusakowski <jprusakowski@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

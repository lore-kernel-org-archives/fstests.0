Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6711B3D3D09
	for <fstests@vger.kernel.org>; Fri, 15 May 2026 04:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778818874; cv=none; b=WSNwNE+7p+0u8SmxvXF+pwIvGxIssk38P+3b3bAPJE95HNHSuGZfM1tqKp5rZw/Hc/91WOFsE78bRFbTn3KDRP9in2chNfdnFVjVENpg3Jl3vO93PWyt6pwZYrCZlPen8D+JBUEpJ80tgnBmWxYHxG+mxRbBsWz8SpxMLxW7pd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778818874; c=relaxed/simple;
	bh=hzpbGtt5JNjh+2XBoTTDm/pYECTztJwQwqxX8PEVhBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dy5fVvWvv56rgiYatSEQgfyYGFdqr7m/GVOEfi8MRZnIzU4HSc1JBt2oCoo02uv+nO7QH/auVEnX2/Z+OhijL1gbLLuqnfhdknWm5pZU1AWxgKuPi++/Omudgk25LvF6DV3gMTOK09CMGJFIIgUsSoYddbtwK6fz02iTXIWve8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKV9axnK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKV9axnK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FBCC2BCB0;
	Fri, 15 May 2026 04:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778818874;
	bh=hzpbGtt5JNjh+2XBoTTDm/pYECTztJwQwqxX8PEVhBM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bKV9axnKW3Cc6MWDsucuNgq6+/Jh6Mt2Ax6tMrNcS3lwNimU+2vXlXtpT+H7DFFbJ
	 uB2/iL4IUVd4r6YCrgMXPxMcmdjyzyvrJh29294+YQMkX2OjwE9iDnjXaVKCISp0jf
	 yU0QnnGJu270NpqilE5mKCGtqIZeNzhdL5ZiSBjyZIurCJ9ONl3ChrWw5kgNHJiSK3
	 M4yOVMWg64z9o2f9sUcHwXwJgNkUe0dO2CIG3IoyyhBxuQCseKyra6pgrfHhC8SDFU
	 WMvitvWbs/B6vVmGJi5Z+r+ug1zPUbxz2fuJVaqW8av/i4Bjx+4g2kB/wDpecUDQcX
	 Q9aCUcFFj2w/A==
Message-ID: <1d069492-b9ae-4ec9-9eb8-c77f6de3ab29@kernel.org>
Date: Fri, 15 May 2026 04:21:11 +0000
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] f2fs/015: Fix mount syntax for disabling jquota
To: Joanne Chang <joannechien@google.com>, Zorro Lang <zlang@kernel.org>,
 fstests@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
References: <20260513032009.2300435-1-joannechien@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260513032009.2300435-1-joannechien@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/13/26 03:20, Joanne Chang wrote:
> F2FS has removed the trailing "=" in the mount options for disabling
> user, group, and project journaled quotas. To maintain compatibility,
> update the test cases in f2fs/015 to try the new syntax first, and fall
> back to the legacy syntax if the initial mount attempt fails.
> 
> Signed-off-by: Joanne Chang <joannechien@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

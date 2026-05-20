Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0053C0635
	for <fstests@vger.kernel.org>; Wed, 20 May 2026 08:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779264886; cv=none; b=lkTTtT/2fyhFfY8KDeosXnIEI84lyswXhbd9mK5gn2dg5uL1W433/jro5nEPey84qmeNnS/GnrcbmrjttCWWDmtH54igidt2R1zDpNdILwSIIi7ch68S3y2UB91w0LsRkTRPt9a7R+7JxT+HWefjgUan6xDbfu+oDLsSe8AQm9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779264886; c=relaxed/simple;
	bh=0MtyPsfipsyI9MspFzo7yhbzaQMmF6vl+Wa2laFLdYM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AkUTeoz9nEQ/dC83pbtvrGP23KNjlaUinK/yCvu/Dsjnr4ggAxnLx8DG+ojqyE9SObAgir1wN3E5TcbAev9FNC3KyCbkjXbDOpUKCLt6fajcdBhexyj7y+49KBjpJG6s6BqmBsfw1oWyv80jiydWeIL4oxqC3Irm20FnOmicaL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjhAm2sq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjhAm2sq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403821F000E9;
	Wed, 20 May 2026 08:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779264885;
	bh=Tfx+PSlmtT1gDfTrl0TEo7BWR6ahF0uKqZ5bOpUj4vw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=cjhAm2sq/B82ImYEagpmIGfuBUwgA9BG6PMZZfLl6eAMGQll3CixUNiQoIZm7TDW5
	 YjfYxggI23V8DTb8gaxErM9EG/PeN4DB+eM04GtXJHGKxgI7n3DDu0WBsBl476/DN2
	 lKdo6Gv+BnYhgG9Lr736G9/ZgPsuZu1fnpNMDjrwi+qNwDRX6RCHq6dj11nxrgkUqa
	 YrYn6VIm92Yg4QyNSp0Kn1izqeL+lIoMS4lLpLCioxn3vJLbyIQf0o8z/abBwbTTdd
	 jCEGrMoXkF7sI3G4Ll3vznbQ7EZ5NUgtOS0qafHWNUJIZzRZjSNcS12Mn+N/hSARyh
	 S57yJ9SVbNMaw==
Message-ID: <f2e2147e-bf60-4a67-83fe-b77d34f7bc8a@kernel.org>
Date: Wed, 20 May 2026 16:14:20 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>,
 Qu Wenruo <wqu@suse.com>, "Darrick J . Wong" <djwong@kernel.org>,
 Nirjhar Roy <nirjhar.roy.lists@gmail.com>
Subject: Re: [PATCH] generic/563: allow read tolerance for f2fs in scenario 3
To: Jan Prusakowski <jprusakowski@google.com>, Zorro Lang <zlang@kernel.org>,
 fstests@vger.kernel.org
References: <20260515082608.449455-1-jprusakowski@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260515082608.449455-1-jprusakowski@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/2026 4:26 PM, Jan Prusakowski wrote:
> F2FS is a log-structured file system that allocates new blocks even for
> overwrites. To perform allocation, it may need to read metadata blocks
> (such as the Node Address Table (NAT) or Segment Info Table (SIT)) if
> they are not already in memory.
> 
> In scenario 3 (read -> read/write), unlike scenario 2, there is no prior
> write in the same mount session to load these metadata blocks into memory.
> Therefore, the write operation in the second cgroup triggers metadata
> reads, which are charged to that cgroup.
> 
> Relax the read tolerance for f2fs in scenario 3 to accommodate these
> expected metadata reads, matching the tolerance already used in scenario 2.
> 
> Signed-off-by: Jan Prusakowski <jprusakowski@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

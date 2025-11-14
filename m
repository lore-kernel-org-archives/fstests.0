Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD18F1BC41
	for <fstests@vger.kernel.org>; Fri, 14 Nov 2025 01:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763084038; cv=none; b=NQnYlDVljlYlQbYhKDa4BMANWhfeTs4fE2tjDdxv4nF+/vVh6VzHNcz0AikPDGKAXmGqmmJah88lmeoTGf1o1EkRbtYR2navOZhP8TXvdVXBFphtjQgvtWQOr26PsZhvKIk3VaZR1liMo7GXEBks34T8bfbk4rEHL0T41F++WFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763084038; c=relaxed/simple;
	bh=exd2h08pVhf0aUPP9p+4zI9UBcu8vPVvEmGm5+1BvDM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UTTc36JfyXQ6qKjv0q6S+UkkEecY6VPqwJuAhWg99COITJVIKem6i9Fb8VQq44U+9ksZVEKOC6qa8n9lXqJO1mUkIz+fGwcQ+dZsQ4pP2WmqCclK1P7lSjOFoCnHHOCk6jEr1YOKHOfx4RgPgIR0v0c94TMeU5cVdxnGHopZTR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/BYxSr0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/BYxSr0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293F6C113D0;
	Fri, 14 Nov 2025 01:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763084038;
	bh=exd2h08pVhf0aUPP9p+4zI9UBcu8vPVvEmGm5+1BvDM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=U/BYxSr0qJBjIzslnpNC8OzZLZc/dKzCVzlVHejsfPg1qDHBGKaUO8PKqFle1yigh
	 G5w8Kbt82z58SfqG4xbBksiKPBkofUXC4C0ScXTyqwo9nfN1uwuZey24JqVggGfKsE
	 H+BraAUDtBFqVHhxzU5B4xwdGpU5i+BOArmPeY4Vz/jv3ih2axaHwX1uq7N1ORaMnz
	 3a0me02xa7RQZJgjWNJLVai3Qxv91eQh5sOY9DA7GHFeRSRKbfGbTT0y3ihqSpK5wU
	 bLM1MqbnHIQ23EOJvnmicTwBYMfz2qMFFaHLiHUd7i3qxHn2iTt6FCbF6Tx05OEZzn
	 b3VfDfcxknetw==
Message-ID: <98034c77-5e47-43ea-9c45-335e2cd51b68@kernel.org>
Date: Fri, 14 Nov 2025 09:33:58 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v1 2/3] f2fs/016: add test cases for test_dummy_encryption
 mount option
To: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 Joanne Chang <joannechien@google.com>
References: <20251112135223.3467852-1-joannechien@google.com>
 <20251112135223.3467852-2-joannechien@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251112135223.3467852-2-joannechien@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/2025 9:52 PM, Joanne Chang wrote:
> Add test cases to verify f2fs's support for different versions of the
> "test_dummy_encryption" mount option.
> 
> To ensure test robustness, the MKFS_OPTIONS and MOUNT_OPTIONS are
> cleared. This prevents additional options from interfereing with the
> test results.
> 
> Signed-off-by: Joanne Chang <joannechien@google.com>

To Zorro,

The changes look good to me, though, still I want to confirm that whether
it is recommended or not to add new cases in old testcase.

Thanks,

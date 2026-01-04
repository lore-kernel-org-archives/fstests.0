Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D2D219A8A
	for <fstests@vger.kernel.org>; Sun,  4 Jan 2026 14:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767537771; cv=none; b=ogYbP5oauwt3plAakfdbec2bDjjyds2Wc1Ee7kiISiCZtewwluW3MG/XUHAaGOXMd15i9VsS6EYSNu2byjoUAzSy2hyrITytH2tsL32khT1SpJm6bSBnaoDQBIWMSdfSe7/OB7ewIE2HycBYk71h5Q/KaoBM6h3c/KIJyt3rNI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767537771; c=relaxed/simple;
	bh=qLh7a2fNEbatp51SHeXp1DxBMO4onwIeinZHCMPacSY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=L4wMSTaQghsRnM2kqab4qY2HIzmChe+XcrghAVyMsSvGgTgZzynTJHwpZ5D041xYV0SA9GakmcgOR7sgYQLo07z4zc6Nm7j8M1Aw2u2caFf4VCcbKzcEnwNenU2ubiQNxvcfxSH2QN9MCBwgmj8cBOcHOcUojx2feWQT6dULrqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kqzerijv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kqzerijv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4BAC4CEF7;
	Sun,  4 Jan 2026 14:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767537770;
	bh=qLh7a2fNEbatp51SHeXp1DxBMO4onwIeinZHCMPacSY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=KqzerijvOqYgGRe9eC4ccQ/LSA5ayJm0QlP+gcpnScS0uf4rWnqsOcGbIzWVG65BM
	 xIa59gy2aFExXvSwaOfVO1u5gaamgOgmym6qWn8pQM3HMVoIK6T86d8zAOHl2ro6YC
	 7mW6WPxPKAQYVsdPd8u4RgCnWoFX6bE5OKsoQPYuZtw7cyz1ssfFxus5VLY0RfkUPi
	 2Kc1XJyRchgnBuZPv/2n3J0uvaQOSIrZJR8FqXWIOTFxwtTNNl9gI3YU7BuxR67wGR
	 CigyXPmH5U6jAzEupdvy/3vIvS8O5cMhGfTh7RzSe7uy/8BqcnNGFIBzgrD85/XlBw
	 d1Y60CvpVlD/w==
Message-ID: <5b348fba-6b32-420b-a0ff-65c5d368d1a1@kernel.org>
Date: Sun, 4 Jan 2026 22:42:29 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2] common/rc: add _require_blocks_in_file helper
To: Joanne Chang <joannechien@google.com>, Zorro Lang <zlang@kernel.org>,
 fstests@vger.kernel.org
References: <20251229023145.1806877-1-joannechien@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251229023145.1806877-1-joannechien@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/29/2025 10:31 AM, Joanne Chang wrote:
> generic/735 attempts to create a file with nearly 2^32 blocks. However,
> some filesystems have a maximum file block limit below this threshold.
> For instance, F2FS is limited to approximately 2^30 blocks due to the
> capacity of the inode. So add _require_blocks_in_file helper to skip the
> test in such cases.
> 
> Signed-off-by: Joanne Chang <joannechien@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

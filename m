Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C6E218ADD
	for <fstests@vger.kernel.org>; Fri, 14 Nov 2025 01:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763084092; cv=none; b=t2zR+mYGaDoXgzsl59e9JJ6GPDsnmnlf3l2me4aCOuzCXJ6cyVcXeqNDTVP1pwtTUHS9kGBa+8l3oeKIVLzbBmTh5QPP5BOtbEyeTQLAowTK8ByDN4KaCi2yvQtzDWsVPw4bMAWeygtyvYcUEk0z2V3mWc3VFumbMvpdZjnyPxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763084092; c=relaxed/simple;
	bh=YjMII5HUntbbCppXh7SUcDPnKk/b0aE0AtCer6ea34U=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VE/VQTpsLf1zoZylcg0kf1Z0R5XEd0fvowfGgRIZ94jBi6n4QF6sbBzyU0/2j+smsJ4WScuJos15uGn1DhLrHoP4w+FF5RqJtPer77nWMVRdXLiufPQ/vXKLgUhvcvT6I96o8HLEX/jhbN+KJqmBXuEm6gk789MFK1ZbTFpgpzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyI0VutK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyI0VutK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FFC1C4CEF7;
	Fri, 14 Nov 2025 01:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763084092;
	bh=YjMII5HUntbbCppXh7SUcDPnKk/b0aE0AtCer6ea34U=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=VyI0VutKKjAWkR0w6kJ+wDT16FkTSWUaXs9T5hfV49BU4bqQFFzdcKqqzpvPSbNHh
	 atK2gAVi9FcNvWA1PP8fMHemyVievlz6y8L+10VNqgm5Bq31w/wtTRKTf7H3eBvSQV
	 Eorft36TTM52oFVSYUrdOtQTXi8H0z2ns7I4Xa3hV7wXCwR39rNEaaNpACsK4aMOh2
	 f+cXjVydxDrR0BqUIO6iH4LupL3w5lyPgHJjI+vK3FFFxHvSAjSjzPwd7oadzPm22n
	 CWPGfUXimLnFsWz7DFwaDChj3iZLYNqt4z/BPSHx+vCE49kUguJCrCO6nsDN2Ytxnd
	 0w6AQjL7dZVaQ==
Message-ID: <a9500c33-b259-4ff5-8411-997399a47358@kernel.org>
Date: Fri, 14 Nov 2025 09:34:51 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v1 3/3] f2fs/{019,020}: clear MOUNT_OPTIONS alongside
 MKFS_OPTIONS
To: Joanne Chang <joannechien@google.com>, Zorro Lang <zlang@kernel.org>,
 fstests@vger.kernel.org
References: <20251112135223.3467852-1-joannechien@google.com>
 <20251112135223.3467852-3-joannechien@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251112135223.3467852-3-joannechien@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/2025 9:52 PM, Joanne Chang wrote:
> Currently, f2fs/019 and f2fs/020 only clears MKFS_OPTIONS. This causes
> the tests to fail when leftover MOUNT_OPTIONS depend on unapplied
> MKFS_OPTIONS. So MOUNT_OPTIONS should also be cleared to ensure reliable
> mounting.
> 
> Signed-off-by: Joanne Chang <joannechien@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

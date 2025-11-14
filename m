Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A84426C39E
	for <fstests@vger.kernel.org>; Fri, 14 Nov 2025 01:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763083844; cv=none; b=ukZEr9KGpBiuid+KgCqdjWLrdRDQyG1KunSGwn+eoLuZ3psQOAdAv/I85RKxSHb9s6AeXW/47dOjZN/9QkoAn15tOLVKDw+LhEKcysz/qhQZu6+axwTKsCh8D9KLxnTjb3hACyLIgkRfjORC0D637mHQvypnyRNsW94mCsLqKi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763083844; c=relaxed/simple;
	bh=a1cdXiNw2H1JE/HA6Rad4k0t2mwYcH0+AZQJU2v9Q+4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FEQNyBsjda1Em7iBDyoajOV5tlOZlzxUgraMwCTBDzfrozfwcfi+StluOZRFoxtyOFG3jb6JoTtqRCdd5Ec2SOa0kXc8LDLY9UdRnP+snSeZwBxjJAQL+l0By9gWznKIaIuPIx5aEbydA3QGqXAGrXt8FWY/z4gCA5GIWqWRd1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6FdrW0O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6FdrW0O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9004AC4CEF5;
	Fri, 14 Nov 2025 01:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763083843;
	bh=a1cdXiNw2H1JE/HA6Rad4k0t2mwYcH0+AZQJU2v9Q+4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=a6FdrW0O3G2gTk2LmZmezLEusB3LRDO9X6ERx4+XQxYwruG/1CJ+Ghszf8FZdNAcG
	 WenInxKs7Mtfd+G7e1fFLFNV3GksMlZ7j0uU6RCd3oNMmvc5NmMZvTzTQJYGNTgvzS
	 8zMHYkq8tWw+gWZ25FMVE4/gqV2DYBdaagdoqRUJ5cvVzui23vlp6EQuPDr8EnCyvY
	 0lLWyRbb6OFDMMx1iK7QuLQq6B/Ra+ViZhegTw9a5pepT//JcNv2B1+XGe2wuuTV0D
	 LkSJ4smZqbE+REoQOhB+d5/ka5f92zu25pjh2hhbiX7EGwETxo6m4u6yyPgOfFkVIy
	 MBJ7O5Glyx1qg==
Message-ID: <41d4bf9e-708f-4a24-b9cc-f0adf30140c8@kernel.org>
Date: Fri, 14 Nov 2025 09:30:43 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v1 1/3] f2fs/015: clear MKFS_OPTIONS and MOUNT_OPTIONS
To: Joanne Chang <joannechien@google.com>, Zorro Lang <zlang@kernel.org>,
 fstests@vger.kernel.org
References: <20251112135223.3467852-1-joannechien@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251112135223.3467852-1-joannechien@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/12/2025 9:52 PM, Joanne Chang wrote:
> Currently, residual options can interfere with checking the mount
> behavior of the listed MKFS_OPTIONS and MOUNT_OPTIONS. For example,
> "Option#120: test_dummy_encryption" should fail with the listed
> options but succeeds if “MKFS_OPTIONS=encrypt” is preset. By
> explicitly clearing MKFS_OPTIONS and MOUNT_OPTIONS, the test’s
> reliability can be improved.
> 
> f2fs/015.out is also updated to expect failure for cases that require
> additional mkfs attributes to mount.
> 
> Signed-off-by: Joanne Chang <joannechien@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

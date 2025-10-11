Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8426819F40B
	for <fstests@vger.kernel.org>; Sat, 11 Oct 2025 07:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760166813; cv=none; b=WWjyTaIthmmQHbRsmoF6jbKop3ZUgsOU80AsomHASQgeer6f1GdoABuw01Mrp9/jiiiJjAFzC0Z3R+z1A5/F0iqwC/I18wx6UmqkUaoTZtxZOF7csc6eAeT7TKgpAj77ocCZfxfA5jqEhYTXMnh0omDthaeRZGnVgM3OY6jxdvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760166813; c=relaxed/simple;
	bh=Do43WpfLPmpga5YWE6MICXx9omQSNh8hFVG5f+zuSco=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QBbhPDy3G/uLTYzoIhYTTwgydghoWujDnTJgjSN2ZrqUH+CGQ1tdpHWm0TXSmPDKUre5V69gRIYCoXkRHr4re6CFysHlde4JGQXwAXWBiIy0LChIuW7boJz1f5X6g0ebHub/UjHVVDObVL1lsBSZWspOaFUS09dQBBwepZNBwuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUmcN5Ce; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUmcN5Ce"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0BB3C4CEF4;
	Sat, 11 Oct 2025 07:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760166813;
	bh=Do43WpfLPmpga5YWE6MICXx9omQSNh8hFVG5f+zuSco=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=BUmcN5Ce020K0s0jpIOHTwuIVD0qbBMBGI4Eu27haS+QqJ9Jg9sl9uA3WzS9cMHIF
	 MWKs5TUDdGrxpZeWnKK3MoLAob3+DzOW1LPSq/oTqawRptW1lPQHH/ZTDFdyUZhYun
	 u19itZeEY2IeVLet5I2HefLqKp+ahOJYlpRGGvR6vhvdtQHkoZ7VFdZYTi9yLyfSsG
	 2vVrcxvBPWMFppnuUMYtCLbPD7rIFY0qDzIJTmqnoR6VpBmpgtYE/0R69OW7Hp2NhT
	 WZ3fpel0hmVIgGUNusRofqqHLyUJIgAc8J0wVWC3MPYKFeLXcWTqjL6UuwB8DdrUGR
	 ElofHPU+OimNw==
Message-ID: <508e5cba-6523-41cb-af38-0e8dbbce6cbc@kernel.org>
Date: Sat, 11 Oct 2025 15:13:28 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v3] common/encrypt: Explicitly set the test file to
 uncompressed
To: Jan Prusakowski <jprusakowski@google.com>, Zorro Lang <zlang@kernel.org>,
 Eric Biggers <ebiggers@google.com>, fstests@vger.kernel.org
References: <20251006095813.3497619-1-jprusakowski@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251006095813.3497619-1-jprusakowski@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/6/25 17:58, Jan Prusakowski wrote:
> verify_ciphertext_for_encryption_policy() checks if encryption works
> correctly by reading encrypted file's contents directly from a block device and
> comparing it to a known good ciphertext.
> 
> This, however, won't work if the test file is also compressed. So this patch
> adds a check if a test file is compressed and disables its compression in this
> case.
> 
> Signed-off-by: Jan Prusakowski <jprusakowski@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

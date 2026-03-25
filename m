Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5E13563D4
	for <fstests@vger.kernel.org>; Wed, 25 Mar 2026 06:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774420213; cv=none; b=VmoGuPWpd3LTOdp5fG0b64RhTmMouadmd/sx2yYtGrDaDRdslaphFqZkMS+yFo9tewKzKZvFDqtteCBx1TCEFcl3hbD3dwdTOkPOZWcbaNl588dGFmv8YHzEL+oWSJF3FwW983AcEMGo7pyIHue1HjPoz9NguBWH9U1y809e4no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774420213; c=relaxed/simple;
	bh=GJkdHJL8jbzI0cvYfVjlcOX4u1soS5SlVk5upSvOhck=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pfZuWD2DeS8lwKwRb+hS4ZByuxhoCM5zUKDQmPlngLgGj+VTwYIM7nUHHue7TQbg1pCEQKlsuArD+pSF39G9kE1IdFV12QiCN55WLIrKvwEF3r6BI6PYm7hbT/Zb8w0dbgClNpcPtMQ3sMEOmurWNWGe+jWxod5OsH+KNf0Eya0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+e9jmL5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+e9jmL5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E803FC4CEF7;
	Wed, 25 Mar 2026 06:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774420213;
	bh=GJkdHJL8jbzI0cvYfVjlcOX4u1soS5SlVk5upSvOhck=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=N+e9jmL54g+k15rZtjbqbRiqeaeGSF3BAvReSeKWmVSVDiCjM835SEaAodWvVY81u
	 tQPSOq0k5+DsRnAdNR9oxdk2VZF6mXLoPMASvrlmVMDDxMrtKVh6g43NRUtQuPPRj6
	 vwYGjXJ9Mrt35YtS0fMleE+v1J9VyHzr93eDzczBJs+5kx9Y//iS8Hzp+KAFcjUVP5
	 jyyl8kTBcGQHvDONGspVpXJbGZF3cUjvc/xg6xK2IHxTyZFk4pI65TruorE1KYtoj8
	 jpCUxWnGLkyyKdznBOdfvBH/8tW2OiV1Fds5oy+yF5rOFt3yV9Kl2aac4NRxwk1GGa
	 vxWZpqYor0xTQ==
Message-ID: <db814739-7fae-40ad-87aa-53ed159dee31@kernel.org>
Date: Wed, 25 Mar 2026 14:30:09 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] common/rc: support f2fs in _require_fanotify_ioerrors()
To: Christoph Hellwig <hch@infradead.org>
References: <20260324025656.493776-1-chao@kernel.org>
 <acN4PWKHvk_33VB7@infradead.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <acN4PWKHvk_33VB7@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/25/26 13:53, Christoph Hellwig wrote:
> On Tue, Mar 24, 2026 at 10:56:55AM +0800, Chao Yu wrote:
>> This patch allows to run generic/791 on f2fs.
> 
> When was this introduced?  This doesn't currently exist in mainline,
> and it would probably help to run your fserror implementation past
> Darrick and fsdevel for review.

Oh, let me Cc Darrick and fsdevel for review.

Thanks,


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F4D2D372D
	for <fstests@vger.kernel.org>; Fri, 23 Jan 2026 04:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769141327; cv=none; b=Kt9vEp08fIExHvSSlrPq/bdn/iOJq88au6c1GRHs/SonhhsHjrL3EXStyQ+ju21vDe36t8yCnd712dR3+mWfNin94gVF0NAVuH/dq+BN3xdgwtklYtgwSXUS65u5XynTXwhWfMw8EyPOTq/IQeIjVlAz9tWeHBrxgUwDkaOXoTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769141327; c=relaxed/simple;
	bh=wlGCSZXy6T9m5mbui6m5dviyE7AZ/Vj5vC2XwFQTI2Y=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Hd/jIzLarP63/xsu+N7R2vybcaaLUMu9bH9/NcelTmgYz9aSnjxOG0PIZTJIMLd28n/XA4V4mRNZN1fmvG1wR/J5hdghGhij/itMDvW1nLF8eJYJlh5frQ45MnM1bel4TOhP+XlrmTNLimUXR4d5wA4/hnGSfrbcHqaUd/PGr/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DETJvzmB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DETJvzmB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA73C4CEF1;
	Fri, 23 Jan 2026 04:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769141326;
	bh=wlGCSZXy6T9m5mbui6m5dviyE7AZ/Vj5vC2XwFQTI2Y=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=DETJvzmBRUeGOuScx3ZkzOt2aBqFDDWHrHU5MZpdrP3HqFXAlBT/O1SP9Z5Xmug+q
	 oniJ+S3fFVn6o5nhSqKcUFaZf7MeTIqvwefIKEBTFPwg7fQE82tukmUQR++DSaxBga
	 nGcUxn91+fas6Tog3dqt/g4wZaNmObsR44C6+weJ7RGUc+5Dmp23V7ukViI3sRmgPt
	 WU5ovZrPJ+xEkskmIUCD6aR901iv57WIPP0kIJszBfdzRUs7FzDlJV+4tdvm0V2SDK
	 N+IAKZGpBvQDSoudHn9jIShmg9Au1hhPIgkuCUQ6cbdrn4T0MIfYTNi5KpMK2OmXaH
	 MqTY9n+F036BQ==
Message-ID: <4964e3f1-019e-43d4-bbd9-a6ba3ba48cda@kernel.org>
Date: Fri, 23 Jan 2026 12:08:45 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v1] f2fs/015: Test correct mkfs options for error cases
To: Joanne Chang <joannechien@google.com>, Zorro Lang <zlang@kernel.org>,
 fstests@vger.kernel.org
References: <20260123032744.1018230-1-joannechien@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260123032744.1018230-1-joannechien@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/23/2026 11:27 AM, Joanne Chang wrote:
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> Let's add the required mkfs options for quota mount option cases with
> wrong results.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> Co-developed-by: Joanne Chang <joannechien@google.com>
> Signed-off-by: Joanne Chang <joannechien@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
